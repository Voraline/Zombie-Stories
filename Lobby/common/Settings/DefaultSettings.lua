local v1 = {
	["Graphics"] = {
		["Ragdolls"] = true,
		["Flinching"] = true,
		["HeadgearHeadshot"] = false,
		["BulletHoles"] = true,
		["ArmorDestroyEffect"] = true,
		["ZombieQuality"] = 4,
		["ParticleQuality"] = 4,
		["BaseFOV"] = 70,
		["LoadLobbyChoice"] = 1,
		["AnimatedTextures"] = true,
		["RagdollTimer"] = 4,
		["BulletTracers"] = true,
		["BulletShells"] = true,
		["HideNearbyPlayers"] = false,
		["ShowMeleeHitboxes"] = false,
		["DisplayDamageIndicators"] = false,
		["ProceduralAnimations"] = true
	},
	["Sound"] = {
		["RagdollSounds"] = true,
		["MusicVolume"] = 1,
		["MainMenuTheme"] = 9
	},
	["MainMenu"] = {
		["TradeEnabled"] = true,
		["ShowLevel"] = true,
		["ShowStats"] = true
	},
	["Camera"] = {
		["MaxCameraDistance"] = 6,
		["ThirdPersonSide"] = 1,
		["PinchToZoom"] = true,
		["ScrollWheelZoom"] = true
	}
}
local v2 = {
	["Sensitivity"] = 1,
	["AimingSensitivity"] = 1,
	["AutoShoot"] = true,
	["AutoJump"] = false,
	["DPadSelection"] = false,
	["ShowEditButton"] = false,
	["DynamicStaminaUI"] = true,
	["MobileSelectionMode"] = 1,
	["GamepadSelectionMode"] = 1,
	["ShowControlHints"] = true,
	["HotbarScale"] = 0.95,
	["Binds"] = nil
}
local v3 = {
	["Reload"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.R,
		["Gamepad"] = Enum.KeyCode.ButtonX
	},
	["PrimaryAttack"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Mouse"] = Enum.UserInputType.MouseButton1,
		["Gamepad"] = Enum.KeyCode.ButtonR2
	},
	["SecondaryAttack"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Mouse"] = Enum.UserInputType.MouseButton2,
		["Gamepad"] = Enum.KeyCode.ButtonL2
	},
	["ToggleSecondaryAttack"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.Q
	},
	["Firemode"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.B,
		["Gamepad"] = Enum.KeyCode.ButtonY
	},
	["QuickMeleeAndBlock"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.V
	},
	["OffHandUse"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.F,
		["Gamepad"] = Enum.KeyCode.ButtonR1
	},
	["SprintHold"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.LeftShift
	},
	["SprintToggle"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Gamepad"] = Enum.KeyCode.ButtonL3
	},
	["CrouchHold"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.LeftControl
	},
	["CrouchToggle"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.C
	},
	["ProneToggle"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.X
	},
	["CrouchProneToggle"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Gamepad"] = Enum.KeyCode.ButtonB
	},
	["Thirdperson"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.Z,
		["Gamepad"] = Enum.KeyCode.ButtonR3
	},
	["PromptInteract"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.E,
		["Gamepad"] = Enum.KeyCode.ButtonX
	},
	["LeaderboardToggle"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil
	},
	["LeaderboardHold"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.Tab
	},
	["NVGToggle"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.N,
		["Gamepad"] = Enum.KeyCode.ButtonL1
	},
	["QuickChat"] = {
		["Keyboard"] = nil,
		["Mouse"] = nil,
		["Gamepad"] = nil,
		["Keyboard"] = Enum.KeyCode.G
	}
}
v2.Binds = v3
v1.Controls = v2
return v1