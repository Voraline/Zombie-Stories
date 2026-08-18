local v1 = game:GetService("ReplicatedStorage").Packages
local v_u_2 = require(v1.Fusion).Children
local function v_u_9(p3) -- name: commaFormat
	local v4 = math.floor(p3)
	local v5 = tostring(v4)
	local v6 = #v5
	if v6 <= 3 then
		return v5
	end
	local v7 = ""
	for v8 = 1, v6 do
		if v8 > 1 and (v6 - v8 + 1) % 3 == 0 then
			v7 = v7 .. ","
		end
		v7 = v7 .. v5:sub(v8, v8)
	end
	return v7
end
local v_u_10 = {
	["SP"] = {
		["label"] = "SP",
		["color"] = nil,
		["useImage"] = false,
		["enabled"] = true,
		["color"] = Color3.fromRGB(38, 175, 255)
	},
	["ZBucks"] = {
		["label"] = "Z$",
		["color"] = nil,
		["useImage"] = false,
		["enabled"] = true,
		["color"] = Color3.fromRGB(17, 255, 77)
	},
	["Gems"] = {
		["label"] = "GM",
		["color"] = nil,
		["useImage"] = false,
		["enabled"] = false,
		["color"] = Color3.fromRGB(255, 80, 80)
	},
	["ClassLevel"] = {
		["label"] = "",
		["color"] = nil,
		["useImage"] = true,
		["image"] = "rbxassetid://3187426822",
		["enabled"] = true,
		["color"] = Color3.fromRGB(255, 255, 255)
	}
}
return function(p_u_11)
	-- upvalues: (copy) v_u_10, (copy) v_u_9, (copy) v_u_2
	local v12 = p_u_11.scope
	local v_u_14 = v12:Computed(function(p13)
		-- upvalues: (copy) p_u_11, (ref) v_u_10
		return v_u_10[p13(p_u_11.CostType)] or v_u_10.SP
	end)
	local v16 = v12:Computed(function(p15)
		-- upvalues: (copy) v_u_14
		return not p15(v_u_14).useImage
	end)
	local v18 = v12:Computed(function(p17)
		-- upvalues: (copy) v_u_14
		return p17(v_u_14).useImage
	end)
	local v20 = v12:Computed(function(p19)
		-- upvalues: (copy) v_u_14
		return p19(v_u_14).label
	end)
	local v22 = v12:Computed(function(p21)
		-- upvalues: (copy) v_u_14
		return p21(v_u_14).color
	end)
	local v24 = v12:Computed(function(p23)
		-- upvalues: (copy) v_u_14
		return p23(v_u_14).image or ""
	end)
	local v26 = v12:Computed(function(p25)
		-- upvalues: (ref) v_u_9, (copy) p_u_11
		return v_u_9(p25(p_u_11.Amount))
	end)
	local v28 = v12:Computed(function(p27)
		-- upvalues: (copy) v_u_14
		return p27(v_u_14).enabled ~= false
	end)
	local v29 = v12:New("Frame")
	local v30 = {
		["Name"] = "CostTemplate",
		["AutomaticSize"] = Enum.AutomaticSize.X,
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(0, 1),
		["LayoutOrder"] = p_u_11.LayoutOrder or 0,
		["Visible"] = v28
	}
	local v31 = v_u_2
	local v32 = {}
	local v33 = v12:New("UIListLayout")({
		["Name"] = "UIListLayout",
		["FillDirection"] = nil,
		["HorizontalAlignment"] = nil,
		["SortOrder"] = nil,
		["VerticalAlignment"] = nil,
		["FillDirection"] = Enum.FillDirection.Horizontal,
		["HorizontalAlignment"] = Enum.HorizontalAlignment.Left,
		["SortOrder"] = Enum.SortOrder.LayoutOrder,
		["VerticalAlignment"] = Enum.VerticalAlignment.Center
	})
	local v34 = v12:New("TextLabel")({
		["Name"] = "Cost",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["AutomaticSize"] = Enum.AutomaticSize.X,
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		["LayoutOrder"] = 1,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["RichText"] = true,
		["Size"] = UDim2.fromScale(0, 0.5),
		["Text"] = v26,
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextScaled"] = true,
		["ZIndex"] = 2,
		[v_u_2] = { v12:New("UIStroke")({
				["Name"] = "UIStroke",
				["StrokeSizingMode"] = "ScaledSize",
				["Thickness"] = 0.06
			}) }
	})
	local v35 = v12:New("Frame")
	local v36 = {
		["Name"] = "TypeFrame",
		["AnchorPoint"] = Vector2.new(0, 0.5),
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["LayoutOrder"] = 2,
		["Size"] = UDim2.fromScale(0.8, 0.8),
		["SizeConstraint"] = Enum.SizeConstraint.RelativeYY,
		[v_u_2] = { v12:New("TextLabel")({
				["Name"] = "Label",
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["AutomaticSize"] = Enum.AutomaticSize.X,
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				["Position"] = UDim2.fromScale(0.5, 0.5),
				["RichText"] = true,
				["Size"] = UDim2.fromScale(0.8, 0.8),
				["Text"] = v20,
				["TextColor3"] = v22,
				["TextScaled"] = true,
				["Visible"] = v16,
				["ZIndex"] = 2,
				[v_u_2] = { v12:New("UIStroke")({
						["Name"] = "UIStroke",
						["StrokeSizingMode"] = "ScaledSize",
						["Thickness"] = 0.06
					}) }
			}), v12:New("ImageLabel")({
				["Name"] = "ImageLabel",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["Image"] = nil,
				["Position"] = nil,
				["ScaleType"] = nil,
				["Size"] = nil,
				["Visible"] = nil,
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["Image"] = v24,
				["Position"] = UDim2.fromScale(0.5, 0.5),
				["ScaleType"] = Enum.ScaleType.Fit,
				["Size"] = UDim2.fromScale(0.8, 0.8),
				["Visible"] = v18
			}) }
	}
	__set_list(v32, 1, {v33, v34, v35(v36)})
	v30[v31] = v32
	return v29(v30)
end