return function(p_u_1)
	local v2 = p_u_1.scope
	local v17 = v2:ForPairs(p_u_1.PlayerList, function(_, p3, p4, p_u_5)
		local v6 = p3:New("Frame")
		local v8 = {
			["Size"] = UDim2.new(0.2, 0, 1, 0),
			["BackgroundColor3"] = Color3.new(0.180392, 0.180392, 0.180392),
			["LayoutOrder"] = p3:Computed(function(p7)
				-- upvalues: (copy) p_u_5
				return p7(p_u_5.Score) * -1
			end),
			["Visible"] = p_u_5.Visible
		}
		local v9 = p3.Children
		local v10 = {}
		local v11 = p3:New("TextLabel")({
			["Size"] = nil,
			["Position"] = nil,
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["Text"] = nil,
			["TextColor3"] = nil,
			["Font"] = nil,
			["TextScaled"] = true,
			["ZIndex"] = 2,
			["Size"] = UDim2.new(0.8, 0, 0.2, 0),
			["Position"] = UDim2.new(0.5, 0, 0.1, 0),
			["AnchorPoint"] = Vector2.new(0.5, 0),
			["Text"] = p_u_5.Name,
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["Font"] = Enum.Font.GothamBlack
		})
		local v12 = p3:New("TextLabel")({
			["Size"] = nil,
			["Position"] = nil,
			["AnchorPoint"] = nil,
			["BackgroundTransparency"] = 1,
			["Text"] = nil,
			["TextColor3"] = nil,
			["Font"] = nil,
			["TextScaled"] = true,
			["ZIndex"] = 2,
			["Size"] = UDim2.new(0.8, 0, 0.2, 0),
			["Position"] = UDim2.new(0.5, 0, 0.9, 0),
			["AnchorPoint"] = Vector2.new(0.5, 1),
			["Text"] = p_u_5.Score,
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["Font"] = Enum.Font.GothamBold
		})
		local v13 = p3:New("UICorner")({
			["CornerRadius"] = UDim.new(0.1, 0)
		})
		local v14 = p3:New("UIAspectRatioConstraint")({
			["AspectRatio"] = 1
		})
		local v15 = p3:New("ImageLabel")
		local v16 = {
			["Size"] = UDim2.new(0.9, 0, 0.9, 0),
			["Position"] = UDim2.new(0.5, 0, 0.5, 0),
			["AnchorPoint"] = Vector2.new(0.5, 0.5),
			["Image"] = p_u_5.Headshot,
			["BackgroundColor3"] = Color3.new(0.078431, 0.078431, 0.078431),
			[p3.Children] = { p3:New("UICorner")({
					["CornerRadius"] = UDim.new(0.1, 0)
				}) }
		}
		__set_list(v10, 1, {v11, v12, v13, v14, v15(v16)})
		v8[v9] = v10
		return p4, v6(v8)
	end)
	local v_u_18 = v2:Value(UDim2.new(0.5, 0, -1, 0))
	task.delay(0.25, function()
		-- upvalues: (copy) v_u_18
		v_u_18:set(UDim2.new(0.5, 0, 0, 0))
	end)
	local v19 = v2:New("Frame")
	local v20 = {
		["Size"] = UDim2.new(0.45, 0, 0.15, 0),
		["Position"] = v2:Tween(v_u_18, TweenInfo.new(0.25)),
		["AnchorPoint"] = Vector2.new(0.5, 0),
		["BackgroundTransparency"] = 1
	}
	local v21 = v2.Children
	local v22 = {}
	local v27 = v2:New("TextLabel")({
		["Size"] = nil,
		["Position"] = nil,
		["AnchorPoint"] = nil,
		["BackgroundColor3"] = nil,
		["BackgroundTransparency"] = 0,
		["Text"] = nil,
		["TextColor3"] = nil,
		["Font"] = nil,
		["TextScaled"] = true,
		["Size"] = UDim2.new(0.125, 0, 0.3, 0),
		["Position"] = UDim2.new(0.5, 0, -0.05, 0),
		["AnchorPoint"] = Vector2.new(0.5, 1),
		["BackgroundColor3"] = Color3.new(0.113725, 0.113725, 0.113725),
		["Text"] = v2:Computed(function(p23)
			-- upvalues: (copy) p_u_1
			local v24 = p23(p_u_1.TimeLeft)
			local v25 = string.format
			local v26 = v24 / 60
			return v25("%02d:%02d", math.floor(v26), v24 % 60)
		end),
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["Font"] = Enum.Font.GothamBlack
	})
	local v28 = v2:New("Frame")
	local v29 = {
		["Size"] = UDim2.new(1, 0, 1, 0),
		["BackgroundTransparency"] = 1,
		[v2.Children] = { v17, v2:New("UIListLayout")({
				["SortOrder"] = Enum.SortOrder.LayoutOrder,
				["Padding"] = UDim.new(0.05, 0),
				["FillDirection"] = Enum.FillDirection.Horizontal,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
				["VerticalAlignment"] = Enum.VerticalAlignment.Center
			}) }
	}
	__set_list(v22, 1, {v27, v28(v29)})
	v20[v21] = v22
	return v19(v20)
end