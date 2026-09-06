local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local SkinFormat = require(script.Parent.SkinFormat)
local v1 = {}
local u16 = {}
function v1.init(p1) -- Line: 39 -- upvalues: ServerStorage (val), HttpService (val), u16 (val), SkinFormat (val)
    local Register, RenameMap, path, v1, v2, v3, v4, v5, v6, v7
    local VModels = p1.VModels
    local Configs = p1.Configs
    local CustomResources = ServerStorage:FindFirstChild("CustomResources")
    if not CustomResources then
        v1 = p1
    else
        v1 = p1
        for i, j in CustomResources:GetChildren() do
            for k, n in j:GetChildren() do
                n.Parent = ServerStorage.common.ServerResources[j.Name]
            end
        end
        CustomResources:Destroy()
    end
    local v8 = {VModels, Configs}
    local v9 = nil
    local v10 = nil
    for m, i5 in v8, v9, v10 do
        RenameMap = i5:FindFirstChild("RenameMap")
        if RenameMap and RenameMap:IsA("StringValue") and RenameMap.Value ~= "" then
            v2 = HttpService:JSONDecode(RenameMap.Value)
            v3 = nil
            v4 = nil
            for i6, i7 in v2, v3, v4 do
                v5 = i5
                path = i7.path
                v6 = nil
                v7 = nil
                for i8, i9 in path, v6, v7 do
                    v5 = v5:FindFirstChild(i9)
                    if not v5 then
                        break
                    end
                end
                if v5 and v5.Name ~= i7.name then
                    v5.Name = i7.name
                end
            end
            RenameMap:Destroy()
        end
    end
    function Register(p1) -- Line: 78 -- upvalues: Register (val), u16 (upval)
        if p1:IsA("Folder") then
            for i, j in p1:GetChildren() do
                Register(j)
            end
            return
        end
        if p1:IsA("Model") then
            u16[p1.Name] = p1
        elseif p1:IsA("ModuleScript") then
            u16[p1.Name] = p1
        elseif p1:IsA("Configuration") then
            u16[p1.Name] = p1
        end
    end
    for i10, i11 in VModels:GetChildren() do
        Register(i11)
    end
    v9 = u16
    v10 = nil
    local v11 = nil
    for i12, i13 in v9, v10, v11 do
        SkinFormat.stampAttributes(i13)
    end
    if not v1.IsInEdit then
        local v12
        local SharedResources = v1.SharedResources
        local ChunkSender = v1.ChunkSender
        local GetAttFolder = v1.GetAttFolder
        local attCache = v1.attCache
        for i14, i15 in ServerStorage.common.ServerResources.Attachments:GetChildren() do
            if i15:IsA("Folder") then
                for i16, i17 in i15:GetChildren() do
                    attCache[i17.Name] = i17
                end
                v12 = Instance.new("Folder", SharedResources.Attachments)
                v12.Name = i15.Name
            end
        end
        GetAttFolder:SetCallback(function(p1, p2) -- Line: 116 -- upvalues: attCache (val), ChunkSender (val), SharedResources (val)
            local Name
            local v1 = p2[1]
            if attCache[v1] then
                ChunkSender.Send(p1, attCache[v1], nil, SharedResources.Attachments[attCache[v1].Parent.Name])
            end
            local v2 = {}
            if not (attCache[v1]) then
                Name = nil
            else
                Name = attCache[v1].Parent.Name
                if not Name then
                    Name = nil
                end
            end
            v2[1] = Name
            return v2
        end)
    end
end
function v1.loadViewmodel(p1) -- Line: 132 -- upvalues: u16 (val)
    return u16[p1]
end
function v1.GetViewmodels() -- Line: 136 -- upvalues: u16 (val)
    return u16
end
function v1.GetViewmodel(p1) -- Line: 140 -- upvalues: u16 (val)
    return u16[p1]
end
return v1