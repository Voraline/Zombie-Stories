local u2 = require("./ClientConnection")
local u5 = require("./ClientIdentifiers")
local u8 = require("./ClientProcess")
local u11 = require("../Constants")
local u14 = require("../Utilities/Output")
local u17 = require("../../TableKit")
local u20 = require("../../RemotePacketSizeCounter")
require("../Types")
local u26 = require("../../../Promise")
local u27 = 0
local function toStringData(p1) -- Line: 14 -- upvalues: u17 (val)
    if typeof(p1) == "table" then
        return u17.ToString(p1)
    end
    return (tostring(p1))
end
local v1 = {}
local u30 = {
    __index = v1,
    __tostring = function(p1) -- Line: 26
        return "ClientBridge"
    end,
}
function v1.RateLimit(p1) -- Line: 30 -- upvalues: u14 (val)
    u14.warn("cannot call :RateLimit() from client")
end
function v1.DisableRateLimit(p1) -- Line: 34 -- upvalues: u14 (val)
    u14.warn("cannot call :DisableRateLimit() from client")
end
function v1.InboundMiddleware(p1, p2) -- Line: 38 -- upvalues: u14 (val), u17 (val)
    local v1 = tostring(p1) == "ClientBridge"
    u14.fatalAssert(v1, "InboundMiddleware called with . instead of :")
    v1 = typeof(p2) == "table"
    u14.fatalAssert(v1, string.format("InboundMiddleware takes table, got %*", (typeof(p2))))
    v1 = u17.IsArray(p2)
    u14.warnAssert(v1, "InboundMiddleware takes array, got dictionary.")
    p1._inboundMiddleware = p2
end
function v1.OutboundMiddleware(p1, p2) -- Line: 49 -- upvalues: u14 (val), u17 (val)
    local v1 = tostring(p1) == "ClientBridge"
    u14.fatalAssert(v1, "OutboundMiddleware called with . instead of :")
    v1 = typeof(p2) == "table"
    u14.fatalAssert(v1, string.format("OutboundMiddleware takes table, got %*", (typeof(p2))))
    v1 = u17.IsArray(p2)
    u14.warnAssert(v1, "InboundMiddleware takes array, got dictionary.")
    p1._outboundMiddleware = p2
end
function v1:Fire(p2) -- Line: 60 -- upvalues: u14 (val), u11 (val), u17 (val), u20 (val), u8 (val)
    local _outboundMiddleware, v1, v2, v3
    local v4 = tostring(self) == "ClientBridge"
    u14.fatalAssert(v4, "Fire called with . instead of :")
    if self._outboundMiddleware == nil then
        if self.Logging then
            if typeof(p2) ~= "table" then
                v2 = tostring(p2)
            else
                v2 = u17.ToString(p2)
            end
            v1 = string.format(u11.CLIENT_FIRE_LOG, self._name, v2, u20.GetDataByteSize(p2))
            u14.log(v1)
        end
        u8.addToQueue(self._identifier, p2)
        return
    end
    v1 = p2
    _outboundMiddleware = self._outboundMiddleware
    local v5 = nil
    v2 = nil
    for i, j in _outboundMiddleware, v5, v2 do
        v3 = j(v1)
        if typeof(v3) == "table" then
            v1 = v3
        else
            u14.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", self._name))
        end
    end
    if self.Logging then
        local v6
        local v7 = v1
        if typeof(v7) ~= "table" then
            v6 = tostring(v7)
        else
            v6 = u17.ToString(v7)
        end
        v4 = string.format(u11.CLIENT_FIRE_LOG, self._name, v6, u20.GetDataByteSize(v1))
        u14.log(v4)
    end
    u8.addToQueue(self._identifier, v1)
end
function v1:Connect(p2) -- Line: 107 -- upvalues: u14 (val), u2 (val), u5 (val), u11 (val), u17 (val), u20 (val)
    local v1 = tostring(self) == "ClientBridge"
    u14.fatalAssert(v1, "connect called with . instead of :")
    u14.typecheck("function", "Connect", "callback", p2)
    return u2(self._identifier, function(p1) -- Line: 111 -- upvalues: u5 (upval), self (val), u14 (upval), u11 (upval), u17 (upval), u20 (upval), p2 (val)
        if typeof(p1) ~= "table" then
            local _inboundMiddleware, v1, v2, v3
            if self._inboundMiddleware == nil then
                if self.Logging then
                    if typeof(p1) ~= "table" then
                        v2 = tostring(p1)
                    else
                        v2 = u17.ToString(p1)
                    end
                    v1 = string.format(u11.CLIENT_CONNECT_LOG, self._name, v2, u20.GetDataByteSize(p1))
                    u14.log(v1)
                end
                p2(p1)
                return
            end
            v1 = p1
            _inboundMiddleware = self._inboundMiddleware
            local v4 = nil
            v2 = nil
            for i, j in _inboundMiddleware, v4, v2 do
                v3 = j(v1)
                if typeof(v3) == "table" then
                    v1 = v3
                else
                    u14.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", self._name))
                end
            end
            if self.Logging then
                local v5
                local v6 = v1
                if typeof(v6) ~= "table" then
                    v5 = tostring(v6)
                else
                    v5 = u17.ToString(v6)
                end
                local v7 = string.format(u11.CLIENT_CONNECT_LOG, self._name, v5, u20.GetDataByteSize(v1))
                u14.log(v7)
            end
            p2(v1)
            return
        elseif p1[1] == u5.ref("REQUEST") then
            return
        end
    end)
end
function v1.Wait(p1) -- Line: 163 -- upvalues: u14 (val)
    local v1 = tostring(p1) == "ClientBridge"
    u14.fatalAssert(v1, "Wait called with . instead of :")
    local u13 = coroutine.running()
    p1:Once(function(p1) -- Line: 167 -- upvalues: u13 (val)
        coroutine.resume(u13, p1)
    end)
    return coroutine.yield()
end
function v1.Invoke(p1, p2) -- Line: 173 -- upvalues: u26 (val)
    return (u26.new(function(a1, a2) -- Line: 174 -- upvalues: p1 (val), p2 (val)
    local v1, v2
    v1 = p1:InvokeServerAsync(p2)
    a1(v1)
    return
end))
end
function v1:InvokeServerAsync(p2) -- Line: 190 -- upvalues: u14 (val), u27 (ref), u5 (val), u8 (val)
    local v1 = tostring(self) == "ClientBridge"
    u14.fatalAssert(v1, "InvokeServerAsync called with . instead of :")
    local u13 = u27
    u27 = u27 + 1
    local v2 = {}
    local REQUEST = u5.ref("REQUEST")
    v2[1] = REQUEST
    v2[2] = u13
    v2[3] = p2
    self:Fire(v2)
    local u29 = coroutine.running()
    local u30 = nil
    return coroutine.yield()
end
function v1:Once(p2) -- Line: 209 -- upvalues: u14 (val)
    local v1 = tostring(self) == "ClientBridge"
    u14.fatalAssert(v1, "Once called with . instead of :")
    local u13 = nil
    u13 = self:Connect(function(p1) -- Line: 213 -- upvalues: u13 (ref), p2 (val)
        u13:Disconnect()
        p2(p1)
    end)
    return u13
end
function v1.Destroy(p1) -- Line: 221 -- upvalues: u14 (val)
    local v1 = tostring(p1) == "ClientBridge"
    u14.fatalAssert(v1, "Destroy called with . instead of :")
    table.clear(p1)
    setmetatable(p1, nil)
end
return function(p1) -- Line: 228 -- upvalues: u5 (val), u30 (val), u8 (val)
    local v1 = setmetatable({
        Logging = false,
        _identifier = u5.ref(p1),
        _name = p1,
        _inboundMiddleware = {},
        _outboundMiddleware = {},
    }, u30)
    u8.registerBridge(v1._identifier)
    return v1
end