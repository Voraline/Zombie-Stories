local CollectionService = game:GetService("CollectionService")
local u5 = {TAG = "OutfitMorphSpecialMesh"}
local u7 = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

local function bodyPartFor(p1, p2, p3) -- Line: 9
    if p3 then
        local fakebodyparts = p1:FindFirstChild("fakebodyparts")
        local v1 = fakebodyparts
        if v1 then
            local v2 = "Fake" .. p2
            v1 = fakebodyparts:FindFirstChild(v2)
        end
        if v1 and v1:IsA("BasePart") then
            return v1
        end
    end
    local v3 = p1:FindFirstChild(p2)
    if v3 and v3:IsA("BasePart") then
        return v3
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
    local v1 = false
    if p1 ~= nil then
        v1 = true
        if p1:GetAttribute("SpecialMeshOutfit") ~= true then
            v1 = p1.Name == "XXiiOmq_TrueHyperGameriiXX"
        end
    end
    return v1
end

function u5.Cleanup(p1, p2) -- Line: 36 -- upvalues: CollectionService (val), u5 (val), u7 (val), bodyPartFor (val)
    local TAG, v1, v2
    for i, v in ipairs(p1:GetDescendants()) do
        v2 = CollectionService
        v1 = u5
        TAG = v1.TAG
        if v2:HasTag(v, TAG) or v:IsA("WeldConstraint") and v.Name:match("MeshWeld$") then
            v:Destroy()
        end
    end
    for i2, i3 in ipairs(p1:GetChildren()) do
        if i3:IsA("MeshPart") and i3.Name:match("Mesh$") then
            i3:Destroy()
        end
    end
    local v3, v4 = p1, p2
    for i4, j in ipairs(u7) do
        v2 = bodyPartFor
        v1 = v4
        if v1 then
            v1 = v4.FakeBodyParts == true
        end
        v2 = v2(v3, j, v1)
        if v2 then
            v2.Transparency = 0
        end
    end
end

function u5.Apply(p1, p2, p3) -- Line: 59
    -- upvalues: u5 (val), bodyPartFor (val), removeBodyMover (val), CollectionService (val)
    local Name, TAG, WeldConstraint, v1, v2, v3, v4, v5
    u5.Cleanup(p1, p3)
    local v6, v7, v8 = p3, p1, p2
    for i, v in ipairs(p1:GetChildren()) do
        if v:IsA("Shirt")
            or v:IsA("Pants")
            or v:IsA("CharacterMesh")
            or v:IsA("Accessory")
            or v.ClassName == "Hat" then
            v:Destroy()
        end
    end
    if not v6 or v6.KeepPlayerFace ~= true then
        local Head = v7:FindFirstChild("Head")
        local Decal = Head
        if Decal then
            Decal = Head:FindFirstChildOfClass("Decal")
        end
        if Decal then
            Decal:Destroy()
        end
    end
    for i2, i3 in ipairs(v8:GetChildren()) do
        if i3:IsA("MeshPart") and i3.Name ~= "HumanoidRootPart" then
            v4 = bodyPartFor
            Name = i3.Name
            v2 = v6
            if v2 then
                v2 = v6.FakeBodyParts == true
            end
            v4 = v4(v7, Name, v2)
            if v4 then
                v5 = i3:Clone()
                v5.Name = i3.Name .. "Mesh"
                v5.CanCollide = false
                v5.CanTouch = false
                v5.CanQuery = false
                v5.Anchored = false
                v5.Massless = true
                for i4, j in ipairs(v5:GetDescendants()) do
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
                v1 = CollectionService
                v3 = u5
                TAG = v3.TAG
                v1:AddTag(v5, TAG)
                v5.Parent = v7
                v5.CFrame = v4.CFrame
                WeldConstraint = Instance.new("WeldConstraint")
                WeldConstraint.Name = i3.Name .. "MeshWeld"
                WeldConstraint.Part0 = v4
                WeldConstraint.Part1 = v5
                WeldConstraint.Enabled = true
                WeldConstraint.Parent = v5
                v4.Transparency = 1
            end
        end
    end
    for i5, k in ipairs(v7:GetDescendants()) do
        if k:IsA("JointInstance") then
            if not k.Part0 or not k.Part1 then
                k:Destroy()
            end
        end
    end
end

return u5