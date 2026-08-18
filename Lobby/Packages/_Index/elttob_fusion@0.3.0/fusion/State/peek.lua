local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.State.castToState)
local v_u_3 = require(v1.Graph.evaluate)
return function(p4) -- name: peek
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = v_u_2(p4)
	if v5 == nil then
		return p4
	end
	v_u_3(v5, false)
	return v5._EXTREMELY_DANGEROUS_usedAsValue
end