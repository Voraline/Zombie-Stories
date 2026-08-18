local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v3 = v2.New
local v4 = v2.Children
local v5 = v3("Frame")
local v6 = {
	["Name"] = "Header",
	["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["Size"] = UDim2.fromScale(1, 0.065)
}
local v7 = {}
local v8 = v3("UICorner")({
	["Name"] = "UICorner",
	["CornerRadius"] = nil,
	["CornerRadius"] = UDim.new(0.3, 0)
})
local v9 = v3("TextLabel")({
	["Name"] = "TextLabel",
	["AnchorPoint"] = nil,
	["BackgroundColor3"] = nil,
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = nil,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["Text"] = "SETTINGS",
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextSize"] = 14,
	["TextWrapped"] = true,
	["AnchorPoint"] = Vector2.new(1, 0),
	["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
	["Position"] = UDim2.fromScale(0.99, 0),
	["Size"] = UDim2.fromScale(0.15, 1),
	["TextColor3"] = Color3.fromRGB(255, 184, 84)
})
local v10 = v3("TextButton")
local v11 = {
	["Name"] = "Exit",
	["Active"] = false,
	["AnchorPoint"] = Vector2.new(1, 1),
	["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["LayoutOrder"] = 1000,
	["Position"] = UDim2.new(1, 5, 0, -10),
	["Size"] = UDim2.fromOffset(35, 35),
	["Visible"] = false
}
local v12 = {}
local v13 = v3("ImageLabel")
local v14 = {
	["Name"] = "WeaponStats",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(248, 248, 248),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["Image"] = "rbxassetid://2851926732",
	["ImageColor3"] = Color3.fromRGB(255, 73, 73),
	["LayoutOrder"] = -1,
	["Position"] = UDim2.fromScale(0.5, 0.5),
	["ScaleType"] = Enum.ScaleType.Slice,
	["Selectable"] = true,
	["Size"] = UDim2.fromScale(1, 1),
	["SliceCenter"] = Rect.new(12, 12, 12, 12),
	[v4] = { v3("ImageLabel")({
			["Name"] = "Fill",
			["AnchorPoint"] = nil,
			["BackgroundColor3"] = nil,
			["BackgroundTransparency"] = 1,
			["BorderColor3"] = nil,
			["Image"] = "rbxassetid://2851928361",
			["ImageColor3"] = nil,
			["Position"] = nil,
			["ScaleType"] = nil,
			["Size"] = nil,
			["SliceCenter"] = nil,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
			["BorderColor3"] = Color3.fromRGB(27, 42, 53),
			["ImageColor3"] = Color3.fromRGB(49, 49, 49),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["ScaleType"] = Enum.ScaleType.Slice,
			["Size"] = UDim2.new(1, -10, 1, -10),
			["SliceCenter"] = Rect.new(7, 7, 7, 7)
		}), v3("TextLabel")({
			["Name"] = "Label",
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
			["BackgroundTransparency"] = 1,
			["BorderColor3"] = Color3.fromRGB(27, 42, 53),
			["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			["Position"] = UDim2.fromScale(0.525, 0.5),
			["Size"] = UDim2.fromScale(0.85, 0.8),
			["Text"] = "X",
			["TextColor3"] = Color3.fromRGB(255, 73, 73),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v4] = { v3("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 20
				}) }
		}) }
}
__set_list(v12, 1, {v13(v14)})
v11[v4] = v12
__set_list(v7, 1, {v8, v9, v10(v11)})
v6[v4] = v7
return v5(v6)