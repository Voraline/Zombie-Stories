local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = require("./HandleInvalidPlayer")
require("../Utilities/Output")
local v_u_5 = require("../../TableKit")
require("../Types")
local v_u_6 = require("../Utilities/RecycledSpawn")
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = {}
local v_u_12 = {}
local function v_u_14(p13) -- name: playerAdded
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_11
	v_u_7[p13] = true
	v_u_8[p13] = 0
	v_u_9[p13] = {}
	v_u_11[p13] = {}
end
return {
	["start"] = function() -- name: start
		-- upvalues: (copy) v_u_2, (copy) v_u_1, (copy) v_u_14, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_11, (ref) v_u_4, (copy) v_u_3, (copy) v_u_10, (copy) v_u_5, (copy) v_u_12, (copy) v_u_6
		task.spawn(function()
			-- upvalues: (ref) v_u_2, (ref) v_u_1, (ref) v_u_14, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_11, (ref) v_u_4, (ref) v_u_3, (ref) v_u_10, (ref) v_u_5, (ref) v_u_12, (ref) v_u_6
			debug.setmemorycategory("BridgeNet2")
			local v15 = Instance.new("RemoteEvent")
			local v_u_16 = Instance.new("RemoteEvent")
			v15.Name = "metaRemoteEvent"
			v_u_16.Name = "dataRemoteEvent"
			v15.Parent = v_u_2
			v_u_16.Parent = v_u_2
			v_u_1.PlayerAdded:Connect(v_u_14)
			v_u_1.PlayerRemoving:Connect(function(p17)
				-- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_11
				v_u_7[p17] = nil
				v_u_8[p17] = nil
				v_u_9[p17] = nil
				v_u_11[p17] = nil
			end)
			v15.OnServerEvent:Connect(function(p18, p19)
				-- upvalues: (ref) v_u_8, (copy) v_u_16, (ref) v_u_9
				if p19 == "1" then
					v_u_8[p18] = nil
					v_u_16:FireClient(p18, v_u_9[p18])
					v_u_9[p18] = nil
				end
			end)
			v_u_16.OnServerEvent:Connect(function(p20, p21)
				-- upvalues: (ref) v_u_4, (ref) v_u_11
				if typeof(p21) == "table" then
					local v22 = v_u_11[p20]
					table.insert(v22, p21)
				else
					v_u_4(p20)
				end
			end)
			local v_u_23 = {}
			local function v_u_29(p24, p25, p26) -- name: addContentToQueue
				-- upvalues: (copy) v_u_23
				local v27 = v_u_23[p24]
				if v27 then
					if v27[p25] then
						local v28 = v27[p25]
						table.insert(v28, p26)
					else
						v27[p25] = { p26 }
					end
				else
					v_u_23[p24] = {
						[p25] = { p26 }
					}
					return
				end
			end
			v_u_3.PostSimulation:Connect(function()
				-- upvalues: (ref) v_u_10, (copy) v_u_29, (ref) v_u_7, (copy) v_u_23, (ref) v_u_8, (ref) v_u_9, (ref) v_u_5, (copy) v_u_16, (ref) v_u_11, (ref) v_u_4, (ref) v_u_12, (ref) v_u_6
				debug.profilebegin("BridgeNet2")
				debug.profilebegin("BridgeNet2:Send")
				for _, v30 in v_u_10 do
					local v31 = v30.playerContainer.kind
					local v32 = v30.playerContainer.value
					local v33 = v30.id
					local v34 = v30.content
					if v31 == "single" then
						v_u_29(v32, v33, v34)
					elseif v31 == "all" then
						for v35 in v_u_7 do
							v_u_29(v35, v33, v34)
						end
					elseif v31 == "except" then
						for _, v36 in v32 do
							v_u_7[v36] = false
						end
						for v37, v38 in v_u_7 do
							if v38 then
								v_u_29(v37, v33, v34)
							else
								v_u_7[v37] = true
							end
						end
					elseif v31 == "set" then
						for _, v39 in v32 do
							v_u_29(v39, v33, v34)
						end
					end
				end
				for v40, v41 in v_u_23 do
					if v_u_8[v40] then
						if v_u_9[v40] then
							for v42, v43 in v41 do
								if v_u_9[v40][v42] then
									v_u_9[v40][v42] = v_u_5.MergeArrays(v_u_9[v40][v42], v43)
								else
									v_u_9[v40][v42] = v43
								end
							end
						else
							v_u_9[v40] = v41
						end
					else
						v_u_16:FireClient(v40, v41)
					end
					v_u_23[v40] = nil
				end
				table.clear(v_u_10)
				debug.profileend()
				debug.profilebegin("BridgeNet2:Receive")
				for v44, v45 in v_u_11 do
					for _, v46 in v45 do
						for v47 = 1, #v46, 2 do
							local v48 = v46[v47]
							local v49 = v46[v47 + 1]
							if typeof(v49) ~= "string" then
								v_u_4(v44)
								break
							end
							local v50 = v_u_12[v49]
							if v50 then
								for _, v51 in v50 do
									v_u_6(v51, v44, v48)
								end
							end
						end
					end
					table.clear(v_u_11[v44])
				end
				debug.profileend()
				debug.profileend()
			end)
		end)
	end,
	["addToQueue"] = function(p52, p53, p54) -- name: addToQueue
		-- upvalues: (copy) v_u_10
		local v55 = v_u_10
		table.insert(v55, {
			["playerContainer"] = p52,
			["id"] = p53,
			["content"] = p54
		})
	end,
	["setInvalidPlayerFunction"] = function(p56) -- name: setInvalidPlayerFunction
		-- upvalues: (ref) v_u_4
		v_u_4 = p56
	end,
	["registerBridge"] = function(p57) -- name: registerBridge
		-- upvalues: (copy) v_u_12
		if not v_u_12[p57] then
			v_u_12[p57] = {}
		end
	end,
	["connect"] = function(p_u_58, p_u_59) -- name: connect
		-- upvalues: (copy) v_u_12
		local v60 = v_u_12[p_u_58]
		table.insert(v60, p_u_59)
		return function()
			-- upvalues: (ref) v_u_12, (copy) p_u_58, (copy) p_u_59
			local v61 = table.find(v_u_12[p_u_58], p_u_59)
			table.remove(v_u_12[p_u_58], v61)
		end
	end
}