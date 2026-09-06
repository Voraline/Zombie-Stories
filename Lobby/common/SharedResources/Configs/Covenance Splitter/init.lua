local u2 = require("@game/ReplicatedStorage/common/PlayerHandler")
local v1 = {
    Damage = 42,
    Multipliers = {Arms = 1.3, Torso = 1.5, Legs = 2, Head = 0.4},
    Penetration = 2,
    PenetrationReduction = 1.3,
    MaxEnemiesPerSwing = 2,
    MaxHitsPerEnemy = 2,
    StaminaRequired = 6,
    StaminaUsed = 6,
    DelayPerShot = 0.35,
    HeavyDelayPerShot = 0.5,
    SwingStart = 0.1,
    SwingEnd = 0.3,
    SwingComboEnd = 3.5,
    HeavyStaminaRequired = 55,
    HeavyStaminaCost = -20,
    HeavySwingStart = 0.2,
    HeavySwingEnd = 1,
    HeavyChargeStaminaDrain = 0.15,
    ChargeTime = 2,
    BlockStaminaDrain = 0.25,
    BlockStaminaUse = 15,
    BlockStaminaRequired = 75,
    BlockCooldown = 0.5,
    ParryWindow = 0.25,
    BlockReduction = 1.5,
    ADSSpeed = 1,
    DrawSpeed = 10,
    HolsterSpeed = 15,
    IsMelee = true,
    UseBlockAnimation = true,
    HitRegLeniency = 10,
    SwingData = {
        Swing1 = {
            start = 0.2,
            num_rays = 40,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 6,
            min_dist = 6,
            yaw = -70,
            pitch = 0,
            direction = -1,
        },
        Swing2 = {
            start = 0.2,
            num_rays = 40,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 8,
            min_dist = 8,
            yaw = 70,
            pitch = 0,
            direction = -1,
        },
        HeavySwing = {
            start = 0.3,
            num_rays = 20,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 14,
            min_dist = 8,
            yaw = -70,
            pitch = 70,
            direction = -1,
        },
        HeavySwing2 = {
            start = 0.3,
            num_rays = 20,
            raysbeforedelay = 4,
            delaytime = 0.01,
            max_dist = 14,
            min_dist = 8,
            yaw = 70,
            pitch = 70,
            direction = -1,
        },
    },
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1.35,
    HolsteredWalkspeedMultiplier = 1.1,
    FirstDrawAnimation = nil,
    FirstDrawAnimationTime = nil,
    DrawAnimation = nil,
    DrawAnimationTime = nil,
    KeyFrameSounds = {
        Slash = {SoundId = "9103662102", Volume = 0.5},
        Swing = {SoundId = "9103662819", Volume = 0.5},
        HeavySwing = {SoundId = "7453869722", Volume = 0.5},
        Charge = {SoundId = "9125407249", Volume = 0.5},
    },
    UnequipSFX = {SoundId = "201858168", Volume = 0.5},
    DeploySFX = {SoundId = "9103661541", Volume = 0.5},
    HitSFX = {ID = "9103662819", PlaybackSpeed = 0.8, Volume = 0.75},
    BlockSFX = {SoundId = "9125670740", Volume = 0.5},
    StartBlockSFX = {SoundId = "9116844753", Volume = 0.5},
    NewSkinsSystem = false,
    NewSkinsSystemBlacklist = {},
    WorldScaleValue = 0.81,
    Parried = function(p1) -- Line: 189
        local Parry = p1.Viewmodel.Model.KeyParts.Parry
        Parry.ParrySparks:Emit(math.random(10, 25))
        Parry.Attachment.ParryLargeSparkParticles:Emit(1)
    end,
    SWEPParried = function(p1, p2) -- Line: 195 -- upvalues: u2 (val)
        if p2 then
            local PlayerState = u2:GetPlayerState(p1)
            if PlayerState and PlayerState.HP < PlayerState.MaxHP then
                PlayerState:Heal(5)
            end
        end
    end,
    Blocked = function(p1) -- Line: 204
        p1.Viewmodel.Model.KeyParts.Parry.ParrySparks:Emit(math.random(10, 25))
    end,
    DynamicFOVOffsetConstant = 3,
    Offset = CFrame.new(),
    SprintOffset = CFrame.new(),
    CrouchAnimation = CFrame.new(),
    BlockOffset = CFrame.new(),
}
local v2 = CFrame.new(0, -2, 3)
v1.HolsterCF = v2 * CFrame.Angles(-0.4363323129985824, 0, 0)
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/BaseMelee")
return v1