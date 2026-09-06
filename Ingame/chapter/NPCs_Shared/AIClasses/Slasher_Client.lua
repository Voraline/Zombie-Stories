local ReplicatedStorage = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
NPCs_Shared:WaitForChild("Resources")
local NPCModels = ReplicatedStorage.arc.NPCs_Shared.Resources.NPCModels
local BaseNPCv2_Client = require(NPCs_Shared.AIClasses.BaseNPCv2_Client)
local u27 = {_ClassName = script.Name}
u27.__index = u27
setmetatable(u27, BaseNPCv2_Client)
u27.Name = "Slasher"
function u27.new(p1) -- Line: 28 -- upvalues: BaseNPCv2_Client (val), u27 (val), NPCModels (val)
    local v1 = BaseNPCv2_Client.new(p1)
    setmetatable(v1, u27)
    v1.BaseModel = NPCModels.Slasher
    v1.HealthBarName = "Slasher"
    v1.AnimationInfo.Idle = {Id = "rbxassetid://1456411981", Priority = Enum.AnimationPriority.Core}
    v1.AnimationInfo.Attack = {Id = "rbxassetid://9205494146", Priority = Enum.AnimationPriority.Action}
    return v1
end
return u27