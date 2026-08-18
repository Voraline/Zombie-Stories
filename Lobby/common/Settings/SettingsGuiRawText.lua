local v1 = scope:New("ScreenGui")
local v2 = {
	["Name"] = "SettingsGui",
	["ResetOnSpawn"] = false,
	["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
}
local v3 = Children
local v4 = {}
local v5 = scope:New("Frame")
local v6 = {
	["Name"] = "Panel",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(17, 37, 63),
	["BackgroundTransparency"] = 0.1,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(1.2, 0.78),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
}
local v7 = Children
local v8 = {}
local v9 = scope:New("UICorner")({
	["Name"] = "UICorner",
	["CornerRadius"] = nil,
	["CornerRadius"] = UDim.new(0.015, 0)
})
local v10 = scope:New("Frame")({
	["Name"] = "Background",
	["BackgroundColor3"] = nil,
	["BorderColor3"] = nil,
	["BorderSizePixel"] = 0,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Visible"] = false,
	["ZIndex"] = 0,
	["BackgroundColor3"] = Color3.fromRGB(14, 33, 50),
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["Size"] = UDim2.fromScale(1.538, 1),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeYY
})
local v11 = scope:New("Frame")
local v12 = {
	["Name"] = "Header",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.065)
}
local v13 = Children
local v14 = {}
local v15 = scope:New("UICorner")({
	["Name"] = "UICorner",
	["CornerRadius"] = nil,
	["CornerRadius"] = UDim.new(0.3, 0)
})
local v16 = scope:New("TextLabel")({
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
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.99, 0),
	["Size"] = UDim2.fromScale(0.15, 1),
	["TextColor3"] = Color3.fromRGB(255, 184, 84)
})
local v17 = scope:New("TextButton")
local v18 = {
	["Name"] = "Exit",
	["Active"] = false,
	["AnchorPoint"] = Vector2.new(1, 1),
	["BackgroundTransparency"] = 1,
	["LayoutOrder"] = 1000,
	["Position"] = UDim2.new(1, 5, 0, -10),
	["Size"] = UDim2.fromOffset(35, 35),
	["Visible"] = false
}
local v19 = Children
local v20 = {}
local v21 = scope:New("ImageLabel")
local v22 = {
	["Name"] = "WeaponStats",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851926732",
	["ImageColor3"] = Color3.fromRGB(255, 73, 73),
	["LayoutOrder"] = -1,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Selectable"] = true,
	["Size"] = UDim2.fromScale(1, 1),
	["SliceCenter"] = Rect.new(12, 12, 12, 12),
	[Children] = { scope:New("ImageLabel")({
			["Name"] = "Fill",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["Image"] = "rbxassetid://2851928361",
			["ImageColor3"] = nil,
			["Position"] = nil,
			["ScaleType"] = nil,
			["Size"] = nil,
			["SliceCenter"] = nil,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["ImageColor3"] = Color3.fromRGB(49, 49, 49),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["ScaleType"] = Enum.ScaleType.Slice,
			["Size"] = UDim2.new(1, -10, 1, -10),
			["SliceCenter"] = Rect.new(7, 7, 7, 7)
		}), scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["BackgroundTransparency"] = 1,
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.525, 0.5),
			["Size"] = UDim2.fromScale(0.85, 0.8),
			["Text"] = "X",
			["TextColor3"] = Color3.fromRGB(255, 73, 73),
			["TextScaled"] = true,
			[Children] = { scope:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 20
				}) }
		}) }
}
__set_list(v20, 1, {v21(v22)})
v18[v19] = v20
__set_list(v14, 1, {v15, v16, v17(v18)})
v12[v13] = v14
local v23 = v11(v12)
local v24 = scope:New("Frame")
local v25 = {
	["Name"] = "Container",
	["AnchorPoint"] = Vector2.new(1, 1),
	["BackgroundTransparency"] = 1,
	["Position"] = UDim2.fromScale(0.995, 1),
	["Size"] = UDim2.fromScale(0.695, 0.945),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.016, 0)
		}) }
}
local v26 = v24(v25)
local v27 = scope:New("Frame")
local v28 = {
	["Name"] = "Tabs",
	["AnchorPoint"] = Vector2.new(0, 1),
	["BackgroundTransparency"] = 1,
	["Position"] = UDim2.fromScale(0, 1),
	["Size"] = UDim2.fromScale(0.296, 1)
}
local v29 = Children
local v30 = {}
local v31 = scope:New("UICorner")({
	["Name"] = "UICorner",
	["CornerRadius"] = nil,
	["CornerRadius"] = UDim.new(0.035, 0)
})
local v32 = scope:New("ScrollingFrame")
local v33 = {
	["Name"] = "Frame",
	["AutomaticCanvasSize"] = Enum.AutomaticSize.Y,
	["BackgroundTransparency"] = 1,
	["CanvasSize"] = UDim2.new(),
	["ScrollBarImageColor3"] = Color3.fromRGB(16, 16, 16),
	["ScrollBarThickness"] = 0,
	["ScrollingDirection"] = Enum.ScrollingDirection.Y,
	["Selectable"] = false,
	["Size"] = UDim2.fromScale(1, 1)
}
local v34 = Children
local v35 = {}
local v36 = scope:New("UIListLayout")({
	["Name"] = "UIListLayout",
	["SortOrder"] = nil,
	["SortOrder"] = Enum.SortOrder.LayoutOrder
})
local v37 = scope:New("TextButton")
local v38 = {
	["Name"] = "Button",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.3),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["Visible"] = false
}
local v39 = Children
local v40 = {}
local v41 = scope:New("Frame")
local v42 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.new(0.95, -8, 0.85, -8),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.2, 0)
		}), scope:New("UIStroke")({
			["Name"] = "UIStroke",
			["Color"] = nil,
			["Thickness"] = 4,
			["Color"] = Color3.fromRGB(255, 184, 84)
		}), scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "GRAPHICS",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.9, 0.85),
			["TextColor3"] = Color3.new(1, 1, 1)
		}) }
}
__set_list(v40, 1, {v41(v42)})
v38[v39] = v40
local v43 = v37(v38)
local v44 = scope:New("TextButton")
local v45 = {
	["Name"] = "Exit",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.2),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["Visible"] = false
}
local v46 = Children
local v47 = {}
local v48 = scope:New("Frame")
local v49 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(61, 0, 0),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.new(0.95, -8, 0.85, -8),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.2, 0)
		}), scope:New("UIStroke")({
			["Name"] = "UIStroke",
			["Color"] = nil,
			["Thickness"] = 4,
			["Color"] = Color3.fromRGB(255, 73, 73)
		}), scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "EXIT",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.9, 0.85),
			["TextColor3"] = Color3.fromRGB(255, 73, 73)
		}) }
}
__set_list(v47, 1, {v48(v49)})
v45[v46] = v47
__set_list(v35, 1, {v36, v43, v44(v45)})
v33[v34] = v35
local v50 = v32(v33)
local v51 = scope:New("Frame")
local v52 = {
	["Name"] = "Background",
	["BackgroundTransparency"] = 1,
	["ClipsDescendants"] = true,
	["Size"] = UDim2.fromScale(1, 1),
	["ZIndex"] = 0
}
local v53 = Children
local v54 = {}
local v55 = scope:New("Frame")
local v56 = {
	["Name"] = "CurvedFrame",
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.9,
	["Size"] = UDim2.fromScale(1.2, 1),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.028, 0)
		}) }
}
__set_list(v54, 1, {v55(v56)})
v52[v53] = v54
__set_list(v30, 1, {v31, v50, v51(v52)})
v28[v29] = v30
__set_list(v8, 1, {v9, v10, v23, v26, v27(v28), scope:New("UIGradient")({
	["Name"] = "UIGradient",
	["Color"] = nil,
	["Rotation"] = 90,
	["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(95, 95, 95)) })
})})
v6[v7] = v8
__set_list(v4, 1, {v5(v6)})
v2[v3] = v4
v1(v2)