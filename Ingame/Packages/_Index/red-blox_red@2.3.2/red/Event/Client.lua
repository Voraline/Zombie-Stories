local v_u_1 = require(script.Parent.Parent.Parent.Spawn)
local v_u_2 = require(script.Parent.Parent.Net)
local function v_u_4(p3, ...) -- name: Fire
	-- upvalues: (copy) v_u_2
	if p3.Unreliable then
		v_u_2.Client.SendUnreliableEvent(p3.Id, table.pack(...))
	else
		v_u_2.Client.SendReliableEvent(p3.Id, table.pack(...))
	end
end
local function v_u_8(p5, p_u_6) -- name: On
	-- upvalues: (copy) v_u_2, (copy) v_u_1
	v_u_2.Client.SetListener(p5.Id, function(p7)
		-- upvalues: (ref) v_u_1, (copy) p_u_6
		v_u_1(p_u_6, table.unpack(p7))
	end)
end
return function(p9, p10) -- name: Client
	-- upvalues: (copy) v_u_4, (copy) v_u_8
	return {
		["Id"] = p9,
		["Unreliable"] = p10,
		["Fire"] = v_u_4,
		["On"] = v_u_8
	}
end