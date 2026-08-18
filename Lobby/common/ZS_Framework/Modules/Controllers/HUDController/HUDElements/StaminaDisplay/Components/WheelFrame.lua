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
	local v9 = v4:New("Frame")
	local v10 = {
		["Name"] = v_u_5 and "LeftFrame" or "RightFrame",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["ClipsDescendants"] = true
	}
	local v11
	if v_u_5 then
		v11 = UDim2.fromScale(0, 0)
	else
		v11 = UDim2.fromScale(0.5, 0)
	end
	v10.Position = v11
	v10.Size = UDim2.fromScale(0.5, 1)
	v10.ZIndex = 2
	local v12 = v_u_2
	local v13 = {}
	local v14 = v4:New("ImageLabel")
	local v15 = {
		["Name"] = "WheelImage"
	}
	local v16
	if v_u_5 then
		v16 = Vector2.new(0, 0)
	else
		v16 = Vector2.new(1, 0)
	end
	v15.AnchorPoint = v16
	v15.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v15.BackgroundTransparency = 1
	v15.BorderColor3 = Color3.fromRGB(27, 42, 53)
	v15.Image = "rbxassetid://13676717187"
	v15.ImageColor3 = Color3.fromRGB(101, 206, 255)
	local v17
	if v_u_5 then
		v17 = UDim2.fromScale(0, 0)
	else
		v17 = UDim2.fromScale(1, 0)
	end
	v15.Position = v17
	v15.Size = UDim2.fromScale(2, 1)
	v15[v_u_2] = { v4:New("UIGradient")({
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
	__set_list(v13, 1, {v14(v15)})
	v10[v12] = v13
	return v9(v10)
end