local v1 = {}
local u1 = {}
local v2 = {CFrame.new(0, 1, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1), CFrame.new(0, -0.5, 0, 0, -1, 0, 1, 0, -0, 0, 0, 1)}
u1.Neck = v2
v2 = {
    CFrame.new(-1.3, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1),
    CFrame.new(0.2, 0.75, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1),
}
u1["Left Shoulder"] = v2
v2 = {
    CFrame.new(1.3, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    CFrame.new(-0.2, 0.75, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
}
u1["Right Shoulder"] = v2
v2 = {CFrame.new(-0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1)}
u1["Left Hip"] = v2
v2 = {CFrame.new(0.5, -1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1), CFrame.new(0, 1, 0, 0, 1, -0, -1, 0, 0, 0, 0, 1)}
u1["Right Hip"] = v2
local u147 = {RagdollAttachment = true, RagdollConstraint = true, ColliderPart = true}

local function createColliderPart(p1) -- Line: 22
    if not p1 then
        return
    end
    local Part = Instance.new("Part")
    Part.Name = "ColliderPart"
    Part.Size = p1.Size / 1.7
    Part.CustomPhysicalProperties = PhysicalProperties.new(Enum.Material.Metal)
    Part.CFrame = p1.CFrame
    Part.Transparency = 1
    Part.CollisionGroup = "NPCRagdoll"
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = Part
    WeldConstraint.Part1 = p1
    WeldConstraint.Parent = Part
    Part.Parent = p1
    return Part
end

function replaceJoints(p1) -- Line: 44 -- upvalues: u1 (val), createColliderPart (val)
    local Attachment, BallSocketConstraint, v1
    for k, v in pairs(p1:GetDescendants()) do
        if v:IsA("Motor6D") and u1[v.Name] then
            v.Enabled = false
            v1 = Instance.new("Attachment")
            Attachment = Instance.new("Attachment")
            v1.CFrame = u1[v.Name][1]
            Attachment.CFrame = u1[v.Name][2]
            v1.Name = "RagdollAttachment"
            Attachment.Name = "RagdollAttachment"
            createColliderPart(v.Part1)
            BallSocketConstraint = Instance.new("BallSocketConstraint")
            BallSocketConstraint.Attachment0 = v1
            BallSocketConstraint.Attachment1 = Attachment
            BallSocketConstraint.Name = "RagdollConstraint"
            BallSocketConstraint.Radius = 0.15
            BallSocketConstraint.LimitsEnabled = true
            BallSocketConstraint.TwistLimitsEnabled = false
            BallSocketConstraint.MaxFrictionTorque = 0
            BallSocketConstraint.Restitution = 0
            BallSocketConstraint.UpperAngle = 90
            BallSocketConstraint.TwistLowerAngle = -45
            BallSocketConstraint.TwistUpperAngle = 45
            if v.Name == "Neck" then
                BallSocketConstraint.TwistLimitsEnabled = true
                BallSocketConstraint.UpperAngle = 45
                BallSocketConstraint.TwistLowerAngle = -70
                BallSocketConstraint.TwistUpperAngle = 70
            end
            v1.Parent = v.Part0
            Attachment.Parent = v.Part1
            BallSocketConstraint.Parent = v.Parent
        end
    end
end

function v1.Ragdoll(p1) -- Line: 102
    replaceJoints(p1)
end

function v1.UnRagdoll(p1) -- Line: 106 -- upvalues: u147 (val)
    for k, v in pairs(p1:GetDescendants()) do
        if u147[v.Name] then
            v:Destroy()
        end
        if v:IsA("Motor6D") then
            v.Enabled = true
        end
    end
end

return v1