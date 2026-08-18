local v_u_1 = require("./ClientConnection")
local v_u_2 = require("./ClientIdentifiers")
local v_u_3 = require("./ClientProcess")
local v_u_4 = require("../Constants")
local v_u_5 = require("../Utilities/Output")
local v_u_6 = require("../../TableKit")
local v_u_7 = require("../../RemotePacketSizeCounter")
require("../Types")
local v_u_8 = require("../../../Promise")
local v_u_9 = 0
local v10 = {}
local v_u_11 = {
	["__index"] = v10,
	["__tostring"] = function(_) -- name: __tostring
		return "ClientBridge"
	end
}
function v10.RateLimit(_) -- name: RateLimit
	-- upvalues: (copy) v_u_5
	v_u_5.warn("cannot call :RateLimit() from client")
end
function v10.DisableRateLimit(_) -- name: DisableRateLimit
	-- upvalues: (copy) v_u_5
	v_u_5.warn("cannot call :DisableRateLimit() from client")
end
function v10.InboundMiddleware(p12, p13) -- name: InboundMiddleware
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	v_u_5.fatalAssert(tostring(p12) == "ClientBridge", "InboundMiddleware called with . instead of :")
	v_u_5.fatalAssert(typeof(p13) == "table", string.format("InboundMiddleware takes table, got %*", (typeof(p13))))
	v_u_5.warnAssert(v_u_6.IsArray(p13), "InboundMiddleware takes array, got dictionary.")
	p12._inboundMiddleware = p13
end
function v10.OutboundMiddleware(p14, p15) -- name: OutboundMiddleware
	-- upvalues: (copy) v_u_5, (copy) v_u_6
	v_u_5.fatalAssert(tostring(p14) == "ClientBridge", "OutboundMiddleware called with . instead of :")
	v_u_5.fatalAssert(typeof(p15) == "table", string.format("OutboundMiddleware takes table, got %*", (typeof(p15))))
	v_u_5.warnAssert(v_u_6.IsArray(p15), "InboundMiddleware takes array, got dictionary.")
	p14._outboundMiddleware = p15
end
function v10.Fire(p16, p17) -- name: Fire
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_6, (copy) v_u_7, (copy) v_u_3
	v_u_5.fatalAssert(tostring(p16) == "ClientBridge", "Fire called with . instead of :")
	if p16._outboundMiddleware == nil then
		if p16.Logging then
			local v18 = string.format
			local v19 = v_u_4.CLIENT_FIRE_LOG
			local v20 = p16._name
			local v21
			if typeof(p17) == "table" then
				v21 = v_u_6.ToString(p17)
			else
				v21 = tostring(p17)
			end
			local v22 = v18(v19, v20, v21, v_u_7.GetDataByteSize(p17))
			v_u_5.log(v22)
		end
		v_u_3.addToQueue(p16._identifier, p17)
	else
		for _, v23 in p16._outboundMiddleware do
			local v24 = v23(p17)
			if typeof(v24) == "table" then
				p17 = v24
			else
				v_u_5.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", p16._name))
			end
		end
		if p16.Logging then
			local v25 = string.format
			local v26 = v_u_4.CLIENT_FIRE_LOG
			local v27 = p16._name
			local v28
			if typeof(p17) == "table" then
				v28 = v_u_6.ToString(p17)
			else
				v28 = tostring(p17)
			end
			local v29 = v25(v26, v27, v28, v_u_7.GetDataByteSize(p17))
			v_u_5.log(v29)
		end
		v_u_3.addToQueue(p16._identifier, p17)
	end
end
function v10.Connect(p_u_30, p_u_31) -- name: Connect
	-- upvalues: (copy) v_u_5, (copy) v_u_1, (copy) v_u_2, (copy) v_u_4, (copy) v_u_6, (copy) v_u_7
	v_u_5.fatalAssert(tostring(p_u_30) == "ClientBridge", "connect called with . instead of :")
	v_u_5.typecheck("function", "Connect", "callback", p_u_31)
	return v_u_1(p_u_30._identifier, function(p32)
		-- upvalues: (ref) v_u_2, (copy) p_u_30, (ref) v_u_5, (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (copy) p_u_31
		if typeof(p32) == "table" and p32[1] == v_u_2.ref("REQUEST") then
			return
		elseif p_u_30._inboundMiddleware == nil then
			if p_u_30.Logging then
				local v33 = string.format
				local v34 = v_u_4.CLIENT_CONNECT_LOG
				local v35 = p_u_30._name
				local v36
				if typeof(p32) == "table" then
					v36 = v_u_6.ToString(p32)
				else
					v36 = tostring(p32)
				end
				local v37 = v33(v34, v35, v36, v_u_7.GetDataByteSize(p32))
				v_u_5.log(v37)
			end
			p_u_31(p32)
		else
			for _, v38 in p_u_30._inboundMiddleware do
				local v39 = v38(p32)
				if typeof(v39) == "table" then
					p32 = v39
				else
					v_u_5.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", p_u_30._name))
				end
			end
			if p_u_30.Logging then
				local v40 = string.format
				local v41 = v_u_4.CLIENT_CONNECT_LOG
				local v42 = p_u_30._name
				local v43
				if typeof(p32) == "table" then
					v43 = v_u_6.ToString(p32)
				else
					v43 = tostring(p32)
				end
				local v44 = v40(v41, v42, v43, v_u_7.GetDataByteSize(p32))
				v_u_5.log(v44)
			end
			p_u_31(p32)
		end
	end)
end
function v10.Wait(p45) -- name: Wait
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p45) == "ClientBridge", "Wait called with . instead of :")
	local v_u_46 = coroutine.running()
	p45:Once(function(p47)
		-- upvalues: (copy) v_u_46
		coroutine.resume(v_u_46, p47)
	end)
	return coroutine.yield()
end
function v10.Invoke(p_u_48, p_u_49) -- name: Invoke
	-- upvalues: (copy) v_u_8
	return v_u_8.new(function(p50, _)
		-- upvalues: (copy) p_u_48, (copy) p_u_49
		p50((p_u_48:InvokeServerAsync(p_u_49)))
	end)
end
function v10.InvokeServerAsync(p51, p52) -- name: InvokeServerAsync
	-- upvalues: (copy) v_u_5, (ref) v_u_9, (copy) v_u_2, (copy) v_u_3
	v_u_5.fatalAssert(tostring(p51) == "ClientBridge", "InvokeServerAsync called with . instead of :")
	local v_u_53 = v_u_9
	v_u_9 = v_u_9 + 1
	p51:Fire({ v_u_2.ref("REQUEST"), v_u_53, p52 })
	local v_u_54 = coroutine.running()
	local v_u_55 = nil
	v_u_55 = v_u_3.connect(p51._identifier, function(p56)
		-- upvalues: (ref) v_u_2, (copy) v_u_53, (ref) v_u_55, (copy) v_u_54
		if typeof(p56) == "table" then
			if p56[1] == v_u_2.ref("REQUEST") and p56[2] == v_u_53 then
				v_u_55()
				coroutine.resume(v_u_54, p56[3])
			end
		end
	end)
	return coroutine.yield()
end
function v10.Once(p57, p_u_58) -- name: Once
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p57) == "ClientBridge", "Once called with . instead of :")
	local v_u_59 = nil
	v_u_59 = p57:Connect(function(p60)
		-- upvalues: (ref) v_u_59, (copy) p_u_58
		v_u_59:Disconnect()
		p_u_58(p60)
	end)
	return v_u_59
end
function v10.Destroy(p61) -- name: Destroy
	-- upvalues: (copy) v_u_5
	v_u_5.fatalAssert(tostring(p61) == "ClientBridge", "Destroy called with . instead of :")
	table.clear(p61)
	setmetatable(p61, nil)
end
return function(p62)
	-- upvalues: (copy) v_u_2, (copy) v_u_11, (copy) v_u_3
	local v63 = {
		["Logging"] = false,
		["_identifier"] = nil,
		["_name"] = nil,
		["_inboundMiddleware"] = nil,
		["_outboundMiddleware"] = nil,
		["_identifier"] = v_u_2.ref(p62),
		["_name"] = p62,
		["_inboundMiddleware"] = {},
		["_outboundMiddleware"] = {}
	}
	local v64 = v_u_11
	local v65 = setmetatable(v63, v64)
	v_u_3.registerBridge(v65._identifier)
	return v65
end