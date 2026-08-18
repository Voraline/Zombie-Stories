local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Logging.logError)
local v_u_3 = require(v1.Utility.xtypeof)
return function(p_u_4) -- name: Out
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	return {
		["type"] = "SpecialKey",
		["kind"] = "Out",
		["stage"] = "observer",
		["apply"] = function(_, p_u_5, p_u_6, p7) -- name: apply
			-- upvalues: (copy) p_u_4, (ref) v_u_2, (ref) v_u_3
			local v8, v9 = pcall(p_u_6.GetPropertyChangedSignal, p_u_6, p_u_4)
			if v8 then
				if v_u_3(p_u_5) == "State" and p_u_5.kind == "Value" then
					p_u_5:set(p_u_6[p_u_4])
					local function v10()
						-- upvalues: (copy) p_u_5, (copy) p_u_6, (ref) p_u_4
						p_u_5:set(p_u_6[p_u_4])
					end
					table.insert(p7, v9:Connect(v10))
					table.insert(p7, function()
						-- upvalues: (copy) p_u_5
						p_u_5:set(nil)
					end)
				else
					v_u_2("invalidOutType")
				end
			else
				v_u_2("invalidOutProperty", nil, p_u_6.ClassName, p_u_4)
				return
			end
		end
	}
end