local v_u_1 = require("../Utilities/Output")
return function(p2)
	-- upvalues: (copy) v_u_1
	v_u_1.warn(string.format("Player %*:%* sent an invalid packet. Likely exploiter- or something interacted with the internal BridgeNet API.", p2.Name, p2.UserId))
end