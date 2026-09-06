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
    if not u33 then
        u33 = Instance.new("Folder")
        u33.Name = "WepConfigPreparedViewmodels"
        u33.Parent = ReplicatedStorage
        return u33
    end
    if u33.Parent then
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
    if not u33 then
        u33 = Instance.new("Folder")
        u33.Name = "WepConfigPreparedViewmodels"
        u33.Parent = ReplicatedStorage
        v1 = u33
    elseif u33.Parent then
        v1 = u33
    end
    v3.Parent = v1
    v1 = {age = 0, model = v3}
    u31[p1] = v1
    u34 = u34 + 1
    v1.age = u34
    local v4 = 0
    local v5 = nil
    local age = nil
    for k, v in pairs(u31) do
        v4 = v4 + 1
        if not age then
            v5 = k
            age = v.age
        elseif v.age >= age then
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
local function applySkinToViewmodel(p1, p2, p3) -- Line: 127 -- upvalues: ReplicatedStorage (val), u30 (val), SkinApplier (val), SkinFormat (val), SkinUtil (val)
    local BaseName, v1, v2
    local ViewmodelOverride = ReplicatedStorage:FindFirstChild("ViewmodelOverride")
    if not ViewmodelOverride then
        local v3, v4
        v1 = SkinFormat.classify(p1)
        if v1.type == "skinsdk_model" then
            local BaseName_2 = p2.BaseName
            if not BaseName_2 then
                BaseName_2 = p2.WeaponName
            end
            v4 = u30.loadViewmodel(BaseName_2):expect():Clone()
            v4.Name = p1.Name
            SkinApplier:ApplyCreatorSkin(v4, p1)
            v4:SetAttribute("GlobalPartsApplied", true)
            return v4
        end
        if p1:IsA("ModuleScript") then
            local BaseName_3 = p2.BaseName
            if not BaseName_3 then
                BaseName_3 = p2.WeaponName
            end
            v4 = u30.loadViewmodel(BaseName_3):expect():Clone()
            v4.Name = p1.Name
            v2 = require(p1)
            SkinApplier:DecodeSkin(v4, p1)
            if v2 then
                v2(v4, SkinUtil)
            end
            v4:SetAttribute("GlobalPartsApplied", true)
            return v4
        end
        if v1.type == "configuration" then
            v3 = u30.loadViewmodel(p2.BaseName):expect():Clone()
            v3.Name = p1.Name
            SkinApplier:ApplyFolder(v3, p1)
            v3:SetAttribute("GlobalPartsApplied", true)
            return v3
        end
        if v1.type ~= "derived_model" then
            return p1
        end
        if p2 and p2.BaseName and p2.BaseName ~= p2.WeaponName and p1.Name ~= p2.BaseName and not (p1:GetAttribute("GlobalPartsApplied")) then
            p1:SetAttribute("GlobalPartsApplied", true)
            v3 = u30.loadViewmodel(p2.BaseName):expect()
            SkinApplier:AddGlobalParts(p1, v3)
        end
        return p1
    elseif ViewmodelOverride:GetAttribute("SkinSDKVersion") then
        v1 = ViewmodelOverride:Clone()
        ViewmodelOverride:Destroy()
        local SkinCreatorOverride = ReplicatedStorage:FindFirstChild("SkinCreatorOverride")
        if SkinCreatorOverride then
            SkinCreatorOverride:Destroy()
        end
        BaseName = p2.BaseName
        if not BaseName then
            BaseName = p2.WeaponName
        end
        v2 = u30.loadViewmodel(BaseName):expect():Clone()
        v2.Name = p1.Name
        SkinApplier:ApplyCreatorSkin(v2, v1)
        v1:Destroy()
        v2:SetAttribute("GlobalPartsApplied", true)
        v2:SetAttribute("BaseWeaponName", p2.WeaponName)
        v2.Name = "SkinCreatorOverride"
        v2.Parent = ReplicatedStorage
        return v2
    end
end
local function applyStockGlobalParts(p1, p2) -- Line: 210
    if not (p1:GetAttribute("GlobalPartsApplied")) then
        if not p2.BaseName then
            p1:SetAttribute("GlobalPartsApplied", true)
            if p1:FindFirstChild("GlobalParts") and p1.GlobalParts:FindFirstChild("ToWeapon") then
                local Weld
                local v1 = p1.GlobalParts.ToWeapon:Clone()
                local Handle = p1.KeyParts.Handle
                for i, j in v1:QueryDescendants("BasePart") do
                    Weld = Instance.new("Weld")
                    Weld.Name = Handle.Name .. ":" .. j.Name
                    Weld.Part0 = Handle
                    Weld.Part1 = j
                    Weld.C0 = CFrame.new()
                    Weld.C1 = j.CFrame:toObjectSpace(Handle.CFrame)
                    Weld.Parent = Handle
                end
                for k, n in v1:GetChildren() do
                    n.Parent = p1.Weapon
                end
                v1:Destroy()
            end
        elseif p2.BaseName ~= p2.WeaponName then
        end
    end
end
function u30.loadViewmodel(p1, p2) -- Line: 250 -- upvalues: u28 (ref), ReplicatedStorage (val), u31 (val), u34 (ref), Promise (val), u32 (val), u29 (ref), applySkinToViewmodel (val), applyStockGlobalParts (val), cachePrepared (val)
    local u57, u59, u66, v1, v2, v3
    if p2 then
        v1 = p2
    else
        v1 = u28:GetWeaponConfig(p1)
    end
    local v4 = v1 ~= nil
    assert(v4, "No config found for " .. p1)
    local ViewmodelOverride = ReplicatedStorage:FindFirstChild("ViewmodelOverride")
    local Attribute = ViewmodelOverride
    if Attribute then
        Attribute = ViewmodelOverride:GetAttribute("SkinSDKVersion")
    end
    if Attribute then
        u57 = v1
        u59 = false
        v3 = Promise.new(function(a1, p2, p3) -- Line: 281 -- upvalues: u57 (val), p1 (val), u29 (upval), applySkinToViewmodel (upval), applyStockGlobalParts (upval), ReplicatedStorage (upval)
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
            if SkinCreatorOverride then
                local Attribute = SkinCreatorOverride:GetAttribute("BaseWeaponName")
                if Attribute == u57.WeaponName then
                    v2 = SkinCreatorOverride
                end
            end
            a1(v2)
        end)
        u66 = nil
        u66 = v3:andThen(function(a1) -- Line: 309 -- upvalues: u59 (ref), cachePrepared (upval), p1 (val), u32 (upval), u66 (ref)
            u59 = true
            local v1 = cachePrepared(p1, a1)
            local v2 = u32[p1]
            if v2 == u66 then
                u32[p1] = nil
            end
            return v1
        end, function(a1) -- Line: 316 -- upvalues: u59 (ref), u32 (upval), p1 (val), u66 (ref), Promise (upval)
            u59 = true
            local v1 = u32[p1]
            if v1 == u66 then
                u32[p1] = nil
            end
            return Promise.reject(a1)
        end)
        u32[p1] = u66
        if u59 and u32[p1] == u66 then
            u32[p1] = nil
        end
        return u66:andThen(function(p1) -- Line: 328 -- upvalues: u34 (upval)
            u34 = u34 + 1
            p1.age = u34
            return p1.model:Clone()
        end)
    end
    v2 = u31[p1]
    if not v2 or not v2.model then
        v3 = u32[p1]
        if v3 then
            return v3:andThen(function(p1) -- Line: 271 -- upvalues: u34 (upval)
                u34 = u34 + 1
                p1.age = u34
                return p1.model:Clone()
            end)
        end
        u57 = v1
        u59 = false
        v3 = Promise.new(function(a1, p2, p3) -- Line: 281 -- upvalues: u57 (val), p1 (val), u29 (upval), applySkinToViewmodel (upval), applyStockGlobalParts (upval), ReplicatedStorage (upval)
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
            if SkinCreatorOverride then
                local Attribute = SkinCreatorOverride:GetAttribute("BaseWeaponName")
                if Attribute == u57.WeaponName then
                    v2 = SkinCreatorOverride
                end
            end
            a1(v2)
        end)
        u66 = nil
        u66 = v3:andThen(function(a1) -- Line: 309 -- upvalues: u59 (ref), cachePrepared (upval), p1 (val), u32 (upval), u66 (ref)
            u59 = true
            local v1 = cachePrepared(p1, a1)
            local v2 = u32[p1]
            if v2 == u66 then
                u32[p1] = nil
            end
            return v1
        end, function(a1) -- Line: 316 -- upvalues: u59 (ref), u32 (upval), p1 (val), u66 (ref), Promise (upval)
            u59 = true
            local v1 = u32[p1]
            if v1 == u66 then
                u32[p1] = nil
            end
            return Promise.reject(a1)
        end)
        u32[p1] = u66
        if u59 and u32[p1] == u66 then
            u32[p1] = nil
        end
        return u66:andThen(function(p1) -- Line: 328 -- upvalues: u34 (upval)
            u34 = u34 + 1
            p1.age = u34
            return p1.model:Clone()
        end)
    end
    if v2.model.Parent then
        u34 = u34 + 1
        v2.age = u34
        return Promise.resolve(v2.model:Clone())
    end
    v3 = u32[p1]
    if v3 then
        return v3:andThen(function(p1) -- Line: 271 -- upvalues: u34 (upval)
            u34 = u34 + 1
            p1.age = u34
            return p1.model:Clone()
        end)
    end
    u57 = v1
    u59 = false
    v3 = Promise.new(function(a1, p2, p3) -- Line: 281 -- upvalues: u57 (val), p1 (val), u29 (upval), applySkinToViewmodel (upval), applyStockGlobalParts (upval), ReplicatedStorage (upval)
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
        if SkinCreatorOverride then
            local Attribute = SkinCreatorOverride:GetAttribute("BaseWeaponName")
            if Attribute == u57.WeaponName then
                v2 = SkinCreatorOverride
            end
        end
        a1(v2)
    end)
    u66 = nil
    u66 = v3:andThen(function(a1) -- Line: 309 -- upvalues: u59 (ref), cachePrepared (upval), p1 (val), u32 (upval), u66 (ref)
        u59 = true
        local v1 = cachePrepared(p1, a1)
        local v2 = u32[p1]
        if v2 == u66 then
            u32[p1] = nil
        end
        return v1
    end, function(a1) -- Line: 316 -- upvalues: u59 (ref), u32 (upval), p1 (val), u66 (ref), Promise (upval)
        u59 = true
        local v1 = u32[p1]
        if v1 == u66 then
            u32[p1] = nil
        end
        return Promise.reject(a1)
    end)
    u32[p1] = u66
    if u59 and u32[p1] == u66 then
        u32[p1] = nil
    end
    return u66:andThen(function(p1) -- Line: 328 -- upvalues: u34 (upval)
        u34 = u34 + 1
        p1.age = u34
        return p1.model:Clone()
    end)
end
function u30.setupGunGameListeners() -- Line: 338 -- upvalues: u28 (ref)
    local v1 = require("@game/ReplicatedStorage/common/zap")
    local u3 = {}
    v1.PreloadWeapons.On(function(p1) -- Line: 343 -- upvalues: u28 (upval), u3 (val)
        local v1
        local v2 = p1.Weapons
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            v1 = u28:StreamViewmodel(j)
            v1:andThen(function(p1) -- Line: 346 -- upvalues: j (val), u3 (upval)
                if p1:IsA("Model") then
                    local v1 = p1:Clone()
                    v1.Name = j
                    v1:PivotTo(CFrame.new(0, -1000, 0))
                    v1.Parent = workspace
                    table.insert(u3, v1)
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