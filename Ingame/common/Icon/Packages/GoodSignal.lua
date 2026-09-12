local u0 = nil

local function acquireRunnerThreadAndCallEventHandler(p1, ...) -- Line: 34 -- upvalues: u0 (ref)
    local v1 = u0
    u0 = nil
    p1(...)
    u0 = v1
end

local function runEventHandlerInFreeThread() -- Line: 45 -- upvalues: acquireRunnerThreadAndCallEventHandler (val)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local u3 = {}
u3.__index = u3

function u3.new(p1, p2) -- Line: 60 -- upvalues: u3 (val)
    local v1 = {_connected = true, _next = false, _signal = p1, _fn = p2}
    local v2 = u3
    return (setmetatable(v1, v2))
end

function u3:Disconnect() -- Line: 69
    self._connected = false
    if self._signal._handlerListHead == self then
        self._signal._handlerListHead = self._next
        return
    end
    local _handlerListHead = self._signal._handlerListHead
    while _handlerListHead do
        if _handlerListHead._next == self then
            break
        end
        _handlerListHead = _handlerListHead._next
    end
    if _handlerListHead then
        _handlerListHead._next = self._next
    end
end

u3.Destroy = u3.Disconnect
local v1 = {
    __index = function(p1, p2) -- Line: 92
        local v1 = error
        local v2 = tostring(p2)
        v1(("Attempt to get Connection::%s (not a valid member)"):format(v2), 2)
    end,
    __newindex = function(p1, p2, p3) -- Line: 95
        local v1 = error
        local v2 = tostring(p2)
        v1(("Attempt to set Connection::%s (not a valid member)"):format(v2), 2)
    end,
}
setmetatable(u3, v1)
local u13 = {}
u13.__index = u13

function u13.new() -- Line: 104 -- upvalues: u13 (val)
    local v1 = u13
    return (setmetatable({_handlerListHead = false}, v1))
end

function u13:Connect(p2) -- Line: 110 -- upvalues: u3 (val)
    local v1 = u3.new(self, p2)
    if not self._handlerListHead then
        self._handlerListHead = v1
        return v1
    end
    v1._next = self._handlerListHead
    self._handlerListHead = v1
    return v1
end

function u13.DisconnectAll(p1) -- Line: 123
    p1._handlerListHead = false
end

u13.Destroy = u13.DisconnectAll

function u13.Fire(p1, ...) -- Line: 132 -- upvalues: u0 (ref), runEventHandlerInFreeThread (val)
    local _handlerListHead = p1._handlerListHead
    while _handlerListHead do
        if _handlerListHead._connected then
            if not u0 then
                u0 = coroutine.create(runEventHandlerInFreeThread)
                coroutine.resume(u0)
            end
            task.spawn(u0, _handlerListHead._fn, ...)
        end
        _handlerListHead = _handlerListHead._next
    end
end

function u13.Wait(p1) -- Line: 149
    local u2 = coroutine.running()
    local u3 = nil
    local v1 = p1:Connect(function(...) -- Line: 152 -- upvalues: u3 (ref), u2 (val)
        u3:Disconnect()
        task.spawn(u2, ...)
    end)
    v1 = coroutine.yield()
    return v1
end

function u13.Once(p1, p2) -- Line: 161
    local u2 = nil
    u2 = (p1:Connect(function(...) -- Line: 163 -- upvalues: u2 (ref), p2 (val)
        if u2._connected then
            u2:Disconnect()
        end
        p2(...)
    end))
    return u2
end

local v2 = {
    __index = function(p1, p2) -- Line: 174
        local v1 = error
        local v2 = tostring(p2)
        v1(("Attempt to get Signal::%s (not a valid member)"):format(v2), 2)
    end,
    __newindex = function(p1, p2, p3) -- Line: 177
        local v1 = error
        local v2 = tostring(p2)
        v1(("Attempt to set Signal::%s (not a valid member)"):format(v2), 2)
    end,
}
setmetatable(u13, v2)
return u13