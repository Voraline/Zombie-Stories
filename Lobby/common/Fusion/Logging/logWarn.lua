local v1 = script.Parent.Parent
local v_u_2 = require(v1.Logging.messages)
return function(p3, ...) -- name: logWarn
	-- upvalues: (copy) v_u_2
	local v4
	if v_u_2[p3] == nil then
		p3 = "unknownMessage"
		v4 = v_u_2[p3]
	else
		v4 = v_u_2[p3]
	end
	warn(string.format("[Fusion] " .. v4 .. "\n(ID: " .. p3 .. ")", ...))
end