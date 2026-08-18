local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
return function(p_u_2) -- name: ChargeAttackIndicator
	local v3 = p_u_2.scope
	local v5 = v3:Computed(function(p4)
		-- upvalues: (copy) p_u_2
		if p4(p_u_2.showReady) then
			return UDim2.fromScale(0.5, 0.5)
		else
			return UDim2.fromScale(1, 1)
		end
	end)
	local v7 = v3:Computed(function(p6)
		-- upvalues: (copy) p_u_2
		return p6(p_u_2.showReady) and 0 or 1
	end)
	local v9 = v3:Computed(function(p8)
		-- upvalues: (copy) p_u_2
		if p8(p_u_2.showReady) then
			return Color3.fromRGB(255, 137, 101)
		else
			return Color3.fromRGB(255, 255, 255)
		end
	end)
	local v10 = v3:Spring(v5, 15, 0.6)
	local v11 = v3:Spring(v7, 20, 1)
	local v12 = v3:Spring(v9, 20, 1)
	return v3:New("ImageLabel")({
		["Name"] = "ChargeAttack",
		["Image"] = "rbxassetid://14503290950",
		["AnchorPoint"] = nil,
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["ImageColor3"] = nil,
		["ImageTransparency"] = nil,
		["Position"] = nil,
		["ScaleType"] = nil,
		["Size"] = nil,
		["ZIndex"] = 2,
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["ImageColor3"] = v12,
		["ImageTransparency"] = v11,
		["Position"] = UDim2.fromScale(1.25, 0.5),
		["ScaleType"] = Enum.ScaleType.Fit,
		["Size"] = v10
	})
end