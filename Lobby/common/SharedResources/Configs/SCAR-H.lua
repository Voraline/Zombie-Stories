local v1 = {
	["Ammo"] = 20,
	["StoredAmmo"] = 200,
	["AmmoType"] = nil,
	["Damage"] = 26,
	["Multipliers"] = {
		["Arms"] = 1,
		["Torso"] = 1,
		["Legs"] = 1,
		["Head"] = 2
	},
	["Penetration"] = 0,
	["PenetrationReduction"] = 0.5,
	["FireMode"] = { "Auto", "Semi-Auto" },
	["DelayPerShot"] = 0.1,
	["BurstAmt"] = nil,
	["BurstDelay"] = nil,
	["ADSSpeed"] = 0.9,
	["DrawSpeed"] = 0.8,
	["HolsterSpeed"] = 0.865,
	["ReloadTime"] = 2.317,
	["ReloadTimeScale"] = 1,
	["EmptyReloadTime"] = 3,
	["EmptyReloadTimeScale"] = 1,
	["EquippedWalkspeedChange"] = 0,
	["HolsteredWalkspeedChange"] = 0,
	["EquippedWalkspeedMultiplier"] = 0.98,
	["HolsteredWalkspeedMultiplier"] = 1,
	["BaseSpread"] = 0.04363323129985824,
	["CrouchSpreadReduction"] = 0.7,
	["ProneSpreadReduction"] = 0.3,
	["ADSSpreadReduction"] = 0.3,
	["MovementSpread"] = nil,
	["AirSpread"] = nil,
	["SlidingSpread"] = nil,
	["DivingSpread"] = nil,
	["ShootingSpreadIncrement"] = nil,
	["ShootingSpreadDecay"] = nil,
	["FirstDrawAnimation"] = nil,
	["FirstDrawAnimationTime"] = nil,
	["DrawAnimation"] = nil,
	["DrawAnimationTime"] = nil,
	["ShootSingle"] = {
		["SoundId"] = "6150718445",
		["Volume"] = 0.45
	},
	["AutoLoop"] = nil,
	["AutoLoopTail"] = nil,
	["KeyFrameSounds"] = {
		["mag_out_empty"] = {
			["SoundId"] = "6941845510",
			["Volume"] = 0.5
		},
		["mag_in_empty_2"] = {
			["SoundId"] = "6941845478",
			["Volume"] = 0.5
		},
		["mag_in_empty_1"] = {
			["SoundId"] = "6941845455",
			["Volume"] = 0.5
		},
		["action1"] = {
			["SoundId"] = "6941845535",
			["Volume"] = 0.5
		},
		["mag_out"] = {
			["SoundId"] = "6941850094",
			["Volume"] = 0.5
		},
		["r2i"] = {
			["SoundId"] = "6941845559",
			["Volume"] = 0.5
		},
		["bolt_release"] = {
			["SoundId"] = "6941852334",
			["Volume"] = 0.5
		},
		["mag_in"] = {
			["SoundId"] = "6941845478",
			["Volume"] = 0.5
		}
	},
	["DeploySFX"] = nil,
	["IsAPistol"] = false,
	["UsePistolIcon"] = false,
	["BulletCasing"] = "rifle",
	["WorldScaleValue"] = 1,
	["NewSkinsSystem"] = false,
	["NewSkinsSystemBlacklist"] = {},
	["DynamicFOVOffsetConstant"] = 1.5,
	["AimDynamicFOVOffsetConstant"] = 0.1,
	["Offset"] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	["SprintOffset"] = CFrame.new(0.5, -0.200000003, 0, 0.696706712, 0, 0.717356086, -0.142516658, 0.980066597, 0.138414249, -0.703056753, -0.198669329, 0.682818949),
	["AimOffset"] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
}
local function v_u_5(p2, p3) -- name: setInstanceTransparency
	if p2 then
		if p2:IsA("BasePart") then
			p2.Transparency = p3
		else
			for _, v4 in p2:GetDescendants() do
				if v4:IsA("BasePart") then
					v4.Transparency = p3
				end
			end
		end
	else
		return
	end
end
local function v_u_11(p6, p7) -- name: findMagazinePart
	if not p6 then
		return nil
	end
	local v8 = p6:FindFirstChild("Magazine_Hide")
	local v9 = v8 and v8:FindFirstChild(p7)
	if v9 then
		return v9
	end
	local v10 = p6:FindFirstChild("Magazine_Show")
	return v10 and v10:FindFirstChild(p7) or p6:FindFirstChild(p7, true)
end
function v1.CustomEquip(_, p12) -- name: CustomEquip
	-- upvalues: (copy) v_u_5, (copy) v_u_11
	local v13 = nil
	local v14 = nil
	local v15 = nil
	local v16 = nil
	local v17 = nil
	local v18 = nil or p12:FindFirstChild("Weapon")
	if v18 and not v13 then
		v13 = p12:FindFirstChild("KeyParts")
	end
	if v13 then
		local v19 = v13:FindFirstChild("Irons1")
		local v20 = v13:FindFirstChild("Irons2")
		if v19 and v20 then
			v19.Transparency = 1
			v20.Transparency = 1
		end
	end
	if v13 and not v14 then
		v14 = v13:FindFirstChild("MagOneBone")
	end
	if v14 and not v15 then
		v15 = v13:FindFirstChild("MagTwoBone")
	end
	if v15 and not v16 then
		v16 = v18:FindFirstChild("ExtMag")
	end
	if v16 and not v17 then
		v17 = v18:FindFirstChild("Falsemag")
	end
	if v17 then
		v14.Color = v16.Color
		v15.Color = v14.Color
		v17.Transparency = 1
	end
	v_u_5(v_u_11(v18, "RegMagClone"), 1)
	v_u_5(v_u_11(v18, "Drum"), 1)
end
function v1.OnWeaponReload(p_u_21) -- name: OnWeaponReload
	-- upvalues: (copy) v_u_5, (copy) v_u_11
	if p_u_21.Ammo > 0 then
		task.delay(0.1, function()
			-- upvalues: (copy) p_u_21, (ref) v_u_5, (ref) v_u_11
			if p_u_21 and not p_u_21.IsDestroyed then
				local v22 = p_u_21.Viewmodel.Model.Weapon
				v_u_5(v_u_11(v22, "RegMagClone"), 0)
				v_u_5(v_u_11(v22, "Drum"), 0)
			end
		end)
	end
end
function v1.CustomKF(p23, p24, _) -- name: CustomKF
	-- upvalues: (copy) v_u_5, (copy) v_u_11
	if p23 == "action1" then
		local v25 = nil
		local v26 = nil
		local v27 = nil
		local v28 = nil
		local v29 = nil
		local v30 = nil or p24:FindFirstChild("Weapon")
		if v30 and not v25 then
			v25 = p24:FindFirstChild("KeyParts")
		end
		if v25 and not v26 then
			v26 = v25:FindFirstChild("MagOneBone")
		end
		if v26 and not v27 then
			v27 = v25:FindFirstChild("MagTwoBone")
		end
		if v27 and not v28 then
			v28 = v30:FindFirstChild("ExtMag")
		end
		if v28 and not v29 then
			v29 = v30:FindFirstChild("Falsemag")
		end
		if v29 then
			v26.Color = v28.Color
			v27.Color = v26.Color
			v29.Transparency = 1
			return
		end
	elseif p23 == "mag_in" then
		v_u_5(v_u_11(p24.Weapon, "RegMagClone"), 1)
		v_u_5(v_u_11(p24.Weapon, "Drum"), 1)
	end
end
v1.Mods = {
	["Optic"] = {
		{
			["Name"] = "Red Dot",
			["Level"] = 6
		},
		{
			["Name"] = "Kobra Sight",
			["Level"] = 6
		}
	},
	["Other"] = {
		{
			["Name"] = "+10 Bullets",
			["Level"] = 10
		},
		{
			["Name"] = "Rifle HP",
			["Level"] = 12
		},
		{
			["Name"] = "Rifle AP",
			["Level"] = 14
		}
	}
}
v1.KeyFrameSounds = {
	["action1"] = { 6941845535, 0.5 },
	["mag_out_empty"] = { 6941845510, 0.5 },
	["mag_in_empty_1"] = { 6941845455, 0.5 },
	["mag_in_empty_2"] = { 6941845478, 0.5 },
	["r2i"] = { 6941845559, 0.5 },
	["mag_out"] = { 6941850094, 0.5 },
	["mag_in"] = { 6941845478, 0.5 },
	["bolt_release"] = { 6941852334, 0.5 }
}
v1.Ammo = 20
v1.StoredAmmo = 200
v1.Spread = 0.04363323129985824
v1.ADSSpreadReduction = 0.2
v1.RecoilPitchSpeed = 12
v1.RecoilPitchDamper = 1.6
v1.VerticalRecoil = 5.1
v1.HorizontalRecoil = 2
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/SCAR_Mods")
return v1