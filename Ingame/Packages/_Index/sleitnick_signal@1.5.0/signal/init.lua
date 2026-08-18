local v_u_1 = nil
local function v_u_4(p2, ...) -- name: acquireRunnerThreadAndCallEventHandler
	-- upvalues: (ref) v_u_1
	local v3 = v_u_1
	v_u_1 = nil
	p2(...)
	v_u_1 = v3
end
local function v_u_5(...) -- name: runEventHandlerInFreeThread
	-- upvalues: (copy) v_u_4
	v_u_4(...)
	while true do
		v_u_4(coroutine.yield())
	end
end
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p7, p8) -- name: new
	-- upvalues: (copy) v_u_6
	local v9 = v_u_6
	return setmetatable({
		["Connected"] = true,
		["_signal"] = nil,
		["_fn"] = nil,
		["_next"] = false,
		["_signal"] = p7,
		["_fn"] = p8
	}, v9)
end
function v_u_6.Disconnect(p10) -- name: Disconnect
	if p10.Connected then
		p10.Connected = false
		if p10._signal._handlerListHead == p10 then
			p10._signal._handlerListHead = p10._next
		else
			local v11 = p10._signal._handlerListHead
			while v11 and v11._next ~= p10 do
				v11 = v11._next
			end
			if v11 then
				v11._next = p10._next
			end
		end
	else
		return
	end
end
v_u_6.Destroy = v_u_6.Disconnect
setmetatable(v_u_6, {
	["__index"] = function(_, p12) -- name: __index
		error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p12))), 2)
	end,
	["__newindex"] = function(_, p13, _) -- name: __newindex
		error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p13))), 2)
	end
})
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new() -- name: new
	-- upvalues: (copy) v_u_14
	local v15 = v_u_14
	return setmetatable({
		["_handlerListHead"] = false,
		["_proxyHandler"] = nil
	}, v15)
end
function v_u_14.Wrap(p16) -- name: Wrap
	-- upvalues: (copy) v_u_14
	local v17 = typeof(p16) == "RBXScriptSignal"
	local v18 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p16)
	assert(v17, v18)
	local v_u_19 = v_u_14.new()
	v_u_19._proxyHandler = p16:Connect(function(...)
		-- upvalues: (copy) v_u_19
		v_u_19:Fire(...)
	end)
	return v_u_19
end
function v_u_14.Is(p20) -- name: Is
	-- upvalues: (copy) v_u_14
	local v21
	if type(p20) == "table" then
		v21 = getmetatable(p20) == v_u_14
	else
		v21 = false
	end
	return v21
end
function v_u_14.Connect(p22, p23) -- name: Connect
	-- upvalues: (copy) v_u_6
	local v24 = v_u_6.new(p22, p23)
	if not p22._handlerListHead then
		p22._handlerListHead = v24
		return v24
	end
	v24._next = p22._handlerListHead
	p22._handlerListHead = v24
	return v24
end
function v_u_14.ConnectOnce(p25, p26) -- name: ConnectOnce
	return p25:Once(p26)
end
function v_u_14.Once(p27, p_u_28) -- name: Once
	local v_u_29 = nil
	local v_u_30 = false
	v_u_29 = p27:Connect(function(...)
		-- upvalues: (ref) v_u_30, (ref) v_u_29, (copy) p_u_28
		if not v_u_30 then
			v_u_30 = true
			v_u_29:Disconnect()
			p_u_28(...)
		end
	end)
	return v_u_29
end
function v_u_14.GetConnections(p31) -- name: GetConnections
	local v32 = p31._handlerListHead
	local v33 = {}
	while v32 do
		table.insert(v33, v32)
		v32 = v32._next
	end
	return v33
end
function v_u_14.DisconnectAll(p34) -- name: DisconnectAll
	local v35 = p34._handlerListHead
	while v35 do
		v35.Connected = false
		v35 = v35._next
	end
	p34._handlerListHead = false
end
function v_u_14.Fire(p36, ...) -- name: Fire
	-- upvalues: (ref) v_u_1, (copy) v_u_5
	local v37 = p36._handlerListHead
	while v37 do
		if v37.Connected then
			if not v_u_1 then
				v_u_1 = coroutine.create(v_u_5)
			end
			task.spawn(v_u_1, v37._fn, ...)
		end
		v37 = v37._next
	end
end
function v_u_14.FireDeferred(p38, ...) -- name: FireDeferred
	local v39 = p38._handlerListHead
	while v39 do
		task.defer(v39._fn, ...)
		v39 = v39._next
	end
end
function v_u_14.Wait(p40) -- name: Wait
	local v_u_41 = coroutine.running()
	local v_u_42 = nil
	local v_u_43 = false
	v_u_42 = p40:Connect(function(...)
		-- upvalues: (ref) v_u_43, (ref) v_u_42, (copy) v_u_41
		if not v_u_43 then
			v_u_43 = true
			v_u_42:Disconnect()
			task.spawn(v_u_41, ...)
		end
	end)
	return coroutine.yield()
end
function v_u_14.Destroy(p44) -- name: Destroy
	p44:DisconnectAll()
	local v45 = rawget(p44, "_proxyHandler")
	if v45 then
		v45:Disconnect()
	end
end
setmetatable(v_u_14, {
	["__index"] = function(_, p46) -- name: __index
		error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p46))), 2)
	end,
	["__newindex"] = function(_, p47, _) -- name: __newindex
		error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p47))), 2)
	end
})
return {
	["new"] = v_u_14.new,
	["Wrap"] = v_u_14.Wrap,
	["Is"] = v_u_14.Is
}