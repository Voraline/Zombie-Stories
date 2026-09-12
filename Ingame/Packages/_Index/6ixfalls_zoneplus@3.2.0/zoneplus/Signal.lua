local u0 = nil

local function acquireRunnerThreadAndCallEventHandler(p1, ...) -- Line: 34 -- upvalues: u0 (ref)
    local v1 = u0
    u0 = nil
    p1(...)
    u0 = v1
end

local function runEventHandlerInFreeThread(...) -- Line: 45 -- upvalues: acquireRunnerThreadAndCallEventHandler (val)
    acquireRunnerThreadAndCallEventHandler(...)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local u3 = {}
u3.__index = u3

function u3.new(p1, p2) -- Line: 56 -- upvalues: u3 (val)
    local v1 = {_connected = true, _next = false, _signal = p1, _fn = p2}
    local v2 = u3
    return (setmetatable(v1, v2))
end

function u3:Disconnect() -- Line: 65
    local _connected = self._connected
    assert(_connected, "Can't disconnect a connection twice.", 2)
    self._connected = false
    local _signal = self._signal
    if _signal._handlerListHead ~= self then
        local _handlerListHead = _signal._handlerListHead
        while _handlerListHead do
            if _handlerListHead._next == self then
                break
            end
            _handlerListHead = _handlerListHead._next
        end
        if _handlerListHead then
            _handlerListHead._next = self._next
        end
    else
        _signal._handlerListHead = self._next
    end
    if _signal.connectionsChanged then
        _signal.totalConnections = _signal.totalConnections - 1
        _signal.connectionsChanged:Fire(-1)
    end
end

local v1 = {
    __index = function(p1, p2) -- Line: 94
        local v1 = error
        local v2 = tostring(p2)
        v1(("Attempt to get Connection::%s (not a valid member)"):format(v2), 2)
    end,
    __newindex = function(p1, p2, p3) -- Line: 97
        local v1 = error
        local v2 = tostring(p2)
        v1(("Attempt to set Connection::%s (not a valid member)"):format(v2), 2)
    end,
}
setmetatable(u3, v1)
local u12 = {}
u12.__index = u12

function u12.new(p1) -- Line: 106 -- upvalues: u12 (val)
    local v1 = u12
    local v2 = setmetatable({_handlerListHead = false}, v1)
    if p1 then
        v2.totalConnections = 0
        v2.connectionsChanged = u12.new()
    end
    return v2
end

function u12:Connect(p2) -- Line: 117 -- upvalues: u3 (val)
    local v1 = u3.new(self, p2)
    if not self._handlerListHead then
        self._handlerListHead = v1
    else
        v1._next = self._handlerListHead
        self._handlerListHead = v1
    end
    if self.connectionsChanged then
        self.totalConnections = self.totalConnections + 1
        self.connectionsChanged:Fire(1)
    end
    return v1
end

function u12.DisconnectAll(p1) -- Line: 135
    p1._handlerListHead = false
    if p1.connectionsChanged then
        local connectionsChanged = p1.connectionsChanged
        local v1 = -p1.totalConnections
        connectionsChanged:Fire(v1)
        p1.connectionsChanged:Destroy()
        p1.connectionsChanged = nil
        p1.totalConnections = 0
    end
end

u12.Destroy = u12.DisconnectAll
u12.destroy = u12.DisconnectAll

function u12:Fire(...) -- Line: 152 -- upvalues: u0 (ref), runEventHandlerInFreeThread (val)
    local _handlerListHead = self._handlerListHead
    while _handlerListHead do
        if _handlerListHead._connected then
            if not u0 then
                u0 = coroutine.create(runEventHandlerInFreeThread)
            end
            task.spawn(u0, _handlerListHead._fn, ...)
        end
        _handlerListHead = _handlerListHead._next
    end
end

function u12.Wait(p1) -- Line: 167
    local u2 = coroutine.running()
    local u3 = nil
    local v1 = p1:Connect(function(...) -- Line: 170 -- upvalues: u3 (ref), u2 (val)
        u3:Disconnect()
        task.spawn(u2, ...)
    end)
    v1 = coroutine.yield()
    return v1
end

return u12