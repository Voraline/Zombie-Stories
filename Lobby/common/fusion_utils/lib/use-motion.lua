local v_u_1 = require("./utils/finder")
require("./types/fusion")
require("./types/ripple")
local v_u_2 = require(script.Parent.utils["lock-value"])
local v_u_3 = require(script.Parent["use-event-listener"])
local v_u_4 = game:GetService("RunService")
return function(p5, p6) -- name: useMotion
	-- upvalues: (copy) v_u_1, (copy) v_u_3, (copy) v_u_4, (copy) v_u_2
	local v7 = v_u_1.find(v_u_1.libraries.ripple, "useMotion")
	local v_u_8 = p5.peek
	local v_u_9 = v7.createMotion(p6)
	local v_u_10 = p5:Value(p6)
	v_u_3(p5, v_u_4.Heartbeat, function(p11)
		-- upvalues: (copy) v_u_9, (copy) v_u_8, (copy) v_u_10
		local v12 = v_u_9:step(p11)
		if v12 ~= v_u_8(v_u_10) then
			v_u_10:set(v12)
		end
	end)
	return v_u_2(v_u_10), v_u_9
end