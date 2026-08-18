return function(p_u_1) -- name: Symbol
	local v2 = newproxy(true)
	getmetatable(v2).__tostring = function() -- name: __tostring
		-- upvalues: (copy) p_u_1
		return p_u_1
	end
	return v2
end