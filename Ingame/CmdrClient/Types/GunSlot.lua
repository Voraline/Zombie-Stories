local v_u_1 = require("../Shared/Util")
local v_u_2 = { "Primary", "Secondary" }
local v_u_7 = {
	["DisplayName"] = "Gun slot",
	["Prefixes"] = "",
	["Transform"] = nil,
	["Validate"] = nil,
	["Autocomplete"] = nil,
	["Parse"] = nil,
	["Transform"] = function(p3) -- name: Transform
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return v_u_1.MakeFuzzyFinder(v_u_2)(p3)
	end,
	["Validate"] = function(p4) -- name: Validate
		return #p4 > 0, "No slot with that name exists."
	end,
	["Autocomplete"] = function(p5) -- name: Autocomplete
		return p5
	end,
	["Parse"] = function(p6) -- name: Parse
		return p6[1]
	end
}
return function(p8)
	-- upvalues: (copy) v_u_7
	p8:RegisterType("gunSlot", v_u_7)
end