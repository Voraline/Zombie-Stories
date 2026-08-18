return function(p1, p2) -- name: isSimilar
	local v3 = typeof(p1)
	local v4 = v3 == "table"
	local v5 = v3 == "userdata"
	local v6
	if v4 or v5 then
		if v3 == typeof(p2) and (v5 or (table.isfrozen(p1) or getmetatable(p1) ~= nil)) then
			return p1 == p2
		end
		v6 = false
	elseif p1 == p2 then
		v6 = true
	else
		if p1 ~= p1 then
			return p2 ~= p2
		end
		v6 = false
	end
	return v6
end