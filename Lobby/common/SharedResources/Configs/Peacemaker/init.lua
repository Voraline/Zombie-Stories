local u0 = {
    Ammo = 6,
    StoredAmmo = 84,
    AmmoType = nil,
    Damage = 45,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 3.4},
    Penetration = 1,
    PenetrationReduction = 0.5,
    FireMode = {"Semi-Auto"},
    DelayPerShot = 0.3333333333333333,
    PrimeAction = true,
    BoltAnimationTime = 0.8,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.5,
    DrawSpeed = 1.15,
    HolsterSpeed = 1.15,
    UsesLoadLoop = true,
    ShouldNotCycleAfterReload = true,
    LoadStartAnimationTime = 0.3,
    LoadStartTime = 0.3,
    LoadStopAnimationTime = 0.67,
    LoadStopTime = 0.67,
    InsertTime = 0.8,
    IncrAmmoCountTime = 0.3,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1.05,
    HolsteredWalkspeedMultiplier = 1,
    AimWalkSpeedMultiplier = 1.25,
    BaseSpread = 0.06981317007977318,
    CrouchSpreadReduction = 1,
    ProneSpreadReduction = 1,
    ADSSpreadReduction = 1.55,
    MovementSpread = nil,
    AirSpread = nil,
    SlidingSpread = nil,
    DivingSpread = nil,
    ShootingSpreadIncrement = nil,
    ShootingSpreadDecay = nil,
    FirstDrawAnimation = "Equip",
    FirstDrawAnimationTime = 0,
    DrawAnimation = nil,
    DrawAnimationTime = nil,
    ShootSingle = {SoundId = "9119298681", Volume = 0.3},
    AutoLoop = nil,
    AutoLoopTail = nil,
    KeyFrameSounds = {
        hammer_down = {SoundId = "103700869904646", Volume = 0.3},
        normal_hammer_down = {SoundId = "103700869904646", Volume = 0.5},
        cylinder_close = {SoundId = "9117631258", Volume = 0.5},
        bullet_out = {SoundId = "95308929208021", Volume = 0.5},
        bullet_in = {SoundId = "504956429", Volume = 0.5},
        cylinder_open = {SoundId = "9116321026", Volume = 0.5},
    },
    DeploySFX = nil,
    IsAPistol = true,
    UsePistolIcon = false,
    BulletCasing = "pistol",
    WorldScaleValue = 1.0884040867415,
    NewSkinsSystem = false,
    NewSkinsSystemBlacklist = {},
    DynamicFOVOffsetConstant = 2,
    AimDynamicFOVOffsetConstant = 0.5,
    Offset = CFrame.new(0.100000001, 0.150000006, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    SprintOffset = CFrame.new(-0.300000012, 0, -0.300000012, 0.962250173, -0.0841859728, 0.258819044, -0.0299755037, 0.912392259, 0.408217907, -0.270510703, -0.400565982, 0.875426054),
    AimOffset = CFrame.new(0, 0.3, 0.140000001, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    CrouchAnimation = CFrame.new(-0.3, 0, 0),
}
local function GetShellTransparency(p1) -- Line: 167
    for k, v in pairs(p1:GetDescendants()) do
        if v:IsA("BasePart") then
            return v.Transparency
        end
    end
    return nil
end
local function SetShellTransparency(p1, p2) -- Line: 175
    for k, v in pairs(p1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = p2
        end
    end
end
local RunService = game:GetService("RunService")
function u0.CustomShootAnimation() end
function u0.OnEquipped(p1) -- Line: 189 -- upvalues: u0 (val), RunService (val)
    if p1.connection then
        return
    end
    local Viewmodel = p1.Viewmodel
    local Animations = Viewmodel.Animations
    local u4 = {Idle = Animations.Idle, Fire = Animations.Fire, FanIdle = Animations.FanIdle, FanFire = Animations.FanFire}
    u4.FanIdle.Looped = true
    u4.FanIdle.Priority = Enum.AnimationPriority.Core
    u4.FanIdle:Play(0, 0, 0)
    u4.FanFire.Priority = Enum.AnimationPriority.Action4
    function p1.Config.CustomShootAnimation() -- Line: 213 -- upvalues: p1 (val), u4 (val), Viewmodel (val)
        if p1.Aiming then
            u4.FanFire.Priority = Enum.AnimationPriority.Action4
            u4.FanIdle:AdjustWeight(1, 0.1)
            Viewmodel:StopAnimation("Pump")
            Viewmodel:PlayAnimation("FanFire", 0, 1, 1)
            return
        end
        p1.Viewmodel.Animations.Pump.Priority = Enum.AnimationPriority.Action3
        local BoltAnimationTime = p1.Config.BoltAnimationTime
        if not BoltAnimationTime then
            BoltAnimationTime = p1.Config.DelayPerShot
        end
        Viewmodel:PlayAnimation("Pump", 0, 1, Viewmodel.Animations.Pump.Length / BoltAnimationTime)
    end
    local DelayPerShot = u0.DelayPerShot
    local u28 = u0.DelayPerShot / 3
    p1.connection = RunService.RenderStepped:Connect(function(a1) -- Line: 238 -- upvalues: p1 (val), u28 (val), u4 (val), DelayPerShot (val)
        if p1.Aiming then
            p1.Config.DelayPerShot = u28
            u4.Idle:AdjustWeight(0, 0.1)
            u4.FanIdle:AdjustWeight(1, 0.1)
            p1.Config.PrimeAction = false
            return
        end
        p1.Config.DelayPerShot = DelayPerShot
        u4.Idle:AdjustWeight(1, 0.1)
        u4.FanIdle:AdjustWeight(0, 0.1)
        p1.Config.PrimeAction = true
    end)
    p1.Destroyed:Connect(function() -- Line: 252 -- upvalues: p1 (val)
        if p1.connection then
            p1.connection:Disconnect()
            p1.connection = nil
        end
    end)
end
u0.VerticalRecoil = 8
u0.HorizontalRecoil = 5
u0.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Revolver_Mods")
return u0