local v1 = require("@game/ReplicatedStorage/common/Fusion")
local v_u_2 = v1.New
local v_u_3 = v1.Children
local v_u_4 = v1.OnEvent
return function(p5)
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	local v6 = v_u_2("Frame")
	local v7 = {
		["Name"] = "DamageGraph",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(0.5, 0.5),
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Visible"] = p5.isOpen
	}
	local v8 = v_u_3
	local v9 = {}
	local v10 = v_u_2("TextButton")
	local v11 = {
		["Name"] = "Exit",
		["Text"] = "",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(40, 49, 63),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["BorderSizePixel"] = 0,
		["ClipsDescendants"] = true,
		["Position"] = UDim2.fromScale(0.935, -0.1),
		["Size"] = UDim2.fromScale(0.3, 0.15),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
		["ZIndex"] = 5,
		[v_u_4("MouseButton1Click")] = p5.onClose
	}
	local v12 = v_u_3
	local v13 = {}
	local v14 = v_u_2("Frame")
	local v15 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(63, 22, 22),
		["BackgroundTransparency"] = 0.2,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.new(1, 0, 1, -5),
		["ZIndex"] = 3,
		[v_u_3] = {
			v_u_2("Frame")({
				["Name"] = "Point",
				["AnchorPoint"] = nil,
				["BackgroundColor3"] = nil,
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = nil,
				["Position"] = nil,
				["ZIndex"] = 4,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["Position"] = UDim2.fromScale(1, 0.5)
			}),
			v_u_2("TextLabel")({
				["Name"] = "BottomLabel",
				["FontFace"] = nil,
				["Text"] = "CLOSE",
				["TextColor3"] = nil,
				["TextScaled"] = true,
				["TextSize"] = 14,
				["TextWrapped"] = true,
				["TextXAlignment"] = nil,
				["AnchorPoint"] = nil,
				["BackgroundColor3"] = nil,
				["BackgroundTransparency"] = 1,
				["BorderColor3"] = nil,
				["Position"] = nil,
				["Size"] = nil,
				["ZIndex"] = 6,
				["FontFace"] = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				["TextColor3"] = Color3.fromRGB(255, 169, 169),
				["TextXAlignment"] = Enum.TextXAlignment.Left,
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
				["BorderColor3"] = Color3.fromRGB(27, 42, 53),
				["Position"] = UDim2.fromScale(0.08, 0.5),
				["Size"] = UDim2.fromScale(0.88, 0.9)
			}),
			v_u_2("UIGradient")({
				["Name"] = "UIGradient",
				["Color"] = nil,
				["Rotation"] = 90,
				["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(0.536, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
			}),
			v_u_2("UICorner")({
				["Name"] = "UICorner"
			})
		}
	}
	__set_list(v13, 1, {v14(v15)})
	v11[v12] = v13
	__set_list(v9, 1, {v10(v11)})
	v7[v8] = v9
	return v6(v7)
end