local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local common = game.ReplicatedStorage.common
local Resources = NPCs_Shared:WaitForChild("Resources")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local DamageHelper_Util = require((NPCs_Shared:WaitForChild("Utils")):WaitForChild("DamageHelper_Util"))
local Janitor = require(ReplicatedStorage.common:WaitForChild("Janitor"))
require(NPCs_Shared.Utils.Displacement_Util)
local Hitreg_Util = require(NPCs_Shared.Utils.Hitreg_Util)
local Ragdoll_Util = require(NPCs_Shared.Utils.Ragdoll_Util)
local u72 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local DamageIndicator_Util = require(NPCs_Shared.Utils.DamageIndicator_Util)
require(NPCs_Shared.Utils.Encoder_Util)
local Signal = require(common.Signal)
local StatusEffect_Util = require(NPCs_Shared.Utils.StatusEffect_Util)
local u108 = game:GetService("RunService"):IsClient()
if u108 then
    u108 = require("@game/ReplicatedStorage/common/ZS_Framework/Modules/Utils/RaycastUtil")
end
local u109 = nil
local u110 = {}
local u111 = {}
local u112 = {}
local u113 = {}
local ParryEvent = require(RedEvents.Framework.ParryEvent)
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u126 = {}
u126._ClassName = script.Name
u126.__index = u126
u126.MakeHealthBar = true
u126.DetailFolderName = "Details"
u126.AttackPrepareSound = NPCs_Shared.Resources.SFX.prepare:Clone()
u126.AttackSound = NPCs_Shared.Resources.SFX.miss:Clone()
u126.CanParry = true
u126.CanBlock = true
u126.AttackWindup = 0.67

local function unpackData(p1) -- Line: 59
    local v1 = bit32.extract(p1, 8, 8)
    local v2 = bit32.extract(p1, 0, 8)
    return v1 - 128, v2 - 128
end

function u126.new(p1) -- Line: 68 -- upvalues: Janitor (val), Signal (val), NPCs_Shared (val), u126 (val)
    local u1 = {}
    local v1 = {
        Crawl = {Id = "rbxassetid://134221028851811", Priority = Enum.AnimationPriority.Action4},
        Walk = {Id = "rbxassetid://1456410875", Priority = Enum.AnimationPriority.Idle},
        Idle = {Id = "rbxassetid://1456411981", Priority = Enum.AnimationPriority.Core},
        Death = {Id = "rbxassetid://1631844886", Priority = Enum.AnimationPriority.Action},
        Stunned = {Id = "rbxassetid://4794760171", Priority = Enum.AnimationPriority.Movement},
        Attack = {Id = "rbxassetid://9205494146", Priority = Enum.AnimationPriority.Action},
        Climbing = {Id = "rbxassetid://3539184749", Priority = Enum.AnimationPriority.Action2},
    }
    u1.AnimationInfo = v1
    local v2 = p1[2]
    v1 = buffer.readi32(v2, 0)
    local v3 = p1[2]
    v2 = buffer.readi32(v3, 4)
    u1.MaxHP = v1
    u1.HP = v2
    u1.ServerHP = u1.HP
    local v4 = p1[3]
    v3 = buffer.readi16(v4, 0)
    u1.InitData = p1
    u1.WalkSpeed = v3
    u1.RequireHumanoid = p1[4]
    u1.pastPositions = {}
    u1._Janitor = Janitor.new()
    u1.Died = Signal.new()
    u1.Destroyed = Signal.new()
    u1.HealthChanged = Signal.new()
    u1.MovementStateChanged = Signal.new()
    u1.StatusUpdated = Signal.new()
    u1.Particles = {}
    u1.Neons = {}
    u1.HealthChanged:Connect(function() -- Line: 109 -- upvalues: u1 (val)
        if u1.HealthBar then
            local Size = u1.HealthBar.HealthContainer.Bar.Size
            local HealthBar = u1.HealthBar
            local v1 = false
            if u1.HP ~= u1.MaxHP then
                v1 = 0 < u1.HP
            end
            HealthBar.Enabled = v1
            local v2 = u1
            local Bar = v2.HealthBar.HealthContainer.Bar
            local v3 = UDim2.fromScale(u1.HP / u1.MaxHP, Size.Y.Scale)
            Bar:TweenSize(v3, "Out", "Sine", 0.1, true)
        end
    end)
    u1.LastClimbPos = nil
    u1.ClimbingSpeed = 0
    u1.MovementStateChanged:Connect(function(p1, p2) -- Line: 120 -- upvalues: u1 (val)
        if p1 == "Climbing" then
            if p2 then
                u1.LastClimbPos = u1.HRP.Position
                u1.AnimationTracks.Climbing:Play(0.1, 1, 1)
                return
            end
            u1.LastClimbPos = nil
            u1.AnimationTracks.Climbing:Stop()
        end
    end)
    u1.HitSFX = NPCs_Shared.Resources.SFX.hitplayer:Clone()
    local v5 = u126
    setmetatable(u1, v5)
    return u1
end

function u126:Spawn(p2) -- Line: 146 -- upvalues: DamageHelper_Util (val)
    local v1
    if not self._Initialized then
        self:Init()
    end
    local v2 = DamageHelper_Util
    local BaseModel = self.BaseModel
    self.ArmorHPs = v2:GetArmorHPList(BaseModel)
    self.HP = self.MaxHP
    self.ServerHP = self.MaxHP
    self.Model.PrimaryPart.CFrame = p2
    self.Model.Parent = workspace.Zombies
    self.Spawned = true
    self.MovementState = {Climbing = false}
    if self.AnimationTracks then
        v1 = self
    else
        local Animation, Id, Id_2, Id_3, v3, v4, v5, v6, v7
        self.AnimationTracks = {}
        local Humanoid = self.Humanoid
        if not Humanoid then
            Humanoid = self.AnimationController
        end
        if not Humanoid:FindFirstChild("Animator") then
            Instance.new("Animator").Parent = Humanoid
        end
        v1 = self
        for k, v in pairs(self.AnimationInfo) do
            Animation = Instance.new("Animation")
            Id = v.Id
            if typeof(Id) ~= "string" then
                Id_2 = v.Id
                if typeof(Id_2) == "table" then
                    v1.AnimationTracks[k] = {}
                    Id_3 = v.Id
                    v3 = nil
                    v4 = nil
                    for i, j in Id_3, v3, v4 do
                        Animation.AnimationId = j
                        v5 = Humanoid.Animator:LoadAnimation(Animation)
                        v5.Priority = v.Priority
                        v6 = v1.AnimationTracks[k]
                        table.insert(v6, v5)
                    end
                end
            else
                Animation.AnimationId = v.Id
                v1.AnimationTracks[k] = (Humanoid.Animator:LoadAnimation(Animation))
                v7 = v1.AnimationTracks[k]
                v7.Priority = v.Priority
            end
        end
    end
    if v1.AnimationTracks.Idle and v1.AlwaysIdle then
        v1.AnimationTracks.Idle:Play()
    end
    v1:ClientActivate()
end

function u126:GenerateModel() -- Line: 202
    -- upvalues: u112 (val), peek (val), u72 (val), u111 (val), Resources (val), StatusEffect_Util (val)
    -- upvalues: DamageHelper_Util (val)
    local High, Joints, Medium, Neons, Particles, v1, v2
    if not self.BaseModel:GetAttribute("Setup") then
        repeat
            task.wait()
        until self.BaseModel:GetAttribute("Setup")
    end
    if self.Model then
        self.Model:Destroy()
    end
    if not u112[self.BaseModel] then
        self.Model = self.BaseModel:Clone()
    else
        v1 = u112[self.BaseModel][self.DetailFolderName]
        v1.Name = "Details"
        v1.Parent = self.BaseModel
        self.Model = self.BaseModel:Clone()
        v1.Parent = nil
    end
    v1 = {High = {}}
    local v3 = {}
    v1.Medium = v3
    local v4 = self
    for i, j in self.Model:GetDescendants() do
        if j.Name == "LOD_HIGH" then
            if not ((peek(u72.Graphics.ZombieQuality)) <= 3) then
                High = v1.High
                table.insert(High, j)
            else
                j:Destroy()
            end
        elseif j.Name ~= "HIGH" then
            if j.Name == "LOD_MEDIUM" or j.Name == "MEDIUM" then
                if not ((peek(u72.Graphics.ZombieQuality)) <= 2) then
                    Medium = v1.Medium
                    table.insert(Medium, j)
                else
                    j:Destroy()
                end
            end
        elseif not ((peek(u72.Graphics.ZombieQuality)) <= 3) then
            High = v1.High
            table.insert(High, j)
        else
            j:Destroy()
        end
    end
    u111[v4] = v1
    if not v4.Model:FindFirstChild("Left Leg") then
        v4.Height = v4.Model:GetExtentsSize().Y
    else
        v4.Height = v4.Model["Left Leg"].Size.Y + v4.Model.HumanoidRootPart.Size.Y / 2
    end
    if v4.MakeHealthBar then
        if v4.HealthBar then
            v4.HealthBar:Destroy()
        end
        v3 = Resources.Misc.HealthBar:Clone()
        local NameLabel = v3.NameLabel
        local HealthBarName = v4.HealthBarName
        if not HealthBarName then
            HealthBarName = v4.Name
            if not HealthBarName then
                HealthBarName = v4.Model.Name
            end
        end
        NameLabel.Text = HealthBarName
        local v5 = v4.HP ~= v4.MaxHP
        v3.Enabled = v5
        v3.Parent = v4.Model:FindFirstChild("Head", true)
        v4.HealthBar = v3
        local Status = v3:WaitForChild("Status")
        v4.StatusUpdated:Connect(function(p1, p2) -- Line: 262 -- upvalues: Status (val), StatusEffect_Util (upval)
            if p1 == "Apply" then
                local v1 = Status
                local _Name = p2._Name
                if v1:FindFirstChild(_Name) then
                    Status[p2._Name]:Destroy()
                end
                v1 = StatusEffect_Util.GetIconLabel(p2)
                v1.Parent = Status
            end
        end)
    end
    v4.Joints = {}
    for k, n in v4.Model:GetDescendants() do
        if n:IsA("Motor6D") then
            Joints = v4.Joints
            v2 = {n, n.C1}
            table.insert(Joints, v2)
        end
    end
    local Humanoid = v4.Model:FindFirstChildOfClass("Humanoid")
    if not v4.RequireHumanoid or not Humanoid then
        if Humanoid then
            Humanoid:Destroy()
        end
        v4.AnimationController = Instance.new("AnimationController")
        local Animator = Instance.new("Animator")
        Animator.Parent = v4.AnimationController
        v4.AnimationController.Parent = v4.Model
    else
        local FallingDown = Enum.HumanoidStateType.FallingDown
        Humanoid:SetStateEnabled(FallingDown, false)
        local Climbing = Enum.HumanoidStateType.Climbing
        Humanoid:SetStateEnabled(Climbing, false)
        local GettingUp = Enum.HumanoidStateType.GettingUp
        Humanoid:SetStateEnabled(GettingUp, false)
        local Ragdoll = Enum.HumanoidStateType.Ragdoll
        Humanoid:SetStateEnabled(Ragdoll, false)
        local Landed = Enum.HumanoidStateType.Landed
        Humanoid:SetStateEnabled(Landed, false)
        local Freefall = Enum.HumanoidStateType.Freefall
        Humanoid:SetStateEnabled(Freefall, false)
        local Seated = Enum.HumanoidStateType.Seated
        Humanoid:SetStateEnabled(Seated, false)
        local Swimming = Enum.HumanoidStateType.Swimming
        Humanoid:SetStateEnabled(Swimming, false)
        v4.Humanoid = Humanoid
    end
    local PrimaryPart = v4.Model.PrimaryPart
    if not PrimaryPart then
        PrimaryPart = v4.Model:FindFirstChild("HumanoidRootPart")
    end
    v4.HRP = PrimaryPart
    if not v4.HRP then
        v4.HRP = v4.Model:FindFirstChildOfClass("BasePart")
        if v4.HRP then
            warn(v4._ClassName .. " is using a random part as a HRP!")
        else
            warn(v4._ClassName .. " could not find a HRP to use!")
        end
    end
    v4.HRP.Anchored = true
    v4.HRP.CollisionGroup = "NPCCollision"
    v4.HRP.CanQuery = true
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://2897232972"
    Sound.Volume = 0.2
    Sound.Looped = true
    Sound.Parent = v4.HRP
    v4.FootstepSFX = Sound
    v4.HitSFX.Parent = v4.HRP
    local v6 = DamageHelper_Util
    local Model = v4.Model
    v4.UIDTable = v6:GenUIDTable(Model)
    for m, i5 in v4.Model:GetDescendants() do
        if i5:IsA("ParticleEmitter") then
            Particles = v4.Particles
            table.insert(Particles, i5)
        elseif i5:IsA("BasePart") and i5.Material == Enum.Material.Neon then
            Neons = v4.Neons
            table.insert(Neons, i5)
        end
    end
end

function u126:Init() -- Line: 340 -- upvalues: u110 (val), u112 (val)
    if self._Initialized then
        return
    end
    local v1 = self.BaseModel ~= nil
    assert(v1, "NPC has no BaseModel")
    if not u110[self.BaseModel] then
        u110[self.BaseModel] = "SettingUp"
        if not self.BaseModel:GetAttribute("Setup") then
            repeat
                self.BaseModel:GetAttributeChangedSignal("Setup"):Wait()
            until self.BaseModel:GetAttribute("Setup")
        end
        local DetailFolders = self.BaseModel:FindFirstChild("DetailFolders")
        if DetailFolders then
            v1 = {}
            for i, j in DetailFolders:GetChildren() do
                v1[j.Name] = j
                j.Parent = nil
            end
            u112[self.BaseModel] = v1
            DetailFolders:Destroy()
        end
        u110[self.BaseModel] = "Finished"
    elseif u110[self.BaseModel] == "SettingUp" then
        repeat
            task.wait()
        until u110[self.BaseModel] ~= "SettingUp"
    end
    self:GenerateModel()
    self._Initialized = true
    if self.InitData[1] then
        local v2 = self.InitData[1]
        self:Spawn(v2)
    end
end

function u126.UpdateWalkSpeed(p1, p2, p3) -- Line: 389 -- upvalues: GameState (val)
    local ZombieSpeed
    if not p3 then
        ZombieSpeed = GameState.Data.Variables.ZombieSpeed
    else
        ZombieSpeed = 1
    end
    p1.WalkSpeed = p2 * ZombieSpeed
end

function u126:ClientActivate() -- Line: 393
    if self.NPCThread then
        self:Deactivate()
    end
    local v1 = {}
    self.NPCThread = v1
    v1.Break = false
end

function u126.FastThink(p1, p2) -- Line: 402
    if p1.IsDead then
        p1.AnimationTracks.Walk:Stop()
        p1.FootstepSFX:Pause()
        return
    end
    local v1 = p1.Speed or 0
    if not (0.1 < v1) then
        p1.FootstepSFX:Pause()
        p1.AnimationTracks.Walk:Stop()
        p1.AnimationTracks.Idle:Play()
    else
        v1 = p1.Speed or 0
        if p1.AnimationTracks.Walk.IsPlaying ~= false then
            local Walk_2 = p1.AnimationTracks.Walk
            local v2 = v1 / p1.WalkSpeed
            Walk_2:AdjustSpeed(v2)
        else
            local Walk = p1.AnimationTracks.Walk
            local v3 = v1 / p1.WalkSpeed
            Walk:Play(0.1, 1, v3)
            p1.FootstepSFX.PlaybackSpeed = 1 * (1 + v1 / p1.WalkSpeed)
            if not p1.FootstepSFX.Paused then
                p1.FootstepSFX:Play()
            else
                p1.FootstepSFX:Resume()
            end
        end
        if not p1.AlwaysIdle then
            p1.AnimationTracks.Idle:Stop()
        end
    end
    if p1.MovementState.Climbing then
        p1.ClimbingSpeed = (p1.HRP.Position - p1.LastClimbPos).Magnitude
        local Climbing = p1.AnimationTracks.Climbing
        local v4 = p1.ClimbingSpeed * 10
        Climbing:AdjustSpeed(v4)
        p1.LastClimbPos = p1.HRP.Position
    end
end

function u126:Deactivate() -- Line: 438
    if self.NPCThread then
        self.NPCThread.Break = true
    end
end

function u126:Despawn() -- Line: 447
    local v1 = 0
    while not self.Model do
        if not (v1 < 5) then
            break
        end
        task.wait(2)
        v1 = v1 + 1
    end
    self:Deactivate()
    self.Model.Parent = nil
    self.Spawned = false
end

function u126:Destroy() -- Line: 460 -- upvalues: u111 (val)
    if self._Destroyed then
        return
    end
    self._Destroyed = true
    self:Despawn()
    self.Model:Destroy()
    self.Destroyed:Fire()
    local _Janitor = self._Janitor
    if _Janitor then
        _Janitor:Destroy()
        self._Janitor = nil
    end
    if u111[self] then
        table.clear(u111[self])
        u111[self] = nil
    end
    self.HealthChanged:DisconnectAll()
    self.MovementStateChanged:DisconnectAll()
    self.StatusUpdated:DisconnectAll()
end

u126.ApplyEffect = StatusEffect_Util.ApplyEffect
u126.RemoveEffect = StatusEffect_Util.RemoveEffect

function u126.ChangeMovementState(p1, p2, p3) -- Line: 493
    if not p1.MovementState then
        return
    end
    p1.MovementState[p2] = p3
    p1.MovementStateChanged:Fire(p2, p3)
end

function u126:ChangeHealth(p2, p3) -- Line: 502
    local HP = self.HP
    if not p3 then
        self.ServerHP = self.ServerHP + p2
        self.HP = self.ServerHP
    else
        self.HP = self.HP + p2
    end
    if self.HP ~= HP then
        local HealthChanged = self.HealthChanged
        local HP_2 = self.HP
        HealthChanged:Fire(HP_2)
    end
end

function u126.SetHealth(p1, p2) -- Line: 515
    p1.MaxHP = p2
    p1.HP = p1.MaxHP
    p1.ServerHP = p1.MaxHP
    local HealthChanged = p1.HealthChanged
    local HP = p1.HP
    HealthChanged:Fire(HP)
end

function u126.ClientChangeHealth(p1, p2) -- Line: 522
    p1:ChangeHealth(p2, true)
end

function u126.ClientShot(p1, p2) -- Line: 526 -- upvalues: Hitreg_Util (val), Players (val), Resources (val)
    local HP = p1.HP
    local v1 = Hitreg_Util(p1, p2)
    if v1 and p1.HP <= 0 then
        if p2.weapon.Config.OnKill then
            task.spawn(p2.weapon.Config.OnKill, p2.weapon, Players.LocalPlayer, p2)
        end
        p1:ClientKill()
        if v1.HitHeadshot then
            p1:HeadshotEffect(true)
            local v2 = Resources.SFX.headshot:Clone()
            v2.Parent = p1.HRP
            v2:Play()
        end
    end
    return v1
end

function u126:HeadshotEffect(p2) -- Line: 552
    local Head = self.Model:FindFirstChild("Head")
    if not Head then
        Head = self.Model:FindFirstChild("UpperHead")
    end
    if not Head then
        return
    end
    if not p2 then
        if self.BeforeHeadshotInfo then
            Head.Transparency = self.BeforeHeadshotInfo.HeadTransparency
            if self.BeforeHeadshotInfo.HeadLOD then
                local Details_2 = self.Model:FindFirstChild("Details")
                if Details_2 then
                    local LOD_2 = Details_2:FindFirstChild("LOD")
                    if LOD_2 then
                        self.BeforeHeadshotInfo.HeadLOD.Parent = LOD_2
                    end
                end
            end
        end
        return
    end
    local Details = self.Model:FindFirstChild("Details")
    local v1 = nil
    if Details then
        local LOD = Details:FindFirstChild("LOD")
        if LOD then
            local Name = Head.Name
            v1 = LOD:FindFirstChild(Name)
        end
    end
    local v2 = {HeadLOD = v1, HeadTransparency = Head.Transparency}
    self.BeforeHeadshotInfo = v2
    Head.Transparency = 1
    if not v1 then
        return
    end
    self.BackupHeadLOD = v1
    v1.Parent = nil
end

function u126.FleshShot(p1, p2, p3) -- Line: 592 -- upvalues: DamageIndicator_Util (val)
    p2.Damage = p3 or 0
    p1.LastShotData = p2
    local Normal = p2.raycastResult.Normal
    local Instance = p2.raycastResult.Instance
    local Position = p2.raycastResult.Position
    local Attribute = Instance:GetAttribute("uid")
    if Attribute then
        local PredictedDamageByUid = p1.PredictedDamageByUid
        if not PredictedDamageByUid then
            PredictedDamageByUid = {}
        end
        p1.PredictedDamageByUid = PredictedDamageByUid
        p1.PredictedDamageByUid[Attribute] = p3 or 0
    end
    task.defer(DamageIndicator_Util.Display, Instance, p3 or 0)
    local startPos = p2.startPos
    local v1 = p2.weapon.Config.Damage / p1.MaxHP
    p1:Flinch(Position, startPos, v1, Instance, Normal, Normal)
end

function u126.ArmorBroken(p1, p2) -- Line: 615
    p1.Model.Details.Armor[p2.Name]:Destroy()
end

local u178 = {
    Head = 1,
    UpperTorso = 0.9,
    LowerTorso = 0.6,
    LeftArm = 0.7,
    RightArm = 0.7,
    LeftLeg = 0.3,
    RightLeg = 0.3,
}

function u126:Flinch(p2, p3, p4, p5, p6, p7) -- Line: 632
    -- upvalues: peek (val), u72 (val), u178 (val), TweenService (val)
    if peek(u72.Graphics.Flinching) and not self.NoFlinch then
        local Joints, Name, Position, Unit, Unit_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
        if p2 then
            Position = p2
        else
            if p6 then
                if p5 and p5.Parent then
                    local CFrame_2 = p5.CFrame
                    v14 = CFrame.new(p6)
                    Position = CFrame_2:ToWorldSpace(v14).Position
                    v13 = p4 * 2.5
                    if not p7 then
                        Unit = (Position - p3).Unit
                    else
                        Unit = -p7.Unit
                        if not Unit then
                            Unit = (Position - p3).Unit
                        end
                    end
                    Joints = self.Joints
                    v14 = nil
                    v1 = nil
                    for i, j in Joints, v14, v1 do
                        v2 = j[1]
                        v3 = j[2]
                        if v2 and v2.Part1 then
                            Name = v2.Part1.Name
                            v4 = u178[Name] or 0.5
                            v5 = v2.Part1.Position - Position
                            v7 = 1 - v5.Magnitude / 5
                            v6 = math.clamp(v7, 0, 1)
                            Unit_2 = v5:Cross(Unit).Unit
                            v8 = v13 * v4 * v6
                            if Unit_2.Magnitude ~= Unit_2.Magnitude then
                                Unit_2 = Vector3.new(0, 0, 0)
                            end
                            v9 = CFrame.Angles(Unit_2.X * v8, Unit_2.Y * v8, Unit_2.Z * v8)
                            v2.C1 = v2.C1 * v9
                            v10 = TweenService
                            v11 = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                            v12 = {C1 = v3}
                            v10:Create(v2, v11, v12):Play()
                        end
                    end
                    return
                end
                return
            end
            Position = p2
        end
        v13 = p4 * 2.5
        if not p7 then
            Unit = (Position - p3).Unit
        else
            Unit = -p7.Unit
            if not Unit then
                Unit = (Position - p3).Unit
            end
        end
        Joints = self.Joints
        v14 = nil
        v1 = nil
        for k, n in Joints, v14, v1 do
            v2 = n[1]
            v3 = n[2]
            if v2 and v2.Part1 then
                Name = v2.Part1.Name
                v4 = u178[Name] or 0.5
                v5 = v2.Part1.Position - Position
                v7 = 1 - v5.Magnitude / 5
                v6 = math.clamp(v7, 0, 1)
                Unit_2 = v5:Cross(Unit).Unit
                v8 = v13 * v4 * v6
                if Unit_2.Magnitude ~= Unit_2.Magnitude then
                    Unit_2 = Vector3.new(0, 0, 0)
                end
                v9 = CFrame.Angles(Unit_2.X * v8, Unit_2.Y * v8, Unit_2.Z * v8)
                v2.C1 = v2.C1 * v9
                v10 = TweenService
                v11 = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                v12 = {C1 = v3}
                v10:Create(v2, v11, v12):Play()
            end
        end
        return
    end
end

function u126:Ragdoll() -- Line: 701 -- upvalues: peek (val), u72 (val), Ragdoll_Util (val), Resources (val)
    self.HRP.CanQuery = false
    if not self.Ragdolling and peek(u72.Graphics.Ragdolls) then
        local v1
        self.Ragdolling = true
        self.HRP.Anchored = false
        if self.Humanoid then
            local Humanoid = self.Humanoid
            local Physics = Enum.HumanoidStateType.Physics
            Humanoid:ChangeState(Physics)
        end
        Ragdoll_Util.Ragdoll(self.Model)
        local Particles = self.Particles
        local v2 = nil
        local v3 = nil
        for i, j in Particles, v2, v3 do
            j.Enabled = false
        end
        local Neons = self.Neons
        v2 = nil
        v3 = nil
        for k, n in Neons, v2, v3 do
            n.Material = Enum.Material.SmoothPlastic
        end
        if not peek(u72.Sound.RagdollSounds) then
            return
        end
        local u49 = {}
        for k2, v in pairs(self.Model:GetChildren()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                v.CanTouch = true
                local u77 = 0
                v1 = v.Touched:Connect(function(p1) -- Line: 729 -- upvalues: u77 (ref), v (val)
                    local Ignore = workspace.Ignore
                    if not p1:IsDescendantOf(Ignore) then
                        u77 = v.Velocity.magnitude
                    end
                end)
                table.insert(u49, v1)
                v1 = v.TouchEnded:Connect(function(p1) -- Line: 738 -- upvalues: v (val), u77 (ref), Resources (upval)
                    local Ignore = workspace.Ignore
                    if not p1:IsDescendantOf(Ignore) then
                        local v1 = v.Velocity.magnitude - u77
                        if 1.5 < v1 and v1 < 4.5 then
                            local v2 = Resources.SFX.ragdoll_impact["Impact" .. math.random(1, 6)]:Clone()
                            v2.Parent = v
                            v2.Volume = 7
                            v2:Play()
                            game.Debris:AddItem(v2, 3)
                        end
                    end
                end)
                table.insert(u49, v1)
            end
        end
        task.delay(2, function() -- Line: 757 -- upvalues: u49 (val)
            local v1 = u49
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                j:Disconnect()
            end
            table.clear(u49)
        end)
        return
    end
    if not self.Ragdolling and self.AnimationTracks.Death and not self.AnimationTracks.Death.IsPlaying then
        self.AnimationTracks.Death:Play()
    end
end

function u126:UnRagdoll() -- Line: 773 -- upvalues: Ragdoll_Util (val)
    self.HRP.CanQuery = true
    if self.Ragdolling then
        local Particles = self.Particles
        local v1 = nil
        local v2 = nil
        for i, j in Particles, v1, v2 do
            j.Enabled = true
        end
        local Neons = self.Neons
        v1 = nil
        v2 = nil
        for k, n in Neons, v1, v2 do
            n.Material = Enum.Material.Neon
        end
        self.Ragdolling = false
        self.HRP.Anchored = true
        if self.Humanoid then
            local Humanoid = self.Humanoid
            local GettingUp = Enum.HumanoidStateType.GettingUp
            Humanoid:ChangeState(GettingUp)
        end
        Ragdoll_Util.UnRagdoll(self.Model)
    end
end

function u126:ClientKill() -- Line: 794
    self.Model.Parent = workspace.Ignore
    self:Ragdoll()
    local u8 = os.clock()
    self.ClientKillTimestamp = u8
    task.defer(function() -- Line: 799 -- upvalues: self (val), u8 (val)
        task.wait(1)
        if self.ClientKillTimestamp ~= u8 then
            return
        end
        task.wait(game.Players.LocalPlayer:GetNetworkPing() * 2 + 0.5)
        if self.ClientKillTimestamp == u8 and not self.ServerDead then
            self:HeadshotEffect(false)
            self:UnRagdoll()
            self.Model.Parent = workspace.Zombies
        end
    end)
end

function u126.Kill(p1) -- Line: 813 -- upvalues: peek (val), u72 (val)
    if p1.IsDead then
        return
    end
    p1.IsDead = true
    p1.ServerDead = true
    p1.MoveTo = nil
    p1.Died:Fire()
    task.defer(function() -- Line: 821 -- upvalues: p1 (val), peek (upval), u72 (upval)
        p1:Deactivate()
        if not p1.dontRagdoll then
            p1:Ragdoll()
        end
        if p1.LastShotData then
            local v1 = p1.LastShotData.Damage or 0
            local v2 = p1
            local MaxHP = v2.MaxHP
            local Instance = p1.LastShotData.raycastResult.Instance
            Instance.Velocity = (Instance.Position - p1.LastShotData.startPos).Unit * (v1 / MaxHP) * 250
        end
        if p1._Destroyed then
            return
        end
        p1.Model.Parent = workspace.Ignore
        if p1.Ragdolling then
            task.wait(peek(u72.Graphics.RagdollTimer))
        end
        p1:FadeCharacter()
        task.wait(0.75)
        p1:Destroy()
    end)
end

function u126.Crawl(p1) -- Line: 854
    p1:PlayAnimation("Crawl", 0.2)
end

function u126.Uncrawl(p1) -- Line: 858
    p1:StopAnimation("Crawl")
end

function u126.FadeCharacter(p1) -- Line: 862 -- upvalues: TweenService (val)
    task.defer(function() -- Line: 863 -- upvalues: p1 (val), TweenService (upval)
        local v1, v2
        for i, j in p1.Model:GetDescendants() do
            if j:IsA("BasePart") or j:IsA("Texture") or j:IsA("Decal") then
                v1 = TweenService
                v2 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                v1:Create(j, v2, {Transparency = 1}):Play()
            elseif j:IsA("Frame") or j:IsA("TextLabel") then
                if j:IsA("TextLabel") then
                    v1 = TweenService
                    v2 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    v1:Create(j, v2, {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
                end
                v1 = TweenService
                v2 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                v1:Create(j, v2, {BackgroundTransparency = 1}):Play()
            end
        end
    end)
end

function u126.MakeCharSound(p1, p2, p3, p4, p5) -- Line: 892 -- upvalues: u113 (val)
    local Sound = Instance.new("Sound")
    Sound.SoundId = p2
    Sound.Volume = p3 or 0.5
    Sound.Looped = p5
    Sound.Parent = p1.HRP
    if p4 then
        if u113[p4] then
            u113[p4]:Stop()
        end
        u113[p4] = Sound
    end
    Sound.Stopped:Connect(function() -- Line: 908 -- upvalues: Sound (val), u113 (upval), p4 (val)
        Sound:Destroy()
        if u113[p4] == Sound then
            u113[p4] = nil
        end
    end)
    Sound:Play()
    if Sound.TimeLength == 0 then
        Sound:GetPropertyChangedSignal("TimeLength"):Wait()
    end
    task.delay(Sound.TimeLength, function() -- Line: 921 -- upvalues: Sound (val)
        Sound:Destroy()
    end)
end

function u126.StopCharSound(p1, p2) -- Line: 926 -- upvalues: u113 (val)
    local v1 = p2 ~= nil
    assert(v1, "Must pass sound name")
    if u113[p2] then
        u113[p2]:Stop()
    end
end

function u126:PlayAnimation(p2, p3, p4, p5) -- Line: 933
    if self.AnimationTracks and self.AnimationTracks[p2] then
        self.AnimationTracks[p2]:Play(p3, p4, p5)
    end
end

function u126:StopAnimation(p2) -- Line: 939
    if self.AnimationTracks and self.AnimationTracks[p2] then
        self.AnimationTracks[p2]:Stop()
    end
end

function u126.ClientThink(p1, p2) -- Line: 948
    if p1.CurrentEffects then
        local CurrentEffects = p1.CurrentEffects
        local v1 = nil
        local v2 = nil
        for i, j in CurrentEffects, v1, v2 do
            if j.update then
                j.update(p2)
            end
        end
    end
end

function u126.ServerUpdate(p1, p2) -- Line: 960 -- upvalues: u108 (val)
    if not p1._Destroyed and not p1.IsDead and p1.HRP then
        local v1, v2, v3
        if p1.GroundPositionCorrectionDisabled then
            v1 = p1.HRP.CFrame.Rotation + p2
        else
            local v4 = workspace
            v3 = -p1.Height * 1.5
            local v5 = Vector3.new(0, v3, 0)
            local AltRaycastParams = u108:GetAltRaycastParams()
            v4 = v4:Raycast(p2, v5, AltRaycastParams)
            if not v4 then
                v1 = p1.HRP.CFrame.Rotation + p2
            else
                v2 = p1.HRP.CFrame.Rotation + v4.Position
                local Height = p1.Height
                v1 = v2 + Vector3.new(0, Height, 0)
            end
        end
        p1.MoveTo = v1.p
        if not p1.Spawned or not p1.HRP.Parent then
            if not p1.HRP.Parent then
                p1:GenerateModel()
            end
            p1:Spawn(v1)
        end
        if p1.Spawned then
            local pastPositions = p1.pastPositions
            local p = v1.p
            table.insert(pastPositions, p)
            if 2 < #pastPositions then
                table.remove(pastPositions, 1)
            end
            if #pastPositions == 2 then
                local p_2 = v1.p
                local Y = v1.p.Y
                v2 = p_2 - Vector3.new(0, Y, 0)
                v3 = pastPositions[1]
                local Y_2 = pastPositions[1].Y
                p1.Speed = ((v2 - (v3 - Vector3.new(0, Y_2, 0))) / 0.1).Magnitude
                p1.LastSpeedCheck = os.clock() + 0.25
                local Position = p1.HRP.Position
                local Y_3 = p1.HRP.Position.Y
                local Unit = (v2 - (Position - Vector3.new(0, Y_3, 0))).Unit
                if not p1.RotateTowards and not p1.AlignDirection and 1 < p1.Speed then
                    local v6 = CFrame.new(p1.HRP.Position, p1.HRP.Position + Unit * 5)
                    p1.Rotation = v6 - CFrame.new(p1.HRP.Position, p1.HRP.Position + Unit * 5).Position
                end
            end
        end
        return
    end
end

function u126.Rollback(p1, p2) -- Line: 1017
    print("BaseNPC:Rollback called for " .. p2 .. " SERVER HP " .. p1.HP .. " CLIENT HP ")
    p1.HP = p2
    p1.IsDead = false
    p1.Model.Parent = workspace.Zombies
    p1.AnimationTracks.Death:Stop()
    p1:UnRagdoll()
    local HealthChanged = p1.HealthChanged
    local HP = p1.HP
    HealthChanged:Fire(HP)
    p1:HeadshotEffect(false)
end

function u126.ReconcileDamage(p1, p2, p3) -- Line: 1033 -- upvalues: DamageIndicator_Util (val)
    local PredictedDamageByUid = p3
    if PredictedDamageByUid then
        PredictedDamageByUid = p1.PredictedDamageByUid
        if PredictedDamageByUid then
            PredictedDamageByUid = p1.PredictedDamageByUid[p3]
        end
    end
    if PredictedDamageByUid then
        local v1 = p2 - PredictedDamageByUid
        local v2 = math.abs(v1)
        local v3 = PredictedDamageByUid * 0.03
        if v2 <= math.max(0.5, v3) then
            return
        end
    end
    local UIDTable = p3
    if UIDTable then
        UIDTable = p1.UIDTable
        if UIDTable then
            UIDTable = p1.UIDTable[p3]
        end
    end
    if UIDTable then
        DamageIndicator_Util.Display(UIDTable, p2)
    end
end

function u126.ServerShot(p1) end

function u126.AttackHit(p1) -- Line: 1049
    if p1.HitSFX and not p1.HitSFX.IsPlaying then
        p1.HitSFX:Play()
    end
end

function u126:Stun(p2) -- Line: 1055 -- upvalues: NPCs_Shared (val)
    local Attack = self.AnimationTracks.Attack
    if typeof(Attack) ~= "table" then
        self.AnimationTracks.Attack:Stop()
    else
        local Attack_2 = self.AnimationTracks.Attack
        local v1 = nil
        local v2 = nil
        for i, j in Attack_2, v1, v2 do
            j:Stop()
        end
    end
    self.AnimationTracks.Stunned:Play()
    if p2 == true then
        local v3 = NPCs_Shared.Resources.SFX.parry:Clone()
        v3.Parent = self.HRP
        v3:Play()
        game.Debris:AddItem(v3, 2)
    end
end

function u126.Attack(p1, p2, p3) -- Line: 1072
    -- upvalues: GameState (val), u109 (ref), RunService (val), ParryEvent (val)
    if not p1.Spawned then
        return
    end
    task.defer(function() -- Line: 1076
        -- upvalues: p1 (val), GameState (upval), u109 (upval), RunService (upval), p3 (val), ParryEvent (upval)
        local Attack_2
        local v1 = p1
        local Attack = v1.AnimationTracks.Attack
        if typeof(Attack) ~= "table" then
            Attack_2 = p1.AnimationTracks.Attack
        else
            Attack_2 = p1.AnimationTracks.Attack[math.random(#p1.AnimationTracks.Attack)]
        end
        local v2 = p1.AnimationInfo.Attack.Speed or 1
        v1 = GameState
        local v3 = v2 * v1.Data.Variables.ZombieAttackSpeed
        Attack_2:Play(nil, nil, v3)
        v2 = p1.AttackPrepareSound:Clone()
        v2.Parent = p1.HRP
        v2.PlaybackSpeed = GameState.Data.Variables.ZombieAttackSpeed
        v2:Play()
        game.Debris:AddItem(v2, 2)
        task.wait(p1.AttackWindup / GameState.Data.Variables.ZombieAttackSpeed)
        v1 = p1.AttackSound:Clone()
        v1.Parent = p1.HRP
        v1:Play()
        game.Debris:AddItem(v1, 2)
        local Character = game.Players.LocalPlayer.Character
        if not Character then
            return
        end
        if (Character.HumanoidRootPart.Position - p1.HRP.Position).Magnitude <= 8 then
            if not u109 then
                local v4
                if not RunService:IsClient() then
                    v4 = nil
                else
                    v4 = require("@game/ReplicatedStorage/common/ZS_Framework/Modules/Controllers/WeaponController")
                end
                u109 = v4
            end
            local CanParry = p1.CanParry
            local CanBlock = p1.CanBlock
            local v5 = true
            if p3 then
                if p3.Unparriable ~= nil then
                    CanParry = not p3.Unparriable
                end
                if p3.Unblockable ~= nil then
                    CanBlock = not p3.Unblockable
                end
                if p3.DontParryStun ~= nil then
                    v5 = not p3.DontParryStun
                end
            end
            if CanParry and u109.Parrying then
                local v6 = ParryEvent
                local v7 = p1
                local UID = v7.UID
                v6:FireServer(UID)
                if v5 then
                    p1:Stun()
                end
                game.Debris:AddItem(v1, 2)
                u109:Parried()
                return
            end
            if CanBlock and u109.Blocking then
                u109:Blocked()
            end
        end
    end)
end

if RunService:IsClient() then
    DamageIndicator_Util.Init()
    u72.SettingsChanged:Connect(function() -- Line: 1143 -- upvalues: u111 (val), peek (val), u72 (val), DamageIndicator_Util (val)
        local High, Medium, v1, v2
        local v3 = u111
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            if (peek(u72.Graphics.ZombieQuality)) <= 3 then
                High = j.High
                v1 = nil
                v2 = nil
                for k, n in High, v1, v2 do
                    n:Destroy()
                end
            end
            if (peek(u72.Graphics.ZombieQuality)) <= 2 then
                Medium = j.Medium
                v1 = nil
                v2 = nil
                for m, i5 in Medium, v1, v2 do
                    i5:Destroy()
                end
            end
        end
        DamageIndicator_Util.Init()
    end)
end
return u126