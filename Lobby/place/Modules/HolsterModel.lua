local HolsterPlacement = require(script.Parent.HolsterPlacement)
local v1 = {}
local v2 = {
    attr = "HolsterPrimary",
    part = "Torso",
    c0 = CFrame.new(0.15633, 0.45016, 0.56081, 0.00045, -0.70804, 0.70617, 0.00025, -0.70617, -0.70804, 1, 0.0005, -0.00015),
}
local v3 = {
    attr = "HolsterSecondary",
    part = "Right Leg",
    c0 = CFrame.new(
        0.45074,
        0.29878,
        -0.00716,
        0.99832,
        0.02504,
        -0.05233,
        0.00457,
        -0.93317,
        -0.3594,
        -0.05784,
        0.35855,
        -0.93172
    ),
}
local v4 = {
    attr = "HolsterMelee",
    part = "Torso",
    c0 = CFrame.new(-0.8, -0.3, 0.45, -0.01994, -4e-05, -0.9998, -0.04575, 0.99895, 0.00087, 0.99875, 0.04575, -0.01992),
}
v1[1] = v2
v1[2] = v3
v1[3] = v4
local u51 = {["Left Arm"] = true, ["Right Arm"] = true, Head = true, HumanoidRootPart = true}
local u56 = {}
v4 = v1
local v5 = nil
local v6 = nil
for i, j in v4, v5, v6 do
    u56[j.attr] = j
end

local function prepareGun(p1) -- Line: 77 -- upvalues: u51 (val)
    local v1 = p1
    for i, j in p1:GetChildren() do
        if u51[j.Name] or j:IsA("Configuration") or j:IsA("Humanoid") or j:IsA("AnimationController") then
            j:Destroy()
        end
    end
    local Handle = v1:FindFirstChild("Handle", true)
    if not Handle or not Handle:IsA("BasePart") then
        local Weapon = v1:FindFirstChild("Weapon")
        if not Weapon then
            Weapon = v1:FindFirstChild("KeyParts")
        end
        local PrimaryPart = Weapon
        if PrimaryPart then
            PrimaryPart = Weapon.PrimaryPart
            if not PrimaryPart then
                PrimaryPart = Weapon:FindFirstChildWhichIsA("BasePart", true)
            end
        end
        Handle = PrimaryPart
    end
    if Handle and Handle:IsA("BasePart") then
        local Weld
        local Descendants = v1:GetDescendants()
        local v2 = Descendants
        local v3 = nil
        local v4 = nil
        for k, n in v2, v3, v4 do
            if n:IsA("Motor6D") or n:IsA("Weld") or n:IsA("WeldConstraint") then
                n:Destroy()
            end
        end
        v2 = Descendants
        v3 = nil
        v4 = nil
        for m, i5 in v2, v3, v4 do
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
                    Weld.C0 = (Handle.CFrame:Inverse()) * i5.CFrame
                    Weld.Parent = Handle
                end
            end
        end
        return Handle
    end
    return nil
end

return {
    Slots = v1,
    Install = function(p1, p2, p3, p4) -- Line: 134 -- upvalues: u56 (val), prepareGun (val), HolsterPlacement (val)
        local v1 = u56[p3]
        local v2 = v1
        if v2 then
            local part = v1.part
            v2 = p2:FindFirstChild(part)
        end
        if v2 and v2:IsA("BasePart") then
            local v3 = prepareGun(p1)
            if not v3 then
                return false
            end
            local v4 = HolsterPlacement
            v4 = v4.calculate(HolsterPlacement.collectCorners(p1, v3), v2.Size, v1.c0, v1.attr)
            if not v4 then
                return false
            end
            p1.Name = p3
            local v5 = v2.CFrame * v4 * v3.CFrame:Inverse() * (p1:GetPivot())
            p1:PivotTo(v5)
            local Weld = Instance.new("Weld")
            Weld.Part0 = v2
            Weld.Part1 = v3
            Weld.C0 = v4
            Weld.Parent = v3
            p1.Parent = p4
            return true
        end
        return false
    end,
}