local v_u_1 = require("../Shared/Util")
return function(p_u_2)
	-- upvalues: (copy) v_u_1
	local v7 = {
		["Transform"] = function(p3) -- name: Transform
			-- upvalues: (ref) v_u_1, (copy) p_u_2
			return v_u_1.MakeFuzzyFinder(p_u_2:GetTypeNames())(p3)
		end,
		["Validate"] = function(p4) -- name: Validate
			return #p4 > 0, "No type with that name could be found."
		end,
		["Autocomplete"] = function(p5) -- name: Autocomplete
			return p5
		end,
		["Parse"] = function(p6) -- name: Parse
			return p6[1]
		end
	}
	p_u_2:RegisterType("type", v7)
	p_u_2:RegisterType("types", v_u_1.MakeListableType(v7))
end