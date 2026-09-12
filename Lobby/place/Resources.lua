local RunService = game:GetService("RunService")
local v1 = {}
local u338 = setmetatable({}, v1)
local u10 = {}
local new = Instance.new
local u12 = type
local u353 = require
local u14 = nil
local u17 = RunService:IsServer()
local v2 = {
    __index = function(p1, p2) -- Line: 22 -- upvalues: new (val)
        local v1
        local success, result = pcall(new, p2)
        if not success or not result then
            v1 = true
        else
            result:Destroy()
            v1 = false
        end
        p1[p2] = v1
        return v1
    end,
}
local u22 = setmetatable({
    Folder = false,
    RemoteEvent = false,
    BindableEvent = false,
    RemoteFunction = false,
    BindableFunction = false,
    Library = true,
}, v2)

function u338.GetLocalTable(p1, p2) -- Line: 38 -- upvalues: u338 (val), u10 (val)
    local v1 = p1 ~= u338 and p1 or p2
    local v2 = v1
    v1 = u10[v2]
    if not v1 then
        v1 = {}
        u10[v2] = v1
    end
    return v1
end

local function GetFirstChild(p1, p2, p3) -- Line: 50 -- upvalues: u22 (val), new (val)
    local v1 = p1:FindFirstChild(p2)
    if not v1 then
        if u22[p3] then
            local v2 = error
            local FullName = p1:GetFullName()
            v2("[Resources] " .. p3 .. " \"" .. p2 .. "\" is not installed within " .. FullName .. ".", 2)
        end
        v1 = new(p3)
        v1.Name = p2
        v1.Parent = p1
    end
    return v1
end

function v1.__index(p1, p2) -- Line: 63
    -- upvalues: u12 (val), GetFirstChild (val), u14 (ref), u338 (val), u10 (val), u17 (val)
    local GetLocalFolder, u44
    if u12(p2) ~= "string" then
        error("[Resources] Attempt to index Resources with invalid key: string expected, got " .. typeof(p2), 2)
    end
    if p2:sub(1, 3) ~= "Get" then
        error("[Resources] Methods should begin with \"Get\"", 2)
    end
    local u27 = p2:sub(4)
    local v1, v2 = u27:byte(-2, -1)
    if v2 ~= 121 or v1 == 97 or v1 == 101 or v1 == 105 or v1 == 111 or v1 == 117 then
        u44 = u27 .. "s"
    else
        u44 = (u27:sub(1, -2)) .. "ies"
        if not u44 then
            u44 = u27 .. "s"
        end
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

    local function GetFunction(p1_2, p2_2) -- Line: 90
        -- upvalues: p1 (val), u12 (upval), p2 (val), u54 (ref), u53 (ref), u10 (upval), u44 (val), GetLocalFolder (ref)
        -- upvalues: u52 (val), u17 (upval), GetFirstChild (upval), u27 (ref)
        local v1 = p1_2 ~= p1 and p1_2 or p2_2
        local v2 = v1
        if u12(v2) ~= "string" then
            error("[Resources] " .. p2 .. " expected a string parameter, got " .. typeof(v2), 2)
        end
        if not u54 then
            local v3
            u53 = u10[u44]
            v1 = GetLocalFolder
            if not u52 then
                v3 = u44
            else
                v3 = u44:sub(6)
                if not v3 then
                    v3 = u44
                end
            end
            u54 = v1(v3)
            if not u53 then
                local v4
                u53 = u54:GetChildren()
                u10[u44] = u53
                v1 = #u53
                for i = 1, v1 do
                    v4 = u53[i]
                    u53[v4.Name] = v4
                    u53[i] = nil
                end
            end
        end
        v1 = u53[v2]
        if not v1 then
            if u17 then
                v1 = GetFirstChild(u54, v2, u27)
            elseif not u52 then
                v1 = u54:WaitForChild(v2, 5)
                if not v1 then
                    local script_2 = getfenv(0).script
                    if not script_2 or not script_2.Parent then
                        if u27 == "Library" then
                            warn("[Resources] Did you forget to install " .. v2 .. "?")
                        elseif u27 == "Folder" then
                            warn("[Resources] Make sure a Script in ServerScriptService calls `require(ReplicatedStorage:WaitForChild(\"Resources\"))`")
                        end
                    elseif script_2.Parent.Parent == script then
                        warn("[Resources] Make sure a Script in ServerScriptService calls `Resources:LoadLibrary(\"" .. script_2.Name .. "\")`")
                    elseif u27 == "Library" then
                        warn("[Resources] Did you forget to install " .. v2 .. "?")
                    elseif u27 == "Folder" then
                        warn("[Resources] Make sure a Script in ServerScriptService calls `require(ReplicatedStorage:WaitForChild(\"Resources\"))`")
                    end
                    v1 = u54:WaitForChild(v2)
                end
            else
                v1 = GetFirstChild(u54, v2, u27)
            end
            u53[v2] = v1
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
        Repository = (game:GetService("ServerScriptService")):FindFirstChild("Repository")
    end

    local function CacheLibrary(p1, p2, p3) -- Line: 152
        if not p1[p2.Name] then
            p1[p2.Name] = p2
            return
        end
        local v1 = error
        local FullName = p1[p2.Name]:GetFullName()
        local FullName_2 = p2:GetFullName()
        v1(
            "[Resources] Duplicate " .. p3 .. " Found:\n\t" .. FullName .. " and \n\t" .. FullName_2 .. "\nOvershadowing is only permitted when a server-only library overshadows a replicated library",
            0
        )
    end

    if Repository then
        local ClassName, Descendants, v3, v4, v5, v6, v7, v8, v9
        local v10 = {}
        local LocalTable_2 = u338:GetLocalTable("Libraries")
        local v11 = {}
        local v12 = Repository:GetChildren()
        local v13 = false
        while v12 do
            v11[v12] = nil
            v3 = #v12
            for i = 1, v3 do
                v5 = v12[i]
                ClassName = v5.ClassName
                v6 = v13
                if not v6 then
                    v6 = not not v5.Name:find("Server", 1, true)
                end
                if ClassName ~= "ModuleScript" then
                    if ClassName ~= "Folder" then
                        error(
                            "[Resources] Instances within your Repository must be either a ModuleScript or a Folder, found: " .. ClassName .. " " .. v5:GetFullName(),
                            0
                        )
                    else
                        v11[v5:GetChildren()] = v6
                    end
                elseif not v6 then
                    Descendants = v5:GetDescendants()
                    v7 = nil
                    v8 = #Descendants
                    for j = 1, v8 do
                        v9 = Descendants[j]
                        if v9.Name:find("Server", 1, true) then
                            if not v7 then
                                v7 = v5:Clone()
                            end
                            v9:Destroy()
                        end
                    end
                    if v7 then
                        v7.Parent = u338:GetLocalFolder("Libraries")
                        CacheLibrary(v10, v7, "ServerLibraries")
                    end
                    v5.Parent = u338:GetFolder("Libraries")
                    CacheLibrary(LocalTable_2, v5, "ReplicatedLibraries")
                else
                    v5.Parent = u338:GetLocalFolder("Libraries")
                    CacheLibrary(v10, v5, "ServerLibraries")
                end
            end
            v3, v4 = next(v11)
            v12 = v3
            v13 = v4
        end
        v3 = next
        v4 = v10
        local v14 = nil
        for k, n in v3, v4, v14 do
            LocalTable_2[k] = n
        end
        Repository:Destroy()
    end
else
    local LocalPlayer
    repeat
        LocalPlayer = game:GetService("Players").LocalPlayer
    until LocalPlayer or not wait()
    repeat
        u14 = LocalPlayer:FindFirstChildOfClass("PlayerScripts")
    until u14 or not wait()
end
local LocalTable = u338:GetLocalTable("LoadedLibraries")
local u315 = {}

function u338.LoadLibrary(p1, p2) -- Line: 235 -- upvalues: u338 (val), LocalTable (val), u315 (val), u353 (val)
    local v1 = p1 ~= u338 and p1 or p2
    local v2 = v1
    v1 = LocalTable[v2]
    if v1 == nil then
        local Name, v3
        local script = getfenv(0).script
        if not script then
            script = {Name = "Command bar"}
        end
        local Library = u338:GetLibrary(v2)
        u315[script] = Library
        local v4 = Library
        local v5 = 0
        while v4 do
            v5 = v5 + 1
            v4 = u315[v4]
            if v4 == Library then
                Name = v4.Name
                v3 = v5
                for i = 1, v3 do
                    v4 = u315[v4]
                    Name = Name .. " -> " .. v4.Name
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