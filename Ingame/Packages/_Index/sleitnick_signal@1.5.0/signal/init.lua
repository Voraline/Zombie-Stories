local u0 = nil
local function acquireRunnerThreadAndCallEventHandler(p1, ...) -- Line: 53 -- upvalues: u0 (ref)
    u0 = nil
    p1(...)
    u0 = u0
end
local function runEventHandlerInFreeThread(...) -- Line: 64 -- upvalues: acquireRunnerThreadAndCallEventHandler (val)
    acquireRunnerThreadAndCallEventHandler(...)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end
local u3 = {}
u3.__index = u3
function u3.new(p1, p2) -- Line: 90 -- upvalues: u3 (val)
    local v1 = {Connected = true, _next = false, _signal = p1, _fn = p2}
    return (setmetatable(v1, u3))
end
function u3:Disconnect() -- Line: 99
    local _handlerListHead
    if not self.Connected then
        return
    end
    self.Connected = false
    if self._signal._handlerListHead == self then
        self._signal._handlerListHead = self._next
        return
    end
    _handlerListHead = self._signal._handlerListHead
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
setmetatable(u3, {
    __index = function(p1, p2) -- Line: 126
        local v1 = ("Attempt to get Connection::%s (not a valid member)"):format((tostring(p2)))
        error(v1, 2)
    end,
    __newindex = function(p1, p2, p3) -- Line: 129
        local v1 = ("Attempt to set Connection::%s (not a valid member)"):format((tostring(p2)))
        error(v1, 2)
    end,
})
local u13 = {}
u13.__index = u13
function u13.new() -- Line: 165 -- upvalues: u13 (val)
    local v1 = {_handlerListHead = false}
    return (setmetatable(v1, u13))
end
function u13.Wrap(p1) -- Line: 186 -- upvalues: u13 (val)
    local v1 = typeof(p1) == "RBXScriptSignal"
    assert(v1, "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p1))
    local u17 = u13.new()
    u17._proxyHandler = p1:Connect(function(...) -- Line: 192 -- upvalues: u17 (val)
        u17:Fire(...)
    end)
    return u17
end
function u13.Is(p1) -- Line: 204 -- upvalues: u13 (val)
    local v1 = false
    if type(p1) == "table" then
        local v2 = getmetatable(p1)
        v1 = v2 == u13
    end
    return v1
end
function u13:Connect(p2) -- Line: 221 -- upvalues: u3 (val)
    local v1 = u3.new(self, p2)
    if not self._handlerListHead then
        self._handlerListHead = v1
        return v1
    end
    v1._next = self._handlerListHead
    self._handlerListHead = v1
    return v1
end
function u13.ConnectOnce(p1, p2) -- Line: 237
    return p1:Once(p2)
end
function u13:Once(p2) -- Line: 256
    local u2 = nil
    local u3 = false
    u2 = self:Connect(function(...) -- Line: 259 -- upvalues: u3 (ref), u2 (ref), p2 (val)
        if u3 then
            return
        end
        u3 = true
        u2:Disconnect()
        p2(...)
    end)
    return u2
end
function u13.GetConnections(p1) -- Line: 270
    local v1 = {}
    local _handlerListHead = p1._handlerListHead
    while _handlerListHead do
        table.insert(v1, _handlerListHead)
        _handlerListHead = _handlerListHead._next
    end
    return v1
end
function u13:DisconnectAll() -- Line: 288
    local _handlerListHead = self._handlerListHead
    while _handlerListHead do
        _handlerListHead.Connected = false
        _handlerListHead = _handlerListHead._next
    end
    self._handlerListHead = false
end
function u13:Fire(, ...) -- Line: 312 -- upvalues: u0 (ref), runEventHandlerInFreeThread (val)
    local _handlerListHead = self._handlerListHead
    while _handlerListHead do
        if _handlerListHead.Connected then
            if not u0 then
                u0 = coroutine.create(runEventHandlerInFreeThread)
            end
            task.spawn(u0, _handlerListHead._fn, ...)
        end
        _handlerListHead = _handlerListHead._next
    end
end
function u13.FireDeferred(p1, ...) -- Line: 333
    local _handlerListHead = p1._handlerListHead
    while _handlerListHead do
        task.defer(_handlerListHead._fn, ...)
        _handlerListHead = _handlerListHead._next
    end
end
function u13.Wait(p1) -- Line: 356
    local u2 = coroutine.running()
    local u3 = nil
    local u4 = false
    return coroutine.yield()
end
function u13.Destroy(p1) -- Line: 383
    p1:DisconnectAll()
    local v1 = rawget(p1, "_proxyHandler")
    if v1 then
        v1:Disconnect()
    end
end
setmetatable(u13, {
    __index = function(p1, p2) -- Line: 393
        local v1 = ("Attempt to get Signal::%s (not a valid member)"):format((tostring(p2)))
        error(v1, 2)
    end,
    __newindex = function(p1, p2, p3) -- Line: 396
        local v1 = ("Attempt to set Signal::%s (not a valid member)"):format((tostring(p2)))
        error(v1, 2)
    end,
})
return {new = u13.new, Wrap = u13.Wrap, Is = u13.Is}