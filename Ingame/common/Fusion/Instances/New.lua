local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Instances.defaultProps)
local v_u_3 = require(v1.Instances.applyInstanceProps)
local v_u_4 = require(v1.Logging.logError)
return function(p_u_5) -- name: New
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_3
	return function(p6)
		-- upvalues: (copy) p_u_5, (ref) v_u_4, (ref) v_u_2, (ref) v_u_3
		local v7, v8 = pcall(Instance.new, p_u_5)
		if not v7 then
			v_u_4("cannotCreateClass", nil, p_u_5)
		end
		local v9 = v_u_2[p_u_5]
		if v9 ~= nil then
			for v10, v11 in pairs(v9) do
				v8[v10] = v11
			end
		end
		v_u_3(p6, v8)
		return v8
	end
end