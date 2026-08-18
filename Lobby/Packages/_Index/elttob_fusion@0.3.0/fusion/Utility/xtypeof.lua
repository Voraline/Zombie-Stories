return function(p1) -- name: xtypeof
	local v2 = typeof(p1)
	if v2 == "table" then
		local v3 = p1.type
		if typeof(v3) == "string" then
			return p1.type
		end
	end
	return v2
end