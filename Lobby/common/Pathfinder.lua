local PathfindingService = game:GetService("PathfindingService")
local u5 = {NodesAreSetup = false}
local u6 = nil

function BuildNodes(self) -- Line: 21 -- upvalues: u6 (ref), u5 (val)
    local Attribute_2, Neighbors, Neighbors_2, v1, v2, v3, v4, v5
    local v6 = {}
    local v7 = {}
    for i, v in ipairs(self:GetChildren()) do
        if v:IsA("Folder") then
            v4 = {
                F = 0,
                G = 0,
                H = 0,
                Position = v:GetAttribute("NodePosition"),
                Neighbors = {},
            }
            table.insert(v6, v4)
            v7[v:GetAttribute("NodeId")] = v4
        end
    end
    for i2, i3 in ipairs(self:GetChildren()) do
        if i3:IsA("Folder") then
            v4 = (i3:GetAttribute("NodeLinks")):split(",")
            v5 = v7[i3:GetAttribute("NodeId")]
            for i4, j in ipairs(v4) do
                v1 = v7[j]
                v2 = j ~= ""
                Attribute_2 = i3:GetAttribute("NodeId")
                v3 = ("Node '%s' has no neighbors"):format(Attribute_2)
                assert(v2, v3)
                Neighbors = v5.Neighbors
                table.insert(Neighbors, v1)
                Neighbors_2 = v1.Neighbors
                table.insert(Neighbors_2, v5)
            end
        end
    end
    u6 = v6
    u5.NodesAreSetup = true
end

function u5.FindNearestNode(p1, p2, p3, p4) -- Line: 56 -- upvalues: u6 (ref)
    local Magnitude
    local v1 = p4 or 1
    local v2 = (1 / 0)
    local v3 = nil
    local v4, v5 = p3, p2
    for i, v in ipairs(u6) do
        if v4 == nil or not v4[v] then
            Magnitude = ((v5 - v.Position) * Vector3.new(1, v1, 1)).Magnitude
            if Magnitude < v2 then
                v2 = Magnitude
                v3 = v
            end
        end
    end
    return v3
end

function u5.UseRoblox(p1, p2, p3) -- Line: 71 -- upvalues: PathfindingService (val)
    local u8 = PathfindingService:CreatePath({
        AgentRadius = 1,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentCanClimb = true,
        WaypointSpacing = 4,
    })
    local success = pcall(function() -- Line: 82 -- upvalues: u8 (val), p2 (val), p3 (val)
        local v1 = u8
        local v2 = p2
        local v3 = p3
        v1:ComputeAsync(v2, v3)
    end)
    if success and u8.Status == Enum.PathStatus.Success then
        local Position
        local Waypoints = u8:GetWaypoints()
        local v1 = {}
        local v2 = Waypoints
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            Position = j.Position
            table.insert(v1, Position)
        end
        return v1
    end
    return nil
end

function u5.FindPath(p1, p2, p3, p4, p5) -- Line: 100 -- upvalues: u5 (val)
    local F, Magnitude, Position, Position_2, v1, v2, v3, v4
    local v5 = {}
    local v6 = false
    if not p4 then
        v3 = u5:FindNearestNode(p2, nil, 1.15)
    else
        v3 = p4
    end
    if not p5 then
        v4 = u5:FindNearestNode(p3, nil, 1.25)
    else
        v4 = p5
    end
    local u110 = {}
    u110[v3] = true
    local v7 = {}

    local function FindLowestFNode() -- Line: 111 -- upvalues: u110 (val)
        local F = (1 / 0)
        local v1 = nil
        for k in pairs(u110) do
            if k.F < F then
                F = k.F
                v1 = k
            end
        end
        return v1
    end

    local function Heuristic(p1, p2) -- Line: 122
        local Position = p1.Position
        local Position_2 = p2.Position
        local Magnitude = (Position - Position_2).Magnitude
        if Magnitude < 5 then
            Magnitude = ((Position - Position_2) * Vector3.new(1, 1.25, 1)).Magnitude
        end
        return Magnitude
    end

    while next(u110) do
        F = (1 / 0)
        v2 = nil
        for k in pairs(u110) do
            if k.F < F then
                F = k.F
                v2 = k
            end
        end
        v1 = v2
        u110[v1] = nil
        v7[v1] = true
        if v1 == v4 then
            v6 = true
            break
        end
        for i, v in ipairs(v1.Neighbors) do
            if not v7[v] then
                if not u110[v] then
                    u110[v] = true
                    v.Parent = v1
                    v.G = v1.G + (v.Position - v1.Position).Magnitude
                    Position = v.Position
                    Position_2 = v4.Position
                    Magnitude = (Position - Position_2).Magnitude
                    if Magnitude < 5 then
                        Magnitude = ((Position - Position_2) * Vector3.new(1, 1.25, 1)).Magnitude
                    end
                    v.H = Magnitude
                    v.F = v.G + v.H
                elseif v.G < v1.G then
                    v.Parent = v1
                    v.G = v1.G + (v.Position - v1.Position).Magnitude
                    v.F = v.G + v.H
                end
            end
        end
    end
    v1 = {}
    if v6 then
        local Position_3
        local Parent = v4
        while Parent do
            Position_3 = Parent.Position
            table.insert(v5, 1, Position_3)
            table.insert(v1, 1, Parent)
            Parent = Parent.Parent
        end
    end

    local function ResetNodeDictionary(p1) -- Line: 182
        for k in pairs(p1) do
            k.F = 0
            k.G = 0
            k.H = 0
            k.Parent = nil
        end
    end

    for k2 in pairs(u110) do
        k2.F = 0
        k2.G = 0
        k2.H = 0
        k2.Parent = nil
    end
    for k3 in pairs(v7) do
        k3.F = 0
        k3.G = 0
        k3.H = 0
        k3.Parent = nil
    end
    if v6 ~= nil then
        return v5, v1
    end
    return nil
end

function u5.Init(p1, p2) -- Line: 199
    BuildNodes(p2)
end

return u5