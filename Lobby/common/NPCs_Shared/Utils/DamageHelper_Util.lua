local v_u_1 = {}
local v_u_2 = {}
local function v_u_8(p3) -- name: deepCopy
	-- upvalues: (copy) v_u_8
	local v4 = {}
	for v5, v7 in pairs(p3) do
		if type(v7) == "table" then
			local v7 = v_u_8(v7)
		end
		v4[v5] = v7
	end
	return v4
end
return {
	["GetHPList"] = function(_, p9) -- name: GetHPList
		-- upvalues: (copy) v_u_2
		if not v_u_2[p9] then
			local v10 = {}
			for _, v11 in p9:GetChildren() do
				if v11:IsA("BasePart") and v11.CanQuery then
					local v12 = v11:GetAttribute("uid")
					assert(v12, "uid doesn\'t exist!")
					v10[v11:GetAttribute("uid")] = true
				end
			end
			v_u_2[p9] = v10
		end
		return v_u_2[p9]
	end,
	["GetArmorHPList"] = function(_, p13) -- name: GetArmorHPList
		-- upvalues: (copy) v_u_1, (copy) v_u_8
		if not v_u_1[p13] then
			local v14 = {
				["HPDir"] = {}
			}
			if p13:FindFirstChild("Hitboxes") and p13.Hitboxes:FindFirstChild("Armor") then
				for _, v15 in p13.Hitboxes.Armor:GetChildren() do
					if not v15:GetAttribute("ArmorHealth") then
						warn(v15, "does not have a set armor health. Setting to 25")
						v15:SetAttribute("ArmorHealth", 25)
					end
					if not v15:GetAttribute("ArmorLevel") then
						warn(v15, "does not have a set armor level. Setting to 1")
						v15:SetAttribute("ArmorLevel", 1)
					end
					local v16 = v14.HPDir
					local v17 = {
						["HP"] = v15:GetAttribute("ArmorHealth"),
						["Lvl"] = v15:GetAttribute("ArmorLevel")
					}
					table.insert(v16, v17)
					local v18 = #v14.HPDir
					for _, v19 in v15:GetChildren() do
						local v20 = v19:GetAttribute("uid")
						assert(v20, "uid doesn\'t exist!")
						v14[v19:GetAttribute("uid")] = { v18, v15.Name }
					end
				end
			end
			v_u_1[p13] = v14
		end
		return v_u_8(v_u_1[p13])
	end,
	["GenUIDTable"] = function(_, p21) -- name: GenUIDTable
		local v22 = {}
		for _, v23 in p21:GetDescendants() do
			if v23:GetAttribute("uid") then
				v22[v23:GetAttribute("uid")] = v23
			end
		end
		return v22
	end
}