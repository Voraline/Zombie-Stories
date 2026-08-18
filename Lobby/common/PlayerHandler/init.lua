local v1 = game:GetService("PhysicsService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("RunService")
local v4 = game:GetService("ReplicatedStorage")
local v5 = v4.common
local v6 = v4.common.RedEvents
local v7 = workspace:FindFirstChild("SpawnBoxSerial551236123161233")
local v8 = require(v5:WaitForChild("Signal"))
local v_u_9 = require(script:WaitForChild("PlayerState"))
local v_u_10 = nil
local v_u_11 = v3:IsServer()
local v_u_12 = require(v6.Framework.UpdateStatusEvent)
local v_u_13 = require(v6.Framework.ForceTeleport)
local v_u_14 = require(v6.Framework.CameraEvent)
local v_u_15 = require(v6.Framework.FrameworkEvents)
local v_u_16 = {}
local v_u_17 = {}
local v_u_18 = {}
local v_u_19 = {}
local v_u_20 = nil
local v_u_21 = {}
if v_u_11 then
	local v22 = game:GetService("ServerStorage"):FindFirstChild("common")
	if v22 then
		v22 = game:GetService("ServerStorage").common:FindFirstChild("ProgressionTracker")
	end
	if v22 then
		v_u_10 = require(v22)
	end
	if v7 then
		v_u_20 = v7:WaitForChild("FieldLocation").CFrame * CFrame.new(0, 2, 0)
	end
	v1:RegisterCollisionGroup("NPCRagdoll")
	v1:RegisterCollisionGroup("NPC")
	v1:RegisterCollisionGroup("Player")
	v1:CollisionGroupSetCollidable("Player", "Player", false)
	v1:CollisionGroupSetCollidable("Player", "NPC", false)
	v1:CollisionGroupSetCollidable("NPC", "NPC", false)
	v1:CollisionGroupSetCollidable("NPC", "NPCRagdoll", false)
	v1:CollisionGroupSetCollidable("Player", "NPCRagdoll", false)
	for _, v23 in game.ServerStorage.common.ServerResources.StatusEffects:GetChildren() do
		v_u_18[v23.Name] = require(v23)
	end
end
if not v_u_11 then
	v_u_21.HealthChanged = v8.new()
	v_u_21.ReplicatedState = v8.new()
	v_u_21.StatusUpdated = v8.new()
end
v_u_21.PlayerDied = v8.new()
function v_u_21.KillPlayer(p24) -- name: KillPlayer
	-- upvalues: (copy) v_u_17
	local v25 = v_u_17[p24]
	if v25 then
		print("PlayerHandler:KillPlayer", p24.Name, v25.HP)
		v25.IsDead = true
	end
end
function v_u_21.Init(_) -- name: Init
	-- upvalues: (copy) v_u_21, (copy) v_u_17, (copy) v_u_9, (copy) v_u_11, (ref) v_u_20, (ref) v_u_10, (copy) v_u_19, (copy) v_u_2, (copy) v_u_15
	if not v_u_21._Init then
		local function v31(p26) -- name: setupPlayerState
			-- upvalues: (ref) v_u_17, (ref) v_u_21
			local v_u_27 = p26.Player
			v_u_17[v_u_27] = p26
			v_u_17[v_u_27]:GetPropertyChangedSignal("IsDead"):Connect(function(p28)
				-- upvalues: (copy) v_u_27, (ref) v_u_21, (ref) v_u_17
				local v29 = v_u_27.Character
				local v30 = v29 and v29.PrimaryPart
				if v30 then
					v30.Anchored = p28
				end
				if p28 then
					v_u_21.PlayerDied:Fire(v_u_27, v_u_17[v_u_27])
				end
			end)
		end
		v_u_9.StateAdded:Connect(v31)
		local function v38(p_u_32) -- name: PlayerAdded
			-- upvalues: (ref) v_u_11, (ref) v_u_9, (ref) v_u_17, (ref) v_u_21, (ref) v_u_20, (ref) v_u_10
			if v_u_11 then
				local v33 = v_u_9.new(p_u_32)
				local v_u_34 = v33.Player
				v_u_17[v_u_34] = v33
				v_u_17[v_u_34]:GetPropertyChangedSignal("IsDead"):Connect(function(p35)
					-- upvalues: (copy) v_u_34, (ref) v_u_21, (ref) v_u_17
					local v36 = v_u_34.Character
					local v37 = v36 and v36.PrimaryPart
					if v37 then
						v37.Anchored = p35
					end
					if p35 then
						v_u_21.PlayerDied:Fire(v_u_34, v_u_17[v_u_34])
					end
				end)
				v_u_17[p_u_32].Died:Connect(function()
					-- upvalues: (ref) v_u_21, (copy) p_u_32, (ref) v_u_20
					v_u_21:Teleport(p_u_32, v_u_20)
				end)
				p_u_32.CharacterAdded:Connect(function(_)
					-- upvalues: (ref) v_u_10, (copy) p_u_32
					if v_u_10 then
						v_u_10:UniformPlayer(p_u_32, v_u_10:GetClass(p_u_32))
					end
				end)
			end
		end
		local function v40(p39) -- name: PlayerRemoving
			-- upvalues: (ref) v_u_17, (ref) v_u_19
			if v_u_17[p39] then
				v_u_17[p39]:Destroy()
			end
			v_u_17[p39] = nil
			v_u_19[p39] = nil
		end
		for _, v41 in game.Players:GetPlayers() do
			v38(v41)
		end
		v_u_2.PlayerRemoving:Connect(v40)
		if v_u_11 then
			v_u_2.PlayerAdded:Connect(v38)
			require("@game/ServerStorage/common/PhysBall").init()
			v_u_15.RequestPendingTeleport:SetCallback(function(p42)
				-- upvalues: (ref) v_u_19
				local v43 = v_u_19[p42]
				v_u_19[p42] = nil
				return v43
			end)
		end
		v_u_21._Init = true
	end
end
function v_u_21.Teleport(_, p44, p45) -- name: Teleport
	-- upvalues: (copy) v_u_11, (copy) v_u_19, (copy) v_u_13
	local v46 = v_u_11
	assert(v46, "Teleport only available on server")
	v_u_19[p44] = p45
	if workspace.StreamingEnabled then
		local v47
		if typeof(p45) == "CFrame" then
			v47 = p45.Position
		else
			v47 = p45
		end
		p44:RequestStreamAroundAsync(v47, 5 + p44:GetNetworkPing() * 2)
	end
	v_u_13:FireClient(p44, p45)
	local v48 = p44.Character
	if v48 then
		if typeof(p45) ~= "CFrame" then
			p45 = CFrame.new(p45)
		end
		v48:PivotTo(p45)
	end
end
function v_u_21.GetHealth(_, p49) -- name: GetHealth
	-- upvalues: (copy) v_u_17
	return v_u_17[p49] and v_u_17[p49].HP or 100
end
function v_u_21.RespawnPlayer(_, p50, p51) -- name: RespawnPlayer
	-- upvalues: (copy) v_u_21
	local v52 = v_u_21:WaitForPlayerState(p50)
	if v52 then
		if v52.HP == 0 or p51 ~= nil then
			v52.HP = p51 or v52.MaxHP * 0.5
		end
		v52.IsDowned = false
		v52.IsDead = false
	end
end
function v_u_21.GetPlayerState(_, p53) -- name: GetPlayerState
	-- upvalues: (copy) v_u_17
	return v_u_17[p53]
end
function v_u_21.GetPlayerStateProperty(_, p54, p55) -- name: GetPlayerStateProperty
	-- upvalues: (copy) v_u_17
	if v_u_17[p54] then
		return v_u_17[p54][p55]
	else
		return nil
	end
end
function v_u_21.SetState(_, p56, p57, p58) -- name: SetState
	-- upvalues: (copy) v_u_17
	if v_u_17[p56] then
		v_u_17[p56][p57] = p58
	end
end
function v_u_21.SetMaxHP(_, p59, p60, p61) -- name: SetMaxHP
	-- upvalues: (copy) v_u_21
	local v62 = v_u_21:WaitForPlayerState(p59)
	if v62 and (typeof(p60) == "number" and p60 > 0) then
		v62.MaxHP = p60
		if p61 then
			v62.HP = p60
		else
			local v63 = v62.HP
			v62.HP = math.min(v63, p60)
		end
		local v64 = p59.Character
		if v64 then
			local v65 = v64:FindFirstChild("MaxHP")
			local v66 = v64:FindFirstChild("HP")
			if v65 and v65:IsA("NumberValue") then
				v65.Value = p60
			end
			if v66 and v66:IsA("NumberValue") then
				v66.Value = v62.HP
			end
		end
		if _G and (_G.plrDictionary and _G.plrDictionary[p59]) then
			local v67 = _G.plrDictionary[p59]
			if v67.MaxHealth then
				v67.MaxHealth.Value = p60
			end
			if v67.Health then
				v67.Health.Value = v62.HP
			end
		end
		p59:SetAttribute("Skill_MaxHP", p60)
		p59:SetAttribute("Skill_CurrentHP", v62.HP)
	end
end
function v_u_21.UpdateStatBar(_, _) -- name: UpdateStatBar end
function v_u_21.ResetStats(_, p68) -- name: ResetStats
	-- upvalues: (copy) v_u_17, (copy) v_u_21, (copy) v_u_12, (copy) v_u_16
	for v69, _ in v_u_17[p68].StatusEffects do
		v_u_17[p68].StatusEffects[v69] = false
	end
	v_u_21:UpdateStatBar(p68)
	v_u_12:FireClient(p68, v_u_16[p68])
end
function v_u_21.RemoveStatus(_, p70, p71) -- name: RemoveStatus
	-- upvalues: (copy) v_u_11, (copy) v_u_17
	if v_u_11 then
		local v72 = v_u_17[p70]
		local v73 = v72 and v72.StatusEffects
		if v73 then
			v73[p71] = false
		end
	end
end
function v_u_21.ApplyStatus(_, p74, p75) -- name: ApplyStatus
	-- upvalues: (copy) v_u_11, (copy) v_u_17, (copy) v_u_18
	if v_u_11 then
		local v76 = v_u_17[p74]
		local v77 = v76 and v76.StatusEffects
		if v77 then
			if not v77[p75] then
				v77[p75] = 1
				return
			end
			if v_u_18[p75].Stacks then
				v77[p75] = v77[p75] + 1
			end
		end
	end
end
function v_u_21.WaitForPlayerState(_, p78) -- name: WaitForPlayerState
	-- upvalues: (copy) v_u_17
	while not v_u_17[p78] and p78.Parent do
		task.wait()
	end
	return v_u_17[p78]
end
function v_u_21.SetCameraControllerEnabled(_, p79, p80) -- name: SetCameraControllerEnabled
	-- upvalues: (copy) v_u_11, (copy) v_u_14
	if v_u_11 then
		v_u_14:FireClient(p79, {
			["Type"] = "SetEnabled",
			["Enabled"] = nil,
			["Enabled"] = p80
		})
	else
		require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.CameraController):SetEnabled(p80)
	end
end
v3.Heartbeat:Connect(function(p81) -- name: OnUpdate
	-- upvalues: (copy) v_u_17
	for _, v82 in pairs(v_u_17) do
		v82.StatusEffects:Update(p81)
		if v82.UpdateSpartanShield then
			v82:UpdateSpartanShield(p81)
		end
	end
end)
v_u_21:Init()
return v_u_21