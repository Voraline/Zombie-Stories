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
    local LookVector = C0.LookVector
    local LookVector_2 = p2.LookVector
    local v3 = 1 - LookVector:Dot(LookVector_2)
    local UpVector_2 = C0.UpVector
    local UpVector = p2.UpVector
    local v4 = 1 - (UpVector_2:Dot(UpVector))
    if not (v2 < v3) and not (v2 < v4) then
        return false
    end
    p1.C0 = p2
    return true
end

local function SolveArmIK(p1, p2, p3, p4, p5, p6) -- Line: 38
    local v1 = nil
    if p6 == "Left" then
        v1 = p1 * CFrame.new(0, 0, p5.X)
    elseif p6 == "Right" then
        v1 = p1 * CFrame.new(0, 0, -p5.X)
    end
    local v2 = v1:pointToObjectSpace(p2)
    local unit = v2.unit
    local magnitude = v2.magnitude
    local v3 = Vector3.new(0, 0, -1):Cross(unit)
    local v4 = -unit.Z
    local v5 = math.acos(v4)
    v4 = v1 * CFrame.fromAxisAngle(v3, v5)
    if magnitude < (math.max(p4, p3)) - math.min(p4, p3) then
        return v4 * CFrame.new(0, 0, (math.max(p4, p3)) - math.min(p4, p3) - magnitude), -1.5707963267948966, 3.141592653589793
    end
    if p3 + p4 < magnitude then
        return v4, 1.5707963267948966, 0, magnitude
    end
    local v6 = (-(p4 * p4) + p3 * p3 + magnitude * magnitude) / (2 * p3 * magnitude)
    local v7 = -math.acos(v6)
    v6 = (p4 * p4 - p3 * p3 + magnitude * magnitude) / (2 * p4 * magnitude)
    local v8 = math.acos(v6)
    return v4, v7 + 1.5707963267948966, v8 - v7
end

local function SolveLegIK(p1, p2, p3, p4, p5) -- Line: 72
    local new = CFrame.new
    local v1 = -p5.X
    local v2 = p1 * new(v1, 0, 0)
    local v3 = v2:pointToObjectSpace(p2)
    local unit = v3.unit
    local magnitude = v3.magnitude
    local v4 = -unit
    local v5 = Vector3.new(0, 0, -1):Cross(v4)
    v4 = -unit.Z
    local v6 = math.acos(v4)
    v4 = v2 * CFrame.fromAxisAngle(v5, v6):Inverse()
    if magnitude < (math.max(p4, p3)) - math.min(p4, p3) then
        return v4 * CFrame.new(0, 0, (math.max(p4, p3)) - math.min(p4, p3) - magnitude), -1.5707963267948966, 3.141592653589793
    end
    if p3 + p4 < magnitude then
        return v4, 1.5707963267948966, 0, magnitude
    end
    local v7 = (-(p4 * p4) + p3 * p3 + magnitude * magnitude) / (2 * p3 * magnitude)
    local v8 = -math.acos(v7)
    v7 = (p4 * p4 - p3 * p3 + magnitude * magnitude) / (2 * p4 * magnitude)
    local v9 = math.acos(v7)
    return v4, 1.5707963267948966 - v8, -(v9 - v8)
end

local function WorldCFrameToC0ObjectSpace(p1, p2) -- Line: 101
    local CFrame = p1.Part0.CFrame
    local C1 = p1.C1
    return CFrame:inverse() * p2 * C1
end

local u4 = {}
u4.__index = u4

local function requireChild(p1, p2, p3) -- Line: 113
    local v1 = p1:FindFirstChild(p2)
    if not v1 then
        v1 = p1:WaitForChild(p2, 5)
    end
    if not v1 then
        error(string.format("[R6IK] Missing required R6 instance %s.%s after %d seconds", p1:GetFullName(), p2, 5), 2)
    end
    if not v1:IsA(p3) then
        error(string.format("[R6IK] Expected %s.%s to be a %s, got %s", p1:GetFullName(), p2, p3, v1.ClassName), 2)
    end
    return v1
end

function u4.New(p1, p2) -- Line: 141 -- upvalues: u4 (val), requireChild (val)
    local v1 = u4
    local v2 = setmetatable({}, v1)
    v2.isLocalPlayer = p2 or false
    v2.Torso = requireChild(p1, "Torso", "BasePart")
    v2.Head = requireChild(p1, "Head", "BasePart")
    v2.HumanoidRootPart = requireChild(p1, "HumanoidRootPart", "BasePart")
    v2.LeftArm = requireChild(p1, "Left Arm", "BasePart")
    v2.RightArm = requireChild(p1, "Right Arm", "BasePart")
    v2.LeftLeg = requireChild(p1, "Left Leg", "BasePart")
    v2.RightLeg = requireChild(p1, "Right Leg", "BasePart")
    v2.Motor6Ds = {
        ["Left Shoulder"] = requireChild(v2.Torso, "Left Shoulder", "Motor6D"),
        ["Right Shoulder"] = requireChild(v2.Torso, "Right Shoulder", "Motor6D"),
        ["Left Hip"] = requireChild(v2.Torso, "Left Hip", "Motor6D"),
        ["Right Hip"] = requireChild(v2.Torso, "Right Hip", "Motor6D"),
        Neck = requireChild(v2.Torso, "Neck", "Motor6D"),
        RootJoint = requireChild(v2.HumanoidRootPart, "RootJoint", "Motor6D"),
    }
    v2.C0s = {
        ["Left Shoulder"] = v2.Motor6Ds["Left Shoulder"].C0,
        ["Right Shoulder"] = v2.Motor6Ds["Right Shoulder"].C0,
        ["Left Hip"] = v2.Motor6Ds["Left Hip"].C0,
        ["Right Hip"] = v2.Motor6Ds["Right Hip"].C0,
        Neck = v2.Motor6Ds.Neck.C0,
        RootJoint = v2.Motor6Ds.RootJoint.C0,
    }
    v2.C1s = {
        ["Left Shoulder"] = v2.Motor6Ds["Left Shoulder"].C1,
        ["Right Shoulder"] = v2.Motor6Ds["Right Shoulder"].C1,
        ["Left Hip"] = v2.Motor6Ds["Left Hip"].C1,
        ["Right Hip"] = v2.Motor6Ds["Right Hip"].C1,
        RootJoint = v2.Motor6Ds.RootJoint.C1,
    }
    v2.Part0s = {
        ["Left Shoulder"] = v2.Motor6Ds["Left Shoulder"].Part0,
        ["Right Shoulder"] = v2.Motor6Ds["Right Shoulder"].Part0,
        ["Left Hip"] = v2.Motor6Ds["Left Hip"].Part0,
        ["Right Hip"] = v2.Motor6Ds["Right Hip"].Part0,
        RootJoint = v2.Motor6Ds.RootJoint.Part0,
    }
    v2.Part1s = {
        ["Left Shoulder"] = v2.Motor6Ds["Left Shoulder"].Part1,
        ["Right Shoulder"] = v2.Motor6Ds["Right Shoulder"].Part1,
        ["Left Hip"] = v2.Motor6Ds["Left Hip"].Part1,
        ["Right Hip"] = v2.Motor6Ds["Right Hip"].Part1,
        RootJoint = v2.Motor6Ds.RootJoint.Part1,
    }
    v2.LeftUpperArmLength = 1
    v2.LeftLowerArmLength = 1
    v2.RightUpperArmLength = 1
    v2.RightLowerArmLength = 1
    v2.LeftUpperLegLength = 1
    v2.LeftLowerLegLength = 1
    v2.RightUpperLegLength = 1
    v2.RightLowerLegLength = 1
    return v2
end

function u4.ArmIK(p1, p2, p3) -- Line: 211 -- upvalues: SolveArmIK (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    if p2 == "Left" then
        v5 = p1.Torso.CFrame * p1.C0s["Left Shoulder"]
        v6 = p1.C1s["Left Shoulder"]
        v7, v8, v9 = SolveArmIK(v5, p3, p1.LeftUpperArmLength, p1.LeftLowerArmLength, v6, p2)
        v10 = CFrame.Angles(v8, 0, 0)
        v1 = CFrame.Angles(v9, 0, 0)
        v2 = v7 * v10 * (CFrame.new(0, -p1.LeftUpperArmLength * 0.5, 0)) * CFrame.new(0, -p1.LeftUpperArmLength * 0.5, 0) * v1 * CFrame.new(0, -p1.LeftLowerArmLength * 0.5, 0) * CFrame.new(0, (p1.LeftArm.Size.Y - p1.LeftLowerArmLength) * 0.5, 0)
        v3 = p1.Motor6Ds["Left Shoulder"]
        v4 = p1.Motor6Ds["Left Shoulder"]
        local CFrame_2 = v4.Part0.CFrame
        local C1 = v4.C1
        v3.C0 = CFrame_2:inverse() * v2 * C1
        return
    end
    if p2 == "Right" then
        v5 = p1.Torso.CFrame * p1.C0s["Right Shoulder"]
        v6 = p1.C1s["Right Shoulder"]
        v7, v8, v9 = SolveArmIK(v5, p3, p1.RightUpperArmLength, p1.RightLowerArmLength, v6, p2)
        v10 = CFrame.Angles(v8, 0, 0)
        v1 = CFrame.Angles(v9, 0, 0)
        v2 = v7 * v10 * (CFrame.new(0, -p1.RightUpperArmLength * 0.5, 0)) * CFrame.new(0, -p1.RightUpperArmLength * 0.5, 0) * v1 * CFrame.new(0, -p1.RightLowerArmLength * 0.5, 0) * CFrame.new(0, (p1.RightArm.Size.Y - p1.RightLowerArmLength) * 0.5, 0)
        v3 = p1.Motor6Ds["Right Shoulder"]
        v4 = p1.Motor6Ds["Right Shoulder"]
        local CFrame_3 = v4.Part0.CFrame
        local C1_2 = v4.C1
        v3.C0 = CFrame_3:inverse() * v2 * C1_2
    end
end

function u4.LegIK(p1, p2, p3) -- Line: 249 -- upvalues: SolveLegIK (val), UpdateC0IfChanged (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    if p2 == "Left" then
        v5 = p1.Torso.CFrame * p1.C0s["Left Hip"]
        v6 = p1.C1s["Left Hip"]
        v7 = SolveLegIK
        v7, v8, v9 = v7(v5 * CFrame.Angles(0, 1.5707963267948966, 0), p3, p1.LeftUpperLegLength, p1.LeftLowerLegLength, v6)
        v10 = CFrame.Angles(v8, 0, 0)
        v1 = CFrame.Angles(v9, 0, 0)
        v2 = v7 * v10 * (CFrame.new(0, -p1.LeftUpperLegLength * 0.5, 0)) * CFrame.new(0, -p1.LeftUpperLegLength * 0.5, 0) * v1 * CFrame.new(0, -p1.LeftLowerLegLength * 0.5, 0) * CFrame.new(0, (p1.LeftLeg.Size.Y - p1.LeftLowerLegLength) * 0.5, 0)
        v3 = p1.Motor6Ds["Left Hip"]
        local CFrame_2 = v3.Part0.CFrame
        local C1 = v3.C1
        v4 = (CFrame_2:inverse()) * v2 * C1
        v3 = UpdateC0IfChanged
        v3(p1.Motor6Ds["Left Hip"], v4, p1.isLocalPlayer)
        return
    end
    if p2 == "Right" then
        v5 = p1.Torso.CFrame * p1.C0s["Right Hip"]
        v6 = p1.C1s["Right Hip"]
        v7 = SolveLegIK
        v7, v8, v9 = v7(v5 * CFrame.Angles(0, -1.5707963267948966, 0), p3, p1.RightUpperLegLength, p1.RightLowerLegLength, v6)
        v10 = CFrame.Angles(v8, 0, 0)
        v1 = CFrame.Angles(v9, 0, 0)
        v2 = v7 * v10 * (CFrame.new(0, -p1.RightUpperLegLength * 0.5, 0)) * CFrame.new(0, -p1.RightUpperLegLength * 0.5, 0) * v1 * CFrame.new(0, -p1.RightLowerLegLength * 0.5, 0) * CFrame.new(0, (p1.RightLeg.Size.Y - p1.RightLowerLegLength) * 0.5, 0)
        v3 = p1.Motor6Ds["Right Hip"]
        local CFrame_3 = v3.Part0.CFrame
        local C1_2 = v3.C1
        v4 = (CFrame_3:inverse()) * v2 * C1_2
        v3 = UpdateC0IfChanged
        v3(p1.Motor6Ds["Right Hip"], v4, p1.isLocalPlayer)
    end
end

return u4