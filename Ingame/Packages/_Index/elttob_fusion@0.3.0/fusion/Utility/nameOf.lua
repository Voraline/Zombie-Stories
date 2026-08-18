local v1 = script.Parent.Parent
local v_u_2 = require(v1.Utility.nicknames)
return function(p3, p4) -- name: nameOf
	-- upvalues: (copy) v_u_2
	local v5 = v_u_2[p3]
	if typeof(v5) == "string" then
		return v5
	end
	if typeof(p3) == "table" then
		local v6 = p3.name
		if typeof(v6) == "string" then
			return p3.name
		end
		local v7 = p3.kind
		if typeof(v7) == "string" then
			return p3.kind
		end
		local v8 = p3.type
		if typeof(v8) == "string" then
			return p3.type
		end
	end
	return p4
end