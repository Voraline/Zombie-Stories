local v_u_1 = game:GetService("RunService")
local v_u_2 = require(script.Parent.Identifier)
local v_u_3 = require(script.Server)
local v_u_4 = require(script.Client)
local function v_u_7(p5) -- name: Server
	-- upvalues: (copy) v_u_1, (copy) v_u_3
	local v6 = v_u_1:IsServer()
	assert(v6, "Server events can only be accessed from the server")
	if not p5.ServerEvent then
		p5.ServerEvent = v_u_3(p5.Id, p5.Validate, p5.Unreliable)
	end
	return p5.ServerEvent
end
local function v_u_10(p8) -- name: Client
	-- upvalues: (copy) v_u_1, (copy) v_u_4
	local v9 = v_u_1:IsClient()
	assert(v9, "Client events can only be accessed from the client")
	if not p8.ClientEvent then
		p8.ClientEvent = v_u_4(p8.Id, p8.Unreliable)
	end
	return p8.ClientEvent
end
return function(p11, p12) -- name: Event
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_10
	local v13, v14
	if type(p11) == "string" then
		v13 = p11
		v14 = false
	else
		v13 = p11.Name
		v14 = p11.Unreliable or false
	end
	local v15 = not v_u_2.Exists(v13)
	assert(v15, "Cannot use same name twice")
	return {
		["Id"] = nil,
		["Validate"] = nil,
		["Unreliable"] = nil,
		["ServerEvent"] = nil,
		["ClientEvent"] = nil,
		["Server"] = nil,
		["Client"] = nil,
		["Id"] = v_u_2.Shared(v13):Await(),
		["Validate"] = p12,
		["Unreliable"] = v14,
		["Server"] = v_u_7,
		["Client"] = v_u_10
	}
end