local ReplicatedStorage = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
NPCs_Shared:WaitForChild("Resources")
local BaseNPCv2_Client = require(NPCs_Shared.AIClasses.BaseNPCv2_Client)
local u23 = {}
u23._ClassName = script.Name
u23.__index = u23
setmetatable(u23, BaseNPCv2_Client)
u23.GroundPositionCorrectionDisabled = true

function u23.new(p1) -- Line: 27 -- upvalues: BaseNPCv2_Client (val), u23 (val)
    local v1 = BaseNPCv2_Client.new(p1)
    local v2 = u23
    setmetatable(v1, v2)
    return v1
end

function u23.GiveMoverData(p1, p2, p3) -- Line: 34
    p1.LinearVelocityTarget = p2
    p1.RotationalVelocityTarget = p3
end

function u23._GiveOrientation(p1, p2) -- Line: 41
    p1.AlignDirection = p2
end

return u23