local v_u_1 = require("../Shared/Util")
local v_u_2 = Enum.UserInputType:GetEnumItems()
for _, v3 in pairs(Enum.KeyCode:GetEnumItems()) do
	v_u_2[#v_u_2 + 1] = v3
end
local v_u_8 = {
	["Transform"] = function(p4) -- name: Transform
		-- upvalues: (copy) v_u_1, (copy) v_u_2
		return v_u_1.MakeFuzzyFinder(v_u_2)(p4)
	end,
	["Validate"] = function(p5) -- name: Validate
		return #p5 > 0
	end,
	["Autocomplete"] = function(p6) -- name: Autocomplete
		-- upvalues: (copy) v_u_1
		return v_u_1.GetNames(p6)
	end,
	["Parse"] = function(p7) -- name: Parse
		return p7[1]
	end
}
return function(p9)
	-- upvalues: (copy) v_u_8, (copy) v_u_1
	p9:RegisterType("userInput", v_u_8)
	p9:RegisterType("userInputs", v_u_1.MakeListableType(v_u_8))
end