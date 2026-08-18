local v_u_1 = require("./ServerProcess")
local v2 = {}
local v_u_3 = {
	["__index"] = v2,
	["__tostring"] = function(_) -- name: __tostring
		return "ServerConnection"
	end
}
function v2.Disconnect(p4) -- name: Disconnect
	p4.Connected = nil
	p4._disconnectCallback()
	table.clear(p4)
	setmetatable(p4, nil)
end
return function(p5, p6)
	-- upvalues: (copy) v_u_3, (copy) v_u_1
	local v7 = v_u_3
	local v8 = setmetatable({
		["Connected"] = true,
		["_disconnectCallback"] = nil,
		["_disconnectCallback"] = function() -- name: _disconnectCallback end
	}, v7)
	v8._disconnectCallback = v_u_1.connect(p5, p6)
	return v8
end