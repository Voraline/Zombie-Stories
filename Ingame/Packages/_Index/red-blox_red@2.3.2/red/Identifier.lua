local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Future = require(script.Parent.Parent.Future)
local ReliableRedEvent = ReplicatedStorage:WaitForChild("ReliableRedEvent")
local v1 = {}
local u21 = 0
local u22 = 0
local function UInt(p1) -- Line: 12
    local v1 = ("I%*"):format((math.ceil(math.log(p1 + 1, 2) / 8)))
    return string.pack(v1, p1)
end
function v1.Shared(p1) -- Line: 16 -- upvalues: Future (val), RunService (val), ReliableRedEvent (val), u21 (ref)
    return Future.new(function(p1) -- Line: 17 -- upvalues: RunService (upval), ReliableRedEvent (upval), u21 (upval)
        local v1
        if not (RunService:IsServer()) then
            v1 = task.delay(5, function() -- Line: 30 -- upvalues: p1 (val)
                warn((("Yielded while initializing identifier: %*. It may not exist on the server!"):format(p1)))
            end)
            while not (ReliableRedEvent:GetAttribute(p1)) do
                ReliableRedEvent.AttributeChanged:Wait()
            end
            task.cancel(v1)
            return ReliableRedEvent:GetAttribute(p1)
        end
        if ReliableRedEvent:GetAttribute(p1) then
            return ReliableRedEvent:GetAttribute(p1)
        end
        u21 = u21 + 1
        local v2 = u21
        local v3 = ("I%*"):format((math.ceil(math.log(v2 + 1, 2) / 8)))
        v1 = string.pack(v3, v2)
        ReliableRedEvent:SetAttribute(p1, v1)
        return v1
    end, p1)
end
function v1.Exists(p1) -- Line: 45 -- upvalues: RunService (val), ReliableRedEvent (val)
    local v1 = RunService:IsServer()
    if v1 then
        v1 = ReliableRedEvent:GetAttribute(p1) ~= nil
    end
    return v1
end
function v1.Unique() -- Line: 49 -- upvalues: u22 (ref), UInt (val)
    u22 = u22 + 1
    if u22 == 65535 then
        u22 = 0
    end
    return UInt(u22)
end
return v1