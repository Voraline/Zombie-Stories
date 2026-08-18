local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Instances.applyInstanceProps)
return function(p_u_4, p_u_5) -- name: Hydrate
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	if p_u_5 == nil then
		v_u_2.logError("scopeMissing", nil, "instances using Hydrate", "myScope:Hydrate (instance) { ... }")
	end
	return function(p6)
		-- upvalues: (copy) p_u_4, (copy) p_u_5, (ref) v_u_3
		local v7 = p_u_4
		local v8 = p_u_5
		table.insert(v7, v8)
		v_u_3(p_u_4, p6, p_u_5)
		return p_u_5
	end
end