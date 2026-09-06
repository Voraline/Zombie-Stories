local ReplicatedStorage = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
NPCs_Shared:WaitForChild("Resources")
local NPCModels = ReplicatedStorage.arc.NPCs_Shared.Resources.NPCModels
local BaseNPCv2_Client = require(NPCs_Shared.AIClasses.BaseNPCv2_Client)
local u27 = {_ClassName = script.Name}
u27.__index = u27
setmetatable(u27, BaseNPCv2_Client)
u27.Name = "Charger"
function u27.new(p1) -- Line: 28 -- upvalues: BaseNPCv2_Client (val), u27 (val), NPCModels (val)
    local v1 = BaseNPCv2_Client.new(p1)
    setmetatable(v1, u27)
    v1.BaseModel = NPCModels.Charger
    v1.HealthBarName = "Charger"
    v1.AnimationInfo.Attack = {Id = "rbxassetid://1387793624", Priority = Enum.AnimationPriority.Action}
    v1.AnimationInfo.Idle = {Id = "rbxassetid://1457837265", Priority = Enum.AnimationPriority.Core}
    v1.AnimationInfo.Walk = {Id = "rbxassetid://1457816581", Priority = Enum.AnimationPriority.Idle}
    return v1
end
return u27