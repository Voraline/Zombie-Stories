local HolsterPlacement = require(script.Parent.HolsterPlacement)
local v1 = {}
local v2 = {attr = "HolsterPrimary", part = "Torso", c0 = CFrame.new(0.15633, 0.45016, 0.56081, 0.00045, -0.70804, 0.70617, 0.00025, -0.70617, -0.70804, 1, 0.0005, -0.00015)}
local v3 = {attr = "HolsterSecondary", part = "Right Leg", c0 = CFrame.new(0.45074, 0.29878, -0.00716, 0.99832, 0.02504, -0.05233, 0.00457, -0.93317, -0.3594, -0.05784, 0.35855, -0.93172)}
local v4 = {attr = "HolsterMelee", part = "Torso", c0 = CFrame.new(-0.8, -0.3, 0.45, -0.01994, -4e-05, -0.9998, -0.04575, 0.99895, 0.00087, 0.99875, 0.04575, -0.01992)}
v1[1] = v2
v1[2] = v3
v1[3] = v4
local u51 = {}
u51["Left Arm"] = true
u51["Right Arm"] = true
u51.Head = true
u51.HumanoidRootPart = true
local u56 = {}
v4 = v1
local v5 = nil
local v6 = nil
for i, j in v4, v5, v6 do
    u56[j.attr] = j
end
local function prepareGun(p1) -- Line: 77 -- upvalues: u51 (val)
    local Weld, v1
    local v2 = p1
    for i, j in p1:GetChildren() do
        if u51[j.Name] then
            j:Destroy()
        elseif not (j:IsA("Configuration")) and not (j:IsA("Humanoid")) and not (j:IsA("AnimationController")) then
        end
    end
    local Handle = v2:FindFirstChild("Handle", true)
    if not Handle then
        local Weapon = v2:FindFirstChild("Weapon")
        if not Weapon then
            Weapon = v2:FindFirstChild("KeyParts")
        end
        local PrimaryPart = Weapon
        if PrimaryPart then
            PrimaryPart = Weapon.PrimaryPart
            if not PrimaryPart then
                PrimaryPart = Weapon:FindFirstChildWhichIsA("BasePart", true)
            end
        end
        Handle = PrimaryPart
    elseif Handle:IsA("BasePart") then
    end
    if not Handle or not (Handle:IsA("BasePart")) then
        return nil
    end
    local Descendants = v2:GetDescendants()
    local v3 = Descendants
    local v4 = nil
    local v5 = nil
    for k, n in v3, v4, v5 do
        if n:IsA("Motor6D") then
            n:Destroy()
        elseif not (n:IsA("Weld")) and not (n:IsA("WeldConstraint")) then
        end
    end
    v3 = Descendants
    v4 = nil
    v5 = nil
    for m, i5 in v3, v4, v5 do
        if i5:IsA("BasePart") then
            i5.Anchored = false
            i5.CanCollide = false
            i5.CanTouch = false
            i5.CanQuery = false
            i5.Massless = true
            i5.CastShadow = false
            if i5 ~= Handle then
                Weld = Instance.new("Weld")
                Weld.Part0 = Handle
                Weld.Part1 = i5
                v1 = Handle.CFrame:Inverse()
                Weld.C0 = v1 * i5.CFrame
                Weld.Parent = Handle
            end
        end
    end
    return Handle
end
v5 = {Slots = v1}
function v5.Install(p1, p2, p3, p4) -- Line: 134 -- upvalues: u56 (val), prepareGun (val), HolsterPlacement (val)
    local v1 = u56[p3]
    local v2 = v1
    if v2 then
        v2 = p2:FindFirstChild(v1.part)
    end
    if not v2 or not (v2:IsA("BasePart")) then
        return false
    end
    local v3 = prepareGun(p1)
    if not v3 then
        return false
    end
    local v4 = HolsterPlacement.collectCorners(p1, v3)
    local v5 = HolsterPlacement.calculate(v4, v2.Size, v1.c0, v1.attr)
    if not v5 then
        return false
    end
    p1.Name = p3
    local v6 = v2.CFrame * v5 * v3.CFrame:Inverse()
    p1:PivotTo(v6 * p1:GetPivot())
    local Weld = Instance.new("Weld")
    Weld.Part0 = v2
    Weld.Part1 = v3
    Weld.C0 = v5
    Weld.Parent = v3
    p1.Parent = p4
    return true
end
return v5