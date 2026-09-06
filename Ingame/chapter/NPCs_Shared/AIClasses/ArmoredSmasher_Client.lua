local ReplicatedStorage = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local NPCModels = ReplicatedStorage.arc.NPCs_Shared.Resources.NPCModels
local BaseNPCv2_Client = require(NPCs_Shared.AIClasses.BaseNPCv2_Client)
local u23 = {_ClassName = script.Name}
u23.__index = u23
setmetatable(u23, BaseNPCv2_Client)
u23.Name = "Armored Smasher"
u23.CanParry = false
u23.AttackSound = NPCs_Shared.Resources.SFX.miss:Clone()
u23.AttackSound.Volume = 0
function u23.new(p1) -- Line: 30 -- upvalues: BaseNPCv2_Client (val), u23 (val), NPCModels (val)
    local v1 = BaseNPCv2_Client.new(p1)
    setmetatable(v1, u23)
    v1.BaseModel = NPCModels.ArmoredSmasher
    v1.HealthBarName = "Armored Smasher"
    v1.AnimationInfo.Attack = {Id = "rbxassetid://1521393887", Speed = 0.75, Priority = Enum.AnimationPriority.Action}
    v1.AnimationInfo.Idle = {Id = "rbxassetid://1457837265", Priority = Enum.AnimationPriority.Core}
    v1.AnimationInfo.Walk = {Id = "rbxassetid://1683003916", Priority = Enum.AnimationPriority.Idle}
    return v1
end
function u23.Spawn(p1, ...) -- Line: 46 -- upvalues: BaseNPCv2_Client (val), ReplicatedStorage (val)
    BaseNPCv2_Client.Spawn(p1, ...)
    p1.SmashFX = ReplicatedStorage.chapter.NPCs_Shared.Resources.SmashEffects.SmashEffects.SmashFX:Clone()
    local Sound = Instance.new("Sound")
    Sound.Name = "Sound"
    Sound.SoundId = "rbxassetid://3763439926"
    Sound.Volume = 0.25
    Sound.Parent = p1.SmashFX
    p1.SmashFX.Parent = p1.Model.HumanoidRootPart
end
function u23.Attack(p1, ...) -- Line: 58 -- upvalues: BaseNPCv2_Client (val)
    BaseNPCv2_Client.Attack(p1, ...)
    p1.SmashFX.Debris:Emit(10)
    p1.SmashFX.Smash:Emit(1)
    p1.SmashFX.Smash1:Emit(1)
    p1.SmashFX.Sound:Play()
end
return u23