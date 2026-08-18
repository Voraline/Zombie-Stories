return function(p1, p2, p3) -- name: springCoefficients
	if p1 == 0 or p3 == 0 then
		return 1, 0, 0, 1
	end
	if p2 > 1 then
		local v4 = p1 * p3
		local v5 = p2 ^ 2 - 1
		local v6 = math.sqrt(v5)
		local v7 = -0.5 / v6
		local v8 = -v6 - p2
		local v9 = 1 / v8
		local v10 = v4 * v8
		local v11 = math.exp(v10)
		local v12 = v4 * v9
		local v13 = math.exp(v12)
		return (v13 * v8 - v11 * v9) * v7, (v11 - v13) * v7 / p3, (v13 - v11) * v7 * p3, (v11 * v8 - v13 * v9) * v7
	end
	if p2 == 1 then
		local v14 = p1 * p3
		local v15 = -v14
		local v16 = math.exp(v15)
		return v16 * (v14 + 1), v16 * p1, v16 * (-v14 * p3), v16 * (1 - v14)
	end
	local v17 = p1 * p3
	local v18 = 1 - p2 ^ 2
	local v19 = math.sqrt(v18)
	local v20 = 1 / v19
	local v21 = v19 * v17
	local v22 = -v17 * p2
	local v23 = math.exp(v22)
	local v24 = v23 * math.sin(v21)
	local v25 = v23 * math.cos(v21)
	local v26 = v24 * v20
	local v27 = v26 * p2
	return v27 + v25, v26, -(v27 * p2 + v24 * v19), v25 - v27
end