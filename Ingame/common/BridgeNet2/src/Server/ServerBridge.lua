local v_u_1 = require("../Constants")
local v_u_2 = require("../../RemotePacketSizeCounter")
local v_u_3 = require("./ServerProcess")
local v_u_4 = require("../../TableKit")
require("../Types")
local v_u_5 = require("../Utilities/Output")
local v_u_6 = require("./PlayerContainers")
local v_u_7 = require("./ServerConnection")
local v_u_8 = require("./ServerIdentifiers")
local v_u_9 = game:GetService("Players")
local function v_u_13(p10) -- name: toStringData
	-- upvalues: (copy) v_u_4
	if typeof(p10) == "table" then
		if v_u_4.IsArray(p10) then
			return v_u_4.ToArrayString(p10)
		else
			return v_u_4.ToString(p10)
		end
	else
		local v11 = ""
		local v12 = ""
		if typeof(p10) == "CFrame" then
			v11 = "CFrame("
			v12 = ")"
		elseif typeof(p10) == "Vector3" then
			v11 = "Vector3("
			v12 = ")"
		end
		return ("%*%*%*"):format(v11, tostring(p10), v12)
	end
end
local v14 = {}
local v_u_15 = {
	["__index"] = v14,
	["__tostring"] = function(_) -- name: __tostring
		return "ServerBridge"
	end
}
function v14.InboundMiddleware(p16, p17) -- name: InboundMiddleware
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p16) == "ServerBridge", "InboundMiddleware called with . instead of :")
	p16._inboundMiddleware = p17
end
function v14.OutboundMiddleware(p18, p19) -- name: OutboundMiddleware
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p18) == "ServerBridge", "OutboundMiddleware called with . instead of :")
	p18._outboundMiddleware = p19
end
function v14.Connect(p_u_20, p_u_21) -- name: Connect
	-- upvalues: (copy) v_u_5, (copy) v_u_7, (copy) v_u_8, (copy) v_u_1, (copy) v_u_13, (copy) v_u_2
	v_u_5.fatalAssert(tostring(p_u_20) == "ServerBridge", "Connect called with . instead of :")
	v_u_5.typecheck("function", "Connect", "callback", p_u_21)
	return v_u_7(p_u_20._identifier, function(p_u_22, p23)
		-- upvalues: (ref) v_u_8, (copy) p_u_20, (ref) v_u_5, (ref) v_u_1, (ref) v_u_13, (ref) v_u_2, (copy) p_u_21
		if typeof(p23) == "table" and p23[1] == v_u_8.ref("REQUEST") then
			return
		else
			if p_u_20.RateLimitActive then
				if p_u_20._rateMap[p_u_22] == nil then
					p_u_20._rateMap[p_u_22] = 1
				else
					local v24 = p_u_20._rateMap[p_u_22]
					p_u_20._rateMap[p_u_22] = v24 + 1
				end
				task.delay(1, function()
					-- upvalues: (ref) p_u_20, (copy) p_u_22
					local v25 = p_u_20._rateMap[p_u_22]
					local v26 = p_u_20._rateMap
					local v27 = p_u_22
					local v28 = v25 - 1
					v26[v27] = math.min(0, v28)
				end)
				if p_u_20._rateMap[p_u_22] >= p_u_20._maxRate and not p_u_20._overflowFunction(p_u_22) then
					return
				end
			end
			if p_u_20._inboundMiddleware == nil then
				if p_u_20.Logging then
					local v29 = string.format(v_u_1.SERVER_CONNECT_LOG, p_u_20._name, p_u_22.Name, v_u_13(p23), v_u_2.GetDataByteSize(p23))
					v_u_5.log(v29)
				end
				p_u_21(p_u_22, p23)
			else
				local v30 = p23
				for _, v31 in p_u_20._inboundMiddleware do
					local v32 = v31(p_u_22, p23)
					if typeof(v32) == "table" then
						p23 = v32
					else
						v_u_5.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", p_u_20._name))
					end
				end
				if p_u_20.Logging and p_u_20.Logging then
					local v33 = string.format(v_u_1.SERVER_CONNECT_LOG, p_u_20._name, p_u_22.Name, v_u_13(v30), v_u_2.GetDataByteSize(v30))
					v_u_5.log(v33)
				end
				p_u_21(p_u_22, p23)
			end
		end
	end)
end
function v14.RateLimit(p34, p35, p36) -- name: RateLimit
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p34) == "ServerBridge", "RateLimit called with . instead of :")
	p34.RateLimitActive = true
	p34._overflowFunction = p36
	p34._maxRate = p35
end
function v14.DisableRateLimit(p37) -- name: DisableRateLimit
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p37) == "ServerBridge", "DisableRateLimit called with . instead of :")
	p37.RateLimitActive = false
end
function v14.Wait(p38) -- name: Wait
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p38) == "ServerBridge", "Wait called with . instead of :")
	local v_u_39 = coroutine.running()
	p38:Connect(function(p40, p41)
		-- upvalues: (copy) v_u_39
		coroutine.resume(v_u_39, p40, p41)
	end)
	return coroutine.yield()
end
function v14.Once(p42, p_u_43) -- name: Once
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p42) == "ServerBridge", "Once called with . instead of :")
	v_u_5.typecheck("function", "Once", "callback", p_u_43)
	local v_u_44 = nil
	v_u_44 = p42:Connect(function(p45, p46)
		-- upvalues: (ref) v_u_44, (copy) p_u_43
		v_u_44:Disconnect()
		p_u_43(p45, p46)
	end)
	return v_u_44
end
function v14.FireAllInRangeExcept(p47, p48, p49, p50, p51) -- name: FireAllInRangeExcept
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	local v52 = {}
	local v53 = {}
	for _, v54 in ipairs(p51) do
		v52[v54] = true
	end
	for _, v55 in v_u_9:GetPlayers() do
		if v55:DistanceFromCharacter(p48) <= p49 and not v52[v55] then
			table.insert(v53, v55)
		end
	end
	p47:Fire(v_u_6.Players(v53), p50)
	return v53
end
function v14.FireAllInRange(p56, p57, p58, p59) -- name: FireAllInRange
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	local v60 = {}
	for _, v61 in v_u_9:GetPlayers() do
		if v61:DistanceFromCharacter(p57) <= p58 then
			table.insert(v60, v61)
		end
	end
	p56:Fire(v_u_6.Players(v60), p59)
	return v60
end
function v14.Fire(p62, p63, p64) -- name: Fire
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_1, (copy) v_u_4, (copy) v_u_13, (copy) v_u_2, (copy) v_u_3
	v_u_5.fatalAssert(tostring(p62) == "ServerBridge", "Fire called with . instead of :")
	local v65 = nil
	if typeof(p63) == "Instance" then
		if p63:IsA("Player") then
			v65 = v_u_6.Single(p63)
		else
			v_u_5.fatal("non-player instance passed into :Fire()")
		end
	else
		if typeof(p63) == "nil" then
			v_u_5.fatal("target parameter passed into ServerBridge:Fire() is nil")
		end
		v_u_5.typecheck("table", "Fire", "target", p63)
		v65 = p63
	end
	if p62._outboundMiddleware == nil then
		if p62.Logging and p62.Logging then
			local v66 = string.format
			local v67 = v_u_1.SERVER_FIRE_LOG
			local v68 = p62._name
			local v69
			if v65.kind == "all" then
				v69 = "{all}"
			elseif v65.kind == "single" then
				v69 = v65.value.Name
			else
				v69 = v_u_4.ToArrayString(v65.value)
			end
			local v70 = v66(v67, v68, v69, v_u_13(p64), v_u_2.GetDataByteSize(p64))
			v_u_5.log(v70)
		end
		v_u_3.addToQueue(v65, p62._identifier, p64)
	else
		for _, v71 in p62._outboundMiddleware do
			local v72 = v71(p64)
			if typeof(v72) == "table" then
				p64 = v72
			else
				v_u_5.silent(string.format("Outbound middleware on bridge %* did not return a table; ignoring the return.", p62._name))
			end
		end
		if p62.Logging then
			local v73 = string.format
			local v74 = v_u_1.SERVER_FIRE_LOG
			local v75 = p62._name
			local v76
			if v65.kind == "all" then
				v76 = "{all}"
			elseif v65.kind == "single" then
				v76 = v65.value.Name
			else
				v76 = v_u_4.ToArrayString(v65.value)
			end
			local v77 = v73(v74, v75, v76, v_u_13(p64), v_u_2.GetDataByteSize(p64))
			v_u_5.log(v77)
		end
		v_u_3.addToQueue(v65, p62._identifier, p64)
	end
end
return function(p78)
	-- upvalues: (copy) v_u_8, (copy) v_u_15, (copy) v_u_3
	local v79 = {
		["_identifier"] = nil,
		["_outboundMiddleware"] = nil,
		["_inboundMiddleware"] = nil,
		["_name"] = nil,
		["Logging"] = false,
		["OnServerInvoke"] = nil,
		["RateLimitActive"] = false,
		["_maxRate"] = 500,
		["_rateMap"] = nil,
		["_overflowFunction"] = nil,
		["_identifier"] = v_u_8.ref(p78),
		["_name"] = p78,
		["OnServerInvoke"] = function() end,
		["_rateMap"] = {},
		["_overflowFunction"] = function() -- name: _overflowFunction
			return false
		end
	}
	local v80 = v_u_15
	local v_u_81 = setmetatable(v79, v80)
	v_u_3.registerBridge(v_u_81._identifier)
	v_u_3.connect(v_u_81._identifier, function(p82, p83)
		-- upvalues: (copy) v_u_81, (ref) v_u_8
		if typeof(p83) == "table" then
			if v_u_81.OnServerInvoke ~= nil and p83[1] == v_u_8.ref("REQUEST") then
				local v84 = p83[2]
				local v85 = v_u_81.OnServerInvoke(p82, p83[3])
				v_u_81:Fire(p82, { v_u_8.ref("REQUEST"), v84, v85 })
			end
		end
	end)
	return v_u_81
end