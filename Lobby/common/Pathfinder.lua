local PathfindingService = game:GetService("PathfindingService")
local u5 = {NodesAreSetup = false}
local u6 = nil
function BuildNodes(self) -- Line: 21 -- upvalues: u6 (ref), u5 (val)
    local Attribute, v1, v2, v3, v4
    local v5 = {}
    local v6 = {}
    for i, v in ipairs(self:GetChildren()) do
        if v:IsA("Folder") then
            v3 = {
                F = 0,
                G = 0,
                H = 0,
                Position = v:GetAttribute("NodePosition"),
                Neighbors = {},
            }
            table.insert(v5, v3)
            v6[v:GetAttribute("NodeId")] = v3
        end
    end
    for i2, i3 in ipairs(self:GetChildren()) do
        if i3:IsA("Folder") then
            Attribute = i3:GetAttribute("NodeLinks")
            v3 = Attribute:split(",")
            v4 = v6[i3:GetAttribute("NodeId")]
            for i4, j in ipairs(v3) do
                v1 = v6[j]
                v2 = j ~= ""
                assert(v2, ("Node '%s' has no neighbors"):format(i3:GetAttribute("NodeId")))
                table.insert(v4.Neighbors, v1)
                table.insert(v1.Neighbors, v4)
            end
        end
    end
    u6 = v5
    u5.NodesAreSetup = true
end
function u5.FindNearestNode(p1, p2, p3, p4) -- Line: 56 -- upvalues: u6 (ref)
    local Magnitude, v1, v2
    local v3 = p4 or 1
    local v4 = (1 / 0)
    local v5 = nil
    v2, v1 = p3, p2
    for i, v in ipairs(u6) do
        if v2 == nil then
            Magnitude = ((v1 - v.Position) * Vector3.new(1, v3, 1)).Magnitude
            if Magnitude < v4 then
                v4 = Magnitude
                v5 = v
            end
        elseif v2[v] then
        end
    end
    return v5
end
function u5.UseRoblox(p1, p2, p3) -- Line: 71 -- upvalues: PathfindingService (val)
    local u8 = PathfindingService:CreatePath({
        AgentRadius = 1,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentCanClimb = true,
        WaypointSpacing = 4,
    })
    local v1 = pcall(function() -- Line: 82 -- upvalues: u8 (val), p2 (val), p3 (val)
        u8:ComputeAsync(p2, p3)
    end)
    if not v1 or u8.Status ~= Enum.PathStatus.Success then
        return nil
    end
    local Waypoints = u8:GetWaypoints()
    local v2 = {}
    local v3 = Waypoints
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        table.insert(v2, j.Position)
    end
    return v2
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
            if not (v7[v]) then
                if not (u110[v]) then
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
        local Parent = v4
        while Parent do
            table.insert(v5, 1, Parent.Position)
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