local v_u_1 = {}
local function v_u_5(p2, p3, ...) -- name: RunCallback
	-- upvalues: (copy) v_u_1
	p2(...)
	local v4 = v_u_1
	table.insert(v4, p3)
end
local function v_u_6() -- name: Yielder
	-- upvalues: (copy) v_u_5
	while true do
		v_u_5(coroutine.yield())
	end
end
return function(p7, ...)
	-- upvalues: (copy) v_u_1, (copy) v_u_6
	local v8
	if #v_u_1 > 0 then
		v8 = v_u_1[#v_u_1]
		v_u_1[#v_u_1] = nil
	else
		v8 = coroutine.create(v_u_6)
		coroutine.resume(v8)
	end
	task.spawn(v8, p7, v8, ...)
end