local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
local v_u_5 = v2.peek
local v_u_6 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p_u_7)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	local v8 = p_u_7.scope
	local v_u_9 = v8:Value(p_u_7.Default)
	local v11 = v8:Spring(v8:Computed(function(p10)
		-- upvalues: (copy) v_u_9
		if p10(v_u_9) then
			return UDim2.new(1, 0, 0.5, 0)
		else
			return UDim2.new(0.4, 0, 0.5, 0)
		end
	end), 25, 1)
	local v13 = v8:Spring(v8:Computed(function(p12)
		-- upvalues: (copy) v_u_9
		if p12(v_u_9) then
			return UDim2.new(0.75, 0, 1, 0)
		else
			return UDim2.new(0, 0, 1, 0)
		end
	end), 25, 1)
	local v14 = p_u_7.Description ~= nil
	local v15 = v8:New("Frame")
	local v16 = {
		["Name"] = "Toggle",
		["BackgroundTransparency"] = 1,
		["LayoutOrder"] = p_u_7.LayoutOrder or 1
	}
	local v17
	if v14 then
		v17 = UDim2.fromScale(1, 0.11)
	else
		v17 = UDim2.fromScale(1, 0.08)
	end
	v16.Size = v17
	v16.SizeConstraint = Enum.SizeConstraint.RelativeXX
	v16.Visible = p_u_7.Visible == nil and true or p_u_7.Visible
	local v18 = v_u_3
	local v19 = {}
	local v20 = v8:New("Frame")
	local v21 = {
		["Name"] = "Frame",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.new(),
		["BackgroundTransparency"] = 0.8,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.99, 0.85)
	}
	local v22 = v_u_3
	local v23 = {}
	local v24 = v8:New("UICorner")({})
	local v25 = v8:New("ImageButton")
	local v27 = {
		["Name"] = "Toggle",
		["AnchorPoint"] = Vector2.new(1, 0.5),
		["BackgroundTransparency"] = 1,
		["Image"] = "rbxassetid://2851928361",
		["ImageColor3"] = Color3.fromRGB(33, 33, 33),
		["ImageTransparency"] = 1,
		["Position"] = UDim2.fromScale(1, 0.5),
		["ScaleType"] = Enum.ScaleType.Slice,
		["Size"] = UDim2.fromScale(0.18, 1),
		["SliceCenter"] = Rect.new(7, 7, 7, 7),
		[v_u_4("MouseButton1Click")] = function()
			-- upvalues: (copy) p_u_7, (ref) v_u_5, (copy) v_u_9
			if p_u_7.ButtonSound then
				p_u_7.ButtonSound:Play()
			end
			local v26 = not v_u_5(v_u_9)
			v_u_9:set(v26)
			if p_u_7.OnChanged then
				p_u_7.OnChanged(v26)
			end
		end,
		[v_u_3] = { v8:New("Frame")({
				["Name"] = "Back",
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundColor3"] = Color3.new(1, 1, 1),
				["BackgroundTransparency"] = 0.95,
				["Position"] = UDim2.fromScale(0, 0.5),
				["Size"] = UDim2.fromScale(1, 1),
				[v_u_3] = { v8:New("UICorner")({
						["CornerRadius"] = UDim.new(0.17, 0)
					}) }
			}), v8:New("Frame")({
				["Name"] = "Fill",
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundTransparency"] = 1,
				["ClipsDescendants"] = true,
				["Position"] = UDim2.fromScale(0, 0.5),
				["Size"] = v13,
				["ZIndex"] = 2,
				[v_u_3] = { v8:New("Frame")({
						["Name"] = "Frame",
						["BackgroundColor3"] = Color3.fromRGB(255, 184, 84),
						["Size"] = UDim2.fromScale(100, 1),
						[v_u_3] = { v8:New("UICorner")({
								["CornerRadius"] = UDim.new(0.17, 0)
							}) }
					}) }
			}), v8:New("Frame")({
				["Name"] = "Slide",
				["AnchorPoint"] = Vector2.new(1, 0.5),
				["BackgroundColor3"] = Color3.new(1, 1, 1),
				["Position"] = v11,
				["Size"] = UDim2.fromScale(0.4, 1),
				["ZIndex"] = 3,
				[v_u_3] = { v8:New("UICorner")({
						["CornerRadius"] = UDim.new(0.2, 0)
					}) }
			}) }
	}
	local v28 = v25(v27)
	local v29 = v8:New("TextLabel")({
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
		["FontFace"] = v_u_6,
		["Position"] = UDim2.fromScale(0.01, 0),
		["Size"] = UDim2.fromScale(0.8, 0.06),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
		["Text"] = p_u_7.Text,
		["TextColor3"] = Color3.new(1, 1, 1),
		["TextXAlignment"] = Enum.TextXAlignment.Left
	})
	local v30
	if v14 then
		v30 = v8:New("TextLabel")({
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
			["FontFace"] = v_u_6,
			["Position"] = UDim2.fromScale(0.01, 0.96),
			["Size"] = UDim2.fromScale(0.8, 0.05),
			["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
			["Text"] = p_u_7.Description,
			["TextColor3"] = Color3.new(1, 1, 1),
			["TextXAlignment"] = Enum.TextXAlignment.Left
		})
	else
		v30 = nil
	end
	__set_list(v23, 1, {v24, v28, v29, v30})
	v21[v22] = v23
	__set_list(v19, 1, {v20(v21)})
	v16[v18] = v19
	return v15(v16), function(p31)
		-- upvalues: (copy) v_u_9
		v_u_9:set(p31)
	end
end