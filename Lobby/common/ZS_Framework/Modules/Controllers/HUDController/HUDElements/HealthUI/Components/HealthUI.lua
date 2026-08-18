local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.Packages.Fusion).Children
return function(p_u_4) -- name: HealthUI
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = p_u_4.scope
	local v8 = v5:Computed(function(p6)
		-- upvalues: (copy) p_u_4
		local v7 = (1 - p6(p_u_4.healthPercentage)) * 360
		return math.max(v7, 180)
	end)
	local v11 = v5:Computed(function(p9)
		-- upvalues: (copy) p_u_4
		local v10 = (1 - p9(p_u_4.healthPercentage)) * 360
		return math.min(v10, 180)
	end)
	local v13 = v5:Computed(function(p12)
		-- upvalues: (copy) p_u_4
		return (1 - p12(p_u_4.healthPercentage)) * 360 ~= 360
	end)
	local v15 = v5:Computed(function(p14)
		-- upvalues: (copy) p_u_4
		return (1 - p14(p_u_4.healthPercentage)) * 360 ~= 360
	end)
	local v18 = v5:Computed(function(p16)
		-- upvalues: (copy) p_u_4
		local v17 = (1 - p16(p_u_4.shieldPercentage)) * 360
		return math.max(v17, 180)
	end)
	local v21 = v5:Computed(function(p19)
		-- upvalues: (copy) p_u_4
		local v20 = (1 - p19(p_u_4.shieldPercentage)) * 360
		return math.min(v20, 180)
	end)
	local v24 = v5:Computed(function(p22)
		-- upvalues: (copy) p_u_4
		local v23
		if (1 - p22(p_u_4.shieldPercentage)) * 360 == 360 then
			v23 = false
		else
			v23 = p22(p_u_4.shieldVisible)
		end
		return v23
	end)
	local v27 = v5:Computed(function(p25)
		-- upvalues: (copy) p_u_4
		local v26
		if (1 - p25(p_u_4.shieldPercentage)) * 360 == 360 then
			v26 = false
		else
			v26 = p25(p_u_4.shieldVisible)
		end
		return v26
	end)
	local v28 = v5:New("UIGradient")({
		["Name"] = "UIGradient",
		["Rotation"] = nil,
		["Transparency"] = nil,
		["Rotation"] = v8,
		["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.499, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 0)
		})
	})
	local v29 = v5:New("UIGradient")({
		["Name"] = "UIGradient",
		["Rotation"] = nil,
		["Transparency"] = nil,
		["Rotation"] = v11,
		["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.499, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 0)
		})
	})
	local v30 = v5:New("ImageLabel")({
		["Name"] = "ImageLabel",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13665860902",
		["ImageColor3"] = p_u_4.healthColor,
		["Size"] = UDim2.fromScale(2, 1),
		["Visible"] = v13,
		[v_u_3] = { v28 }
	})
	local v31 = v5:New("ImageLabel")({
		["Name"] = "ImageLabel",
		["AnchorPoint"] = Vector2.new(1, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13665860902",
		["ImageColor3"] = p_u_4.healthColor,
		["Position"] = UDim2.fromScale(1, 0),
		["Size"] = UDim2.fromScale(2, 1),
		["Visible"] = v15,
		[v_u_3] = { v29 }
	})
	local v32 = v5:New("UIGradient")({
		["Name"] = "UIGradient",
		["Rotation"] = nil,
		["Transparency"] = nil,
		["Rotation"] = v18,
		["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.499, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 0)
		})
	})
	local v33 = v5:New("UIGradient")({
		["Name"] = "UIGradient",
		["Rotation"] = nil,
		["Transparency"] = nil,
		["Rotation"] = v21,
		["Transparency"] = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.499, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 0)
		})
	})
	local v34 = Color3.fromRGB(100, 180, 255)
	local v36 = v5:Spring(v5:Computed(function(p35)
		-- upvalues: (copy) p_u_4
		if p35(p_u_4.shieldBroken) then
			return Color3.fromRGB(255, 0, 0)
		else
			return Color3.fromRGB(0, 0, 0)
		end
	end), 8)
	local v38 = v5:Computed(function(p37)
		-- upvalues: (copy) p_u_4
		return p37(p_u_4.shieldVisible)
	end)
	local v39 = v5:New("ImageLabel")({
		["Name"] = "ShieldBackground",
		["AnchorPoint"] = nil,
		["BackgroundTransparency"] = 1,
		["Image"] = "rbxassetid://13665860902",
		["ImageColor3"] = nil,
		["ImageTransparency"] = nil,
		["Position"] = nil,
		["Size"] = nil,
		["Visible"] = nil,
		["ZIndex"] = 0,
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["ImageColor3"] = v36,
		["ImageTransparency"] = p_u_4.shieldBgTransparency,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(1, 1),
		["Visible"] = v38
	})
	local v40 = v5:New("ImageLabel")({
		["Name"] = "ShieldLeft",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13665860902",
		["ImageColor3"] = v34,
		["Size"] = UDim2.fromScale(2, 1),
		["Visible"] = v24,
		[v_u_3] = { v32 }
	})
	local v41 = v5:New("ImageLabel")({
		["Name"] = "ShieldRight",
		["AnchorPoint"] = Vector2.new(1, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13665860902",
		["ImageColor3"] = v34,
		["Position"] = UDim2.fromScale(1, 0),
		["Size"] = UDim2.fromScale(2, 1),
		["Visible"] = v27,
		[v_u_3] = { v33 }
	})
	local v42 = v5:New("ImageLabel")
	local v43 = {
		["Name"] = "OverLine",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13665853889",
		["Size"] = UDim2.fromScale(1, 1),
		["ZIndex"] = 5,
		[v_u_3] = { v5:New("UIGradient")({
				["Name"] = "UIGradient",
				["Transparency"] = nil,
				["Transparency"] = p_u_4.overlineTransparency
			}), v5:New("UICorner")({
				["Name"] = "UICorner",
				["CornerRadius"] = nil,
				["CornerRadius"] = UDim.new(1, 0)
			}) }
	}
	local v44 = v42(v43)
	local v45 = v5:New("ImageLabel")
	local v46 = {
		["Name"] = "UnderLine",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Image"] = "rbxassetid://13665853284",
		["ImageColor3"] = p_u_4.healthColor,
		["Size"] = UDim2.fromScale(1, 1),
		["ZIndex"] = 4,
		[v_u_3] = { v5:New("UIGradient")({
				["Name"] = "UIGradient",
				["Transparency"] = nil,
				["Transparency"] = p_u_4.underlineTransparency
			}), v5:New("UICorner")({
				["Name"] = "UICorner",
				["CornerRadius"] = nil,
				["CornerRadius"] = UDim.new(1, 0)
			}) }
	}
	local v47 = v45(v46)
	local v48 = v5:New("TextLabel")({
		["Name"] = "HealthLabel",
		["AnchorPoint"] = Vector2.new(0.5, 1),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		["Position"] = UDim2.fromScale(0.5, 0.9),
		["Size"] = UDim2.fromScale(0.4, 0.2),
		["Text"] = p_u_4.healthText,
		["TextColor3"] = p_u_4.healthColor,
		["TextScaled"] = true,
		["TextSize"] = 14,
		["TextWrapped"] = true,
		["ZIndex"] = 4,
		[v_u_3] = { v5:New("UIStroke")({
				["Name"] = "UIStroke",
				["Thickness"] = 3,
				["Transparency"] = 0.8
			}) }
	})
	local v51 = v5:Computed(function(p49)
		-- upvalues: (copy) p_u_4
		local v50 = p49(p_u_4.shieldPercentage)
		return UDim2.new(v50, 0, 1, 0)
	end)
	local v52 = v5:Computed(function(_)
		return false
	end)
	local v53 = v5:New("Frame")
	local v54 = {
		["Name"] = "ShieldBar",
		["AnchorPoint"] = Vector2.new(0.5, 1),
		["BackgroundColor3"] = Color3.fromRGB(30, 30, 30),
		["BackgroundTransparency"] = 0.5,
		["Position"] = UDim2.new(0.5, 0, -0.05, 0),
		["Size"] = UDim2.new(0.8, 0, 0.08, 0),
		["Visible"] = v52,
		["ZIndex"] = 10
	}
	local v55 = v_u_3
	local v56 = {}
	local v57 = v5:New("UICorner")({
		["Name"] = "UICorner",
		["CornerRadius"] = nil,
		["CornerRadius"] = UDim.new(0.5, 0)
	})
	local v58 = v5:New("Frame")
	local v59 = {
		["Name"] = "ShieldFill",
		["BackgroundColor3"] = Color3.fromRGB(100, 180, 255),
		["Size"] = v51,
		["ZIndex"] = 11,
		[v_u_3] = { v5:New("UICorner")({
				["Name"] = "UICorner",
				["CornerRadius"] = nil,
				["CornerRadius"] = UDim.new(0.5, 0)
			}), v5:New("UIGradient")({
				["Name"] = "UIGradient",
				["Color"] = nil,
				["Rotation"] = 90,
				["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 160, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 200, 255)) })
			}) }
	}
	__set_list(v56, 1, {v57, v58(v59)})
	v54[v55] = v56
	local v60 = v53(v54)
	local v61 = v5:New("ViewportFrame")
	local v62 = {
		["Name"] = "PlayerFrame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = p_u_4.playerFrameColor,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.8, 0.8),
		["ZIndex"] = 3,
		["Ambient"] = Color3.fromRGB(200, 200, 200),
		["LightColor"] = Color3.fromRGB(140, 140, 140),
		["LightDirection"] = Vector3.new(-1, -1, -1),
		[v_u_3] = { v5:New("UICorner")({
				["Name"] = "UICorner",
				["CornerRadius"] = nil,
				["CornerRadius"] = UDim.new(1, 0)
			}) }
	}
	local v63 = v61(v62)
	local v64 = v5:New("Frame")
	local v65 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0, 1),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Position"] = UDim2.fromScale(0.01, 0.99),
		["Size"] = UDim2.fromScale(0.15, 0.15),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
	}
	local v66 = v_u_3
	local v67 = {}
	local v68 = v5:New("Frame")
	local v69 = {
		["Name"] = "HealthCircle",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Size"] = UDim2.fromScale(1, 1),
		["ZIndex"] = 2,
		[v_u_3] = { v5:New("Frame")({
				["Name"] = "LeftFrame",
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["ClipsDescendants"] = true,
				["Size"] = UDim2.fromScale(0.5, 1),
				["ZIndex"] = 2,
				[v_u_3] = { v30 }
			}), v5:New("Frame")({
				["Name"] = "RightFrame",
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["ClipsDescendants"] = true,
				["Position"] = UDim2.fromScale(0.5, 0),
				["Size"] = UDim2.fromScale(0.5, 1),
				["ZIndex"] = 2,
				[v_u_3] = { v31 }
			}) }
	}
	local v70 = v68(v69)
	local v71 = v5:New("Frame")
	local v72 = {
		["Name"] = "ShieldCircle",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(1.05, 1.05),
		["ZIndex"] = 1,
		[v_u_3] = { v39, v5:New("Frame")({
				["Name"] = "ShieldLeftFrame",
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["ClipsDescendants"] = true,
				["Size"] = UDim2.fromScale(0.5, 1),
				["ZIndex"] = 1,
				[v_u_3] = { v40 }
			}), v5:New("Frame")({
				["Name"] = "ShieldRightFrame",
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["ClipsDescendants"] = true,
				["Position"] = UDim2.fromScale(0.5, 0),
				["Size"] = UDim2.fromScale(0.5, 1),
				["ZIndex"] = 1,
				[v_u_3] = { v41 }
			}) }
	}
	__set_list(v67, 1, {v63, v70, v71(v72), v5:New("Frame")({
	["Name"] = "ECG",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["ClipsDescendants"] = true,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.8, 0.8),
	["ZIndex"] = 5,
	[v_u_3] = { v44, v47 }
}), v48, v60})
	v65[v66] = v67
	local v73 = v64(v65)
	return {
		["screenGui"] = v5:New("ScreenGui")({
			["Name"] = "HealthUI",
			["Parent"] = v_u_2.LocalPlayer:WaitForChild("PlayerGui"),
			["ResetOnSpawn"] = false,
			["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
			[v_u_3] = { v73 }
		}),
		["mainFrame"] = v73,
		["playerFrame"] = v63,
		["healthLabel"] = v48,
		["leftCircleGradient"] = v28,
		["rightCircleGradient"] = v29,
		["leftCircleImage"] = v30,
		["rightCircleImage"] = v31,
		["underLine"] = v47,
		["overLine"] = v44,
		["shieldBar"] = v60
	}
end