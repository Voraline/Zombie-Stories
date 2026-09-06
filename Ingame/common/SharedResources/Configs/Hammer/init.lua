local v1 = {
    Damage = 150,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 1.4},
    Penetration = 1,
    PenetrationReduction = 0.5,
    MaxEnemiesPerSwing = 4,
    MaxHitsPerEnemy = 1,
    StaminaRequired = 12,
    StaminaUsed = 12,
    DelayPerShot = 0.8,
    HeavyDelayPerShot = 1.5,
    SwingStart = 0.4,
    SwingEnd = 0.6,
    SwingComboEnd = 1.9,
    HeavyStaminaRequired = 200,
    HeavyStaminaCost = 10,
    HeavySwingStart = 0.3,
    HeavySwingEnd = 1,
    HeavyChargeStaminaDrain = 0.25,
    ChargeTime = 0.5,
    BlockStaminaDrain = 0.1,
    ParryWindow = 0.2,
    BlockReduction = 0.5,
    ADSSpeed = 1,
    DrawSpeed = 1.5,
    HolsterSpeed = 1.5,
    IsMelee = true,
    HitRegLeniency = 10,
    SwingData = {
        Swing1 = {
            start = 0.4,
            num_rays = 20,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 9,
            min_dist = 8.5,
            yaw = -120,
            pitch = 0,
            direction = -1,
        },
        Swing2 = {
            start = 0.4,
            num_rays = 20,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 9,
            min_dist = 8.5,
            yaw = 120,
            pitch = 0,
            direction = -1,
        },
    },
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    FirstDrawAnimation = nil,
    FirstDrawAnimationTime = nil,
    DrawAnimation = nil,
    DrawAnimationTime = nil,
    KeyFrameSounds = {
        Swing = {SoundId = "6767836089", Volume = 0.5},
    },
    UnequipSFX = {SoundId = "481731911", Volume = 0.5},
    DeploySFX = {SoundId = "5752235534", Volume = 0.5},
    HitSFX = {ID = "3521554607", PlaybackSpeed = 0.9, Volume = 0.75},
    BlockSFX = {SoundId = "9125670740", Volume = 0.5},
    StartBlockSFX = {SoundId = "9116844753", Volume = 0.5},
    NewSkinsSystem = false,
    NewSkinsSystemBlacklist = {},
    Parried = function(p1) -- Line: 144
        local Parry = p1.Viewmodel.Model.KeyParts.Parry
        Parry.ParrySparks:Emit(math.random(10, 25))
        Parry.Attachment.ParryLargeSparkParticles:Emit(1)
    end,
    Blocked = function(p1) -- Line: 150
        p1.Viewmodel.Model.KeyParts.Parry.ParrySparks:Emit(math.random(10, 25))
    end,
    DynamicFOVOffsetConstant = 3,
    Offset = CFrame.new(),
    SprintOffset = CFrame.new(),
    CrouchAnimation = CFrame.new(),
}
local v2 = CFrame.new(0, 0, 0)
v1.BlockOffset = v2 * CFrame.Angles(0.17453292519943295, 0, 0.05235987755982989)
v2 = CFrame.new(0, -2, 3)
v1.HolsterCF = v2 * CFrame.Angles(-0.4363323129985824, 0, 0)
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Hammer_Mods")
return v1