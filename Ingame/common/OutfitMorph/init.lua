local RunService = game:GetService("RunService")
local Client = require(script.Backends.Client)
local Server = require(script.Backends.Server)
local OutfitVFX = require(script.OutfitVFX)
local SpecialMesh = require(script.SpecialMesh)
local Watcher = require(script.Watcher)
local u27 = {}
u27.SpecialMeshTag = SpecialMesh.TAG

local function copyOptions(p1) -- Line: 23
    local v1 = {}
    local v2 = pairs
    local v3 = p1 or {}
    for k, v in v2(v3) do
        v1[k] = v
    end
    return v1
end

local function backendFor(p1) -- Line: 31 -- upvalues: RunService (val), Server (val), Client (val)
    local Backend = p1.Backend
    if Backend == nil then
        if not RunService:IsServer() then
            Backend = "Client"
        else
            Backend = "Server"
        end
    end
    if Backend == "Server" then
        return Server, Backend
    end
    if Backend == "Client" then
        return Client, Backend
    end
    error("Invalid OutfitMorph backend: " .. tostring(Backend), 3)
end

local function cleanBrokenJoints(p1) -- Line: 46
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("JointInstance") then
            if not v.Part0 or not v.Part1 then
                v:Destroy()
            end
        end
    end
end

local function clearClothingAndAccessories(p1) -- Line: 54
    for i, v in ipairs(p1:GetChildren()) do
        if v:IsA("Shirt")
            or v:IsA("Pants")
            or v:IsA("ShirtGraphic")
            or v:IsA("CharacterMesh")
            or v:IsA("BodyColors")
            or v:IsA("Accessory")
            or v.ClassName == "Hat" then
            v:Destroy()
        end
    end
end

local function cleanupArtifacts(p1, p2) -- Line: 70 -- upvalues: SpecialMesh (val), OutfitVFX (val)
    SpecialMesh.Cleanup(p1, p2)
    OutfitVFX.Cleanup(p1, p2)
end

function u27.Cleanup(p1, p2) -- Line: 75 -- upvalues: Watcher (val), SpecialMesh (val), OutfitVFX (val)
    Watcher.Cancel(p1)
    local v1 = p2 or {}
    SpecialMesh.Cleanup(p1, v1)
    OutfitVFX.Cleanup(p1, v1)
end

function u27.IsSpecialMeshOutfit(p1) -- Line: 80 -- upvalues: SpecialMesh (val)
    return SpecialMesh.Matches(p1)
end

function u27.VfxTagFor(p1) -- Line: 84 -- upvalues: OutfitVFX (val)
    return OutfitVFX.VfxTagFor(p1)
end

function u27.ApplyOutfitClothing(p1, p2, p3) -- Line: 88 -- upvalues: Watcher (val)
    local ClassName, v1, v2
    if not p2 then
        return
    end
    local v3 = p1
    for i, v in ipairs(p2:GetChildren()) do
        if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then
            ClassName = v.ClassName
            v1 = v3:FindFirstChildOfClass(ClassName)
            if v1 then
                v1:Destroy()
            end
            v2 = v:Clone()
            Watcher.AllowCurrent(v3, v2)
            v2.Parent = v3
        end
    end
end

function u27.ApplyOutfitAccessories(p1, p2, p3) -- Line: 107
    -- upvalues: RunService (val), Server (val), Client (val), Watcher (val), cleanBrokenJoints (val)
    local v1, v2, v3
    if not p2 then
        return
    end
    local v4 = p3 or {}
    local Backend = v4.Backend
    if Backend == nil then
        if not RunService:IsServer() then
            Backend = "Client"
        else
            Backend = "Server"
        end
    end
    if Backend == "Server" then
        v2 = Server
        v3 = Backend
    elseif Backend ~= "Client" then
        error("Invalid OutfitMorph backend: " .. tostring(Backend), 3)
        v2 = nil
        v3 = nil
    else
        v2 = Client
        v3 = Backend
    end
    local Head = p1:FindFirstChild("Head")
    local Clothing = script:FindFirstChild("Clothing")
    local headmesh = Clothing
    if headmesh then
        headmesh = Clothing:FindFirstChild("headmesh")
    end
    if Head and headmesh then
        local SpecialMesh = Head:FindFirstChildOfClass("SpecialMesh")
        if SpecialMesh then
            SpecialMesh:Destroy()
        end
        headmesh:Clone().Parent = Head
    end
    local v5 = p1
    for i, v in ipairs(p2:GetChildren()) do
        if v:IsA("Accessory") then
            v1 = v:Clone()
            for i2, i3 in ipairs(v1:GetDescendants()) do
                if i3:IsA("BasePart") then
                    i3.Anchored = false
                end
            end
            Watcher.AllowCurrent(v5, v1)
            if v3 ~= "Client" then
                v1.Parent = v5
            else
                v2.AttachAccessory(v5, v1)
            end
        end
    end
    cleanBrokenJoints(v5)
end

function u27.Apply(p1, p2, p3) -- Line: 146
    -- upvalues: copyOptions (val), RunService (val), Server (val), Client (val), Watcher (val), SpecialMesh (val)
    -- upvalues: OutfitVFX (val), clearClothingAndAccessories (val), u27 (val)
    local v1, v2, v3, v4
    local v5 = p1
    if v5 then
        v5 = p1:IsA("Model")
    end
    assert(v5, "OutfitMorph.Apply requires a character Model")
    v5 = type(p3) == "table"
    assert(v5, "OutfitMorph.Apply requires options")
    local u25 = copyOptions(p3)
    v5 = p3.Morph == true
    u25.Morph = v5
    v5 = p3.UseOutfitHats == true
    u25.UseOutfitHats = v5
    if u25.KeepPlayerFace == nil then
        u25.KeepPlayerFace = true
    end
    local Backend = u25.Backend
    if Backend == nil then
        if not RunService:IsServer() then
            Backend = "Client"
        else
            Backend = "Server"
        end
    end
    if Backend == "Server" then
        v5 = Server
        v3 = Backend
    elseif Backend ~= "Client" then
        error("Invalid OutfitMorph backend: " .. tostring(Backend), 3)
        v5 = nil
        v3 = nil
    else
        v5 = Client
        v3 = Backend
    end
    local u78 = false
    if u25.Player ~= nil then
        u78 = false
        if u25.Player.Character == p1 then
            u78 = p1.Parent ~= nil
        end
    end
    local u83 = Watcher.Begin(p1)

    local function jobIsCurrent() -- Line: 162 -- upvalues: Watcher (upval), u83 (val), u78 (val), u25 (val), p1 (val)
        if not Watcher.IsCurrent(u83) then
            return false
        end
        if not u78 then
            return true
        end
        if u25.Player.Character == p1 and p1.Parent ~= nil then
            return true
        end
        Watcher.Finish(u83)
        return false
    end

    SpecialMesh.Cleanup(p1, u25)
    OutfitVFX.Cleanup(p1, u25)
    if not Watcher.IsCurrent(u83) then
        v4 = false
    elseif not u78 then
        v4 = true
    elseif u25.Player.Character ~= p1 then
        Watcher.Finish(u83)
        v4 = false
    elseif p1.Parent ~= nil then
        v4 = true
    else
        Watcher.Finish(u83)
        v4 = false
    end
    if not v4 then
        return false, "superseded"
    end
    clearClothingAndAccessories(p1)
    if not u25.Morph then
        Watcher.Arm(u83, "Off")
        v4, v1 = v5.ApplyFullAvatar(p1, u25)
        Watcher.Finish(u83)
        return v4, v1
    end
    v4 = SpecialMesh.Matches(p2)
    v1 = false
    if v3 == "Server" then
        v1 = u78
    end
    local v6 = "Off"
    if v1 then
        if v4 then
            v6 = "Strict"
        elseif not u25.UseOutfitHats then
            v6 = "ClothingOnly"
        else
            v6 = "Strict"
        end
    end
    Watcher.Arm(u83, v6)
    local v7 = u25
    if v4 then
        v7 = copyOptions(u25)
        v7.UseOutfitHats = true
        v7.KeepPlayerFace = false
    end
    v5.ApplyBaseAppearance(p1, v7)
    if not Watcher.IsCurrent(u83) then
        v2 = false
    elseif not u78 then
        v2 = true
    elseif u25.Player.Character ~= p1 then
        Watcher.Finish(u83)
        v2 = false
    elseif p1.Parent ~= nil then
        v2 = true
    else
        Watcher.Finish(u83)
        v2 = false
    end
    if not v2 then
        return false, "superseded"
    end
    if not v4 then
        u27.ApplyOutfitClothing(p1, p2, u25)
        OutfitVFX.Apply(p1, p2, u25)
        if not u25.UseOutfitHats then
            v5.ApplyPlayerAccessories(p1, u25)
        else
            u27.ApplyOutfitAccessories(p1, p2, u25)
        end
    else
        SpecialMesh.Apply(p1, p2, v7)
        u27.ApplyOutfitAccessories(p1, p2, v7)
    end
    if not Watcher.IsCurrent(u83) then
        v2 = false
    elseif not u78 then
        v2 = true
    elseif u25.Player.Character ~= p1 then
        Watcher.Finish(u83)
        v2 = false
    elseif p1.Parent ~= nil then
        v2 = true
    else
        Watcher.Finish(u83)
        v2 = false
    end
    if not v2 then
        return false, "superseded"
    end
    if v6 ~= "Off" then
        Watcher.FinishAfter(u83, 5)
    else
        Watcher.Finish(u83)
    end
    return true
end

function u27.RestoreAvatar(p1, p2) -- Line: 230 -- upvalues: copyOptions (val), u27 (val)
    local v1 = copyOptions
    local v2 = p2 or {}
    v1 = v1(v2)
    v1.Morph = false
    v1.UseOutfitHats = false
    return u27.Apply(p1, nil, v1)
end

return u27