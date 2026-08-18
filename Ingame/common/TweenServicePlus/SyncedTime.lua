local v_u_1 = game:GetService("RunService")
local v_u_2 = {}
v_u_2.__index = v_u_2
v_u_2.ClassName = "MasterClock"
function v_u_2.new(p3, p4) -- name: new
	-- upvalues: (copy) v_u_2
	local v5 = v_u_2
	local v_u_6 = setmetatable({}, v5)
	v_u_6._remoteEvent = p3 or error("No remoteEvent")
	v_u_6._remoteFunction = p4 or error("No remoteFunction")
	function v_u_6._remoteFunction.OnServerInvoke(_, p7)
		-- upvalues: (copy) v_u_6
		return v_u_6:_handleDelayRequest(p7)
	end
	v_u_6._remoteEvent.OnServerEvent:Connect(function(p8)
		-- upvalues: (copy) v_u_6
		v_u_6._remoteEvent:FireClient(p8, v_u_6:GetTime())
	end)
	task.defer(function()
		-- upvalues: (copy) v_u_6
		while true do
			task.wait(3.5)
			v_u_6:Sync()
		end
	end)
	return v_u_6
end
function v_u_2.IsSynced(_) -- name: IsSynced
	return true
end
function v_u_2.GetTime(_) -- name: GetTime
	return tick()
end
function v_u_2.Sync(p9) -- name: Sync
	local v10 = p9:GetTime()
	p9._remoteEvent:FireAllClients(v10)
end
function v_u_2._handleDelayRequest(p11, p12) -- name: _handleDelayRequest
	return p11:GetTime() - p12
end
local v_u_13 = {}
v_u_13.__index = v_u_13
v_u_13.ClassName = "SlaveClock"
v_u_13._offset = -1
function v_u_13.new(p14, p15) -- name: new
	-- upvalues: (copy) v_u_13
	local v16 = v_u_13
	local v_u_17 = setmetatable({}, v16)
	v_u_17._remoteEvent = p14 or error("No remoteEvent")
	v_u_17._remoteFunction = p15 or error("No remoteFunction")
	v_u_17._remoteEvent.OnClientEvent:Connect(function(p18)
		-- upvalues: (copy) v_u_17
		v_u_17:_handleSyncEvent(p18)
	end)
	v_u_17._remoteEvent:FireServer()
	return v_u_17
end
function v_u_13.GetTime(p19) -- name: GetTime
	if p19:IsSynced() then
		return p19:_getLocalTime() - p19._offset
	end
	warn("[SlaveClock][GetTime] - Slave clock is not yet synced")
	return p19:_getLocalTime()
end
function v_u_13.IsSynced(p20) -- name: IsSynced
	return p20._offset ~= -1
end
function v_u_13._getLocalTime(_) -- name: _getLocalTime
	return tick()
end
function v_u_13._handleSyncEvent(p21, p22) -- name: _handleSyncEvent
	local v23 = p21:_getLocalTime() - p22
	local v24 = p21:_sendDelayRequest((p21:_getLocalTime()))
	local v25 = (v23 - v24) / 2
	local v26 = (v23 + v24) / 2
	p21._offset = v25
	p21._pneWayDelay = v26
end
function v_u_13._sendDelayRequest(p27, p28) -- name: _sendDelayRequest
	return p27._remoteFunction:InvokeServer(p28)
end
return (function() -- name: buildClock
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_13
	local v29 = script:WaitForChild("TimeSyncEvent")
	local v30 = script:WaitForChild("DelayedRequestEvent")
	if v_u_1:IsClient() and v_u_1:IsServer() then
		local v31 = v_u_2.new(v29, v30)
		v29.OnClientEvent:Connect(function() end)
		return v31
	elseif v_u_1:IsClient() then
		return v_u_13.new(v29, v30)
	else
		return v_u_2.new(v29, v30)
	end
end)()