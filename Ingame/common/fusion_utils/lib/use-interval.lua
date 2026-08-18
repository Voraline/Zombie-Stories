local v_u_1 = game:GetService("RunService")
require("./types/fusion")
local v_u_2 = require(script.Parent["use-event-listener"])
local v_u_3 = require(script.Parent["use-thread"])
return function(p4, p_u_5, p_u_6, p7) -- name: useInterval
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_3
	local v_u_8 = p4:innerScope()
	local v_u_9 = v_u_8.peek
	local v_u_10 = nil
	if p7 == nil then
		p7 = false
	end
	local v_u_11 = 0
	local v_u_12 = nil
	v_u_12 = v_u_2(v_u_8, v_u_1.Heartbeat, function(p13)
		-- upvalues: (ref) v_u_11, (copy) v_u_9, (copy) p_u_5, (ref) v_u_12, (ref) v_u_10, (copy) v_u_8, (copy) p_u_6
		v_u_11 = v_u_11 + p13
		local v14 = v_u_9
		local v15 = p_u_5
		if typeof(v14(v15)) == "number" then
			if v_u_11 >= v_u_9(p_u_5) then
				v_u_11 = 0
				if v_u_10 then
					v_u_10:doCleanup()
				end
				v_u_10 = v_u_8:innerScope()
				p_u_6(v_u_10)
			end
		else
			return v_u_12()
		end
	end)
	if p7 then
		local v16 = v_u_8:innerScope()
		v_u_3(v_u_8, p_u_6, v16)
	end
end