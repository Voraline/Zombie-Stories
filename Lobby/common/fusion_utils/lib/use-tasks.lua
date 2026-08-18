require("./types")
return function(p1, ...) -- name: useTasks
	for v2 = 1, select("#", ...) do
		local v3 = select
		table.insert(p1, v3(v2, ...))
	end
	return ...
end