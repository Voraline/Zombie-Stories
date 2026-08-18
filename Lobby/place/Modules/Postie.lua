local v_u_1 = game:GetService("HttpService")
local v2 = game:GetService("RunService")
game:GetService("ReplicatedStorage")
if not script:FindFirstChild("Sent") then
	local v3 = Instance.new("RemoteEvent")
	v3.Name = "Sent"
	v3.Parent = script
end
if not script:FindFirstChild("Received") then
	local v4 = Instance.new("RemoteEvent")
	v4.Name = "Received"
	v4.Parent = script
end
local v_u_5 = script.Sent
local v_u_6 = script.Received
local v_u_7 = v2:IsServer()
local v_u_8 = {}
local v_u_9 = {}
local function v_u_16(p_u_10, ...) -- name: spawnNow
	local v11 = Instance.new("BindableEvent")
	local v_u_12 = table.pack(...)
	v11.Event:Connect(function()
		-- upvalues: (copy) p_u_10, (copy) v_u_12
		local v13 = p_u_10
		local v14 = v_u_12
		local v15 = v_u_12.n
		v13(table.unpack(v14, 1, v15))
	end)
	v11:Fire()
	v11:Destroy()
end
local v45 = {
	["InvokeClient"] = function(p17, p_u_18, p_u_19, ...) -- name: InvokeClient
		-- upvalues: (copy) v_u_7, (copy) v_u_9, (copy) v_u_1, (copy) v_u_16, (copy) v_u_5
		local v20 = v_u_7
		assert(v20, "Postie.InvokeClient can only be called from the server")
		local v21 = typeof(p17) == "string"
		assert(v21, "bad argument #1 to Postie.InvokeClient, expects string")
		local v22
		if typeof(p_u_18) == "Instance" then
			v22 = p_u_18:IsA("Player")
		else
			v22 = false
		end
		assert(v22, "bad argument #2 to Postie.InvokeClient, expects Instance<Player>")
		local v23 = typeof(p_u_19) == "number"
		assert(v23, "bad argument #3 to Postie.InvokeClient, expects number")
		local v_u_24 = Instance.new("BindableEvent")
		local v_u_25 = false
		local v_u_26 = #v_u_9 + 1
		local v_u_27 = v_u_1:GenerateGUID(false)
		v_u_9[v_u_26] = function(p28, p29, ...)
			-- upvalues: (copy) p_u_18, (copy) v_u_27, (ref) v_u_25, (ref) v_u_9, (copy) v_u_26, (copy) v_u_24
			if p28 ~= p_u_18 or p29 ~= v_u_27 then
				return false
			end
			v_u_25 = true
			table.remove(v_u_9, v_u_26)
			v_u_24:Fire(true, ...)
			return true
		end
		v_u_16(function()
			-- upvalues: (copy) p_u_19, (ref) v_u_25, (ref) v_u_9, (copy) v_u_26, (copy) v_u_24
			task.wait(p_u_19)
			if not v_u_25 then
				table.remove(v_u_9, v_u_26)
				v_u_24:Fire(false)
			end
		end)
		v_u_5:FireClient(p_u_18, p17, v_u_27, ...)
		return v_u_24.Event:Wait()
	end,
	["InvokeServer"] = function(p30, p_u_31, ...) -- name: InvokeServer
		-- upvalues: (copy) v_u_7, (copy) v_u_9, (copy) v_u_1, (copy) v_u_16, (copy) v_u_5
		local v32 = not v_u_7
		assert(v32, "Postie.InvokeServer can only be called from the client")
		local v33 = typeof(p30) == "string"
		assert(v33, "bad argument #1 to Postie.InvokeServer, expects string")
		local v34 = typeof(p_u_31) == "number"
		assert(v34, "bad argument #2 to Postie.InvokeServer, expects number")
		local v_u_35 = Instance.new("BindableEvent")
		local v_u_36 = false
		local v_u_37 = #v_u_9 + 1
		local v_u_38 = v_u_1:GenerateGUID(false)
		v_u_9[v_u_37] = function(p39, ...)
			-- upvalues: (copy) v_u_38, (ref) v_u_36, (ref) v_u_9, (copy) v_u_37, (copy) v_u_35
			if p39 ~= v_u_38 then
				return false
			end
			v_u_36 = true
			table.remove(v_u_9, v_u_37)
			v_u_35:Fire(true, ...)
			return true
		end
		v_u_16(function()
			-- upvalues: (copy) p_u_31, (ref) v_u_36, (ref) v_u_9, (copy) v_u_37, (copy) v_u_35
			task.wait(p_u_31)
			if not v_u_36 then
				table.remove(v_u_9, v_u_37)
				v_u_35:Fire(false)
			end
		end)
		v_u_5:FireServer(p30, v_u_38, ...)
		return v_u_35.Event:Wait()
	end,
	["SetCallback"] = function(p40, p41) -- name: SetCallback
		-- upvalues: (copy) v_u_8
		local v42 = typeof(p40) == "string"
		assert(v42, "bad argument #1 to Postie.SetCallback, expects string")
		v_u_8[p40] = p41
	end,
	["GetCallback"] = function(p43) -- name: GetCallback
		-- upvalues: (copy) v_u_8
		local v44 = typeof(p43) == "string"
		assert(v44, "bad argument #1 to Postie.GetCallback, expects string")
		return v_u_8[p43]
	end
}
if v_u_7 then
	v_u_6.OnServerEvent:Connect(function(...)
		-- upvalues: (copy) v_u_9
		for _, v46 in ipairs(v_u_9) do
			if v46(...) then
				return
			end
		end
	end)
	v_u_5.OnServerEvent:Connect(function(p47, p48, p49, ...)
		-- upvalues: (copy) v_u_8, (copy) v_u_6
		local v50 = v_u_8[p48]
		local v51 = v_u_6
		if v50 then
			v50 = v50(p47, ...)
		end
		v51:FireClient(p47, p49, v50)
	end)
	return v45
else
	v_u_6.OnClientEvent:Connect(function(...)
		-- upvalues: (copy) v_u_9
		for _, v52 in ipairs(v_u_9) do
			if v52(...) then
				return
			end
		end
	end)
	v_u_5.OnClientEvent:Connect(function(p53, p54, ...)
		-- upvalues: (copy) v_u_8, (copy) v_u_6
		local v55 = v_u_8[p53]
		local v56 = v_u_6
		if v55 then
			v55 = v55(...)
		end
		v56:FireServer(p54, v55)
	end)
	return v45
end