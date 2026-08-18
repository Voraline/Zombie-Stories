local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.OnHit(p2, p3, p4, p5) -- name: OnHit
	if p2.onActivate then
		p2.onActivate(p3, p4, p5)
	end
end
function v_u_1.new() -- name: new
	-- upvalues: (copy) v_u_1
	local v6 = v_u_1
	local v7 = setmetatable({}, v6)
	v7.onActivate = nil
	return v7
end
return v_u_1