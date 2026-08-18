local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Logging.logError)
return function(p_u_3) -- name: OnChange
	-- upvalues: (copy) v_u_2
	return {
		["type"] = "SpecialKey",
		["kind"] = "OnChange",
		["stage"] = "observer",
		["apply"] = function(_, p_u_4, p_u_5, p6) -- name: apply
			-- upvalues: (copy) p_u_3, (ref) v_u_2
			local v7, v8 = pcall(p_u_5.GetPropertyChangedSignal, p_u_5, p_u_3)
			if v7 then
				if typeof(p_u_4) == "function" then
					local function v9()
						-- upvalues: (copy) p_u_4, (copy) p_u_5, (ref) p_u_3
						p_u_4(p_u_5[p_u_3])
					end
					table.insert(p6, v8:Connect(v9))
				else
					v_u_2("invalidChangeHandler", nil, p_u_3)
				end
			else
				v_u_2("cannotConnectChange", nil, p_u_5.ClassName, p_u_3)
				return
			end
		end
	}
end