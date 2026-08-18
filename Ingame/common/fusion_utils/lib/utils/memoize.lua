local function v_u_6(p1, p2, p3) -- name: setCached
	for v4 = 1, p2.n do
		local v5 = p2[v4]
		p1.children = p1.children or {}
		p1.children[v5] = p1.children[v5] or {}
		p1 = p1.children[v5]
	end
	p1.returns = p3
end
return function(p_u_7) -- name: memoize
	-- upvalues: (copy) v_u_6
	local v_u_8 = {}
	return function(...)
		-- upvalues: (copy) v_u_8, (copy) p_u_7, (ref) v_u_6
		local v9 = table.pack(...)
		local v10 = v_u_8
		for v11 = 1, v9.n do
			local v12 = v10.children
			if v12 then
				v10 = v10.children[v9[v11]]
			else
				v10 = v12
			end
			if not v10 then
				v13 = nil
				::l7::
				if not v13 then
					v13 = table.pack(p_u_7(...))
					v_u_6(v_u_8, v9, assert(v13, "Luau"))
				end
				return table.unpack(v13)
			end
		end
		local v13 = v10.returns
		goto l7
	end
end