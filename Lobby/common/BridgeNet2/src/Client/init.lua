local v_u_1 = require("@self/ClientBridge")
local v_u_2 = require("@self/ClientIdentifiers")
local v_u_3 = require("@self/ClientProcess")
require("./Types")
return {
	["start"] = function() -- name: start
		-- upvalues: (copy) v_u_3, (copy) v_u_2
		v_u_3.start()
		v_u_2.start()
	end,
	["ser"] = function(p4) -- name: ser
		-- upvalues: (copy) v_u_2
		return v_u_2.ser(p4)
	end,
	["deser"] = function(p5) -- name: deser
		-- upvalues: (copy) v_u_2
		return v_u_2.deser(p5)
	end,
	["makeIdentifier"] = function(p6, p7) -- name: makeIdentifier
		-- upvalues: (copy) v_u_2
		return v_u_2.ref(p6, p7)
	end,
	["makeBridge"] = function(p8) -- name: makeBridge
		-- upvalues: (copy) v_u_1
		return v_u_1(p8)
	end
}