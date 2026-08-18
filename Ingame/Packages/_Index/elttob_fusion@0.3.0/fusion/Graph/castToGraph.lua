local v1 = script.Parent.Parent
require(v1.Types)
return function(p2) -- name: castToGraph
	if typeof(p2) == "table" then
		local v3 = p2.validity
		if typeof(v3) == "string" then
			local v4 = p2.timeliness
			if typeof(v4) == "string" then
				local v5 = p2.dependencySet
				if typeof(v5) == "table" then
					local v6 = p2.dependentSet
					if typeof(v6) == "table" then
						return p2
					end
				end
			end
		end
	end
	return nil
end