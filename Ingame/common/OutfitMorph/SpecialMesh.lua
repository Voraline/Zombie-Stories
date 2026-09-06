local CollectionService = game:GetService("CollectionService")
local u5 = {TAG = "OutfitMorphSpecialMesh"}
local u7 = {
    "Head",
    "Torso",
    "Left Arm",
    "Right Arm",
    "Left Leg",
    "Right Leg",
}
local function bodyPartFor(p1, p2, p3) -- Line: 9
    local v1
    if not p3 then
        v1 = p1:FindFirstChild(p2)
        if v1 then
            if v1:IsA("BasePart") then
                return v1
            end
            return nil
        end
        return nil
    end
    local fakebodyparts = p1:FindFirstChild("fakebodyparts")
    local v2 = fakebodyparts
    if v2 then
        v2 = fakebodyparts:FindFirstChild("Fake" .. p2)
    end
    if not v2 then
        v1 = p1:FindFirstChild(p2)
        if v1 then
            if v1:IsA("BasePart") then
                return v1
            end
            return nil
        end
        return nil
    end
    if v2:IsA("BasePart") then
        return v2
    end
    v1 = p1:FindFirstChild(p2)
    if not v1 then
        return nil
    end
    if v1:IsA("BasePart") then
        return v1
    end
    return nil
end
local function removeBodyMover(p1) -- Line: 22
    local v1 = p1:IsA("BodyVelocity")
    if not v1 then
        v1 = p1:IsA("BodyPosition")
        if not v1 then
            v1 = p1:IsA("BodyAngularVelocity")
            if not v1 then
                v1 = p1:IsA("BodyForce")
                if not v1 then
                    v1 = p1:IsA("BodyThrust")
                    if not v1 then
                        v1 = p1:IsA("BodyGyro")
                    end
                end
            end
        end
    end
    return v1
end
function u5.Matches(p1) -- Line: 31
    local v1 = if p1 ~= nil then if p1:GetAttribute("SpecialMeshOutfit") ~= true then p1.Name == "XXiiOmq_TrueHyperGameriiXX" else true else false
    return v1
end
function u5.Cleanup(p1, p2) -- Line: 36 -- upvalues: CollectionService (val), u5 (val), u7 (val), bodyPartFor (val)
    local v1, v2, v3, v4
    for i, v in ipairs(p1:GetDescendants()) do
        if CollectionService:HasTag(v, u5.TAG) then
            v:Destroy()
        elseif v:IsA("WeldConstraint") and v.Name:match("MeshWeld$") then
            v:Destroy()
        end
    end
    for i2, i3 in ipairs(p1:GetChildren()) do
        if i3:IsA("MeshPart") and i3.Name:match("Mesh$") then
            i3:Destroy()
        end
    end
    v1, v2 = p1, p2
    for i4, j in ipairs(u7) do
        v3 = v2
        if v3 then
            v3 = v2.FakeBodyParts == true
        end
        v4 = bodyPartFor(v1, j, v3)
        if v4 then
            v4.Transparency = 0
        end
    end
end
function u5.Apply(p1, p2, p3) -- Line: 59 -- upvalues: u5 (val), bodyPartFor (val), removeBodyMover (val), CollectionService (val)
    local WeldConstraint, v1, v2, v3, v4, v5, v6
    u5.Cleanup(p1, p3)
    v4, v1, v2 = p3, p1, p2
    for i, v in ipairs(p1:GetChildren()) do
        if v:IsA("Shirt") then
            v:Destroy()
        elseif not (v:IsA("Pants")) and not (v:IsA("CharacterMesh")) and not (v:IsA("Accessory")) and v.ClassName ~= "Hat" then
        end
    end
    if not v4 then
        local Head = v1:FindFirstChild("Head")
        local Decal = Head
        if Decal then
            Decal = Head:FindFirstChildOfClass("Decal")
        end
        if Decal then
            Decal:Destroy()
        end
    elseif v4.KeepPlayerFace == true then
    end
    for i2, i3 in ipairs(v2:GetChildren()) do
        if i3:IsA("MeshPart") and i3.Name ~= "HumanoidRootPart" then
            v3 = v4
            if v3 then
                v3 = v4.FakeBodyParts == true
            end
            v5 = bodyPartFor(v1, i3.Name, v3)
            if v5 then
                v6 = i3:Clone()
                v6.Name = i3.Name .. "Mesh"
                v6.CanCollide = false
                v6.CanTouch = false
                v6.CanQuery = false
                v6.Anchored = false
                v6.Massless = true
                for i4, j in ipairs(v6:GetDescendants()) do
                    if j:IsA("BasePart") then
                        j.CanCollide = false
                        j.CanTouch = false
                        j.CanQuery = false
                        j.Anchored = false
                        j.Massless = true
                    elseif removeBodyMover(j) then
                        j:Destroy()
                    end
                end
                CollectionService:AddTag(v6, u5.TAG)
                v6.Parent = v1
                v6.CFrame = v5.CFrame
                WeldConstraint = Instance.new("WeldConstraint")
                WeldConstraint.Name = i3.Name .. "MeshWeld"
                WeldConstraint.Part0 = v5
                WeldConstraint.Part1 = v6
                WeldConstraint.Enabled = true
                WeldConstraint.Parent = v6
                v5.Transparency = 1
            end
        end
    end
    for i5, k in ipairs(v1:GetDescendants()) do
        if k:IsA("JointInstance") then
            if not k.Part0 then
                k:Destroy()
            elseif k.Part1 then
            end
        end
    end
end
return u5