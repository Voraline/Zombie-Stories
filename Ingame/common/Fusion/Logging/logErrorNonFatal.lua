local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.Logging.messages)
return function(p3, p4, ...) -- name: logErrorNonFatal
	-- upvalues: (copy) v_u_2
	local v5
	if v_u_2[p3] == nil then
		p3 = "unknownMessage"
		v5 = v_u_2[p3]
	else
		v5 = v_u_2[p3]
	end
	local v_u_6
	if p4 == nil then
		v_u_6 = string.format("[Fusion] " .. v5 .. "\n(ID: " .. p3 .. ")", ...)
	else
		local v7 = v5:gsub("ERROR_MESSAGE", p4.message)
		v_u_6 = string.format("[Fusion] " .. v7 .. "\n(ID: " .. p3 .. ")\n---- Stack trace ----\n" .. p4.trace, ...)
	end
	task.spawn(function(...)
		-- upvalues: (ref) v_u_6
		error(v_u_6:gsub("\n", "\n    "), 0)
	end, ...)
end