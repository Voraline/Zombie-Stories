game:GetService("ReplicatedStorage")
local v_u_1 = game.Players.LocalPlayer
local v_u_2 = v_u_1.Character
v_u_2 = v_u_2
local v_u_3
if v_u_2 then
	v_u_3 = v_u_2:WaitForChild("Humanoid", 5)
else
	v_u_3 = v_u_2
end
local v_u_4 = script:WaitForChild("Animations"):GetChildren()
local v_u_5 = Instance.new("BindableEvent")
local v_u_6 = Instance.new("BindableEvent")
local v_u_7 = Instance.new("BindableEvent")
local v_u_8 = require("@game/ReplicatedStorage/common/Settings")
local v_u_9 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_12 = {
	["HasLanded"] = true,
	["Climbing"] = false,
	["GetOff"] = false,
	["Jumped"] = v_u_5.Event,
	["Landed"] = v_u_6.Event,
	["Respawned"] = v_u_7.Event,
	["JumpPower"] = 30,
	["Animations"] = {},
	["hpUpdated"] = function(_, _) -- name: hpUpdated end,
	["SetJumpPower"] = function(p10, p11) -- name: SetJumpPower
		p10.JumpPower = p11
		if p10.Humanoid then
			p10.Humanoid.JumpPower = p11
		end
	end
}
local function v_u_18(p_u_13) -- name: ConEvents
	-- upvalues: (ref) v_u_3, (copy) v_u_12, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_1, (copy) v_u_7, (copy) v_u_18, (copy) v_u_9, (copy) v_u_8
	if not v_u_3 then
		v_u_3 = p_u_13:WaitForChild("Humanoid")
	end
	task.defer(function()
		-- upvalues: (ref) v_u_3, (ref) v_u_12
		local v14 = Instance.new("BuoyancySensor")
		v14.Parent = v_u_3.Parent:WaitForChild("Left Leg")
		v_u_12.WaterSensor = v14
	end)
	for _, v15 in pairs(v_u_4) do
		v_u_12.Animations[v15.Name] = v_u_3:WaitForChild("Animator"):LoadAnimation(v15)
	end
	v_u_3.Jumping:Connect(function()
		-- upvalues: (ref) v_u_12, (ref) v_u_5
		if v_u_12.HasLanded then
			v_u_5:Fire()
		end
		v_u_12.HasLanded = false
	end)
	v_u_3.Running:Connect(function()
		-- upvalues: (ref) v_u_12
		if v_u_12.Climbing == true then
			v_u_12.Climbing = false
		end
	end)
	v_u_3.StateChanged:Connect(function(_, p16)
		-- upvalues: (ref) v_u_12, (ref) v_u_6
		if p16 == Enum.HumanoidStateType.Freefall then
			v_u_12.HasLanded = false
		elseif p16 == Enum.HumanoidStateType.Landed then
			if not v_u_12.HasLanded then
				v_u_6:Fire()
			end
			v_u_12.HasLanded = true
		end
	end)
	v_u_3.Climbing:Connect(function()
		-- upvalues: (ref) v_u_12
		v_u_12.Climbing = true
	end)
	v_u_3.Seated:Connect(function(p17)
		-- upvalues: (ref) v_u_12
		if p17 == true then
			v_u_12.HasLanded = false
		else
			v_u_12.GetOff = true
		end
	end)
	v_u_3.Died:Connect(function()
		-- upvalues: (ref) v_u_12, (ref) p_u_13, (ref) v_u_1, (ref) v_u_3, (ref) v_u_7, (ref) v_u_18
		v_u_12.Alive = false
		v_u_12.WaterSensor = nil
		p_u_13 = v_u_1.CharacterAdded:Wait()
		v_u_3 = p_u_13:WaitForChild("Humanoid")
		v_u_7:Fire(v_u_3)
		v_u_18()
	end)
	v_u_3:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
	v_u_3:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	v_u_3:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	v_u_3.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	v_u_12.Humanoid = v_u_3
	v_u_3.UseJumpPower = true
	v_u_3.JumpPower = v_u_12.JumpPower
	v_u_3.AutoJumpEnabled = v_u_9(v_u_8.Controls.AutoJump) or false
end
if v_u_2 then
	print("HumanoidUtil Char")
	v_u_18(v_u_2)
else
	task.defer(function()
		-- upvalues: (ref) v_u_2, (copy) v_u_1, (ref) v_u_3, (copy) v_u_18
		if v_u_2 then
			return
		else
			local v19 = v_u_1.Character or v_u_1.CharacterAdded:Wait()
			task.wait()
			v_u_2 = v19
			if not v_u_3 then
				v_u_3 = v_u_2:WaitForChild("Humanoid")
				v_u_18(v_u_2)
				print("HumanoidUtil defer")
			end
		end
	end)
end
v_u_1.CharacterAdded:Connect(function(p20)
	-- upvalues: (copy) v_u_18
	print("HumanoidUtil Add")
	v_u_18(p20)
end)
v_u_1.CharacterRemoving:Connect(function()
	-- upvalues: (copy) v_u_12, (ref) v_u_3
	print("HumanoidUtil Remove")
	v_u_12.Humanoid = nil
	v_u_3 = nil
end)
v_u_8.SettingsChanged:Connect(function()
	-- upvalues: (ref) v_u_3, (copy) v_u_9, (copy) v_u_8
	if v_u_3 then
		v_u_3.AutoJumpEnabled = v_u_9(v_u_8.Controls.AutoJump) or false
	end
end)
return v_u_12