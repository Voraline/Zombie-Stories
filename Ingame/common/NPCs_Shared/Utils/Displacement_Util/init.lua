local NPCs_WalkableSpace, X, Y, Z, createNode, v1, v2, v3, v4, v5, v6, v7
local u226 = require(script:WaitForChild("Octree")).new()
local u227 = -32768
local u118 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
if not (ReplicatedStorage:FindFirstChild("chapter")) then
    NPCs_WalkableSpace = ReplicatedStorage:FindFirstChild("arc")
    if NPCs_WalkableSpace then
        NPCs_WalkableSpace = ReplicatedStorage.arc:FindFirstChild("NPCs_WalkableSpace")
    end
else
    NPCs_WalkableSpace = ReplicatedStorage.chapter:FindFirstChild("NPCs_WalkableSpace")
end
local Children = NPCs_WalkableSpace:GetChildren()
table.sort(Children, function(p1, p2) -- Line: 11
    local v1 = p1.Name < p2.Name
    return v1
end)
local v8 = Children
local v9 = nil
local v10 = nil
for i, j in v8, v9, v10 do
    if j:IsA("BasePart") then
        v1 = -j.Size / 2
        v2 = j.Size / 2
        function createNode(p1) -- Line: 24 -- upvalues: u227 (ref), j (val), u226 (val), u118 (val)
            u227 = u227 + 1
            local v1 = j.CFrame:PointToWorldSpace(p1)
            u226:CreateNode(v1, (tostring(u227)))
            u118[tostring(u227)] = v1
        end
        X = v2.X
        v3 = 326
        for k = v1.X, X, v3 do
            Y = v2.Y
            v4 = 326
            for n = v1.Y, Y, v4 do
                Z = v2.Z
                v5 = 326
                for m = v1.Z, Z, v5 do
                    v6 = Vector3.new(k, n, m)
                    u227 = u227 + 1
                    v7 = j.CFrame:PointToWorldSpace(v6)
                    u226:CreateNode(v7, (tostring(u227)))
                    u118[tostring(u227)] = v7
                end
            end
        end
    end
end
if 32767 < u227 then
    error("too many uids")
end
local u58 = {}
v9 = 50
v10 = 1
for i5 = 1, v9, v10 do
    u227 = u227 + 1
    table.insert(u58, (tostring(u227)))
end
local u79 = {}
if game:GetService("RunService"):IsServer() then
    local function PlayerAdded(p1) -- Line: 64 -- upvalues: u58 (val), u118 (val), u79 (val)
        local v1 = table.remove(u58, 1)
        if not v1 then
            print("No available UIDs for " .. p1.Name)
            return
        end
        u118[v1] = p1
        u79[p1.Name] = v1
        print(p1.Name .. " assigned UID " .. v1)
    end
    local function PlayerRemoving(p1) -- Line: 76 -- upvalues: u79 (val), u118 (val), u58 (val)
        local v1 = u79[p1]
        if v1 then
            u118[v1] = nil
            u79[p1.Name] = nil
            table.insert(u58, v1)
            print(p1.Name .. " removed, freeing UID " .. v1)
        end
    end
    for i6, i7 in game.Players:GetPlayers() do end
end
return {
    GetClosestNode = function(p1, p2) -- Line: 110 -- upvalues: u226 (val), u118 (val)
        local v1 = u226:KNearestNeighborsSearch(p2, 1, 326)
        if not v1 then
            return
        end
        if v1[1] then
            return v1[1], u118[v1[1]] - p2
        end
    end,
    GetPlayerDisplacement = function(p1, p2, p3) -- Line: 118 -- upvalues: u79 (val)
        if not p2 then
            return (Vector3.new(0, 0, 0))
        end
        local v1 = u79[p2.Name]
        if not v1 or not p2.Character or not p2.Character.Parent or not p2.Character.PrimaryPart then
            return (Vector3.new(0, 0, 0))
        end
        return p2.Character.PrimaryPart.Position - p3, v1
    end,
    GetNodePos = function(p1, p2) -- Line: 134 -- upvalues: u118 (val)
        if u118[tostring(p2)] == nil then
            return nil
        end
        if typeof(u118[tostring(p2)]) == "Vector3" then
            return u118[tostring(p2)]
        end
        return u118[tostring(p2)].Character.PrimaryPart.Position, u118[tostring(p2)].Character.PrimaryPart
    end,
}