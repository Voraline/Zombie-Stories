local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Memory.checkLifetime)
local v_u_4 = require(v1.State.castToState)
local v_u_5 = {}
return function(p_u_6) -- name: Out
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_4, (copy) v_u_3
	local v7 = v_u_5[p_u_6]
	if v7 == nil then
		v7 = {
			["type"] = "SpecialKey",
			["kind"] = "Out",
			["stage"] = "observer",
			["apply"] = nil,
			["apply"] = function(_, p8, p_u_9, p_u_10) -- name: apply
				-- upvalues: (copy) p_u_6, (ref) v_u_2, (ref) v_u_4, (ref) v_u_3
				local v11, v12 = pcall(p_u_10.GetPropertyChangedSignal, p_u_10, p_u_6)
				if not v11 then
					v_u_2.logError("invalidOutProperty", nil, p_u_10.ClassName, p_u_6)
				end
				if not v_u_4(p_u_9) then
					v_u_2.logError("invalidOutType")
				end
				if p_u_9.kind ~= "Value" then
					v_u_2.logError("invalidOutType")
				end
				v_u_3.bOutlivesA(p8, p_u_10, p_u_9.scope, p_u_9.oldestTask, v_u_3.formatters.propertyOutputsTo, p_u_6)
				p_u_9:set(p_u_10[p_u_6])
				local function v13()
					-- upvalues: (copy) p_u_9, (copy) p_u_10, (ref) p_u_6
					p_u_9:set(p_u_10[p_u_6])
				end
				table.insert(p8, v12:Connect(v13))
			end
		}
		v_u_5[p_u_6] = v7
	end
	return v7
end