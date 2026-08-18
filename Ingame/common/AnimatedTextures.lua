return {
	["collect"] = function(p1) -- name: collect
		local v2 = nil
		for _, v3 in p1:GetDescendants() do
			if v3:IsA("Texture") and v3.Name == "Animate" then
				v2 = v2 or {}
				table.insert(v2, v3)
			end
		end
		return v2
	end,
	["update"] = function(p4) -- name: update
		local v5 = os.clock() * 1
		local v6 = math.rad(v5) % 6.283185307179586 / 6.283185307179586 * 20
		for _, v7 in p4 do
			v7.OffsetStudsU = v6
			v7.OffsetStudsV = v6
		end
	end
}