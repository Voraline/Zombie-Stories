local v1 = script.Parent.Parent
local v_u_2 = require(v1.Logging.logError)
return function(p_u_3, p4) -- name: restrictRead
	-- upvalues: (copy) v_u_2
	local v5 = getmetatable(p4)
	if v5 == nil then
		v5 = {}
		setmetatable(p4, v5)
	end
	function v5.__index(_, p6) -- name: __index
		-- upvalues: (ref) v_u_2, (copy) p_u_3
		v_u_2("strictReadError", nil, tostring(p6), p_u_3)
	end
	return p4
end