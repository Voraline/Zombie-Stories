local u0 = nil
local function acquireRunnerThreadAndCallEventHandler(p1, ...) -- Line: 34 -- upvalues: u0 (ref)
    u0 = nil
    p1(...)
    u0 = u0
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
    return (setmetatable(v1, u3))
end
function u3:Disconnect() -- Line: 65
    local _handlerListHead
    assert(self._connected, "Can't disconnect a connection twice.", 2)
    self._connected = false
    local _signal = self._signal
    if _signal._handlerListHead ~= self then
        _handlerListHead = _signal._handlerListHead
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
setmetatable(u3, {
    __index = function(p1, p2) -- Line: 94
        local v1 = ("Attempt to get Connection::%s (not a valid member)"):format((tostring(p2)))
        error(v1, 2)
    end,
    __newindex = function(p1, p2, p3) -- Line: 97
        local v1 = ("Attempt to set Connection::%s (not a valid member)"):format((tostring(p2)))
        error(v1, 2)
    end,
})
local u12 = {}
u12.__index = u12
function u12.new(p1) -- Line: 106 -- upvalues: u12 (val)
    local v1 = setmetatable({_handlerListHead = false}, u12)
    if p1 then
        v1.totalConnections = 0
        v1.connectionsChanged = u12.new()
    end
    return v1
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
        p1.connectionsChanged:Fire(-p1.totalConnections)
        p1.connectionsChanged:Destroy()
        p1.connectionsChanged = nil
        p1.totalConnections = 0
    end
end
u12.Destroy = u12.DisconnectAll
u12.destroy = u12.DisconnectAll
function u12:Fire(, ...) -- Line: 152 -- upvalues: u0 (ref), runEventHandlerInFreeThread (val)
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
    return coroutine.yield()
end
return u12