local v1 = script.Parent.Parent
require(v1.PubTypes)
local v_u_2 = require(v1.Logging.logError)
local function v_u_5(p3, p4) -- name: getProperty_unsafe
	return p3[p4]
end
return function(p_u_6) -- name: OnEvent
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	return {
		["type"] = "SpecialKey",
		["kind"] = "OnEvent",
		["stage"] = "observer",
		["apply"] = function(_, p7, p8, p9) -- name: apply
			-- upvalues: (ref) v_u_5, (copy) p_u_6, (ref) v_u_2
			local v10, v11 = pcall(v_u_5, p8, p_u_6)
			if v10 and typeof(v11) == "RBXScriptSignal" then
				if typeof(p7) == "function" then
					table.insert(p9, v11:Connect(p7))
				else
					v_u_2("invalidEventHandler", nil, p_u_6)
				end
			else
				v_u_2("cannotConnectEvent", nil, p8.ClassName, p_u_6)
				return
			end
		end
	}
end