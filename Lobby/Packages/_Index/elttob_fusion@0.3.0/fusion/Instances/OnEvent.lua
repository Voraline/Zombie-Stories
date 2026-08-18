local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = {}
local function v_u_6(p4, p5) -- name: getProperty_unsafe
	return p4[p5]
end
return function(p_u_7) -- name: OnEvent
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_2
	local v8 = v_u_3[p_u_7]
	if v8 == nil then
		v8 = {
			["type"] = "SpecialKey",
			["kind"] = "OnEvent",
			["stage"] = "observer",
			["apply"] = nil,
			["apply"] = function(_, p9, p10, p11) -- name: apply
				-- upvalues: (ref) v_u_6, (copy) p_u_7, (ref) v_u_2
				local v12, v13 = pcall(v_u_6, p11, p_u_7)
				if v12 and typeof(v13) == "RBXScriptSignal" then
					if typeof(p10) == "function" then
						table.insert(p9, v13:Connect(p10))
					else
						v_u_2.logError("invalidEventHandler", nil, p_u_7)
					end
				else
					v_u_2.logError("cannotConnectEvent", nil, p11.ClassName, p_u_7)
					return
				end
			end
		}
		v_u_3[p_u_7] = v8
	end
	return v8
end