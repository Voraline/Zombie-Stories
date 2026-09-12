local HttpService = game:GetService("HttpService")
local ServerStorage = game:GetService("ServerStorage")
local SkinFormat = require(script.Parent.SkinFormat)
local v1 = {}
local u16 = {}

function v1.init(p1) -- Line: 39 -- upvalues: ServerStorage (val), HttpService (val), u16 (val), SkinFormat (val)
    local Register, RenameMap, Value, path, v1, v2, v3, v4, v5, v6, v7, v8
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
    local v9 = {}
    v9[1] = VModels
    v9[2] = Configs
    local v10 = nil
    local v11 = nil
    for m, i5 in v9, v10, v11 do
        RenameMap = i5:FindFirstChild("RenameMap")
        if RenameMap and RenameMap:IsA("StringValue") and RenameMap.Value ~= "" then
            v2 = HttpService
            Value = RenameMap.Value
            v3 = v2:JSONDecode(Value)
            v4 = nil
            v5 = nil
            for i6, i7 in v3, v4, v5 do
                v6 = i5
                path = i7.path
                v7 = nil
                v8 = nil
                for i8, i9 in path, v7, v8 do
                    v6 = v6:FindFirstChild(i9)
                    if not v6 then
                        break
                    end
                end
                if v6 and v6.Name ~= i7.name then
                    v6.Name = i7.name
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
        if p1:IsA("Model") or p1:IsA("ModuleScript") or p1:IsA("Configuration") then
            u16[p1.Name] = p1
        end
    end

    for i10, i11 in VModels:GetChildren() do
        Register(i11)
    end
    v10 = u16
    v11 = nil
    local v12 = nil
    for i12, i13 in v10, v11, v12 do
        SkinFormat.stampAttributes(i13)
    end
    if not v1.IsInEdit then
        local v13
        local SharedResources = v1.SharedResources
        local ChunkSender = v1.ChunkSender
        local GetAttFolder = v1.GetAttFolder
        local attCache = v1.attCache
        for i14, i15 in ServerStorage.common.ServerResources.Attachments:GetChildren() do
            if i15:IsA("Folder") then
                for i16, i17 in i15:GetChildren() do
                    attCache[i17.Name] = i17
                end
                v13 = Instance.new("Folder", SharedResources.Attachments)
                v13.Name = i15.Name
            end
        end
        GetAttFolder:SetCallback(function(p1, p2) -- Line: 116 -- upvalues: attCache (val), ChunkSender (val), SharedResources (val)
            local Name, v1
            local v2 = p2[1]
            if attCache[v2] then
                v1 = ChunkSender
                local Send = v1.Send
                local v3 = attCache[v2]
                Send(p1, v3, nil, SharedResources.Attachments[attCache[v2].Parent.Name])
            end
            v1 = {}
            if not attCache[v2] then
                Name = nil
            else
                Name = attCache[v2].Parent.Name
                if not Name then
                    Name = nil
                end
            end
            v1[1] = Name
            return v1
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