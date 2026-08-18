require("./SkillTypes")
local v1 = require("./CoreSkills")
local v2 = require("./CombatSkills")
local v3 = require("./SurvivalSkills")
local v4 = require("./SkillLayout")
local v_u_5 = {}
local function v8(p6) -- name: registerSkills
	-- upvalues: (copy) v_u_5
	for _, v7 in p6 do
		if v_u_5[v7.id] then
			warn((("Duplicate skill ID: %*"):format(v7.id)))
		end
		v_u_5[v7.id] = v7
	end
end
v8(v1)
v8(v2)
v8(v3)
return {
	["skills"] = v_u_5,
	["layout"] = v4,
	["getSkill"] = function(p9) -- name: getSkill
		-- upvalues: (copy) v_u_5
		return v_u_5[p9]
	end,
	["getSkillsByBranch"] = function(p10) -- name: getSkillsByBranch
		-- upvalues: (copy) v_u_5
		local v11 = {}
		for _, v12 in v_u_5 do
			if v12.branch == p10 then
				table.insert(v11, v12)
			end
		end
		return v11
	end,
	["getSkillsByTier"] = function(p13, p14) -- name: getSkillsByTier
		-- upvalues: (copy) v_u_5
		local v15 = {}
		for _, v16 in v_u_5 do
			if v16.branch == p13 and v16.tier == p14 then
				table.insert(v15, v16)
			end
		end
		return v15
	end,
	["getAllSkillIds"] = function() -- name: getAllSkillIds
		-- upvalues: (copy) v_u_5
		local v17 = {}
		for v18 in v_u_5 do
			table.insert(v17, v18)
		end
		return v17
	end,
	["getTierRequiredCount"] = function(p19, p20) -- name: getTierRequiredCount
		-- upvalues: (copy) v_u_5
		for _, v21 in v_u_5 do
			if v21.branch == p19 and (v21.tier == p20 + 1 and v21.requirements) then
				for _, v22 in v21.requirements.requirements do
					if v22.type == "tier" and v22.tier == p20 then
						return v22.count or 4
					end
				end
			end
		end
		return 4
	end,
	["countSkillsAtTier"] = function(p23, p24, p25) -- name: countSkillsAtTier
		-- upvalues: (copy) v_u_5
		local v26 = 0
		for _, v27 in v_u_5 do
			if v27.branch == p23 and v27.tier == p24 then
				v26 = v26 + (p25[v27.id] or 0)
			end
		end
		return v26
	end
}