local v1 = {}
local v_u_2 = {
	["__index"] = v1
}
function v1.new(p3, p4, p5, p6, p7, p8) -- name: new
	-- upvalues: (copy) v_u_2
	local v9 = v_u_2
	return setmetatable({
		["position"] = p3,
		["velocity"] = p4,
		["target"] = p5,
		["stiffness"] = p6,
		["damping"] = p7,
		["precision"] = p8
	}, v9)
end
function v1.update(p10, p11) -- name: update
	local v12 = p10.position - p10.target
	local v13 = -p10.stiffness * v12 + -p10.damping * p10.velocity
	local v14 = p10.velocity + v13 * p11
	local v15 = p10.position + v14
	if (type(v14) == "number" and math.abs(v14) or v14.magnitude) < p10.precision then
		local v16 = p10.target - v15
		if (type(v16) == "number" and math.abs(v16) or v16.magnitude) < p10.precision then
			p10.position = p10.target
			p10.velocity = p10.velocity - p10.velocity
			return
		end
	end
	p10.position = v15
	p10.velocity = v14
end
return v1