local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new() -- name: new
	-- upvalues: (copy) v_u_1
	local v2 = v_u_1
	return setmetatable({
		["SpeedMult"] = 0,
		["Inactive"] = true
	}, v2)
end
function v_u_1.Apply(p3, _, p4) -- name: Apply
	local v5 = p4 or 0
	p3.SpeedMult = v5
	p3.Inactive = v5 == 0
end
function v_u_1.Destroy(p6) -- name: Destroy
	p6.SpeedMult = 0
	p6.Inactive = true
end
return v_u_1