local v_u_19 = {
	["ApplySkinPalette"] = function(_, p1, p2, _) -- name: ApplySkinPalette
		for _, v3 in p1.Weapon:QueryDescendants("BasePart") do
			local v4 = v3:GetAttribute("PaletteIndex")
			if v4 and p2[v4] then
				for v5, v6 in p2[v4] do
					v3[v5] = v6
				end
			end
		end
	end,
	["ApplyTexture"] = function(_, p7, p8, p9, p10) -- name: ApplyTexture
		local v11 = p10 and Instance.new("Decal") or Instance.new("Texture")
		v11.Texture = p7
		if p9 then
			for v12, v13 in p9 do
				v11[v12] = v13
			end
		end
		for _, v14 in p8 do
			if v14:IsA("BasePart") then
				for _, v15 in Enum.NormalId:GetEnumItems() do
					local v16 = v11:Clone()
					v16.Face = v15
					v16.Parent = v14
					v16.Transparency = v16.Transparency + v14.Transparency
				end
			end
		end
	end,
	["ApplyGalaxy"] = function(_, p17) -- name: ApplyGalaxy
		-- upvalues: (copy) v_u_19
		p17:SetAttribute("attuid1", nil)
		for _, v18 in p17.Weapon:QueryDescendants("BasePart") do
			v_u_19:ApplyTexture("rbxassetid://1818175145", { v18 }, {
				["Name"] = "Animate",
				["StudsPerTileU"] = 2,
				["StudsPerTileV"] = 2
			})
		end
	end
}
return v_u_19