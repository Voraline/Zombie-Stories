local v1 = {
    Ammo = 12,
    StoredAmmo = 180,
    AmmoType = nil,
    Damage = 40,
    Multipliers = {Arms = 1, Torso = 0.7, Legs = 2, Head = 1.43},
    Penetration = 1,
    PenetrationReduction = 0.1,
    DamageDropoff = {
        {Distance = 3, Damage = 85},
        {Distance = 10, Damage = 40},
        {Distance = 50, Damage = 32},
        {Distance = 100, Damage = 32},
    },
    AimFOVMultiplier = 0.5,
    FireMode = {"Semi-Auto", "Burst"},
    MuzzleModule = "InsaneFlash",
    DelayPerShot = 0.12765957446808512,
    BurstAmt = 2,
    BurstDelay = 1e-07,
    ADSSpeed = 1.15,
    DrawSpeed = 1.75,
    HolsterSpeed = 1.75,
    ReloadTime = 1.1,
    ReloadTimeScale = 1,
    EmptyReloadTime = 1.7,
    EmptyReloadTimeScale = 1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 0.95,
    BaseSpread = 0.2617993877991494,
    CrouchSpreadReduction = nil,
    ProneSpreadReduction = nil,
    ADSSpreadReduction = 0.0001,
    MovementSpread = nil,
    AirSpread = nil,
    SlidingSpread = nil,
    DivingSpread = nil,
    ShootingSpreadIncrement = nil,
    ShootingSpreadDecay = nil,
    FirstDrawAnimation = "ReloadEmpty",
    FirstDrawAnimationTime = 1,
    DrawAnimation = "ReloadEmpty",
    DrawAnimationTime = 1,
    ShootSingle = {SoundId = "10511097438", Volume = 0.5},
    SuppressorShootSingle = {SoundId = "11952465151", Volume = 0.5},
}
local v2 = {}
v2["0"] = {
    {SoundId = "10934800433", Volume = 0.05},
}
v1.LayeredSFXs = v2
v1.AutoLoop = nil
v1.AutoLoopTail = nil
v1.DeploySFX = nil
v1.IsAPistol = false
v1.UsePistolIcon = true
v1.BulletCasing = "pistol"
v1.WorldScaleValue = 1
v1.NewSkinsSystem = false
v1.NewSkinsSystemBlacklist = {}
v1.UseAltCameraReload = true
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 0.5
v1.Offset = CFrame.new(0.0500000007, -0.0500000007, -0.200000003, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(-0.300000012, 0, -0.300000012, 0.962250173, -0.0841859728, 0.258819044, -0.0299755037, 0.912392259, 0.408217907, -0.270510703, -0.400565982, 0.875426054)
v1.AimOffset = CFrame.new(0, 0, 0.333, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.KeyFrameSounds = {
    MagOut = {4527563547, 0.5},
    MagIn = {4537252060, 0.5},
    BoltBack = {4527565140, 0.5},
}
v1.VerticalRecoil = 2
v1.HorizontalRecoil = 4
v1.Offset = CFrame.new()
local v3 = CFrame.new(0.2, 0.2, 0)
v1.SprintOffset = v3 * CFrame.Angles(-0.5, 0.2, 0)
v1.AimOffset = CFrame.new(0, 0, 0.5)
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/M2011_Mods")
return v1