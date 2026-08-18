require("./types/fusion")
local function v_u_8(p1, p_u_2) -- name: connect
	if typeof(p1) == "RBXScriptSignal" then
		local v_u_3 = nil
		v_u_3 = p1:Connect(function(...)
			-- upvalues: (ref) v_u_3, (copy) p_u_2
			if v_u_3.Connected then
				p_u_2(...)
			end
		end)
		return v_u_3
	end
	local v4 = typeof(p1) == "table"
	assert(v4, "[pretty-fusion-utils] Event-like should be an object")
	local v5 = p1.Connect
	if typeof(v5) == "function" then
		return p1:Connect(p_u_2)
	end
	local v6 = p1.connect
	if typeof(v6) == "function" then
		return p1:connect(p_u_2)
	end
	local v7 = p1.subscribe
	if typeof(v7) == "function" then
		return p1:subscribe(p_u_2)
	end
	error("[pretty-fusion-utils] Event-like has no supported connect method")
end
local function v_u_12(p_u_9) -- name: bindDisconnect
	if typeof(p_u_9) == "function" then
		return p_u_9
	end
	if typeof(p_u_9) == "RBXScriptConnection" then
		return function()
			-- upvalues: (copy) p_u_9
			if p_u_9.Connected then
				p_u_9:Disconnect()
			end
		end
	end
	local v10 = typeof(p_u_9) == "table"
	assert(v10, "[pretty-fusion-utils] Connection-like should be an object")
	local v_u_11 = p_u_9.Disconnect or p_u_9.disconnect
	return function()
		-- upvalues: (copy) v_u_11, (copy) p_u_9
		v_u_11(p_u_9)
	end
end
return function(p13, p14, p15) -- name: useEventListener
	-- upvalues: (copy) v_u_12, (copy) v_u_8
	local v16 = v_u_12(v_u_8(p14, p15))
	table.insert(p13, v16)
	return v16
end