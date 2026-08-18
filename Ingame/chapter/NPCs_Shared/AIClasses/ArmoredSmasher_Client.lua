local v_u_1 = game:GetService("ReplicatedStorage")
workspace:WaitForChild("Ignore")
local v2 = v_u_1.common:WaitForChild("NPCs_Shared")
local v_u_3 = v_u_1.arc.NPCs_Shared.Resources.NPCModels
local v_u_4 = require(v2.AIClasses.BaseNPCv2_Client)
local v_u_5 = {
	["_ClassName"] = script.Name
}
v_u_5.__index = v_u_5
setmetatable(v_u_5, v_u_4)
v_u_5.Name = "Armored Smasher"
v_u_5.CanParry = false
v_u_5.AttackSound = v2.Resources.SFX.miss:Clone()
v_u_5.AttackSound.Volume = 0
function v_u_5.new(p6) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
	local v7 = v_u_4.new(p6)
	local v8 = v_u_5
	setmetatable(v7, v8)
	v7.BaseModel = v_u_3.ArmoredSmasher
	v7.HealthBarName = "Armored Smasher"
	v7.AnimationInfo.Attack = {
		["Id"] = "rbxassetid://1521393887",
		["Priority"] = nil,
		["Speed"] = 0.75,
		["Priority"] = Enum.AnimationPriority.Action
	}
	v7.AnimationInfo.Idle = {
		["Id"] = "rbxassetid://1457837265",
		["Priority"] = nil,
		["Priority"] = Enum.AnimationPriority.Core
	}
	v7.AnimationInfo.Walk = {
		["Id"] = "rbxassetid://1683003916",
		["Priority"] = nil,
		["Priority"] = Enum.AnimationPriority.Idle
	}
	return v7
end
function v_u_5.Spawn(p9, ...) -- name: Spawn
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	v_u_4.Spawn(p9, ...)
	p9.SmashFX = v_u_1.chapter.NPCs_Shared.Resources.SmashEffects.SmashEffects.SmashFX:Clone()
	local v10 = Instance.new("Sound")
	v10.Name = "Sound"
	v10.SoundId = "rbxassetid://3763439926"
	v10.Volume = 0.25
	v10.Parent = p9.SmashFX
	p9.SmashFX.Parent = p9.Model.HumanoidRootPart
end
function v_u_5.Attack(p11, ...) -- name: Attack
	-- upvalues: (copy) v_u_4
	v_u_4.Attack(p11, ...)
	p11.SmashFX.Debris:Emit(10)
	p11.SmashFX.Smash:Emit(1)
	p11.SmashFX.Smash1:Emit(1)
	p11.SmashFX.Sound:Play()
end
return v_u_5