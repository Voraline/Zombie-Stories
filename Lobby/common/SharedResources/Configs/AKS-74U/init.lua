return {
    Ammo = 30,
    StoredAmmo = 240,
    AmmoType = nil,
    Damage = 22,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 1.5},
    Penetration = 0,
    PenetrationReduction = 0.5,
    FireMode = {"Auto"},
    DelayPerShot = 0.08163265306122448,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 2,
    DrawSpeed = 1.3,
    HolsterSpeed = 1.4,
    ReloadTime = 1.5,
    ReloadTimeScale = 1.5,
    EmptyReloadTime = 1.8,
    EmptyReloadTimeScale = 1.5,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1.2,
    HolsteredWalkspeedMultiplier = 1.01,
    BaseSpread = 0.09599310885968812,
    CrouchSpreadReduction = nil,
    ProneSpreadReduction = nil,
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
    ShootSingle = {SoundId = "9096224565", Volume = 0.25},
    AutoLoop = nil,
    AutoLoopTail = nil,
    KeyFrameSounds = {
        bolt_back = {SoundId = "167077275", Volume = 0.5},
        mag_out = {SoundId = "306684229", Volume = 0.5},
        mag_in = {SoundId = "306684202", Volume = 0.5},
    },
    DeploySFX = nil,
    IsAPistol = false,
    UsePistolIcon = false,
    BulletCasing = "rifle",
    WorldScaleValue = 0.72590791877556,
    NewSkinsSystem = false,
    NewSkinsSystemBlacklist = {},
    OnKeyframeReached = function(p1, p2) -- Line: 132
        if p1 == "mag_in" then
            task.delay(0.02, function() -- Line: 134 -- upvalues: p2 (val)
                if p2 and not p2.IsDestroyed then
                    p2.Viewmodel.Model.KeyParts.Mag2Real.Transparency = 1
                    for i, j in p2.Viewmodel.Model.KeyParts.Mag2Real:GetDescendants() do
                        if j:IsA("BasePart") then
                            j.Transparency = 1
                        end
                    end
                end
            end)
        end
    end,
    OnWeaponReload = function(p1) -- Line: 147
        if p1.Ammo <= 0 then
            task.delay(0.1, function() -- Line: 149 -- upvalues: p1 (val)
                if p1 and not p1.Destroyed then
                    if tostring(p1.Viewmodel.Model.KeyParts.Mag2Real.Color) ~= "1, 1, 1" then
                        p1.Viewmodel.Model.KeyParts.Mag2Real.Transparency = 0
                    end
                    for i, j in p1.Viewmodel.Model.KeyParts.Mag2Real:GetDescendants() do
                        if j:IsA("BasePart") then
                            j.Transparency = 0
                        end
                    end
                end
            end)
        end
    end,
    DynamicFOVOffsetConstant = 4,
    AimDynamicFOVOffsetConstant = 0.1,
    Offset = CFrame.new(-0.349999994, -0.0500000007, 0.400000006, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    SprintOffset = CFrame.new(1.29999995, -0.100000001, 0, 0.696706712, 0, 0.717356086, -0.142516658, 0.980066597, 0.138414249, -0.703056753, -0.198669329, 0.682818949),
    AimOffset = CFrame.new(0, 0, 0.25, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    VerticalRecoil = 2,
    HorizontalRecoil = 2.1,
    AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Base"),
}