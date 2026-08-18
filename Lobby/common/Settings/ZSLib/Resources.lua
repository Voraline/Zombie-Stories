local v1 = scope:New("Folder")
local v2 = {
	["Name"] = "Resources"
}
local v3 = Children
local v4 = {}
local v5 = scope:New("ImageButton")
local v6 = {
	["Name"] = "Dropdownold",
	["AnchorPoint"] = Vector2.new(1, 1),
	["BackgroundTransparency"] = 1,
	["ClipsDescendants"] = true,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.new(),
	["ImageTransparency"] = 0.25,
	["Position"] = UDim2.fromScale(1, 1),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Selectable"] = false,
	["Size"] = UDim2.fromScale(1, 1),
	["SliceCenter"] = Rect.new(7, 7, 7, 7),
	["Visible"] = false
}
local v7 = Children
local v8 = {}
local v9 = scope:New("ScrollingFrame")
local v10 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["CanvasSize"] = UDim2.new(),
	["ClipsDescendants"] = false,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScrollBarImageColor3"] = Color3.fromRGB(16, 16, 16),
	["ScrollBarThickness"] = 0,
	["ScrollingDirection"] = Enum.ScrollingDirection.Y,
	["Selectable"] = false,
	["Size"] = UDim2.new(1, -5, 1, -5)
}
local v11 = Children
local v12 = {}
local v13 = scope:New("UIGridLayout")({
	["Name"] = "UIGridLayout",
	["CellPadding"] = nil,
	["CellSize"] = nil,
	["FillDirection"] = nil,
	["HorizontalAlignment"] = nil,
	["SortOrder"] = nil,
	["VerticalAlignment"] = nil,
	["CellPadding"] = UDim2.fromOffset(0, -5),
	["CellSize"] = UDim2.new(1, 0, 0, 45),
	["FillDirection"] = Enum.FillDirection.Vertical,
	["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
	["SortOrder"] = Enum.SortOrder.LayoutOrder,
	["VerticalAlignment"] = Enum.VerticalAlignment.Center
})
local v14 = scope:New("TextButton")
local v15 = {
	["Name"] = "Exit",
	["Active"] = false,
	["BackgroundTransparency"] = 1,
	["LayoutOrder"] = 1000,
	["Size"] = UDim2.fromOffset(100, 100),
	["Visible"] = false
}
local v16 = Children
local v17 = {}
local v18 = scope:New("ImageLabel")
local v19 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851926732",
	["ImageColor3"] = Color3.fromRGB(255, 73, 73),
	["LayoutOrder"] = -1,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Selectable"] = true,
	["Size"] = UDim2.new(1, -10, 1, -10),
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
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.9, 0.8),
			["Text"] = "EXIT",
			["TextColor3"] = Color3.fromRGB(255, 73, 73),
			["TextScaled"] = true,
			[Children] = { scope:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 20
				}) }
		}) }
}
__set_list(v17, 1, {v18(v19), scope:New("UISizeConstraint")({
	["Name"] = "UISizeConstraint",
	["MaxSize"] = nil,
	["MaxSize"] = Vector2.new(300, 0)
})})
v15[v16] = v17
local v20 = v14(v15)
local v21 = scope:New("TextButton")
local v22 = {
	["Name"] = "Button",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromOffset(100, 100),
	["Visible"] = false
}
local v23 = Children
local v24 = {}
local v25 = scope:New("ImageLabel")
local v26 = {
	["Name"] = "Frame",
	["Active"] = true,
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851926732",
	["ImageColor3"] = Color3.fromRGB(34, 34, 34),
	["LayoutOrder"] = -1,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Selectable"] = true,
	["Size"] = UDim2.new(1, -10, 1, -10),
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
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.9, 0.8),
			["Text"] = "AUTOMATIC",
			["TextColor3"] = Color3.fromRGB(216, 216, 216),
			["TextScaled"] = true,
			[Children] = { scope:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 20
				}) }
		}) }
}
__set_list(v24, 1, {v25(v26), scope:New("UISizeConstraint")({
	["Name"] = "UISizeConstraint",
	["MaxSize"] = nil,
	["MaxSize"] = Vector2.new(300, 0)
})})
v22[v23] = v24
__set_list(v12, 1, {v13, v20, v21(v22)})
v10[v11] = v12
local v27 = v9(v10)
local v28 = scope:New("TextButton")
local v29 = {
	["Name"] = "Exit",
	["AnchorPoint"] = Vector2.new(1, 0),
	["BackgroundTransparency"] = 1,
	["LayoutOrder"] = 1000,
	["Position"] = UDim2.new(1, -10, 0, 10),
	["Size"] = UDim2.fromOffset(35, 35),
	["Text"] = "X"
}
local v30 = Children
local v31 = {}
local v32 = scope:New("ImageLabel")
local v33 = {
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
__set_list(v31, 1, {v32(v33)})
v29[v30] = v31
__set_list(v8, 1, {v27, v28(v29)})
v6[v7] = v8
local v34 = v5(v6)
local v35 = scope:New("ScrollingFrame")
local v36 = {
	["Name"] = "ContainerTemplate",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["BottomImage"] = "",
	["CanvasSize"] = UDim2.fromOffset(0, 346),
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScrollBarImageColor3"] = Color3.fromRGB(16, 16, 16),
	["ScrollBarThickness"] = 3,
	["ScrollingDirection"] = Enum.ScrollingDirection.Y,
	["Selectable"] = false,
	["Size"] = UDim2.new(1, -5, 1, -5),
	["TopImage"] = "",
	["Visible"] = false,
	[Children] = { scope:New("UIListLayout")({
			["Name"] = "UIListLayout",
			["SortOrder"] = nil,
			["SortOrder"] = Enum.SortOrder.LayoutOrder
		}) }
}
local v37 = v35(v36)
local v38 = scope:New("Sound")({
	["Name"] = "button",
	["SoundId"] = "rbxassetid://1852347417"
})
local v39 = scope:New("Folder")
local v40 = {
	["Name"] = "Templates"
}
local v41 = Children
local v42 = {}
local v43 = scope:New("Frame")
local v44 = {
	["Name"] = "Toggle",
	["BackgroundTransparency"] = 1,
	["LayoutOrder"] = 1,
	["Size"] = UDim2.fromScale(1, 0.08),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v45 = Children
local v46 = {}
local v47 = scope:New("Frame")
local v48 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85)
}
local v49 = Children
local v50 = {}
local v51 = scope:New("UICorner")({
	["Name"] = "UICorner"
})
local v52 = scope:New("ImageButton")
local v53 = {
	["Name"] = "Toggle",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.fromRGB(33, 33, 33),
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(1, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Size"] = UDim2.fromScale(0.18, 1),
	["SliceCenter"] = Rect.new(7, 7, 7, 7)
}
local v54 = Children
local v55 = {}
local v56 = scope:New("Frame")
local v57 = {
	["Name"] = "Back",
	["AnchorPoint"] = Vector2.new(0, 0.5),
	["BackgroundColor3"] = Color3.new(1, 1, 1),
	["BackgroundTransparency"] = 0.95,
	["Position"] = UDim2.fromScale(0, 0.5),
	["Size"] = UDim2.fromScale(1, 1),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.17, 0)
		}) }
}
local v58 = v56(v57)
local v59 = scope:New("Frame")
local v60 = {
	["Name"] = "Fill",
	["AnchorPoint"] = Vector2.new(0, 0.5),
	["BackgroundTransparency"] = 1,
	["ClipsDescendants"] = true,
	["Position"] = UDim2.fromScale(0, 0.5),
	["Size"] = UDim2.fromScale(0.75, 1),
	["ZIndex"] = 2
}
local v61 = Children
local v62 = {}
local v63 = scope:New("Frame")
local v64 = {
	["Name"] = "Frame",
	["BackgroundColor3"] = Color3.fromRGB(255, 184, 84),
	["Size"] = UDim2.fromScale(100, 1),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.17, 0)
		}) }
}
__set_list(v62, 1, {v63(v64)})
v60[v61] = v62
local v65 = v59(v60)
local v66 = scope:New("Frame")
local v67 = {
	["Name"] = "Slide",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.new(1, 1, 1),
	["Position"] = UDim2.fromScale(1, 0.5),
	["Size"] = UDim2.fromScale(0.4, 1),
	["ZIndex"] = 3,
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.2, 0)
		}) }
}
__set_list(v55, 1, {v58, v65, v66(v67)})
v53[v54] = v55
__set_list(v50, 1, {v51, v52(v53), scope:New("TextLabel")({
	["Name"] = "Label",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ANIMATED SKINS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0),
	["Size"] = UDim2.fromScale(0.8, 0.06),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
}), scope:New("TextLabel")({
	["Name"] = "DescriptionLabel",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ANIMATED SKINS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextTransparency"] = 0.5,
	["TextXAlignment"] = nil,
	["Visible"] = false,
	["AnchorPoint"] = Vector2.new(0, 1),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.96),
	["Size"] = UDim2.fromScale(0.8, 0.05),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})})
v48[v49] = v50
__set_list(v46, 1, {v47(v48)})
v44[v45] = v46
local v68 = v43(v44)
local v69 = scope:New("Frame")
local v70 = {
	["Name"] = "NumberSlider",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.11),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v71 = Children
local v72 = {}
local v73 = scope:New("Frame")
local v74 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85)
}
local v75 = Children
local v76 = {}
local v77 = scope:New("UICorner")({
	["Name"] = "UICorner"
})
local v78 = scope:New("ImageLabel")
local v79 = {
	["Name"] = "Slide",
	["AnchorPoint"] = Vector2.new(0.5, 1),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.fromRGB(33, 33, 33),
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(0.5, 0.85),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Size"] = UDim2.fromScale(0.97, 0.01),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["SliceCenter"] = Rect.new(7, 7, 7, 7)
}
local v80 = Children
local v81 = {}
local v82 = scope:New("ImageLabel")
local v83 = {
	["Name"] = "SlidingBase",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.fromRGB(33, 33, 33),
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Size"] = UDim2.fromScale(1, 1),
	["SliceCenter"] = Rect.new(7, 7, 7, 7)
}
local v84 = Children
local v85 = {}
local v86 = scope:New("ImageLabel")({
	["Name"] = "Fill",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = nil,
	["Position"] = nil,
	["ScaleType"] = nil,
	["Size"] = nil,
	["SliceCenter"] = nil,
	["SliceScale"] = 2,
	["AnchorPoint"] = Vector2.new(0, 0.5),
	["ImageColor3"] = Color3.fromRGB(255, 184, 84),
	["Position"] = UDim2.fromScale(0, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Size"] = UDim2.fromScale(0.3, 0.75),
	["SliceCenter"] = Rect.new(7, 7, 7, 7)
})
local v87 = scope:New("ImageLabel")
local v88 = {
	["Name"] = "Slide",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://4175209485",
	["Position"] = UDim2.fromScale(0.3, 0.5),
	["Size"] = UDim2.fromScale(0.016, 0.016),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["SliceCenter"] = Rect.new(7, 7, 7, 7),
	["ZIndex"] = 3,
	[Children] = { scope:New("TextButton")({
			["Name"] = "Button",
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Size"] = nil,
			["Text"] = "",
			["TextColor3"] = nil,
			["TextSize"] = 14,
			["TextTransparency"] = 1,
			["ZIndex"] = 50,
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
			["Size"] = UDim2.fromScale(1, 1),
			["TextColor3"] = Color3.new()
		}) }
}
local v89 = v87(v88)
local v90 = scope:New("Frame")
local v91 = {
	["Name"] = "Back",
	["AnchorPoint"] = Vector2.new(0, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0, 0.5),
	["Size"] = UDim2.fromScale(1, 0.75),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(1, 0)
		}) }
}
__set_list(v85, 1, {v86, v89, v90(v91)})
v83[v84] = v85
__set_list(v81, 1, {v82(v83)})
v79[v80] = v81
local v92 = v78(v79)
local v93 = scope:New("ImageLabel")
local v94 = {
	["Name"] = "TextBox",
	["AnchorPoint"] = Vector2.new(1, 0),
	["BackgroundColor3"] = Color3.new(1, 1, 1),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.fromRGB(33, 33, 33),
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(1, 0),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Size"] = UDim2.fromScale(0.16, 0.6),
	["SliceCenter"] = Rect.new(7, 7, 7, 7),
	[Children] = { scope:New("TextBox")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["PlaceholderColor3"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "1",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["PlaceholderColor3"] = Color3.new(1, 1, 1),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(1, 0.7),
			["TextColor3"] = Color3.new(1, 1, 1)
		}), scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.2, 0)
		}) }
}
__set_list(v76, 1, {v77, v92, v93(v94), scope:New("TextLabel")({
	["Name"] = "Label",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "MUSIC VOLUME",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.04),
	["Size"] = UDim2.fromScale(0.82, 0.06),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
}), scope:New("TextLabel")({
	["Name"] = "DescriptionLabel",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ANIMATED SKINS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextTransparency"] = 0.5,
	["TextXAlignment"] = nil,
	["Visible"] = false,
	["AnchorPoint"] = Vector2.new(0, 1),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.75),
	["Size"] = UDim2.fromScale(0.82, 0.05),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})})
v74[v75] = v76
__set_list(v72, 1, {v73(v74)})
v70[v71] = v72
local v95 = v69(v70)
local v96 = scope:New("Frame")
local v97 = {
	["Name"] = "Number",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.08),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v98 = Children
local v99 = {}
local v100 = scope:New("Frame")
local v101 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85)
}
local v102 = Children
local v103 = {}
local v104 = scope:New("ImageLabel")
local v105 = {
	["Name"] = "Toggle",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.new(1, 1, 1),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.fromRGB(33, 33, 33),
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(1, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Size"] = UDim2.fromScale(0.16, 1),
	["SliceCenter"] = Rect.new(7, 7, 7, 7),
	[Children] = { scope:New("TextBox")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["PlaceholderColor3"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "1",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["PlaceholderColor3"] = Color3.new(1, 1, 1),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(1, 0.7),
			["TextColor3"] = Color3.new(1, 1, 1)
		}), scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.15, 0)
		}) }
}
__set_list(v103, 1, {v104(v105), scope:New("TextLabel")({
	["Name"] = "Label",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "MUSIC VOLUME",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0),
	["Size"] = UDim2.fromScale(0.82, 0.06),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
}), scope:New("UICorner")({
	["Name"] = "UICorner"
}), scope:New("TextLabel")({
	["Name"] = "DescriptionLabel",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ANIMATED SKINS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextTransparency"] = 0.5,
	["TextXAlignment"] = nil,
	["Visible"] = false,
	["AnchorPoint"] = Vector2.new(0, 1),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.96),
	["Size"] = UDim2.fromScale(0.82, 0.05),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})})
v101[v102] = v103
__set_list(v99, 1, {v100(v101)})
v97[v98] = v99
local v106 = v96(v97)
local v107 = scope:New("Frame")
local v108 = {
	["Name"] = "BindsHeader",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.09),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v109 = Children
local v110 = {}
local v111 = scope:New("Frame")
local v112 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85),
	[Children] = {
		scope:New("UICorner")({
			["Name"] = "UICorner"
		}),
		scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "PRESS TO BIND",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["TextXAlignment"] = nil,
			["AnchorPoint"] = Vector2.new(0, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.01, 0.5),
			["Size"] = UDim2.fromScale(0.5, 0.9),
			["TextColor3"] = Color3.new(1, 1, 1),
			["TextXAlignment"] = Enum.TextXAlignment.Left
		}),
		scope:New("ImageLabel")({
			["Name"] = "KeyboardLabel",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["Image"] = "rbxassetid://13693390115",
			["ImageColor3"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["SizeConstraint"] = nil,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["ImageColor3"] = Color3.fromRGB(255, 184, 84),
			["Position"] = UDim2.new(0.695, -4, 0.5, 0),
			["Size"] = UDim2.fromScale(0.06, 0.06),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
		}),
		scope:New("ImageLabel")({
			["Name"] = "MouseLabel",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["Image"] = "rbxassetid://13693587767",
			["ImageColor3"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["SizeConstraint"] = nil,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["ImageColor3"] = Color3.fromRGB(255, 184, 84),
			["Position"] = UDim2.new(0.815, -2, 0.5, 0),
			["Size"] = UDim2.fromScale(0.06, 0.06),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
		}),
		scope:New("ImageLabel")({
			["Name"] = "GamepadLabel",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["Image"] = "rbxassetid://13693666926",
			["ImageColor3"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["SizeConstraint"] = nil,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["ImageColor3"] = Color3.fromRGB(255, 184, 84),
			["Position"] = UDim2.fromScale(0.935, 0.5),
			["Size"] = UDim2.fromScale(0.06, 0.06),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
		})
	}
}
__set_list(v110, 1, {v111(v112)})
v108[v109] = v110
local v113 = v107(v108)
local v114 = scope:New("Frame")
local v115 = {
	["Name"] = "Header",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.09),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v116 = Children
local v117 = {}
local v118 = scope:New("Frame")
local v119 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner"
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
			["Size"] = UDim2.fromScale(0.9, 0.9),
			["TextColor3"] = Color3.new(1, 1, 1)
		}) }
}
__set_list(v117, 1, {v118(v119)})
v115[v116] = v117
local v120 = v114(v115)
local v121 = scope:New("Frame")
local v122 = {
	["Name"] = "Dropdown",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.08),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v123 = Children
local v124 = {}
local v125 = scope:New("Frame")
local v126 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85)
}
local v127 = Children
local v128 = {}
local v129 = scope:New("UICorner")({
	["Name"] = "UICorner"
})
local v130 = scope:New("ImageButton")
local v131 = {
	["Name"] = "Toggle",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.new(1, 1, 1),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.fromRGB(33, 33, 33),
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(1, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Size"] = UDim2.fromScale(0.22, 1),
	["SliceCenter"] = Rect.new(7, 7, 7, 7),
	[Children] = { scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "AUTOMATIC",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.05, 0.5),
			["Size"] = UDim2.fromScale(0.78, 0.6),
			["TextColor3"] = Color3.new(1, 1, 1)
		}), scope:New("ImageLabel")({
			["Name"] = "keyboard_arrow_down",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["Image"] = "rbxassetid://3926305904",
			["ImageRectOffset"] = nil,
			["ImageRectSize"] = nil,
			["LayoutOrder"] = 19,
			["Position"] = nil,
			["Selectable"] = true,
			["Size"] = nil,
			["SizeConstraint"] = nil,
			["ZIndex"] = 2,
			["AnchorPoint"] = Vector2.new(1, 0.5),
			["ImageRectOffset"] = Vector2.new(404, 284),
			["ImageRectSize"] = Vector2.new(36, 36),
			["Position"] = UDim2.fromScale(1, 0.5),
			["Size"] = UDim2.fromScale(0.2, 0.2),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
		}), scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.15, 0)
		}) }
}
__set_list(v128, 1, {v129, v130(v131), scope:New("TextLabel")({
	["Name"] = "Label",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ZOMBIE DETAIL",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.04),
	["Size"] = UDim2.fromScale(0.76, 0.06),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
}), scope:New("TextLabel")({
	["Name"] = "DescriptionLabel",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ANIMATED SKINS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextTransparency"] = 0.5,
	["TextXAlignment"] = nil,
	["Visible"] = false,
	["AnchorPoint"] = Vector2.new(0, 1),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.96),
	["Size"] = UDim2.fromScale(0.76, 0.05),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})})
v126[v127] = v128
__set_list(v124, 1, {v125(v126)})
v122[v123] = v124
local v132 = v121(v122)
local v133 = scope:New("Frame")
local v134 = {
	["Name"] = "Button",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 0.08),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v135 = Children
local v136 = {}
local v137 = scope:New("Frame")
local v138 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85)
}
local v139 = Children
local v140 = {}
local v141 = scope:New("TextLabel")({
	["Name"] = "Label",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "MUSIC VOLUME",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.04),
	["Size"] = UDim2.fromScale(0.82, 0.06),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})
local v142 = scope:New("UICorner")({
	["Name"] = "UICorner"
})
local v143 = scope:New("Frame")
local v144 = {
	["Name"] = "Toggle",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.new(1, 1, 1),
	["BackgroundTransparency"] = 0.95,
	["Position"] = UDim2.new(1, -3, 0.5, 0),
	["Size"] = UDim2.fromScale(0.15, 1)
}
local v145 = Children
local v146 = {}
local v147 = scope:New("UICorner")({
	["Name"] = "UICorner",
	["CornerRadius"] = nil,
	["CornerRadius"] = UDim.new(0.18, 0)
})
local v148 = scope:New("TextButton")
local v149 = {
	["Name"] = "Button",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(1, 1),
	["TextTransparency"] = 1,
	[Children] = { scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "OPEN",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.9, 0.9),
			["TextColor3"] = Color3.fromRGB(255, 184, 84)
		}) }
}
__set_list(v146, 1, {v147, v148(v149), scope:New("UIStroke")({
	["Name"] = "UIStroke",
	["Color"] = nil,
	["Thickness"] = 3,
	["Color"] = Color3.fromRGB(255, 184, 84)
})})
v144[v145] = v146
__set_list(v140, 1, {v141, v142, v143(v144), scope:New("TextLabel")({
	["Name"] = "DescriptionLabel",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ANIMATED SKINS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextTransparency"] = 0.5,
	["TextXAlignment"] = nil,
	["Visible"] = false,
	["AnchorPoint"] = Vector2.new(0, 1),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.96),
	["Size"] = UDim2.fromScale(0.82, 0.05),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})})
v138[v139] = v140
__set_list(v136, 1, {v137(v138)})
v134[v135] = v136
local v150 = v133(v134)
local v151 = scope:New("Frame")
local v152 = {
	["Name"] = "Bind",
	["BackgroundTransparency"] = 1,
	["LayoutOrder"] = 1,
	["Size"] = UDim2.fromScale(1, 0.16),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
}
local v153 = Children
local v154 = {}
local v155 = scope:New("Frame")
local v156 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(),
	["BackgroundTransparency"] = 0.8,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.fromScale(0.99, 0.85)
}
local v157 = Children
local v158 = {}
local v159 = scope:New("UICorner")({
	["Name"] = "UICorner"
})
local v160 = scope:New("TextLabel")({
	["Name"] = "Label",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "JUMP",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["AnchorPoint"] = Vector2.new(0, 0.5),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.5),
	["Size"] = UDim2.fromScale(0.62, 0.07),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})
local v161 = scope:New("TextLabel")({
	["Name"] = "DescriptionLabel",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = "ANIMATED SKINS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextTransparency"] = 0.5,
	["TextXAlignment"] = nil,
	["Visible"] = false,
	["AnchorPoint"] = Vector2.new(0, 1),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.01, 0.83),
	["Size"] = UDim2.fromScale(0.8, 0.04),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})
local v162 = scope:New("ImageButton")
local v163 = {
	["Name"] = "GamepadButton",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(107, 107, 107),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(0.99, 0.5),
	["Size"] = UDim2.fromScale(0.11, 0.11),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.1, 0)
		}), scope:New("UIStroke")({
			["Name"] = "UIStroke",
			["Color"] = nil,
			["Color"] = Color3.fromRGB(255, 184, 84)
		}) }
}
local v164 = v162(v163)
local v165 = scope:New("ImageButton")
local v166 = {
	["Name"] = "MouseButton",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(107, 107, 107),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	["ImageTransparency"] = 1,
	["Position"] = UDim2.new(0.87, -2, 0.5, 0),
	["Size"] = UDim2.fromScale(0.11, 0.11),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.1, 0)
		}), scope:New("UIStroke")({
			["Name"] = "UIStroke",
			["Color"] = nil,
			["Color"] = Color3.fromRGB(255, 184, 84)
		}) }
}
local v167 = v165(v166)
local v168 = scope:New("ImageButton")
local v169 = {
	["Name"] = "KeyboardButton",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(107, 107, 107),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	["ImageTransparency"] = 1,
	["Position"] = UDim2.new(0.75, -4, 0.5, 0),
	["Size"] = UDim2.fromScale(0.11, 0.11),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.1, 0)
		}), scope:New("UIStroke")({
			["Name"] = "UIStroke",
			["Color"] = nil,
			["Color"] = Color3.fromRGB(255, 184, 84)
		}) }
}
__set_list(v158, 1, {v159, v160, v161, v164, v167, v168(v169)})
v156[v157] = v158
__set_list(v154, 1, {v155(v156)})
v152[v153] = v154
__set_list(v42, 1, {v68, v95, v106, v113, v120, v132, v150, v151(v152)})
v40[v41] = v42
local v170 = v39(v40)
local v171 = scope:New("ImageButton")
local v172 = {
	["Name"] = "Dropdown",
	["AnchorPoint"] = Vector2.new(1, 1),
	["BackgroundTransparency"] = 1,
	["ClipsDescendants"] = true,
	["Image"] = "rbxassetid://2851928361",
	["ImageColor3"] = Color3.fromRGB(6, 14, 24),
	["ImageTransparency"] = 0.2,
	["Position"] = UDim2.fromScale(1, 1),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Selectable"] = false,
	["Size"] = UDim2.fromScale(1, 1),
	["SliceCenter"] = Rect.new(7, 7, 7, 7),
	["Visible"] = false,
	["ZIndex"] = 2
}
local v173 = Children
local v174 = {}
local v175 = scope:New("ScrollingFrame")
local v176 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["CanvasSize"] = UDim2.new(),
	["ClipsDescendants"] = false,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScrollBarImageColor3"] = Color3.fromRGB(16, 16, 16),
	["ScrollBarThickness"] = 0,
	["ScrollingDirection"] = Enum.ScrollingDirection.Y,
	["Selectable"] = false,
	["Size"] = UDim2.new(1, -5, 1, -5)
}
local v177 = Children
local v178 = {}
local v179 = scope:New("TextButton")
local v180 = {
	["Name"] = "Exit",
	["Active"] = false,
	["BackgroundTransparency"] = 1,
	["LayoutOrder"] = 1000,
	["Size"] = UDim2.fromOffset(100, 100),
	["Visible"] = false
}
local v181 = Children
local v182 = {}
local v183 = scope:New("ImageLabel")
local v184 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundTransparency"] = 1,
	["Image"] = "rbxassetid://2851926732",
	["ImageColor3"] = Color3.fromRGB(255, 73, 73),
	["LayoutOrder"] = -1,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Selectable"] = true,
	["Size"] = UDim2.new(1, -10, 1, -10),
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
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.9, 0.8),
			["Text"] = "EXIT",
			["TextColor3"] = Color3.fromRGB(255, 73, 73),
			["TextScaled"] = true,
			[Children] = { scope:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 20
				}) }
		}) }
}
__set_list(v182, 1, {v183(v184), scope:New("UISizeConstraint")({
	["Name"] = "UISizeConstraint",
	["MaxSize"] = nil,
	["MaxSize"] = Vector2.new(300, 0)
})})
v180[v181] = v182
local v185 = v179(v180)
local v186 = scope:New("TextButton")
local v187 = {
	["Name"] = "Button",
	["BackgroundTransparency"] = 1,
	["Size"] = UDim2.fromScale(0.5, 0.14),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["Visible"] = false
}
local v188 = Children
local v189 = {}
local v190 = scope:New("Frame")
local v191 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.new(1, 1, 1),
	["BackgroundTransparency"] = 0.95,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["Size"] = UDim2.new(1, 0, 0.8, -6),
	[Children] = { scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.2, 0)
		}), scope:New("UIStroke")({
			["Name"] = "UIStroke",
			["Color"] = nil,
			["Thickness"] = 3,
			["Color"] = Color3.fromRGB(255, 184, 84)
		}), scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "AUTOMATIC",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.9, 0.8),
			["TextColor3"] = Color3.fromRGB(255, 184, 84)
		}) }
}
__set_list(v189, 1, {v190(v191)})
v187[v188] = v189
__set_list(v178, 1, {v185, v186(v187), scope:New("UIListLayout")({
	["Name"] = "UIListLayout",
	["HorizontalAlignment"] = nil,
	["SortOrder"] = nil,
	["VerticalAlignment"] = nil,
	["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
	["SortOrder"] = Enum.SortOrder.LayoutOrder,
	["VerticalAlignment"] = Enum.VerticalAlignment.Center
})})
v176[v177] = v178
local v192 = v175(v176)
local v193 = scope:New("TextButton")
local v194 = {
	["Name"] = "Exit",
	["AnchorPoint"] = Vector2.new(1, 0),
	["BackgroundColor3"] = Color3.fromRGB(50, 17, 17),
	["BackgroundTransparency"] = 0.5,
	["LayoutOrder"] = 1000,
	["Position"] = UDim2.fromScale(0.98, 0.02),
	["Size"] = UDim2.fromScale(0.1, 0.1),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["Text"] = "X",
	["TextColor3"] = Color3.fromRGB(255, 73, 73),
	["TextScaled"] = true,
	["TextTransparency"] = 1,
	[Children] = { scope:New("UIStroke")({
			["Name"] = "UIStroke",
			["ApplyStrokeMode"] = nil,
			["Color"] = nil,
			["Thickness"] = 3,
			["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border,
			["Color"] = Color3.fromRGB(255, 73, 73)
		}), scope:New("UICorner")({
			["Name"] = "UICorner",
			["CornerRadius"] = nil,
			["CornerRadius"] = UDim.new(0.2, 0)
		}), scope:New("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "X",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.525, 0.5),
			["Size"] = UDim2.fromScale(0.85, 0.8),
			["TextColor3"] = Color3.fromRGB(255, 73, 73)
		}) }
}
__set_list(v174, 1, {v192, v193(v194)})
v172[v173] = v174
__set_list(v4, 1, {v34, v37, v38, v170, v171(v172)})
v2[v3] = v4
v1(v2)