local RunService = game:GetService("RunService")
local v1 = {}
local v2 = {}
local u338 = setmetatable(v2, v1)
local u10 = {}
local new = Instance.new
local u12 = type
local u353 = require
local u14 = nil
local u17 = RunService:IsServer()
local u22 = setmetatable({
    Folder = false,
    RemoteEvent = false,
    BindableEvent = false,
    RemoteFunction = false,
    BindableFunction = false,
    Library = true,
}, {
    __index = function(p1, p2) -- Line: 22 -- upvalues: new (val)
        local v1, v2, v3
        v1, v2 = pcall(new, p2)
        if not v1 then
            v3 = true
        elseif not v2 then
            v3 = true
        else
            v2:Destroy()
            v3 = false
        end
        p1[p2] = v3
        return v3
    end,
})
function u338.GetLocalTable(p1, p2) -- Line: 38 -- upvalues: u338 (val), u10 (val)
    local v1
    if p1 == u338 then
        v1 = p2
    else
        v1 = p1
        if not v1 then
            v1 = p2
        end
    end
    local v2 = v1
    v1 = u10[v2]
    if not v1 then
        u10[v2] = {}
    end
    return v1
end
local function GetFirstChild(p1, p2, p3) -- Line: 50 -- upvalues: u22 (val), new (val)
    local v1 = p1:FindFirstChild(p2)
    if not v1 then
        if u22[p3] then
            local FullName = p1:GetFullName()
            error("[Resources] " .. p3 .. " \"" .. p2 .. "\" is not installed within " .. FullName .. ".", 2)
        end
        v1 = new(p3)
        v1.Name = p2
        v1.Parent = p1
    end
    return v1
end
function v1.__index(p1, p2) -- Line: 63 -- upvalues: u12 (val), GetFirstChild (val), u14 (ref), u338 (val), u10 (val), u17 (val)
    local GetLocalFolder, u44, v1, v2
    if u12(p2) ~= "string" then
        v1 = "[Resources] Attempt to index Resources with invalid key: string expected, got " .. typeof(p2)
        error(v1, 2)
    end
    if p2:sub(1, 3) ~= "Get" then
        error("[Resources] Methods should begin with \"Get\"", 2)
    end
    local u27 = p2:sub(4)
    v1, v2 = u27:byte(-2, -1)
    if v2 ~= 121 then
        u44 = u27 .. "s"
    elseif v1 ~= 97 and v1 ~= 101 and v1 ~= 105 and v1 ~= 111 and v1 ~= 117 then
        local v3 = u27:sub(1, -2)
        u44 = v3 .. "ies"
    end
    local u52 = u27:sub(1, 5) == "Local"
    local u53 = nil
    local u54 = nil
    if u52 then
        u27 = u27:sub(6)
        if u27 ~= "Folder" then
            GetLocalFolder = u338.GetLocalFolder
        else
            function GetLocalFolder() -- Line: 78 -- upvalues: GetFirstChild (upval), u14 (upval)
                return GetFirstChild(u14, "Resources", "Folder")
            end
        end
    elseif u27 ~= "Folder" then
        GetLocalFolder = u338.GetFolder
    else
        function GetLocalFolder() -- Line: 84
            return script
        end
    end
    local function GetFunction(a1, a2) -- Line: 90 -- upvalues: p1 (val), u12 (upval), p2 (val), u54 (ref), u53 (ref), u10 (upval), u44 (val), GetLocalFolder (ref), u52 (val), u17 (upval), GetFirstChild (upval), u27 (ref)
        local v1, v2
        if a1 == p1 then
            v1 = a2
        else
            v1 = a1
        end
        local v3 = v1
        if u12(v3) ~= "string" then
            v2 = "[Resources] " .. p2 .. " expected a string parameter, got " .. typeof(v3)
            error(v2, 2)
        end
        if not u54 then
            u53 = u10[u44]
            v1 = GetLocalFolder
            if not u52 then
                v2 = u44
            else
                v2 = u44:sub(6)
            end
            u54 = v1(v2)
            if not u53 then
                local v4
                u53 = u54:GetChildren()
                u10[u44] = u53
                v1 = #u53
                v2 = 1
                for i = 1, v1, v2 do
                    v4 = u53[i]
                    u53[v4.Name] = v4
                    u53[i] = nil
                end
            end
        end
        v1 = u53[v3]
        if not v1 then
            if u17 then
                v1 = GetFirstChild(u54, v3, u27)
            elseif not u52 then
                v1 = u54:WaitForChild(v3, 5)
                if not v1 then
                    local script = getfenv(0).script
                    if not script then
                        if u27 == "Library" then
                            warn("[Resources] Did you forget to install " .. v3 .. "?")
                        elseif u27 == "Folder" then
                            warn("[Resources] Make sure a Script in ServerScriptService calls `require(ReplicatedStorage:WaitForChild(\"Resources\"))`")
                        end
                    elseif script.Parent and script.Parent.Parent == script then
                        warn("[Resources] Make sure a Script in ServerScriptService calls `Resources:LoadLibrary(\"" .. script.Name .. "\")`")
                    end
                    v1 = u54:WaitForChild(v3)
                end
            else
                v1 = GetFirstChild(u54, v3, u27)
            end
            u53[v3] = v1
        end
        return v1
    end
    u338[p2] = GetFunction
    return GetFunction
end
if u17 then
    u14 = game:GetService("ServerStorage")
    local Repository = u14:FindFirstChild("Repository")
    if not Repository then
        local ServerScriptService = game:GetService("ServerScriptService")
        Repository = ServerScriptService:FindFirstChild("Repository")
    end
    local function CacheLibrary(p1, p2, p3) -- Line: 152
        if not (p1[p2.Name]) then
            p1[p2.Name] = p2
            return
        end
        local FullName = p1[p2.Name]:GetFullName()
        local FullName_2 = p2:GetFullName()
        error("[Resources] Duplicate " .. p3 .. " Found:\n\t" .. FullName .. " and \n\t" .. FullName_2 .. "\nOvershadowing is only permitted when a server-only library overshadows a replicated library", 0)
    end
    if Repository then
        local ClassName, Descendants, v3, v4, v5, v6, v7, v8, v9, v10
        local v11 = {}
        local LocalTable_2 = u338:GetLocalTable("Libraries")
        local v12 = {}
        local v13 = Repository:GetChildren()
        local v14 = false
        while v13 do
            v12[v13] = nil
            v3 = #v13
            v4 = 1
            for i = 1, v3, v4 do
                v5 = v13[i]
                ClassName = v5.ClassName
                v6 = v14
                if not v6 then
                    v6 = not (not (v5.Name:find("Server", 1, true)))
                end
                if ClassName ~= "ModuleScript" then
                    if ClassName ~= "Folder" then
                        v7 = "[Resources] Instances within your Repository must be either a ModuleScript or a Folder, found: " .. ClassName .. " " .. v5:GetFullName()
                        error(v7, 0)
                    else
                        v12[v5:GetChildren()] = v6
                    end
                elseif not v6 then
                    Descendants = v5:GetDescendants()
                    v7 = nil
                    v8 = #Descendants
                    v9 = 1
                    for j = 1, v8, v9 do
                        v10 = Descendants[j]
                        if v10.Name:find("Server", 1, true) then
                            if not v7 then
                                v7 = v5:Clone()
                            end
                            v10:Destroy()
                        end
                    end
                    if v7 then
                        v7.Parent = u338:GetLocalFolder("Libraries")
                        CacheLibrary(v11, v7, "ServerLibraries")
                    end
                    v5.Parent = u338:GetFolder("Libraries")
                    CacheLibrary(LocalTable_2, v5, "ReplicatedLibraries")
                else
                    v5.Parent = u338:GetLocalFolder("Libraries")
                    CacheLibrary(v11, v5, "ServerLibraries")
                end
            end
            v3, v4 = next(v12)
            v13 = v3
            v14 = v4
        end
        v3 = next
        v4 = v11
        local v15 = nil
        for k, n in v3, v4, v15 do
            LocalTable_2[k] = n
        end
        Repository:Destroy()
    end
else
    local LocalPlayer
    while true do
        LocalPlayer = game:GetService("Players").LocalPlayer
        if LocalPlayer or not (wait()) then
            break
        end
    end
    while true do
        u14 = LocalPlayer:FindFirstChildOfClass("PlayerScripts")
        if u14 or not (wait()) then
            break
        end
    end
end
local LocalTable = u338:GetLocalTable("LoadedLibraries")
local u315 = {}
function u338.LoadLibrary(p1, p2) -- Line: 235 -- upvalues: u338 (val), LocalTable (val), u315 (val), u353 (val)
    local v1
    if p1 == u338 then
        v1 = p2
    else
        v1 = p1
    end
    local v2 = v1
    v1 = LocalTable[v2]
    if v1 == nil then
        local Name, v3, v4
        local script = getfenv(0).script
        if not script then
            script = {Name = "Command bar"}
        end
        local Library = u338:GetLibrary(v2)
        u315[script] = Library
        local v5 = Library
        local v6 = 0
        while v5 do
            v6 = v6 + 1
            v5 = u315[v5]
            if v5 == Library then
                Name = v5.Name
                v3 = v6
                v4 = 1
                for i = 1, v3, v4 do
                    v5 = u315[v5]
                    Name = Name .. " -> " .. v5.Name
                end
                error("[Resources] Circular dependency chain detected: " .. Name)
            end
        end
        v1 = u353(Library)
        if u315[script] == Library then
            u315[script] = nil
        end
        if v1 == nil then
            error("[Resources] " .. v2 .. " must return a non-nil value. Return false instead.")
        end
        LocalTable[v2] = v1
    end
    return v1
end
v1.__call = u338.LoadLibrary
return u338