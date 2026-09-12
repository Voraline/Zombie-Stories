local u0 = {}
local u1 = nil
local u2 = nil

function BuildNodes(self) -- Line: 22 -- upvalues: u2 (ref), u1 (ref)
    local Attribute_2, Neighbors, Neighbors_2, v1, v2, v3, v4, v5
    if u2 == self then
        return
    end
    u2 = self
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
    u1 = v6
end

function u0.FindNearestNode(p1, p2, p3) -- Line: 65 -- upvalues: u1 (ref)
    local Magnitude
    local v1 = (1 / 0)
    local v2 = nil
    local v3, v4 = p3, p2
    for i, v in ipairs(u1) do
        if v3 == nil or not v3[v] then
            Magnitude = (v4 - v.Position).Magnitude
            if Magnitude < v1 then
                v1 = Magnitude
                v2 = v
            end
        end
    end
    return v2
end

function u0.FindPath(p1, p2, p3, p4, p5) -- Line: 79 -- upvalues: u0 (val)
    local F, v1, v2, v3, v4
    local v5 = {}
    local v6 = false
    if not p4 then
        v3 = u0:FindNearestNode(p2)
    else
        v3 = p4
    end
    if not p5 then
        v4 = u0:FindNearestNode(p3)
    else
        v4 = p5
    end
    local u64 = {}
    u64[v3] = true
    local v7 = {}

    local function FindLowestFNode() -- Line: 90 -- upvalues: u64 (val)
        local F = (1 / 0)
        local v1 = nil
        for k in pairs(u64) do
            if k.F < F then
                F = k.F
                v1 = k
            end
        end
        return v1
    end

    while next(u64) do
        F = (1 / 0)
        v2 = nil
        for k in pairs(u64) do
            if k.F < F then
                F = k.F
                v2 = k
            end
        end
        v1 = v2
        u64[v1] = nil
        v7[v1] = true
        if v1 == v4 then
            v6 = true
            break
        end
        for i, v in ipairs(v1.Neighbors) do
            if not v7[v] then
                if not u64[v] then
                    u64[v] = true
                    v.Parent = v1
                    v.G = v1.G + (v.Position - v1.Position).Magnitude
                    v.H = (v.Position - v4.Position).Magnitude
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
        local Position
        local Parent = v4
        while Parent do
            Position = Parent.Position
            table.insert(v5, 1, Position)
            table.insert(v1, 1, Parent)
            Parent = Parent.Parent
        end
    end

    local function ResetNodeDictionary(p1) -- Line: 151
        for k in pairs(p1) do
            k.F = 0
            k.G = 0
            k.H = 0
            k.Parent = nil
        end
    end

    for k2 in pairs(u64) do
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

function u0.Init(p1, p2, p3) -- Line: 169
    BuildNodes(p2)
end

return u0