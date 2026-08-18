local v_u_1 = require("../Shared/Util")
local v_u_4 = {
	["Validate"] = function(p2) -- name: Validate
		return p2 ~= nil
	end,
	["Parse"] = function(p3) -- name: Parse
		return tostring(p3)
	end
}
local v_u_8 = {
	["Transform"] = function(p5) -- name: Transform
		return tonumber(p5)
	end,
	["Validate"] = function(p6) -- name: Validate
		return p6 ~= nil
	end,
	["Parse"] = function(p7) -- name: Parse
		return p7
	end
}
local v_u_13 = {
	["Transform"] = function(p9) -- name: Transform
		return tonumber(p9)
	end,
	["Validate"] = function(p10) -- name: Validate
		local v11
		if p10 == nil then
			v11 = false
		else
			v11 = p10 == math.floor(p10)
		end
		return v11, "Only whole numbers are valid."
	end,
	["Parse"] = function(p12) -- name: Parse
		return p12
	end
}
local v_u_18 = {
	["Transform"] = function(p14) -- name: Transform
		return tonumber(p14)
	end,
	["Validate"] = function(p15) -- name: Validate
		local v16
		if p15 == nil or p15 ~= math.floor(p15) then
			v16 = false
		else
			v16 = p15 > 0
		end
		return v16, "Only positive whole numbers are valid."
	end,
	["Parse"] = function(p17) -- name: Parse
		return p17
	end
}
local v_u_23 = {
	["Transform"] = function(p19) -- name: Transform
		return tonumber(p19)
	end,
	["Validate"] = function(p20) -- name: Validate
		local v21
		if p20 == nil or p20 ~= math.floor(p20) then
			v21 = false
		else
			v21 = p20 >= 0
		end
		return v21, "Only non-negative whole numbers are valid."
	end,
	["Parse"] = function(p22) -- name: Parse
		return p22
	end
}
local v_u_28 = {
	["Transform"] = function(p24) -- name: Transform
		return tonumber(p24)
	end,
	["Validate"] = function(p25) -- name: Validate
		local v26
		if p25 == nil or (p25 ~= math.floor(p25) or p25 < 0) then
			v26 = false
		else
			v26 = p25 <= 255
		end
		return v26, "Only bytes are valid."
	end,
	["Parse"] = function(p27) -- name: Parse
		return p27
	end
}
local v_u_33 = {
	["Transform"] = function(p29) -- name: Transform
		return tonumber(p29)
	end,
	["Validate"] = function(p30) -- name: Validate
		local v31
		if p30 == nil or (p30 ~= math.floor(p30) or p30 < 0) then
			v31 = false
		else
			v31 = p30 <= 9
		end
		return v31, "Only digits are valid."
	end,
	["Parse"] = function(p32) -- name: Parse
		return p32
	end
}
local v_u_34 = v_u_1.MakeDictionary({
	"true",
	"t",
	"yes",
	"y",
	"on",
	"enable",
	"enabled",
	"1",
	"+"
})
local v_u_35 = v_u_1.MakeDictionary({
	"false",
	"f",
	"no",
	"n",
	"off",
	"disable",
	"disabled",
	"0",
	"-"
})
local v_u_39 = {
	["Transform"] = function(p36) -- name: Transform
		return p36:lower()
	end,
	["Validate"] = function(p37) -- name: Validate
		-- upvalues: (copy) v_u_34, (copy) v_u_35
		return v_u_34[p37] ~= nil and true or v_u_35[p37] ~= nil, "Please use true/yes/on or false/no/off."
	end,
	["Parse"] = function(p38) -- name: Parse
		-- upvalues: (copy) v_u_34, (copy) v_u_35
		if v_u_34[p38] then
			return true
		elseif v_u_35[p38] then
			return false
		else
			return nil
		end
	end
}
return function(p40)
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_13, (copy) v_u_18, (copy) v_u_23, (copy) v_u_28, (copy) v_u_33, (ref) v_u_39, (copy) v_u_1
	p40:RegisterType("string", v_u_4)
	p40:RegisterType("number", v_u_8)
	p40:RegisterType("integer", v_u_13)
	p40:RegisterType("positiveInteger", v_u_18)
	p40:RegisterType("nonNegativeInteger", v_u_23)
	p40:RegisterType("byte", v_u_28)
	p40:RegisterType("digit", v_u_33)
	p40:RegisterType("boolean", v_u_39)
	p40:RegisterType("strings", v_u_1.MakeListableType(v_u_4))
	p40:RegisterType("numbers", v_u_1.MakeListableType(v_u_8))
	p40:RegisterType("integers", v_u_1.MakeListableType(v_u_13))
	p40:RegisterType("positiveIntegers", v_u_1.MakeListableType(v_u_18))
	p40:RegisterType("nonNegativeIntegers", v_u_1.MakeListableType(v_u_23))
	p40:RegisterType("bytes", v_u_1.MakeListableType(v_u_28))
	p40:RegisterType("digits", v_u_1.MakeListableType(v_u_33))
	p40:RegisterType("booleans", v_u_1.MakeListableType(v_u_39))
end