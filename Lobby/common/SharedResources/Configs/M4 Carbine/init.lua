local v1 = {
    Ammo = 30,
    StoredAmmo = 240,
    AmmoType = nil,
    Damage = 26,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 1.5},
    Penetration = 0,
    PenetrationReduction = 0.5,
    FireMode = {"Burst", "Semi-Auto"},
    DelayPerShot = 0.075,
    BurstAmt = 3,
    BurstDelay = 0.12,
    ADSSpeed = 1.4,
    DrawSpeed = 1.1,
    HolsterSpeed = 1.1,
    ReloadTime = 2.2,
    ReloadTimeScale = 1,
    EmptyReloadTime = 2.42,
    EmptyReloadTimeScale = 1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.12217304763960307,
    CrouchSpreadReduction = 0.6,
    ProneSpreadReduction = 0.2,
    ADSSpreadReduction = 0.25,
    MovementSpread = nil,
    AirSpread = nil,
    SlidingSpread = nil,
    DivingSpread = nil,
    ShootingSpreadIncrement = nil,
    ShootingSpreadDecay = nil,
    FirstDrawAnimation = "ReloadEmpty",
    FirstDrawAnimationTime = 0.8,
    DrawAnimation = "Reload",
    DrawAnimationTime = 1.2,
    ShootSingle = {SoundId = "5631260448", Volume = 0.25},
    AutoLoop = nil,
    AutoLoopTail = nil,
    KeyFrameSounds = {
        slap = {SoundId = "2170412810", Volume = 0.5},
        mag_out = {SoundId = "306684817", Volume = 0.5},
        mag_in = {SoundId = "306684800", Volume = 0.5},
    },
    UnequipSFX = {SoundId = "8169233194", Volume = 0.5},
    DeploySFX = {SoundId = "8169246285", Volume = 0.5},
    IsAPistol = false,
    UsePistolIcon = false,
    BulletCasing = "rifle",
    WorldScaleValue = 0.92555051908921,
    NewSkinsSystem = true,
}
local v2 = {}
v2["Cobalt Disruption M4 Carbine"] = true
v2["Synthwave Rider M4 Carbine"] = true
v1.NewSkinsSystemBlacklist = v2
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 1.5
v1.Offset = CFrame.new(0, 0, 0.449999988, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(0, 0, -0.300000012, 0.962250173, -0.0841859728, 0.258819044, -0.0299755037, 0.912392259, 0.408217907, -0.270510703, -0.400565982, 0.875426054)
v1.AimOffset = CFrame.new(0, 0, 0.300000012, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.VerticalRecoil = 1.8
v1.HorizontalRecoil = 2
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/AR15_Mods")
return v1