local v_u_1 = nil
local function v_u_4(p2, ...) -- name: passer
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5() -- name: yielder
	-- upvalues: (copy) v_u_4
	while true do
		v_u_4(coroutine.yield())
	end
end
return function(p6, ...)
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	if v_u_1 == nil then
		v_u_1 = coroutine.create(v_u_5)
		coroutine.resume(v_u_1)
	end
	task.spawn(v_u_1, p6, ...)
end