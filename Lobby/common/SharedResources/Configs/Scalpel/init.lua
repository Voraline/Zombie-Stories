local v1 = {
    Damage = 20,
    Multipliers = {Arms = 2, Torso = 1, Legs = 3, Head = 2},
    Penetration = 1,
    PenetrationReduction = 0.5,
    MaxEnemiesPerSwing = 2,
    MaxHitsPerEnemy = 2,
    StaminaRequired = 3,
    StaminaUsed = 3,
    DelayPerShot = 0.4,
    HeavyDelayPerShot = 0.6,
    SwingAnimationTimeScale = 1.25,
    SwingStart = 0.21000000000000002,
    SwingEnd = 0.26249999999999996,
    SwingComboEnd = 0.75,
    HeavyStaminaRequired = 5,
    HeavyStaminaCost = 5,
    HeavySwingStart = 0.1,
    HeavySwingEnd = 0.25,
    HeavyChargeStaminaDrain = 0,
    ChargeTime = 0.2,
    BlockStaminaUse = 3,
    BlockStaminaRequired = 3,
    BlockStaminaDrain = 0,
    BlockCooldown = 0.1,
    ParryWindow = 0.25,
    BlockReduction = 0.75,
    ADSSpeed = 1,
    DrawSpeed = 3,
    HolsterSpeed = 1.5,
    IsMelee = true,
    HitRegLeniency = 8,
    SwingData = {
        Swing1 = {
            start = 0.2,
            num_rays = 20,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 7,
            min_dist = 6,
            yaw = -30,
            pitch = 30,
            direction = -1,
        },
        Swing2 = {
            start = 0.2,
            num_rays = 20,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 7,
            min_dist = 6,
            yaw = 30,
            pitch = 30,
            direction = -1,
        },
        HeavySwing = {
            start = 0.1,
            num_rays = 3,
            raysbeforedelay = 1,
            delaytime = 0.03,
            max_dist = 8,
            min_dist = 8,
            yaw = 0,
            pitch = -5,
            direction = 1,
        },
        HeavySwing2 = {
            start = 0.1,
            num_rays = 3,
            raysbeforedelay = 1,
            delaytime = 0.03,
            max_dist = 8,
            min_dist = 8,
            yaw = 0,
            pitch = -5,
            direction = 1,
        },
    },
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1.25,
    HolsteredWalkspeedMultiplier = 1,
    FirstDrawAnimation = nil,
    FirstDrawAnimationTime = nil,
    DrawAnimation = "Equip",
    DrawAnimationTime = 0,
    KeyFrameSounds = {
        Slash = {SoundId = "8880136011", Volume = 0.5},
        Swing = {SoundId = "6241709963", Volume = 0.5},
        ChargeSlash1 = {SoundId = "8880136011", Volume = 0.5},
        ChargeSlash2 = {SoundId = "8880136011", Volume = 0.5},
        ChargeSlash3 = {SoundId = "8880136011", Volume = 0.5},
        Charge = {SoundId = "9125407249", Volume = 0.5},
    },
    UnequipSFX = {SoundId = "481731911", Volume = 0.5},
    DeploySFX = {SoundId = "5752235534", Volume = 0.5},
    HitSFX = {ID = "5989945551", PlaybackSpeed = 0.8},
    BlockSFX = {SoundId = "1194860475", Volume = 0.5},
    StartBlockSFX = {SoundId = "9116844753", Volume = 0.5},
    NewSkinsSystem = false,
    NewSkinsSystemBlacklist = {},
    WorldScaleValue = 0.9,
}
local v2 = {}
v2["Left Arm"] = true
v2["Left Shoulder"] = true
v1.ArmIgnores = v2
function v1.Parried(p1) -- Line: 201
    local Parry = p1.Viewmodel.Model.KeyParts.Parry
    Parry.ParrySparks:Emit(math.random(10, 25))
    Parry.Attachment.ParryLargeSparkParticles:Emit(1)
end
function v1.Blocked(p1) -- Line: 207
    p1.Viewmodel.Model.KeyParts.Parry.ParrySparks:Emit(math.random(10, 25))
end
v1.Offset = CFrame.new(-0.400000006, 0.400000006, 0, 0.97522366, 0.13705875, -0.173648253, -0.139173105, 0.990268052, 0, 0.171958312, 0.024167167, 0.98480773)
v1.ReplicationOffset = v1.Offset
v1.SprintOffset = CFrame.new()
v1.CrouchAnimation = CFrame.new()
local v3 = CFrame.new(0, -1.7, 0)
v1.BlockOffset = v3 * CFrame.Angles(1.1423973285781066, 0, -1.5707963267948966)
v3 = CFrame.new(0, -2, 3)
v1.HolsterCF = v3 * CFrame.Angles(-0.4363323129985824, 0, 0)
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/BaseMelee")
return v1