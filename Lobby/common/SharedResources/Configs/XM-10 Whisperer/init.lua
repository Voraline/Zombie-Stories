local v1 = {
    Ammo = 42,
    StoredAmmo = 252,
    AmmoType = nil,
    Damage = 18,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 1.95},
    Penetration = 0,
    PenetrationReduction = 0.5,
    FireMode = {"Auto"},
    DelayPerShot = 0.04,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.2,
    DrawSpeed = 0.6,
    HolsterSpeed = 0.6,
    Lense = true,
    ReloadTime = 2.70875,
    ReloadTimeScale = 0.85,
    EmptyReloadTime = 3.875,
    EmptyReloadTimeScale = 0.85,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1.08,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.07853981633974483,
    CrouchSpreadReduction = 0.8,
    ProneSpreadReduction = 0.5,
    ADSSpreadReduction = 0.82,
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
}
local v2 = {}
v2["0"] = {
    {SoundId = "14008310937", Volume = 2},
}
v1.LayeredSFXs = v2
v1.ShootSingle = {SoundId = "13983549640", Volume = 0.4}
v1.HasSuppressor = true
v1.MuzzleModule = "LogicHeat"
v1.SuppressorShootSingle = {SoundId = "6784293060", Volume = 0.5}
v1.AutoLoop = nil
v1.AutoLoopTail = nil
v1.KeyFrameSounds = {
    bolt_back = {SoundId = "485605520", Volume = 0.5},
    bolt_forward = {SoundId = "485605588", Volume = 0.5},
    mag_in = {SoundId = "543803337", Volume = 0.5},
    mag_out = {SoundId = "399221445", Volume = 0.5},
}
v1.DeploySFX = nil
v1.IsAPistol = true
v1.UsePistolIcon = true
v1.BulletCasing = "pistol"
v1.WorldScaleValue = 1
v1.NewSkinsSystem = false
v1.NewSkinsSystemBlacklist = {}
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 0.5
v1.Offset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(0.75, -0.150000006, 0, 0.696706712, 0, 0.717356086, -0.142516658, 0.980066597, 0.138414249, -0.703056753, -0.198669329, 0.682818949)
v1.AimOffset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.VerticalRecoil = 2.9
v1.HorizontalRecoil = 4.2
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/MAC10_Mods")
return v1