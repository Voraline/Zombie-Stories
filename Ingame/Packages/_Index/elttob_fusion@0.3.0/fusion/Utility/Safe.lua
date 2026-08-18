local _ = script.Parent.Parent
return function(p1) -- name: Safe
	local _, v2 = xpcall(p1.try, p1.fallback)
	return v2
end