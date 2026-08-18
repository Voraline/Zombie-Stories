require("../types/fusion")
return function(p1) -- name: castToState
	local v2 = getmetatable(p1)
	if typeof(v2) == "table" and v2.type == "State" then
		local v3 = v2.kind
		if typeof(v3) == "string" then
			return p1
		end
	end
	return nil
end