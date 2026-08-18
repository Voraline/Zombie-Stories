local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.OnHit(p2, p3, p4, p5, p6) -- name: OnHit
	if p6 == "3016" and p2.onActivate then
		p2.onActivate(p3, p4, p5)
	end
end
function v_u_1.new() -- name: new
	-- upvalues: (copy) v_u_1
	local v7 = v_u_1
	local v8 = setmetatable({}, v7)
	v8.onActivate = nil
	return v8
end
return v_u_1