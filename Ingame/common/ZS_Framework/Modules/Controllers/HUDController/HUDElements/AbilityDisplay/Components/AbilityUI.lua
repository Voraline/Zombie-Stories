local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
game:GetService("TweenService")
local v_u_3 = require(v1.Packages.Fusion)
local v_u_4 = v_u_3.Children
local v_u_5 = require("../../../SharedComponents/WheelFrame")
require("../../../SharedComponents/CanvasFrame")
return function(p_u_6) -- name: AbilityUI
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3, (copy) v_u_2
	local v7 = p_u_6.scope
	local v_u_9 = v7:Computed(function(p8)
		-- upvalues: (copy) p_u_6
		if p8(p_u_6.isActive) then
			return p8(p_u_6.durationRemaining)
		else
			return p8(p_u_6.percentage)
		end
	end)
	local v11 = v7:Spring(v7:Computed(function(p10)
		-- upvalues: (copy) v_u_9
		return (1 - p10(v_u_9)) * 360
	end), 25, 1)
	local v13 = v7:Spring(v7:Computed(function(p12)
		-- upvalues: (copy) p_u_6
		if p12(p_u_6.isActive) then
			return Color3.fromRGB(180, 150, 255)
		else
			return Color3.fromRGB(101, 206, 255)
		end
	end), 15, 1)
	local v24 = v7:Spring(v7:Computed(function(p14)
		-- upvalues: (copy) p_u_6
		local v15 = p14(p_u_6.staminaPlacement)
		local v16 = p14(p_u_6.staminaFrameSize)
		local v17 = p14(p_u_6.isMobile)
		local v18 = p14(p_u_6.customPosition)
		if v17 and v18 then
			return v18
		end
		if v15 == "center" then
			if not v17 then
				return UDim2.new(1, 0, 0.86, 0)
			end
			local v19 = p14(p_u_6.objectiveListSizeY)
			local v20 = p14(p_u_6.ammoHudWidth)
			return UDim2.new(0.99, -v20, -0.02, 90 + v19)
		end
		local v21 = -(v16.X * 0.7 + 10)
		if not v17 then
			return UDim2.new(1, v21, 0.86, 0)
		end
		local v22 = p14(p_u_6.objectiveListSizeY)
		local v23 = p14(p_u_6.ammoHudWidth)
		return UDim2.new(0.99, -v23 + v21, -0.02, 90 + v22)
	end), 25, 1)
	local v28 = v7:Spring(v7:Computed(function(p25)
		-- upvalues: (copy) p_u_6
		local v26 = p25(p_u_6.staminaPlacement)
		local v27 = p25(p_u_6.isMobile)
		if v27 and p25(p_u_6.customPosition) then
			return Vector2.new(0.5, 0.5)
		elseif v26 == "center" then
			if v27 then
				return Vector2.new(1, 0)
			else
				return Vector2.new(1, 1)
			end
		elseif v27 then
			return Vector2.new(1, 0)
		else
			return Vector2.new(1, 1)
		end
	end), 25, 1)
	local v30 = v7:Spring(v7:Computed(function(p29)
		-- upvalues: (copy) p_u_6
		if p29(p_u_6.staminaPlacement) == "center" then
			return UDim2.fromScale(0.15, 0.15)
		else
			return UDim2.fromScale(0.15, 0.15)
		end
	end), 10, 1)
	local v35 = v7:Computed(function(p31)
		-- upvalues: (copy) p_u_6, (copy) v_u_9
		if p31(p_u_6.isReady) and not (p31(p_u_6.isActivating) or p31(p_u_6.isActive)) then
			return ""
		end
		if p_u_6.ammoCount then
			local v32 = p31(p_u_6.ammoCount)
			if v32 > 0 then
				return string.format("%d", v32)
			end
		end
		local v33 = string.format
		local v34 = p31(v_u_9) * 100
		return v33("%d", (math.ceil(v34)))
	end)
	local v_u_38 = v7:Computed(function(p36)
		-- upvalues: (copy) p_u_6
		local v37 = p36(p_u_6.isReady) and not p36(p_u_6.isActivating)
		if v37 then
			v37 = not p36(p_u_6.isActive)
		end
		return v37
	end)
	local v40 = v7:Spring(v7:Computed(function(p39)
		-- upvalues: (copy) v_u_38
		return p39(v_u_38) and 0 or 1
	end), 15, 1)
	local v41 = p_u_6.readyLabelText
	local v_u_43 = v7:Spring(v7:Computed(function(p42)
		-- upvalues: (copy) p_u_6
		return (1 - p42(p_u_6.activationProgress)) * 360
	end), 30, 1)
	local v45 = v7:Spring(v7:Computed(function(p44)
		-- upvalues: (copy) p_u_6
		return p44(p_u_6.isActivating) and 0 or 1
	end), 20, 1)
	local v46 = Color3.fromRGB(255, 200, 100)
	local v47 = v7:New("ImageLabel")({
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
	local v48 = v7:New("Frame")
	local v49 = {
		["Name"] = "MainFrame",
		["AnchorPoint"] = v28,
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Position"] = v24,
		["Size"] = v30,
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
	}
	local v50 = v_u_4
	local v51 = {}
	local v52 = v7:New("UIScale")({
		["Name"] = "UIScale",
		["Scale"] = nil,
		["Scale"] = p_u_6.uiScale
	})
	local v53 = v7:New("ImageLabel")({
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
	local v54 = v7:New("ImageLabel")({
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
	local v55 = v_u_5({
		["scope"] = nil,
		["isLeft"] = true,
		["rotation"] = nil,
		["wheelColor"] = nil,
		["scope"] = v7,
		["rotation"] = v11,
		["wheelColor"] = v13
	})
	local v56 = v_u_5({
		["scope"] = nil,
		["isLeft"] = false,
		["rotation"] = nil,
		["wheelColor"] = nil,
		["scope"] = v7,
		["rotation"] = v11,
		["wheelColor"] = v13
	})
	local v57 = v7:New("Frame")
	local v58 = {
		["Name"] = "ActivationLeftFrame",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["ClipsDescendants"] = true,
		["Position"] = UDim2.fromScale(0, 0),
		["Size"] = UDim2.fromScale(0.5, 1),
		["ZIndex"] = 2
	}
	local v59 = v_u_4
	local v60 = {}
	local v61 = v7:New("ImageLabel")
	local v64 = {
		["Name"] = "ActivationLeftWheel",
		["AnchorPoint"] = Vector2.new(0, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13676717187",
		["ImageColor3"] = v46,
		["ImageTransparency"] = v45,
		["Position"] = UDim2.fromScale(0, 0),
		["Size"] = UDim2.fromScale(2, 1),
		["ZIndex"] = 2,
		[v_u_4] = { v7:New("UIGradient")({
				["Name"] = "UIGradient",
				["Rotation"] = nil,
				["Transparency"] = nil,
				["Rotation"] = v7:Computed(function(p62)
					-- upvalues: (copy) v_u_43
					local v63 = v_u_43
					return math.max(180, p62(v63))
				end),
				["Transparency"] = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.5, 1),
					NumberSequenceKeypoint.new(0.501, 0),
					NumberSequenceKeypoint.new(1, 0)
				})
			}) }
	}
	__set_list(v60, 1, {v61(v64)})
	v58[v59] = v60
	local v65 = v57(v58)
	local v66 = v7:New("Frame")
	local v67 = {
		["Name"] = "ActivationRightFrame",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["ClipsDescendants"] = true,
		["Position"] = UDim2.fromScale(0.5, 0),
		["Size"] = UDim2.fromScale(0.5, 1),
		["ZIndex"] = 2
	}
	local v68 = v_u_4
	local v69 = {}
	local v70 = v7:New("ImageLabel")
	local v73 = {
		["Name"] = "ActivationRightWheel",
		["AnchorPoint"] = Vector2.new(1, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13676717187",
		["ImageColor3"] = v46,
		["ImageTransparency"] = v45,
		["Position"] = UDim2.fromScale(1, 0),
		["Size"] = UDim2.fromScale(2, 1),
		["ZIndex"] = 2,
		[v_u_4] = { v7:New("UIGradient")({
				["Name"] = "UIGradient",
				["Rotation"] = nil,
				["Transparency"] = nil,
				["Rotation"] = v7:Computed(function(p71)
					-- upvalues: (copy) v_u_43
					local v72 = v_u_43
					return math.min(180, p71(v72))
				end),
				["Transparency"] = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.5, 1),
					NumberSequenceKeypoint.new(0.501, 0),
					NumberSequenceKeypoint.new(1, 0)
				})
			}) }
	}
	__set_list(v69, 1, {v70(v73)})
	v67[v68] = v69
	local v74 = v66(v67)
	local v75 = v7:New("ImageLabel")({
		["Name"] = "AbilityIcon",
		["AnchorPoint"] = nil,
		["BackgroundColor3"] = nil,
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = nil,
		["BorderSizePixel"] = 0,
		["Image"] = nil,
		["ImageColor3"] = nil,
		["Position"] = nil,
		["Size"] = nil,
		["ZIndex"] = 3,
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["Image"] = p_u_6.abilityImage,
		["ImageColor3"] = Color3.fromRGB(101, 206, 255),
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.7, 0.7)
	})
	local v76 = v7:New("TextLabel")({
		["Name"] = "PercentageLabel",
		["AnchorPoint"] = Vector2.new(0.5, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["BorderSizePixel"] = 0,
		["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
		["Position"] = UDim2.fromScale(0.5, 0.65),
		["Size"] = UDim2.fromScale(0.4, 0.18),
		["Text"] = v35,
		["TextColor3"] = Color3.fromRGB(101, 206, 255),
		["TextScaled"] = true,
		["TextSize"] = 14,
		["TextWrapped"] = true,
		["ZIndex"] = 4,
		[v_u_4] = { v7:New("UIStroke")({
				["Name"] = "UIStroke",
				["Thickness"] = 2,
				["Transparency"] = 0.8
			}) }
	})
	local v77 = v7:New("TextLabel")
	local v78 = {
		["Name"] = "ReadyLabel",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["BorderSizePixel"] = 0,
		["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold),
		["Position"] = UDim2.fromScale(0.5, 0.78),
		["Size"] = UDim2.fromScale(0.8, 0.15),
		["Text"] = v41,
		["TextColor3"] = Color3.fromRGB(150, 255, 150),
		["TextScaled"] = true,
		["TextSize"] = 14,
		["TextTransparency"] = v40,
		["TextWrapped"] = true,
		["ZIndex"] = 4,
		[v_u_4] = { v7:New("UIStroke")({
				["Name"] = "UIStroke",
				["Thickness"] = 2,
				["Transparency"] = nil,
				["Transparency"] = v40
			}) }
	}
	__set_list(v51, 1, {v52, v53, v54, v55, v56, v47, v65, v74, v75, v76, v77(v78), v7:New("TextButton")({
	["Name"] = "TouchActivateButton",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["BorderSizePixel"] = 0,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(1, 1),
	["Text"] = "",
	["ZIndex"] = 10,
	["Visible"] = p_u_6.isMobile,
	["Active"] = p_u_6.isMobile,
	[v_u_3.OnEvent("Activated")] = function()
		-- upvalues: (copy) p_u_6
		if p_u_6.onActivatePressed then
			p_u_6.onActivatePressed()
		end
	end
})})
	v49[v50] = v51
	local v79 = v48(v49)
	return {
		["screenGui"] = v7:New("ScreenGui")({
			["Name"] = "AbilityUI",
			["Parent"] = v_u_2.LocalPlayer:WaitForChild("PlayerGui"),
			["IgnoreGuiInset"] = true,
			["ResetOnSpawn"] = false,
			["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets,
			["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
			["Enabled"] = p_u_6.visible,
			[v_u_4] = { v79 }
		}),
		["blueGlowImage"] = v47,
		["mainFrame"] = v79
	}
end