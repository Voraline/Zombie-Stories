local v1 = {
	["Ammo"] = 8,
	["StoredAmmo"] = 96,
	["AmmoType"] = nil,
	["Damage"] = 50,
	["Multipliers"] = {
		["Arms"] = 1,
		["Torso"] = 1,
		["Legs"] = 1,
		["Head"] = 2.1
	},
	["Penetration"] = 5,
	["PenetrationReduction"] = 0.97,
	["FireMode"] = { "Semi-Auto" },
	["DelayPerShot"] = 0.55,
	["BurstAmt"] = nil,
	["BurstDelay"] = nil,
	["ADSSpeed"] = 1,
	["DrawSpeed"] = 1,
	["HolsterSpeed"] = 1,
	["ReloadTime"] = 3.28,
	["ReloadTimeScale"] = 1,
	["EmptyReloadTime"] = 3.28,
	["EmptyReloadTimeScale"] = 1,
	["EquippedWalkspeedChange"] = 0,
	["HolsteredWalkspeedChange"] = 0,
	["EquippedWalkspeedMultiplier"] = 1,
	["HolsteredWalkspeedMultiplier"] = 1,
	["BaseSpread"] = 0,
	["CrouchSpreadReduction"] = nil,
	["ProneSpreadReduction"] = nil,
	["ADSSpreadReduction"] = 0.75,
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
	["SuppressorShootSingle"] = {
		["SoundId"] = "6977620785",
		["Volume"] = 0.25
	},
	["ShootSingle"] = {
		["SoundId"] = "6141026935",
		["Volume"] = 0.25
	},
	["AutoLoop"] = nil,
	["AutoLoopTail"] = nil,
	["KeyFrameSounds"] = {
		["bolt_forward"] = {
			["SoundId"] = "515215899",
			["Volume"] = 0.5
		},
		["bolt_back"] = {
			["SoundId"] = "515215871",
			["Volume"] = 0.5
		},
		["mag_in"] = {
			["SoundId"] = "515216013",
			["Volume"] = 0.5
		},
		["mag_out"] = {
			["SoundId"] = "515216895",
			["Volume"] = 0.5
		},
		["mag_tap"] = {
			["SoundId"] = "515215936",
			["Volume"] = 0.5
		}
	},
	["DeploySFX"] = nil,
	["IsAPistol"] = false,
	["UsePistolIcon"] = false,
	["BulletCasing"] = "rifle",
	["WorldScaleValue"] = 0.78091650846564,
	["NewSkinsSystem"] = false,
	["NewSkinsSystemBlacklist"] = {},
	["DynamicFOVOffsetConstant"] = 3,
	["AimDynamicFOVOffsetConstant"] = 0.5,
	["Offset"] = CFrame.new(-0.100000001, -0.0500000007, 0.349999994, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	["SprintOffset"] = CFrame.new(0.5, -0.200000003, 0, 0.696706712, 0, 0.717356086, -0.142516658, 0.980066597, 0.138414249, -0.703056753, -0.198669329, 0.682818949),
	["AimOffset"] = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	["VerticalRecoil"] = 10,
	["HorizontalRecoil"] = 8.2,
	["AttachmentNodeData"] = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Base")
}
return v1