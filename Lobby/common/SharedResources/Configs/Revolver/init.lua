return {
    Ammo = 6,
    StoredAmmo = 36,
    AmmoType = nil,
    Damage = 55,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 2},
    Penetration = 1,
    PenetrationReduction = 1,
    FireMode = {"Semi-Auto"},
    DelayPerShot = 0.6666666666666666,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.5,
    DrawSpeed = 1,
    HolsterSpeed = 1,
    ReloadTime = 2,
    ReloadTimeScale = 1,
    EmptyReloadTime = 2,
    EmptyReloadTimeScale = 1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.03490658503988659,
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
    ShootSingle = {SoundId = "6784287172", Volume = 0.3},
    AutoLoop = nil,
    AutoLoopTail = nil,
    KeyFrameSounds = {
        cylinder_close = {SoundId = "657519674", Volume = 0.5},
        bullets_out = {SoundId = "1252000087", Volume = 0.5},
        bullets_in = {SoundId = "504956429", Volume = 0.5},
        open_cylinder = {SoundId = "504956498", Volume = 0.5},
    },
    DeploySFX = nil,
    IsAPistol = true,
    UsePistolIcon = false,
    BulletCasing = "pistol",
    WorldScaleValue = 1.0884040867415,
    NewSkinsSystem = false,
    NewSkinsSystemBlacklist = {},
    DynamicFOVOffsetConstant = 2,
    AimDynamicFOVOffsetConstant = 0.5,
    Offset = CFrame.new(0.100000001, -0.150000006, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    SprintOffset = CFrame.new(
        -0.300000012,
        0,
        -0.300000012,
        0.962250173,
        -0.0841859728,
        0.258819044,
        -0.0299755037,
        0.912392259,
        0.408217907,
        -0.270510703,
        -0.400565982,
        0.875426054
    ),
    AimOffset = CFrame.new(0, 0, 0.100000001, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    CustomKF = function(p1, p2, p3) -- Line: 153
        local v1, v2
        local StoredAmmo = p3.StoredAmmo
        local Ammo = p3.Ammo
        if p1 == "shell_in" then
            for j = 1, 6 do
                if p2.KeyParts.Shells["Shell" .. j].Transparency == 1 then
                    v2 = p2.KeyParts.Shells["Shell" .. j]
                    v2.Transparency = 0
                    return
                end
            end
            return
        end
        if p1 == "loadStopStarted" then
            local v3
            local Shells = p2:WaitForChild("KeyParts"):WaitForChild("Shells")
            v1 = 6 - Ammo
            for i = 1, 6 do
                if not (Ammo < i) then
                    v3 = Shells["Shell" .. i]
                    v3.Transparency = 0
                else
                    v3 = Shells["Shell" .. i]
                    v3.Transparency = 1
                end
            end
            return
        end
        if p1 == "bullets_out2" then
            local Shells_2 = p2:WaitForChild("KeyParts"):WaitForChild("Shells")
            v1 = 6 - Ammo
            if Ammo < 1 then
                v2 = Shells_2["Shell" .. 1]
                v2.Transparency = 1
            end
            if Ammo < 2 then
                v2 = Shells_2["Shell" .. 2]
                v2.Transparency = 1
            end
            if Ammo < 3 then
                v2 = Shells_2["Shell" .. 3]
                v2.Transparency = 1
            end
            if Ammo < 4 then
                v2 = Shells_2["Shell" .. 4]
                v2.Transparency = 1
            end
            if Ammo < 5 then
                v2 = Shells_2["Shell" .. 5]
                v2.Transparency = 1
            end
            if Ammo < 6 then
                v2 = Shells_2["Shell" .. 6]
                v2.Transparency = 1
            end
        end
    end,
    CustomEquip = function(p1, p2) -- Line: 191
        local v1
        local Shells = p2:WaitForChild("KeyParts"):WaitForChild("Shells")
        local v2 = 6 - p1
        local v3 = p1
        for i = 1, 6 do
            if not (v3 < i) then
                v1 = Shells["Shell" .. i]
                v1.Transparency = 0
            else
                v1 = Shells["Shell" .. i]
                v1.Transparency = 1
            end
        end
    end,
    VerticalRecoil = 18,
    HorizontalRecoil = 10,
    AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Revolver_Mods"),
}