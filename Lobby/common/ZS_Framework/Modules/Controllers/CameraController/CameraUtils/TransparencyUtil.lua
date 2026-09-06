local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local u20 = {}
local u21 = {}
local u22 = {}
local u23 = {}
local u24 = {}
local u25 = {}
local LocalPlayerController = require(script.Parent.Parent.Parent:WaitForChild("LocalPlayerController"))
local OutfitMorph = require(ReplicatedStorage.common:WaitForChild("OutfitMorph"))
local u39 = {TransparencyModifier = 1}
local v1 = {}
v1["Left Arm"] = 0
v1["Right Arm"] = 0
v1["Left Leg"] = 0
v1["Right Leg"] = 0
v1.Torso = 0
v1.HumanoidRootPart = 0
u39.CustomList = v1
local function disconnectCharacterConnections() -- Line: 38 -- upvalues: u25 (val)
    local v1 = u25
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        j:Disconnect()
    end
    table.clear(u25)
end
function u39.Init(p1) -- Line: 45 -- upvalues: LocalPlayerController (val), u25 (val)
    LocalPlayerController.CharacterChanged:Connect(function(p1) -- Line: 46 -- upvalues: u25 (upval)
        local v1 = u25
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            j:Disconnect()
        end
        table.clear(u25)
        if p1 then
            SetupCharacter(p1)
        end
    end)
    if LocalPlayerController.character then
        SetupCharacter(LocalPlayerController.character)
    end
end
function u39.Update(p1) -- Line: 57
    UpdateTransparency()
end
local function isTurkeyRigPart(p1) -- Line: 62 -- upvalues: LocalPlayer (val)
    if not p1 then
        return false
    end
    local Parent = p1.Parent
    while Parent do
        if Parent == LocalPlayer.Character then
            break
        end
        if Parent:IsA("Model") and string.find(Parent.Name, "_TurkeyRig") then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end
local function isSpecialOutfitPart(p1) -- Line: 78 -- upvalues: LocalPlayer (val), CollectionService (val), OutfitMorph (val)
    local Parent = p1
    while Parent do
        if Parent == LocalPlayer.Character then
            break
        end
        if Parent.Name ~= "HeadMesh" and CollectionService:HasTag(Parent, OutfitMorph.SpecialMeshTag) then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end
local function applyPartTransparency(p1) -- Line: 89 -- upvalues: isTurkeyRigPart (val), u39 (val), isSpecialOutfitPart (val)
    local TransparencyModifier
    p1.CastShadow = false
    if p1.Name ~= "Torso" then
        if isSpecialOutfitPart(p1) then
            p1.LocalTransparencyModifier = 0
            return
        end
        TransparencyModifier = u39.CustomList[p1.Name]
        if not TransparencyModifier then
            TransparencyModifier = u39.TransparencyModifier
        end
        p1.LocalTransparencyModifier = TransparencyModifier
        return
    end
    if isTurkeyRigPart(p1) then
        p1.LocalTransparencyModifier = u39.TransparencyModifier
        return
    end
    if isSpecialOutfitPart(p1) then
        p1.LocalTransparencyModifier = 0
        return
    end
    TransparencyModifier = u39.CustomList[p1.Name]
    if not TransparencyModifier then
        TransparencyModifier = u39.TransparencyModifier
    end
    p1.LocalTransparencyModifier = TransparencyModifier
end
local function applyDecalTransparency(p1, p2) -- Line: 101 -- upvalues: u39 (val)
    if u39.TransparencyModifier == 1 then
        p1.Transparency = 1
        return
    end
    p1.Transparency = p2
end
function UpdateTransparency() -- Line: 111 -- upvalues: u20 (val), u23 (val), isTurkeyRigPart (val), u39 (val), isSpecialOutfitPart (val), u21 (val), u24 (val), u22 (val)
    local TransparencyModifier, v1, v2, v3
    local v4 = 1
    local v5 = #u20
    local v6 = 1
    for i = 1, v5, v6 do
        v1 = u20[i]
        if not v1.Parent then
            u23[v1] = nil
        else
            u20[v4] = v1
            u23[v1] = v4
            v4 = v4 + 1
            v1.CastShadow = false
            if v1.Name ~= "Torso" then
                if not (isSpecialOutfitPart(v1)) then
                    TransparencyModifier = u39.CustomList[v1.Name]
                    if not TransparencyModifier then
                        TransparencyModifier = u39.TransparencyModifier
                    end
                    v1.LocalTransparencyModifier = TransparencyModifier
                else
                    v1.LocalTransparencyModifier = 0
                end
            elseif isTurkeyRigPart(v1) then
                v1.LocalTransparencyModifier = u39.TransparencyModifier
            end
        end
    end
    v5 = #u20
    v6 = 1
    for j = v4, v5, v6 do
        u20[j] = nil
    end
    v5 = 1
    v6 = #u21
    local v7 = 1
    for k = 1, v6, v7 do
        v2 = u21[k]
        if not v2.Parent then
            u24[v2] = nil
            u22[v2] = nil
        else
            u21[v5] = v2
            u24[v2] = v5
            v5 = v5 + 1
            v3 = u22[v2]
            if u39.TransparencyModifier ~= 1 then
                v2.Transparency = v3
            else
                v2.Transparency = 1
            end
        end
    end
    v6 = #u21
    v7 = 1
    for n = v5, v6, v7 do
        u21[n] = nil
    end
end
function SetupCharacter(p1) -- Line: 146 -- upvalues: u25 (val), u20 (val), u21 (val), u22 (val), u23 (val), u24 (val), isTurkeyRigPart (val), u39 (val), isSpecialOutfitPart (val)
    local v1 = u25
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        j:Disconnect()
    end
    table.clear(u25)
    table.clear(u20)
    table.clear(u21)
    table.clear(u22)
    table.clear(u23)
    table.clear(u24)
    for k, n in p1:QueryDescendants("BasePart") do
        table.insert(u20, n)
        u23[n] = #u20
    end
    for m, i5 in p1:QueryDescendants("Decal, Texture") do
        table.insert(u21, i5)
        u24[i5] = #u21
        u22[i5] = i5.Transparency
    end
    table.insert(u25, p1.DescendantAdded:Connect(function(p1) -- Line: 165 -- upvalues: u23 (upval), u20 (upval), isTurkeyRigPart (upval), u39 (upval), isSpecialOutfitPart (upval), u24 (upval), u21 (upval), u22 (upval)
        local TransparencyModifier
        if p1:IsA("BasePart") then
            if not (u23[p1]) then
                table.insert(u20, p1)
                u23[p1] = #u20
            end
            p1.CastShadow = false
            if p1.Name ~= "Torso" then
                if isSpecialOutfitPart(p1) then
                    p1.LocalTransparencyModifier = 0
                    return
                end
                TransparencyModifier = u39.CustomList[p1.Name]
                if not TransparencyModifier then
                    TransparencyModifier = u39.TransparencyModifier
                end
                p1.LocalTransparencyModifier = TransparencyModifier
                return
            end
            if isTurkeyRigPart(p1) then
                p1.LocalTransparencyModifier = u39.TransparencyModifier
                return
            end
            if isSpecialOutfitPart(p1) then
                p1.LocalTransparencyModifier = 0
                return
            end
            TransparencyModifier = u39.CustomList[p1.Name]
            if not TransparencyModifier then
                TransparencyModifier = u39.TransparencyModifier
            end
            p1.LocalTransparencyModifier = TransparencyModifier
            return
        end
        if p1:IsA("Decal") then
            if not (u24[p1]) then
                table.insert(u21, p1)
                u24[p1] = #u21
                u22[p1] = p1.Transparency
            end
            local v1 = u22[p1]
            if u39.TransparencyModifier == 1 then
                p1.Transparency = 1
                return
            end
            p1.Transparency = v1
            return
        elseif not (p1:IsA("Texture")) then
            return
        end
    end))
    table.insert(u25, p1.DescendantRemoving:Connect(function(p1) -- Line: 182 -- upvalues: u23 (upval), u20 (upval), u24 (upval), u21 (upval), u22 (upval)
        local v1, v2
        if p1:IsA("BasePart") then
            v1 = u23[p1]
            if not v1 then
                return
            end
            v2 = u20[#u20]
            u20[v1] = v2
            u20[#u20] = nil
            u23[p1] = nil
            if v2 == p1 then
                return
            end
            u23[v2] = v1
            return
        end
        if p1:IsA("Decal") then
            v1 = u24[p1]
            if v1 then
                v2 = u21[#u21]
                u21[v1] = v2
                u21[#u21] = nil
                u24[p1] = nil
                u22[p1] = nil
                if v2 ~= p1 then
                    u24[v2] = v1
                end
            end
        elseif p1:IsA("Texture") then
            v1 = u24[p1]
            if v1 then
                v2 = u21[#u21]
                u21[v1] = v2
                u21[#u21] = nil
                u24[p1] = nil
                u22[p1] = nil
                if v2 ~= p1 then
                    u24[v2] = v1
                end
            end
        end
    end))
    UpdateTransparency()
end
return u39