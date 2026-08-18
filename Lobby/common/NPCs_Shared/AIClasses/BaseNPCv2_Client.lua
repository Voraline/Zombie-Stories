local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
workspace:WaitForChild("Ignore")
local v_u_5 = v1.common:WaitForChild("NPCs_Shared")
local v6 = game.ReplicatedStorage.common
local v_u_7 = v_u_5:WaitForChild("Resources")
local v8 = game.ReplicatedStorage.common.RedEvents
local v_u_9 = require(v_u_5:WaitForChild("Utils"):WaitForChild("DamageHelper_Util"))
local v_u_10 = require(v1.common:WaitForChild("Janitor"))
require(v_u_5.Utils.Displacement_Util)
local v_u_11 = require(v_u_5.Utils.Hitreg_Util)
local v_u_12 = require(v_u_5.Utils.Ragdoll_Util)
local v_u_13 = require("@game/ReplicatedStorage/common/Settings")
local v_u_14 = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local v_u_15 = require(v_u_5.Utils.DamageIndicator_Util)
require(v_u_5.Utils.Encoder_Util)
local v_u_16 = require(v6.Signal)
local v_u_17 = require(v_u_5.Utils.StatusEffect_Util)
local v_u_18 = game:GetService("RunService"):IsClient()
if v_u_18 then
	v_u_18 = require("@game/ReplicatedStorage/common/ZS_Framework/Modules/Utils/RaycastUtil")
end
local v_u_19 = nil
local v_u_20 = {}
local v_u_21 = {}
local v_u_22 = {}
local v_u_23 = {}
local v_u_24 = require(v8.Framework.ParryEvent)
local v_u_25 = require(v1.common.ZS_Shared.Data.GameState)
local v_u_26 = {
	["_ClassName"] = script.Name
}
v_u_26.__index = v_u_26
v_u_26.MakeHealthBar = true
v_u_26.DetailFolderName = "Details"
v_u_26.AttackPrepareSound = v_u_5.Resources.SFX.prepare:Clone()
v_u_26.AttackSound = v_u_5.Resources.SFX.miss:Clone()
v_u_26.CanParry = true
v_u_26.CanBlock = true
v_u_26.AttackWindup = 0.67
function v_u_26.new(p27) -- name: new
	-- upvalues: (copy) v_u_10, (copy) v_u_16, (copy) v_u_5, (copy) v_u_26
	local v_u_28 = {}
	local v29 = {
		["Crawl"] = {
			["Id"] = "rbxassetid://134221028851811",
			["Priority"] = nil,
			["Priority"] = Enum.AnimationPriority.Action4
		},
		["Walk"] = {
			["Id"] = "rbxassetid://1456410875",
			["Priority"] = nil,
			["Priority"] = Enum.AnimationPriority.Idle
		},
		["Idle"] = {
			["Id"] = "rbxassetid://1456411981",
			["Priority"] = nil,
			["Priority"] = Enum.AnimationPriority.Core
		},
		["Death"] = {
			["Id"] = "rbxassetid://1631844886",
			["Priority"] = nil,
			["Priority"] = Enum.AnimationPriority.Action
		},
		["Stunned"] = {
			["Id"] = "rbxassetid://4794760171",
			["Priority"] = nil,
			["Priority"] = Enum.AnimationPriority.Movement
		},
		["Attack"] = {
			["Id"] = "rbxassetid://9205494146",
			["Priority"] = nil,
			["Priority"] = Enum.AnimationPriority.Action
		},
		["Climbing"] = {
			["Id"] = "rbxassetid://3539184749",
			["Priority"] = nil,
			["Priority"] = Enum.AnimationPriority.Action2
		}
	}
	v_u_28.AnimationInfo = v29
	local v30 = p27[2]
	local v31 = buffer.readi32(v30, 0)
	local v32 = p27[2]
	local v33 = buffer.readi32(v32, 4)
	v_u_28.MaxHP = v31
	v_u_28.HP = v33
	v_u_28.ServerHP = v_u_28.HP
	local v34 = p27[3]
	local v35 = buffer.readi16(v34, 0)
	v_u_28.InitData = p27
	v_u_28.WalkSpeed = v35
	v_u_28.RequireHumanoid = p27[4]
	v_u_28.pastPositions = {}
	v_u_28._Janitor = v_u_10.new()
	v_u_28.Died = v_u_16.new()
	v_u_28.Destroyed = v_u_16.new()
	v_u_28.HealthChanged = v_u_16.new()
	v_u_28.MovementStateChanged = v_u_16.new()
	v_u_28.StatusUpdated = v_u_16.new()
	v_u_28.Particles = {}
	v_u_28.Neons = {}
	v_u_28.HealthChanged:Connect(function()
		-- upvalues: (copy) v_u_28
		if v_u_28.HealthBar then
			local v36 = v_u_28.HealthBar.HealthContainer.Bar.Size
			local v37 = v_u_28.HealthBar
			local v38
			if v_u_28.HP == v_u_28.MaxHP then
				v38 = false
			else
				v38 = v_u_28.HP > 0
			end
			v37.Enabled = v38
			v_u_28.HealthBar.HealthContainer.Bar:TweenSize(UDim2.fromScale(v_u_28.HP / v_u_28.MaxHP, v36.Y.Scale), "Out", "Sine", 0.1, true)
		end
	end)
	v_u_28.LastClimbPos = nil
	v_u_28.ClimbingSpeed = 0
	v_u_28.MovementStateChanged:Connect(function(p39, p40)
		-- upvalues: (copy) v_u_28
		if p39 == "Climbing" then
			if p40 then
				v_u_28.LastClimbPos = v_u_28.HRP.Position
				v_u_28.AnimationTracks.Climbing:Play(0.1, 1, 1)
				return
			end
			v_u_28.LastClimbPos = nil
			v_u_28.AnimationTracks.Climbing:Stop()
		end
	end)
	v_u_28.HitSFX = v_u_5.Resources.SFX.hitplayer:Clone()
	local v41 = v_u_26
	setmetatable(v_u_28, v41)
	return v_u_28
end
function v_u_26.Spawn(p42, p43) -- name: Spawn
	-- upvalues: (copy) v_u_9
	if not p42._Initialized then
		p42:Init()
	end
	p42.ArmorHPs = v_u_9:GetArmorHPList(p42.BaseModel)
	p42.HP = p42.MaxHP
	p42.ServerHP = p42.MaxHP
	p42.Model.PrimaryPart.CFrame = p43
	p42.Model.Parent = workspace.Zombies
	p42.Spawned = true
	p42.MovementState = {
		["Climbing"] = false
	}
	if not p42.AnimationTracks then
		p42.AnimationTracks = {}
		local v44 = p42.Humanoid or p42.AnimationController
		if not v44:FindFirstChild("Animator") then
			Instance.new("Animator").Parent = v44
		end
		for v45, v46 in pairs(p42.AnimationInfo) do
			local v47 = Instance.new("Animation")
			local v48 = v46.Id
			if typeof(v48) == "string" then
				v47.AnimationId = v46.Id
				p42.AnimationTracks[v45] = v44.Animator:LoadAnimation(v47)
				p42.AnimationTracks[v45].Priority = v46.Priority
			else
				local v49 = v46.Id
				if typeof(v49) == "table" then
					p42.AnimationTracks[v45] = {}
					for _, v50 in v46.Id do
						v47.AnimationId = v50
						local v51 = v44.Animator:LoadAnimation(v47)
						v51.Priority = v46.Priority
						local v52 = p42.AnimationTracks[v45]
						table.insert(v52, v51)
					end
				end
			end
		end
	end
	if p42.AnimationTracks.Idle and p42.AlwaysIdle then
		p42.AnimationTracks.Idle:Play()
	end
	p42:ClientActivate()
end
function v_u_26.GenerateModel(p53) -- name: GenerateModel
	-- upvalues: (copy) v_u_22, (copy) v_u_14, (copy) v_u_13, (copy) v_u_21, (copy) v_u_7, (copy) v_u_17, (copy) v_u_9
	if not p53.BaseModel:GetAttribute("Setup") then
		repeat
			task.wait()
		until p53.BaseModel:GetAttribute("Setup")
	end
	if p53.Model then
		p53.Model:Destroy()
	end
	if v_u_22[p53.BaseModel] then
		local v54 = v_u_22[p53.BaseModel][p53.DetailFolderName]
		v54.Name = "Details"
		v54.Parent = p53.BaseModel
		p53.Model = p53.BaseModel:Clone()
		v54.Parent = nil
	else
		p53.Model = p53.BaseModel:Clone()
	end
	local v55 = {
		["High"] = {},
		["Medium"] = {}
	}
	for _, v56 in p53.Model:GetDescendants() do
		if v56.Name == "LOD_HIGH" or v56.Name == "HIGH" then
			if v_u_14(v_u_13.Graphics.ZombieQuality) <= 3 then
				v56:Destroy()
			else
				local v57 = v55.High
				table.insert(v57, v56)
			end
		elseif v56.Name == "LOD_MEDIUM" or v56.Name == "MEDIUM" then
			if v_u_14(v_u_13.Graphics.ZombieQuality) <= 2 then
				v56:Destroy()
			else
				local v58 = v55.Medium
				table.insert(v58, v56)
			end
		end
	end
	v_u_21[p53] = v55
	if p53.Model:FindFirstChild("Left Leg") then
		p53.Height = p53.Model["Left Leg"].Size.Y + p53.Model.HumanoidRootPart.Size.Y / 2
	else
		p53.Height = p53.Model:GetExtentsSize().Y
	end
	if p53.MakeHealthBar then
		if p53.HealthBar then
			p53.HealthBar:Destroy()
		end
		local v59 = v_u_7.Misc.HealthBar:Clone()
		v59.NameLabel.Text = p53.HealthBarName or (p53.Name or p53.Model.Name)
		v59.Enabled = p53.HP ~= p53.MaxHP
		v59.Parent = p53.Model:FindFirstChild("Head", true)
		p53.HealthBar = v59
		local v_u_60 = v59:WaitForChild("Status")
		p53.StatusUpdated:Connect(function(p61, p62)
			-- upvalues: (copy) v_u_60, (ref) v_u_17
			if p61 == "Apply" then
				if v_u_60:FindFirstChild(p62._Name) then
					v_u_60[p62._Name]:Destroy()
				end
				v_u_17.GetIconLabel(p62).Parent = v_u_60
			end
		end)
	end
	p53.Joints = {}
	for _, v63 in p53.Model:GetDescendants() do
		if v63:IsA("Motor6D") then
			local v64 = p53.Joints
			local v65 = { v63, v63.C1 }
			table.insert(v64, v65)
		end
	end
	local v66 = p53.Model:FindFirstChildOfClass("Humanoid")
	if p53.RequireHumanoid and v66 then
		v66:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		v66:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
		v66:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		v66:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		v66:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
		v66:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		v66:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		v66:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
		p53.Humanoid = v66
	else
		if v66 then
			v66:Destroy()
		end
		p53.AnimationController = Instance.new("AnimationController")
		Instance.new("Animator").Parent = p53.AnimationController
		p53.AnimationController.Parent = p53.Model
	end
	p53.HRP = p53.Model.PrimaryPart or p53.Model:FindFirstChild("HumanoidRootPart")
	if not p53.HRP then
		p53.HRP = p53.Model:FindFirstChildOfClass("BasePart")
		if p53.HRP then
			warn(p53._ClassName .. " is using a random part as a HRP!")
		else
			warn(p53._ClassName .. " could not find a HRP to use!")
		end
	end
	p53.HRP.Anchored = true
	p53.HRP.CollisionGroup = "NPCCollision"
	p53.HRP.CanQuery = true
	local v67 = Instance.new("Sound")
	v67.SoundId = "rbxassetid://2897232972"
	v67.Volume = 0.2
	v67.Looped = true
	v67.Parent = p53.HRP
	p53.FootstepSFX = v67
	p53.HitSFX.Parent = p53.HRP
	p53.UIDTable = v_u_9:GenUIDTable(p53.Model)
	for _, v68 in p53.Model:GetDescendants() do
		if v68:IsA("ParticleEmitter") then
			local v69 = p53.Particles
			table.insert(v69, v68)
		elseif v68:IsA("BasePart") and v68.Material == Enum.Material.Neon then
			local v70 = p53.Neons
			table.insert(v70, v68)
		end
	end
end
function v_u_26.Init(p71) -- name: Init
	-- upvalues: (copy) v_u_20, (copy) v_u_22
	if not p71._Initialized then
		local v72 = p71.BaseModel ~= nil
		assert(v72, "NPC has no BaseModel")
		if v_u_20[p71.BaseModel] then
			if v_u_20[p71.BaseModel] == "SettingUp" then
				repeat
					task.wait()
				until v_u_20[p71.BaseModel] ~= "SettingUp"
			end
		else
			v_u_20[p71.BaseModel] = "SettingUp"
			if not p71.BaseModel:GetAttribute("Setup") then
				repeat
					p71.BaseModel:GetAttributeChangedSignal("Setup"):Wait()
				until p71.BaseModel:GetAttribute("Setup")
			end
			local v73 = p71.BaseModel:FindFirstChild("DetailFolders")
			if v73 then
				local v74 = {}
				for _, v75 in v73:GetChildren() do
					v74[v75.Name] = v75
					v75.Parent = nil
				end
				v_u_22[p71.BaseModel] = v74
				v73:Destroy()
			end
			v_u_20[p71.BaseModel] = "Finished"
		end
		p71:GenerateModel()
		p71._Initialized = true
		if p71.InitData[1] then
			p71:Spawn(p71.InitData[1])
		end
	end
end
function v_u_26.UpdateWalkSpeed(p76, p77, p78) -- name: UpdateWalkSpeed
	-- upvalues: (copy) v_u_25
	p76.WalkSpeed = p77 * (p78 and 1 or v_u_25.Data.Variables.ZombieSpeed)
end
function v_u_26.ClientActivate(p79) -- name: ClientActivate
	-- upvalues: (copy) v_u_26
	if p79.NPCThread then
		v_u_26:Deactivate()
	end
	local v80 = {}
	p79.NPCThread = v80
	v80.Break = false
end
function v_u_26.FastThink(p81, _) -- name: FastThink
	if p81.IsDead then
		p81.AnimationTracks.Walk:Stop()
		p81.FootstepSFX:Pause()
	else
		if (p81.Speed or 0) > 0.1 then
			local v82 = p81.Speed or 0
			if p81.AnimationTracks.Walk.IsPlaying == false then
				p81.AnimationTracks.Walk:Play(0.1, 1, v82 / p81.WalkSpeed)
				p81.FootstepSFX.PlaybackSpeed = 1 * (1 + v82 / p81.WalkSpeed)
				if p81.FootstepSFX.Paused then
					p81.FootstepSFX:Resume()
				else
					p81.FootstepSFX:Play()
				end
			else
				p81.AnimationTracks.Walk:AdjustSpeed(v82 / p81.WalkSpeed)
			end
			if not p81.AlwaysIdle then
				p81.AnimationTracks.Idle:Stop()
			end
		else
			p81.FootstepSFX:Pause()
			p81.AnimationTracks.Walk:Stop()
			p81.AnimationTracks.Idle:Play()
		end
		if p81.MovementState.Climbing then
			p81.ClimbingSpeed = (p81.HRP.Position - p81.LastClimbPos).Magnitude
			p81.AnimationTracks.Climbing:AdjustSpeed(p81.ClimbingSpeed * 10)
			p81.LastClimbPos = p81.HRP.Position
		end
	end
end
function v_u_26.Deactivate(p83) -- name: Deactivate
	if p83.NPCThread then
		p83.NPCThread.Break = true
	end
end
function v_u_26.Despawn(p84) -- name: Despawn
	local v85 = 0
	while not p84.Model and v85 < 5 do
		task.wait(2)
		v85 = v85 + 1
	end
	p84:Deactivate()
	p84.Model.Parent = nil
	p84.Spawned = false
end
function v_u_26.Destroy(p86) -- name: Destroy
	-- upvalues: (copy) v_u_21
	if not p86._Destroyed then
		p86._Destroyed = true
		p86:Despawn()
		p86.Model:Destroy()
		p86.Destroyed:Fire()
		local v87 = p86._Janitor
		if v87 then
			v87:Destroy()
			p86._Janitor = nil
		end
		if v_u_21[p86] then
			table.clear(v_u_21[p86])
			v_u_21[p86] = nil
		end
		p86.HealthChanged:DisconnectAll()
		p86.MovementStateChanged:DisconnectAll()
		p86.StatusUpdated:DisconnectAll()
	end
end
v_u_26.ApplyEffect = v_u_17.ApplyEffect
v_u_26.RemoveEffect = v_u_17.RemoveEffect
function v_u_26.ChangeMovementState(p88, p89, p90) -- name: ChangeMovementState
	if p88.MovementState then
		p88.MovementState[p89] = p90
		p88.MovementStateChanged:Fire(p89, p90)
	end
end
function v_u_26.ChangeHealth(p91, p92, p93) -- name: ChangeHealth
	local v94 = p91.HP
	if p93 then
		p91.HP = p91.HP + p92
	else
		p91.ServerHP = p91.ServerHP + p92
		p91.HP = p91.ServerHP
	end
	if p91.HP ~= v94 then
		p91.HealthChanged:Fire(p91.HP)
	end
end
function v_u_26.SetHealth(p95, p96) -- name: SetHealth
	p95.MaxHP = p96
	p95.HP = p95.MaxHP
	p95.ServerHP = p95.MaxHP
	p95.HealthChanged:Fire(p95.HP)
end
function v_u_26.ClientChangeHealth(p97, p98) -- name: ClientChangeHealth
	p97:ChangeHealth(p98, true)
end
function v_u_26.ClientShot(p99, p100) -- name: ClientShot
	-- upvalues: (copy) v_u_11, (copy) v_u_4, (copy) v_u_7
	local _ = p99.HP
	local v101 = v_u_11(p99, p100)
	if v101 and p99.HP <= 0 then
		if p100.weapon.Config.OnKill then
			task.spawn(p100.weapon.Config.OnKill, p100.weapon, v_u_4.LocalPlayer, p100)
		end
		p99:ClientKill()
		if v101.HitHeadshot then
			p99:HeadshotEffect(true)
			local v102 = v_u_7.SFX.headshot:Clone()
			v102.Parent = p99.HRP
			v102:Play()
		end
	end
	return v101
end
function v_u_26.HeadshotEffect(p103, p104) -- name: HeadshotEffect
	local v105 = p103.Model:FindFirstChild("Head") or p103.Model:FindFirstChild("UpperHead")
	if v105 then
		if p104 then
			local v106 = p103.Model:FindFirstChild("Details")
			local v107 = nil
			if v106 then
				local v108 = v106:FindFirstChild("LOD")
				if v108 then
					v107 = v108:FindFirstChild(v105.Name)
				end
			end
			p103.BeforeHeadshotInfo = {
				["HeadLOD"] = v107,
				["HeadTransparency"] = v105.Transparency
			}
			v105.Transparency = 1
			if v107 then
				p103.BackupHeadLOD = v107
				v107.Parent = nil
				return
			end
		elseif p103.BeforeHeadshotInfo then
			v105.Transparency = p103.BeforeHeadshotInfo.HeadTransparency
			if p103.BeforeHeadshotInfo.HeadLOD then
				local v109 = p103.Model:FindFirstChild("Details")
				local v110 = v109 and v109:FindFirstChild("LOD")
				if v110 then
					p103.BeforeHeadshotInfo.HeadLOD.Parent = v110
				end
			end
		end
	end
end
function v_u_26.FleshShot(p111, p112, p113) -- name: FleshShot
	-- upvalues: (copy) v_u_15
	p112.Damage = p113 or 0
	p111.LastShotData = p112
	local v114 = p112.raycastResult.Normal
	local v115 = p112.raycastResult.Instance
	local v116 = p112.raycastResult.Position
	local v117 = v115:GetAttribute("uid")
	if v117 then
		p111.PredictedDamageByUid = p111.PredictedDamageByUid or {}
		p111.PredictedDamageByUid[v117] = p113 or 0
	end
	task.defer(v_u_15.Display, v115, p113 or 0)
	p111:Flinch(v116, p112.startPos, p112.weapon.Config.Damage / p111.MaxHP, v115, v114, v114)
end
function v_u_26.ArmorBroken(p118, p119) -- name: ArmorBroken
	p118.Model.Details.Armor[p119.Name]:Destroy()
end
local v_u_120 = {
	["Head"] = 1,
	["UpperTorso"] = 0.9,
	["LowerTorso"] = 0.6,
	["LeftArm"] = 0.7,
	["RightArm"] = 0.7,
	["LeftLeg"] = 0.3,
	["RightLeg"] = 0.3
}
function v_u_26.Flinch(p121, p122, p123, p124, p125, p126, p127) -- name: Flinch
	-- upvalues: (copy) v_u_14, (copy) v_u_13, (copy) v_u_120, (copy) v_u_2
	if v_u_14(v_u_13.Graphics.Flinching) and not p121.NoFlinch then
		if not p122 and p126 then
			if not (p125 and p125.Parent) then
				return
			end
			p122 = p125.CFrame:ToWorldSpace(CFrame.new(p126)).Position
		end
		local v128 = p124 * 2.5
		local v129 = p127 and -p127.Unit or (p122 - p123).Unit
		for _, v130 in p121.Joints do
			local v131 = v130[1]
			local v132 = v130[2]
			if v131 and v131.Part1 then
				local v133 = v_u_120[v131.Part1.Name] or 0.5
				local v134 = v131.Part1.Position - p122
				local v135 = 1 - v134.Magnitude / 5
				local v136 = math.clamp(v135, 0, 1)
				local v137 = v134:Cross(v129).Unit
				local v138 = v128 * v133 * v136
				local v139 = v137.Magnitude ~= v137.Magnitude and Vector3.new(0, 0, 0) or v137
				local v140 = CFrame.Angles(v139.X * v138, v139.Y * v138, v139.Z * v138)
				v131.C1 = v131.C1 * v140
				v_u_2:Create(v131, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					["C1"] = v132
				}):Play()
			end
		end
	end
end
function v_u_26.Ragdoll(p141) -- name: Ragdoll
	-- upvalues: (copy) v_u_14, (copy) v_u_13, (copy) v_u_12, (copy) v_u_7
	p141.HRP.CanQuery = false
	if p141.Ragdolling or not v_u_14(v_u_13.Graphics.Ragdolls) then
		if not p141.Ragdolling and (p141.AnimationTracks.Death and not p141.AnimationTracks.Death.IsPlaying) then
			p141.AnimationTracks.Death:Play()
		end
	else
		p141.Ragdolling = true
		p141.HRP.Anchored = false
		if p141.Humanoid then
			p141.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		end
		v_u_12.Ragdoll(p141.Model)
		for _, v142 in p141.Particles do
			v142.Enabled = false
		end
		for _, v143 in p141.Neons do
			v143.Material = Enum.Material.SmoothPlastic
		end
		if v_u_14(v_u_13.Sound.RagdollSounds) then
			local v_u_144 = {}
			for _, v_u_145 in pairs(p141.Model:GetChildren()) do
				if v_u_145:IsA("BasePart") and v_u_145.Name ~= "HumanoidRootPart" then
					v_u_145.CanTouch = true
					local v_u_146 = 0
					local v147 = v_u_145.Touched
					local function v149(p148)
						-- upvalues: (ref) v_u_146, (copy) v_u_145
						if not p148:IsDescendantOf(workspace.Ignore) then
							v_u_146 = v_u_145.Velocity.magnitude
						end
					end
					table.insert(v_u_144, v147:Connect(v149))
					local v150 = v_u_145.TouchEnded
					local function v154(p151)
						-- upvalues: (copy) v_u_145, (ref) v_u_146, (ref) v_u_7
						if not p151:IsDescendantOf(workspace.Ignore) then
							local v152 = v_u_145.Velocity.magnitude - v_u_146
							if v152 > 1.5 and v152 < 4.5 then
								local v153 = v_u_7.SFX.ragdoll_impact["Impact" .. math.random(1, 6)]:Clone()
								v153.Parent = v_u_145
								v153.Volume = 7
								v153:Play()
								game.Debris:AddItem(v153, 3)
							end
						end
					end
					table.insert(v_u_144, v150:Connect(v154))
				end
			end
			task.delay(2, function()
				-- upvalues: (copy) v_u_144
				for _, v155 in v_u_144 do
					v155:Disconnect()
				end
				table.clear(v_u_144)
			end)
			return
		end
	end
end
function v_u_26.UnRagdoll(p156) -- name: UnRagdoll
	-- upvalues: (copy) v_u_12
	p156.HRP.CanQuery = true
	if p156.Ragdolling then
		for _, v157 in p156.Particles do
			v157.Enabled = true
		end
		for _, v158 in p156.Neons do
			v158.Material = Enum.Material.Neon
		end
		p156.Ragdolling = false
		p156.HRP.Anchored = true
		if p156.Humanoid then
			p156.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
		v_u_12.UnRagdoll(p156.Model)
	end
end
function v_u_26.ClientKill(p_u_159) -- name: ClientKill
	p_u_159.Model.Parent = workspace.Ignore
	p_u_159:Ragdoll()
	local v_u_160 = os.clock()
	p_u_159.ClientKillTimestamp = v_u_160
	task.defer(function()
		-- upvalues: (copy) p_u_159, (copy) v_u_160
		task.wait(1)
		if p_u_159.ClientKillTimestamp == v_u_160 then
			task.wait(game.Players.LocalPlayer:GetNetworkPing() * 2 + 0.5)
			if p_u_159.ClientKillTimestamp == v_u_160 and not p_u_159.ServerDead then
				p_u_159:HeadshotEffect(false)
				p_u_159:UnRagdoll()
				p_u_159.Model.Parent = workspace.Zombies
			end
		end
	end)
end
function v_u_26.Kill(p_u_161) -- name: Kill
	-- upvalues: (copy) v_u_14, (copy) v_u_13
	if not p_u_161.IsDead then
		p_u_161.IsDead = true
		p_u_161.ServerDead = true
		p_u_161.MoveTo = nil
		p_u_161.Died:Fire()
		task.defer(function()
			-- upvalues: (copy) p_u_161, (ref) v_u_14, (ref) v_u_13
			p_u_161:Deactivate()
			if not p_u_161.dontRagdoll then
				p_u_161:Ragdoll()
			end
			if p_u_161.LastShotData then
				local v162 = p_u_161.LastShotData.Damage or 0
				local v163 = p_u_161.MaxHP
				local v164 = p_u_161.LastShotData.raycastResult.Instance
				v164.Velocity = (v164.Position - p_u_161.LastShotData.startPos).Unit * (v162 / v163) * 250
			end
			if not p_u_161._Destroyed then
				p_u_161.Model.Parent = workspace.Ignore
				if p_u_161.Ragdolling then
					task.wait(v_u_14(v_u_13.Graphics.RagdollTimer))
				end
				p_u_161:FadeCharacter()
				task.wait(0.75)
				p_u_161:Destroy()
			end
		end)
	end
end
function v_u_26.Crawl(p165) -- name: Crawl
	p165:PlayAnimation("Crawl", 0.2)
end
function v_u_26.Uncrawl(p166) -- name: Uncrawl
	p166:StopAnimation("Crawl")
end
function v_u_26.FadeCharacter(p_u_167) -- name: FadeCharacter
	-- upvalues: (copy) v_u_2
	task.defer(function()
		-- upvalues: (copy) p_u_167, (ref) v_u_2
		for _, v168 in p_u_167.Model:GetDescendants() do
			if v168:IsA("BasePart") or (v168:IsA("Texture") or v168:IsA("Decal")) then
				v_u_2:Create(v168, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					["Transparency"] = 1
				}):Play()
			elseif v168:IsA("Frame") or v168:IsA("TextLabel") then
				if v168:IsA("TextLabel") then
					v_u_2:Create(v168, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
						["TextTransparency"] = 1,
						["TextStrokeTransparency"] = 1
					}):Play()
				end
				v_u_2:Create(v168, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
					["BackgroundTransparency"] = 1
				}):Play()
			end
		end
	end)
end
function v_u_26.MakeCharSound(p169, p170, p171, p_u_172, p173) -- name: MakeCharSound
	-- upvalues: (copy) v_u_23
	local v_u_174 = Instance.new("Sound")
	v_u_174.SoundId = p170
	v_u_174.Volume = p171 or 0.5
	v_u_174.Looped = p173
	v_u_174.Parent = p169.HRP
	if p_u_172 then
		if v_u_23[p_u_172] then
			v_u_23[p_u_172]:Stop()
		end
		v_u_23[p_u_172] = v_u_174
	end
	v_u_174.Stopped:Connect(function()
		-- upvalues: (copy) v_u_174, (ref) v_u_23, (copy) p_u_172
		v_u_174:Destroy()
		if v_u_23[p_u_172] == v_u_174 then
			v_u_23[p_u_172] = nil
		end
	end)
	v_u_174:Play()
	if v_u_174.TimeLength == 0 then
		v_u_174:GetPropertyChangedSignal("TimeLength"):Wait()
	end
	task.delay(v_u_174.TimeLength, function()
		-- upvalues: (copy) v_u_174
		v_u_174:Destroy()
	end)
end
function v_u_26.StopCharSound(_, p175) -- name: StopCharSound
	-- upvalues: (copy) v_u_23
	local v176 = p175 ~= nil
	assert(v176, "Must pass sound name")
	if v_u_23[p175] then
		v_u_23[p175]:Stop()
	end
end
function v_u_26.PlayAnimation(p177, p178, p179, p180, p181) -- name: PlayAnimation
	if p177.AnimationTracks and p177.AnimationTracks[p178] then
		p177.AnimationTracks[p178]:Play(p179, p180, p181)
	end
end
function v_u_26.StopAnimation(p182, p183) -- name: StopAnimation
	if p182.AnimationTracks and p182.AnimationTracks[p183] then
		p182.AnimationTracks[p183]:Stop()
	end
end
function v_u_26.ClientThink(p184, p185) -- name: ClientThink
	if p184.CurrentEffects then
		for _, v186 in p184.CurrentEffects do
			if v186.update then
				v186.update(p185)
			end
		end
	end
end
function v_u_26.ServerUpdate(p187, p188) -- name: ServerUpdate
	-- upvalues: (copy) v_u_18
	if not p187._Destroyed and (not p187.IsDead and p187.HRP) then
		local v189
		if p187.GroundPositionCorrectionDisabled then
			v189 = p187.HRP.CFrame.Rotation + p188
		else
			local v190 = workspace
			local v191 = -p187.Height * 1.5
			local v192 = v190:Raycast(p188, Vector3.new(0, v191, 0), v_u_18:GetAltRaycastParams())
			if v192 then
				local v193 = p187.HRP.CFrame.Rotation + v192.Position
				local v194 = p187.Height
				v189 = v193 + Vector3.new(0, v194, 0)
			else
				v189 = p187.HRP.CFrame.Rotation + p188
			end
		end
		p187.MoveTo = v189.p
		if not (p187.Spawned and p187.HRP.Parent) then
			if not p187.HRP.Parent then
				p187:GenerateModel()
			end
			p187:Spawn(v189)
		end
		if p187.Spawned then
			local v195 = p187.pastPositions
			local v196 = v189.p
			table.insert(v195, v196)
			if #v195 > 2 then
				table.remove(v195, 1)
			end
			if #v195 == 2 then
				local v197 = v189.p
				local v198 = v189.p.Y
				local v199 = v197 - Vector3.new(0, v198, 0)
				local v200 = v195[1]
				local v201 = v195[1].Y
				p187.Speed = ((v199 - (v200 - Vector3.new(0, v201, 0))) / 0.1).Magnitude
				p187.LastSpeedCheck = os.clock() + 0.25
				local v202 = p187.HRP.Position
				local v203 = p187.HRP.Position.Y
				local v204 = (v199 - (v202 - Vector3.new(0, v203, 0))).Unit
				if not p187.RotateTowards and (not p187.AlignDirection and p187.Speed > 1) then
					p187.Rotation = CFrame.new(p187.HRP.Position, p187.HRP.Position + v204 * 5) - CFrame.new(p187.HRP.Position, p187.HRP.Position + v204 * 5).Position
				end
			end
		end
	end
end
function v_u_26.Rollback(p205, p206) -- name: Rollback
	print("BaseNPC:Rollback called for " .. p206 .. " SERVER HP " .. p205.HP .. " CLIENT HP ")
	p205.HP = p206
	p205.IsDead = false
	p205.Model.Parent = workspace.Zombies
	p205.AnimationTracks.Death:Stop()
	p205:UnRagdoll()
	p205.HealthChanged:Fire(p205.HP)
	p205:HeadshotEffect(false)
end
function v_u_26.ReconcileDamage(p207, p208, p209) -- name: ReconcileDamage
	-- upvalues: (copy) v_u_15
	local v210 = p209 and p207.PredictedDamageByUid
	if v210 then
		v210 = p207.PredictedDamageByUid[p209]
	end
	if v210 then
		local v211 = p208 - v210
		local v212 = math.abs(v211)
		local v213 = v210 * 0.03
		if v212 <= math.max(0.5, v213) then
			return
		end
	end
	local v214 = p209 and p207.UIDTable
	if v214 then
		v214 = p207.UIDTable[p209]
	end
	if v214 then
		v_u_15.Display(v214, p208)
	end
end
function v_u_26.ServerShot(_) -- name: ServerShot end
function v_u_26.AttackHit(p215) -- name: AttackHit
	if p215.HitSFX and not p215.HitSFX.IsPlaying then
		p215.HitSFX:Play()
	end
end
function v_u_26.Stun(p216, p217) -- name: Stun
	-- upvalues: (copy) v_u_5
	local v218 = p216.AnimationTracks.Attack
	if typeof(v218) == "table" then
		for _, v219 in p216.AnimationTracks.Attack do
			v219:Stop()
		end
	else
		p216.AnimationTracks.Attack:Stop()
	end
	p216.AnimationTracks.Stunned:Play()
	if p217 == true then
		local v220 = v_u_5.Resources.SFX.parry:Clone()
		v220.Parent = p216.HRP
		v220:Play()
		game.Debris:AddItem(v220, 2)
	end
end
function v_u_26.Attack(p_u_221, _, p_u_222) -- name: Attack
	-- upvalues: (copy) v_u_25, (ref) v_u_19, (copy) v_u_3, (copy) v_u_24
	if p_u_221.Spawned then
		task.defer(function()
			-- upvalues: (copy) p_u_221, (ref) v_u_25, (ref) v_u_19, (ref) v_u_3, (copy) p_u_222, (ref) v_u_24
			local v223 = p_u_221.AnimationTracks.Attack
			local v224
			if typeof(v223) == "table" then
				v224 = p_u_221.AnimationTracks.Attack[math.random(#p_u_221.AnimationTracks.Attack)]
			else
				v224 = p_u_221.AnimationTracks.Attack
			end
			v224:Play(nil, nil, (p_u_221.AnimationInfo.Attack.Speed or 1) * v_u_25.Data.Variables.ZombieAttackSpeed)
			local v225 = p_u_221.AttackPrepareSound:Clone()
			v225.Parent = p_u_221.HRP
			v225.PlaybackSpeed = v_u_25.Data.Variables.ZombieAttackSpeed
			v225:Play()
			game.Debris:AddItem(v225, 2)
			task.wait(p_u_221.AttackWindup / v_u_25.Data.Variables.ZombieAttackSpeed)
			local v226 = p_u_221.AttackSound:Clone()
			v226.Parent = p_u_221.HRP
			v226:Play()
			game.Debris:AddItem(v226, 2)
			local v227 = game.Players.LocalPlayer.Character
			if v227 then
				if (v227.HumanoidRootPart.Position - p_u_221.HRP.Position).Magnitude <= 8 then
					if not v_u_19 then
						local v228
						if v_u_3:IsClient() then
							v228 = require("@game/ReplicatedStorage/common/ZS_Framework/Modules/Controllers/WeaponController")
						else
							v228 = nil
						end
						v_u_19 = v228
					end
					local v229 = p_u_221.CanParry
					local v230 = p_u_221.CanBlock
					local v231 = true
					if p_u_222 then
						if p_u_222.Unparriable ~= nil then
							v229 = not p_u_222.Unparriable
						end
						if p_u_222.Unblockable ~= nil then
							v230 = not p_u_222.Unblockable
						end
						if p_u_222.DontParryStun ~= nil then
							v231 = not p_u_222.DontParryStun
						end
					end
					if v229 and v_u_19.Parrying then
						v_u_24:FireServer(p_u_221.UID)
						if v231 then
							p_u_221:Stun()
						end
						game.Debris:AddItem(v226, 2)
						v_u_19:Parried()
						return
					end
					if v230 and v_u_19.Blocking then
						v_u_19:Blocked()
					end
				end
			end
		end)
	end
end
if v_u_3:IsClient() then
	v_u_15.Init()
	v_u_13.SettingsChanged:Connect(function()
		-- upvalues: (copy) v_u_21, (copy) v_u_14, (copy) v_u_13, (copy) v_u_15
		for _, v232 in v_u_21 do
			if v_u_14(v_u_13.Graphics.ZombieQuality) <= 3 then
				for _, v233 in v232.High do
					v233:Destroy()
				end
			end
			if v_u_14(v_u_13.Graphics.ZombieQuality) <= 2 then
				for _, v234 in v232.Medium do
					v234:Destroy()
				end
			end
		end
		v_u_15.Init()
	end)
end
return v_u_26