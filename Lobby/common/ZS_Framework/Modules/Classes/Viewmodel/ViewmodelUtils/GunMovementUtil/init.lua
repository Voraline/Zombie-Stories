local v1 = {}
local v_u_2 = require(script:WaitForChild("inertia"))
local v_u_3 = require(script:WaitForChild("directional"))
function v1.Update(_, p4, p5) -- name: Update
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	v_u_3.Update(p4)
	local v6, v7 = v_u_2.Update(p4, p5)
	return v6, v7
end
return v1