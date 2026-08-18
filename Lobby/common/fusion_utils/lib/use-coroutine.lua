require("./types/fusion")
return function(p1, p_u_2, ...) -- name: useCoroutine
	if typeof(p_u_2) == "function" then
		p_u_2 = coroutine.create(p_u_2)
	end
	coroutine.resume(p_u_2, ...)
	local function v3()
		-- upvalues: (ref) p_u_2
		if coroutine.status(p_u_2) ~= "dead" then
			coroutine.close(p_u_2)
		end
	end
	table.insert(p1, v3)
	return p_u_2
end