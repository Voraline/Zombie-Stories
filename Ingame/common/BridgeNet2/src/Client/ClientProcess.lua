local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
require("../Types")
require("../Utilities/Output")
local v_u_3 = require("../Utilities/RecycledSpawn")
local v_u_4 = {}
local v_u_5 = 0
local v_u_6 = {}
local v_u_7 = {}
return {
	["start"] = function() -- name: start
		-- upvalues: (copy) v_u_1, (copy) v_u_6, (copy) v_u_2, (ref) v_u_5, (copy) v_u_4, (copy) v_u_7, (copy) v_u_3
		debug.setmemorycategory("BridgeNet2")
		local v_u_8 = v_u_1:WaitForChild("dataRemoteEvent")
		local v_u_9 = v_u_1:WaitForChild("metaRemoteEvent")
		v_u_8.OnClientEvent:Connect(function(p10)
			-- upvalues: (ref) v_u_6
			local v11 = v_u_6
			table.insert(v11, p10)
		end)
		v_u_2.PostSimulation:Connect(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_8, (ref) v_u_4, (ref) v_u_6, (ref) v_u_7, (ref) v_u_3
			debug.profilebegin("BridgeNet2")
			if v_u_5 > 0 then
				local v12 = v_u_8
				local v13 = {}
				local v14 = v_u_4
				local v15 = v_u_5
				__set_list(v13, 1, {table.unpack(v14, 1, v15)})
				v12:FireServer(v13)
				v_u_5 = 0
				table.clear(v_u_4)
			end
			debug.profilebegin("BridgeNet2:Receive")
			for _, v16 in v_u_6 do
				for v17, v18 in v16 do
					local v19 = v_u_7[v17]
					if v19 then
						if #v19 == 1 then
							local v20 = v19[1]
							for _, v21 in v18 do
								v_u_3(v20, v21)
							end
						else
							for _, v22 in v18 do
								for _, v23 in v19 do
									v_u_3(v23, v22)
								end
							end
						end
					end
				end
			end
			table.clear(v_u_6)
			debug.profileend()
		end)
		task.spawn(function()
			-- upvalues: (copy) v_u_9
			for _ = 1, 15 do
				task.wait()
			end
			v_u_9:FireServer("1")
		end)
	end,
	["registerBridge"] = function(p24) -- name: registerBridge
		-- upvalues: (copy) v_u_7
		v_u_7[p24] = {}
	end,
	["addToQueue"] = function(p25, p26) -- name: addToQueue
		-- upvalues: (copy) v_u_4, (ref) v_u_5
		v_u_4[v_u_5 + 1] = p26
		v_u_4[v_u_5 + 2] = p25
		v_u_5 = v_u_5 + 2
	end,
	["connect"] = function(p_u_27, p_u_28) -- name: connect
		-- upvalues: (copy) v_u_7
		local v29 = v_u_7[p_u_27]
		table.insert(v29, p_u_28)
		return function()
			-- upvalues: (ref) v_u_7, (copy) p_u_27, (copy) p_u_28
			local v30 = table.find(v_u_7[p_u_27], p_u_28)
			table.remove(v_u_7[p_u_27], v30)
		end
	end
}