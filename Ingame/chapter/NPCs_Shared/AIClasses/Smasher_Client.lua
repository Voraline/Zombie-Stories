local ReplicatedStorage = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local NPCModels = ReplicatedStorage.chapter.NPCs_Shared.Resources.NPCModels
local BaseNPCv2_Client = require(NPCs_Shared.AIClasses.BaseNPCv2_Client)
local u23 = {}
u23._ClassName = script.Name
u23.__index = u23
setmetatable(u23, BaseNPCv2_Client)
u23.Name = "Smasher"
u23.CanParry = false
u23.AttackSound = NPCs_Shared.Resources.SFX.miss:Clone()
u23.AttackSound.Volume = 0

function u23.new(p1) -- Line: 30 -- upvalues: BaseNPCv2_Client (val), u23 (val), NPCModels (val), NPCs_Shared (val)
    local v1 = BaseNPCv2_Client.new(p1)
    local v2 = u23
    setmetatable(v1, v2)
    local AnimationInfo = v1.AnimationInfo
    AnimationInfo.Walk = {Id = "rbxassetid://1683003916", Priority = Enum.AnimationPriority.Idle}
    local AnimationInfo_2 = v1.AnimationInfo
    AnimationInfo_2.Idle = {Id = "rbxassetid://1457837265", Priority = Enum.AnimationPriority.Core}
    local AnimationInfo_3 = v1.AnimationInfo
    AnimationInfo_3.Attack = {Id = "rbxassetid://1521393887", Speed = 0.75, Priority = Enum.AnimationPriority.Action}
    v1.BaseModel = NPCModels.Smasher
    v1.HitSFX = NPCs_Shared.Resources.SFX.damage2:Clone()
    return v1
end

function u23.Attack(p1) -- Line: 45 -- upvalues: BaseNPCv2_Client (val)
    if p1.Model.Parent == nil then
        return
    end
    BaseNPCv2_Client.Attack(p1)
    task.wait(0.4)
    p1.SmashFX.Debris:Emit(10)
    p1.SmashFX.Smash:Emit(1)
    p1.SmashFX.Smash1:Emit(1)
    p1.SmashFX.Sound:Play()
end

function u23.GenerateModel(p1, ...) -- Line: 57 -- upvalues: BaseNPCv2_Client (val), ReplicatedStorage (val)
    BaseNPCv2_Client.GenerateModel(p1, ...)
    p1.SmashFX = ReplicatedStorage.chapter.NPCs_Shared.Resources.SmashEffects.SmashEffects.SmashFX:Clone()
    local Sound = Instance.new("Sound")
    Sound.Name = "Sound"
    Sound.SoundId = "rbxassetid://3763439926"
    Sound.Volume = 0.25
    Sound.Parent = p1.SmashFX
    p1.SmashFX.Parent = p1.Model.HumanoidRootPart
end

return u23