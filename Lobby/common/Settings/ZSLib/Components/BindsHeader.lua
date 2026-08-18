local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion).Children
local v_u_3 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = p4.scope
	local v6 = v5:New("Frame")
	local v7 = {
		["Name"] = "BindsHeader",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p4.LayoutOrder or 1,
		["Size"] = UDim2.fromScale(1, 0.09),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX
	}
	local v8 = v_u_2
	local v9 = {}
	local v10 = v5:New("Frame")
	local v11 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.new(),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.99, 0.85),
		[v_u_2] = {
			v5:New("UICorner")({}),
			v5:New("TextLabel")({
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
				["FontFace"] = v_u_3,
				["Position"] = UDim2.fromScale(0.01, 0.5),
				["Size"] = UDim2.fromScale(0.5, 0.9),
				["TextColor3"] = Color3.new(1, 1, 1),
				["TextXAlignment"] = Enum.TextXAlignment.Left
			}),
			v5:New("ImageLabel")({
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
			v5:New("ImageLabel")({
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
			v5:New("ImageLabel")({
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
	__set_list(v9, 1, {v10(v11)})
	v7[v8] = v9
	return v6(v7)
end