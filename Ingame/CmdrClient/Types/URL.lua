local v_u_1 = require("../Shared/Util")
local v_u_4 = {
	["Validate"] = function(p2) -- name: Validate
		if p2:match("^https?://.+$") then
			return true
		else
			return false, "URLs must begin with http:// or https://"
		end
	end,
	["Parse"] = function(p3) -- name: Parse
		return p3
	end
}
return function(p5)
	-- upvalues: (copy) v_u_4, (copy) v_u_1
	p5:RegisterType("url", v_u_4)
	p5:RegisterType("urls", v_u_1.MakeListableType(v_u_4))
end