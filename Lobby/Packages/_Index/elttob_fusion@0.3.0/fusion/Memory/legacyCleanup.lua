local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.doCleanup)
return function(p4) -- name: legacyCleanup
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	v_u_2.logWarn("cleanupWasRenamed")
	return v_u_3(p4)
end