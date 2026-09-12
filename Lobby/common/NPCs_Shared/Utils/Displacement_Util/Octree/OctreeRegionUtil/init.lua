local u2 = require("@self/Draw")
local u3 = {
    {0.25, 0.25, -0.25},
    {-0.25, 0.25, -0.25},
    {0.25, 0.25, 0.25},
    {-0.25, 0.25, 0.25},
    {0.25, -0.25, -0.25},
    {-0.25, -0.25, -0.25},
    {0.25, -0.25, 0.25},
    {-0.25, -0.25, 0.25},
}
local u36 = {}

function u36.visualize(p1) -- Line: 34 -- upvalues: u2 (val)
    local size = p1.size
    local position = p1.position
    local v1 = size[1]
    local v2 = size[2]
    local v3 = size[3]
    local v4 = position[1]
    local v5 = position[2]
    local v6 = position[3]
    local v7 = u2
    v7 = v7.box(Vector3.new(v4, v5, v6), (Vector3.new(v1, v2, v3)))
    v7.Transparency = 0.9
    local depth = p1.depth
    v7.Name = "OctreeRegion_" .. tostring(depth)
    return v7
end

function u36.create(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 85
    local v1 = p4 / 2
    local v2 = p5 / 2
    local v3 = p6 / 2
    local v4 = {node_count = 0, subRegions = {}}
    v4.lowerBounds = {p1 - v1, p2 - v2, p3 - v3}
    v4.upperBounds = {p1 + v1, p2 + v2, p3 + v3}
    v4.position = {p1, p2, p3}
    local v5 = {p4, p5, p6}
    v4.size = v5
    v4.parent = p7
    if not p7 then
        v5 = 1
    else
        v5 = p7.depth + 1
        if not v5 then
            v5 = 1
        end
    end
    v4.depth = v5
    v4.parentIndex = p8
    v4.nodes = {}
    return v4
end

function u36.addNode(p1, p2) -- Line: 122
    assert(p2, "Bad node")
    local parent = p1
    local v1 = p2
    while parent do
        if not parent.nodes[v1] then
            parent.nodes[v1] = v1
            parent.node_count = parent.node_count + 1
        end
        parent = parent.parent
    end
end

function u36.moveNode(p1, p2, p3) -- Line: 142
    local parent, v1
    local v2 = p1.depth == p2.depth
    assert(v2, "fromLowest.depth ~= toLowest.depth")
    v2 = p1 ~= p2
    assert(v2, "fromLowest == toLowest")
    local parent_2 = p1
    local parent_3 = p2
    local v3 = p3
    while parent_2 ~= parent_3 do
        v1 = parent_2.nodes[v3]
        assert(v1, "Not in currentFrom")
        v1 = 0 < parent_2.node_count
        assert(v1, "No nodes in currentFrom")
        parent_2.nodes[v3] = nil
        parent_2.node_count = parent_2.node_count - 1
        if parent_2.node_count <= 0 and parent_2.parentIndex then
            parent = parent_2.parent
            assert(parent, "Bad currentFrom.parent")
            v1 = parent_2.parent.subRegions[parent_2.parentIndex] == parent_2
            assert(v1, "Not in subregion")
            parent_2.parent.subRegions[parent_2.parentIndex] = nil
        end
        v1 = not parent_3.nodes[v3]
        assert(v1, "Failed to add")
        parent_3.nodes[v3] = v3
        parent_3.node_count = parent_3.node_count + 1
        parent_2 = parent_2.parent
        parent_3 = parent_3.parent
    end
end

function u36.removeNode(p1, p2) -- Line: 183
    local parent, v1
    assert(p2, "Bad node")
    local parent_2 = p1
    local v2 = p2
    while parent_2 do
        v1 = parent_2.nodes[v2]
        assert(v1, "Not in current")
        v1 = 0 < parent_2.node_count
        assert(v1, "Current has bad node count")
        parent_2.nodes[v2] = nil
        parent_2.node_count = parent_2.node_count - 1
        if parent_2.node_count <= 0 and parent_2.parentIndex then
            parent = parent_2.parent
            assert(parent, "No parent")
            v1 = parent_2.parent.subRegions[parent_2.parentIndex] == parent_2
            assert(v1, "Not in subregion")
            parent_2.parent.subRegions[parent_2.parentIndex] = nil
        end
        parent_2 = parent_2.parent
    end
end

function u36.getSearchRadiusSquared(p1, p2, p3) -- Line: 215
    local v1 = p1 + 0.8660254037844386 * p2
    return v1 * v1 + p3
end

function u36.getNeighborsWithinRadius(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 237 -- upvalues: u36 (val)
    local RawPosition, RawPosition_2, RawPosition_3, position, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    assert(p8, "Bad maxDepth")
    local v12 = p1.size[1] / 2
    local v13 = u36.getSearchRadiusSquared(p2, v12, 1e-06)
    local v14 = p2 * p2
    local v15, v16, v17, v18, v19, v20, v21 = p3, p4, p5, p8, p6, p7, p2
    for k, v in pairs(p1.subRegions) do
        position = v.position
        v1 = position[1]
        v2 = position[2]
        v3 = position[3]
        v4 = v15 - v1
        v5 = v16 - v2
        v6 = v17 - v3
        if v4 * v4 + v5 * v5 + v6 * v6 <= v13 then
            if v.depth ~= v18 then
                u36.getNeighborsWithinRadius(v, v21, v15, v16, v17, v19, v20, v18)
            else
                for k2, i in pairs(v.nodes) do
                    RawPosition, RawPosition_2, RawPosition_3 = k2:GetRawPosition()
                    v7 = v15 - RawPosition
                    v8 = v16 - RawPosition_2
                    v9 = v17 - RawPosition_3
                    v11 = v7 * v7 + v8 * v8
                    v10 = v11 + v9 * v9
                    if v10 <= v14 then
                        v11 = #v19 + 1
                        v19[v11] = (k2:GetObject())
                        v20[#v20 + 1] = v10
                    end
                end
            end
        end
    end
end

function u36.getOrCreateSubRegionAtDepth(p1, p2, p3, p4, p5) -- Line: 285 -- upvalues: u36 (val)
    local v1, v2
    local v3 = p1
    local v4 = p5
    local v5, v6, v7 = p2, p3, p4
    for i = p1.depth, v4 do
        v2 = u36.getSubRegionIndex(v3, v5, v6, v7)
        v1 = v3.subRegions[v2]
        if not v1 then
            v1 = u36.createSubRegion(v3, v2)
            v3.subRegions[v2] = v1
        end
        v3 = v1
    end
    return v3
end

function u36.createSubRegion(p1, p2) -- Line: 309 -- upvalues: u3 (val), u36 (val)
    local size = p1.size
    local position = p1.position
    local v1 = u3[p2]
    local v2 = position[1] + v1[1] * size[1]
    local v3 = position[2] + v1[2] * size[2]
    local v4 = position[3] + v1[3] * size[3]
    local v5 = size[1] / 2
    local v6 = size[2] / 2
    local v7 = size[3] / 2
    return u36.create(v2, v3, v4, v5, v6, v7, p1, p2)
end

function u36.inRegionBounds(p1, p2, p3, p4) -- Line: 333
    local lowerBounds = p1.lowerBounds
    local upperBounds = p1.upperBounds
    local v1 = false
    if lowerBounds[1] <= p2 then
        v1 = false
        if p2 <= upperBounds[1] then
            v1 = false
            if lowerBounds[2] <= p3 then
                v1 = false
                if p3 <= upperBounds[2] then
                    v1 = false
                    if lowerBounds[3] <= p4 then
                        v1 = p4 <= upperBounds[3]
                    end
                end
            end
        end
    end
    return v1
end

function u36.getSubRegionIndex(p1, p2, p3, p4) -- Line: 352
    local v1
    if not (p1.position[1] < p2) then
        v1 = 2
    else
        v1 = 1
    end
    if p3 <= p1.position[2] then
        v1 = v1 + 4
    end
    if p1.position[3] <= p4 then
        v1 = v1 + 2
    end
    return v1
end

function u36.getTopLevelRegionHash(p1, p2, p3) -- Line: 374
    return p1 * 73856093 + p2 * 19351301 + p3 * 83492791
end

function u36.getTopLevelRegionCellIndex(p1, p2, p3, p4) -- Line: 390
    local v1 = p1[1]
    local v2 = p2 / v1 + 0.5
    local v3 = math.floor(v2)
    local v4 = p1[2]
    local v5 = p3 / v4 + 0.5
    v2 = math.floor(v5)
    local v6 = p1[3]
    v1 = p4 / v6 + 0.5
    return v3, v2, (math.floor(v1))
end

function u36.getTopLevelRegionPosition(p1, p2, p3, p4) -- Line: 407
    return p1[1] * p2, p1[2] * p3, p1[3] * p4
end

function u36.areEqualTopRegions(p1, p2, p3, p4) -- Line: 423
    local position = p1.position
    local v1 = false
    if position[1] == p2 then
        v1 = false
        if position[2] == p3 then
            v1 = position[3] == p4
        end
    end
    return v1
end

function u36.findRegion(p1, p2, p3, p4, p5) -- Line: 440 -- upvalues: u36 (val)
    local v1, v2, v3 = u36.getTopLevelRegionCellIndex(p2, p3, p4, p5)
    local v4 = p1[u36.getTopLevelRegionHash(v1, v2, v3)]
    if not v4 then
        return nil
    end
    local v5, v6, v7 = u36.getTopLevelRegionPosition(p2, v1, v2, v3)
    for k, v in pairs(v4) do
        if u36.areEqualTopRegions(v, v5, v6, v7) then
            return v
        end
    end
    return nil
end

function u36.getOrCreateRegion(p1, p2, p3, p4, p5) -- Line: 469 -- upvalues: u36 (val)
    local v1, v2, v3 = u36.getTopLevelRegionCellIndex(p2, p3, p4, p5)
    local v4 = u36.getTopLevelRegionHash(v1, v2, v3)
    local v5 = p1[v4]
    if not v5 then
        v5 = {}
        p1[v4] = v5
    end
    local v6, v7, v8 = u36.getTopLevelRegionPosition(p2, v1, v2, v3)
    for k, v in pairs(v5) do
        if u36.areEqualTopRegions(v, v6, v7, v8) then
            return v
        end
    end
    local v9 = u36.create(v6, v7, v8, p2[1], p2[2], p2[3])
    table.insert(v5, v9)
    return v9
end

return u36