local function UpdateC0IfChanged(p1, p2, p3) -- Line: 12
    local v1, v2
    local C0 = p1.C0
    if not p3 then
        v1 = 0.005
    else
        v1 = 0.0001
    end
    if not p3 then
        v2 = 0.005
    else
        v2 = 0.0001
    end
    if v1 < (p2.Position - C0.Position).Magnitude then
        p1.C0 = p2
        return true
    end
    local v3 = 1 - C0.LookVector:Dot(p2.LookVector)
    if v2 < v3 then
        p1.C0 = p2
        return true
    end
    if v2 >= 1 - C0.UpVector:Dot(p2.UpVector) then
        return false
    end
    p1.C0 = p2
    return true
end
local function SolveArmIK(p1, p2, p3, p4, p5, p6) -- Line: 38
    local v1
    local v2 = nil
    if p6 == "Left" then
        v2 = p1 * CFrame.new(0, 0, p5.X)
    elseif p6 == "Right" then
        v2 = p1 * CFrame.new(0, 0, -p5.X)
    end
    local v3 = v2:pointToObjectSpace(p2)
    local unit = v3.unit
    local magnitude = v3.magnitude
    local v4 = Vector3.new(0, 0, -1):Cross(unit)
    local v5 = v2 * CFrame.fromAxisAngle(v4, (math.acos(-unit.Z)))
    local v6 = math.max(p4, p3)
    if magnitude < v6 - math.min(p4, p3) then
        local v7 = math.max(p4, p3)
        v1 = v5 * CFrame.new(0, 0, v7 - math.min(p4, p3) - magnitude)
        return v1, -1.5707963267948966, 3.141592653589793
    end
    if p3 + p4 < magnitude then
        return v5, 1.5707963267948966, 0, magnitude
    end
    v1 = -math.acos((-(p4 * p4) + p3 * p3 + magnitude * magnitude) / (2 * p3 * magnitude))
    v6 = math.acos((p4 * p4 - p3 * p3 + magnitude * magnitude) / (2 * p4 * magnitude))
    return v5, v1 + 1.5707963267948966, v6 - v1
end
local function SolveLegIK(p1, p2, p3, p4, p5) -- Line: 72
    local v1
    local v2 = p1 * CFrame.new(-p5.X, 0, 0)
    local v3 = v2:pointToObjectSpace(p2)
    local unit = v3.unit
    local magnitude = v3.magnitude
    local v4 = Vector3.new(0, 0, -1):Cross(-unit)
    local v5 = v2 * CFrame.fromAxisAngle(v4, (math.acos(-unit.Z))):Inverse()
    local v6 = math.max(p4, p3)
    if magnitude < v6 - math.min(p4, p3) then
        local v7 = math.max(p4, p3)
        v1 = v5 * CFrame.new(0, 0, v7 - math.min(p4, p3) - magnitude)
        return v1, -1.5707963267948966, 3.141592653589793
    end
    if p3 + p4 < magnitude then
        return v5, 1.5707963267948966, 0, magnitude
    end
    v1 = -math.acos((-(p4 * p4) + p3 * p3 + magnitude * magnitude) / (2 * p3 * magnitude))
    v6 = math.acos((p4 * p4 - p3 * p3 + magnitude * magnitude) / (2 * p4 * magnitude))
    return v5, 1.5707963267948966 - v1, -(v6 - v1)
end
local function WorldCFrameToC0ObjectSpace(p1, p2) -- Line: 101
    return p1.Part0.CFrame:inverse() * p2 * p1.C1
end
local u4 = {}
u4.__index = u4
local function requireChild(p1, p2, p3) -- Line: 113
    local v1
    local v2 = p1:FindFirstChild(p2)
    if not v2 then
        v2 = p1:WaitForChild(p2, 5)
    end
    if not v2 then
        local FullName = p1:GetFullName()
        v1 = string.format("[R6IK] Missing required R6 instance %s.%s after %d seconds", FullName, p2, 5)
        error(v1, 2)
    end
    if not (v2:IsA(p3)) then
        local FullName_2 = p1:GetFullName()
        v1 = string.format("[R6IK] Expected %s.%s to be a %s, got %s", FullName_2, p2, p3, v2.ClassName)
        error(v1, 2)
    end
    return v2
end
function u4.New(p1, p2) -- Line: 141 -- upvalues: u4 (val), requireChild (val)
    local v1 = setmetatable({}, u4)
    v1.isLocalPlayer = p2 or false
    v1.Torso = requireChild(p1, "Torso", "BasePart")
    v1.Head = requireChild(p1, "Head", "BasePart")
    v1.HumanoidRootPart = requireChild(p1, "HumanoidRootPart", "BasePart")
    v1.LeftArm = requireChild(p1, "Left Arm", "BasePart")
    v1.RightArm = requireChild(p1, "Right Arm", "BasePart")
    v1.LeftLeg = requireChild(p1, "Left Leg", "BasePart")
    v1.RightLeg = requireChild(p1, "Right Leg", "BasePart")
    local v2 = {}
    v2["Left Shoulder"] = requireChild(v1.Torso, "Left Shoulder", "Motor6D")
    v2["Right Shoulder"] = requireChild(v1.Torso, "Right Shoulder", "Motor6D")
    v2["Left Hip"] = requireChild(v1.Torso, "Left Hip", "Motor6D")
    v2["Right Hip"] = requireChild(v1.Torso, "Right Hip", "Motor6D")
    v2.Neck = requireChild(v1.Torso, "Neck", "Motor6D")
    v2.RootJoint = requireChild(v1.HumanoidRootPart, "RootJoint", "Motor6D")
    v1.Motor6Ds = v2
    v2 = {}
    v2["Left Shoulder"] = v1.Motor6Ds["Left Shoulder"].C0
    v2["Right Shoulder"] = v1.Motor6Ds["Right Shoulder"].C0
    v2["Left Hip"] = v1.Motor6Ds["Left Hip"].C0
    v2["Right Hip"] = v1.Motor6Ds["Right Hip"].C0
    v2.Neck = v1.Motor6Ds.Neck.C0
    v2.RootJoint = v1.Motor6Ds.RootJoint.C0
    v1.C0s = v2
    v2 = {}
    v2["Left Shoulder"] = v1.Motor6Ds["Left Shoulder"].C1
    v2["Right Shoulder"] = v1.Motor6Ds["Right Shoulder"].C1
    v2["Left Hip"] = v1.Motor6Ds["Left Hip"].C1
    v2["Right Hip"] = v1.Motor6Ds["Right Hip"].C1
    v2.RootJoint = v1.Motor6Ds.RootJoint.C1
    v1.C1s = v2
    v2 = {}
    v2["Left Shoulder"] = v1.Motor6Ds["Left Shoulder"].Part0
    v2["Right Shoulder"] = v1.Motor6Ds["Right Shoulder"].Part0
    v2["Left Hip"] = v1.Motor6Ds["Left Hip"].Part0
    v2["Right Hip"] = v1.Motor6Ds["Right Hip"].Part0
    v2.RootJoint = v1.Motor6Ds.RootJoint.Part0
    v1.Part0s = v2
    v2 = {}
    v2["Left Shoulder"] = v1.Motor6Ds["Left Shoulder"].Part1
    v2["Right Shoulder"] = v1.Motor6Ds["Right Shoulder"].Part1
    v2["Left Hip"] = v1.Motor6Ds["Left Hip"].Part1
    v2["Right Hip"] = v1.Motor6Ds["Right Hip"].Part1
    v2.RootJoint = v1.Motor6Ds.RootJoint.Part1
    v1.Part1s = v2
    v1.LeftUpperArmLength = 1
    v1.LeftLowerArmLength = 1
    v1.RightUpperArmLength = 1
    v1.RightLowerArmLength = 1
    v1.LeftUpperLegLength = 1
    v1.LeftLowerLegLength = 1
    v1.RightUpperLegLength = 1
    v1.RightLowerLegLength = 1
    return v1
end
function u4.ArmIK(p1, p2, p3) -- Line: 211 -- upvalues: SolveArmIK (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    if p2 == "Left" then
        v6, v7, v8 = SolveArmIK(p1.Torso.CFrame * p1.C0s["Left Shoulder"], p3, p1.LeftUpperArmLength, p1.LeftLowerArmLength, p1.C1s["Left Shoulder"], p2)
        v9 = CFrame.Angles(v7, 0, 0)
        v1 = CFrame.Angles(v8, 0, 0)
        v4 = v6 * v9 * CFrame.new(0, -p1.LeftUpperArmLength * 0.5, 0) * CFrame.new(0, -p1.LeftUpperArmLength * 0.5, 0) * v1
        v3 = v4 * CFrame.new(0, -p1.LeftLowerArmLength * 0.5, 0)
        v2 = v3 * CFrame.new(0, (p1.LeftArm.Size.Y - p1.LeftLowerArmLength) * 0.5, 0)
        v3 = p1.Motor6Ds["Left Shoulder"]
        v5 = p1.Motor6Ds["Left Shoulder"]
        v3.C0 = v5.Part0.CFrame:inverse() * v2 * v5.C1
        return
    end
    if p2 == "Right" then
        v6, v7, v8 = SolveArmIK(p1.Torso.CFrame * p1.C0s["Right Shoulder"], p3, p1.RightUpperArmLength, p1.RightLowerArmLength, p1.C1s["Right Shoulder"], p2)
        v9 = CFrame.Angles(v7, 0, 0)
        v1 = CFrame.Angles(v8, 0, 0)
        v4 = v6 * v9 * CFrame.new(0, -p1.RightUpperArmLength * 0.5, 0) * CFrame.new(0, -p1.RightUpperArmLength * 0.5, 0) * v1
        v3 = v4 * CFrame.new(0, -p1.RightLowerArmLength * 0.5, 0)
        v2 = v3 * CFrame.new(0, (p1.RightArm.Size.Y - p1.RightLowerArmLength) * 0.5, 0)
        v3 = p1.Motor6Ds["Right Shoulder"]
        v5 = p1.Motor6Ds["Right Shoulder"]
        v3.C0 = v5.Part0.CFrame:inverse() * v2 * v5.C1
    end
end
function u4.LegIK(p1, p2, p3) -- Line: 249 -- upvalues: SolveLegIK (val), UpdateC0IfChanged (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    if p2 == "Left" then
        v5 = p1.C1s["Left Hip"]
        v7 = p1.Torso.CFrame * p1.C0s["Left Hip"] * CFrame.Angles(0, 1.5707963267948966, 0)
        v6, v7, v8 = SolveLegIK(v7, p3, p1.LeftUpperLegLength, p1.LeftLowerLegLength, v5)
        v9 = CFrame.Angles(v7, 0, 0)
        v1 = CFrame.Angles(v8, 0, 0)
        v4 = v6 * v9 * CFrame.new(0, -p1.LeftUpperLegLength * 0.5, 0) * CFrame.new(0, -p1.LeftUpperLegLength * 0.5, 0) * v1
        v3 = v4 * CFrame.new(0, -p1.LeftLowerLegLength * 0.5, 0)
        v2 = v3 * CFrame.new(0, (p1.LeftLeg.Size.Y - p1.LeftLowerLegLength) * 0.5, 0)
        v4 = p1.Motor6Ds["Left Hip"]
        UpdateC0IfChanged(p1.Motor6Ds["Left Hip"], v4.Part0.CFrame:inverse() * v2 * v4.C1, p1.isLocalPlayer)
        return
    end
    if p2 == "Right" then
        v5 = p1.C1s["Right Hip"]
        v7 = p1.Torso.CFrame * p1.C0s["Right Hip"] * CFrame.Angles(0, -1.5707963267948966, 0)
        v6, v7, v8 = SolveLegIK(v7, p3, p1.RightUpperLegLength, p1.RightLowerLegLength, v5)
        v9 = CFrame.Angles(v7, 0, 0)
        v1 = CFrame.Angles(v8, 0, 0)
        v4 = v6 * v9 * CFrame.new(0, -p1.RightUpperLegLength * 0.5, 0) * CFrame.new(0, -p1.RightUpperLegLength * 0.5, 0) * v1
        v3 = v4 * CFrame.new(0, -p1.RightLowerLegLength * 0.5, 0)
        v2 = v3 * CFrame.new(0, (p1.RightLeg.Size.Y - p1.RightLowerLegLength) * 0.5, 0)
        v4 = p1.Motor6Ds["Right Hip"]
        UpdateC0IfChanged(p1.Motor6Ds["Right Hip"], v4.Part0.CFrame:inverse() * v2 * v4.C1, p1.isLocalPlayer)
    end
end
return u4