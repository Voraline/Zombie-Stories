local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion).Children
local v_u_3 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p4, p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v6 = p4:New("ScreenGui")
	local v7 = {
		["Name"] = "SettingsGui",
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
	}
	local v8 = v_u_2
	local v9 = {}
	local v10 = p4:New("Frame")
	local v11 = {
		["Name"] = "Panel",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(17, 37, 63),
		["BackgroundTransparency"] = p5 and 0 or 0.1,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(1.2, 0.78),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
	}
	local v12 = v_u_2
	local v13 = {}
	local v14 = p4:New("UICorner")({
		["CornerRadius"] = UDim.new(0.015, 0)
	})
	local v15 = p4:New("Frame")({
		["Name"] = "Background",
		["BackgroundColor3"] = nil,
		["BorderSizePixel"] = 0,
		["Size"] = nil,
		["SizeConstraint"] = nil,
		["Visible"] = false,
		["ZIndex"] = 0,
		["BackgroundColor3"] = Color3.fromRGB(14, 33, 50),
		["Size"] = UDim2.fromScale(1.538, 1),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
	})
	local v16 = p4:New("Frame")
	local v17 = {
		["Name"] = "Header",
		["BackgroundTransparency"] = 1,
		["Size"] = UDim2.fromScale(1, 0.065),
		[v_u_2] = { p4:New("UICorner")({
				["CornerRadius"] = UDim.new(0.3, 0)
			}), p4:New("TextLabel")({
				["Name"] = "TextLabel",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["FontFace"] = nil,
				["Position"] = nil,
				["Size"] = nil,
				["Text"] = "SETTINGS",
				["TextColor3"] = nil,
				["TextScaled"] = true,
				["AnchorPoint"] = Vector2.new(1, 0),
				["FontFace"] = v_u_3,
				["Position"] = UDim2.fromScale(0.99, 0),
				["Size"] = UDim2.fromScale(0.15, 1),
				["TextColor3"] = Color3.fromRGB(255, 184, 84)
			}), p4:New("TextButton")({
				["Name"] = "Exit",
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["BackgroundColor3"] = Color3.fromRGB(255, 73, 73),
				["Position"] = UDim2.fromScale(1, -0.15),
				["Size"] = UDim2.fromScale(1, 1),
				["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
				["AutoButtonColor"] = false,
				["Text"] = "",
				[v_u_2] = { p4:New("UICorner")({
						["CornerRadius"] = UDim.new(0.2, 0)
					}), p4:New("Frame")({
						["Name"] = "Fill",
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["BackgroundColor3"] = Color3.fromRGB(49, 49, 49),
						["Position"] = UDim2.fromScale(0.5, 0.5),
						["Size"] = UDim2.fromScale(0.8, 0.8),
						[v_u_2] = { p4:New("UICorner")({
								["CornerRadius"] = UDim.new(0.2, 0)
							}) }
					}), p4:New("TextLabel")({
						["Name"] = "Label",
						["AnchorPoint"] = nil,
						["BackgroundTransparency"] = 1,
						["FontFace"] = nil,
						["Text"] = "X",
						["TextColor3"] = nil,
						["TextScaled"] = true,
						["Position"] = nil,
						["Size"] = nil,
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["FontFace"] = v_u_3,
						["TextColor3"] = Color3.fromRGB(255, 73, 73),
						["Position"] = UDim2.fromScale(0.5, 0.5),
						["Size"] = UDim2.fromScale(1, 1)
					}) }
			}) }
	}
	local v18 = v16(v17)
	local v19 = p4:New("Frame")({
		["Name"] = "Container",
		["AnchorPoint"] = Vector2.new(1, 1),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.fromScale(0.995, 1),
		["Size"] = UDim2.fromScale(0.695, 0.945),
		[v_u_2] = { p4:New("UICorner")({
				["CornerRadius"] = UDim.new(0.016, 0)
			}) }
	})
	local v20 = p4:New("Frame")
	local v21 = {
		["Name"] = "Tabs",
		["AnchorPoint"] = Vector2.new(0, 1),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.fromScale(0, 1),
		["Size"] = UDim2.fromScale(0.296, 1),
		[v_u_2] = { p4:New("UICorner")({
				["CornerRadius"] = UDim.new(0.035, 0)
			}), p4:New("ScrollingFrame")({
				["Name"] = "Frame",
				["AutomaticCanvasSize"] = Enum.AutomaticSize.Y,
				["BackgroundTransparency"] = 1,
				["CanvasSize"] = UDim2.new(),
				["ScrollBarImageColor3"] = Color3.fromRGB(16, 16, 16),
				["ScrollBarThickness"] = 0,
				["ScrollingDirection"] = Enum.ScrollingDirection.Y,
				["Selectable"] = false,
				["Size"] = UDim2.fromScale(1, 1),
				[v_u_2] = { p4:New("UIListLayout")({
						["SortOrder"] = Enum.SortOrder.LayoutOrder
					}) }
			}), p4:New("Frame")({
				["Name"] = "Background",
				["BackgroundTransparency"] = 1,
				["ClipsDescendants"] = true,
				["Size"] = UDim2.fromScale(1, 1),
				["ZIndex"] = 0,
				[v_u_2] = { p4:New("Frame")({
						["Name"] = "CurvedFrame",
						["BackgroundColor3"] = Color3.new(),
						["BackgroundTransparency"] = 0.9,
						["Size"] = UDim2.fromScale(1.2, 1),
						[v_u_2] = { p4:New("UICorner")({
								["CornerRadius"] = UDim.new(0.028, 0)
							}) }
					}) }
			}) }
	}
	__set_list(v13, 1, {v14, v15, v18, v19, v20(v21), p4:New("UIGradient")({
	["Color"] = nil,
	["Rotation"] = 90,
	["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(95, 95, 95)) })
})})
	v11[v12] = v13
	__set_list(v9, 1, {v10(v11)})
	v7[v8] = v9
	return v6(v7)
end