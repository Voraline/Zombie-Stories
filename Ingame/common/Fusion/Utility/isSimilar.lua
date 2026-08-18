return function(p1, p2) -- name: isSimilar
	if typeof(p1) == "table" then
		return false
	else
		return p1 == p2
	end
end