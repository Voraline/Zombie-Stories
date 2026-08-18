local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = game:GetService("TweenService")
local v4 = require(v1.Packages.Fusion)
local v5 = v4.scoped
local v_u_6 = v4.peek
require("@game/ReplicatedStorage/common/HUDService")
local v7 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
local v_u_8 = require("@game/ReplicatedStorage/common/BindUtil")
local v9 = require("./Objectives")
local v10 = require("@game/ReplicatedStorage/common/Signal")
local v11 = require("@self/Components/StaminaUI")
local v12 = v5(v4)
local v_u_13 = v12:Value(1)
local v_u_14 = v12:Value("side")
local v_u_15 = v12:Value(false)
local v_u_16 = v12:Value(false)
local v_u_17 = v12:Value(0)
local v_u_18 = v12:Value(false)
local v_u_19 = v12:Value(false)
local v_u_20 = v12:Value(0)
local v_u_21 = v12:Value("100")
local v_u_22 = v12:Value(0)
local v_u_23 = v12:Value(0)
local v_u_24 = v12:Value(1)
local v_u_25 = v12:Value(1)
local v_u_26 = v12:Value(1)
local v_u_27 = v12:Value(1)
local v_u_28 = v12:Value(true)
local v_u_29 = v12:Value(nil)
local v_u_30 = v12:Value(true)
local v_u_31 = v12:Value(1)
local v_u_32 = v2.LocalPlayer
local v_u_33 = 100
local v_u_34 = os.clock()
local v_u_35 = nil
local v36 = v11({
	["scope"] = v12,
	["percentage"] = v_u_13,
	["placement"] = v_u_14,
	["isMobile"] = v_u_15,
	["isDecreasing"] = v_u_16,
	["decreaseStartTheta"] = v_u_17,
	["showChargeReady"] = v_u_18,
	["requiredFlashActive"] = v_u_19,
	["requiredAmount"] = v_u_20,
	["staminaText"] = v_u_21,
	["objectiveListSizeY"] = v_u_22,
	["decreaseLeftTransparency"] = v_u_24,
	["decreaseRightTransparency"] = v_u_25,
	["requiredLeftTransparency"] = v_u_26,
	["requiredRightTransparency"] = v_u_27,
	["ammoHudWidth"] = v_u_23,
	["customPosition"] = v_u_29,
	["dynamicStaminaEnabled"] = v_u_30,
	["uiScale"] = v_u_31
})
local v_u_37 = v36.screenGui
local v38 = v36.blueGlowImage
local v_u_39 = v36.mainFrame
v12:Observer(v_u_28):onChange(function()
	-- upvalues: (copy) v_u_37, (copy) v_u_6, (copy) v_u_28
	v_u_37.Enabled = v_u_6(v_u_28)
end)
local v_u_40 = Instance.new("Sound")
v_u_40.Name = "readyCharge"
v_u_40.SoundId = "rbxassetid://9039999622"
v_u_40.Parent = v_u_37
local v41 = TweenInfo.new(0.01, Enum.EasingStyle.Linear)
local v42 = TweenInfo.new(0.4, Enum.EasingStyle.Linear)
local v_u_43 = v3:Create(v38, v41, {
	["ImageTransparency"] = 0
})
local v_u_44 = v3:Create(v38, v42, {
	["ImageTransparency"] = 1
})
v_u_43.Completed:Connect(function()
	-- upvalues: (copy) v_u_44
	v_u_44:Play()
end)
local function v_u_48(p45) -- name: setPercentage
	-- upvalues: (copy) v_u_6, (copy) v_u_13, (copy) v_u_16, (copy) v_u_17, (copy) v_u_24, (copy) v_u_25, (copy) v_u_43
	local v46 = math.clamp(p45, 0, 1)
	local v47 = v_u_6(v_u_13)
	if v46 < v47 and not v_u_6(v_u_16) then
		v_u_16:set(true)
		v_u_17:set((1 - v47) * 360)
		v_u_24:set(0)
		v_u_25:set(0)
	elseif v47 < v46 then
		if v46 == 1 then
			v_u_43:Play()
		end
		if v_u_6(v_u_16) then
			v_u_16:set(false)
			v_u_24:set(1)
			v_u_25:set(1)
		end
	end
	v_u_13:set(v46)
end
local function v_u_51() -- name: updateMobilePlacement
	-- upvalues: (copy) v_u_8, (copy) v_u_15, (ref) v_u_35, (copy) v_u_32, (copy) v_u_23
	if v_u_8.getInputMethod() == "Touch" then
		v_u_15:set(true)
		local v49 = not v_u_35 and v_u_32:FindFirstChild("PlayerGui")
		if v49 then
			v_u_35 = v49:FindFirstChild("AmmoUI")
		end
		local v50 = v_u_35 and v_u_35:FindFirstChild("Ammo")
		if v50 then
			v_u_23:set(v50.AbsoluteSize.X)
			return
		end
	else
		v_u_15:set(false)
	end
end
local v_u_60 = {
	["IsShowing"] = true,
	["PlacementChanged"] = v10.new(),
	["Show"] = function(_) -- name: Show
		-- upvalues: (copy) v_u_28, (copy) v_u_60
		v_u_28:set(true)
		v_u_60.IsShowing = true
	end,
	["Hide"] = function(_) -- name: Hide
		-- upvalues: (copy) v_u_28, (copy) v_u_60
		v_u_28:set(false)
		v_u_60.IsShowing = false
	end,
	["SetPercentage"] = function(_, p52) -- name: SetPercentage
		-- upvalues: (copy) v_u_48
		v_u_48(p52)
	end,
	["SetPlacement"] = function(_, p53) -- name: SetPlacement
		-- upvalues: (copy) v_u_6, (copy) v_u_14, (copy) v_u_60
		local v54 = p53 and "center" or "side"
		local v55 = v_u_6(v_u_14)
		v_u_14:set(v54)
		if v54 ~= v55 then
			v_u_60.PlacementChanged:Fire(v54)
		end
	end,
	["GetPlacement"] = function(_) -- name: GetPlacement
		-- upvalues: (copy) v_u_6, (copy) v_u_14
		return v_u_6(v_u_14)
	end,
	["GetMainFrame"] = function(_) -- name: GetMainFrame
		-- upvalues: (copy) v_u_39
		return v_u_39
	end,
	["SetCustomPosition"] = function(_, p56) -- name: SetCustomPosition
		-- upvalues: (copy) v_u_29
		v_u_29:set(p56)
	end,
	["SetDynamicStaminaEnabled"] = function(_, p57) -- name: SetDynamicStaminaEnabled
		-- upvalues: (copy) v_u_30
		v_u_30:set(p57)
	end,
	["SetUIScale"] = function(_, p58) -- name: SetUIScale
		-- upvalues: (copy) v_u_31
		v_u_31:set(p58)
	end,
	["MobileActivated"] = function(_) -- name: MobileActivated
		-- upvalues: (copy) v_u_15, (copy) v_u_60, (copy) v_u_6, (copy) v_u_14
		v_u_15:set(true)
		v_u_60:SetPlacement(v_u_6(v_u_14) == "center")
	end,
	["MobileDeactivated"] = function(_) -- name: MobileDeactivated
		-- upvalues: (copy) v_u_15
		v_u_15:set(false)
	end,
	["ChargeReady"] = function(_) -- name: ChargeReady
		-- upvalues: (copy) v_u_40, (copy) v_u_18
		v_u_40:Play()
		v_u_18:set(true)
	end,
	["ChargeNotReady"] = function(_) -- name: ChargeNotReady
		-- upvalues: (copy) v_u_18
		v_u_18:set(false)
	end,
	["FlashRequired"] = function(_, p59) -- name: FlashRequired
		-- upvalues: (ref) v_u_34, (copy) v_u_20, (copy) v_u_19, (copy) v_u_26, (copy) v_u_27
		if v_u_34 < os.clock() then
			v_u_34 = os.clock() + 3
			v_u_20:set(p59)
			v_u_19:set(true)
			v_u_26:set(1)
			v_u_27:set(1)
			task.delay(0.01, function()
				-- upvalues: (ref) v_u_26, (ref) v_u_27
				v_u_26:set(0)
				v_u_27:set(0)
			end)
			task.delay(0.5, function()
				-- upvalues: (ref) v_u_26, (ref) v_u_27, (ref) v_u_19
				v_u_26:set(1)
				v_u_27:set(1)
				task.delay(0.25, function()
					-- upvalues: (ref) v_u_26, (ref) v_u_27, (ref) v_u_19
					v_u_26:set(0)
					v_u_27:set(0)
					task.delay(0.5, function()
						-- upvalues: (ref) v_u_26, (ref) v_u_27, (ref) v_u_19
						v_u_26:set(1)
						v_u_27:set(1)
						task.delay(0.25, function()
							-- upvalues: (ref) v_u_19
							v_u_19:set(false)
						end)
					end)
				end)
			end)
		end
	end
}
v7.StaminaChanged:Connect(function(p61)
	-- upvalues: (copy) v_u_32, (copy) v_u_60, (ref) v_u_33, (copy) v_u_21
	v_u_60:SetPercentage(p61 / (100 * (v_u_32:GetAttribute("Skill_StaminaMaxMult") or 1)))
	v_u_33 = p61 or v_u_33
	local v62 = v_u_33
	v_u_21:set(string.format("%d", (math.ceil(v62))))
end)
v_u_32:GetAttributeChangedSignal("Skill_StaminaMaxMult"):Connect(function()
	-- upvalues: (ref) v_u_33, (copy) v_u_21, (copy) v_u_60, (copy) v_u_32
	v_u_33 = v_u_33
	local v63 = v_u_33
	v_u_21:set(string.format("%d", (math.ceil(v63))))
	v_u_60:SetPercentage(v_u_33 / (100 * (v_u_32:GetAttribute("Skill_StaminaMaxMult") or 1)))
end)
v_u_8.InputMethodChanged:Connect(function(_)
	-- upvalues: (copy) v_u_51
	v_u_51()
end)
local v_u_64 = v9:GetGuiList()
v_u_64:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	-- upvalues: (copy) v_u_6, (copy) v_u_15, (copy) v_u_22, (copy) v_u_64
	if v_u_6(v_u_15) then
		v_u_22:set(v_u_64.AbsoluteSize.Y)
	end
end)
v_u_33 = v_u_33
local v65 = v_u_33
v_u_21:set(string.format("%d", (math.ceil(v65))))
v_u_51()
task.spawn(function()
	-- upvalues: (copy) v_u_32, (ref) v_u_35, (copy) v_u_6, (copy) v_u_15, (copy) v_u_23
	local v66 = v_u_32:WaitForChild("PlayerGui"):WaitForChild("AmmoUI", 10)
	if v66 then
		v_u_35 = v66
		local v_u_67 = v66:FindFirstChild("Ammo")
		if v_u_67 then
			if v_u_6(v_u_15) then
				v_u_23:set(v_u_67.AbsoluteSize.X)
			end
			v_u_67:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				-- upvalues: (ref) v_u_6, (ref) v_u_15, (ref) v_u_23, (copy) v_u_67
				if v_u_6(v_u_15) then
					v_u_23:set(v_u_67.AbsoluteSize.X)
				end
			end)
		end
	end
end)
return v_u_60