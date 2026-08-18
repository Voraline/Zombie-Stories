local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion).Children
return function(p_u_3) -- name: WheelFrame
	-- upvalues: (copy) v_u_2
	local v4 = p_u_3.scope
	local v_u_5 = p_u_3.isLeft
	local v8 = v4:Computed(function(p6)
		-- upvalues: (copy) p_u_3, (copy) v_u_5
		local v7 = p6(p_u_3.rotation)
		if v_u_5 then
			return math.max(180, v7)
		else
			return math.min(180, v7)
		end
	end)
	local v10 = v4:Computed(function(p9)
		-- upvalues: (copy) p_u_3
		if p_u_3.wheelColor then
			return p9(p_u_3.wheelColor)
		else
			return Color3.fromRGB(101, 206, 255)
		end
	end)
	local v11 = v4:New("Frame")
	local v12 = {
		["Name"] = v_u_5 and "LeftFrame" or "RightFrame",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["ClipsDescendants"] = true
	}
	local v13
	if v_u_5 then
		v13 = UDim2.fromScale(0, 0)
	else
		v13 = UDim2.fromScale(0.5, 0)
	end
	v12.Position = v13
	v12.Size = UDim2.fromScale(0.5, 1)
	v12.ZIndex = 2
	local v14 = v_u_2
	local v15 = {}
	local v16 = v4:New("ImageLabel")
	local v17 = {
		["Name"] = "WheelImage"
	}
	local v18
	if v_u_5 then
		v18 = Vector2.new(0, 0)
	else
		v18 = Vector2.new(1, 0)
	end
	v17.AnchorPoint = v18
	v17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v17.BackgroundTransparency = 1
	v17.BorderColor3 = Color3.fromRGB(27, 42, 53)
	v17.Image = "rbxassetid://13676717187"
	v17.ImageColor3 = v10
	local v19
	if v_u_5 then
		v19 = UDim2.fromScale(0, 0)
	else
		v19 = UDim2.fromScale(1, 0)
	end
	v17.Position = v19
	v17.Size = UDim2.fromScale(2, 1)
	v17[v_u_2] = { v4:New("UIGradient")({
			["Name"] = "UIGradient",
			["Rotation"] = nil,
			["Transparency"] = nil,
			["Rotation"] = v8,
			["Transparency"] = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 1),
				NumberSequenceKeypoint.new(0.501, 0),
				NumberSequenceKeypoint.new(1, 0)
			})
		}) }
	__set_list(v15, 1, {v16(v17)})
	v12[v14] = v15
	return v11(v12)
end