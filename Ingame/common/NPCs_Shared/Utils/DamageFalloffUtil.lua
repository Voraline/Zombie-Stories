return {
	["CalculateDamageAtDistance"] = function(p1, p2) -- name: CalculateDamageAtDistance
		local v3 = p1.Damage
		local v4 = p1.DamageDropoff
		if not v4 then
			return v3
		end
		for v5, v6 in v4 do
			if v5 == 1 and p2 <= v6.Distance then
				local v7 = v6.Damage
				local v8 = p2 / v6.Distance
				return v3 * (1 - v8) + v7 * v8
			end
			if p2 <= v6.Distance or v5 == #v4 then
				local v9 = v4[v5 - 1]
				local v10 = v5 == #v4 and v6.Distance < p2 and v6.Damage
				if not v10 then
					local v11 = v9.Damage
					local v12 = v6.Damage
					local v13 = (p2 - v9.Distance) / (v6.Distance - v9.Distance)
					v10 = v11 * (1 - v13) + v12 * v13
				end
				return v10
			end
		end
		return v3
	end,
	["RescaleDropoff"] = function(p14, p15, p16) -- name: RescaleDropoff
		if not p14 or (not p15 or p15 == 0) then
			return p14
		end
		local v17 = p16 / p15
		local v18 = {}
		for v19, v20 in p14 do
			v18[v19] = {
				["Distance"] = v20.Distance,
				["Damage"] = v20.Damage * v17
			}
		end
		return v18
	end
}