local u2 = require("../Constants")
local u5 = require("../../RemotePacketSizeCounter")
local u8 = require("./ServerProcess")
local u11 = require("../../TableKit")
require("../Types")
local u17 = require("../Utilities/Output")
local u20 = require("./PlayerContainers")
local u23 = require("./ServerConnection")
local u26 = require("./ServerIdentifiers")
local Players = game:GetService("Players")

local function toStringData(p1) -- Line: 17 -- upvalues: u11 (val)
    if typeof(p1) == "table" then
        if u11.IsArray(p1) then
            return u11.ToArrayString(p1)
        end
        return u11.ToString(p1)
    end
    local v1 = ""
    local v2 = ""
    if typeof(p1) == "CFrame" then
        v1 = "CFrame("
        v2 = ")"
    elseif typeof(p1) == "Vector3" then
        v1 = "Vector3("
        v2 = ")"
    end
    local v3 = tostring(p1)
    return (("%*%*%*"):format(v1, v3, v2))
end

local v1 = {}
local u34 = {}
u34.__index = v1

function u34.__tostring(p1) -- Line: 42
    return "ServerBridge"
end

function v1.InboundMiddleware(p1, p2) -- Line: 46 -- upvalues: u17 (val)
    local fatalAssert = u17.fatalAssert
    local v1 = tostring(p1) == "ServerBridge"
    fatalAssert(v1, "InboundMiddleware called with . instead of :")
    p1._inboundMiddleware = p2
end

function v1.OutboundMiddleware(p1, p2) -- Line: 51 -- upvalues: u17 (val)
    local fatalAssert = u17.fatalAssert
    local v1 = tostring(p1) == "ServerBridge"
    fatalAssert(v1, "OutboundMiddleware called with . instead of :")
    p1._outboundMiddleware = p2
end

function v1:Connect(p2) -- Line: 58 -- upvalues: u17 (val), u23 (val), u26 (val), u2 (val), toStringData (val), u5 (val)
    local fatalAssert = u17.fatalAssert
    local v1 = tostring(self) == "ServerBridge"
    fatalAssert(v1, "Connect called with . instead of :")
    u17.typecheck("function", "Connect", "callback", p2)
    local v2 = u23
    return v2(self._identifier, function(p1, p2_2) -- Line: 62
        -- upvalues: u26 (upval), self (val), u17 (upval), u2 (upval), toStringData (upval), u5 (upval), p2 (val)
        local v1, v2, v3, v4
        if typeof(p2_2) == "table" and p2_2[1] == u26.ref("REQUEST") then
            return
        end
        if self.RateLimitActive then
            if self._rateMap[p1] == nil then
                self._rateMap[p1] = 1
            else
                v1 = self._rateMap[p1]
                self._rateMap[p1] = v1 + 1
            end
            task.delay(1, function() -- Line: 76 -- upvalues: self (upval), p1 (val)
                local v1 = self._rateMap[p1]
                local v2 = self
                local _rateMap = v2._rateMap
                local v3 = p1
                local v4 = v1 - 1
                _rateMap[v3] = (math.min(0, v4))
            end)
            v1 = self._rateMap[p1]
            if self._maxRate <= v1 and not self._overflowFunction(p1) then
                return
            end
        end
        if self._inboundMiddleware == nil then
            if self.Logging then
                local format_2 = string.format
                v2 = u2
                local SERVER_CONNECT_LOG_2 = v2.SERVER_CONNECT_LOG
                v3 = self
                v1 = format_2(SERVER_CONNECT_LOG_2, v3._name, p1.Name, toStringData(p2_2), u5.GetDataByteSize(p2_2))
                u17.log(v1)
            end
            p2(p1, p2_2)
            return
        end
        v1 = p2_2
        local _inboundMiddleware = self._inboundMiddleware
        v3 = nil
        local v5 = nil
        for i, j in _inboundMiddleware, v3, v5 do
            v4 = j(p1, v1)
            if typeof(v4) == "table" then
                v1 = v4
            else
                u17.silent(string.format(
                    "Inbound middleware on bridge %* did not return a table; ignoring the return.",
                    self._name
                ))
            end
        end
        if self.Logging and self.Logging then
            local format = string.format
            v3 = u2
            local SERVER_CONNECT_LOG = v3.SERVER_CONNECT_LOG
            v5 = self
            v2 = format(SERVER_CONNECT_LOG, v5._name, p1.Name, toStringData(p2_2), u5.GetDataByteSize(p2_2))
            u17.log(v2)
        end
        p2(p1, v1)
    end)
end

function v1.RateLimit(p1, p2, p3) -- Line: 137 -- upvalues: u17 (val)
    local fatalAssert = u17.fatalAssert
    local v1 = tostring(p1) == "ServerBridge"
    fatalAssert(v1, "RateLimit called with . instead of :")
    p1.RateLimitActive = true
    p1._overflowFunction = p3
    p1._maxRate = p2
end

function v1.DisableRateLimit(p1) -- Line: 144 -- upvalues: u17 (val)
    local fatalAssert = u17.fatalAssert
    local v1 = tostring(p1) == "ServerBridge"
    fatalAssert(v1, "DisableRateLimit called with . instead of :")
    p1.RateLimitActive = false
end

function v1.Wait(p1) -- Line: 149 -- upvalues: u17 (val)
    local fatalAssert = u17.fatalAssert
    local v1 = tostring(p1) == "ServerBridge"
    fatalAssert(v1, "Wait called with . instead of :")
    local u13 = coroutine.running()
    p1:Connect(function(p1, p2) -- Line: 152 -- upvalues: u13 (val)
        coroutine.resume(u13, p1, p2)
    end)
    return coroutine.yield()
end

function v1.Once(p1, p2) -- Line: 158 -- upvalues: u17 (val)
    local fatalAssert = u17.fatalAssert
    local v1 = tostring(p1) == "ServerBridge"
    fatalAssert(v1, "Once called with . instead of :")
    u17.typecheck("function", "Once", "callback", p2)
    local u21 = nil
    u21 = (p1:Connect(function(p1, p2_2) -- Line: 163 -- upvalues: u21 (ref), p2 (val)
        u21:Disconnect()
        p2(p1, p2_2)
    end))
    return u21
end

function v1.FireAllInRangeExcept(p1, p2, p3, p4, p5) -- Line: 170 -- upvalues: Players (val), u20 (val)
    local v1 = {}
    local v2 = {}
    for i, v in ipairs(p5) do
        v2[v] = true
    end
    for i2, j in Players:GetPlayers() do
        if j:DistanceFromCharacter(p2) <= p3 and not v2[j] then
            table.insert(v1, j)
        end
    end
    local v3 = u20.Players(v1)
    p1:Fire(v3, p4)
    return v1
end

function v1.FireAllInRange(p1, p2, p3, p4) -- Line: 190 -- upvalues: Players (val), u20 (val)
    local v1 = {}
    for i, j in Players:GetPlayers() do
        if j:DistanceFromCharacter(p2) <= p3 then
            table.insert(v1, j)
        end
    end
    local v2 = u20.Players(v1)
    p1:Fire(v2, p4)
    return v1
end

function v1:Fire(p2, p3) -- Line: 203
    -- upvalues: u17 (val), u20 (val), u2 (val), u11 (val), toStringData (val), u5 (val), u8 (val)
    local v1
    local fatalAssert = u17.fatalAssert
    local v2 = tostring(self) == "ServerBridge"
    fatalAssert(v2, "Fire called with . instead of :")
    local v3 = nil
    if typeof(p2) ~= "Instance" then
        if typeof(p2) == "nil" then
            u17.fatal("target parameter passed into ServerBridge:Fire() is nil")
        end
        u17.typecheck("table", "Fire", "target", p2)
        v3 = p2
    elseif not p2:IsA("Player") then
        u17.fatal("non-player instance passed into :Fire()")
    else
        v3 = u20.Single(p2)
    end
    if self._outboundMiddleware == nil then
        if self.Logging and self.Logging then
            local Name_2
            local format_2 = string.format
            local SERVER_FIRE_LOG_2 = u2.SERVER_FIRE_LOG
            local _name_2 = self._name
            if v3.kind == "all" then
                Name_2 = "{all}"
            elseif v3.kind ~= "single" then
                Name_2 = u11.ToArrayString(v3.value)
            else
                Name_2 = v3.value.Name
            end
            v2 = format_2(SERVER_FIRE_LOG_2, _name_2, Name_2, toStringData(p3), u5.GetDataByteSize(p3))
            u17.log(v2)
        end
        u8.addToQueue(v3, self._identifier, p3)
        return
    end
    v2 = p3
    local _outboundMiddleware = self._outboundMiddleware
    local v4 = nil
    local v5 = nil
    for i, j in _outboundMiddleware, v4, v5 do
        v1 = j(v2)
        if typeof(v1) == "table" then
            v2 = v1
        else
            u17.silent(string.format("Outbound middleware on bridge %* did not return a table; ignoring the return.", self._name))
        end
    end
    if self.Logging then
        local Name
        local format = string.format
        local SERVER_FIRE_LOG = u2.SERVER_FIRE_LOG
        local _name = self._name
        if v3.kind == "all" then
            Name = "{all}"
        elseif v3.kind ~= "single" then
            Name = u11.ToArrayString(v3.value)
        else
            Name = v3.value.Name
        end
        local v6 = format(SERVER_FIRE_LOG, _name, Name, toStringData(v2), u5.GetDataByteSize(v2))
        u17.log(v6)
    end
    u8.addToQueue(v3, self._identifier, v2)
end

return function(p1) -- Line: 276 -- upvalues: u26 (val), u34 (val), u8 (val)
    local v1 = {
        Logging = false,
        RateLimitActive = false,
        _maxRate = 500,
        _identifier = u26.ref(p1),
        _name = p1,
        OnServerInvoke = function() end,
        _rateMap = {},
        _overflowFunction = function() -- Line: 294
            return false
        end,
    }
    local v2 = u34
    local u11 = setmetatable(v1, v2)
    u8.registerBridge(u11._identifier)
    v1 = u8
    v1.connect(u11._identifier, function(p1, p2) -- Line: 301 -- upvalues: u11 (val), u26 (upval)
        if typeof(p2) ~= "table" then
            return
        end
        if u11.OnServerInvoke ~= nil and p2[1] == u26.ref("REQUEST") then
            local v1 = p2[2]
            local v2 = u11.OnServerInvoke(p1, p2[3])
            local v3 = u11
            local v4 = {u26.ref("REQUEST"), v1, v2}
            v3:Fire(p1, v4)
        end
    end)
    return u11
end