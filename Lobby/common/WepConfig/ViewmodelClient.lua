local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local SkinApplier = require(script.Parent.SkinApplier)
local SkinFormat = require(script.Parent.SkinFormat)
local SkinUtil = require(common:WaitForChild("SkinUtil"))
local Promise = require(common:WaitForChild("Promise"))
local u28 = nil
local u29 = nil
local u30 = {}
local u31 = {}
local u32 = {}
local u33 = nil
local u34 = 0

local function getPreparedFolder() -- Line: 43 -- upvalues: u33 (ref), ReplicatedStorage (val)
    if u33 and u33.Parent then
        return u33
    end
    u33 = Instance.new("Folder")
    u33.Name = "WepConfigPreparedViewmodels"
    u33.Parent = ReplicatedStorage
    return u33
end

local function touch(p1) -- Line: 53 -- upvalues: u34 (ref)
    u34 = u34 + 1
    p1.age = u34
end

local function cachePrepared(p1, p2) -- Line: 58 -- upvalues: u31 (val), u33 (ref), ReplicatedStorage (val), u34 (ref)
    local v1
    local v2 = u31[p1]
    if v2 and v2.model then
        v2.model:Destroy()
    end
    local v3 = p2:Clone()
    v3.Name = p1
    if not u33 or not u33.Parent then
        u33 = Instance.new("Folder")
        u33.Name = "WepConfigPreparedViewmodels"
        u33.Parent = ReplicatedStorage
        v1 = u33
    else
        v1 = u33
    end
    v3.Parent = v1
    v1 = {age = 0}
    v1.model = v3
    u31[p1] = v1
    u34 = u34 + 1
    v1.age = u34
    local v4 = 0
    local v5 = nil
    local age = nil
    for k, v in pairs(u31) do
        v4 = v4 + 1
        if not age or v.age < age then
            v5 = k
            age = v.age
        end
    end
    if 40 < v4 and v5 then
        local v6 = u31[v5]
        if v6 and v6.model then
            v6.model:Destroy()
        end
        u31[v5] = nil
    end
    return v1
end

function u30.clearCache() -- Line: 90 -- upvalues: u31 (val), u32 (val), u33 (ref)
    for k, v in pairs(u31) do
        if v.model then
            v.model:Destroy()
        end
        u31[k] = nil
    end
    table.clear(u32)
    if u33 then
        u33:Destroy()
        u33 = nil
    end
end

function u30.init(p1) -- Line: 111 -- upvalues: u28 (ref), u29 (ref)
    u28 = p1.WepConfig
    u29 = p1.streamOrFindVModel
end

local function applySkinToViewmodel(p1, p2, p3) -- Line: 127
    -- upvalues: ReplicatedStorage (val), u30 (val), SkinApplier (val), SkinFormat (val), SkinUtil (val)
    local v1, v2, v3, v4
    local ViewmodelOverride = ReplicatedStorage:FindFirstChild("ViewmodelOverride")
    if ViewmodelOverride and ViewmodelOverride:GetAttribute("SkinSDKVersion") then
        v1 = ViewmodelOverride:Clone()
        ViewmodelOverride:Destroy()
        local SkinCreatorOverride = ReplicatedStorage:FindFirstChild("SkinCreatorOverride")
        if SkinCreatorOverride then
            SkinCreatorOverride:Destroy()
        end
        local BaseName = p2.BaseName
        if not BaseName then
            BaseName = p2.WeaponName
        end
        v4 = u30.loadViewmodel(BaseName):expect():Clone()
        v4.Name = p1.Name
        SkinApplier:ApplyCreatorSkin(v4, v1)
        v1:Destroy()
        v4:SetAttribute("GlobalPartsApplied", true)
        local WeaponName = p2.WeaponName
        v4:SetAttribute("BaseWeaponName", WeaponName)
        v4.Name = "SkinCreatorOverride"
        v4.Parent = ReplicatedStorage
        return v4
    end
    v1 = SkinFormat.classify(p1)
    if v1.type == "skinsdk_model" then
        local BaseName_2 = p2.BaseName
        if not BaseName_2 then
            BaseName_2 = p2.WeaponName
        end
        v3 = u30.loadViewmodel(BaseName_2):expect():Clone()
        v3.Name = p1.Name
        SkinApplier:ApplyCreatorSkin(v3, p1)
        v3:SetAttribute("GlobalPartsApplied", true)
        return v3
    end
    if p1:IsA("ModuleScript") then
        local BaseName_3 = p2.BaseName
        if not BaseName_3 then
            BaseName_3 = p2.WeaponName
        end
        v3 = u30.loadViewmodel(BaseName_3):expect():Clone()
        v3.Name = p1.Name
        v4 = require(p1)
        SkinApplier:DecodeSkin(v3, p1)
        if v4 then
            v4(v3, SkinUtil)
        end
        v3:SetAttribute("GlobalPartsApplied", true)
        return v3
    end
    if v1.type == "configuration" then
        v2 = u30.loadViewmodel(p2.BaseName):expect():Clone()
        v2.Name = p1.Name
        SkinApplier:ApplyFolder(v2, p1)
        v2:SetAttribute("GlobalPartsApplied", true)
        return v2
    end
    if v1.type ~= "derived_model" then
        return p1
    end
    if p2
        and p2.BaseName
        and p2.BaseName ~= p2.WeaponName
        and p1.Name ~= p2.BaseName
        and not p1:GetAttribute("GlobalPartsApplied") then
        p1:SetAttribute("GlobalPartsApplied", true)
        v2 = u30.loadViewmodel(p2.BaseName):expect()
        SkinApplier:AddGlobalParts(p1, v2)
    end
    return p1
end

local function applyStockGlobalParts(p1, p2) -- Line: 210
    if not p1:GetAttribute("GlobalPartsApplied") then
        local CFrame_2, CFrame_3, Handle, Weld, v1
        if not p2.BaseName then
            p1:SetAttribute("GlobalPartsApplied", true)
            if p1:FindFirstChild("GlobalParts") and p1.GlobalParts:FindFirstChild("ToWeapon") then
                v1 = p1.GlobalParts.ToWeapon:Clone()
                Handle = p1.KeyParts.Handle
                for i, j in v1:QueryDescendants("BasePart") do
                    Weld = Instance.new("Weld")
                    Weld.Name = Handle.Name .. ":" .. j.Name
                    Weld.Part0 = Handle
                    Weld.Part1 = j
                    Weld.C0 = CFrame.new()
                    CFrame_2 = j.CFrame
                    CFrame_3 = Handle.CFrame
                    Weld.C1 = CFrame_2:toObjectSpace(CFrame_3)
                    Weld.Parent = Handle
                end
                for k, n in v1:GetChildren() do
                    n.Parent = p1.Weapon
                end
                v1:Destroy()
            end
        elseif p2.BaseName == p2.WeaponName then
            p1:SetAttribute("GlobalPartsApplied", true)
            if p1:FindFirstChild("GlobalParts") and p1.GlobalParts:FindFirstChild("ToWeapon") then
                v1 = p1.GlobalParts.ToWeapon:Clone()
                Handle = p1.KeyParts.Handle
                for m, i5 in v1:QueryDescendants("BasePart") do
                    Weld = Instance.new("Weld")
                    Weld.Name = Handle.Name .. ":" .. i5.Name
                    Weld.Part0 = Handle
                    Weld.Part1 = i5
                    Weld.C0 = CFrame.new()
                    CFrame_2 = i5.CFrame
                    CFrame_3 = Handle.CFrame
                    Weld.C1 = CFrame_2:toObjectSpace(CFrame_3)
                    Weld.Parent = Handle
                end
                for i6, i7 in v1:GetChildren() do
                    i7.Parent = p1.Weapon
                end
                v1:Destroy()
            end
        end
    end
end

function u30.loadViewmodel(p1, p2) -- Line: 250
    -- upvalues: u28 (ref), ReplicatedStorage (val), u31 (val), u34 (ref), Promise (val), u32 (val), u29 (ref)
    -- upvalues: applySkinToViewmodel (val), applyStockGlobalParts (val), cachePrepared (val)
    local v1, v2
    if p2 then
        v1 = p2
    else
        v1 = u28:GetWeaponConfig(p1)
    end
    local v3 = v1 ~= nil
    local v4 = "No config found for " .. p1
    assert(v3, v4)
    local ViewmodelOverride = ReplicatedStorage:FindFirstChild("ViewmodelOverride")
    local Attribute = ViewmodelOverride
    if Attribute then
        Attribute = ViewmodelOverride:GetAttribute("SkinSDKVersion")
    end
    if not Attribute then
        v4 = u31[p1]
        if v4 and v4.model and v4.model.Parent then
            u34 = u34 + 1
            v4.age = u34
            return Promise.resolve(v4.model:Clone())
        end
        v2 = u32[p1]
        if v2 then
            return v2:andThen(function(p1) -- Line: 271 -- upvalues: u34 (upval)
                u34 = u34 + 1
                p1.age = u34
                return p1.model:Clone()
            end)
        end
    end
    local u57 = v1
    local u59 = false
    local v5 = Promise
    v2 = v5.new(function(p1_2, p2, p3) -- Line: 281
        -- upvalues: u57 (val), p1 (val), u29 (upval), applySkinToViewmodel (upval), applyStockGlobalParts (upval)
        -- upvalues: ReplicatedStorage (upval)
        local UseVModel = u57.UseVModel
        if not UseVModel then
            UseVModel = p1
        end
        local v1 = u29(UseVModel)
        if not v1 then
            p2("Failed to load model: " .. UseVModel .. " (timeout)")
            return
        end
        local v2 = applySkinToViewmodel(v1, u57, UseVModel)
        applyStockGlobalParts(v2, u57)
        if v2 and v2.PrimaryPart then
            v2.PrimaryPart.Anchored = true
        end
        local SkinCreatorOverride = ReplicatedStorage:FindFirstChild("SkinCreatorOverride")
        if SkinCreatorOverride and (SkinCreatorOverride:GetAttribute("BaseWeaponName")) == u57.WeaponName then
            v2 = SkinCreatorOverride
        end
        p1_2(v2)
    end)
    local u66 = nil
    u66 = v2:andThen(function(p1_2) -- Line: 309 -- upvalues: u59 (ref), cachePrepared (upval), p1 (val), u32 (upval), u66 (ref)
        u59 = true
        local v1 = cachePrepared(p1, p1_2)
        if u32[p1] == u66 then
            u32[p1] = nil
        end
        return v1
    end, function(p1_2) -- Line: 316 -- upvalues: u59 (ref), u32 (upval), p1 (val), u66 (ref), Promise (upval)
        u59 = true
        if u32[p1] == u66 then
            u32[p1] = nil
        end
        return Promise.reject(p1_2)
    end)
    u32[p1] = u66
    if u59 and u32[p1] == u66 then
        u32[p1] = nil
    end
    local v6 = u66:andThen(function(p1) -- Line: 328 -- upvalues: u34 (upval)
        u34 = u34 + 1
        p1.age = u34
        return p1.model:Clone()
    end)
    return v6
end

function u30.setupGunGameListeners() -- Line: 338 -- upvalues: u28 (ref)
    local v1 = require("@game/ReplicatedStorage/common/zap")
    local u3 = {}
    v1.PreloadWeapons.On(function(p1) -- Line: 343 -- upvalues: u28 (upval), u3 (val)
        local v1 = p1.Weapons
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            (u28:StreamViewmodel(j)):andThen(function(p1) -- Line: 346 -- upvalues: j (val), u3 (upval)
                if p1:IsA("Model") then
                    local v1 = p1:Clone()
                    v1.Name = j
                    local v2 = CFrame.new(0, -1000, 0)
                    v1:PivotTo(v2)
                    v1.Parent = workspace
                    local v3 = u3
                    table.insert(v3, v1)
                end
            end)
        end
    end)
    v1.ClearPreloadedWeapons.On(function(p1) -- Line: 359 -- upvalues: u3 (val), u28 (upval)
        local v1 = u3
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            j:Destroy()
        end
        u28:ClearCache()
    end)
end

return u30