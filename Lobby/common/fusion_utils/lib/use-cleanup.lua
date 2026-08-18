require("./types/fusion")
return function(p1, ...) -- name: useCleanup
	for v2 = 1, select("#", ...) do
		local v3 = select
		table.insert(p1, v3(v2, ...))
	end
	return ...
end