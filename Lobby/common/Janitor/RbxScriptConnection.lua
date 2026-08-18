local v_u_1 = {
	["Connected"] = true
}
v_u_1.__index = v_u_1
function v_u_1.Disconnect(p2) -- name: Disconnect
	if p2.Connected then
		p2.Connected = false
		p2.Connection:Disconnect()
	end
end
function v_u_1._new(p3) -- name: _new
	-- upvalues: (copy) v_u_1
	local v4 = v_u_1
	return setmetatable({
		["Connection"] = p3
	}, v4)
end
function v_u_1.__tostring(p5) -- name: __tostring
	local v6 = p5.Connected
	return "RbxScriptConnection<" .. tostring(v6) .. ">"
end
return v_u_1