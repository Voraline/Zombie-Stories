local v1 = game:GetService("ReplicatedStorage").Packages
local v_u_2 = require(v1.Fusion).Children
return function(p_u_3)
	-- upvalues: (copy) v_u_2
	local v4 = p_u_3.scope
	local v5 = p_u_3.CornerRadius or 128
	local v6 = p_u_3.StrokeThickness or 50
	local v7 = p_u_3.LockImage or "rbxassetid://6031082533"
	local v_u_8 = p_u_3.ShowLockIcon == nil and true or p_u_3.ShowLockIcon
	local v9 = p_u_3.ZOffset or 0
	local v10 = p_u_3.TextMaxSize or Vector2.new(2000, 514)
	local v_u_13 = v4:Computed(function(p11)
		-- upvalues: (copy) p_u_3
		local v12 = p_u_3.Locked
		return v12 == nil and true or p11(v12)
	end)
	local v16 = v4:Computed(function(p14)
		-- upvalues: (copy) p_u_3
		local v15 = p_u_3.RequiresText
		return v15 == nil and "" or p14(v15)
	end)
	local v18 = v4:Computed(function(p17)
		-- upvalues: (copy) p_u_3, (copy) v_u_13
		if p_u_3.AlwaysOnTop == nil then
			return p17(v_u_13)
		else
			return p17(p_u_3.AlwaysOnTop)
		end
	end)
	local v20 = v4:Computed(function(p19)
		-- upvalues: (copy) v_u_8, (copy) v_u_13
		if v_u_8 then
			return p19(v_u_13)
		else
			return false
		end
	end)
	local v22 = v4:Computed(function(p21)
		-- upvalues: (copy) v_u_13
		return p21(v_u_13) and 0.3 or 0.7
	end)
	local v23 = v4:New("SurfaceGui")
	local v24 = {
		["Name"] = "LockOverlay",
		["Face"] = Enum.NormalId.Top,
		["ResetOnSpawn"] = false,
		["SizingMode"] = Enum.SurfaceGuiSizingMode.PixelsPerStud,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		["AlwaysOnTop"] = v18,
		["ZOffset"] = v9,
		["Adornee"] = p_u_3.Adornee,
		[v_u_2] = { v4:New("Frame")({
				["Name"] = "Frame",
				["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
				["BackgroundTransparency"] = v22,
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["BorderSizePixel"] = 0,
				["Size"] = UDim2.fromScale(1, 1),
				[v_u_2] = {
					v4:New("UICorner")({
						["Name"] = "UICorner",
						["CornerRadius"] = nil,
						["CornerRadius"] = UDim.new(0, v5)
					}),
					v4:New("UIStroke")({
						["Name"] = "UIStroke",
						["Thickness"] = nil,
						["Thickness"] = v6
					}),
					v4:New("UIPadding")({
						["Name"] = "UIPadding",
						["PaddingLeft"] = nil,
						["PaddingRight"] = nil,
						["PaddingLeft"] = UDim.new(0, 15),
						["PaddingRight"] = UDim.new(0, 15)
					}),
					v4:New("UIListLayout")({
						["Name"] = "UIListLayout",
						["HorizontalAlignment"] = nil,
						["SortOrder"] = nil,
						["VerticalAlignment"] = nil,
						["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
						["SortOrder"] = Enum.SortOrder.LayoutOrder,
						["VerticalAlignment"] = Enum.VerticalAlignment.Center
					}),
					v4:New("ImageLabel")({
						["Name"] = "LockIcon",
						["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
						["BackgroundTransparency"] = 1,
						["BorderColor3"] = Color3.fromRGB(0, 0, 0),
						["BorderSizePixel"] = 0,
						["Image"] = v7,
						["LayoutOrder"] = 1,
						["ScaleType"] = Enum.ScaleType.Fit,
						["Size"] = UDim2.fromScale(1, 0.5),
						["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
						["Visible"] = v20,
						[v_u_2] = { v4:New("UISizeConstraint")({
								["Name"] = "UISizeConstraint",
								["MaxSize"] = nil,
								["MaxSize"] = Vector2.new(1500, 1280)
							}) }
					}),
					v4:New("TextLabel")({
						["Name"] = "Requires",
						["AnchorPoint"] = Vector2.new(0.5, 0.5),
						["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
						["BackgroundTransparency"] = 1,
						["BorderColor3"] = Color3.fromRGB(0, 0, 0),
						["BorderSizePixel"] = 0,
						["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
						["LayoutOrder"] = 2,
						["Position"] = UDim2.fromScale(0.5, 0.7),
						["RichText"] = true,
						["Size"] = UDim2.fromScale(1, 0.2),
						["SizeConstraint"] = Enum.SizeConstraint.RelativeXX,
						["Text"] = v16,
						["TextColor3"] = Color3.fromRGB(255, 142, 142),
						["TextScaled"] = true,
						["TextSize"] = 14,
						["TextWrapped"] = true,
						["Visible"] = v_u_13,
						["ZIndex"] = 2,
						[v_u_2] = { v4:New("UIStroke")({
								["Name"] = "UIStroke",
								["Thickness"] = 0.06
							}), v4:New("UISizeConstraint")({
								["Name"] = "UISizeConstraint",
								["MaxSize"] = nil,
								["MaxSize"] = v10
							}) }
					})
				}
			}) }
	}
	return v23(v24)
end