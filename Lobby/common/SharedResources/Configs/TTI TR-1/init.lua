local v1 = {
    Ammo = 25,
    StoredAmmo = 175,
    AmmoType = nil,
    Damage = 85,
    Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 2},
    Penetration = 3,
    PenetrationReduction = 0.6,
    AimFOVMultiplier = 0.55,
    FireMode = {"Semi-Auto"},
    DelayPerShot = 0.1935483870967742,
    Lense = true,
    BurstAmt = nil,
    BurstDelay = nil,
    ADSSpeed = 1.5,
    DrawSpeed = 1.7,
    HolsterSpeed = 1.7,
    ReloadTime = 1.8,
    ReloadTimeScale = 1.4538888888888888,
    EmptyReloadTime = 2.2,
    EmptyReloadTimeScale = 1.355909090909091,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 1.035,
    HolsteredWalkspeedMultiplier = 1.035,
    BaseSpread = 0.017453292519943295,
    CrouchSpreadReduction = 0.7,
    ProneSpreadReduction = 0.5,
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
    SuppressorShootSingle = {SoundId = "6839476979", Volume = 0.25},
    ShootSingle = {SoundId = "13975566037", Volume = 0.75},
}
local v2 = {}
v2["0"] = {
    {SoundId = "13975569169", Volume = 0.6},
    {SoundId = "6839481207", Volume = 0.2},
}
v1.LayeredSFXs = v2
v1.HasSuppressor = true
v1.AutoLoop = nil
v1.AutoLoopTail = nil
v1.KeyFrameSounds = {
    MagIn = {SoundId = "1599278493", Volume = 0.5},
    MagOut = {SoundId = "306684817", Volume = 0.5},
    BoltBack = {SoundId = "1599278764", Volume = 0.5},
}
v1.DeploySFX = nil
v1.IsAPistol = false
v1.UsePistolIcon = false
v1.BulletCasing = "rifle"
v1.WorldScaleValue = 1
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 1.5
v1.Offset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(0.5, -0.100000001, -0.300000012, 0.764842212, 0, 0.64421767, -0.127986297, 0.980066597, 0.151950687, -0.631376207, -0.198669329, 0.749596298)
v1.AimOffset = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.HasShadow = true
v1.VerticalRecoil = 11.7
v1.HorizontalRecoil = 12.36
v1.CrouchRecoilMultiplier = 0.65
v1.ProneRecoilMultiplier = 0.55
function v1.OnEquipped(p1) -- Line: 170
    local u3 = require("@game/ReplicatedStorage/common/SharedResources/Attachments/AttachmentProperties/Optics")
    local Model = p1.Viewmodel.Model
    local Weapon = Model:WaitForChild("Weapon")
    local KeyParts = Model:WaitForChild("KeyParts")
    local v1 = Weapon:WaitForChild("Top Rail_Hide")
    local Sound = KeyParts:WaitForChild("Handle"):FindFirstChildOfClass("Sound")
    if Sound then
        Sound:Play()
    end
    task.defer(function() -- Line: 188 -- upvalues: Model (val), u3 (val), p1 (val)
        local v1
        while true do
            task.wait()
            if not Model.Parent then
                break
            end
            if Model:FindFirstChild("Attachments") then
                v1 = #Model:FindFirstChild("Attachments"):GetChildren()
                if 0 < v1 then
                    break
                end
            end
        end
        if not Model.Parent then
            return
        end
        for i, j in Model:FindFirstChild("Attachments"):GetChildren() do
            if u3[j.Name] then
                p1.Config.HideScopeModel = nil
                return
            end
        end
    end)
    p1.Config.HideScopeModel = v1
end
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Base")
return v1