local v1 = game:GetService("RunService")
local v_u_2 = require("./EggData")
local v3 = game:GetService("ReplicatedStorage").common.RedEvents
local v_u_4 = game:GetService("Players")
local v_u_5 = script.Eggs
local v_u_6 = require(v3.Events.SpawnEgg)
local v_u_7 = require(v3.Events.EggCollected)
local v_u_9 = {
	["ChooseRandomPosition"] = function(_, p8) -- name: ChooseRandomPosition
		if p8 and #p8 ~= 0 then
			return p8[math.random(1, #p8)]
		else
			return nil
		end
	end
}
if v1:IsServer() then
	local v_u_10 = require("./EasterEventController")
	function v_u_9.SpawnEggServer(_, p11) -- name: SpawnEggServer
		-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_10, (copy) v_u_6
		local v12 = v_u_2.EggConfigs[p11]
		if v12 then
			local v13 = {}
			local v14 = game.ServerScriptService.common.Data.Bindables.GetData
			if _G.Difficulty == "Hard" then
				for _, v15 in game.Players:GetPlayers() do
					local v16 = v14:Invoke(v15)
					local v17 = 0
					for v18, _ in v_u_2.EggConfigs do
						if v16.Stats.UniqueAwards.Easter2025[v18] and v16.Stats.UniqueAwards.Easter2025[v18] > 0 then
							v17 = v17 + 1
						end
					end
					if v17 >= 4 then
						table.insert(v13, v15)
					end
				end
			end
			local v19 = v_u_9:ChooseRandomPosition(v12.SpawnPositions)
			v_u_6:FireClients(v_u_10:GetEligiblePlayers(p11), p11, v19)
			v_u_6:FireClients(v13, "Master", v19)
			return v19
		end
		warn("No egg config found for chapter: " .. p11)
	end
end
if v1:IsClient() then
	local v_u_20 = game:GetService("RunService")
	local v_u_21 = v_u_4.LocalPlayer
	require("./EasterEventClient")
	function v_u_9.SpawnEggLocal(_, p_u_22, p23) -- name: SpawnEggLocal
		-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_20, (copy) v_u_4, (copy) v_u_21, (copy) v_u_7
		if v_u_2.EggConfigs[p_u_22] then
			local v_u_24 = v_u_5:FindFirstChild(p_u_22):Clone()
			v_u_24.Name = "EasterEgg_" .. p_u_22
			v_u_24.PrimaryPart.Anchored = true
			v_u_24.PrimaryPart.CanCollide = false
			v_u_24:SetPrimaryPartCFrame((CFrame.new(p23)))
			v_u_24.Parent = workspace
			local v_u_25 = Instance.new("Sound")
			v_u_25.SoundId = "rbxassetid://9116393424"
			v_u_25.Volume = 2
			v_u_25.Looped = true
			v_u_25.Parent = v_u_24.PrimaryPart
			v_u_25.RollOffMaxDistance = 50
			v_u_25.RollOffMinDistance = 5
			v_u_25.RollOffMode = Enum.RollOffMode.Linear
			v_u_25:Play()
			local v_u_26 = v_u_24:GetPrimaryPartCFrame()
			local v_u_27 = 0
			local v_u_28 = nil
			v_u_28 = v_u_20.Heartbeat:Connect(function(p29)
				-- upvalues: (ref) v_u_27, (copy) v_u_24, (copy) v_u_26, (ref) v_u_28
				v_u_27 = v_u_27 + p29
				if v_u_24 and v_u_24.Parent then
					local v30 = v_u_27 * 1.5
					local v31 = (math.sin(v30) + 1) * 0.5 * 2
					v_u_24:SetPrimaryPartCFrame(v_u_26 * CFrame.new(0, v31, 0))
				elseif v_u_28 then
					v_u_28:Disconnect()
				end
			end)
			local v_u_32 = false
			v_u_24.PrimaryPart.Touched:Connect(function(p33)
				-- upvalues: (ref) v_u_32, (ref) v_u_4, (ref) v_u_21, (copy) v_u_25, (copy) v_u_24, (ref) v_u_28, (ref) v_u_7, (copy) p_u_22
				if not v_u_32 then
					local v34 = v_u_4:GetPlayerFromCharacter(p33.Parent)
					if v34 and v34 == v_u_21 then
						v_u_25:Destroy()
						v_u_32 = true
						for _, v35 in v_u_24:GetChildren() do
							v35.Transparency = 1
						end
						if v_u_28 then
							v_u_28:Disconnect()
						end
						v_u_7:FireServer(p_u_22)
						task.delay(1, function()
							-- upvalues: (ref) v_u_24
							if v_u_24 then
								v_u_24:Destroy()
							end
						end)
					end
				end
			end)
		else
			warn("No egg config found for chapter: " .. p_u_22)
		end
	end
	v_u_6:SetClientListener(function(p36, p37)
		-- upvalues: (copy) v_u_9
		v_u_9:SpawnEggLocal(p36, p37)
	end)
end
return v_u_9