local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Instances.defaultProps)
local v_u_4 = require(v1.Instances.applyInstanceProps)
return function(p_u_5, p_u_6) -- name: New
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	if p_u_6 == nil then
		v_u_2.logError("scopeMissing", nil, "instances using New", "myScope:New \"" .. p_u_5 .. "\" { ... }")
	end
	return function(p7)
		-- upvalues: (copy) p_u_6, (ref) v_u_2, (ref) v_u_3, (copy) p_u_5, (ref) v_u_4
		local v8, v9 = pcall(Instance.new, p_u_6)
		if not v8 then
			v_u_2.logError("cannotCreateClass", nil, p_u_6)
		end
		local v10 = v_u_3[p_u_6]
		if v10 ~= nil then
			for v11, v12 in pairs(v10) do
				v9[v11] = v12
			end
		end
		local v13 = p_u_5
		table.insert(v13, v9)
		v_u_4(p_u_5, p7, v9)
		return v9
	end
end