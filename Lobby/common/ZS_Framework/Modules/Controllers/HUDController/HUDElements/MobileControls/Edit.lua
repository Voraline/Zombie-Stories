local v1 = require(game.ReplicatedStorage.Packages.Fusion)
local v2 = v1.scoped(v1)
local v3 = v1.Children
local v4 = v2:New("ScreenGui")
local v5 = {
	["Name"] = "Edit",
	["IgnoreGuiInset"] = true,
	["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets,
	["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
}
local v6 = {}
local v7 = v2:New("Frame")
local v8 = {
	["Name"] = "Frame",
	["AnchorPoint"] = Vector2.new(0.5, 0),
	["BackgroundColor3"] = Color3.fromRGB(1, 21, 40),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["BorderSizePixel"] = 0,
	["ClipsDescendants"] = true,
	["Position"] = UDim2.fromScale(0.5, 0),
	["Size"] = UDim2.fromOffset(405, 0),
	[v3] = {
		v2:New("TextLabel")({
			["Name"] = "TextLabel",
			["AnchorPoint"] = nil,
			["BackgroundColor3"] = nil,
			["BackgroundTransparency"] = 1,
			["BorderColor3"] = nil,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "Tap on a button to edit",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			["AnchorPoint"] = Vector2.new(0.5, 0),
			["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
			["BorderColor3"] = Color3.fromRGB(27, 42, 53),
			["FontFace"] = Font.new("rbxasset://fonts/families/Nunito.json"),
			["Position"] = UDim2.fromScale(0.5, 0),
			["Size"] = UDim2.fromOffset(364, 50),
			["TextColor3"] = Color3.fromRGB(255, 255, 255)
		}),
		v2:New("TextButton")({
			["Name"] = "Save",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(31, 207, 0),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(26, 122, 0),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(202, 100),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Save",
			["TextColor3"] = Color3.fromRGB(0, 0, 0),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 22
				}) }
		}),
		v2:New("TextButton")({
			["Name"] = "Dec",
			["AnchorPoint"] = nil,
			["BackgroundColor3"] = nil,
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = nil,
			["BorderMode"] = nil,
			["BorderSizePixel"] = 5,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "-",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(75, 104, 139),
			["BorderColor3"] = Color3.fromRGB(66, 92, 122),
			["BorderMode"] = Enum.BorderMode.Inset,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(101, 100),
			["Size"] = UDim2.fromOffset(101, 50),
			["TextColor3"] = Color3.fromRGB(0, 0, 0)
		}),
		v2:New("TextButton")({
			["Name"] = "Cancel",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(188, 0, 0),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(122, 0, 0),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(304, 100),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Cancel",
			["TextColor3"] = Color3.fromRGB(0, 0, 0),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 22
				}) }
		}),
		v2:New("TextButton")({
			["Name"] = "Incr",
			["AnchorPoint"] = nil,
			["BackgroundColor3"] = nil,
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = nil,
			["BorderMode"] = nil,
			["BorderSizePixel"] = 5,
			["FontFace"] = nil,
			["Position"] = nil,
			["Size"] = nil,
			["Text"] = "+",
			["TextColor3"] = nil,
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(75, 104, 139),
			["BorderColor3"] = Color3.fromRGB(66, 92, 122),
			["BorderMode"] = Enum.BorderMode.Inset,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(0, 100),
			["Size"] = UDim2.fromOffset(101, 50),
			["TextColor3"] = Color3.fromRGB(0, 0, 0)
		}),
		v2:New("TextButton")({
			["Name"] = "Reset",
			["AnchorPoint"] = Vector2.new(0.5, 1),
			["BackgroundColor3"] = Color3.fromRGB(188, 94, 0),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(122, 81, 0),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.new(0.5, 0, 0, 150),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Reset",
			["TextColor3"] = Color3.fromRGB(0, 0, 0),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 22
				}) }
		}),
		v2:New("Frame")({
			["Name"] = "Frame",
			["BackgroundColor3"] = nil,
			["BackgroundTransparency"] = 0.25,
			["BorderColor3"] = nil,
			["BorderSizePixel"] = 0,
			["Size"] = nil,
			["ZIndex"] = 0,
			["BackgroundColor3"] = Color3.fromRGB(1, 21, 40),
			["BorderColor3"] = Color3.fromRGB(27, 42, 53),
			["Size"] = UDim2.fromOffset(405, 50)
		})
	}
}
local v9 = v7(v8)
local v10 = v2:New("Frame")
local v11 = {
	["Name"] = "Options",
	["AnchorPoint"] = Vector2.new(0.5, 0),
	["BackgroundColor3"] = Color3.fromRGB(1, 21, 40),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["BorderSizePixel"] = 0,
	["ClipsDescendants"] = true,
	["Position"] = UDim2.new(0.5, 0, 0, 50),
	["Size"] = UDim2.fromOffset(306, 0),
	[v3] = { v2:New("TextButton")({
			["Name"] = "Save",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(18, 188, 0),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(13, 138, 0),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(0, 50),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Save",
			["TextColor3"] = Color3.fromRGB(0, 0, 0),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 22
				}) }
		}), v2:New("TextButton")({
			["Name"] = "Cancel",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(188, 0, 0),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(122, 0, 0),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(102, 50),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Cancel",
			["TextColor3"] = Color3.fromRGB(0, 0, 0),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 22
				}) }
		}), v2:New("TextButton")({
			["Name"] = "Reset",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(188, 94, 0),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(122, 81, 0),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(204, 50),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Reset",
			["TextColor3"] = Color3.fromRGB(0, 0, 0),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 22
				}) }
		}) }
}
local v12 = v10(v11)
local v13 = v2:New("Frame")
local v14 = {
	["Name"] = "Presets",
	["AnchorPoint"] = Vector2.new(0.5, 0),
	["BackgroundColor3"] = Color3.fromRGB(1, 21, 40),
	["BackgroundTransparency"] = 1,
	["BorderColor3"] = Color3.fromRGB(27, 42, 53),
	["BorderSizePixel"] = 0,
	["ClipsDescendants"] = true,
	["Position"] = UDim2.new(0.5, 0, 0, 100),
	["Size"] = UDim2.fromOffset(306, 0),
	[v3] = {
		v2:New("TextLabel")({
			["Name"] = "HintLabel",
			["AnchorPoint"] = Vector2.new(0.5, 0),
			["BackgroundTransparency"] = 1,
			["FontFace"] = Font.new("rbxasset://fonts/families/Nunito.json"),
			["Position"] = UDim2.fromScale(0.5, 0),
			["Size"] = UDim2.fromOffset(306, 20),
			["Text"] = "Hold to save preset, tap to load",
			["TextColor3"] = Color3.fromRGB(180, 180, 180),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 14
				}) }
		}),
		v2:New("TextButton")({
			["Name"] = "Preset1",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(75, 104, 139),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(66, 92, 122),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(0, 70),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Preset 1",
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 18
				}) }
		}),
		v2:New("TextButton")({
			["Name"] = "Preset2",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(75, 104, 139),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(66, 92, 122),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(102, 70),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Preset 2",
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 18
				}) }
		}),
		v2:New("TextButton")({
			["Name"] = "Preset3",
			["AnchorPoint"] = Vector2.new(0, 1),
			["BackgroundColor3"] = Color3.fromRGB(75, 104, 139),
			["BackgroundTransparency"] = 0.75,
			["BorderColor3"] = Color3.fromRGB(66, 92, 122),
			["BorderMode"] = Enum.BorderMode.Inset,
			["BorderSizePixel"] = 5,
			["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json"),
			["Position"] = UDim2.fromOffset(204, 70),
			["Size"] = UDim2.fromOffset(102, 50),
			["Text"] = "Preset 3",
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["TextScaled"] = true,
			["TextSize"] = 14,
			["TextWrapped"] = true,
			[v3] = { v2:New("UITextSizeConstraint")({
					["Name"] = "UITextSizeConstraint",
					["MaxTextSize"] = 18
				}) }
		})
	}
}
__set_list(v6, 1, {v9, v12, v13(v14)})
v5[v3] = v6
return v4(v5)