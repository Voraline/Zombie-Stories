local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = {}
return function(p_u_4) -- name: OnChange
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	local v5 = v_u_3[p_u_4]
	if v5 == nil then
		v5 = {
			["type"] = "SpecialKey",
			["kind"] = "OnChange",
			["stage"] = "observer",
			["apply"] = nil,
			["apply"] = function(_, p6, p_u_7, p_u_8) -- name: apply
				-- upvalues: (copy) p_u_4, (ref) v_u_2
				local v9, v10 = pcall(p_u_8.GetPropertyChangedSignal, p_u_8, p_u_4)
				if v9 then
					if typeof(p_u_7) == "function" then
						local function v11()
							-- upvalues: (copy) p_u_7, (copy) p_u_8, (ref) p_u_4
							p_u_7(p_u_8[p_u_4])
						end
						table.insert(p6, v10:Connect(v11))
					else
						v_u_2.logError("invalidChangeHandler", nil, p_u_4)
					end
				else
					v_u_2.logError("cannotConnectChange", nil, p_u_8.ClassName, p_u_4)
					return
				end
			end
		}
		v_u_3[p_u_4] = v5
	end
	return v5
end