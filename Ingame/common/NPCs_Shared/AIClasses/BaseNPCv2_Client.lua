local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
workspace:WaitForChild("Ignore")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local Resources = NPCs_Shared:WaitForChild("Resources")
local Utils = NPCs_Shared:WaitForChild("Utils")
local DamageHelper_Util = require(Utils:WaitForChild("DamageHelper_Util"))
local Janitor = require(ReplicatedStorage.common:WaitForChild("Janitor"))
require(NPCs_Shared.Utils.Displacement_Util)
local Hitreg_Util = require(NPCs_Shared.Utils.Hitreg_Util)
local Ragdoll_Util = require(NPCs_Shared.Utils.Ragdoll_Util)
local u72 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local DamageIndicator_Util = require(NPCs_Shared.Utils.DamageIndicator_Util)
require(NPCs_Shared.Utils.Encoder_Util)
local Signal = require(game.ReplicatedStorage.common.Signal)
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
local ParryEvent = require(game.ReplicatedStorage.common.RedEvents.Framework.ParryEvent)
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u126 = {_ClassName = script.Name}
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
    }
    local v2 = {Id = "rbxassetid://3539184749", Priority = Enum.AnimationPriority.Action2}
    v1.Climbing = v2
    u1.AnimationInfo = v1
    v1 = buffer.readi32(p1[2], 0)
    u1.MaxHP = v1
    u1.HP = buffer.readi32(p1[2], 4)
    u1.ServerHP = u1.HP
    u1.InitData = p1
    u1.WalkSpeed = buffer.readi16(p1[3], 0)
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
            local v1 = if u1.HP ~= u1.MaxHP then 0 < u1.HP else false
            u1.HealthBar.Enabled = v1
            local v2 = UDim2.fromScale(u1.HP / u1.MaxHP, u1.HealthBar.HealthContainer.Bar.Size.Y.Scale)
            u1.HealthBar.HealthContainer.Bar:TweenSize(v2, "Out", "Sine", 0.1, true)
        end
    end)
    u1.LastClimbPos = nil
    u1.ClimbingSpeed = 0
    u1.MovementStateChanged:Connect(function(p1, p2) -- Line: 120 -- upvalues: u1 (val)
        if p1 ~= "Climbing" then
            return
        end
        if p2 then
            u1.LastClimbPos = u1.HRP.Position
            u1.AnimationTracks.Climbing:Play(0.1, 1, 1)
            return
        end
        u1.LastClimbPos = nil
        u1.AnimationTracks.Climbing:Stop()
    end)
    u1.HitSFX = NPCs_Shared.Resources.SFX.hitplayer:Clone()
    setmetatable(u1, u126)
    return u1
end
function u126:Spawn(p2) -- Line: 146 -- upvalues: DamageHelper_Util (val)
    local v1
    if not self._Initialized then
        self:Init()
    end
    self.ArmorHPs = DamageHelper_Util:GetArmorHPList(self.BaseModel)
    self.HP = self.MaxHP
    self.ServerHP = self.MaxHP
    self.Model.PrimaryPart.CFrame = p2
    self.Model.Parent = workspace.Zombies
    self.Spawned = true
    self.MovementState = {Climbing = false}
    if self.AnimationTracks then
        v1 = self
    else
        local Animation, Id, v2, v3, v4, v5
        self.AnimationTracks = {}
        local Humanoid = self.Humanoid
        if not Humanoid then
            Humanoid = self.AnimationController
        end
        if not (Humanoid:FindFirstChild("Animator")) then
            Instance.new("Animator").Parent = Humanoid
        end
        v1 = self
        for k, v in pairs(self.AnimationInfo) do
            Animation = Instance.new("Animation")
            if typeof(v.Id) == "string" then
                Animation.AnimationId = v.Id
                v1.AnimationTracks[k] = Humanoid.Animator:LoadAnimation(Animation)
                v5 = v1.AnimationTracks[k]
                v5.Priority = v.Priority
            elseif typeof(v.Id) == "table" then
                v1.AnimationTracks[k] = {}
                Id = v.Id
                v2 = nil
                v3 = nil
                for i, j in Id, v2, v3 do
                    Animation.AnimationId = j
                    v4 = Humanoid.Animator:LoadAnimation(Animation)
                    v4.Priority = v.Priority
                    table.insert(v1.AnimationTracks[k], v4)
                end
            end
        end
    end
    if v1.AnimationTracks.Idle and v1.AlwaysIdle then
        v1.AnimationTracks.Idle:Play()
    end
    v1:ClientActivate()
end
function u126:GenerateModel() -- Line: 202 -- upvalues: u112 (val), peek (val), u72 (val), u111 (val), Resources (val), StatusEffect_Util (val), DamageHelper_Util (val)
    local v1, v2
    if not (self.BaseModel:GetAttribute("Setup")) then
        while true do
            task.wait()
            if self.BaseModel:GetAttribute("Setup") then
                break
            end
        end
    end
    if self.Model then
        self.Model:Destroy()
    end
    if not (u112[self.BaseModel]) then
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
            v2 = peek(u72.Graphics.ZombieQuality)
            if v2 > 3 then
                table.insert(v1.High, j)
            else
                j:Destroy()
            end
        elseif j.Name ~= "HIGH" then
            if j.Name == "LOD_MEDIUM" then
                v2 = peek(u72.Graphics.ZombieQuality)
                if v2 > 2 then
                    table.insert(v1.Medium, j)
                else
                    j:Destroy()
                end
            elseif j.Name ~= "MEDIUM" then
            end
        end
    end
    u111[v4] = v1
    if not (v4.Model:FindFirstChild("Left Leg")) then
        v4.Height = v4.Model:GetExtentsSize().Y
    else
        v4.Height = v4.Model["Left Leg"].Size.Y + v4.Model.HumanoidRootPart.Size.Y / 2
    end
    if v4.MakeHealthBar then
        if v4.HealthBar then
            v4.HealthBar:Destroy()
        end
        v3 = Resources.Misc.HealthBar:Clone()
        local HealthBarName = v4.HealthBarName
        if not HealthBarName then
            HealthBarName = v4.Name
            if not HealthBarName then
                HealthBarName = v4.Model.Name
            end
        end
        v3.NameLabel.Text = HealthBarName
        local v5 = v4.HP ~= v4.MaxHP
        v3.Enabled = v5
        v3.Parent = v4.Model:FindFirstChild("Head", true)
        v4.HealthBar = v3
        local Status = v3:WaitForChild("Status")
        v4.StatusUpdated:Connect(function(p1, p2) -- Line: 262 -- upvalues: Status (val), StatusEffect_Util (upval)
            if p1 == "Apply" then
                if Status:FindFirstChild(p2._Name) then
                    Status[p2._Name]:Destroy()
                end
                local v1 = StatusEffect_Util.GetIconLabel(p2)
                v1.Parent = Status
            end
        end)
    end
    v4.Joints = {}
    for k, n in v4.Model:GetDescendants() do
        if n:IsA("Motor6D") then
            table.insert(v4.Joints, {n, n.C1})
        end
    end
    local Humanoid = v4.Model:FindFirstChildOfClass("Humanoid")
    if not v4.RequireHumanoid then
        if Humanoid then
            Humanoid:Destroy()
        end
        v4.AnimationController = Instance.new("AnimationController")
        local Animator = Instance.new("Animator")
        Animator.Parent = v4.AnimationController
        v4.AnimationController.Parent = v4.Model
    elseif Humanoid then
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
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
    v4.UIDTable = DamageHelper_Util:GenUIDTable(v4.Model)
    for m, i5 in v4.Model:GetDescendants() do
        if i5:IsA("ParticleEmitter") then
            table.insert(v4.Particles, i5)
        elseif i5:IsA("BasePart") and i5.Material == Enum.Material.Neon then
            table.insert(v4.Neons, i5)
        end
    end
end
function u126:Init() -- Line: 340 -- upvalues: u110 (val), u112 (val)
    if self._Initialized then
        return
    end
    local v1 = self.BaseModel ~= nil
    assert(v1, "NPC has no BaseModel")
    if not (u110[self.BaseModel]) then
        u110[self.BaseModel] = "SettingUp"
        if not (self.BaseModel:GetAttribute("Setup")) then
            while true do
                self.BaseModel:GetAttributeChangedSignal("Setup"):Wait()
                if self.BaseModel:GetAttribute("Setup") then
                    break
                end
            end
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
        while true do
            task.wait()
            if u110[self.BaseModel] ~= "SettingUp" then
                break
            end
        end
    end
    self:GenerateModel()
    self._Initialized = true
    if self.InitData[1] then
        self:Spawn(self.InitData[1])
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
    if 0.1 >= v1 then
        p1.FootstepSFX:Pause()
        p1.AnimationTracks.Walk:Stop()
        p1.AnimationTracks.Idle:Play()
    else
        v1 = p1.Speed or 0
        if p1.AnimationTracks.Walk.IsPlaying ~= false then
            p1.AnimationTracks.Walk:AdjustSpeed(v1 / p1.WalkSpeed)
        else
            p1.AnimationTracks.Walk:Play(0.1, 1, v1 / p1.WalkSpeed)
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
        p1.AnimationTracks.Climbing:AdjustSpeed(p1.ClimbingSpeed * 10)
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
        if v1 >= 5 then
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
    if not p3 then
        self.ServerHP = self.ServerHP + p2
        self.HP = self.ServerHP
    else
        self.HP = self.HP + p2
    end
    if self.HP ~= self.HP then
        self.HealthChanged:Fire(self.HP)
    end
end
function u126.SetHealth(p1, p2) -- Line: 515
    p1.MaxHP = p2
    p1.HP = p1.MaxHP
    p1.ServerHP = p1.MaxHP
    p1.HealthChanged:Fire(p1.HP)
end
function u126.ClientChangeHealth(p1, p2) -- Line: 522
    p1:ChangeHealth(p2, true)
end
function u126.ClientShot(p1, p2) -- Line: 526 -- upvalues: Hitreg_Util (val), Players (val), Resources (val)
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
            v1 = LOD:FindFirstChild(Head.Name)
        end
    end
    self.BeforeHeadshotInfo = {HeadLOD = v1, HeadTransparency = Head.Transparency}
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
    p1:Flinch(Position, p2.startPos, p2.weapon.Config.Damage / p1.MaxHP, Instance, Normal, Normal)
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
function u126:Flinch(p2, p3, p4, p5, p6, p7) -- Line: 632 -- upvalues: peek (val), u72 (val), u178 (val), TweenService (val)
    if not (peek(u72.Graphics.Flinching)) then
        return
    else
        local Position
        if self.NoFlinch then
            return
        end
        if p2 then
            local Unit, Unit_2, v1, v2, v3, v4, v5, v6, v7
            Position = p2
            local v8 = p4 * 2.5
            if not p7 then
                Unit = (Position - p3).Unit
            else
                Unit = -p7.Unit
            end
            local Joints = self.Joints
            local v9 = nil
            local v10 = nil
            for i, j in Joints, v9, v10 do
                v1 = j[1]
                if v1 and v1.Part1 then
                    v2 = u178[v1.Part1.Name] or 0.5
                    v3 = v1.Part1.Position - Position
                    v4 = math.clamp(1 - v3.Magnitude / 5, 0, 1)
                    Unit_2 = v3:Cross(Unit).Unit
                    v5 = v8 * v2 * v4
                    if Unit_2.Magnitude ~= Unit_2.Magnitude then
                        Unit_2 = Vector3.new(0, 0, 0)
                    end
                    v6 = CFrame.Angles(Unit_2.X * v5, Unit_2.Y * v5, Unit_2.Z * v5)
                    v1.C1 = v1.C1 * v6
                    v7 = TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    TweenService:Create(v1, v7, {C1 = j[2]}):Play()
                end
            end
            return
        elseif not p6 then
            Position = p2
        elseif not p5 then
            return
        else
            if not p5.Parent then
                return
            end
            Position = p5.CFrame:ToWorldSpace(CFrame.new(p6)).Position
        end
    end
end
function u126:Ragdoll() -- Line: 701 -- upvalues: peek (val), u72 (val), Ragdoll_Util (val), Resources (val)
    self.HRP.CanQuery = false
    if self.Ragdolling or not (peek(u72.Graphics.Ragdolls)) then
        if not self.Ragdolling and self.AnimationTracks.Death and not self.AnimationTracks.Death.IsPlaying then
            self.AnimationTracks.Death:Play()
        end
        return
    end
    self.Ragdolling = true
    self.HRP.Anchored = false
    if self.Humanoid then
        self.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
    Ragdoll_Util.Ragdoll(self.Model)
    local Particles = self.Particles
    local v1 = nil
    local v2 = nil
    for i, j in Particles, v1, v2 do
        j.Enabled = false
    end
    local Neons = self.Neons
    v1 = nil
    v2 = nil
    for k, n in Neons, v1, v2 do
        n.Material = Enum.Material.SmoothPlastic
    end
    if not (peek(u72.Sound.RagdollSounds)) then
        return
    end
    local u49 = {}
    for k2, v in pairs(self.Model:GetChildren()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.CanTouch = true
            local u77 = 0
            table.insert(u49, v.Touched:Connect(function(p1) -- Line: 729 -- upvalues: u77 (ref), v (val)
                if not (p1:IsDescendantOf(workspace.Ignore)) then
                    u77 = v.Velocity.magnitude
                end
            end))
            table.insert(u49, v.TouchEnded:Connect(function(p1) -- Line: 738 -- upvalues: v (val), u77 (ref), Resources (upval)
                if not (p1:IsDescendantOf(workspace.Ignore)) then
                    local v1 = v.Velocity.magnitude - u77
                    if 1.5 < v1 and v1 < 4.5 then
                        local v2 = Resources.SFX.ragdoll_impact["Impact" .. math.random(1, 6)]:Clone()
                        v2.Parent = v
                        v2.Volume = 7
                        v2:Play()
                        game.Debris:AddItem(v2, 3)
                    end
                end
            end))
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
            self.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
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
            local Instance = p1.LastShotData.raycastResult.Instance
            Instance.Velocity = (Instance.Position - p1.LastShotData.startPos).Unit * ((p1.LastShotData.Damage or 0) / p1.MaxHP) * 250
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
        local v1
        for i, j in p1.Model:GetDescendants() do
            if j:IsA("BasePart") then
                v1 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                TweenService:Create(j, v1, {Transparency = 1}):Play()
            elseif not (j:IsA("Texture")) and not (j:IsA("Decal")) then
                if j:IsA("Frame") then
                    if j:IsA("TextLabel") then
                        v1 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                        TweenService:Create(j, v1, {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
                    end
                    v1 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    TweenService:Create(j, v1, {BackgroundTransparency = 1}):Play()
                elseif not (j:IsA("TextLabel")) then
                end
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
        local v1 = u113[p4]
        if v1 == Sound then
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
    local CurrentEffects
    if p1.CurrentEffects then
        CurrentEffects = p1.CurrentEffects
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
    local v1
    if p1._Destroyed or p1.IsDead or not p1.HRP then
        return
    end
    if p1.GroundPositionCorrectionDisabled then
        v1 = p1.HRP.CFrame.Rotation + p2
    else
        local v2 = Vector3.new(0, -p1.Height * 1.5, 0)
        local v3 = workspace:Raycast(p2, v2, u108:GetAltRaycastParams())
        if not v3 then
            v1 = p1.HRP.CFrame.Rotation + p2
        else
            v1 = p1.HRP.CFrame.Rotation + v3.Position + Vector3.new(0, p1.Height, 0)
        end
    end
    p1.MoveTo = v1.p
    if not p1.Spawned then
        if not p1.HRP.Parent then
            p1:GenerateModel()
        end
        p1:Spawn(v1)
    elseif p1.HRP.Parent then
    end
    if p1.Spawned then
        local pastPositions = p1.pastPositions
        table.insert(pastPositions, v1.p)
        if 2 < #pastPositions then
            table.remove(pastPositions, 1)
        end
        if #pastPositions == 2 then
            local v4 = v1.p - Vector3.new(0, v1.p.Y, 0)
            p1.Speed = ((v4 - (pastPositions[1] - Vector3.new(0, pastPositions[1].Y, 0))) / 0.1).Magnitude
            p1.LastSpeedCheck = os.clock() + 0.25
            local Unit = (v4 - (p1.HRP.Position - Vector3.new(0, p1.HRP.Position.Y, 0))).Unit
            if not p1.RotateTowards and not p1.AlignDirection and 1 < p1.Speed then
                local v5 = CFrame.new(p1.HRP.Position, p1.HRP.Position + Unit * 5)
                p1.Rotation = v5 - CFrame.new(p1.HRP.Position, p1.HRP.Position + Unit * 5).Position
            end
        end
    end
end
function u126.Rollback(p1, p2) -- Line: 1017
    print("BaseNPC:Rollback called for " .. p2 .. " SERVER HP " .. p1.HP .. " CLIENT HP ")
    p1.HP = p2
    p1.IsDead = false
    p1.Model.Parent = workspace.Zombies
    p1.AnimationTracks.Death:Stop()
    p1:UnRagdoll()
    p1.HealthChanged:Fire(p1.HP)
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
    if not PredictedDamageByUid then
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
        return
    else
        local v1 = math.abs(p2 - PredictedDamageByUid)
        if v1 <= math.max(0.5, PredictedDamageByUid * 0.03) then
            return
        end
    end
end
function u126.ServerShot(p1) end
function u126.AttackHit(p1) -- Line: 1049
    if p1.HitSFX and not p1.HitSFX.IsPlaying then
        p1.HitSFX:Play()
    end
end
function u126:Stun(p2) -- Line: 1055 -- upvalues: NPCs_Shared (val)
    local Attack
    if typeof(self.AnimationTracks.Attack) ~= "table" then
        self.AnimationTracks.Attack:Stop()
    else
        Attack = self.AnimationTracks.Attack
        local v1 = nil
        local v2 = nil
        for i, j in Attack, v1, v2 do
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
function u126.Attack(p1, p2, p3) -- Line: 1072 -- upvalues: GameState (val), u109 (ref), RunService (val), ParryEvent (val)
    if not p1.Spawned then
        return
    end
    task.defer(function() -- Line: 1076 -- upvalues: p1 (val), GameState (upval), u109 (upval), RunService (upval), p3 (val), ParryEvent (upval)
        local Attack
        if typeof(p1.AnimationTracks.Attack) ~= "table" then
            Attack = p1.AnimationTracks.Attack
        else
            Attack = p1.AnimationTracks.Attack[math.random(#p1.AnimationTracks.Attack)]
        end
        Attack:Play(nil, nil, (p1.AnimationInfo.Attack.Speed or 1) * GameState.Data.Variables.ZombieAttackSpeed)
        local v1 = p1.AttackPrepareSound:Clone()
        v1.Parent = p1.HRP
        v1.PlaybackSpeed = GameState.Data.Variables.ZombieAttackSpeed
        v1:Play()
        game.Debris:AddItem(v1, 2)
        task.wait(p1.AttackWindup / GameState.Data.Variables.ZombieAttackSpeed)
        local v2 = p1.AttackSound:Clone()
        v2.Parent = p1.HRP
        v2:Play()
        game.Debris:AddItem(v2, 2)
        local Character = game.Players.LocalPlayer.Character
        if not Character or (Character.HumanoidRootPart.Position - p1.HRP.Position).Magnitude > 8 then
            return
        end
        if not u109 then
            local v3
            if not (RunService:IsClient()) then
                v3 = nil
            else
                v3 = require("@game/ReplicatedStorage/common/ZS_Framework/Modules/Controllers/WeaponController")
            end
            u109 = v3
        end
        local CanParry = p1.CanParry
        local CanBlock = p1.CanBlock
        local v4 = true
        if p3 then
            if p3.Unparriable ~= nil then
                CanParry = not p3.Unparriable
            end
            if p3.Unblockable ~= nil then
                CanBlock = not p3.Unblockable
            end
            if p3.DontParryStun ~= nil then
                v4 = not p3.DontParryStun
            end
        end
        if not CanParry or not u109.Parrying then
            if CanBlock and u109.Blocking then
                u109:Blocked()
            end
            return
        end
        ParryEvent:FireServer(p1.UID)
        if v4 then
            p1:Stun()
        end
        game.Debris:AddItem(v2, 2)
        u109:Parried()
    end)
end
if RunService:IsClient() then
    DamageIndicator_Util.Init()
    u72.SettingsChanged:Connect(function() -- Line: 1143 -- upvalues: u111 (val), peek (val), u72 (val), DamageIndicator_Util (val)
        local High, Medium, v1, v2, v3
        local v4 = u111
        local v5 = nil
        local v6 = nil
        for i, j in v4, v5, v6 do
            v1 = peek(u72.Graphics.ZombieQuality)
            if v1 <= 3 then
                High = j.High
                v2 = nil
                v3 = nil
                for k, n in High, v2, v3 do
                    n:Destroy()
                end
            end
            v1 = peek(u72.Graphics.ZombieQuality)
            if v1 <= 2 then
                Medium = j.Medium
                v2 = nil
                v3 = nil
                for m, i5 in Medium, v2, v3 do
                    i5:Destroy()
                end
            end
        end
        DamageIndicator_Util.Init()
    end)
end
return u126