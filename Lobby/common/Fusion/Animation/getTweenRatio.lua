local v_u_1 = game:GetService("TweenService")
return function(p2, p3) -- name: getTweenRatio
	-- upvalues: (copy) v_u_1
	local v4 = p2.DelayTime
	local v5 = p2.Time
	local v6 = p2.Reverses
	local v7 = 1 + p2.RepeatCount
	local v8 = p2.EasingStyle
	local v9 = p2.EasingDirection
	local v10 = v4 + v5
	if v6 then
		v10 = v10 + v5
	end
	if v10 * v7 <= p3 then
		return 1
	end
	local v11 = p3 % v10
	if v11 <= v4 then
		return 0
	end
	local v12 = (v11 - v4) / v5
	if v12 > 1 then
		v12 = 2 - v12
	end
	return v_u_1:GetValue(v12, v8, v9)
end