local NPCs_WalkableSpace, X, X_2, Y, Y_2, Z, Z_2, createNode, v1, v2, v3, v4, v5, v6, v7, v8
local u226 = require(script:WaitForChild("Octree")).new()
local u227 = -32768
local u118 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
if not ReplicatedStorage:FindFirstChild("chapter") then
    NPCs_WalkableSpace = ReplicatedStorage:FindFirstChild("arc")
    if NPCs_WalkableSpace then
        NPCs_WalkableSpace = ReplicatedStorage.arc:FindFirstChild("NPCs_WalkableSpace")
    end
else
    NPCs_WalkableSpace = ReplicatedStorage.chapter:FindFirstChild("NPCs_WalkableSpace")
    if not NPCs_WalkableSpace then
        NPCs_WalkableSpace = ReplicatedStorage:FindFirstChild("arc")
        if NPCs_WalkableSpace then
            NPCs_WalkableSpace = ReplicatedStorage.arc:FindFirstChild("NPCs_WalkableSpace")
        end
    end
end
local Children = NPCs_WalkableSpace:GetChildren()
table.sort(Children, function(p1, p2) -- Line: 11
    local v1 = p1.Name < p2.Name
    return v1
end)
local v9 = Children
local v10 = nil
local v11 = nil
for i, j in v9, v10, v11 do
    if j:IsA("BasePart") then
        v1 = -j.Size / 2
        v2 = j.Size / 2

        function createNode(p1) -- Line: 24 -- upvalues: u227 (ref), j (val), u226 (val), u118 (val)
            u227 = u227 + 1
            local v1 = j.CFrame:PointToWorldSpace(p1)
            local v2 = u226
            local v3 = u227
            local v4 = tostring(v3)
            v2:CreateNode(v1, v4)
            v2 = u118
            local v5 = u227
            v2[tostring(v5)] = v1
        end

        X = v1.X
        X_2 = v2.X
        for k = X, X_2, 326 do
            Y = v1.Y
            Y_2 = v2.Y
            for n = Y, Y_2, 326 do
                Z = v1.Z
                Z_2 = v2.Z
                for m = Z, Z_2, 326 do
                    v4 = Vector3.new(k, n, m)
                    u227 = u227 + 1
                    v5 = j.CFrame:PointToWorldSpace(v4)
                    v8 = u227
                    v7 = tostring(v8)
                    u226:CreateNode(v5, v7)
                    v6 = u227
                    u118[tostring(v6)] = v5
                end
            end
        end
    end
end
if 32767 < u227 then
    error("too many uids")
end
local u58 = {}
for i5 = 1, 50 do
    u227 = u227 + 1
    v3 = u227
    v2 = tostring(v3)
    table.insert(u58, v2)
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
            local v2 = u58
            table.insert(v2, v1)
            print(p1.Name .. " removed, freeing UID " .. v1)
        end
    end

    for i6, i7 in game.Players:GetPlayers() do end
end
return {
    GetClosestNode = function(p1, p2) -- Line: 110 -- upvalues: u226 (val), u118 (val)
        local v1 = u226:KNearestNeighborsSearch(p2, 1, 326)
        if v1 and v1[1] then
            local v2 = u118[v1[1]] - p2
            return v1[1], v2
        end
    end,
    GetPlayerDisplacement = function(p1, p2, p3) -- Line: 118 -- upvalues: u79 (val)
        if not p2 then
            return (Vector3.new(0, 0, 0))
        end
        local v1 = u79[p2.Name]
        if not v1 then
            return (Vector3.new(0, 0, 0))
        end
        if p2.Character and p2.Character.Parent and p2.Character.PrimaryPart then
            return p2.Character.PrimaryPart.Position - p3, v1
        end
        return (Vector3.new(0, 0, 0))
    end,
    GetNodePos = function(p1, p2) -- Line: 134 -- upvalues: u118 (val)
        if u118[tostring(p2)] == nil then
            return nil
        end
        local v1 = u118
        local v2 = v1[(tostring(p2))]
        if typeof(v2) == "Vector3" then
            return u118[tostring(p2)]
        end
        return u118[tostring(p2)].Character.PrimaryPart.Position, u118[tostring(p2)].Character.PrimaryPart
    end,
}