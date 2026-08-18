if workspace:WaitForChild("Values"):WaitForChild("IsLobby").Value then
	return nil
end
local v_u_1 = game:GetService("RunService"):IsServer()
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game.ReplicatedStorage.common
local v5 = game.ReplicatedStorage.common.RedEvents
local v_u_6 = require(v_u_4.ProximityPromptZS)
local v_u_7 = require("@game/ReplicatedStorage/common/PlayerHandler")
local v_u_8 = require("@game/ReplicatedStorage/common/Objective")
local v_u_9 = require("@game/ReplicatedStorage/common/Table")
local v_u_10 = require(v3.common.ZS_Shared.Data.GameState)
local v_u_11
if v_u_1 then
	v_u_11 = require(v3.common.skillTree.SkillTreeData)
else
	v_u_11 = nil
end
local v_u_12 = require(v5.Framework.DoReviveEvent)
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = {}
local v_u_17 = {}
local v_u_18 = nil
local function v_u_22() -- name: updateDownedMarkers
	-- upvalues: (copy) v_u_9, (copy) v_u_17, (ref) v_u_18, (copy) v_u_8
	if #v_u_9.keys(v_u_17) > 0 then
		if not v_u_18 then
			v_u_18 = v_u_8.new({
				["Type"] = "interact",
				["Text"] = "Revive teammates",
				["ImageID"] = "rbxassetid://2706886795",
				["AccentColor"] = nil,
				["IsPrimary"] = false,
				["ProgressFormat"] = "",
				["AccentColor"] = Color3.fromRGB(255, 73, 73)
			})
		end
		local v19 = {}
		for v20 in v_u_17 do
			if v20.Parent and (v20.Character and v20.Character.PrimaryPart) then
				local v21 = v20.Character.PrimaryPart
				table.insert(v19, v21)
			end
		end
		v_u_18.MarkerParts = v19
	elseif v_u_18 then
		v_u_18:Destroy()
		v_u_18 = nil
	end
end
if v_u_1 then
	local v23 = game:GetService("ServerStorage"):FindFirstChild("common")
	if v23 then
		v23 = game:GetService("ServerStorage").common:FindFirstChild("ProgressionTracker")
	end
	if v23 then
		v_u_13 = require(v23)
	end
	local v24 = game.ServerScriptService.common:FindFirstChild("Data")
	if v24 then
		local v25 = v24:FindFirstChild("Bindables")
		if v25 then
			v25 = v25:FindFirstChild("BoughtToken")
		end
		if v25 then
			v25.Event:Connect(function(p26, p27)
				-- upvalues: (copy) v_u_16
				if p27 and v_u_16[p26] then
					v_u_16[p26][p26].Triggered:Fire(p26)
				end
			end)
		end
	end
else
	v_u_12:SetClientListener(function(p28)
		-- upvalues: (copy) v_u_6, (ref) v_u_15, (ref) v_u_14, (copy) v_u_17, (copy) v_u_22
		local v29 = p28[1]
		if v29 == "ChangeSelfPrompt" then
			local v30 = p28[2]
			local v31 = p28[3]
			local v32 = tonumber(v31)
			local v33 = p28[4]
			if not v_u_6:GetPromptByIdentifier(v30) then
				while not v_u_6:GetPromptByIdentifier(v30) do
					task.wait()
				end
			end
			local v34 = v_u_6:GetPromptByIdentifier(v30)
			if v33 then
				if not v_u_15 then
					v_u_15 = v32 - 1
				end
				if v_u_15 == 0 then
					v34.ObjectText = "Self Revive"
				else
					v34.ObjectText = "(+1 AED) " .. v32 .. "/" .. v_u_15 .. " Tokens"
				end
				v34.ActionText = "Use AED+"
			elseif v32 > 0 then
				if not v_u_15 then
					v_u_15 = v32
				end
				v34.ActionText = "Use Revive Token"
				v34.ObjectText = v32 .. "/" .. v_u_15 .. " Left"
			else
				v34.ActionText = "Buy Revive Token"
				v34.ObjectText = "35 R$"
			end
			v34.HoldTime = 0.25
			v34.ResetOnRelease = false
			return
		elseif v29 == "BeingRevived" then
			local v35 = p28[2]
			local v36 = tonumber(v35)
			local v37 = p28[3]
			v_u_14._PlayersReviving[v37] = v36
			return
		elseif v29 == "StoppedReviving" then
			local v38 = p28[2]
			v_u_14._PlayersReviving[v38] = nil
		elseif v29 == "NotDowned" then
			v_u_17[p28[2]] = nil
			v_u_22()
		end
	end)
end
local v_u_39 = {}
v_u_39.__index = v_u_39
function v_u_39.new(p40) -- name: new
	-- upvalues: (copy) v_u_39, (copy) v_u_1, (ref) v_u_14, (copy) v_u_4
	local v41 = v_u_39
	local v_u_42 = setmetatable({}, v41)
	if not v_u_1 and p40.Player == game.Players.LocalPlayer then
		v_u_14 = v_u_42
	end
	v_u_42._PlayerState = require(v_u_4.PlayerHandler):WaitForPlayerState(p40.Player)
	v_u_42._PlayersReviving = {}
	v_u_42._Player = p40.Player
	v_u_42._UsedAED = false
	v_u_42._HasAED = false
	v_u_42.JoinConnection = nil
	if v_u_1 then
		task.defer(function()
			-- upvalues: (copy) v_u_42
			local v_u_43 = false
			local _, _ = pcall(function()
				-- upvalues: (ref) v_u_42, (ref) v_u_43
				local v44 = game:GetService("MarketplaceService"):UserOwnsGamePassAsync(v_u_42._Player.UserId, 10504574) or game:GetService("MarketplaceService"):UserOwnsGamePassAsync(v_u_42._Player.UserId, 6934680)
				if v44 then
					v_u_43 = v44
				end
			end)
			v_u_42._HasAED = v_u_43
		end)
	end
	v_u_42.ReviveProgress = 0
	v_u_42.Inactive = true
	return v_u_42
end
function v_u_39.Serialize(p45) -- name: Serialize
	return { p45.Duration }
end
function v_u_39.CopyStatus(p46, p47, p48) -- name: CopyStatus
	p46._UsedAED = p47._UsedAED
	p46._HasAED = p47._HasAED
	p46._RevivesLeft = p47._RevivesLeft
	p46.Duration = p47.Duration
	p46.ReviveProgress = p47.ReviveProgress
	p46.Inactive = p47.Inactive
	if not p46.Inactive then
		p46:Apply(p48, p46.Duration)
	end
end
function v_u_39.DeletePrompts(p49) -- name: DeletePrompts
	-- upvalues: (copy) v_u_16
	if p49._RevivePrompts then
		for _, v50 in p49._RevivePrompts do
			v50:Destroy()
		end
		v_u_16[p49._Player] = nil
		p49._RevivePrompts = nil
	end
	table.clear(p49._PlayersReviving)
end
function v_u_39.InitalizeRevives(p51) -- name: InitalizeRevives
	-- upvalues: (copy) v_u_1, (copy) v_u_10, (ref) v_u_11
	if v_u_1 then
		p51._RevivesLeft = (v_u_10.Data.Variables.PlayerDowns or 3) + (v_u_11 and (v_u_11.getExtraDowns(p51._Player) or 0) or 0)
	end
end
function v_u_39.Apply(p_u_52, p53, p54) -- name: Apply
	-- upvalues: (copy) v_u_1, (ref) v_u_13, (copy) v_u_7, (copy) v_u_12, (copy) v_u_6, (copy) v_u_2, (copy) v_u_16, (copy) v_u_17, (copy) v_u_22
	p_u_52.Duration = p54 or 30
	p_u_52.Inactive = false
	p_u_52._MaxReviveTime = 5
	if v_u_1 and not p_u_52._RevivesLeft then
		p_u_52:InitalizeRevives()
	end
	p_u_52:DeletePrompts()
	local v_u_55 = p53.Player
	local v56
	if v_u_55.Character and v_u_55.Character.Parent then
		v56 = v_u_55.Character.PrimaryPart ~= nil
	else
		v56 = false
	end
	if v56 then
		if v_u_1 then
			local v_u_57 = v_u_55.Character.PrimaryPart
			if v_u_57 then
				if v_u_13 then
					v_u_13:AddToLeaderStat(v_u_55, "Downs", 1)
				end
				table.clear(p_u_52._PlayersReviving)
				local function v_u_62(p58) -- name: onInteractBegan
					-- upvalues: (ref) v_u_7, (copy) v_u_55, (copy) p_u_52, (ref) v_u_13, (ref) v_u_12
					local v59 = v_u_7:GetPlayerState(p58)
					if v59 and (not v59.IsDowned and (not v59.IsDead and (p58 ~= v_u_55 and not p_u_52._PlayersReviving[p58]))) then
						local v60 = v_u_13
						if v60 then
							v60 = v_u_13:GetClass(p58)
						end
						local v61 = (v60 == "Medic" and 2.5 or 5) - 0.33
						p_u_52._PlayersReviving[p58] = v61
						v_u_12:FireClient(v_u_55, { "BeingRevived", tostring(v61), p58 })
					end
				end
				local function v_u_65(p63) -- name: onInteractEnded
					-- upvalues: (ref) v_u_7, (copy) v_u_55, (copy) p_u_52, (ref) v_u_12
					local v64 = v_u_7:GetPlayerState(p63)
					if v64 and (not v64.IsDowned and (not v64.IsDead and (p63 ~= v_u_55 and p_u_52._PlayersReviving[p63]))) then
						p_u_52._PlayersReviving[p63] = nil
						v_u_12:FireClient(v_u_55, { "StoppedReviving", p63 })
					end
				end
				local function v_u_75(p66) -- name: onTriggered
					-- upvalues: (copy) v_u_55, (copy) p_u_52, (ref) v_u_12, (copy) v_u_57
					if p66 == v_u_55 then
						local v67 = p_u_52._HasAED
						if v67 then
							v67 = not p_u_52._UsedAED
						end
						local v68, v69 = game.ServerScriptService.common.Data.Bindables.GetData:Invoke(p66)
						if not v69 or v67 then
							if v67 or v68.SelfRevives and v68.SelfRevives > 0 then
								p_u_52._PlayersReviving[p66] = 5
								v_u_12:FireClient(v_u_55, { "BeingRevived", tostring(5), p66 })
								p_u_52._RevivePrompts[p66].Enabled = false
								local v70 = p_u_52
								v70._RevivesLeft = v70._RevivesLeft + 1
								if v67 then
									p_u_52._UsedAED = true
								else
									require("@game/ServerStorage/common/DataStore2")(game.ServerScriptService.common.Data.MAIN_DATASTORE_NAME.Value, v_u_55):Update(function(p71)
										if not p71.SelfRevives then
											p71.SelfRevives = 0
										end
										p71.SelfRevives = p71.SelfRevives - 1
										return p71
									end)
								end
								local v_u_72 = Instance.new("Sound")
								v_u_72.SoundId = "rbxassetid://9057348814"
								v_u_72.Volume = 1
								local v_u_73 = Instance.new("Sound")
								v_u_73.SoundId = "rbxassetid://9057349072"
								v_u_73.Volume = 2
								v_u_72.Parent = v_u_57
								v_u_73.Parent = v_u_57
								v_u_72:Play()
								v_u_73:Play()
								task.delay(5, function()
									-- upvalues: (ref) v_u_57, (copy) v_u_72, (copy) v_u_73
									if v_u_57.Parent then
										v_u_72:Destroy()
										v_u_73:Destroy()
										local v74 = Instance.new("Sound")
										v74.SoundId = "rbxassetid://4879269872"
										v74.Volume = 1
										v74.Parent = v_u_57
										v74:Play()
										task.wait(10)
										v74:Destroy()
									end
								end)
								return
							end
							game:GetService("MarketplaceService"):PromptProductPurchase(p66, 972288148)
						end
					end
				end
				p_u_52._RevivePrompts = {}
				local function v79(p76) -- name: createPrompt
					-- upvalues: (ref) v_u_13, (ref) v_u_6, (copy) v_u_55, (copy) v_u_57, (copy) p_u_52, (copy) v_u_62, (copy) v_u_65, (copy) v_u_75
					local v77 = v_u_13
					if v77 then
						v77 = v_u_13:GetClass(p76)
					end
					local v78 = v_u_6.new({
						["ActionText"] = "REVIVE",
						["ObjectText"] = nil,
						["Part"] = nil,
						["Range"] = 6,
						["Obstructable"] = false,
						["HoldTime"] = nil,
						["ResetOnRelease"] = true,
						["Players"] = nil,
						["ObjectText"] = v_u_55.Name,
						["Part"] = v_u_57,
						["HoldTime"] = v77 == "Medic" and 2.5 or 5,
						["Players"] = { p76 }
					})
					p_u_52._RevivePrompts[p76] = v78
					v78.InteractBegan:Connect(v_u_62)
					v78.InteractEnded:Connect(v_u_65)
					v78.Triggered:Connect(v_u_75)
				end
				for _, v80 in v_u_2:GetPlayers() do
					v79(v80)
				end
				p_u_52.JoinConnection = v_u_2.PlayerAdded:Connect(v79)
				v_u_16[v_u_55] = p_u_52._RevivePrompts
				local v81, v82 = game.ServerScriptService.common.Data.Bindables.GetData:Invoke(v_u_55)
				local v83 = (v82 or not v81.SelfRevives) and 0 or v81.SelfRevives
				if p_u_52._HasAED and not p_u_52._UsedAED then
					v83 = v83 + 1
				end
				v_u_12:FireClient(v_u_55, {
					"ChangeSelfPrompt",
					p_u_52._RevivePrompts[v_u_55]._Identifier,
					tostring(v83),
					p_u_52._HasAED and not p_u_52._UsedAED or nil
				})
			end
		end
		if v_u_55 ~= game.Players.LocalPlayer then
			v_u_17[v_u_55] = true
			v_u_22()
		end
	end
end
function v_u_39.Update(p_u_84, p85) -- name: Update
	-- upvalues: (copy) v_u_1, (copy) v_u_12
	if p_u_84.Duration <= 0 or p_u_84.Inactive then
		return
	else
		if v_u_1 then
			for v86, _ in p_u_84._PlayersReviving do
				if not v86.Parent then
					p_u_84._PlayersReviving[v86] = nil
				end
			end
			p_u_84._PlayerState.BeingRevived = next(p_u_84._PlayersReviving) ~= nil
		end
		if not p_u_84._PlayerState.BeingRevived then
			p_u_84.Duration = p_u_84.Duration - p85
		end
		if p_u_84.Duration <= 0 then
			p_u_84.Duration = 0
		end
		if v_u_1 and p_u_84._PlayerState.HP > 0 then
			if p_u_84.JoinConnection then
				p_u_84.JoinConnection:Disconnect()
				p_u_84.JoinConnection = nil
			end
			p_u_84._PlayerState.IsDowned = false
			p_u_84._PlayerState.BeingRevived = false
			p_u_84.Inactive = true
			p_u_84:DeletePrompts()
			v_u_12:FireAllClients({ "NotDowned", p_u_84._PlayerState.Player })
			return
		else
			if next(p_u_84._PlayersReviving) then
				local v87 = p_u_84._MaxReviveTime
				for v88, v89 in p_u_84._PlayersReviving do
					if p_u_84._MaxReviveTime < v89 then
						p_u_84._MaxReviveTime = v89
					end
					local v90 = p_u_84._PlayersReviving
					v90[v88] = v90[v88] - p85
					if p_u_84._PlayersReviving[v88] <= 0 then
						p_u_84._PlayersReviving[v88] = 0
					end
					if p_u_84._PlayersReviving[v88] <= v87 then
						v87 = p_u_84._PlayersReviving[v88]
					end
				end
				local v91 = 1 - v87 / p_u_84._MaxReviveTime
				p_u_84.ReviveProgress = math.clamp(v91, 0, 1)
			else
				p_u_84.ReviveProgress = 0
			end
			if v_u_1 and p_u_84.ReviveProgress >= 1 then
				if game.ReplicatedStorage:FindFirstChild("place") then
					local v92 = require("@game/ServerStorage/place/StoryModule")
					local v93 = p_u_84._Player
					for _, v94 in v92:GetAllNPCs() do
						if v93:DistanceFromCharacter(v94.HRP.Position) < 10 then
							v94:Stun(3)
						end
					end
				end
				local v95 = p_u_84._PlayerState.GodMode
				local v96 = p_u_84._Player
				local v_u_97 = Instance.new("ForceField", v96.Character)
				if not v95 then
					p_u_84._PlayerState.GodMode = true
					task.delay(5, function()
						-- upvalues: (copy) v_u_97, (copy) p_u_84
						v_u_97:Destroy()
						p_u_84._PlayerState.GodMode = false
					end)
				end
				p_u_84._PlayerState.HP = 100
				p_u_84._RevivesLeft = p_u_84._RevivesLeft - 1
				v_u_12:FireAllClients({ "NotDowned", p_u_84._PlayerState.Player })
				return
			elseif p_u_84.Duration <= 0 or v_u_1 and p_u_84._RevivesLeft <= 0 then
				if v_u_1 then
					if p_u_84._PlayerState.HP <= 0 then
						p_u_84._PlayerState.IsDead = true
					end
					p_u_84._PlayerState.IsDowned = false
					p_u_84._PlayerState.BeingRevived = false
					if p_u_84.JoinConnection then
						p_u_84.JoinConnection:Disconnect()
						p_u_84.JoinConnection = nil
					end
					v_u_12:FireAllClients({ "NotDowned", p_u_84._PlayerState.Player })
				end
				p_u_84.Inactive = true
				p_u_84:DeletePrompts()
			end
		end
	end
end
function v_u_39.Destroy(p98) -- name: Destroy
	-- upvalues: (copy) v_u_17, (copy) v_u_22
	if p98.JoinConnection then
		p98.JoinConnection:Disconnect()
		p98.JoinConnection = nil
	end
	p98:DeletePrompts()
	v_u_17[p98._PlayerState.Player] = nil
	v_u_22()
	setmetatable(p98, nil)
	table.clear(p98)
	table.freeze(p98)
end
return v_u_39