return {
	["EncodePositioningData"] = function(p1) -- name: EncodePositioningData
		local v2 = p1.X
		local v3 = math.clamp(v2, -327.68, 326.68)
		local v4 = p1.Y
		local v5 = math.clamp(v4, -327.68, 326.68)
		local v6 = p1.Z
		local v7 = math.clamp(v6, -327.68, 326.68)
		local v8 = v3 * 100 + 0.5
		local v9 = math.floor(v8)
		local v10 = v5 * 100 + 0.5
		local v11 = math.floor(v10)
		local v12 = v7 * 100 + 0.5
		local v13 = math.floor(v12)
		if v9 < -32768 or (v11 < -32768 or v13 < -32768) then
			error("OUT OF BOUNDS")
		end
		if v9 > 32767 or (v11 > 32767 or v13 > 32767) then
			error("OUT OF BOUNDS")
		end
		return Vector3int16.new(v9, v11, v13)
	end,
	["DecodePositioningData"] = function(p14) -- name: DecodePositioningData
		return p14.X / 100, p14.Y / 100, p14.Z / 100
	end
}