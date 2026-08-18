require("../../Types")
local v_u_1 = require("../../Utilities/Output")
return function(p2, ...)
	-- upvalues: (copy) v_u_1
	v_u_1.warnAssert(select("#", ...) == 0, "incorrect number of arguments passed to player container")
	return {
		["kind"] = "single",
		["value"] = nil,
		["value"] = p2
	}
end