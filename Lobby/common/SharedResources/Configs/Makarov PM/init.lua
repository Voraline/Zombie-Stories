local v1 = {
    Ammo = 8,
    StoredAmmo = 80,
    AmmoType = nil,
    Damage = 19,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 2},
    Penetration = 0,
    PenetrationReduction = 0.5,
    FireMode = {"Semi-Auto"},
    DelayPerShot = 0.13636363636363638,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1,
    DrawSpeed = 1,
    HolsterSpeed = 1,
    ReloadTime = 2.317,
    ReloadTimeScale = 1,
    EmptyReloadTime = 2.817,
    EmptyReloadTimeScale = 1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1.12,
    HolsteredWalkspeedMultiplier = 1.12,
    BaseSpread = 0.027925268031909273,
    CrouchSpreadReduction = nil,
    ProneSpreadReduction = nil,
    ADSSpreadReduction = 0.5,
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
    ShootSingle = {SoundId = "7529037524", Volume = 0.25},
    AutoLoop = nil,
    AutoLoopTail = nil,
    KeyFrameSounds = {
        mag_out_2 = {SoundId = "736285597", Volume = 0.5},
        mag_out_1 = {SoundId = "736285188", Volume = 0.5},
        mag_in = {SoundId = "736285539", Volume = 0.5},
        slide_release = {SoundId = "736285247", Volume = 0.5},
    },
    DeploySFX = nil,
    IsAPistol = true,
    UsePistolIcon = false,
    BulletCasing = "pistol",
    WorldScaleValue = 0.75,
    NewSkinsSystem = true,
}
local v2 = {}
v2["Apple Pie Makarov PM"] = true
v1.NewSkinsSystemBlacklist = v2
v1.UseAltCameraReload = true
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 0.5
v1.Offset = CFrame.new(0, 0, 0.200000003, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(-0.300000012, 0, -0.300000012, 0.962250173, -0.0841859728, 0.258819044, -0.0299755037, 0.912392259, 0.408217907, -0.270510703, -0.400565982, 0.875426054)
v1.AimOffset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.VerticalRecoil = 3
v1.HorizontalRecoil = 7
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/BasePistol")
return v1