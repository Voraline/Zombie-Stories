local v_u_1 = require("../Shared/Util")
local v_u_4 = v_u_1.MakeSequenceType({
	["Prefixes"] = "# hexColor3 ! brickColor3",
	["ValidateEach"] = nil,
	["TransformEach"] = nil,
	["Constructor"] = nil,
	["Length"] = 3,
	["ValidateEach"] = function(p2, p3) -- name: ValidateEach
		if p2 == nil then
			return false, ("Invalid or missing number at position %d in Color3 type."):format(p3)
		elseif p2 < 0 or p2 > 255 then
			return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(p3)
		elseif p2 % 1 == 0 then
			return true
		else
			return false, ("Number is not an integer at position %d in Color3 type."):format(p3)
		end
	end,
	["TransformEach"] = tonumber,
	["Constructor"] = Color3.fromRGB
})
local function v_u_6(p5) -- name: parseHexDigit
	if #p5 == 1 then
		p5 = p5 .. p5
	end
	return tonumber(p5, 16)
end
local v_u_15 = {
	["Transform"] = function(p7) -- name: Transform
		-- upvalues: (copy) v_u_1, (copy) v_u_6
		local v8, v9, v10 = p7:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
		return v_u_1.Each(v_u_6, v8, v9, v10)
	end,
	["Validate"] = function(p11, p12, p13) -- name: Validate
		local v14
		if p11 == nil or p12 == nil then
			v14 = false
		else
			v14 = p13 ~= nil
		end
		return v14, "Invalid hex color"
	end,
	["Parse"] = function(...) -- name: Parse
		return Color3.fromRGB(...)
	end
}
return function(p16)
	-- upvalues: (copy) v_u_4, (copy) v_u_1, (copy) v_u_15
	p16:RegisterType("color3", v_u_4)
	p16:RegisterType("color3s", v_u_1.MakeListableType(v_u_4, {
		["Prefixes"] = "# hexColor3s ! brickColor3s"
	}))
	p16:RegisterType("hexColor3", v_u_15)
	p16:RegisterType("hexColor3s", v_u_1.MakeListableType(v_u_15))
end