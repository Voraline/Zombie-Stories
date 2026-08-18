local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(script.Parent.Identifier)
local v_u_4 = require(script.Parent.Parent.Spawn)
local v_u_5 = require(script.Parent.Parent.Signal)
local v_u_6 = require(script.Parent.Net)
local function v_u_10(p7, p8, ...) -- name: FireClient
	-- upvalues: (copy) v_u_2, (copy) v_u_6
	local v9 = v_u_2:IsServer()
	assert(v9, "FireClient can only be called from the server")
	if p7.Unreliable then
		v_u_6.Server.SendUnreliableEvent(p8, p7.Id, table.pack(...))
	else
		v_u_6.Server.SendReliableEvent(p8, p7.Id, table.pack(...))
	end
end
local function v_u_16(p11, ...) -- name: FireAllClients
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_6
	local v12 = v_u_2:IsServer()
	assert(v12, "FireAllClients can only be called from the server")
	local v13 = table.pack(...)
	if p11.Unreliable then
		for _, v14 in v_u_1:GetPlayers() do
			v_u_6.Server.SendUnreliableEvent(v14, p11.Id, v13)
		end
	else
		for _, v15 in v_u_1:GetPlayers() do
			v_u_6.Server.SendReliableEvent(v15, p11.Id, v13)
		end
	end
end
local function v_u_23(p17, p18, ...) -- name: FireAllClientsExcept
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_6
	local v19 = v_u_2:IsServer()
	assert(v19, "FireAllClientsExcept can only be called from the server")
	local v20 = table.pack(...)
	if p17.Unreliable then
		for _, v21 in v_u_1:GetPlayers() do
			if v21 ~= p18 then
				v_u_6.Server.SendUnreliableEvent(v21, p17.Id, v20)
			end
		end
	else
		for _, v22 in v_u_1:GetPlayers() do
			if v22 ~= p18 then
				v_u_6.Server.SendReliableEvent(v22, p17.Id, v20)
			end
		end
	end
end
local function v_u_30(p24, p25, ...) -- name: FireClients
	-- upvalues: (copy) v_u_2, (copy) v_u_6
	local v26 = v_u_2:IsServer()
	assert(v26, "FireClients can only be called from the server")
	local v27 = table.pack(...)
	if p24.Unreliable then
		for _, v28 in p25 do
			v_u_6.Server.SendUnreliableEvent(v28, p24.Id, v27)
		end
	else
		for _, v29 in p25 do
			v_u_6.Server.SendReliableEvent(v29, p24.Id, v27)
		end
	end
end
local function v_u_36(p31, p32, ...) -- name: FireFilteredClients
	-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_6
	local v33 = v_u_2:IsServer()
	assert(v33, "FireFilteredClients can only be called from the server")
	local v34 = table.pack(...)
	for _, v35 in v_u_1:GetPlayers() do
		if p32(v35) then
			if p31.Unreliable then
				v_u_6.Server.SendUnreliableEvent(v35, p31.Id, v34)
			else
				v_u_6.Server.SendReliableEvent(v35, p31.Id, v34)
			end
		end
	end
end
local function v_u_40(p37, ...) -- name: FireServer
	-- upvalues: (copy) v_u_2, (copy) v_u_6
	local v38 = v_u_2:IsClient()
	assert(v38, "FireServer can only be called from the client")
	local v39 = table.pack(...)
	if p37.Unreliable then
		v_u_6.Client.SendUnreliableEvent(p37.Id, v39)
	else
		v_u_6.Client.SendReliableEvent(p37.Id, v39)
	end
end
local function v_u_44(p41, p42) -- name: SetServerListener
	-- upvalues: (copy) v_u_2
	local v43 = v_u_2:IsServer()
	assert(v43, "SetServerListener can only be called from the server")
	p41.Listener = p42
end
local function v_u_48(p45, p46) -- name: SetClientListener
	-- upvalues: (copy) v_u_2
	local v47 = v_u_2:IsClient()
	assert(v47, "SetClientListener can only be called from the client")
	p45.Listener = p46
end
local function v_u_52(p49, p50) -- name: OnServer
	-- upvalues: (copy) v_u_2
	local v51 = v_u_2:IsServer()
	assert(v51, "OnServer can only be called from the server")
	return p49.Signal:Connect(p50)
end
local function v_u_56(p53, p54) -- name: OnClient
	-- upvalues: (copy) v_u_2
	local v55 = v_u_2:IsClient()
	assert(v55, "OnClient can only be called from the client")
	return p53.Signal:Connect(p54)
end
return {
	["SharedCallEvent"] = function(p57, p_u_58) -- name: SharedCallEvent
		-- upvalues: (copy) v_u_3, (copy) v_u_10, (copy) v_u_16, (copy) v_u_23, (copy) v_u_30, (copy) v_u_36, (copy) v_u_40, (copy) v_u_44, (copy) v_u_48, (copy) v_u_2, (copy) v_u_6, (copy) v_u_4
		if typeof(p57) == "string" then
			p57 = {
				["Name"] = nil,
				["Unreliable"] = false,
				["Name"] = p57
			}
		end
		local v59 = p57.Name
		local v60 = p57.Unreliable or false
		local v_u_61 = {
			["Id"] = v_u_3.Shared(v59):Await(),
			["Unreliable"] = v60,
			["FireClient"] = v_u_10,
			["FireAllClients"] = v_u_16,
			["FireAllClientsExcept"] = v_u_23,
			["FireClients"] = v_u_30,
			["FireFilteredClients"] = v_u_36,
			["FireServer"] = v_u_40,
			["CallMode"] = "Call",
			["SetServerListener"] = v_u_44,
			["SetClientListener"] = v_u_48,
			["Listener"] = nil
		}
		if v_u_2:IsServer() then
			v_u_6.Server.SetListener(v_u_61.Id, function(p62, p63)
				-- upvalues: (ref) v_u_4, (copy) v_u_61, (copy) p_u_58
				v_u_4(function(p64, ...)
					-- upvalues: (ref) v_u_61, (ref) p_u_58
					if v_u_61.Listener and pcall(p_u_58, ...) then
						v_u_61.Listener(p64, ...)
					end
				end, p62, table.unpack(p63))
			end)
			return v_u_61
		else
			v_u_6.Client.SetListener(v_u_61.Id, function(p65)
				-- upvalues: (ref) v_u_4, (copy) v_u_61, (copy) p_u_58
				v_u_4(function(...)
					-- upvalues: (ref) v_u_61, (ref) p_u_58
					if v_u_61.Listener and pcall(p_u_58, ...) then
						v_u_61.Listener(...)
					end
				end, table.unpack(p65))
			end)
			return v_u_61
		end
	end,
	["SharedSignalEvent"] = function(p66, p_u_67) -- name: SharedSignalEvent
		-- upvalues: (copy) v_u_3, (copy) v_u_10, (copy) v_u_16, (copy) v_u_23, (copy) v_u_30, (copy) v_u_36, (copy) v_u_40, (copy) v_u_5, (copy) v_u_52, (copy) v_u_56, (copy) v_u_2, (copy) v_u_6, (copy) v_u_4
		if typeof(p66) == "string" then
			p66 = {
				["Name"] = nil,
				["Unreliable"] = false,
				["Name"] = p66
			}
		end
		local v68 = p66.Name
		local v69 = p66.Unreliable or false
		local v_u_70 = {
			["Id"] = v_u_3.Shared(v68):Await(),
			["Unreliable"] = v69,
			["FireClient"] = v_u_10,
			["FireAllClients"] = v_u_16,
			["FireAllClientsExcept"] = v_u_23,
			["FireClients"] = v_u_30,
			["FireFilteredClients"] = v_u_36,
			["FireServer"] = v_u_40,
			["CallMode"] = "Signal",
			["Signal"] = v_u_5(),
			["OnServer"] = v_u_52,
			["OnClient"] = v_u_56
		}
		if v_u_2:IsServer() then
			v_u_6.Server.SetListener(v_u_70.Id, function(p71, p72)
				-- upvalues: (ref) v_u_4, (copy) p_u_67, (copy) v_u_70
				v_u_4(function(p73, ...)
					-- upvalues: (ref) p_u_67, (ref) v_u_70
					if pcall(p_u_67, ...) then
						v_u_70.Signal:Fire(p73, ...)
					end
				end, p71, table.unpack(p72))
			end)
			return v_u_70
		else
			v_u_6.Client.SetListener(v_u_70.Id, function(p74)
				-- upvalues: (ref) v_u_4, (copy) p_u_67, (copy) v_u_70
				v_u_4(function(...)
					-- upvalues: (ref) p_u_67, (ref) v_u_70
					if pcall(p_u_67, ...) then
						v_u_70.Signal:Fire(...)
					end
				end, table.unpack(p74))
			end)
			return v_u_70
		end
	end
}