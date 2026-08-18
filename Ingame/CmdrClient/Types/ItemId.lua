local v_u_1 = require("../Shared/Util")
local v2 = require(game.ReplicatedStorage.common:WaitForChild("ItemData"))
local v_u_3 = {}
for _, v4 in pairs(v2.List) do
	table.insert(v_u_3, v4)
end
local v_u_9 = {
	["DisplayName"] = "Item name",
	["Prefixes"] = "# integer",
	["Transform"] = nil,
	["Validate"] = nil,
	["Autocomplete"] = nil,
	["Parse"] = nil,
	["Transform"] = function(p5) -- name: Transform
		-- upvalues: (copy) v_u_1, (copy) v_u_3
		return v_u_1.MakeFuzzyFinder(v_u_3)(p5)
	end,
	["Validate"] = function(p6) -- name: Validate
		return #p6 > 0, "No item with that name could be found."
	end,
	["Autocomplete"] = function(p7) -- name: Autocomplete
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p7)
	end,
	["Parse"] = function(p8) -- name: Parse
		return p8[1].Id
	end
}
return function(p10)
	-- upvalues: (copy) v_u_9, (copy) v_u_1
	p10:RegisterType("itemId", v_u_9)
	p10:RegisterType("itemIds", v_u_1.MakeListableType(v_u_9, {
		["Prefixes"] = "# integers"
	}))
end