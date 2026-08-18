local function v_u_5(p1) -- name: deepCopy
	-- upvalues: (copy) v_u_5
	local v2 = {}
	for v3, v4 in pairs(p1) do
		if type(v4) == "table" then
			v2[v3] = v_u_5(v4)
		else
			v2[v3] = v4
		end
	end
	return v2
end
return v_u_5