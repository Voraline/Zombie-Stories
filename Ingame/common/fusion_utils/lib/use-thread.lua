require("./types/fusion")
return function(p1, p2, ...) -- name: useThread
	local v_u_3 = task.spawn(p2, ...)
	table.insert(p1, function()
		-- upvalues: (copy) v_u_3
		task.cancel(v_u_3)
	end)
	return v_u_3
end