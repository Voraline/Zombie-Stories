local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.ExternalDebug)
local v_u_3 = require(v1.Memory.deriveScopeImpl)
return function(p_u_4, ...) -- name: innerScope
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v_u_5 = v_u_3(p_u_4, ...)
	table.insert(p_u_4, v_u_5)
	table.insert(v_u_5, function()
		-- upvalues: (copy) p_u_4, (copy) v_u_5
		local v6 = table.find(p_u_4, v_u_5)
		if v6 ~= nil then
			table.remove(p_u_4, v6)
		end
	end)
	v_u_2.trackScope(v_u_5)
	return v_u_5
end