local v_u_1 = require("../Shared/Util")
local v2 = game.ReplicatedStorage.common
local v_u_3 = require(v2.NPCRegistry)
local v_u_4 = {}
for v5 in v_u_3:GetAllNPCs() do
	table.insert(v_u_4, v5)
end
v_u_3.NPCAdded:Connect(function(p6)
	-- upvalues: (copy) v_u_4
	local v7 = v_u_4
	local v8 = p6.UID
	table.insert(v7, v8)
end)
v_u_3.NPCRemoved:Connect(function(p9)
	-- upvalues: (copy) v_u_4
	table.remove(v_u_4, table.find(v_u_4, p9.UID))
end)
local v_u_14 = {
	["Transform"] = function(p10) -- name: Transform
		-- upvalues: (copy) v_u_1, (copy) v_u_4
		return v_u_1.MakeFuzzyFinder(v_u_4)(p10)
	end,
	["Validate"] = function(p11) -- name: Validate
		return #p11 > 0, "No NPC with that UID could be found."
	end,
	["Autocomplete"] = function(p12) -- name: Autocomplete
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p12)
	end,
	["Parse"] = function(p13) -- name: Parse
		-- upvalues: (copy) v_u_3
		return v_u_3:GetNPC(p13[1])
	end
}
return function(p15)
	-- upvalues: (copy) v_u_14, (copy) v_u_1
	p15:RegisterType("npc", v_u_14)
	p15:RegisterType("npcs", v_u_1.MakeListableType(v_u_14))
end