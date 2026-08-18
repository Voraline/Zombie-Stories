local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion).Children
local v_u_3 = require(script.Parent.Parent.SliderModule)
local v_u_4 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p_u_5)
	-- upvalues: (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
	local v6 = p_u_5.scope
	local v7 = p_u_5.Description ~= nil
	local v8 = v6:New("ImageLabel")({
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
	local v9 = v6:New("TextButton")({
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
	})
	local v10 = v6:New("ImageLabel")({
		["Name"] = "Slide",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundTransparency"] = 1,
		["Image"] = "rbxassetid://4175209485",
		["Position"] = UDim2.fromScale(0.3, 0.5),
		["Size"] = UDim2.fromScale(0.016, 0.016),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
		["SliceCenter"] = Rect.new(7, 7, 7, 7),
		["ZIndex"] = 3,
		[v_u_2] = { v9 }
	})
	local v11 = v6:New("Frame")({
		["Name"] = "Back",
		["AnchorPoint"] = Vector2.new(0, 0.5),
		["BackgroundColor3"] = Color3.new(),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0, 0.5),
		["Size"] = UDim2.fromScale(1, 0.75),
		[v_u_2] = { v6:New("UICorner")({
				["CornerRadius"] = UDim.new(1, 0)
			}) }
	})
	local v12 = v6:New("ImageLabel")({
		["Name"] = "SlidingBase",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundTransparency"] = 1,
		["Image"] = "rbxassetid://2851928361",
		["ImageColor3"] = Color3.fromRGB(33, 33, 33),
		["ImageTransparency"] = 1,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["ScaleType"] = Enum.ScaleType.Slice,
		["Size"] = UDim2.fromScale(1, 1),
		["SliceCenter"] = Rect.new(7, 7, 7, 7),
		[v_u_2] = { v8, v10, v11 }
	})
	local v13 = v6:New("ImageLabel")({
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
		["SliceCenter"] = Rect.new(7, 7, 7, 7),
		[v_u_2] = { v12 }
	})
	local v_u_14 = v6:New("TextBox")({
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
		["FontFace"] = v_u_4,
		["PlaceholderColor3"] = Color3.new(1, 1, 1),
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(1, 0.7),
		["TextColor3"] = Color3.new(1, 1, 1)
	})
	local v15 = v6:New("ImageLabel")({
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
		[v_u_2] = { v_u_14, v6:New("UICorner")({
				["CornerRadius"] = UDim.new(0.2, 0)
			}) }
	})
	local v16 = v6:New("Frame")
	local v17 = {
		["Name"] = "NumberSlider",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p_u_5.LayoutOrder or 1
	}
	local v18
	if v7 then
		v18 = UDim2.fromScale(1, 0.14)
	else
		v18 = UDim2.fromScale(1, 0.11)
	end
	v17.Size = v18
	v17.SizeConstraint = Enum.SizeConstraint.RelativeXX
	v17.Visible = p_u_5.Visible == nil and true or p_u_5.Visible
	local v19 = v_u_2
	local v20 = {}
	local v21 = v6:New("Frame")
	local v22 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.new(),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.99, 0.85)
	}
	local v23 = v_u_2
	local v24 = {}
	local v25 = v6:New("UICorner")({})
	local v26 = v6:New("TextLabel")({
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
		["FontFace"] = v_u_4,
		["Position"] = UDim2.fromScale(0.01, 0.04),
		["Size"] = UDim2.fromScale(0.82, 0.06),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
		["Text"] = p_u_5.Text,
		["TextColor3"] = Color3.new(1, 1, 1),
		["TextXAlignment"] = Enum.TextXAlignment.Left
	})
	local v27
	if v7 then
		v27 = v6:New("TextLabel")({
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
			["FontFace"] = v_u_4,
			["Position"] = UDim2.fromScale(0.01, 0.75),
			["Size"] = UDim2.fromScale(0.82, 0.05),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
			["Text"] = p_u_5.Description,
			["TextColor3"] = Color3.new(1, 1, 1),
			["TextXAlignment"] = Enum.TextXAlignment.Left
		})
	else
		v27 = nil
	end
	__set_list(v24, 1, {v25, v13, v15, v26, v27})
	v22[v23] = v24
	__set_list(v20, 1, {v21(v22)})
	v17[v19] = v20
	local v28 = v16(v17)
	local v29 = v_u_3.new(v12, v10, v9, v8, {
		["min"] = p_u_5.Min,
		["max"] = p_u_5.Max,
		["snapFactor"] = p_u_5.SnapFactor
	}, {
		["TextBox"] = v_u_14
	})
	local v30 = v29:Activate()
	v30(p_u_5.Default)
	v_u_14:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (copy) v_u_14, (copy) p_u_5
		if not v_u_14:IsFocused() and p_u_5.OnChanged then
			local v31 = p_u_5.OnChanged
			local v32 = v_u_14.Text
			v31((tonumber(v32)))
		end
	end)
	v29.InteractionEnded.Event:Connect(function(p33)
		-- upvalues: (copy) p_u_5
		if p_u_5.OnChanged then
			p_u_5.OnChanged(p33, true)
		end
	end)
	return v28, v30
end