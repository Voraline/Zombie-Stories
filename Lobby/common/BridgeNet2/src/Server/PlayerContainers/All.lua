require("../../Types")
local v_u_1 = require("../../Utilities/Output")
local v_u_2 = {
	["kind"] = "all",
	["value"] = nil
}
table.freeze(v_u_2)
return function(...)
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	v_u_1.warnAssert(select("#", ...) == 0, "incorrect number of arguments passed to player container")
	return v_u_2
end