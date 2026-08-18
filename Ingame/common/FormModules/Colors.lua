local v_u_1 = Color3.new(1, 1, 1)
local v_u_2 = Color3.new(0, 0, 0)
return {
	["White"] = v_u_1,
	["Black"] = v_u_2,
	["LightGray"] = Color3.fromRGB(224, 224, 224),
	["MediumGray"] = Color3.fromRGB(113, 117, 121),
	["DarkGray"] = Color3.fromRGB(95, 99, 104),
	["DefaultTheme"] = Color3.fromRGB(103, 58, 183),
	["GetContrastColor"] = function(p3) -- name: getContrastColor
		-- upvalues: (copy) v_u_2, (copy) v_u_1
		local v4 = p3.R * 255
		local v5 = p3.G * 255
		local v6 = p3.B * 255
		if v4 * 0.299 + v5 * 0.587 + v6 * 0.114 > 186 then
			return v_u_2
		else
			return v_u_1
		end
	end
}