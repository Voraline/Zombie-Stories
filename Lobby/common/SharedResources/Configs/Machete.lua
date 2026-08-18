local v1 = {
	["Damage"] = 20,
	["Multipliers"] = {
		["Arms"] = 1,
		["Torso"] = 1,
		["Legs"] = 1,
		["Head"] = 1.5
	},
	["Penetration"] = 1,
	["PenetrationReduction"] = 0.5,
	["MaxEnemiesPerSwing"] = 4,
	["MaxHitsPerEnemy"] = 3,
	["StaminaRequired"] = 5,
	["StaminaUsed"] = 5,
	["DelayPerShot"] = 0.8,
	["HeavyDelayPerShot"] = 1.5,
	["SwingStart"] = 0.1,
	["SwingEnd"] = 0.3,
	["SwingComboEnd"] = 3.5,
	["HeavyStaminaRequired"] = 10,
	["HeavyStaminaCost"] = 10,
	["HeavySwingStart"] = 0.3,
	["HeavySwingEnd"] = 0.3,
	["HeavyChargeStaminaDrain"] = 0.25,
	["ChargeTime"] = 0.5,
	["BlockStaminaRequired"] = 5,
	["BlockStaminaDrain"] = 0.1,
	["BlockCooldown"] = 0.25,
	["ParryWindow"] = 0.3,
	["BlockReduction"] = 0.5,
	["ADSSpeed"] = 1,
	["DrawSpeed"] = 1.5,
	["HolsterSpeed"] = 1.5,
	["IsMelee"] = true,
	["UseBlockAnimation"] = true,
	["HitRegLeniency"] = 10
}
local v2 = {
	["Swing1"] = {
		["start"] = 0.2,
		["num_rays"] = 20,
		["raysbeforedelay"] = 4,
		["delaytime"] = 0.01,
		["max_dist"] = 8.5,
		["min_dist"] = 8,
		["yaw"] = -70,
		["pitch"] = 0,
		["direction"] = -1
	},
	["Swing2"] = {
		["start"] = 0.2,
		["num_rays"] = 20,
		["raysbeforedelay"] = 4,
		["delaytime"] = 0.01,
		["max_dist"] = 8.5,
		["min_dist"] = 8,
		["yaw"] = 70,
		["pitch"] = 0,
		["direction"] = -1
	},
	["HeavySwing"] = {
		["start"] = 0.3,
		["num_rays"] = 20,
		["raysbeforedelay"] = 4,
		["delaytime"] = 0.01,
		["max_dist"] = 8,
		["min_dist"] = 8,
		["yaw"] = -70,
		["pitch"] = 70,
		["direction"] = -1
	},
	["HeavySwing2"] = {
		["start"] = 0.3,
		["num_rays"] = 20,
		["raysbeforedelay"] = 4,
		["delaytime"] = 0.01,
		["max_dist"] = 8,
		["min_dist"] = 8,
		["yaw"] = 70,
		["pitch"] = 70,
		["direction"] = -1
	}
}
v1.SwingData = v2
v1.EquippedWalkspeedChange = 0
v1.HolsteredWalkspeedChange = 0
v1.EquippedWalkspeedMultiplier = 1
v1.HolsteredWalkspeedMultiplier = 1
v1.FirstDrawAnimation = nil
v1.FirstDrawAnimationTime = nil
v1.DrawAnimation = nil
v1.DrawAnimationTime = nil
v1.KeyFrameSounds = {
	["Slash"] = {
		["SoundId"] = "8880136011",
		["Volume"] = 0.5
	},
	["Swing"] = {
		["SoundId"] = "6241709963",
		["Volume"] = 0.5
	},
	["HeavySwing"] = {
		["SoundId"] = "7171591581",
		["Volume"] = 0.5
	},
	["Charge"] = {
		["SoundId"] = "9125407249",
		["Volume"] = 0.5
	}
}
v1.UnequipSFX = {
	["SoundId"] = "481731911",
	["Volume"] = 0.5
}
v1.DeploySFX = {
	["SoundId"] = "5752235534",
	["Volume"] = 0.5
}
v1.HitSFX = {
	["ID"] = "566593606",
	["PlaybackSpeed"] = 0.8,
	["Volume"] = 0.75
}
v1.BlockSFX = {
	["SoundId"] = "9125670740",
	["Volume"] = 0.5
}
v1.StartBlockSFX = {
	["SoundId"] = "9116844753",
	["Volume"] = 0.5
}
v1.NewSkinsSystem = false
v1.NewSkinsSystemBlacklist = {}
v1.WorldScaleValue = 0.9
function v1.Parried(p3) -- name: Parried
	local v4 = p3.Viewmodel.Model.KeyParts.Parry
	v4.ParrySparks:Emit(math.random(10, 25))
	v4.Attachment.ParryLargeSparkParticles:Emit(1)
end
function v1.Blocked(p5) -- name: Blocked
	p5.Viewmodel.Model.KeyParts.Parry.ParrySparks:Emit(math.random(10, 25))
end
v1.DynamicFOVOffsetConstant = 3
v1.Offset = CFrame.new()
v1.SprintOffset = CFrame.new()
v1.CrouchAnimation = CFrame.new()
v1.BlockOffset = CFrame.new()
v1.HolsterCF = CFrame.new(0, -2, 3) * CFrame.Angles(-0.4363323129985824, 0, 0)
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/BaseMelee")
return v1