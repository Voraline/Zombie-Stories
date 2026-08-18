local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
local v_u_5 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p_u_6)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_4
	local v7 = p_u_6.scope
	local v8 = p_u_6.Description ~= nil
	local v9 = v7:New("Frame")
	local v10 = {
		["Name"] = "Button",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p_u_6.LayoutOrder or 1
	}
	local v11
	if v8 then
		v11 = UDim2.fromScale(1, 0.11)
	else
		v11 = UDim2.fromScale(1, 0.08)
	end
	v10.Size = v11
	v10.SizeConstraint = Enum.SizeConstraint.RelativeXX
	v10.Visible = p_u_6.Visible == nil and true or p_u_6.Visible
	local v12 = v_u_3
	local v13 = {}
	local v14 = v7:New("Frame")
	local v15 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.new(),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.99, 0.85)
	}
	local v16 = v_u_3
	local v17 = {}
	local v18 = v7:New("TextLabel")({
		["Name"] = "Label",
		["BackgroundTransparency"] = 1,
		["FontFace"] = nil,
		["Position"] = nil,
		["Size"] = nil,
		["SizeConstraint"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextXAlignment"] = nil,
		["FontFace"] = v_u_5,
		["Position"] = UDim2.fromScale(0.01, 0.04),
		["Size"] = UDim2.fromScale(0.82, 0.06),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
		["Text"] = p_u_6.Text,
		["TextColor3"] = Color3.new(1, 1, 1),
		["TextXAlignment"] = Enum.TextXAlignment.Left
	})
	local v19 = v7:New("UICorner")({})
	local v20 = v7:New("Frame")
	local v21 = {
		["Name"] = "Toggle",
		["AnchorPoint"] = Vector2.new(1, 0.5),
		["BackgroundColor3"] = p_u_6.FillColor or Color3.fromRGB(49, 49, 49),
		["BackgroundTransparency"] = 0.95,
		["Position"] = UDim2.new(1, -3, 0.5, 0),
		["Size"] = UDim2.fromScale(0.15, 1),
		[v_u_3] = { v7:New("UICorner")({
				["CornerRadius"] = UDim.new(0.18, 0)
			}), v7:New("TextButton")({
				["Name"] = "Button",
				["BackgroundTransparency"] = 1,
				["Size"] = UDim2.fromScale(1, 1),
				["TextTransparency"] = 1,
				[v_u_4("MouseButton1Click")] = function()
					-- upvalues: (copy) p_u_6
					if p_u_6.ButtonSound then
						p_u_6.ButtonSound:Play()
					end
					if p_u_6.OnClick then
						p_u_6.OnClick()
					end
				end,
				[v_u_3] = { v7:New("TextLabel")({
						["Name"] = "Label",
						["AnchorPoint"] = nil,
						["BackgroundTransparency"] = 1,
						["FontFace"] = nil,
						["Position"] = nil,
						["Size"] = nil,
						["Text"] = nil,
						["TextColor3"] = nil,
						["TextScaled"] = true,
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["FontFace"] = v_u_5,
						["Position"] = UDim2.fromScale(0.5, 0.5),
						["Size"] = UDim2.fromScale(0.9, 0.9),
						["Text"] = p_u_6.ButtonText,
						["TextColor3"] = p_u_6.TextColor or Color3.fromRGB(255, 184, 84)
					}) }
			}), v7:New("UIStroke")({
				["Color"] = nil,
				["Thickness"] = 3,
				["Color"] = p_u_6.OutlineColor or Color3.fromRGB(255, 184, 84)
			}) }
	}
	local v22 = v20(v21)
	local v23
	if v8 then
		v23 = v7:New("TextLabel")({
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
			["AnchorPoint"] = Vector2.new(0, 1),
			["FontFace"] = v_u_5,
			["Position"] = UDim2.fromScale(0.01, 0.96),
			["Size"] = UDim2.fromScale(0.82, 0.05),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
			["Text"] = p_u_6.Description,
			["TextColor3"] = Color3.new(1, 1, 1),
			["TextXAlignment"] = Enum.TextXAlignment.Left
		})
	else
		v23 = nil
	end
	__set_list(v17, 1, {v18, v19, v22, v23})
	v15[v16] = v17
	__set_list(v13, 1, {v14(v15)})
	v10[v12] = v13
	return v9(v10)
end