local v_u_1 = game:GetService("RunService")
require("./types/fusion")
local v_u_2 = require(script.Parent["use-event-listener"])
return function(p_u_3, p_u_4) -- name: useTimer
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	local v_u_5 = p_u_3:Value(p_u_4 or 0)
	local v_u_6 = true
	v_u_2(p_u_3, v_u_1.Heartbeat, function(p7)
		-- upvalues: (ref) v_u_6, (copy) v_u_5, (copy) p_u_3
		if v_u_6 then
			v_u_5:set(p_u_3.peek(v_u_5) + p7)
		end
	end)
	local v8 = {}
	setmetatable(v8, {
		["__index"] = v_u_5
	})
	function v8.start(_) -- name: start
		-- upvalues: (ref) v_u_6
		v_u_6 = true
	end
	function v8.stop(_) -- name: stop
		-- upvalues: (ref) v_u_6
		v_u_6 = false
	end
	function v8.reset(_, p9) -- name: reset
		-- upvalues: (copy) v_u_5, (copy) p_u_4
		v_u_5:set(p9 and p_u_4 or 0)
	end
	return v8
end