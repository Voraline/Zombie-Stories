local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v_u_3 = v1:WaitForChild("ReliableRedEvent")
local v_u_4 = v1:WaitForChild("UnreliableRedEvent")
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {
	["Reliable"] = {},
	["Call"] = {}
}
return {
	["SendReliableEvent"] = function(p8, p9) -- name: SendReliableEvent
		-- upvalues: (copy) v_u_7
		if not v_u_7.Reliable[p8] then
			v_u_7.Reliable[p8] = {}
		end
		local v10 = v_u_7.Reliable[p8]
		table.insert(v10, p9)
	end,
	["SendUnreliableEvent"] = function(p11, p12) -- name: SendUnreliableEvent
		-- upvalues: (copy) v_u_4
		v_u_4:FireServer(p11, p12)
	end,
	["SetListener"] = function(p13, p14) -- name: SetListener
		-- upvalues: (copy) v_u_5
		v_u_5[p13] = p14
	end,
	["CallAsync"] = function(p15, p16) -- name: CallAsync
		-- upvalues: (copy) v_u_7, (copy) v_u_6
		if not v_u_7.Call[p15] then
			v_u_7.Call[p15] = {}
		end
		local v17 = v_u_7.Call[p15]
		table.insert(v17, p16)
		v_u_6[p16[1]] = coroutine.running()
		return coroutine.yield()
	end,
	["Start"] = function() -- name: Start
		-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_6, (copy) v_u_4, (copy) v_u_2, (copy) v_u_7
		v_u_3.OnClientEvent:Connect(function(p18, p19)
			-- upvalues: (ref) v_u_5, (ref) v_u_6
			if p18 then
				for v20, v21 in p18 do
					local v22 = v_u_5[v20]
					if v22 then
						for _, v23 in v21 do
							v22(v23)
						end
					end
				end
			end
			if p19 then
				for v24, v25 in p19 do
					local v26 = v_u_6[v24]
					if v26 then
						v_u_6[v24] = nil
						coroutine.resume(v26, v25)
					end
				end
			end
		end)
		v_u_4.OnClientEvent:Connect(function(p27, p28)
			-- upvalues: (ref) v_u_5
			local v29 = v_u_5[p27]
			if v29 then
				v29(p28)
			end
		end)
		v_u_2.Heartbeat:Connect(function()
			-- upvalues: (ref) v_u_7, (ref) v_u_3
			if next(v_u_7.Reliable) or next(v_u_7.Call) then
				v_u_3:FireServer(v_u_7.Reliable, v_u_7.Call)
				v_u_7.Reliable = {}
				v_u_7.Call = {}
			end
		end)
	end
}