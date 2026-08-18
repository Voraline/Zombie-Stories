return function(p1, p2, p3) -- name: springCoefficients
	if p1 == 0 or p3 == 0 then
		return 1, 0, 0, 1
	end
	if p2 > 1 then
		local v4 = p2 ^ 2 - 1
		local v5 = math.sqrt(v4)
		local v6 = -0.5 / (v5 * p3)
		local v7 = p3 * (v5 + p2) * -1
		local v8 = p3 * (v5 - p2)
		local v9 = p1 * v7
		local v10 = math.exp(v9)
		local v11 = p1 * v8
		local v12 = math.exp(v11)
		return (v12 * v7 - v10 * v8) * v6, (v10 - v12) * v6 / p3, (v12 - v10) * v6 * p3, (v10 * v7 - v12 * v8) * v6
	end
	if p2 == 1 then
		local v13 = p1 * p3
		local v14 = v13 * -1
		local v15 = math.exp(v14)
		return v15 * (v13 + 1), v15 * p1, v15 * (v14 * p3), v15 * (v14 + 1)
	end
	local v16 = 1 - p2 ^ 2
	local v17 = p3 * math.sqrt(v16)
	local v18 = 1 / v17
	local v19 = p1 * -1 * p3 * p2
	local v20 = math.exp(v19)
	local v21 = v17 * p1
	local v22 = math.sin(v21)
	local v23 = v17 * p1
	local v24 = math.cos(v23)
	local v25 = v20 * v22
	local v26 = v20 * v24
	local v27 = v25 * p3 * p2 * v18
	return v27 + v26, v25 * v18, (v25 * v17 + p3 * p2 * v27) * -1, v26 - v27
end