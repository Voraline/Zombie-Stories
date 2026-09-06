local v1 = {
    Ammo = 4,
    StoredAmmo = 40,
    AmmoType = nil,
    Damage = 18,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 1.82},
    Penetration = 0,
    PenetrationReduction = 0.5,
    DamageDropoff = {
        {Distance = 10, Damage = 17},
        {Distance = 50, Damage = 13},
        {Distance = 50, Damage = 8},
        {Distance = 100, Damage = 5},
    },
    FireMode = {"Pump Action"},
    DelayPerShot = 0.6,
    PrimeAction = true,
    BoltAnimationTime = 1.2,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.3,
    DrawSpeed = 1.3,
    HolsterSpeed = 1.3,
    BulletsPerShot = 12,
    UsesLoadLoop = true,
    ShouldNotCycleAfterReload = true,
    LoadStartEmptyAnimationTime = 1.8,
    LoadStartEmptyTime = 1.8,
    LoadStartEmptyInsertTime = 0.8,
    LoadStartAnimationTime = 0.5,
    LoadStartTime = 0.5,
    LoadStopAnimationTime = 0.5,
    LoadStopTime = 0.5,
    InsertTime = 0.4,
    IncrAmmoCountTime = 0.1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.3141592653589793,
    CrouchSpreadReduction = nil,
    ProneSpreadReduction = nil,
    ADSSpreadReduction = 0.65,
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
    ShootSingle = {SoundId = "6839481031", Volume = 0.25},
}
local v2 = {}
v2["0"] = {
    {SoundId = "7529022688", Volume = 0.6},
}
v1.LayeredSFXs = v2
v1.SuppressorShootSingle = {SoundId = "9325905648", Volume = 1.2}
v1.AutoLoop = nil
v1.AutoLoopTail = nil
v1.KeyFrameSounds = {
    pump_back = {SoundId = "3299747822", Volume = 0.5},
    e_back = {SoundId = "4993319040", Volume = 0.5},
    e_forward = {SoundId = "4993319579", Volume = 0.5},
    ins_shell = {SoundId = "6001410744", Volume = 0.5},
}
v1.DeploySFX = nil
v1.ShellOn = "pump_back"
v1.IsAPistol = true
v1.UsePistolIcon = false
v1.BulletCasing = "shotgun"
v1.WorldScaleValue = 0.9
v1.NewSkinsSystem = false
v1.NewSkinsSystemBlacklist = {}
v1.IsShotgun = true
v1.DynamicFOVOffsetConstant = 3
v1.AimDynamicFOVOffsetConstant = -0.5
v1.Offset = CFrame.new(0, 0, 0)
local v3 = CFrame.new(0.2, 0.3, -0.25)
v1.SprintOffset = v3 * CFrame.Angles(-0.5, 0.3, 0.1)
v1.AimOffset = CFrame.new(0.563085556, -0.08, 0.3)
v1.VerticalRecoil = 15.52
v1.HorizontalRecoil = 19
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/BaseShotgun")
return v1