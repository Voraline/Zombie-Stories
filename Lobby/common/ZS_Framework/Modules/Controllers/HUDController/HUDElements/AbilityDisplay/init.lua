local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("UserInputService")
local v6 = require(v_u_1.Packages.Fusion)
local v7 = v6.scoped
local v_u_8 = v6.peek
require("@game/ReplicatedStorage/common/HUDService")
local v_u_9 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
local v_u_10 = require("@game/ReplicatedStorage/common/BindUtil")
local v_u_11 = require("@game/ReplicatedStorage/common/Settings")
local v12 = require("./Objectives")
local v13 = require("./StaminaDisplay")
local v14 = require("@self/Components/AbilityUI")
local v_u_15 = {
	["xbox"] = {
		[Enum.KeyCode.ButtonR1] = "RB",
		[Enum.KeyCode.ButtonL1] = "LB",
		[Enum.KeyCode.ButtonR2] = "RT",
		[Enum.KeyCode.ButtonL2] = "LT",
		[Enum.KeyCode.ButtonA] = "A",
		[Enum.KeyCode.ButtonB] = "B",
		[Enum.KeyCode.ButtonX] = "X",
		[Enum.KeyCode.ButtonY] = "Y"
	},
	["ps"] = {
		[Enum.KeyCode.ButtonR1] = "R1",
		[Enum.KeyCode.ButtonL1] = "L1",
		[Enum.KeyCode.ButtonR2] = "R2",
		[Enum.KeyCode.ButtonL2] = "L2",
		[Enum.KeyCode.ButtonA] = "X",
		[Enum.KeyCode.ButtonB] = "O",
		[Enum.KeyCode.ButtonX] = "\226\150\161",
		[Enum.KeyCode.ButtonY] = "\226\150\179"
	}
}
local function v_u_22() -- name: getOffHandKeyLabel
	-- upvalues: (copy) v_u_10, (copy) v_u_11, (copy) v_u_5, (copy) v_u_15
	local v16 = v_u_10.getInputMethod()
	if v16 == "Touch" then
		return "[TAP]"
	end
	local v17 = v_u_11.Controls
	if v17 then
		v17 = v_u_11.Controls.Binds
	end
	if v17 then
		v17 = v17.OffHandUse
	end
	if not v17 then
		return v16 == "Gamepad" and "[RB]" or "[F]"
	end
	if v16 ~= "Gamepad" then
		local v18 = v17.Keyboard
		return not v18 and "[F]" or "[" .. v18.Name .. "]"
	end
	local v19 = v_u_5:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross" and "ps" or "xbox"
	local v20 = v_u_15[v19]
	local v21 = v17.Gamepad
	return not (v21 and v20) and (v19 == "ps" and "[R1]" or "[RB]") or "[" .. (v20[v21] or v21.Name) .. "]"
end
local v23 = v7(v6)
local v_u_24 = v23:Value(1)
local v_u_25 = v23:Value(false)
local v_u_26 = v23:Value(false)
local v_u_27 = v23:Value(0)
local v_u_28 = v23:Value(false)
local v_u_29 = v23:Value(1)
local v_u_30 = v23:Value("side")
local v_u_31 = v23:Value(false)
local v_u_32 = v23:Value(false)
local v_u_33 = v23:Value(false)
local v_u_34 = v23:Value(0)
local v_u_35 = v23:Value(0)
local v_u_36 = v23:Value(true)
local v_u_37 = v23:Value(nil)
local v_u_38 = v23:Value(Vector2.new(0, 0))
local v_u_39 = v23:Value(Vector2.new(0, 0))
local v_u_40 = v23:Value("rbxassetid://18494319766")
local v_u_41 = v23:Value(0)
local v_u_42 = v23:Value(0)
local v_u_43 = v23:Value(1)
local v_u_44 = v23:Value((v_u_22()))
local v_u_45 = {
	["Focus"] = "rbxassetid://18494319766",
	["AmmoBox"] = "rbxassetid://18494323513",
	["Medkit"] = "rbxassetid://18494325361"
}
local v_u_46 = v2.LocalPlayer
local v_u_47 = nil
local v_u_48 = nil
local v_u_49 = nil
local v_u_50 = nil
local v_u_51 = nil
local v_u_52 = "none"
local v_u_53 = 0
local v_u_54 = 0
local v_u_55 = 0
local v_u_56 = false
local v_u_57 = 0
local v_u_58 = nil
local v_u_59 = nil
local v60 = v14({
	["scope"] = v23,
	["percentage"] = v_u_24,
	["isReady"] = v_u_25,
	["isActivating"] = v_u_26,
	["activationProgress"] = v_u_27,
	["isActive"] = v_u_28,
	["durationRemaining"] = v_u_29,
	["staminaPlacement"] = v_u_30,
	["isMobile"] = v_u_31,
	["isGamepad"] = v_u_32,
	["visible"] = v_u_33,
	["abilityImage"] = v_u_40,
	["objectiveListSizeY"] = v_u_34,
	["ammoHudWidth"] = v_u_35,
	["staminaFramePosition"] = v_u_38,
	["staminaFrameSize"] = v_u_39,
	["ammoCount"] = v_u_41,
	["customPosition"] = v_u_37,
	["uiScale"] = v_u_43,
	["readyLabelText"] = v_u_44,
	["onActivatePressed"] = function() -- name: onActivatePressed
		-- upvalues: (ref) v_u_59
		if v_u_59 then
			v_u_59:UseOffHand()
		end
	end
})
local v_u_61 = v60.screenGui
local v62 = v60.blueGlowImage
local v_u_63 = v60.mainFrame
v23:Observer(v_u_36):onChange(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_36, (copy) v_u_33, (copy) v_u_61
	v_u_61.Enabled = v_u_8(v_u_36) and v_u_8(v_u_33)
end)
v23:Observer(v_u_33):onChange(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_36, (copy) v_u_33, (copy) v_u_61
	v_u_61.Enabled = v_u_8(v_u_36) and v_u_8(v_u_33)
end)
local v64 = v_u_8(v_u_36)
if v64 then
	v64 = v_u_8(v_u_33)
end
v_u_61.Enabled = v64
local v_u_65 = Instance.new("Sound")
v_u_65.Name = "AbilityReady"
v_u_65.SoundId = "rbxassetid://9039999622"
v_u_65.Parent = v_u_61
local v66 = TweenInfo.new(0.01, Enum.EasingStyle.Linear)
local v67 = TweenInfo.new(0.4, Enum.EasingStyle.Linear)
local v_u_68 = v3:Create(v62, v66, {
	["ImageTransparency"] = 0
})
local v_u_69 = v3:Create(v62, v67, {
	["ImageTransparency"] = 1
})
v_u_68.Completed:Connect(function()
	-- upvalues: (copy) v_u_69
	v_u_69:Play()
end)
local function v_u_71() -- name: switchToFocusDisplay
	-- upvalues: (ref) v_u_47, (copy) v_u_33, (ref) v_u_52, (copy) v_u_40, (ref) v_u_56, (ref) v_u_48, (copy) v_u_28, (copy) v_u_26, (copy) v_u_29, (copy) v_u_41
	if v_u_47 then
		v_u_52 = "focus"
		v_u_40:set("rbxassetid://18494319766")
		v_u_33:set(true)
		if v_u_56 then
			if v_u_48 and v_u_48:IsFullyActivated() then
				v_u_28:set(true)
				v_u_26:set(false)
				local v70 = (v_u_48:GetRemainingTime() or 0) / (v_u_48:GetDuration() or 19)
				v_u_29:set((math.clamp(v70, 0, 1)))
			end
			v_u_56 = false
		end
		v_u_41:set(0)
	else
		v_u_33:set(false)
		v_u_52 = "none"
	end
end
local function v_u_74(p72) -- name: switchToTwoHandedDisplay
	-- upvalues: (ref) v_u_47, (copy) v_u_71, (copy) v_u_33, (ref) v_u_52, (copy) v_u_8, (copy) v_u_28, (ref) v_u_56, (ref) v_u_49, (ref) v_u_50, (copy) v_u_26, (copy) v_u_40, (copy) v_u_45, (copy) v_u_24, (copy) v_u_41, (copy) v_u_29
	if p72 then
		if v_u_52 == "focus" and v_u_8(v_u_28) then
			v_u_56 = true
		end
		v_u_49 = p72
		v_u_50 = p72.Config
		v_u_52 = "twohanded"
		v_u_28:set(false)
		v_u_26:set(false)
		v_u_40:set(v_u_45[p72.Name or "AmmoBox"] or "rbxassetid://18494323513")
		v_u_33:set(true)
		local v73 = p72.Ammo or 0
		v_u_24:set(v73 / (p72.Config.Ammo or 3))
		v_u_41:set(v73)
		v_u_29:set(1)
		return
	elseif v_u_47 then
		v_u_71()
	else
		v_u_33:set(false)
		v_u_52 = "none"
	end
end
local function v_u_80() -- name: updateAbilityState
	-- upvalues: (ref) v_u_52, (ref) v_u_49, (ref) v_u_47, (copy) v_u_33, (copy) v_u_24, (copy) v_u_41, (copy) v_u_8, (copy) v_u_42, (copy) v_u_25, (copy) v_u_26, (copy) v_u_28, (copy) v_u_68, (copy) v_u_65
	local v75
	if v_u_52 == "twohanded" then
		v75 = v_u_49
	else
		v75 = v_u_47
	end
	if v75 then
		local v76 = v75.Ammo or 0
		local v77 = v76 > 0
		if v_u_52 == "twohanded" then
			v_u_24:set(v76 / (v75.Config.Ammo or 3))
			v_u_41:set(v76)
		else
			if v77 then
				v_u_24:set(1)
			else
				v_u_24:set(v_u_8(v_u_42))
			end
			v_u_41:set(0)
		end
		local v78 = v_u_8(v_u_25)
		local v79 = v77 and not v_u_8(v_u_26)
		if v79 then
			v79 = not v_u_8(v_u_28)
		end
		v_u_25:set(v79)
		if v79 and (not v78 and v77) then
			v_u_68:Play()
			v_u_65:Play()
		end
	else
		v_u_33:set(false)
	end
end
local function v_u_84() -- name: updateMobilePlacement
	-- upvalues: (copy) v_u_10, (copy) v_u_31, (copy) v_u_32, (ref) v_u_58, (copy) v_u_46, (copy) v_u_35, (copy) v_u_44, (copy) v_u_22
	local v81 = v_u_10.getInputMethod()
	if v81 == "Touch" then
		v_u_31:set(true)
		v_u_32:set(false)
		local v82 = not v_u_58 and v_u_46:FindFirstChild("PlayerGui")
		if v82 then
			v_u_58 = v82:FindFirstChild("AmmoUI")
		end
		local v83 = v_u_58 and v_u_58:FindFirstChild("Ammo")
		if v83 then
			v_u_35:set(v83.AbsoluteSize.X)
		end
	elseif v81 == "Gamepad" then
		v_u_31:set(false)
		v_u_32:set(true)
	else
		v_u_31:set(false)
		v_u_32:set(false)
	end
	v_u_44:set((v_u_22()))
end
local v_u_91 = {
	["IsShowing"] = true,
	["GetMainFrame"] = function(_) -- name: GetMainFrame
		-- upvalues: (copy) v_u_63
		return v_u_63
	end,
	["SetCustomPosition"] = function(_, p85) -- name: SetCustomPosition
		-- upvalues: (copy) v_u_37
		v_u_37:set(p85)
	end,
	["SetUIScale"] = function(_, p86) -- name: SetUIScale
		-- upvalues: (copy) v_u_43
		v_u_43:set(p86)
	end,
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_36, (copy) v_u_91
		v_u_36:set(true)
		v_u_91.IsShowing = true
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_36, (copy) v_u_91
		v_u_36:set(false)
		v_u_91.IsShowing = false
	end,
	["SetStaminaPlacement"] = function(_, p87) -- name: SetStaminaPlacement
		-- upvalues: (copy) v_u_30
		v_u_30:set(p87)
	end,
	["SetFocusAbility"] = function(_, p88) -- name: SetFocusAbility
		-- upvalues: (ref) v_u_47, (ref) v_u_48, (ref) v_u_52, (copy) v_u_71, (copy) v_u_80, (copy) v_u_33, (copy) v_u_26, (copy) v_u_28
		v_u_47 = p88
		if p88 then
			v_u_48 = p88.Config
			if v_u_52 ~= "twohanded" then
				v_u_71()
				v_u_80()
				return
			end
		else
			v_u_48 = nil
			if v_u_52 == "focus" then
				v_u_33:set(false)
				v_u_52 = "none"
				v_u_26:set(false)
				v_u_28:set(false)
			end
		end
	end,
	["SetTwoHandedAbility"] = function(_, p89) -- name: SetTwoHandedAbility
		-- upvalues: (copy) v_u_74, (copy) v_u_80, (ref) v_u_49, (ref) v_u_50, (ref) v_u_47, (copy) v_u_71, (ref) v_u_51, (copy) v_u_33, (ref) v_u_52, (copy) v_u_26, (copy) v_u_28
		if p89 and (p89.Config and p89.Config.IsTwoHandedAbility) then
			v_u_74(p89)
			v_u_80()
			return
		else
			v_u_49 = nil
			v_u_50 = nil
			if v_u_47 then
				v_u_71()
				v_u_80()
				return
			elseif v_u_51 and (v_u_51.Ammo and v_u_51.Ammo > 0) then
				v_u_74(v_u_51)
				v_u_80()
			else
				v_u_33:set(false)
				v_u_52 = "none"
				v_u_26:set(false)
				v_u_28:set(false)
			end
		end
	end,
	["UpdateAmmo"] = function(_) -- name: UpdateAmmo
		-- upvalues: (copy) v_u_80
		v_u_80()
	end,
	["StartActivating"] = function(_) -- name: StartActivating
		-- upvalues: (copy) v_u_26, (copy) v_u_27, (ref) v_u_52, (ref) v_u_55, (ref) v_u_53
		v_u_26:set(true)
		v_u_27:set(0)
		if v_u_52 == "twohanded" then
			v_u_55 = os.clock()
		else
			v_u_53 = os.clock()
		end
	end,
	["CancelActivating"] = function(_) -- name: CancelActivating
		-- upvalues: (copy) v_u_26, (copy) v_u_27, (copy) v_u_80
		v_u_26:set(false)
		v_u_27:set(0)
		v_u_80()
	end,
	["SetActive"] = function(_, p90) -- name: SetActive
		-- upvalues: (copy) v_u_26, (copy) v_u_28, (copy) v_u_29, (ref) v_u_54, (ref) v_u_56, (ref) v_u_57, (ref) v_u_59, (ref) v_u_52, (copy) v_u_80
		if p90 then
			v_u_26:set(false)
			v_u_28:set(true)
			v_u_29:set(1)
			v_u_54 = os.clock()
			v_u_56 = false
			v_u_57 = 0
			if v_u_59 and v_u_52 == "focus" then
				v_u_59:OffHandItemComplete()
				return
			end
		else
			v_u_28:set(false)
			v_u_29:set(0)
			v_u_56 = false
			v_u_57 = 0
			v_u_80()
			if v_u_59 and v_u_52 == "focus" then
				v_u_59:OffHandItemComplete()
			end
		end
	end
}
local v_u_92 = nil
v23:Observer(v_u_26):onChange(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_26, (copy) v_u_28, (ref) v_u_92, (copy) v_u_4, (ref) v_u_52, (ref) v_u_55, (ref) v_u_53, (copy) v_u_27, (ref) v_u_48, (copy) v_u_29, (copy) v_u_91
	if v_u_8(v_u_26) or v_u_8(v_u_28) then
		if not v_u_92 then
			v_u_92 = v_u_4.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u_8, (ref) v_u_26, (ref) v_u_52, (ref) v_u_55, (ref) v_u_53, (ref) v_u_27, (ref) v_u_28, (ref) v_u_48, (ref) v_u_29, (ref) v_u_91
				if v_u_8(v_u_26) then
					local v93, v94
					if v_u_52 == "twohanded" then
						v93 = os.clock() - v_u_55
						v94 = 1.5
					else
						v93 = os.clock() - v_u_53
						v94 = 1
					end
					local v95 = v93 / v94
					v_u_27:set((math.clamp(v95, 0, 1)))
				end
				if v_u_8(v_u_28) and (v_u_52 == "focus" and v_u_48) then
					local v96 = (v_u_48:GetRemainingTime() or 0) / (v_u_48:GetDuration() or 19)
					local v97 = math.clamp(v96, 0, 1)
					v_u_29:set(v97)
					if v97 <= 0 then
						v_u_91:SetActive(false)
					end
				end
			end)
		end
	else
		if not v_u_8(v_u_26) and (not v_u_8(v_u_28) and v_u_92) then
			v_u_92:Disconnect()
			v_u_92 = nil
		end
		return
	end
end)
v23:Observer(v_u_28):onChange(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_26, (copy) v_u_28, (ref) v_u_92, (copy) v_u_4, (ref) v_u_52, (ref) v_u_55, (ref) v_u_53, (copy) v_u_27, (ref) v_u_48, (copy) v_u_29, (copy) v_u_91
	if v_u_8(v_u_26) or v_u_8(v_u_28) then
		if not v_u_92 then
			v_u_92 = v_u_4.RenderStepped:Connect(function()
				-- upvalues: (ref) v_u_8, (ref) v_u_26, (ref) v_u_52, (ref) v_u_55, (ref) v_u_53, (ref) v_u_27, (ref) v_u_28, (ref) v_u_48, (ref) v_u_29, (ref) v_u_91
				if v_u_8(v_u_26) then
					local v98, v99
					if v_u_52 == "twohanded" then
						v98 = os.clock() - v_u_55
						v99 = 1.5
					else
						v98 = os.clock() - v_u_53
						v99 = 1
					end
					local v100 = v98 / v99
					v_u_27:set((math.clamp(v100, 0, 1)))
				end
				if v_u_8(v_u_28) and (v_u_52 == "focus" and v_u_48) then
					local v101 = (v_u_48:GetRemainingTime() or 0) / (v_u_48:GetDuration() or 19)
					local v102 = math.clamp(v101, 0, 1)
					v_u_29:set(v102)
					if v102 <= 0 then
						v_u_91:SetActive(false)
					end
				end
			end)
		end
	else
		if not v_u_8(v_u_26) and (not v_u_8(v_u_28) and v_u_92) then
			v_u_92:Disconnect()
			v_u_92 = nil
		end
		return
	end
end)
v_u_10.InputMethodChanged:Connect(function(_)
	-- upvalues: (copy) v_u_84
	v_u_84()
end)
v_u_11.SettingsChanged:Connect(function(p103)
	-- upvalues: (copy) v_u_44, (copy) v_u_22
	if p103 and (p103[1] == "Controls" and (p103[2] == "Binds" and p103[3] == "OffHandUse")) then
		v_u_44:set((v_u_22()))
	end
end)
v13.PlacementChanged:Connect(function(p104)
	-- upvalues: (copy) v_u_30
	v_u_30:set(p104)
end)
v_u_30:set(v13:GetPlacement())
local v_u_105 = v13:GetMainFrame()
local function v106() -- name: updateStaminaFrameState
	-- upvalues: (copy) v_u_38, (copy) v_u_105, (copy) v_u_39
	v_u_38:set(v_u_105.AbsolutePosition)
	v_u_39:set(v_u_105.AbsoluteSize)
end
v_u_105:GetPropertyChangedSignal("AbsolutePosition"):Connect(v106)
v_u_105:GetPropertyChangedSignal("AbsoluteSize"):Connect(v106)
v_u_38:set(v_u_105.AbsolutePosition)
v_u_39:set(v_u_105.AbsoluteSize)
local v_u_107 = v12:GetGuiList()
v_u_107:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_31, (copy) v_u_34, (copy) v_u_107
	if v_u_8(v_u_31) then
		v_u_34:set(v_u_107.AbsoluteSize.Y)
	end
end)
task.spawn(function()
	-- upvalues: (ref) v_u_59, (ref) v_u_51, (copy) v_u_91, (ref) v_u_52, (copy) v_u_74, (copy) v_u_80, (copy) v_u_33, (copy) v_u_1, (copy) v_u_42
	v_u_59 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.WeaponController)
	v_u_59.InventoryChanged:Connect(function(p108)
		-- upvalues: (ref) v_u_51, (ref) v_u_91, (ref) v_u_52, (ref) v_u_74, (ref) v_u_80, (ref) v_u_33
		local v109 = nil
		local v110 = nil
		for _, v111 in p108 do
			if v111.Config then
				if v111.Name == "Focus" then
					v110 = v111
				elseif v111.Config.IsTwoHandedAbility and (v111.Ammo and (v111.Ammo > 0 and not v109)) then
					v109 = v111
				end
			end
		end
		v_u_51 = v109
		v_u_91:SetFocusAbility(v110)
		if v110 or (not v109 or v_u_52 == "twohanded") then
			if not v110 and (not v109 and v_u_52 ~= "twohanded") then
				v_u_33:set(false)
				v_u_52 = "none"
			end
		else
			v_u_74(v109)
			v_u_80()
		end
	end)
	v_u_59.WeaponEquipped:Connect(function(p112)
		-- upvalues: (ref) v_u_91, (ref) v_u_52
		if p112 and (p112.Config and p112.Config.IsTwoHandedAbility) then
			v_u_91:SetTwoHandedAbility(p112)
		elseif v_u_52 == "twohanded" then
			v_u_91:SetTwoHandedAbility(nil)
		end
	end)
	v_u_59.WeaponUnequipped:Connect(function()
		-- upvalues: (ref) v_u_52, (ref) v_u_91
		if v_u_52 == "twohanded" then
			v_u_91:SetTwoHandedAbility(nil)
		end
	end)
	v_u_59.AmmoChanged:Connect(function()
		-- upvalues: (ref) v_u_80
		v_u_80()
	end)
	v_u_1.common:WaitForChild("Remotes"):WaitForChild("Net").OnClientEvent:Connect(function(p113, p114)
		-- upvalues: (ref) v_u_42, (ref) v_u_52, (ref) v_u_80
		if p113 == "FocusMeter" then
			v_u_42:set(p114)
			if v_u_52 == "focus" then
				v_u_80()
			end
		end
	end)
end)
task.spawn(function()
	-- upvalues: (copy) v_u_9, (copy) v_u_4, (ref) v_u_52, (copy) v_u_91, (ref) v_u_56, (ref) v_u_57, (ref) v_u_48, (copy) v_u_8, (copy) v_u_28, (ref) v_u_50, (copy) v_u_80
	local v_u_115 = v_u_9.FocusEnabled
	local v_u_116 = false
	local v_u_117 = false
	v_u_4.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_9, (ref) v_u_115, (ref) v_u_52, (ref) v_u_91, (ref) v_u_56, (ref) v_u_57, (ref) v_u_48, (ref) v_u_116, (ref) v_u_8, (ref) v_u_28, (ref) v_u_50, (ref) v_u_117, (ref) v_u_80
		local v118 = v_u_9.FocusEnabled
		if v118 ~= v_u_115 then
			v_u_115 = v118
			if v_u_52 == "focus" then
				if v118 then
					v_u_91:SetActive(true)
				else
					v_u_91:SetActive(false)
				end
			elseif v_u_52 == "twohanded" and not v118 then
				v_u_56 = false
				v_u_57 = 0
			end
		end
		if v_u_48 and v_u_52 == "focus" then
			local v119 = v_u_48:IsActivating()
			if v119 ~= v_u_116 then
				v_u_116 = v119
				if v119 then
					v_u_91:StartActivating()
				elseif not v_u_8(v_u_28) then
					v_u_91:CancelActivating()
				end
			end
		end
		if v_u_50 and v_u_52 == "twohanded" then
			local v120 = v_u_50:IsActivating() or false
			if v120 ~= v_u_117 then
				v_u_117 = v120
				if v120 then
					v_u_91:StartActivating()
					return
				end
				v_u_91:CancelActivating()
				v_u_80()
			end
		end
	end)
end)
v_u_84()
task.spawn(function()
	-- upvalues: (copy) v_u_46, (ref) v_u_58, (copy) v_u_8, (copy) v_u_31, (copy) v_u_35
	local v121 = v_u_46:WaitForChild("PlayerGui"):WaitForChild("AmmoUI", 10)
	if v121 then
		v_u_58 = v121
		local v_u_122 = v121:FindFirstChild("Ammo")
		if v_u_122 then
			if v_u_8(v_u_31) then
				v_u_35:set(v_u_122.AbsoluteSize.X)
			end
			v_u_122:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				-- upvalues: (ref) v_u_8, (ref) v_u_31, (ref) v_u_35, (copy) v_u_122
				if v_u_8(v_u_31) then
					v_u_35:set(v_u_122.AbsoluteSize.X)
				end
			end)
		end
	end
end)
return v_u_91