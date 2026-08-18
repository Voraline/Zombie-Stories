local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Dependencies.sharedState)
local v_u_3 = v_u_2.initialisedStack
return function(p4) -- name: initDependency
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = v_u_2.initialisedStackSize
	for v6, v7 in ipairs(v_u_3) do
		if v5 < v6 then
			return
		end
		v7[p4] = true
	end
end