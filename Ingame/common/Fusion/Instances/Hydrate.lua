local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Instances.applyInstanceProps)
return function(p_u_3) -- name: Hydrate
	-- upvalues: (copy) v_u_2
	return function(p4)
		-- upvalues: (ref) v_u_2, (copy) p_u_3
		v_u_2(p4, p_u_3)
		return p_u_3
	end
end