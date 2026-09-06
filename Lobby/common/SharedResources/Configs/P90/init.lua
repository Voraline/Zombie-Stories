local v1 = {
    Ammo = 50,
    StoredAmmo = 300,
    AmmoType = nil,
    Damage = 20,
    Multipliers = {Arms = 0.9, Torso = 1, Legs = 0.9, Head = 1.7},
    Penetration = 0,
    PenetrationReduction = 0.5,
    FireMode = {"Auto", "Semi-Auto"},
    DelayPerShot = 0.06857142857142857,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1,
    DrawSpeed = 1,
    HolsterSpeed = 2,
    ReloadTime = 2.63,
    ReloadTimeScale = 1,
    EmptyReloadTime = 3.3,
    EmptyReloadTimeScale = 1,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1,
    HolsteredWalkspeedMultiplier = 1,
    BaseSpread = 0.10471975511965978,
    CrouchSpreadReduction = nil,
    ProneSpreadReduction = nil,
    ADSSpreadReduction = 1,
    MovementSpread = nil,
    AirSpread = 5,
    SlidingSpread = nil,
    DivingSpread = nil,
    ShootingSpreadIncrement = nil,
    ShootingSpreadDecay = 0.1,
    FirstDrawAnimation = "ReloadEmpty",
    FirstDrawAnimationTime = 1.6,
    DrawAnimation = nil,
    DrawAnimationTime = nil,
    ShootSingle = {SoundId = "87534588983395", Volume = 0.25},
    SuppressorShootSingle = {SoundId = "90324824146898", Volume = 0.35},
    AutoLoop = nil,
    AutoLoopTail = nil,
    KeyFrameSounds = {
        mag_in = {SoundId = "6380367588", Volume = 1},
        mag_out = {SoundId = "92062852955327", Volume = 1},
        bolt_back = {SoundId = "126252469119047", Volume = 0.85},
        bolt_forward = {SoundId = "101491589336010", Volume = 0.85},
        mag_smack = {SoundId = "123609441660673", Volume = 1},
    },
    DeploySFX = {SoundId = "485606203", Volume = 0.4},
    IsAPistol = false,
    UsePistolIcon = true,
    BulletCasing = "pistol",
    WorldScaleValue = 0.74079326160881,
    NewSkinsSystem = false,
    NewSkinsSystemBlacklist = {},
    LODModel = "DefaultSMG",
    DynamicFOVOffsetConstant = 1.5,
    AimDynamicFOVOffsetConstant = 1,
    Offset = CFrame.new(),
    SprintOffset = CFrame.new(0.75, -0.0500000007, -0.0500000007, 0.696706712, 0, 0.717356086, -0.142516658, 0.980066597, 0.138414249, -0.703056753, -0.198669329, 0.682818949),
    AimOffset = CFrame.new(0, 0, -0.1, 1, 0, 0, 0, 1, 0, 0, 0, 1),
}
local v2 = CFrame.new(-1, -0.75, 0.25)
v1.GripOffset = v2 * CFrame.Angles(0, 0, 0.7853981633974483)
v1.RecoilRollSpeed = 30
v1.VerticalRecoil = 2.55
v1.HorizontalRecoil = 2.1
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/P90_Mods")
function v1.AttachedAttachment(p1, p2, p3, p4) -- Line: 178
    local v1
    local CollectionService = game:GetService("CollectionService")
    if p2 == "Barrel" then
        local Weapon = p1:FindFirstChild("Weapon")
        if Weapon then
            local v2
            p4:AddTag("P90_Barrel")
            local Muzzle_Hide = Weapon:FindFirstChild("Muzzle_Hide")
            local Muzzle_Show = Weapon:FindFirstChild("Muzzle_Show")
            v1 = {Muzzle_Hide, Muzzle_Show}
            for k4, n in pairs(v1) do
                for k5, m in pairs(n:GetDescendants()) do
                    if m:IsA("BasePart") then
                        if k4 ~= 1 then
                            v2 = 0
                        else
                            v2 = 1
                        end
                        m.Transparency = v2
                    elseif not (m:IsA("Texture")) and not (m:IsA("Decal")) then
                        if m:IsA("Beam") then
                            m.Enabled = false
                        elseif not (m:IsA("ParticleEmitter")) and not (m:IsA("Trail")) then
                        end
                    end
                end
            end
        end
    elseif p2 == "Muzzle" then
        local Tagged = CollectionService:GetTagged("P90_Barrel")
        local v3 = nil
        local v4 = Tagged
        local v5 = nil
        v1 = nil
        for i, j in v4, v5, v1 do
            if j:IsDescendantOf(p1) then
                v3 = j
                break
            end
        end
        if v3 then
            local v6
            local Muzzle_Hide_2 = v3:FindFirstChild("Muzzle_Hide")
            local Muzzle_Show_2 = v3:FindFirstChild("Muzzle_Show")
            local v7 = {Muzzle_Hide_2, Muzzle_Show_2}
            for k, v in pairs(v7) do
                for k2, k3 in pairs(v:GetDescendants()) do
                    if k3:IsA("BasePart") then
                        if k ~= 1 then
                            v6 = 0
                        else
                            v6 = 1
                        end
                        k3.Transparency = v6
                    elseif not (k3:IsA("Texture")) and not (k3:IsA("Decal")) then
                        if k3:IsA("Beam") then
                            k3.Enabled = false
                        elseif not (k3:IsA("ParticleEmitter")) and not (k3:IsA("Trail")) then
                        end
                    end
                end
            end
        end
    end
    return true
end
function v1.DetachedAttachment(p1, p2, p3, p4) -- Line: 227
    local v1
    local CollectionService = game:GetService("CollectionService")
    if p2 == "Barrel" then
        local Weapon = p1:FindFirstChild("Weapon")
        if Weapon then
            local Attribute
            local Muzzle_Hide = Weapon:FindFirstChild("Muzzle_Hide")
            local Muzzle_Show = Weapon:FindFirstChild("Muzzle_Show")
            v1 = {Muzzle_Hide, Muzzle_Show}
            for k4, n in pairs(v1) do
                for k5, m in pairs(n:GetDescendants()) do
                    if m:IsA("BasePart") then
                        if k4 ~= 1 then
                            Attribute = 1
                        else
                            Attribute = m:GetAttribute("Transparency")
                            if not Attribute then
                                Attribute = 0
                            end
                        end
                        m.Transparency = Attribute
                    elseif not (m:IsA("Texture")) and not (m:IsA("Decal")) then
                    end
                end
            end
        end
    elseif p2 == "Muzzle" then
        local Tagged = CollectionService:GetTagged("P90_Barrel")
        local v2 = nil
        local v3 = Tagged
        local v4 = nil
        v1 = nil
        for i, j in v3, v4, v1 do
            if j:IsDescendantOf(p1) then
                v2 = j
                break
            end
        end
        if v2 then
            local Attribute_2
            local Muzzle_Hide_2 = v2:FindFirstChild("Muzzle_Hide")
            local Muzzle_Show_2 = v2:FindFirstChild("Muzzle_Show")
            local v5 = {Muzzle_Hide_2, Muzzle_Show_2}
            for k, v in pairs(v5) do
                for k2, k3 in pairs(v:GetDescendants()) do
                    if k3:IsA("BasePart") then
                        if k ~= 1 then
                            Attribute_2 = 1
                        else
                            Attribute_2 = k3:GetAttribute("Transparency")
                            if not Attribute_2 then
                                Attribute_2 = 0
                            end
                        end
                        k3.Transparency = Attribute_2
                    elseif not (k3:IsA("Texture")) and not (k3:IsA("Decal")) then
                    end
                end
            end
        end
    end
    return true
end
return v1