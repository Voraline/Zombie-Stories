local v1 = {
    Ammo = 22,
    StoredAmmo = 150,
    AmmoType = nil,
    Damage = 5,
    Multipliers = {Arms = 0.9, Torso = 1, Legs = 0.9, Head = 1.85},
    BulletsPerShot = 18,
    Penetration = 4,
    PenetrationReduction = 0.5,
    IsShotgun = true,
    MuzzleModule = "RedLaser",
    FireMode = {"Burst"},
    DelayPerShot = 0.14457831325301204,
    BurstAmt = 3,
    BurstDelay = 0.125,
    ADSSpeed = 1.15,
    DrawSpeed = 1.1,
    HolsterSpeed = 1.2,
    ReloadTime = 2.76,
    ReloadTimeScale = 0.8,
    EmptyReloadTime = 3.3,
    EmptyReloadTimeScale = 1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.017453292519943295,
    CrouchSpreadReduction = 0.3,
    ProneSpreadReduction = nil,
    ADSSpreadReduction = 19,
    MovementSpread = nil,
    AirSpread = nil,
    SlidingSpread = nil,
    DivingSpread = nil,
    ShootingSpreadIncrement = nil,
    ShootingSpreadDecay = nil,
    FirstDrawAnimation = nil,
    FirstDrawAnimationTime = nil,
    DrawAnimation = nil,
    DrawAnimationTime = nil,
    ShootSingle = {SoundId = "12978117827", Volume = 2.5},
}
local v2 = {}
v2["0"] = {
    {SoundId = "12978125162", Volume = 2},
    {SoundId = "13037219872", Volume = 2},
}
v1.LayeredSFXs = v2
v1.SuppressorShootSingle = {SoundId = "11869837921", Volume = 0.32}
v1.AutoLoop = nil
v1.AutoLoopTail = nil
v1.KeyFrameSounds = {
    mag_in = {SoundId = "485606098", Volume = 0.5},
    mag_out = {SoundId = "485606144", Volume = 0.5},
    bolt_back = {SoundId = "7014999488", Volume = 0.5},
    bolt_forward = {SoundId = "7015000110", Volume = 0.5},
}
v1.DeploySFX = {SoundId = "485606203", Volume = 0.4}
v1.IsAPistol = false
v1.UsePistolIcon = true
v1.BulletCasing = "pistol"
v1.WorldScaleValue = 1
v1.NewSkinsSystem = false
v1.NewSkinsSystemBlacklist = {}
v1.LODModel = "DefaultSMG"
v1.DynamicFOVOffsetConstant = 1.5
v1.AimDynamicFOVOffsetConstant = 1
v1.Offset = CFrame.new()
v1.SprintOffset = CFrame.new(0.75, -0.0500000007, -0.0500000007, 0.696706712, 0, 0.717356086, -0.142516658, 0.980066597, 0.138414249, -0.703056753, -0.198669329, 0.682818949)
v1.AimOffset = CFrame.new(0, 0, 0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.RecoilRollSpeed = 5
v1.VerticalRecoil = 15.18
v1.HorizontalRecoil = 8.1
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/BaseSMG")
return v1