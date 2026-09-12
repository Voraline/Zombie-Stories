local Configs, StreamItemEvent, VModels, loadViewmodel, v1
local RunService = game:GetService("RunService")
local u24 = RunService:IsClient()
local u25 = RunService:IsServer()
local u26 = pcall(RunService.IsEdit, RunService)
if RunService:IsStudio() and u26 and RunService:IsRunning() ~= true and not RunService:IsRunMode() then
    u24 = false
    u25 = true
    u26 = true
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = u25
if ServerStorage then
    ServerStorage = game:GetService("ServerStorage")
end
local HttpService = game:GetService("HttpService")
local IsLobby = (workspace:WaitForChild("Values")):WaitForChild("IsLobby")
local RedEvents = ReplicatedStorage.common.RedEvents
local SharedResources = ReplicatedStorage.common:WaitForChild("SharedResources")
local common = ReplicatedStorage.common
if not u25 then
    Configs = SharedResources:WaitForChild("Configs")
else
    Configs = ServerStorage.common.ServerResources.Configs
    if not Configs then
        Configs = SharedResources:WaitForChild("Configs")
    end
end
if not u25 then
    VModels = SharedResources:WaitForChild("VModels")
else
    VModels = ServerStorage.common.ServerResources.VModels
    if not VModels then
        VModels = SharedResources:WaitForChild("VModels")
    end
end
local ItemData = require(common:WaitForChild("ItemData"))
local ChunkReceiver = u24
if ChunkReceiver then
    ChunkReceiver = require(common:WaitForChild("ChunkReceiver"))
end
if not u25 or u26 then
    v1 = nil
else
    v1 = require("@game/ServerStorage/common/ChunkSender")
end
local SkinFormat = require(script.SkinFormat)
if u24 then
    if Configs:GetAttribute("NonExisting") == "" then
        Configs:GetAttributeChangedSignal("NonExisting"):Wait()
    end
    if Configs:GetAttribute("NonExistingVMs") == "" then
        Configs:GetAttributeChangedSignal("NonExistingVMs"):Wait()
    end
end
local u177 = u24
if u177 then
    local Attribute = Configs:GetAttribute("NonExisting")
    u177 = HttpService:JSONDecode(Attribute)
end
local u188 = u24
if u188 then
    local Attribute_2 = Configs:GetAttribute("NonExistingVMs")
    u188 = HttpService:JSONDecode(Attribute_2)
end
local u189 = {}
local u190 = {Configs = {}, VModels = {}}
local u193 = {}
if not u24 then
    StreamItemEvent = nil
else
    StreamItemEvent = require(RedEvents.Framework.StreamItemEvent)
    if not StreamItemEvent then
        StreamItemEvent = nil
    end
end
local GetAttFolder = not u26
if GetAttFolder then
    GetAttFolder = require(RedEvents.Framework.GetAttFolder)
end
local u227 = nil
local u228 = nil
local u229 = {}

local function streamOrFindVModel(p1, p2) -- Line: 89
    -- upvalues: VModels (val), u24 (ref), u190 (val), StreamItemEvent (val)
    local v1 = VModels:FindFirstChild(p1, p2)
    if not v1 and u24 then
        if not u190.VModels[p1] then
            u190.VModels[p1] = true
            local v2 = StreamItemEvent
            local v3 = {"VModels", p1}
            v2:FireServer(v3)
        end
        v1 = VModels:WaitForChild(p1, 15)
        if not v1 then
            u190.VModels[p1] = nil
        end
    end
    return v1
end

if not u24 then
    local ViewmodelServer = require(script.ViewmodelServer)
    ViewmodelServer.init({
        VModels = VModels,
        Configs = Configs,
        SharedResources = SharedResources,
        ChunkSender = v1,
        GetAttFolder = GetAttFolder,
        attCache = u193,
        IsInEdit = u26,
    })
    loadViewmodel = ViewmodelServer.loadViewmodel
    u229.GetViewmodels = ViewmodelServer.GetViewmodels
    u229.GetViewmodel = ViewmodelServer.GetViewmodel
else
    ChunkReceiver.Main()
    u228 = require(script.ViewmodelClient)
    u228.init({WepConfig = u229, streamOrFindVModel = streamOrFindVModel})
    loadViewmodel = u228.loadViewmodel
    u228.setupGunGameListeners()
end

function u229.PreloadWeapon(p1, p2) -- Line: 133 -- upvalues: ItemData (val), loadViewmodel (ref), u227 (ref)
    local Name = p2
    if ItemData.List[p2] then
        Name = ItemData.List[p2].Name
    end
    loadViewmodel(Name, require(u227(Name)))
end

function u229.StreamViewmodel(p1, p2) -- Line: 141 -- upvalues: ItemData (val), loadViewmodel (ref)
    local Name = p2
    if ItemData.List[p2] then
        Name = ItemData.List[p2].Name
    end
    return loadViewmodel(Name)
end

function u229.GetAttachmentFolder(p1, p2) -- Line: 149
    -- upvalues: u24 (ref), u193 (val), GetAttFolder (val), SharedResources (val)
    local v1
    if not u24 then
        return u193[p2]
    end
    if u193[p2] then
        if u193[p2] == "nil" then
            return
        end
        return u193[p2]
    end
    local v2 = GetAttFolder
    local v3 = {p2}
    _, v1 = v2:Call(v3):Await()
    v3 = v1[1]
    if not v3 then
        u193[p2] = "nil"
        return
    end
    u193[p2] = (SharedResources.Attachments[v3]:WaitForChild(p2, 10))
    if u193[p2] then
        return u193[p2]
    end
    warn("Failed to load attachment: " .. p2 .. " from parent: " .. v3)
    u193[p2] = "nil"
end

function u229.IsStock(p1, p2) -- Line: 176 -- upvalues: ItemData (val)
    local v1 = ItemData.List[p2]
    if not v1 then
        v1 = ItemData.List[ItemData:GetItemIdFromName(p2)]
    end
    if not v1 then
        return
    end
    local Rarity = v1.Rarity
    if Rarity then
        Rarity = v1.Rarity == "Stock"
    end
    return Rarity
end

function u229.GetWeaponConfig(p1, p2, p3) -- Line: 183
    -- upvalues: u189 (val), ItemData (val), streamOrFindVModel (val), SkinFormat (val), u227 (ref), u229 (val)
    -- upvalues: IsLobby (val), u26 (ref), u24 (ref), u188 (val), loadViewmodel (ref), SharedResources (val)
    local Name, v1, v2, v3, v4, v5, v6
    if u189[p2] then
        if u189[p2] == "nil" then
            return
        end
        return u189[p2]
    end
    local v7 = ItemData.List[p2]
    if not v7 then
        v7 = ItemData.List[ItemData:GetItemIdFromName(p2)]
    end
    local BaseWeaponId = nil
    if not v7 then
        Name = p2
    else
        BaseWeaponId = v7.BaseWeaponId
        Name = v7.Name
    end
    if not v7 then
        v5 = streamOrFindVModel(Name, true)
        if v5 then
            local v8 = SkinFormat.getBaseWeapon(v5)
            if v8 then
                v6 = ItemData
                v1 = v8
                local ItemIdFromName = v6:GetItemIdFromName(v1)
                if not ItemIdFromName then
                    ItemIdFromName = ItemData.List[v8] and v8 or nil
                end
                BaseWeaponId = ItemIdFromName
            end
        end
    end
    v5 = nil
    local u79 = nil
    if v7 or not BaseWeaponId then
        v5 = u227(Name)
        if v5 then
            if not p3 then
                u79 = require(v5)
            else
                u79 = require(v5:Clone())
            end
            if u79.BaseConfig then
                v6 = ItemData
                local BaseConfig = u79.BaseConfig
                local ItemIdFromName_2 = v6:GetItemIdFromName(BaseConfig)
                if not ItemIdFromName_2 then
                    if not ItemData.List[u79.BaseConfig] then
                        ItemIdFromName_2 = nil
                    else
                        ItemIdFromName_2 = u79.BaseConfig
                        if not ItemIdFromName_2 then
                            ItemIdFromName_2 = nil
                        end
                    end
                end
                BaseWeaponId = ItemIdFromName_2
            end
        end
    end
    v6 = nil
    if BaseWeaponId then
        local WeaponConfig = u229:GetWeaponConfig(BaseWeaponId, p3)
        if WeaponConfig then
            local u132 = {}
            for k, v in pairs(WeaponConfig) do
                u132[k] = v
            end
            if u79 then
                v2 = u79
                v3 = nil
                v4 = nil
                for i, j in v2, v3, v4 do
                    u132[i] = j
                end
            end
            u132.WeaponName = Name
            u132.WeaponId = p2
            u132.BaseName = ItemData.List[BaseWeaponId].Name
            if not IsLobby.Value and not u26 then
                if not u24 then
                    u132.Viewmodel = loadViewmodel(Name)
                    if not u132.Viewmodel then
                        u132.UseVModel = BaseWeaponId
                    end
                else
                    if u188[Name] then
                        u132.UseVModel = u132.BaseName
                    end
                    ;(loadViewmodel(Name, u132)):andThen(function(p1) -- Line: 265 -- upvalues: u132 (val)
                        u132.Viewmodel = p1
                    end)
                end
            end
            u189[p2] = u132
            v6 = u132
        else
            warn("[WepConfig] Base config not found for: " .. tostring(BaseWeaponId))
            u189[p2] = u79 or "nil"
            v6 = u79
        end
    elseif u79 then
        u79.WeaponName = Name
        u79.WeaponId = p2
        u79.DelayPerShot = u79.DelayPerShot or 0
        if not IsLobby.Value and not u26 then
            if not u24 then
                u79.Viewmodel = loadViewmodel(Name)
            else
                (loadViewmodel(Name, u79)):andThen(function(p1) -- Line: 286 -- upvalues: u79 (ref)
                    u79.Viewmodel = p1
                end)
            end
        end
        u189[p2] = u79 or "nil"
        v6 = u79
    end
    if not v6 then
        return
    end
    local Attribute = v5
    if Attribute then
        Attribute = v5:GetAttribute("SuperClass")
    end
    if Attribute then
        v1 = SharedResources.Configs.SuperClass:FindFirstChild(Attribute)
        if v1 then
            v3 = require(v1)
            v4 = nil
            local v9 = nil
            for k2, n in v3, v4, v9 do
                if not v6[k2] then
                    v6[k2] = n
                end
            end
        end
    end
    if v6 then
        v2 = require(SharedResources.Configs.SuperClass.BaseConfig)
        v3 = nil
        v4 = nil
        for m, i5 in v2, v3, v4 do
            if not v6[m] then
                v6[m] = i5
            end
        end
    end
    return v6
end

function u229.GetWeaponAttachmentProperties(p1) -- Line: 324 -- upvalues: u229 (val)
    local PotentialAttachments, v1, v2
    local WeaponConfig = u229:GetWeaponConfig(p1)
    if not WeaponConfig then
        return nil
    end
    local v3 = {}
    local v4 = WeaponConfig.AttachmentNodeData
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        PotentialAttachments = j.PotentialAttachments
        v1 = nil
        v2 = nil
        for k, n in PotentialAttachments, v1, v2 do
            v3[n.ID] = n
        end
    end
    return v3
end

function u229.ClearCache(p1) -- Line: 339 -- upvalues: u189 (val), u24 (ref), u228 (ref)
    table.clear(u189)
    if u24 then
        u228.clearCache()
    end
end

function u229.ClearModels(p1) -- Line: 346 -- upvalues: u24 (ref), u228 (ref), SharedResources (val)
    if u24 then
        u228.clearCache()
    end
    for i, j in SharedResources.VModels:GetChildren() do
        j:Destroy()
    end
end

function u227(p1) -- Line: 356
    -- upvalues: ItemData (val), u25 (ref), Configs (val), u24 (ref), u177 (val), u190 (val), StreamItemEvent (val)
    local v1
    if ItemData:GetItemFromName(p1) and ItemData:GetItemFromName(p1).Slot == "Outfit" then
        return nil
    end
    if u25 then
        return Configs:FindFirstChild(p1, true)
    end
    if not u24 then
        return
    end
    if u177[p1] then
        return Configs:FindFirstChild(p1)
    end
    if not u190.Configs[p1] then
        u190.Configs[p1] = true
        v1 = StreamItemEvent
        local v2 = {"Configs", p1}
        v1:FireServer(v2)
    end
    v1 = Configs:WaitForChild(p1, 15)
    if not v1 then
        u190.Configs[p1] = nil
        error("Failed to load config: " .. p1)
    end
    return v1
end

return u229