local findFirstMatchingAttachment
local u0 = {}

local function weldAttachments(p1, p2) -- Line: 3
    local Weld = Instance.new("Weld")
    Weld.Part0 = p1.Parent
    Weld.Part1 = p2.Parent
    Weld.C0 = p1.CFrame
    Weld.C1 = p2.CFrame
    Weld.Parent = p1.Parent
    return Weld
end

function findFirstMatchingAttachment(p1, p2) -- Line: 13 -- upvalues: findFirstMatchingAttachment (val)
    local v1
    local v2 = p2
    for i, v in ipairs(p1:GetChildren()) do
        if v:IsA("Attachment") and v.Name == v2 then
            return v
        end
        if not v:IsA("Accoutrement") and not v:IsA("Tool") then
            v1 = findFirstMatchingAttachment(v, v2)
            if v1 then
                return v1
            end
        end
    end
    return nil
end

local function sourceFace(p1) -- Line: 27
    local Decal
    local Head = p1
    if Head then
        Head = p1:FindFirstChild("Head")
    end
    if not Head then
        Decal = p1
        if Decal then
            Decal = p1:FindFirstChildOfClass("Decal")
        end
    else
        Decal = Head:FindFirstChildOfClass("Decal")
        if not Decal then
            Decal = p1
            if Decal then
                Decal = p1:FindFirstChildOfClass("Decal")
            end
        end
    end
    return Decal
end

local function applyPlayerFace(p1, p2, p3) -- Line: 32
    local Head = p1:FindFirstChild("Head")
    if not Head then
        return
    end
    local Decal = Head:FindFirstChildOfClass("Decal")
    if p3 == false then
        if Decal then
            Decal:Destroy()
        end
        return
    end
    local Head_2 = p2
    if Head_2 then
        Head_2 = p2:FindFirstChild("Head")
    end
    local v1 = Head_2 and Head_2:FindFirstChildOfClass("Decal") or p2 and p2:FindFirstChildOfClass("Decal")
    if not v1 then
        return
    end
    if Decal then
        Decal:Destroy()
    end
    v1:Clone().Parent = Head
end

local function applyBodyColors(p1, p2) -- Line: 57
    local BodyColors = p2
    if BodyColors then
        BodyColors = p2:FindFirstChildOfClass("BodyColors")
    end
    if not BodyColors then
        return
    end
    local BodyColors_2 = p1:FindFirstChildOfClass("BodyColors")
    if BodyColors_2 then
        BodyColors_2:Destroy()
    end
    BodyColors:Clone().Parent = p1
end

local function cloneCharacterMeshes(p1, p2) -- Line: 70
    local function cloneFrom(p1_2) -- Line: 71 -- upvalues: p1 (val)
        local v1
        for i, v in ipairs(p1_2:GetDescendants()) do
            if v:IsA("CharacterMesh") then
                v1 = v:Clone()
                v1.Parent = p1
            end
        end
    end

    for i, v in ipairs(p2:GetChildren()) do
        if v:IsA("CharacterMesh") then
            v:Clone().Parent = p1
        elseif v.Name == "R6" then
            cloneFrom(v)
        end
    end
end

function u0.AttachAccessory(p1, p2) -- Line: 88 -- upvalues: findFirstMatchingAttachment (val)
    for i, v in ipairs(p2:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = false
        end
    end
    p2.Parent = p1
    local Handle = p2:FindFirstChild("Handle")
    local Attachment = Handle
    if Attachment then
        Attachment = Handle:FindFirstChildOfClass("Attachment")
    end
    local v1 = Attachment
    if v1 then
        v1 = findFirstMatchingAttachment(p1, Attachment.Name)
    end
    if v1 then
        local Weld = Instance.new("Weld")
        Weld.Part0 = v1.Parent
        Weld.Part1 = Attachment.Parent
        Weld.C0 = v1.CFrame
        Weld.C1 = Attachment.CFrame
        Weld.Parent = v1.Parent
    end
end

function u0.ApplyBaseAppearance(p1, p2) -- Line: 104 -- upvalues: applyPlayerFace (val)
    local AppearanceSource = p2.AppearanceSource
    if not AppearanceSource then
        return true
    end
    local BodyColors = AppearanceSource
    if BodyColors then
        BodyColors = AppearanceSource:FindFirstChildOfClass("BodyColors")
    end
    if BodyColors then
        local BodyColors_2 = p1:FindFirstChildOfClass("BodyColors")
        if BodyColors_2 then
            BodyColors_2:Destroy()
        end
        BodyColors:Clone().Parent = p1
    end
    applyPlayerFace(p1, AppearanceSource, p2.KeepPlayerFace)
    return true
end

function u0.ApplyPlayerAccessories(p1, p2) -- Line: 115 -- upvalues: u0 (val)
    local AppearanceSource = p2.AppearanceSource
    if not AppearanceSource then
        return true
    end
    for i, v in ipairs(AppearanceSource:GetChildren()) do
        if v:IsA("Accessory") then
            u0.AttachAccessory(p1, v:Clone())
        end
    end
    return true
end

function u0.ApplyFullAvatar(p1, p2) -- Line: 129 -- upvalues: u0 (val), cloneCharacterMeshes (val)
    local AppearanceSource = p2.AppearanceSource
    if not AppearanceSource then
        return false, "appearance source unavailable"
    end
    u0.ApplyBaseAppearance(p1, p2)
    local v1, v2 = p1, p2
    for i, v in ipairs(AppearanceSource:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
            v:Clone().Parent = v1
        end
    end
    cloneCharacterMeshes(v1, AppearanceSource)
    u0.ApplyPlayerAccessories(v1, v2)
    return true
end

return u0