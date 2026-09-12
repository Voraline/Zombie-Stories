local RunService = game:GetService("RunService")
local u5 = {}
u5.__index = u5
u5.ClassName = "MasterClock"

function u5.new(p1, p2) -- Line: 14 -- upvalues: u5 (val)
    local v1 = u5
    local u5_2 = setmetatable({}, v1)
    local v2 = p1
    if not v2 then
        v2 = error("No remoteEvent")
    end
    u5_2._remoteEvent = v2
    v2 = p2
    if not v2 then
        v2 = error("No remoteFunction")
    end
    u5_2._remoteFunction = v2
    local _remoteFunction = u5_2._remoteFunction

    function _remoteFunction.OnServerInvoke(p1, p2) -- Line: 20 -- upvalues: u5_2 (val)
        return u5_2:_handleDelayRequest(p2)
    end

    u5_2._remoteEvent.OnServerEvent:Connect(function(p1) -- Line: 23 -- upvalues: u5_2 (val)
        local v1 = u5_2
        local _remoteEvent = v1._remoteEvent
        local Time = u5_2:GetTime()
        _remoteEvent:FireClient(p1, Time)
    end)
    task.defer(function() -- Line: 27 -- upvalues: u5_2 (val)
        while true do
            task.wait(3.5)
            u5_2:Sync()
        end
    end)
    return u5_2
end

function u5.IsSynced(p1) -- Line: 39
    return true
end

function u5.GetTime(p1) -- Line: 45
    return tick()
end

function u5:Sync() -- Line: 50
    local Time = self:GetTime()
    self._remoteEvent:FireAllClients(Time)
end

function u5:_handleDelayRequest(p2) -- Line: 58
    return self:GetTime() - p2
end

local u12 = {}
u12.__index = u12
u12.ClassName = "SlaveClock"
u12._offset = -1

function u12.new(p1, p2) -- Line: 69 -- upvalues: u12 (val)
    local v1 = u12
    local u5 = setmetatable({}, v1)
    local v2 = p1
    if not v2 then
        v2 = error("No remoteEvent")
    end
    u5._remoteEvent = v2
    v2 = p2
    if not v2 then
        v2 = error("No remoteFunction")
    end
    u5._remoteFunction = v2
    u5._remoteEvent.OnClientEvent:Connect(function(p1) -- Line: 75 -- upvalues: u5 (val)
        u5:_handleSyncEvent(p1)
    end)
    u5._remoteEvent:FireServer()
    return u5
end

function u12:GetTime() -- Line: 84
    if self:IsSynced() then
        return (self:_getLocalTime()) - self._offset
    end
    warn("[SlaveClock][GetTime] - Slave clock is not yet synced")
    return self:_getLocalTime()
end

function u12:IsSynced() -- Line: 93
    local v1 = self._offset ~= -1
    return v1
end

function u12._getLocalTime(p1) -- Line: 97
    return tick()
end

function u12:_handleSyncEvent(p2) -- Line: 101
    local v1 = self:_getLocalTime() - p2
    local v2 = self:_getLocalTime()
    local v3 = self:_sendDelayRequest(v2)
    local v4 = (v1 - v3) / 2
    local v5 = (v1 + v3) / 2
    self._offset = v4
    self._pneWayDelay = v5
end

function u12:_sendDelayRequest(p2) -- Line: 129
    return self._remoteFunction:InvokeServer(p2)
end

local function buildClock() -- Line: 135 -- upvalues: RunService (val), u5 (val), u12 (val)
    local TimeSyncEvent = script:WaitForChild("TimeSyncEvent")
    local DelayedRequestEvent = script:WaitForChild("DelayedRequestEvent")
    if RunService:IsClient() and RunService:IsServer() then
        local v1 = u5.new(TimeSyncEvent, DelayedRequestEvent)
        TimeSyncEvent.OnClientEvent:Connect(function() end)
        return v1
    end
    if RunService:IsClient() then
        return u12.new(TimeSyncEvent, DelayedRequestEvent)
    end
    return u5.new(TimeSyncEvent, DelayedRequestEvent)
end

return buildClock()