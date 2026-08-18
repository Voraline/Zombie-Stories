if game:GetService("RunService"):IsServer() then
	return {}
end
local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local _ = v_u_2.common
local v3 = require(v_u_2.Packages.Fusion)
local v4 = v3.scoped(v3)
local v_u_5 = v3.peek
local v_u_6 = require(v_u_2.common.ZS_Shared.Data.GameState)
local v_u_7 = require(script.SettingsGui)(v4, v_u_6.Data.IsLobby)
v_u_7.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
v_u_7.Enabled = false
local v_u_8 = v_u_7.Panel
local v9 = game.ReplicatedStorage.common.RedEvents
local v_u_10 = require("@game/ReplicatedStorage/common/Icon")
local v_u_11 = require(script:WaitForChild("ZSLib"))
require(script:WaitForChild("BannerNotificationModule"))
local v12 = require("@game/ReplicatedStorage/common/Signal")
local v_u_13 = require("@self/DefaultSettings")
local v_u_14 = require(v9.General.SettingsEvent)
local v_u_15 = false
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v22, v23 = require(v9.General.SettingsFunction):Call({
	["Type"] = "GetSavedSettings"
}):Await()
local v24
if v22 then
	v24 = v23 or v_u_13
else
	v24 = v_u_13
end
if not v22 then
	warn("[Settings] Could not fetch saved settings, using defaults")
end
local v_u_25 = {
	["Scope"] = v4,
	["SettingsChanged"] = v12.new(),
	["OpenChanged"] = v12.new()
}
for v_u_26, v27 in v24 do
	v_u_25[v_u_26] = {}
	for v_u_28, v29 in v27 do
		if typeof(v29) == "table" then
			v_u_25[v_u_26][v_u_28] = v29
		else
			local v_u_30 = v4:Value(v29)
			v_u_25[v_u_26][v_u_28] = v_u_30
			v4:Observer(v_u_30):onChange(function()
				-- upvalues: (copy) v_u_26, (copy) v_u_28, (copy) v_u_25, (copy) v_u_5, (copy) v_u_30
				local v31 = { v_u_26, v_u_28 }
				v_u_25.SettingsChanged:Fire(v31, v_u_5(v_u_30))
			end)
		end
	end
end
local v_u_32 = script:WaitForChild("click")
v_u_8.Header.Exit.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_15, (copy) v_u_32, (copy) v_u_7, (copy) v_u_25
	if v_u_15 then
		v_u_32:Play()
		v_u_7.Enabled = false
		v_u_25.OpenChanged:Fire(false)
	end
	v_u_15 = false
	if v_u_25.SettingsIcon then
		v_u_25.SettingsIcon:deselect()
	end
end)
function v_u_25.Init(_) -- name: Init
	-- upvalues: (copy) v_u_11, (copy) v_u_8, (copy) v_u_25, (ref) v_u_16, (copy) v_u_5, (copy) v_u_13, (ref) v_u_17, (copy) v_u_2, (ref) v_u_15, (copy) v_u_32, (copy) v_u_7, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_21, (copy) v_u_1, (copy) v_u_10, (copy) v_u_6, (copy) v_u_14
	local v33 = v_u_11:Init(v_u_8, v_u_25.SettingsChanged)
	v_u_16 = v33:Tab("GRAPHICS")
	v_u_16:Header("DISPLAY")
	v_u_16:Number("FIELD OF VIEW", v_u_5(v_u_25.Graphics.BaseFOV), function(p34)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.BaseFOV:set(p34)
	end, 40, 110, 0.014285714285714285)
	local v_u_36 = v_u_16:Toggle("BULLET TRACERS", v_u_5(v_u_25.Graphics.BulletTracers), function(p35)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.BulletTracers:set(p35)
	end, "Show bullet trails when shooting.")
	local v_u_38 = v_u_16:Toggle("BULLET SHELLS", v_u_5(v_u_25.Graphics.BulletShells), function(p37)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.BulletShells:set(p37)
	end, "Show bullet shell ejection effects.")
	local v_u_40 = v_u_16:Toggle("ANIMATED TEXTURES", v_u_5(v_u_25.Graphics.AnimatedTextures), function(p39)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.AnimatedTextures:set(p39)
	end)
	local v_u_42 = v_u_16:Toggle("BULLET HOLES", v_u_5(v_u_25.Graphics.BulletHoles), function(p41)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.BulletHoles:set(p41)
	end, "Create bullet holes upon shooting.")
	local v_u_43 = {
		{ "ASK", 3 },
		{ "YES", 1 },
		{ "NO", 2 }
	}
	local v_u_45 = v_u_16:Dropdown("LOAD LOBBY", v_u_43, v_u_43[v_u_5(v_u_25.Graphics.LoadLobbyChoice)][1], function(p44, _)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.LoadLobbyChoice:set(p44)
	end, "Set whether or not the lobby map loads.")
	v_u_16:Header("ZOMBIES")
	local v_u_46 = {
		{ "VERY LOW", 4 },
		{ "LOW", 3 },
		{ "MEDIUM", 2 },
		{ "HIGH", 1 }
	}
	local v_u_48 = v_u_16:Dropdown("ZOMBIE QUALITY", v_u_46, v_u_46[v_u_5(v_u_25.Graphics.ZombieQuality)][1], function(p47, _)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.ZombieQuality:set(p47)
	end, "The detail level of zombie models.")
	local v_u_50 = v_u_16:Toggle("FLINCHING", v_u_5(v_u_25.Graphics.Flinching), function(p49)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.Flinching:set(p49)
	end, "Zombies will flinch when shot.")
	local v_u_52 = v_u_16:Toggle("RAGDOLLS", v_u_5(v_u_25.Graphics.Ragdolls), function(p51)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.Ragdolls:set(p51)
	end, "Zombies will ragdoll on death.")
	local v_u_54 = v_u_16:Number("RAGDOLL TIME", v_u_5(v_u_25.Graphics.RagdollTimer), function(p53)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.RagdollTimer:set(p53)
	end, 0, 4, 0.0625)
	local v_u_56 = v_u_16:Toggle("ARMOR DESTROY EFFECT", v_u_5(v_u_25.Graphics.ArmorDestroyEffect), function(p55)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.ArmorDestroyEffect:set(p55)
	end, "Animations for armor flying off when broken.")
	local v_u_58 = v_u_16:Toggle("HEADGEAR EFFECT", v_u_5(v_u_25.Graphics.HeadgearHeadshot), function(p57)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.HeadgearHeadshot:set(p57)
	end, "Headgear flies off on headshot kill.")
	local v_u_59 = {
		{ "DISABLED", 4 },
		{ "LOW", 3 },
		{ "MEDIUM", 2 },
		{ "HIGH", 1 }
	}
	local v_u_61 = v_u_16:Dropdown("PARTICLE QUALITY", v_u_59, v_u_59[v_u_5(v_u_25.Graphics.ParticleQuality)][1], function(p60, _)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.ParticleQuality:set(p60)
	end, "Set the quality of blood and impact effects.")
	v_u_16:Header("MISC")
	local v_u_63 = v_u_16:Toggle("HIDE NEARBY PLAYERS", v_u_5(v_u_25.Graphics.HideNearbyPlayers), function(p62)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.HideNearbyPlayers:set(p62)
	end, "Nearby player characters will be made transparent.")
	local v_u_65 = v_u_16:Toggle("PROCEDURAL ANIMATIONS", v_u_5(v_u_25.Graphics.ProceduralAnimations), function(p64)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.ProceduralAnimations:set(p64)
	end, "Use procedural IK leg animations instead of default walk.")
	local v_u_67 = v_u_16:Toggle("SHOW MELEE HITBOXES", v_u_5(v_u_25.Graphics.ShowMeleeHitboxes), function(p66)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.ShowMeleeHitboxes:set(p66)
	end, "Show raycast hitboxes when swinging melee.")
	local v_u_69 = v_u_16:Toggle("DISPLAY DAMAGE INDICATORS", v_u_5(v_u_25.Graphics.DisplayDamageIndicators), function(p68)
		-- upvalues: (ref) v_u_25
		v_u_25.Graphics.DisplayDamageIndicators:set(p68)
	end, "Show damage dealt per hit on each shot.")
	local function v_u_70() -- name: resetDefault
		-- upvalues: (ref) v_u_25, (ref) v_u_13, (copy) v_u_38, (copy) v_u_42, (copy) v_u_58, (copy) v_u_56, (copy) v_u_50, (copy) v_u_52, (copy) v_u_54, (copy) v_u_63, (copy) v_u_36, (copy) v_u_40, (copy) v_u_65, (copy) v_u_67, (copy) v_u_69, (copy) v_u_48, (copy) v_u_46, (ref) v_u_5, (copy) v_u_61, (copy) v_u_59, (copy) v_u_45, (copy) v_u_43
		v_u_25.Graphics.Ragdolls:set(true)
		v_u_25.Graphics.RagdollTimer:set(4)
		v_u_25.Graphics.BulletTracers:set(true)
		v_u_25.Sound.RagdollSounds:set(true)
		v_u_25.Graphics.Flinching:set(true)
		v_u_25.Graphics.HideNearbyPlayers:set(false)
		v_u_25.Graphics.HeadgearHeadshot:set(false)
		v_u_25.Graphics.ArmorDestroyEffect:set(true)
		v_u_25.Graphics.BulletHoles:set(true)
		v_u_25.Graphics.ShowMeleeHitboxes:set(false)
		v_u_25.Graphics.ZombieQuality:set(4)
		v_u_25.Graphics.ParticleQuality:set(4)
		v_u_25.Graphics.AnimatedTextures:set(v_u_13.Graphics.AnimatedTextures)
		v_u_25.Graphics.BulletShells:set(true)
		v_u_38(true)
		v_u_42(true)
		v_u_58(false)
		v_u_56(true)
		v_u_50(true)
		v_u_52(true)
		v_u_54(4)
		v_u_63(false)
		v_u_36(true)
		v_u_40(v_u_13.Graphics.AnimatedTextures)
		v_u_65(true)
		v_u_25.Graphics.ProceduralAnimations:set(true)
		v_u_67(false)
		v_u_69(false)
		v_u_48:set(v_u_46[v_u_5(v_u_25.Graphics.ZombieQuality)][1])
		v_u_61:set(v_u_59[v_u_5(v_u_25.Graphics.ParticleQuality)][1])
		v_u_45:set(v_u_43[v_u_5(v_u_25.Graphics.LoadLobbyChoice)][1])
		v_u_25.SettingsChanged:Fire()
	end
	v_u_16:Button("RESET TO DEFAULT", "RESET", function()
		-- upvalues: (copy) v_u_70
		v_u_70()
	end, Color3.fromRGB(255, 73, 73), Color3.fromRGB(49, 49, 49), Color3.fromRGB(255, 73, 73))
	v_u_16.UIElements["RESET TO DEFAULT"].LayoutOrder = 999
	v_u_17 = v33:Tab("MOBILE")
	local v71 = {
		{ "HOTBAR", 1 },
		{ "SWAP", 2 },
		{ "DPAD", 3 }
	}
	v_u_17:Dropdown("WEAPON SELECTION", v71, v71[v_u_5(v_u_25.Controls.MobileSelectionMode)][1], function(p72, _)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.MobileSelectionMode:set(p72)
	end, "How weapons are selected on mobile.")
	v_u_17:Toggle("AUTO SHOOT", v_u_5(v_u_25.Controls.AutoShoot), function(p73)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.AutoShoot:set(p73)
	end, "Auto shoot an enemy by hovering over them.")
	v_u_17:Toggle("AUTO JUMP", v_u_5(v_u_25.Controls.AutoJump), function(p74)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.AutoJump:set(p74)
	end, "Automatically jump over obstacles.")
	v_u_17:Toggle("DYNAMIC STAMINA UI", v_u_5(v_u_25.Controls.DynamicStaminaUI), function(p75)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.DynamicStaminaUI:set(p75)
	end, "Move stamina ui to center when using melee.")
	v_u_17:Toggle("SHOW EDIT BUTTON", v_u_5(v_u_25.Controls.ShowEditButton), function(p76)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.ShowEditButton:set(p76)
	end, "Show the edit button on the mobile HUD.")
	v_u_17:Number("HOTBAR SCALE", v_u_5(v_u_25.Controls.HotbarScale), function(p77)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.HotbarScale:set(p77)
	end, 0.5, 1.5, 0.05)
	v_u_17:Button("EDIT MOBILE CONTROLS", "EDIT", function()
		-- upvalues: (ref) v_u_2, (ref) v_u_15, (ref) v_u_32, (ref) v_u_7, (ref) v_u_25
		local v_u_78 = require(v_u_2.common:WaitForChild("HUDService")):GetElement("MobileControls")
		if v_u_78 then
			if v_u_15 then
				v_u_32:Play()
				v_u_7.Enabled = false
				v_u_25.OpenChanged:Fire(false)
			end
			v_u_15 = false
			if v_u_25.SettingsIcon then
				v_u_25.SettingsIcon:deselect()
			end
			task.defer(function()
				-- upvalues: (copy) v_u_78
				v_u_78:EnterEditMode()
			end)
		end
	end)
	v_u_18 = v33:Tab("CONTROLS")
	v_u_18:Number("SENSITIVITY", v_u_5(v_u_25.Controls.Sensitivity), function(p79)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.Sensitivity:set(p79)
	end, 0, 10, 0.0001)
	v_u_18:Number("ADS SENSITIVITY", v_u_5(v_u_25.Controls.AimingSensitivity), function(p80)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.AimingSensitivity:set(p80)
	end, 0, 10, 0.0001)
	local v81 = {
		{ "SWAP", 1 },
		{ "DPAD", 2 }
	}
	v_u_18:Toggle("SHOW CONTROL HINTS", v_u_5(v_u_25.Controls.ShowControlHints), function(p82)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.ShowControlHints:set(p82)
	end, "Show contextual input hints on screen.")
	v_u_18:Dropdown("GAMEPAD WEAPON SELECTION", v81, v81[v_u_5(v_u_25.Controls.GamepadSelectionMode)][1], function(p83, _)
		-- upvalues: (ref) v_u_25
		v_u_25.Controls.GamepadSelectionMode:set(p83)
	end, "How weapons are selected on gamepad.")
	v_u_19 = v33:Tab("CAMERA")
	v_u_19:Toggle("SCROLL WHEEL ZOOM", v_u_5(v_u_25.Camera.ScrollWheelZoom), function(p84)
		-- upvalues: (ref) v_u_25
		v_u_25.Camera.ScrollWheelZoom:set(p84)
	end, "Use scroll wheel to zoom camera in and out.")
	local v85 = {
		{ "RIGHT", 1 },
		{ "LEFT", 2 }
	}
	v_u_19:Dropdown("THIRD PERSON SIDE", v85, v85[v_u_5(v_u_25.Camera.ThirdPersonSide)][1], function(p86, _)
		-- upvalues: (ref) v_u_25
		v_u_25.Camera.ThirdPersonSide:set(p86)
	end, "Default shoulder side in third person.")
	v_u_19:Number("MAX CAMERA DISTANCE", v_u_5(v_u_25.Camera.MaxCameraDistance), function(p87)
		-- upvalues: (ref) v_u_25
		v_u_25.Camera.MaxCameraDistance:set(p87)
	end, 1, 10, 0.1111111111111111)
	v_u_19:Toggle("PINCH TO ZOOM", v_u_5(v_u_25.Camera.PinchToZoom), function(p88)
		-- upvalues: (ref) v_u_25
		v_u_25.Camera.PinchToZoom:set(p88)
	end, "Allow pinch gesture to zoom on mobile.")
	v_u_20 = v33:Tab("MAIN MENU")
	v_u_20:Toggle("TRADE ENABLED", v_u_5(v_u_25.MainMenu.TradeEnabled), function(p89)
		-- upvalues: (ref) v_u_25
		v_u_25.MainMenu.TradeEnabled:set(p89)
	end, "Enable sending and receiving trade requests.")
	v_u_20:Toggle("SHOW LEVEL", v_u_5(v_u_25.MainMenu.ShowLevel), function(p90)
		-- upvalues: (ref) v_u_25
		v_u_25.MainMenu.ShowLevel:set(p90)
	end, "Show level to other players in queues.")
	v_u_20:Toggle("SHOW STATS", v_u_5(v_u_25.MainMenu.ShowStats), function(p91)
		-- upvalues: (ref) v_u_25
		v_u_25.MainMenu.ShowStats:set(p91)
	end, "Show stats to other players in queues.")
	v_u_21 = v33:Tab("SOUND")
	local v92 = {
		{ "Arseniy Shkljaev - NIKKIT", 1 },
		{ "BSlick - ORIGINAL (Variation 1)", 2 },
		{ "BSlick - ORIGINAL (Variation 2)", 3 },
		{ "Eva Weiss - CHRISTMAS", 4 },
		{ "Eva Weiss - HALLOWEEN", 5 },
		{ "BSlick - A51 GOOD ENDING", 6 },
		{ "Airhead Music - COLLIDE", 7 },
		{ "Unknown - OLD SHOP", 8 },
		{ "Arseniy Shkljaev - NIKKIT 2020", 9 },
		{ "Nightforce - ASSAULT", 10 },
		{ "\"Expedite\"", 11 }
	}
	v_u_21:Toggle("RAGDOLL SOUNDS", v_u_5(v_u_25.Sound.RagdollSounds), function(p93)
		-- upvalues: (ref) v_u_25
		v_u_25.Sound.RagdollSounds:set(p93)
	end, "Zombies will play sounds when ragdolling.")
	v_u_21:Number("MUSIC VOLUME", v_u_5(v_u_25.Sound.MusicVolume), function(p94)
		-- upvalues: (ref) v_u_25
		v_u_25.Sound.MusicVolume:set(p94)
	end, 0, 10, 0.01)
	local v95 = v_u_5(v_u_25.Sound.MainMenuTheme)
	if not v92[v95] then
		v_u_25.Sound.MainMenuTheme:set(1)
		v95 = 1
	end
	v_u_21:Dropdown("MAIN MENU THEME", v92, v92[v95][1], function(p96, _)
		-- upvalues: (ref) v_u_25
		v_u_25.Sound.MainMenuTheme:set(p96)
	end, "The music that will play in the main menu.")
	require("@self/Binding").CreateSection(v33)
	local v97 = game:GetService("RunService"):IsStudio()
	local v98 = Enum.KeyCode.P
	if v97 then
		v98 = Enum.KeyCode.P
	end
	local v_u_99 = nil
	local v_u_100 = 0
	local v_u_101 = nil
	v_u_1.LocalPlayer:GetAttributeChangedSignal("ZBucksPickedUp"):Connect(function()
		-- upvalues: (ref) v_u_99, (ref) v_u_10, (ref) v_u_101, (ref) v_u_1, (ref) v_u_100
		if not v_u_99 then
			v_u_99 = v_u_10.new()
		end
		local v102 = tick()
		v_u_101 = v102
		local v103 = v_u_1.LocalPlayer:GetAttribute("ZBucksPickedUp")
		local v104 = v_u_100
		local v105
		if v_u_100 < v103 then
			v105 = 1
		else
			v105 = -1
		end
		while v_u_101 == v102 and v104 ~= v103 do
			v104 = v104 + v105
			v_u_100 = v104
			v_u_99:setLabel("Z$ " .. v104)
			task.wait(0.05)
		end
	end)
	local v_u_106 = v_u_10.new():setImage(7059346373):setLabel("Close", "selected"):setLabel("P", "deselected"):bindEvent("selected", function(_)
		-- upvalues: (ref) v_u_15, (ref) v_u_32, (ref) v_u_7, (ref) v_u_25
		if not v_u_15 then
			v_u_32:Play()
			v_u_7.Enabled = true
			v_u_25.OpenChanged:Fire(true)
		end
		v_u_15 = true
	end):bindEvent("deselected", function(_)
		-- upvalues: (ref) v_u_15, (ref) v_u_32, (ref) v_u_7, (ref) v_u_25
		if v_u_15 then
			v_u_32:Play()
			v_u_7.Enabled = false
			v_u_25.OpenChanged:Fire(false)
		end
		v_u_15 = false
	end):bindToggleKey(v98)
	v_u_25.SettingsIcon = v_u_106
	local v_u_108 = v_u_10.new():setLabel("FPS: 0"):setTextFont(Enum.Font.SourceSans):align("Right"):lock():setOrder(1):bindEvent("selected", function(p107)
		p107:deselect()
	end)
	local v_u_110 = v_u_10.new():setLabel("CPU: 0"):align("Right"):lock():setOrder(2):bindEvent("selected", function(p109)
		p109:deselect()
	end)
	game:GetService("UserInputService").InputBegan:Connect(function(p111)
		-- upvalues: (copy) v_u_106
		if p111.UserInputType == Enum.UserInputType.Touch or p111.UserInputType == Enum.UserInputType.Gamepad1 then
			v_u_106:setLabel("", "deselected")
		elseif p111.UserInputType == Enum.UserInputType.Keyboard then
			v_u_106:setLabel("P", "deselected")
		end
	end)
	local v_u_113 = v_u_10.new():setLabel("0 ms"):align("Right"):lock():setOrder(3):bindEvent("selected", function(p112)
		p112:deselect()
	end)
	local v_u_114 = game:GetService("RunService")
	local v_u_115 = game:GetService("Players").LocalPlayer
	local v_u_116 = nil
	local v_u_117 = nil
	local v_u_118 = 0
	local v_u_119 = nil
	local v_u_120 = "FPS: 0"
	local v121 = game:GetService("RunService")
	local v_u_122 = v121:IsRunning() and time or os.clock
	local v_u_123 = nil
	local v_u_124 = nil
	local v_u_125 = {}
	local function v132() -- name: HeartbeatUpdate
		-- upvalues: (ref) v_u_123, (copy) v_u_122, (copy) v_u_125, (ref) v_u_120, (ref) v_u_124
		v_u_123 = v_u_122()
		for v126 = #v_u_125, 1, -1 do
			local v127 = v_u_125
			local v128 = v126 + 1
			local v129
			if v_u_125[v126] >= v_u_123 - 1 then
				v129 = v_u_125[v126] or nil
			else
				v129 = nil
			end
			v127[v128] = v129
		end
		v_u_125[1] = v_u_123
		local v130 = v_u_122() - v_u_124 >= 1 and #v_u_125 or #v_u_125 / (v_u_122() - v_u_124)
		local v131 = math.floor(v130)
		v_u_120 = tostring(v131)
	end
	v_u_124 = v_u_122()
	v121.Heartbeat:Connect(v132)
	task.defer(function()
		-- upvalues: (copy) v_u_110, (ref) v_u_118, (copy) v_u_108, (ref) v_u_120, (copy) v_u_113, (copy) v_u_115
		while task.wait() do
			v_u_110:setLabel("CPU: " .. v_u_118)
			v_u_108:setLabel("FPS: " .. v_u_120)
			local v133 = workspace:GetAttribute("ServerLocation")
			if v133 then
				local v134 = v_u_113
				local v135 = v_u_115:GetNetworkPing() * 1000
				v134:setLabel(v133 .. math.ceil(v135) .. " ms")
			end
		end
	end)
	task.defer(function()
		-- upvalues: (ref) v_u_116, (ref) v_u_117, (copy) v_u_114, (ref) v_u_118, (ref) v_u_119, (copy) v_u_115
		while true do
			v_u_116 = 60
			v_u_117 = os.clock()
			while v_u_116 > 0 do
				v_u_114.Heartbeat:Wait()
				v_u_116 = v_u_116 - 1
			end
			local v136 = (1 - 60 / (os.clock() - v_u_117) / 60) * 100
			v_u_118 = math.round(v136)
			local v137 = (1 - workspace:GetRealPhysicsFPS() / 60) * 100
			v_u_119 = math.round(v137)
			if v_u_118 + v_u_119 < 1 then
				v_u_118 = 0
			elseif v_u_118 + v_u_119 > 100 then
				v_u_118 = 100
			else
				v_u_118 = v_u_118 + v_u_119
			end
			v_u_115:SetAttribute("ClientCPULoad", v_u_118)
		end
	end)
	v33:SetContainer(v_u_16)
	local v138 = v_u_5(v_u_25.Sound.MusicVolume)
	local v139 = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
	v139:SetAttribute("Volume", v138)
	v139.Volume = not v_u_6.Data.Variables.DefaultMusicEnabled and 0 or v138
	v_u_6.Signals.Variables.DefaultMusicEnabled:Connect(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_25, (ref) v_u_6
		local v140 = v_u_5(v_u_25.Sound.MusicVolume)
		local v141 = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
		v141:SetAttribute("Volume", v140)
		v141.Volume = not v_u_6.Data.Variables.DefaultMusicEnabled and 0 or v140
	end)
	v_u_25.SettingsChanged:Connect(function(p142, p143)
		-- upvalues: (ref) v_u_14, (ref) v_u_6
		v_u_14:FireServer({
			["Type"] = "SetSetting",
			["SettingPath"] = nil,
			["NewValue"] = nil,
			["SettingPath"] = p142,
			["NewValue"] = p143
		})
		if typeof(p142) == "table" then
			if p142[1] == "Sound" and p142[2] == "MusicVolume" then
				local v144 = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
				v144:SetAttribute("Volume", p143)
				v144.Volume = not v_u_6.Data.Variables.DefaultMusicEnabled and 0 or p143
			end
			if p142[1] == "Graphics" and p142[2] == "ShowMeleeHitboxes" then
				workspace:SetAttribute("DebugMelee", p143 == true and true or nil)
			end
		end
	end)
end
return v_u_25