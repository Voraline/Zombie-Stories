local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
local v_u_5 = v2.peek
return function(p_u_6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
	local v7 = p_u_6.scope
	local v_u_8 = p_u_6.Disabled or v7:Value(false)
	local v_u_9 = p_u_6.isHovering or v7:Value(false)
	local v_u_10 = p_u_6.isHeldDown or v7:Value(false)
	local v12 = v7:Computed(function(p11)
		-- upvalues: (copy) v_u_10, (copy) v_u_9
		if p11(v_u_10) then
			return UDim2.new(0.9, 0, 0.9, 0)
		elseif p11(v_u_9) then
			return UDim2.new(1.05, 0, 1.05, 0)
		else
			return UDim2.new(1, 0, 1, 0)
		end
	end)
	local v13 = p_u_6.Text or ""
	local v14 = p_u_6.Font or Enum.Font.SourceSans
	local v15 = p_u_6.TextScaled or false
	local v16 = p_u_6.TextSize or 14
	local v17 = p_u_6.Position or UDim2.new(0.5, 0, 0.5, 0)
	local v18 = p_u_6.Size or UDim2.new(1, 0, 1, 0)
	local v19 = p_u_6.AnchorPoint or Vector2.new(0.5, 0.5)
	local v20 = p_u_6.TextColor3 or Color3.fromRGB(255, 255, 255)
	local v21 = p_u_6.TextTransparency or 0
	local v22 = p_u_6.TextWrapped or false
	local v23 = p_u_6.TextXAlignment or Enum.TextXAlignment.Center
	local v24 = p_u_6.TextYAlignment or Enum.TextYAlignment.Center
	local v25 = p_u_6.TextTruncate or Enum.TextTruncate.None
	local v26 = p_u_6.TextStrokeTransparency or 1
	local v27 = p_u_6.TextStrokeColor3 or Color3.fromRGB(0, 0, 0)
	local v28 = p_u_6.BackgroundTransparency or 1
	local v_u_29 = p_u_6.BackgroundColor3 or Color3.fromRGB(0, 0, 0)
	local v30 = p_u_6.LayoutOrder or 0
	local v33 = v7:Computed(function(p31)
		-- upvalues: (copy) v_u_29, (copy) v_u_8
		local v32 = p31(v_u_29)
		if p31(v_u_8) then
			return Color3.fromRGB(100, 100, 100)
		else
			return v32
		end
	end)
	local v34 = p_u_6.UIAspectRatio
	local v35
	if v34 then
		v35 = v7:New("UIAspectRatioConstraint")({
			["AspectRatio"] = v34
		})
	else
		v35 = nil
	end
	return v7:New("Frame")({
		["Size"] = v18,
		["Position"] = v17,
		["AnchorPoint"] = v19,
		["BackgroundTransparency"] = 1,
		["ZIndex"] = p_u_6.ZIndex or 1,
		["LayoutOrder"] = v30,
		[v7.Children] = { v35, v7:New("TextButton")({
				["Text"] = v13,
				["Font"] = v14,
				["TextScaled"] = v15,
				["TextSize"] = v16,
				["Position"] = UDim2.new(0.5, 0, 0.5, 0),
				["Size"] = v7:Spring(v12, 40, 1),
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["TextColor3"] = v20,
				["TextTransparency"] = v21,
				["TextWrapped"] = v22,
				["TextXAlignment"] = v23,
				["TextYAlignment"] = v24,
				["TextTruncate"] = v25,
				["TextStrokeTransparency"] = v26,
				["TextStrokeColor3"] = v27,
				["BackgroundTransparency"] = v28,
				["BackgroundColor3"] = v33,
				["ZIndex"] = (p_u_6.ZIndex or 1) + 1,
				[v_u_4("Activated")] = function()
					-- upvalues: (copy) p_u_6, (ref) v_u_5, (copy) v_u_8
					if p_u_6.OnClick ~= nil and not v_u_5(v_u_8) then
						p_u_6.OnClick()
					end
				end,
				[v_u_4("MouseButton1Down")] = function()
					-- upvalues: (copy) v_u_10
					v_u_10:set(true)
				end,
				[v_u_4("MouseButton1Up")] = function()
					-- upvalues: (copy) v_u_10
					v_u_10:set(false)
				end,
				[v_u_4("MouseEnter")] = function()
					-- upvalues: (copy) v_u_9
					v_u_9:set(true)
				end,
				[v_u_4("MouseLeave")] = function()
					-- upvalues: (copy) v_u_10, (copy) v_u_9
					v_u_10:set(false)
					v_u_9:set(false)
				end,
				[v_u_3] = p_u_6.Children
			}) }
	})
end