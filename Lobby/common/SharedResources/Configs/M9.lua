local v1 = {
	["Ammo"] = 15,
	["StoredAmmo"] = 120,
	["AmmoType"] = nil,
	["Damage"] = 25,
	["Multipliers"] = {
		["Arms"] = 1,
		["Torso"] = 1,
		["Legs"] = 1,
		["Head"] = 1.5
	},
	["Penetration"] = 0,
	["PenetrationReduction"] = 0.5,
	["FireMode"] = { "Semi-Auto", "Burst" },
	["DelayPerShot"] = 0.08,
	["BurstAmt"] = 3,
	["BurstDelay"] = 0.1,
	["ADSSpeed"] = 1,
	["DrawSpeed"] = 1,
	["HolsterSpeed"] = 1,
	["ReloadTime"] = 2.483,
	["ReloadTimeScale"] = 1,
	["EmptyReloadTime"] = 3.567,
	["EmptyReloadTimeScale"] = 1,
	["EquippedWalkspeedChange"] = 0,
	["HolsteredWalkspeedChange"] = 0,
	["EquippedWalkspeedMultiplier"] = 1,
	["HolsteredWalkspeedMultiplier"] = 1,
	["BaseSpread"] = 0.08726646259971647,
	["CrouchSpreadReduction"] = nil,
	["ProneSpreadReduction"] = nil,
	["ADSSpreadReduction"] = 0.5,
	["MovementSpread"] = nil,
	["AirSpread"] = nil,
	["SlidingSpread"] = nil,
	["DivingSpread"] = nil,
	["ShootingSpreadIncrement"] = nil,
	["ShootingSpreadDecay"] = nil,
	["ShootSingle"] = {
		["SoundId"] = "6921331659",
		["Volume"] = 0.25
	},
	["AutoLoop"] = nil,
	["AutoLoopTail"] = nil,
	["KeyFrameSounds"] = {
		["mag_in"] = {
			["SoundId"] = "485599325",
			["Volume"] = 0.5
		},
		["slide_forward"] = {
			["SoundId"] = "485598642",
			["Volume"] = 0.5
		},
		["mag_out"] = {
			["SoundId"] = "485599431",
			["Volume"] = 0.5
		},
		["slide_back"] = {
			["SoundId"] = "485598458",
			["Volume"] = 0.5
		}
	},
	["UnequipSFX"] = {
		["SoundId"] = "8856316960",
		["Volume"] = 0.5
	},
	["DeploySFX"] = {
		["SoundId"] = "166083962",
		["Volume"] = 0.5
	},
	["IsAPistol"] = true,
	["UsePistolIcon"] = false,
	["BulletCasing"] = "pistol",
	["WorldScaleValue"] = 0.74165418187138,
	["NewSkinsSystem"] = true,
	["NewSkinsSystemBlacklist"] = {
		["Dying Hope M9"] = true,
		["Cyber M9"] = true,
		["Samurai Edge M9"] = true,
		["Merica Sidearm"] = true,
		["Gingerbread M9"] = true,
		["Albert 01R M9"] = true
	},
	["UseAltCameraReload"] = true,
	["DynamicFOVOffsetConstant"] = 2,
	["AimDynamicFOVOffsetConstant"] = 0.5,
	["Offset"] = CFrame.new(0.0799999982, -0.0500000007, -0.200000003, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	["SprintOffset"] = CFrame.new(-0.300000012, 0, -0.300000012, 0.962250173, -0.0841859728, 0.258819044, -0.0299755037, 0.912392259, 0.408217907, -0.270510703, -0.400565982, 0.875426054),
	["AimOffset"] = CFrame.new(0, 0.00999999978, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	["VerticalRecoil"] = 3.95,
	["HorizontalRecoil"] = 1,
	["AttachmentNodeData"] = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/M9_Mods")
}
return v1