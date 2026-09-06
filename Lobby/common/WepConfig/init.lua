local Configs, StreamItemEvent, VModels, loadViewmodel, v1
local RunService = game:GetService("RunService")
local u24 = RunService:IsClient()
local u25 = RunService:IsServer()
local u26 = pcall(RunService.IsEdit, RunService)
if RunService:IsStudio() and u26 and RunService:IsRunning() ~= true and not (RunService:IsRunMode()) then
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
local Values = workspace:WaitForChild("Values")
local IsLobby = Values:WaitForChild("IsLobby")
local RedEvents = ReplicatedStorage.common.RedEvents
local SharedResources = ReplicatedStorage.common:WaitForChild("SharedResources")
local common = ReplicatedStorage.common
if not u25 then
    Configs = SharedResources:WaitForChild("Configs")
else
    Configs = ServerStorage.common.ServerResources.Configs
end
if not u25 then
    VModels = SharedResources:WaitForChild("VModels")
else
    VModels = ServerStorage.common.ServerResources.VModels
end
local ItemData = require(common:WaitForChild("ItemData"))
local ChunkReceiver = u24
if ChunkReceiver then
    ChunkReceiver = require(common:WaitForChild("ChunkReceiver"))
end
if not u25 then
    v1 = nil
elseif not u26 then
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
    u177 = HttpService:JSONDecode(Configs:GetAttribute("NonExisting"))
end
local u188 = u24
if u188 then
    u188 = HttpService:JSONDecode(Configs:GetAttribute("NonExistingVMs"))
end
local u189 = {}
local u190 = {Configs = {}, VModels = {}}
local u193 = {}
if not u24 then
    StreamItemEvent = nil
else
    StreamItemEvent = require(RedEvents.Framework.StreamItemEvent)
end
local GetAttFolder = not u26
if GetAttFolder then
    GetAttFolder = require(RedEvents.Framework.GetAttFolder)
end
local u227 = nil
local u228 = nil
local u229 = {}
local function streamOrFindVModel(p1, p2) -- Line: 89 -- upvalues: VModels (val), u24 (ref), u190 (val), StreamItemEvent (val)
    local v1 = VModels:FindFirstChild(p1, p2)
    if not v1 and u24 then
        if not (u190.VModels[p1]) then
            u190.VModels[p1] = true
            StreamItemEvent:FireServer({"VModels", p1})
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
    local Name
    Name = if ItemData.List[p2] then ItemData.List[p2].Name else p2
    loadViewmodel(Name, require(u227(Name)))
end
function u229.StreamViewmodel(p1, p2) -- Line: 141 -- upvalues: ItemData (val), loadViewmodel (ref)
    local Name
    Name = if ItemData.List[p2] then ItemData.List[p2].Name else p2
    return loadViewmodel(Name)
end
function u229.GetAttachmentFolder(p1, p2) -- Line: 149 -- upvalues: u24 (ref), u193 (val), GetAttFolder (val), SharedResources (val)
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
    _, v1 = GetAttFolder:Call({p2}):Await()
    local v2 = v1[1]
    if not v2 then
        u193[p2] = "nil"
        return
    end
    u193[p2] = SharedResources.Attachments[v2]:WaitForChild(p2, 10)
    if u193[p2] then
        return u193[p2]
    end
    warn("Failed to load attachment: " .. p2 .. " from parent: " .. v2)
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
function u229.GetWeaponConfig(p1, p2, p3) -- Line: 183 -- upvalues: u189 (val), ItemData (val), streamOrFindVModel (val), SkinFormat (val), u227 (ref), u229 (val), IsLobby (val), u26 (ref), u24 (ref), u188 (val), loadViewmodel (ref), SharedResources (val)
    local Name, v1, v2, v3, v4
    if u189[p2] then
        if u189[p2] == "nil" then
            return
        end
        return u189[p2]
    end
    local v5 = ItemData.List[p2]
    if not v5 then
        v5 = ItemData.List[ItemData:GetItemIdFromName(p2)]
    end
    local BaseWeaponId = nil
    if not v5 then
        Name = p2
    else
        BaseWeaponId = v5.BaseWeaponId
        Name = v5.Name
    end
    if not v5 then
        v4 = streamOrFindVModel(Name, true)
        if v4 then
            local v6 = SkinFormat.getBaseWeapon(v4)
            if v6 then
                local ItemIdFromName = ItemData:GetItemIdFromName(v6)
                if not ItemIdFromName then
                    if not (ItemData.List[v6]) then
                        ItemIdFromName = nil
                    else
                        ItemIdFromName = v6
                    end
                end
                BaseWeaponId = ItemIdFromName
            end
        end
    end
    v4 = nil
    local u79 = nil
    if v5 then
        v4 = u227(Name)
        if v4 then
            local BaseConfig
            if not p3 then
                u79 = require(v4)
            else
                u79 = require(v4:Clone())
            end
            if u79.BaseConfig then
                BaseConfig = u79.BaseConfig
                local ItemIdFromName_2 = ItemData:GetItemIdFromName(BaseConfig)
                if not ItemIdFromName_2 then
                    if not (ItemData.List[u79.BaseConfig]) then
                        ItemIdFromName_2 = nil
                    else
                        ItemIdFromName_2 = u79.BaseConfig
                    end
                end
                BaseWeaponId = ItemIdFromName_2
            end
        end
    end
    local v7 = nil
    if BaseWeaponId then
        local WeaponConfig = u229:GetWeaponConfig(BaseWeaponId, p3)
        if WeaponConfig then
            local u132 = {}
            for k, v in pairs(WeaponConfig) do
                u132[k] = v
            end
            if u79 then
                v1 = u79
                v2 = nil
                v3 = nil
                for i, j in v1, v2, v3 do
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
                    v1 = loadViewmodel(Name, u132)
                    v1:andThen(function(p1) -- Line: 265 -- upvalues: u132 (val)
                        u132.Viewmodel = p1
                    end)
                end
            end
            u189[p2] = u132
            v7 = u132
        else
            warn("[WepConfig] Base config not found for: " .. tostring(BaseWeaponId))
            u189[p2] = u79 or "nil"
            v7 = u79
        end
    elseif u79 then
        u79.WeaponName = Name
        u79.WeaponId = p2
        u79.DelayPerShot = u79.DelayPerShot or 0
        if not IsLobby.Value and not u26 then
            if not u24 then
                u79.Viewmodel = loadViewmodel(Name)
            else
                local v8 = loadViewmodel(Name, u79)
                v8:andThen(function(p1) -- Line: 286 -- upvalues: u79 (ref)
                    u79.Viewmodel = p1
                end)
            end
        end
        u189[p2] = u79 or "nil"
        v7 = u79
    end
    if not v7 then
        return
    end
    local Attribute = v4
    if Attribute then
        Attribute = v4:GetAttribute("SuperClass")
    end
    if Attribute then
        local v9 = SharedResources.Configs.SuperClass:FindFirstChild(Attribute)
        if v9 then
            v2 = require(v9)
            v3 = nil
            local v10 = nil
            for k2, n in v2, v3, v10 do
                if not (v7[k2]) then
                    v7[k2] = n
                end
            end
        end
    end
    if v7 then
        v1 = require(SharedResources.Configs.SuperClass.BaseConfig)
        v2 = nil
        v3 = nil
        for m, i5 in v1, v2, v3 do
            if not (v7[m]) then
                v7[m] = i5
            end
        end
    end
    return v7
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
function u227(p1) -- Line: 356 -- upvalues: ItemData (val), u25 (ref), Configs (val), u24 (ref), u177 (val), u190 (val), StreamItemEvent (val)
    if not (ItemData:GetItemFromName(p1)) then
        if u25 then
            return Configs:FindFirstChild(p1, true)
        end
        if not u24 then
            return
        end
        if u177[p1] then
            return Configs:FindFirstChild(p1)
        end
        if not (u190.Configs[p1]) then
            u190.Configs[p1] = true
            StreamItemEvent:FireServer({"Configs", p1})
        end
        local v1 = Configs:WaitForChild(p1, 15)
        if not v1 then
            u190.Configs[p1] = nil
            error("Failed to load config: " .. p1)
        end
        return v1
    elseif ItemData:GetItemFromName(p1).Slot == "Outfit" then
        return nil
    end
end
return u229