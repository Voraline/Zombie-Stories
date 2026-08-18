local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local _ = script.Parent
local v_u_2 = require(v_u_1.common:WaitForChild("Janitor"))
local v_u_3 = require(v_u_1.common.SharedResources:WaitForChild("Attachments"):WaitForChild("AttachmentSystem"))
local v_u_4 = require(v_u_1.common.NPCs_Shared.Utils.DamageFalloffUtil)
local _ = CFrame.new
local _ = CFrame.Angles
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6, p7) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	local v8 = {}
	local v9 = v_u_5
	setmetatable(v8, v9)
	v8.Model = p6
	v8.Weapon = p7
	v8.Janitor = v_u_2.new()
	setupViewmodel(v8)
	return v8
end
function v_u_5.Destroy(p10) -- name: Destroy
	p10.Model:Destroy()
	local v11 = p10.Janitor
	if v11 then
		v11:Destroy()
		p10.Janitor = nil
	end
end
function v_u_5.Shoot(_) -- name: Shoot end
function v_u_5.StopAnimation(p12, p13, p14) -- name: StopAnimation
	if p12.Animations[p13] then
		p12.Animations[p13]:Stop(p14)
	end
end
function v_u_5.PlayAnimation(p15, p16, ...) -- name: PlayAnimation
	local v17, v18, v19 = unpack({ ... })
	local v20 = v17 or 0
	local v21 = v18 or 1
	local v22 = v19 or 1
	if p15.Animations[p16] then
		p15.Animations[p16]:Play(v20, v21, v22)
	else
		warn("[Viewmodel] Could not play animation " .. p16)
	end
end
function createVM(p23) -- name: createVM
	local v24 = p23.Model.Name
	local v25 = p23.Model
	if v25 then
		local v26 = v25:WaitForChild("KeyParts"):FindFirstChild("Barrel") or v25.KeyParts.Handle
		local v27 = Instance.new("Attachment")
		v27.Name = "BarrelAttachment"
		v27.Parent = v26
		for _, v28 in v26:QueryDescendants("ParticleEmitter, Light, Attachment") do
			if v28 ~= v27 then
				v28.Parent = v27
			end
		end
		local v29 = v25:FindFirstChild("HumanoidRootPart")
		if v29 then
			local v30 = v25:FindFirstChildWhichIsA("AnimationController")
			if not v30 then
				v30 = Instance.new("AnimationController")
				v30.Parent = v25
			end
			local v31 = v30:FindFirstChildOfClass("Animator")
			if not v31 then
				v31 = Instance.new("Animator")
				v31.Parent = v30
			end
			for _, v32 in v25:QueryDescendants("BasePart") do
				v32.CastShadow = false
			end
			return v25, v29, v31
		end
		warn("[Viewmodel]: Could not find HumanoidRootPart for weapon: " .. v24)
	else
		warn("[Viewmodel] Could not find viewmodel for weapon: " .. v24)
	end
end
function loadAnimations(p_u_33, p34, p35) -- name: loadAnimations
	local v36 = {}
	for _, v37 in pairs(p35:GetChildren()) do
		if v37:IsA("Animation") then
			local v38 = p34:LoadAnimation(v37)
			v38.Looped = v37.Name == "Idle"
			p_u_33.Janitor:Add(v38, "Destroy")
			p_u_33.Janitor:Add(v38.KeyframeReached:Connect(function(p39)
				-- upvalues: (copy) p_u_33
				if p_u_33.Weapon.Config.KeyFrameSounds[p39] then
					local v40 = Instance.new("Sound")
					v40.SoundId = "rbxassetid://" .. (p_u_33.Weapon.Config.KeyFrameSounds[p39][1] or p_u_33.Weapon.Config.KeyFrameSounds[p39].SoundId)
					v40.Volume = p_u_33.Weapon.Config.KeyFrameSounds[p39][2] or p_u_33.Weapon.Config.KeyFrameSounds[p39].Volume
					v40.Parent = p_u_33.PrimaryPart
					v40:Play()
					game.Debris:AddItem(v40, 10)
				end
				if not p_u_33.Weapon.LowPolyMode then
					if p_u_33.Weapon.Config.OnKeyframeReached then
						p_u_33.Weapon.Config.OnKeyframeReached(p39, p_u_33.Weapon)
					end
					if p_u_33.Weapon.Config.CustomKF then
						p_u_33.Weapon.Config.CustomKF(p39, p_u_33.Model, p_u_33.Weapon.Config)
					end
				end
			end), "Disconnect")
			v36[v37.Name] = v38
		end
	end
	if v36.Idle then
		v36.Idle:Play()
	else
		local v41 = p_u_33.Weapon.Config.IsMelee and p35.Swing1:Clone() or (p_u_33.Weapon.Config.UsesLoadLoop and p35.LoadStart:Clone() or p35.Reload:Clone())
		v41.Name = "Idle"
		local v42 = p34:LoadAnimation(v41)
		v42.Looped = true
		repeat
			task.wait()
		until v42.Length > 0
		v42:Play()
		v42.TimePosition = v42.Length
		v42:AdjustSpeed(0)
		v36.Idle = v42
	end
	if v36.IdleLayer then
		v36.IdleLayer:Play()
	end
	return v36
end
function setupViewmodel(p_u_43) -- name: setupViewmodel
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_4
	local v44, v45, v46 = createVM(p_u_43)
	p_u_43.Model = v44
	p_u_43.PrimaryPart = v45
	p_u_43.Barrel = v44:WaitForChild("KeyParts"):FindFirstChild("Barrel") or v44.KeyParts:FindFirstChild("Handle")
	p_u_43.BarrelAttachment = p_u_43.Barrel:WaitForChild("BarrelAttachment")
	p_u_43.Aimpart = v44.KeyParts:FindFirstChild("Aimpart")
	p_u_43.Animator = v46
	v44.Parent = workspace.Ignore
	p_u_43.Animations = loadAnimations(p_u_43, v46, v44:WaitForChild("Animations"))
	v44.Parent = nil
	p_u_43.Animations.Idle.Priority = Enum.AnimationPriority.Core
	if p_u_43.Weapon.Config.MuzzleModule then
		local v47 = v_u_1.common.SharedResources.MuzzleFlash[p_u_43.Weapon.Config.MuzzleModule]
		v47.Effects.MuzzleModuleFX:Clone().Parent = p_u_43.BarrelAttachment
		p_u_43.MuzzleModule = require(v47)
	end
	if p_u_43.Weapon.Mods then
		v_u_3.DressWeapon(v44.Name, p_u_43.Weapon.Mods, p_u_43.Weapon.Config.AttachmentNodeData, v44, function(_, p48, p49)
			-- upvalues: (copy) p_u_43, (ref) v_u_4, (ref) v_u_1
			local v50
			if p49 then
				v50 = require(p49).new(p48, p_u_43.Weapon.Config, p_u_43)
				if v50.SettingChanges then
					for v51, v52 in v50.SettingChanges do
						if v51 == "Damage" and (p_u_43.Weapon.Config.DamageDropoff and not v50.SettingChanges.DamageDropoff) then
							p_u_43.Weapon.Config.DamageDropoff = v_u_4.RescaleDropoff(p_u_43.Weapon.Config.DamageDropoff, p_u_43.Weapon.Config.Damage, v52)
						end
						p_u_43.Weapon.Config[v51] = v52
						if v51 == "BarrelAttachment" then
							for _, v53 in p_u_43.BarrelAttachment:GetChildren() do
								v53.Parent = v52
							end
							p_u_43.BarrelAttachment = v52
						elseif v51 == "MuzzleModule" then
							p_u_43.BarrelAttachment:ClearAllChildren()
							local v54 = v_u_1.common.SharedResources.MuzzleFlash[p_u_43.Weapon.Config.MuzzleModule]
							v54.Effects.MuzzleModuleFX:Clone().Parent = p_u_43.BarrelAttachment
							p_u_43.MuzzleModule = require(v54)
						end
					end
				end
			else
				v50 = nil
			end
			return v50
		end, true)
	end
	p_u_43.ViewmodelLoaded = true
end
return v_u_5