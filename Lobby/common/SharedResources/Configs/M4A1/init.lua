local v1 = {
    Ammo = 30,
    StoredAmmo = 240,
    AmmoType = nil,
    Damage = 25,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 1.5},
    Penetration = 0,
    PenetrationReduction = 0.5,
    FireMode = {"Auto"},
    DelayPerShot = 0.075,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1,
    DrawSpeed = 1,
    HolsterSpeed = 1,
    ReloadTime = 2.617,
    ReloadTimeScale = 1,
    EmptyReloadTime = 2.983,
    EmptyReloadTimeScale = 1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.07853981633974483,
    CrouchSpreadReduction = 0.7,
    ProneSpreadReduction = 0.5,
    ADSSpreadReduction = 0.2,
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
    ShootSingle = {SoundId = "6472969898", Volume = 0.35},
    AutoLoop = nil,
    AutoLoopTail = nil,
    KeyFrameSounds = {
        mag_in = {SoundId = "1599278493", Volume = 0.5},
        mag_out = {SoundId = "306684817", Volume = 0.5},
        bolt_press = {SoundId = "1599278764", Volume = 0.5},
    },
    DeploySFX = nil,
    IsAPistol = false,
    UsePistolIcon = false,
    BulletCasing = "rifle",
    WorldScaleValue = 0.6575323779596,
    NewSkinsSystem = true,
}
local v2 = {}
v2["Tech M4A1"] = true
v2["Merica Defender"] = true
v2["Abyss Lurker M4A1"] = true
v1.NewSkinsSystemBlacklist = v2
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 1.5
v1.Offset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(0.5, -0.100000001, -0.300000012, 0.764842212, 0, 0.64421767, -0.127986297, 0.980066597, 0.151950687, -0.631376207, -0.198669329, 0.749596298)
v1.AimOffset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.VerticalRecoil = 2.7
v1.HorizontalRecoil = 2
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/AR15_Mods")
return v1