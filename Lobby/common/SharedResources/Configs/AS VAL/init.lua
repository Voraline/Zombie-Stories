local v1 = {
    FireMode = {"Auto", "Semi-Auto"},
    DelayPerShot = 0.06666666666666667,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.5,
    DrawSpeed = 1.2,
    HolsterSpeed = 1.2,
    Penetration = 0,
    Damage = 31,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 2.32},
    DamageDropoff = {
        {Distance = 10, Damage = 31},
        {Distance = 25, Damage = 28},
        {Distance = 50, Damage = 24},
        {Distance = 100, Damage = 17},
    },
    ShootSingle = {SoundId = "122265239756151", Volume = 0.7},
}
local v2 = {}
v2["0"] = {
    {SoundId = "13595024683", Volume = 0.1},
}
v1.LayeredSFXs = v2
v1.KeyFrameSounds = {
    BoltBack = {SoundId = "6977615287", Volume = 0.5},
    BoltForward = {SoundId = "6977615739", Volume = 0.5},
    MagOut = {SoundId = "18608024236", Volume = 0.5},
    MagIn = {SoundId = "109497761089392", Volume = 0.5},
}
v1.DeploySFX = nil
v1.AutoLoop = nil
v1.AutoLoopTail = nil
v1.Ammo = 20
v1.StoredAmmo = 220
v1.BaseSpread = 0.15707963267948966
v1.ADSSpreadReduction = 0.2
v1.ReloadTime = 1.8
v1.EmptyReloadTime = 3
v1.ReloadTimeScale = 1
v1.EmptyReloadTimeScale = 1
v1.FirstDrawAnimation = "ReloadEmpty"
v1.FirstDrawAnimationTime = 1
v1.VerticalRecoil = 2.2
v1.HorizontalRecoil = 3.1
v1.IsAPistol = false
v1.UsePistolIcon = false
v1.BulletCasing = "rifle"
v1.WorldScaleValue = 1
v1.MuzzleModule = "Overheat"
v1.EquippedWalkspeedChange = 0
v1.HolsteredWalkspeedChange = 0
v1.EquippedWalkspeedMultiplier = 1.03
v1.HolsteredWalkspeedMultiplier = 1
v1.FirstDrawAnimation = nil
v1.FirstDrawAnimationTime = nil
v1.DrawAnimation = nil
v1.DrawAnimationTime = nil
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 0.5
v1.Offset = CFrame.new()
local v3 = CFrame.new(0.2, 0.2, 0)
v1.SprintOffset = v3 * CFrame.Angles(-0.5, 0.2, 0)
local v4 = CFrame.new(-0.003, 0.03, 0)
v3 = v4 * CFrame.Angles(-0.005235987755982988, -0.0008726646259971648, 0)
v1.AimOffset = v3 * CFrame.new(0, 0, 0.2)
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/ASVAL_Mods")
return v1