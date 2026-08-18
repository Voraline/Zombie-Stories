local v_u_1 = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local v_u_2 = v_u_1.common:WaitForChild("NPCs_Shared")
local v_u_3 = v_u_1.chapter.NPCs_Shared.Resources.NPCModels
local v_u_4 = require(v_u_2.AIClasses.BaseNPCv2_Client)
local v_u_5 = {
	["_ClassName"] = script.Name
}
v_u_5.__index = v_u_5
setmetatable(v_u_5, v_u_4)
v_u_5.Name = "Smasher"
v_u_5.CanParry = false
v_u_5.AttackSound = v_u_2.Resources.SFX.miss:Clone()
v_u_5.AttackSound.Volume = 0
function v_u_5.new(p6) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3, (copy) v_u_2
	local v7 = v_u_4.new(p6)
	local v8 = v_u_5
	setmetatable(v7, v8)
	v7.AnimationInfo.Walk = {
		["Id"] = "rbxassetid://1683003916",
		["Priority"] = nil,
		["Priority"] = Enum.AnimationPriority.Idle
	}
	v7.AnimationInfo.Idle = {
		["Id"] = "rbxassetid://1457837265",
		["Priority"] = nil,
		["Priority"] = Enum.AnimationPriority.Core
	}
	v7.AnimationInfo.Attack = {
		["Id"] = "rbxassetid://1521393887",
		["Priority"] = nil,
		["Speed"] = 0.75,
		["Priority"] = Enum.AnimationPriority.Action
	}
	v7.BaseModel = v_u_3.Smasher
	v7.HitSFX = v_u_2.Resources.SFX.damage2:Clone()
	return v7
end
function v_u_5.Attack(p9) -- name: Attack
	-- upvalues: (copy) v_u_4
	if p9.Model.Parent ~= nil then
		v_u_4.Attack(p9)
		task.wait(0.4)
		p9.SmashFX.Debris:Emit(10)
		p9.SmashFX.Smash:Emit(1)
		p9.SmashFX.Smash1:Emit(1)
		p9.SmashFX.Sound:Play()
	end
end
function v_u_5.GenerateModel(p10, ...) -- name: GenerateModel
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	v_u_4.GenerateModel(p10, ...)
	p10.SmashFX = v_u_1.chapter.NPCs_Shared.Resources.SmashEffects.SmashEffects.SmashFX:Clone()
	local v11 = Instance.new("Sound")
	v11.Name = "Sound"
	v11.SoundId = "rbxassetid://3763439926"
	v11.Volume = 0.25
	v11.Parent = p10.SmashFX
	p10.SmashFX.Parent = p10.Model.HumanoidRootPart
end
return v_u_5