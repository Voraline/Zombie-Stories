local v1 = require(game.ReplicatedStorage.Packages.Fusion)
local v2 = v1.scoped(v1)
local v3 = v1.Children
local v4 = v2:New("ImageButton")
local v5 = {
	["Name"] = "ButtonTemplate",
	["Active"] = false,
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["Image"] = "rbxasset://textures/ui/TouchControlsSheet.png",
	["ImageRectSize"] = Vector2.new(220, 220),
	["Position"] = UDim2.new(0.5, -35, 0.5, -35),
	["Selectable"] = false,
	["Size"] = UDim2.fromOffset(70, 70),
	[v3] = { v2:New("TextLabel")({
			["Name"] = "TextLabel",
			["BackgroundColor3"] = nil,
			["BackgroundTransparency"] = 1,
			["BorderColor3"] = nil,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "AIM",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextStrokeTransparency"] = 0.8,
			["TextWrapped"] = true,
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
			["BorderColor3"] = Color3.fromRGB(27, 42, 53),
			["FontFace"] = Font.new("rbxasset://fonts/families/Zekton.json"),
			["Position"] = UDim2.fromScale(0.15, 0.307),
			["Size"] = UDim2.fromScale(0.7, 0.386),
			["TextColor3"] = Color3.fromRGB(182, 182, 182)
		}), v2:New("ImageLabel")({
			["Name"] = "ImageLabel",
			["AnchorPoint"] = nil,
			["BackgroundColor3"] = nil,
			["BackgroundTransparency"] = 1,
			["BorderColor3"] = nil,
			["BorderSizePixel"] = 0,
			["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png",
			["Position"] = nil,
			["Size"] = nil,
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
			["BorderColor3"] = Color3.fromRGB(27, 42, 53),
			["Position"] = UDim2.fromScale(0.5, 0.5),
			["Size"] = UDim2.fromScale(0.7, 0.7)
		}), v2:New("UIScale")({
			["Name"] = "UIScale"
		}) }
}
return v4(v5)