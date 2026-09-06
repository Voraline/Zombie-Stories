local RunService = game:GetService("RunService")
local u5 = {}
u5.__index = u5
u5.ClassName = "MasterClock"
function u5.new(p1, p2) -- Line: 14 -- upvalues: u5 (val)
    local u5
    u5 = setmetatable({}, u5)
    local v1 = p1
    if not v1 then
        v1 = error("No remoteEvent")
    end
    u5._remoteEvent = v1
    v1 = p2
    if not v1 then
        v1 = error("No remoteFunction")
    end
    u5._remoteFunction = v1
    function u5._remoteFunction.OnServerInvoke(p1, p2) -- Line: 20 -- upvalues: u5 (val)
        return u5:_handleDelayRequest(p2)
    end
    u5._remoteEvent.OnServerEvent:Connect(function(p1) -- Line: 23 -- upvalues: u5 (val)
        u5._remoteEvent:FireClient(p1, u5:GetTime())
    end)
    task.defer(function() -- Line: 27 -- upvalues: u5 (val)
        while true do
            task.wait(3.5)
            u5:Sync()
        end
    end)
    return u5
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
    local u5 = setmetatable({}, u12)
    local v1 = p1
    if not v1 then
        v1 = error("No remoteEvent")
    end
    u5._remoteEvent = v1
    v1 = p2
    if not v1 then
        v1 = error("No remoteFunction")
    end
    u5._remoteFunction = v1
    u5._remoteEvent.OnClientEvent:Connect(function(p1) -- Line: 75 -- upvalues: u5 (val)
        u5:_handleSyncEvent(p1)
    end)
    u5._remoteEvent:FireServer()
    return u5
end
function u12:GetTime() -- Line: 84
    if not (self:IsSynced()) then
        warn("[SlaveClock][GetTime] - Slave clock is not yet synced")
        return self:_getLocalTime()
    end
    local v1 = self:_getLocalTime()
    return v1 - self._offset
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
    local v2 = self:_sendDelayRequest((self:_getLocalTime()))
    self._offset = (v1 - v2) / 2
    self._pneWayDelay = (v1 + v2) / 2
end
function u12:_sendDelayRequest(p2) -- Line: 129
    return self._remoteFunction:InvokeServer(p2)
end
return (function() -- Line: 135 -- upvalues: RunService (val), u5 (val), u12 (val)
    local TimeSyncEvent = script:WaitForChild("TimeSyncEvent")
    local DelayedRequestEvent = script:WaitForChild("DelayedRequestEvent")
    if not (RunService:IsClient()) then
        if RunService:IsClient() then
            return u12.new(TimeSyncEvent, DelayedRequestEvent)
        end
        return u5.new(TimeSyncEvent, DelayedRequestEvent)
    end
    if RunService:IsServer() then
        local v1 = u5.new(TimeSyncEvent, DelayedRequestEvent)
        TimeSyncEvent.OnClientEvent:Connect(function() end)
        return v1
    end
    if RunService:IsClient() then
        return u12.new(TimeSyncEvent, DelayedRequestEvent)
    end
    return u5.new(TimeSyncEvent, DelayedRequestEvent)
end)()