local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion).Children
local v_u_3 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p4)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = p4.scope
	local v6 = p4.Description ~= nil
	local v7 = v5:New("Frame")
	local v8 = {
		["Name"] = "Bind",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p4.LayoutOrder or 1,
		["Size"] = UDim2.fromScale(1, 0.16),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
		["Visible"] = p4.Visible == nil and true or p4.Visible
	}
	local v9 = v_u_2
	local v10 = {}
	local v11 = v5:New("Frame")
	local v12 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.new(),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.99, 0.85)
	}
	local v13 = v_u_2
	local v14 = {}
	local v15 = v5:New("UICorner")({})
	local v16 = v5:New("TextLabel")
	local v17 = {
		["Name"] = "Label",
		["AnchorPoint"] = nil,
		["BackgroundTransparency"] = 1,
		["FontFace"] = nil,
		["Position"] = nil,
		["Size"] = nil,
		["SizeConstraint"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextXAlignment"] = nil,
		["AnchorPoint"] = Vector2.new(0, 0.5),
		["FontFace"] = v_u_3
	}
	local v18
	if v6 then
		v18 = UDim2.fromScale(0.01, 0.33)
	else
		v18 = UDim2.fromScale(0.01, 0.5)
	end
	v17.Position = v18
	v17.Size = UDim2.fromScale(0.62, 0.07)
	v17.SizeConstraint = Enum.SizeConstraint.RelativeXX
	v17.Text = p4.Text
	v17.TextColor3 = Color3.new(1, 1, 1)
	v17.TextXAlignment = Enum.TextXAlignment.Left
	__set_list(v14, 1, {v15, v16(v17), v5:New("TextLabel")({
	["Name"] = "DescriptionLabel",
	["AnchorPoint"] = nil,
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["Position"] = nil,
	["Size"] = nil,
	["SizeConstraint"] = nil,
	["Text"] = nil,
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextTransparency"] = 0.5,
	["TextXAlignment"] = nil,
	["Visible"] = nil,
	["AnchorPoint"] = Vector2.new(0, 1),
	["FontFace"] = v_u_3,
	["Position"] = UDim2.fromScale(0.01, 0.83),
	["Size"] = UDim2.fromScale(0.8, 0.04),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	["Text"] = not v6 and "" or p4.Description,
	["TextColor3"] = Color3.new(1, 1, 1),
	["TextXAlignment"] = Enum.TextXAlignment.Left,
	["Visible"] = v6
}), v5:New("ImageButton")({
	["Name"] = "GamepadButton",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(107, 107, 107),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	["ImageTransparency"] = 1,
	["Position"] = UDim2.fromScale(0.99, 0.5),
	["Size"] = UDim2.fromScale(0.11, 0.11),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	[v_u_2] = { v5:New("UICorner")({
			["CornerRadius"] = UDim.new(0.1, 0)
		}), v5:New("UIStroke")({
			["Color"] = Color3.fromRGB(255, 184, 84)
		}) }
}), v5:New("ImageButton")({
	["Name"] = "MouseButton",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(107, 107, 107),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	["ImageTransparency"] = 1,
	["Position"] = UDim2.new(0.87, -2, 0.5, 0),
	["Size"] = UDim2.fromScale(0.11, 0.11),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	[v_u_2] = { v5:New("UICorner")({
			["CornerRadius"] = UDim.new(0.1, 0)
		}), v5:New("UIStroke")({
			["Color"] = Color3.fromRGB(255, 184, 84)
		}) }
}), v5:New("ImageButton")({
	["Name"] = "KeyboardButton",
	["AnchorPoint"] = Vector2.new(1, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(107, 107, 107),
	["BackgroundTransparency"] = 0.9,
	["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	["ImageTransparency"] = 1,
	["Position"] = UDim2.new(0.75, -4, 0.5, 0),
	["Size"] = UDim2.fromScale(0.11, 0.11),
	["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
	[v_u_2] = { v5:New("UICorner")({
			["CornerRadius"] = UDim.new(0.1, 0)
		}), v5:New("UIStroke")({
			["Color"] = Color3.fromRGB(255, 184, 84)
		}) }
})})
	v12[v13] = v14
	__set_list(v10, 1, {v11(v12)})
	v8[v9] = v10
	return v7(v8)
end