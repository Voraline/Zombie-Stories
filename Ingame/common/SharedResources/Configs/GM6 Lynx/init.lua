local v1 = {
    Ammo = 5,
    StoredAmmo = 50,
    AmmoType = nil,
    Damage = 110,
    Multipliers = {Arms = 1.1, Torso = 1, Legs = 1.1, Head = 4},
    Penetration = 6,
    PenetrationReduction = 0.91,
    FireMode = {"Semi-Auto"},
    DelayPerShot = 0.6315789473684211,
    BurstAmt = 3,
    BurstDelay = 0.1,
    ADSSpeed = 0.42,
    DrawSpeed = 0.25,
    HolsterSpeed = 0.25,
    ReloadTime = 4.5,
    ReloadTimeScale = 0.4,
    EmptyReloadTime = 6.576,
    EmptyReloadTimeScale = 0.5,
    EquippedWalkspeedChange = 0,
    HolsteredWalkspeedChange = 0,
    EquippedWalkspeedMultiplier = 0.75,
    HolsteredWalkspeedMultiplier = 0.9,
    AimFOVMultiplier = 0.233,
    BaseSpread = 0.4363323129985824,
    CrouchSpreadReduction = nil,
    ProneSpreadReduction = nil,
    ADSSpreadReduction = 0.001,
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
    ShootSingle = {SoundId = "11947450575", Volume = 0.5},
    SuppressorShootSingle = {SoundId = "10978329762", Volume = 0.5},
    AutoLoop = nil,
    AutoLoopTail = nil,
}
local v2 = {
    bolt_forward = {SoundId = "18899814743", Volume = 1.7},
    bolt_back = {SoundId = "18899812869", Volume = 1.7},
    mag_in = {SoundId = "18899809022", Volume = 1.3},
    mag_out = {SoundId = "18899807231", Volume = 1.8},
}
local v3 = {SoundId = "515215936", Volume = 0.7}
v2.mag_tap = v3
v1.KeyFrameSounds = v2
v1.DeploySFX = nil
v1.IsAPistol = false
v1.UsePistolIcon = false
v1.BulletCasing = "rifle"
v1.WorldScaleValue = 1
v1.NewSkinsSystem = false
v2 = {}
v1.NewSkinsSystemBlacklist = v2
v1.DynamicFOVOffsetConstant = 2
v1.AimDynamicFOVOffsetConstant = 0.5
v1.Offset = CFrame.new(0.100000001, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
v1.SprintOffset = CFrame.new(0, 0, -0.300000012, 0.962250173, -0.0841859728, 0.258819044, -0.0299755037, 0.912392259, 0.408217907, -0.270510703, -0.400565982, 0.875426054)
v1.AimOffset = CFrame.new()
v1.VerticalRecoil = 16
v1.HorizontalRecoil = 5
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/GM6_Mods")
v1.Lense = true
v1.Shadow = true
local function getViewmodelModel(p1) -- Line: 175
    local v1
    if not p1 or not p1.Viewmodel then
        return nil
    end
    if p1.Viewmodel.Model then
        return p1.Viewmodel.Model
    end
    local v2 = false
    if p1.Viewmodel.ConfigLoaded and p1.Viewmodel.ConfigLoaded.Wait then
        v2 = true
        pcall(function() -- Line: 187 -- upvalues: p1 (val)
            p1.Viewmodel.ConfigLoaded:Wait()
        end)
    end
    if p1.Viewmodel.Model then
        return p1.Viewmodel.Model
    end
    local v3 = os.clock()
    while not p1.IsDestroyed do
        if p1.Viewmodel.Model then
            break
        end
        v1 = os.clock() - v3
        if v1 >= 6 then
            break
        end
        task.wait()
    end
    if not p1.Viewmodel.Model and v2 then
        warn("[GM6 Lynx] Viewmodel failed to load before OnEquipped finished")
    end
    return p1.Viewmodel.Model
end
function v1.VMImpulse(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) -- Line: 233
    local v1 = math.random() - 0.5
    local v2 = p3 + math.random() * 0.02 * p10
    local v3 = p5 + 0.75 + math.random() * 0.25
    local v4 = p6 + 0.1 - math.random() * 0.05
    local v5 = p7 + math.rad(v1 * 0.1 * p10)
    return v2, p4 + 0.075, v3, v4, v5, p8 + 0.01 * v1 * (p10 * 0.5)
end
function v1.AttachedAttachment(p1, p2, p3, p4) -- Line: 245
    if p2 == "Top Rail" then
        local Weapon = p1:WaitForChild("Weapon")
        p1:WaitForChild("KeyParts")
        for i, j in Weapon:WaitForChild("Top Rail_Hide"):GetChildren() do
            if j:IsA("BasePart") then
                j.Transparency = 1
            end
        end
    end
    return true
end
function v1.OnEquipped(p1) -- Line: 261 -- upvalues: getViewmodelModel (val)
    local u3 = require("@game/ReplicatedStorage/common/SharedResources/Attachments/AttachmentProperties/Optics")
    local u6 = getViewmodelModel(p1)
    if not u6 then
        return
    end
    local Weapon = u6:WaitForChild("Weapon")
    local KeyParts = u6:WaitForChild("KeyParts")
    local v1 = Weapon:WaitForChild("Top Rail_Hide")
    local Sound = KeyParts:WaitForChild("Handle"):FindFirstChildOfClass("Sound")
    if Sound then
        Sound:Play()
    end
    task.defer(function() -- Line: 281 -- upvalues: u6 (val), u3 (val), p1 (val)
        local v1
        while true do
            task.wait()
            if not u6.Parent then
                break
            end
            if u6:FindFirstChild("Attachments") then
                v1 = #u6:FindFirstChild("Attachments"):GetChildren()
                if 0 < v1 then
                    break
                end
            end
        end
        if not u6.Parent then
            return
        end
        for i, j in u6:FindFirstChild("Attachments"):GetChildren() do
            if u3[j.Name] then
                p1.Config.HideScopeModel = nil
                return
            end
        end
    end)
    p1.Config.HideScopeModel = v1
end
return v1