local v1 = {
    Ammo = 6,
    StoredAmmo = 30,
    AmmoType = nil,
    Damage = 55,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 2},
    Penetration = 1,
    PenetrationReduction = 1,
    FireMode = {"Semi-Auto"},
    DelayPerShot = 0.42857142857142855,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.5,
    DrawSpeed = 1,
    HolsterSpeed = 1,
    ReloadTime = 3.3,
    ReloadTimeScale = 1,
    EmptyReloadTime = 3.3,
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
        shell_in = {SoundId = "442294697", Volume = 0.5},
        cylinder_close = {SoundId = "657519674", Volume = 0.5},
        cylidner_spin = {SoundId = "965887968", Volume = 0.5},
        bullets_out = {SoundId = "1252000087", Volume = 0.5},
        shell_out = {SoundId = "442294728", Volume = 0.5},
        bullets_in = {SoundId = "504956429", Volume = 0.5},
        open_cylinder = {SoundId = "504956498", Volume = 0.5},
        bullets_out2 = {SoundId = "1252000087", Volume = 0.5},
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
    SprintOffset = CFrame.new(-0.300000012, 0, -0.300000012, 0.962250173, -0.0841859728, 0.258819044, -0.0299755037, 0.912392259, 0.408217907, -0.270510703, -0.400565982, 0.875426054),
    AimOffset = CFrame.new(0, 0, 0.100000001, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    CustomKF = function(p1, p2, p3) -- Line: 166
        local Shells, v1
        local Ammo = p3.Ammo
        if p1 == "shell_in" then
            local v2 = 6
            local v3 = 1
            for j = 1, v2, v3 do
                if p2.KeyParts.Shells["Shell" .. j].Transparency == 1 then
                    v1 = p2.KeyParts.Shells["Shell" .. j]
                    v1.Transparency = 0
                    return
                end
            end
            return
        end
        if p1 == "loadStopStarted" then
            local v4
            Shells = p2:WaitForChild("KeyParts"):WaitForChild("Shells")
            v1 = 6
            local v5 = 1
            for i = 1, v1, v5 do
                if Ammo >= i then
                    v4 = Shells["Shell" .. i]
                    v4.Transparency = 0
                else
                    v4 = Shells["Shell" .. i]
                    v4.Transparency = 1
                end
            end
            return
        end
        if p1 == "bullets_out2" then
            local Shells_2 = p2:WaitForChild("KeyParts"):WaitForChild("Shells")
            if Ammo < 1 then
                v1 = Shells_2["Shell" .. 1]
                v1.Transparency = 1
            end
            if Ammo < 2 then
                v1 = Shells_2["Shell" .. 2]
                v1.Transparency = 1
            end
            if Ammo < 3 then
                v1 = Shells_2["Shell" .. 3]
                v1.Transparency = 1
            end
            if Ammo < 4 then
                v1 = Shells_2["Shell" .. 4]
                v1.Transparency = 1
            end
            if Ammo < 5 then
                v1 = Shells_2["Shell" .. 5]
                v1.Transparency = 1
            end
            if Ammo < 6 then
                v1 = Shells_2["Shell" .. 6]
                v1.Transparency = 1
            end
        end
    end,
}
function v1.CustomEquip(p1, p2) -- Line: 204
    local v1
    local Shells = p2:WaitForChild("KeyParts"):WaitForChild("Shells")
    local v2 = 6
    local v3 = 1
    local v4 = p1
    for i = 1, v2, v3 do
        if v4 >= i then
            v1 = Shells["Shell" .. i]
            v1.Transparency = 0
        else
            v1 = Shells["Shell" .. i]
            v1.Transparency = 1
        end
    end
end
v1.VerticalRecoil = 18
v1.HorizontalRecoil = 10
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/BasePistol")
return v1