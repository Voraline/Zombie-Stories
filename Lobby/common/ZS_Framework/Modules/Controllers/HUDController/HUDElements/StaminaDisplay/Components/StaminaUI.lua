local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Packages.Fusion).Children
local v_u_4 = require("../../../SharedComponents/WheelFrame")
local v_u_5 = require("../../../SharedComponents/CanvasFrame")
local v_u_6 = require("./ChargeAttackIndicator")
return function(p_u_7) -- name: StaminaUI
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6, (copy) v_u_2
	local v8 = p_u_7.scope
	local v_u_10 = v8:Spring(v8:Computed(function(p9)
		-- upvalues: (copy) p_u_7
		return (1 - p9(p_u_7.percentage)) * 360
	end), 25, 1)
	local v16 = v8:Spring(v8:Computed(function(p11)
		-- upvalues: (copy) p_u_7
		local v12 = p11(p_u_7.placement)
		local v13 = p11(p_u_7.isMobile)
		local v14 = p11(p_u_7.customPosition)
		local v15 = p11(p_u_7.dynamicStaminaEnabled)
		if v13 and v14 then
			return UDim2.fromScale(0.15, 0.15)
		elseif v13 and not v15 then
			return UDim2.fromScale(0.15, 0.15)
		elseif v12 == "center" then
			return UDim2.fromScale(0.1, 0.1)
		else
			return UDim2.fromScale(0.15, 0.15)
		end
	end), 10, 1)
	local v22 = v8:Spring(v8:Computed(function(p17)
		-- upvalues: (copy) p_u_7
		local v18 = p17(p_u_7.placement)
		local v19 = p17(p_u_7.isMobile)
		local v20 = p17(p_u_7.customPosition)
		local v21 = p17(p_u_7.dynamicStaminaEnabled)
		if v19 and v20 then
			return Vector2.new(0.5, 0.5)
		elseif v19 and not v21 then
			return Vector2.new(1, 0)
		elseif v18 == "center" then
			return Vector2.new(0, 0)
		elseif v19 then
			return Vector2.new(1, 0)
		else
			return Vector2.new(1, 1)
		end
	end), 8, 1)
	local v32 = v8:Spring(v8:Computed(function(p23)
		-- upvalues: (copy) p_u_7
		local v24 = p23(p_u_7.placement)
		local v25 = p23(p_u_7.isMobile)
		local v26 = p23(p_u_7.customPosition)
		local v27 = p23(p_u_7.dynamicStaminaEnabled)
		if v25 and v26 then
			if v27 then
				if v24 == "center" then
					return UDim2.new(0.5, 0, 0.5, 0)
				else
					return v26
				end
			else
				return v26
			end
		else
			if v25 and not v27 then
				local v28 = p23(p_u_7.objectiveListSizeY)
				local v29 = p23(p_u_7.ammoHudWidth)
				return UDim2.new(0.99, -v29, -0.02, 90 + v28)
			end
			if v24 == "center" then
				return UDim2.new(0.5, 0, 0.5, 0)
			end
			if not v25 then
				return UDim2.new(1, 0, 0.86, 0)
			end
			local v30 = p23(p_u_7.objectiveListSizeY)
			local v31 = p23(p_u_7.ammoHudWidth)
			return UDim2.new(0.99, -v31, -0.02, 90 + v30)
		end
	end), 8, 1)
	local v34 = v8:Computed(function(p33)
		-- upvalues: (copy) p_u_7
		return p33(p_u_7.decreaseStartTheta) < 180
	end)
	local v36 = v8:Computed(function(p35)
		-- upvalues: (copy) v_u_10
		return p35(v_u_10) >= 180
	end)
	local v39 = v8:Computed(function(p37)
		-- upvalues: (copy) p_u_7
		local v38 = p37(p_u_7.decreaseStartTheta)
		return math.min(v38, 270)
	end)
	local v42 = v8:Computed(function(p40)
		-- upvalues: (copy) p_u_7
		local v41 = p40(p_u_7.decreaseStartTheta)
		return math.max(v41, 179)
	end)
	local v50 = v8:Computed(function(p43)
		-- upvalues: (copy) p_u_7, (copy) v_u_10
		local v44 = p43(p_u_7.decreaseStartTheta)
		local v45 = p43(v_u_10)
		local v46 = v45 - v44
		local v47 = 180 - v44
		local v48 = math.min(v46, v47)
		local v49 = v45 > 180 and v44 > 170 and 90 or 0
		return math.max(v48, v49)
	end)
	local v55 = v8:Computed(function(p51)
		-- upvalues: (copy) p_u_7, (copy) v_u_10
		local v52 = p51(p_u_7.decreaseStartTheta)
		local v53 = p51(v_u_10) - math.max(v52, 179)
		local v54 = v52 >= 340 and 45 or 0
		return math.max(v53, v54)
	end)
	local v57 = v8:Computed(function(p56)
		-- upvalues: (copy) p_u_7
		return p56(p_u_7.requiredFlashActive)
	end)
	local v_u_59 = v8:Computed(function(p58)
		-- upvalues: (copy) p_u_7
		return (1 - p58(p_u_7.requiredAmount) / 100) * 360
	end)
	local v61 = v8:Computed(function(p60)
		-- upvalues: (copy) v_u_59
		return p60(v_u_59) < 180
	end)
	local v62 = v8:Computed(function(_)
		return true
	end)
	local v65 = v8:Computed(function(p63)
		-- upvalues: (copy) v_u_59
		local v64 = p63(v_u_59)
		return math.min(v64, 270)
	end)
	local v68 = v8:Computed(function(p66)
		-- upvalues: (copy) v_u_59
		local v67 = p66(v_u_59)
		return math.max(v67, 179)
	end)
	local v75 = v8:Computed(function(p69)
		-- upvalues: (copy) v_u_59
		local v70 = p69(v_u_59)
		local v71 = 360 - v70
		local v72 = 180 - v70
		local v73 = math.min(v71, v72)
		local v74 = v70 > 170 and 90 or 0
		return math.max(v73, v74)
	end)
	local v80 = v8:Computed(function(p76)
		-- upvalues: (copy) v_u_59
		local v77 = p76(v_u_59)
		local v78 = 360 - math.max(v77, 179)
		local v79 = v77 >= 340 and 45 or 0
		return math.max(v78, v79)
	end)
	local v_u_81 = v8:Spring(p_u_7.decreaseLeftTransparency, 12, 1)
	local v_u_82 = v8:Spring(p_u_7.decreaseRightTransparency, 12, 1)
	local v87 = v8:Computed(function(p83)
		-- upvalues: (copy) p_u_7, (copy) v_u_81, (copy) v_u_82
		local v84 = p83(p_u_7.isDecreasing)
		local v85 = p83(v_u_81)
		local v86 = p83(v_u_82)
		return v84 or (v85 < 0.99 and true or v86 < 0.99)
	end)
	local v88 = v8:Spring(p_u_7.requiredLeftTransparency, 8, 1)
	local v89 = v8:Spring(p_u_7.requiredRightTransparency, 8, 1)
	local v90 = v8:New("ImageLabel")({
		["Name"] = "BlueGlowImage",
		["BackgroundColor3"] = nil,
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = nil,
		["Image"] = "rbxassetid://12799025064",
		["ImageTransparency"] = 1,
		["Size"] = nil,
		["ZIndex"] = 2,
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Size"] = UDim2.fromScale(1, 1)
	})
	local v91 = v8:New("Frame")
	local v92 = {
		["Name"] = "MainFrame",
		["AnchorPoint"] = v22,
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Position"] = v32,
		["Size"] = v16,
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
	}
	local v93 = v_u_3
	local v94 = {}
	local v95 = v8:New("UIScale")({
		["Name"] = "UIScale",
		["Scale"] = nil,
		["Scale"] = p_u_7.uiScale
	})
	local v96 = v8:New("ImageLabel")({
		["Name"] = "MarkerImage",
		["BackgroundColor3"] = nil,
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = nil,
		["Image"] = "rbxassetid://12799024330",
		["ImageColor3"] = nil,
		["ImageTransparency"] = 0.5,
		["Size"] = nil,
		["ZIndex"] = 3,
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["ImageColor3"] = Color3.fromRGB(9, 39, 65),
		["Size"] = UDim2.fromScale(1, 1)
	})
	local v97 = v8:New("ImageLabel")({
		["Name"] = "WheelBackImage",
		["BackgroundColor3"] = nil,
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = nil,
		["Image"] = "rbxassetid://13676717187",
		["ImageColor3"] = nil,
		["ImageTransparency"] = 0.7,
		["Position"] = nil,
		["Size"] = nil,
		["ZIndex"] = 0,
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["ImageColor3"] = Color3.fromRGB(9, 39, 65),
		["Position"] = UDim2.fromOffset(1, 0),
		["Size"] = UDim2.new(1, -1, 1, 0)
	})
	local v98 = v_u_4({
		["scope"] = nil,
		["isLeft"] = true,
		["rotation"] = nil,
		["scope"] = v8,
		["rotation"] = v_u_10
	})
	local v99 = v_u_4({
		["scope"] = nil,
		["isLeft"] = false,
		["rotation"] = nil,
		["scope"] = v8,
		["rotation"] = v_u_10
	})
	local v100 = v8:New("Frame")
	local v101 = {
		["Name"] = "DecreaseFrame",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Size"] = UDim2.fromScale(1, 1),
		["Visible"] = v87,
		[v_u_3] = { v_u_5({
				["scope"] = nil,
				["isLeft"] = true,
				["visible"] = nil,
				["groupTransparency"] = nil,
				["groupColor3"] = nil,
				["rotation"] = nil,
				["gradientRotation"] = nil,
				["scope"] = v8,
				["visible"] = v36,
				["groupTransparency"] = v_u_81,
				["rotation"] = v42,
				["gradientRotation"] = v55
			}), v_u_5({
				["scope"] = nil,
				["isLeft"] = false,
				["visible"] = nil,
				["groupTransparency"] = nil,
				["groupColor3"] = nil,
				["rotation"] = nil,
				["gradientRotation"] = nil,
				["scope"] = v8,
				["visible"] = v34,
				["groupTransparency"] = v_u_82,
				["rotation"] = v39,
				["gradientRotation"] = v50
			}) }
	}
	local v102 = v100(v101)
	local v103 = v8:New("Frame")
	local v104 = {
		["Name"] = "RequiredFrame",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Size"] = UDim2.fromScale(1, 1),
		["Visible"] = v57,
		["ZIndex"] = 3,
		[v_u_3] = { v_u_5({
				["scope"] = nil,
				["isLeft"] = true,
				["visible"] = nil,
				["groupTransparency"] = nil,
				["groupColor3"] = nil,
				["rotation"] = nil,
				["gradientRotation"] = nil,
				["scope"] = v8,
				["visible"] = v62,
				["groupTransparency"] = v88,
				["groupColor3"] = Color3.fromRGB(255, 106, 106),
				["rotation"] = v68,
				["gradientRotation"] = v80
			}), v_u_5({
				["scope"] = nil,
				["isLeft"] = false,
				["visible"] = nil,
				["groupTransparency"] = nil,
				["groupColor3"] = nil,
				["rotation"] = nil,
				["gradientRotation"] = nil,
				["scope"] = v8,
				["visible"] = v61,
				["groupTransparency"] = v89,
				["groupColor3"] = Color3.fromRGB(255, 106, 106),
				["rotation"] = v65,
				["gradientRotation"] = v75
			}) }
	}
	__set_list(v94, 1, {v95, v96, v97, v98, v99, v90, v102, v103(v104), v8:New("TextLabel")({
	["Name"] = "StaminaLabel",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(0, 0, 0),
	["BorderSizePixel"] = 0,
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.4, 0.23),
	["Text"] = p_u_7.staminaText,
	["TextColor3"] = Color3.fromRGB(101, 206, 255),
	["TextScaled"] = true,
	["TextSize"] = 14,
	["TextWrapped"] = true,
	[v_u_3] = { v8:New("UIStroke")({
			["Name"] = "UIStroke",
			["Thickness"] = 3,
			["Transparency"] = 0.8
		}) }
}), v_u_6({
	["scope"] = v8,
	["showReady"] = p_u_7.showChargeReady
})})
	v92[v93] = v94
	local v105 = v91(v92)
	return {
		["screenGui"] = v8:New("ScreenGui")({
			["Name"] = "StaminaUI",
			["Parent"] = v_u_2.LocalPlayer:WaitForChild("PlayerGui"),
			["IgnoreGuiInset"] = true,
			["ResetOnSpawn"] = false,
			["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets,
			["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
			[v_u_3] = { v105 }
		}),
		["blueGlowImage"] = v90,
		["mainFrame"] = v105
	}
end