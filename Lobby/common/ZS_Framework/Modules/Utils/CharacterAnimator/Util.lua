return {
	["lerp"] = function(_, p1, p2, p3) -- name: lerp
		return p1 * (1 - p3) + p2 * p3
	end,
	["rotateAround"] = function(_, p4, p5, p6, p7, p8) -- name: rotateAround
		local v9 = p4.Z
		local v10 = p4.X
		local v11 = math.atan2(v9, v10)
		local v12 = p5.Z
		local v13 = p5.X
		local v14 = (v11 + ((math.atan2(v12, v13) - v11 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * p7 * p8 + 6.283185307179586) % 6.283185307179586
		local v15 = p6 * math.cos(v14)
		local v16 = p6 * math.sin(v14)
		return Vector3.new(v15, 0, v16)
	end
}