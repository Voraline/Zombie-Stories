local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion).Children
return function(p3) -- name: CanvasFrame
	-- upvalues: (copy) v_u_2
	local v4 = p3.scope
	local v5 = p3.isLeft
	local v6 = v4:New("CanvasGroup")
	local v7 = {
		["Name"] = v5 and "LeftCanvas" or "RightCanvas",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(27, 42, 53),
		["GroupColor3"] = p3.groupColor3 or Color3.fromRGB(255, 255, 255),
		["GroupTransparency"] = p3.groupTransparency
	}
	local v8
	if v5 then
		v8 = UDim2.fromScale(0, 0)
	else
		v8 = UDim2.fromScale(0.5, 0)
	end
	v7.Position = v8
	v7.Size = UDim2.fromScale(0.5, 1)
	v7.Visible = p3.visible
	local v9 = v_u_2
	local v10 = {}
	local v11 = v4:New("ImageLabel")
	local v12 = {
		["Name"] = "RedGlowImage"
	}
	local v13
	if v5 then
		v13 = Vector2.new(0, 0)
	else
		v13 = Vector2.new(1, 0)
	end
	v12.AnchorPoint = v13
	v12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	v12.BackgroundTransparency = 1
	v12.BorderColor3 = Color3.fromRGB(27, 42, 53)
	v12.Image = "rbxassetid://12799025513"
	local v14
	if v5 then
		v14 = UDim2.fromScale(0, 0)
	else
		v14 = UDim2.fromScale(1, 0)
	end
	v12.Position = v14
	v12.Rotation = p3.rotation
	v12.Size = UDim2.fromScale(2, 1)
	v12.ZIndex = 2
	v12[v_u_2] = { v4:New("UIGradient")({
			["Name"] = "UIGradient",
			["Rotation"] = nil,
			["Transparency"] = nil,
			["Rotation"] = p3.gradientRotation,
			["Transparency"] = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.502, 1),
				NumberSequenceKeypoint.new(1, 1)
			})
		}) }
	__set_list(v10, 1, {v11(v12)})
	v7[v9] = v10
	return v6(v7)
end