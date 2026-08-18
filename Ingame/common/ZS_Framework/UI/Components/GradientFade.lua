local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
return function(p_u_2)
	local v3 = p_u_2.scope:innerScope()
	local v_u_4 = p_u_2.fadeLowerOffset or 0.001
	local v_u_5 = p_u_2.fadeUpperOffset or 0.001
	local v_u_6 = p_u_2.MinTransparency or 0
	local v_u_7 = p_u_2.MaxTransparency or 1
	if not p_u_2.Reversed then
		local v8 = v_u_6
		v_u_6 = v_u_7
		v_u_7 = v8
	end
	return v3:New("UIGradient")({
		["Rotation"] = p_u_2.Rotation or 0,
		["Transparency"] = v3:Computed(function(p9)
			-- upvalues: (copy) p_u_2, (ref) v_u_7, (ref) v_u_6, (copy) v_u_4, (copy) v_u_5
			local v10 = p9(p_u_2.CurrentValue)
			local v11 = p9(p_u_2.MaxValue)
			local v12 = p9(v_u_7)
			local v13 = p9(v_u_6)
			if v11 == 0 then
				return NumberSequence.new({ NumberSequenceKeypoint.new(0, v13), NumberSequenceKeypoint.new(1, v13) })
			end
			local v14 = v10 / v11
			local v15 = math.clamp(v14, 0, 1)
			local v16 = NumberSequence.new
			local v17 = {}
			local v18 = NumberSequenceKeypoint.new(0, v12)
			local v19 = NumberSequenceKeypoint.new
			local v20 = v15 - v_u_4
			local v21 = v19(math.max(v20, 0), v12)
			local v22 = NumberSequenceKeypoint.new
			local v23 = v15 + v_u_5
			__set_list(v17, 1, {v18, v21, v22(math.min(v23, 1), v13), NumberSequenceKeypoint.new(1, v13)})
			return v16(v17)
		end)
	})
end