require("./Types")
local v_u_1 = require("@self/PlayerContainers")
local v_u_2 = require("@self/ServerBridge")
local v_u_3 = require("@self/ServerIdentifiers")
local v_u_4 = require("@self/ServerProcess")
return {
	["start"] = function() -- name: start
		-- upvalues: (copy) v_u_4, (copy) v_u_3
		v_u_4.start()
		v_u_3.start()
	end,
	["makeBridge"] = function(p5) -- name: makeBridge
		-- upvalues: (copy) v_u_2
		return v_u_2(p5)
	end,
	["ser"] = function(p6) -- name: ser
		-- upvalues: (copy) v_u_3
		return v_u_3.ser(p6)
	end,
	["deser"] = function(p7) -- name: deser
		-- upvalues: (copy) v_u_3
		return v_u_3.deser(p7)
	end,
	["makeIdentifier"] = function(p8) -- name: makeIdentifier
		-- upvalues: (copy) v_u_3
		return v_u_3.ref(p8)
	end,
	["playerContainers"] = function() -- name: playerContainers
		-- upvalues: (copy) v_u_1
		return v_u_1
	end,
	["invalidPlayerhandler"] = function(p9) -- name: invalidPlayerhandler
		-- upvalues: (copy) v_u_4
		v_u_4.setInvalidPlayerFunction(p9)
	end
}