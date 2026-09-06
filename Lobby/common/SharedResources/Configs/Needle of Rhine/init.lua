local v1 = {
    Ammo = 20,
    StoredAmmo = 120,
    AmmoType = nil,
    Damage = 30,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = -2},
    Penetration = 10,
    PenetrationReduction = 1.2,
    FireMode = {"Auto"},
    DelayPerShot = 0.1348314606741573,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.5,
    DrawSpeed = 2,
    HolsterSpeed = 2,
    ReloadTime = 3.5,
    ReloadTimeScale = 0.5,
    EmptyReloadTime = 3.5,
    EmptyReloadTimeScale = 0.5,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.11344640137963143,
    CrouchSpreadReduction = nil,
    ProneSpreadReduction = nil,
    ADSSpreadReduction = 0.6,
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
    {SoundId = "18945493793", Volume = 0.5},
}
v1.LayeredSFXs = v2
v1.ShootSingle = {SoundId = "18945493793", Volume = 0.7}
v1.AutoLoop = nil
v1.AutoLoopTail = nil
v1.KeyFrameSounds = {
    grab = {SoundId = "5251447931", Volume = 0.5},
    mag_out = {SoundId = "6978733711", Volume = 0.5},
    mag_in = {SoundId = "6978733711", Volume = 0.5},
}
v1.DeploySFX = nil
v1.IsAPistol = true
v1.UsePistolIcon = false
v1.BulletCasing = "rifle"
v1.WorldScaleValue = 1
v1.NewSkinsSystem = false
v1.NewSkinsSystemBlacklist = {}
v1.DynamicFOVOffsetConstant = 3
v1.AimDynamicFOVOffsetConstant = 0.5
v1.Offset = CFrame.new(0.600000024, -0.300000012, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(0.200000003, 0.300000012, -0.25, 0.950563848, -0.0953745097, 0.295520216, -0.0533600524, 0.887342751, 0.45801273, -0.305910408, -0.451139301, 0.838386655)
v1.AimOffset = CFrame.new(0, 0, 0.300000012, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.VerticalRecoil = 6
v1.HorizontalRecoil = 9
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Base")
return v1