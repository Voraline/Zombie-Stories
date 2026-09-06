local u2 = require("@self/Draw")
local u3 = {}
local v1 = {0.25, 0.25, -0.25}
local v2 = {-0.25, 0.25, -0.25}
local v3 = {0.25, 0.25, 0.25}
local v4 = {-0.25, 0.25, 0.25}
local v5 = {0.25, -0.25, -0.25}
local v6 = {-0.25, -0.25, -0.25}
local v7 = {0.25, -0.25, 0.25}
local v8 = {-0.25, -0.25, 0.25}
u3[1] = v1
u3[2] = v2
u3[3] = v3
u3[4] = v4
u3[5] = v5
u3[6] = v6
u3[7] = v7
u3[8] = v8
local u36 = {
    visualize = function(p1) -- Line: 34 -- upvalues: u2 (val)
        local size = p1.size
        local position = p1.position
        local v1 = Vector3.new(position[1], position[2], position[3])
        local v2 = u2.box(v1, (Vector3.new(size[1], size[2], size[3])))
        v2.Transparency = 0.9
        v2.Name = "OctreeRegion_" .. tostring(p1.depth)
        return v2
    end,
    create = function(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 85
        local v1 = p4 / 2
        local v2 = p5 / 2
        local v3 = p6 / 2
        local v4 = {
            node_count = 0,
            subRegions = {},
            lowerBounds = {p1 - v1, p2 - v2, p3 - v3},
            upperBounds = {p1 + v1, p2 + v2, p3 + v3},
            position = {p1, p2, p3},
        }
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
    end,
    addNode = function(p1, p2) -- Line: 122
        assert(p2, "Bad node")
        local parent = p1
        local v1 = p2
        while parent do
            if not (parent.nodes[v1]) then
                parent.nodes[v1] = v1
                parent.node_count = parent.node_count + 1
            end
            parent = parent.parent
        end
    end,
    moveNode = function(p1, p2, p3) -- Line: 142
        local v1
        local v2 = p1.depth == p2.depth
        assert(v2, "fromLowest.depth ~= toLowest.depth")
        v2 = p1 ~= p2
        assert(v2, "fromLowest == toLowest")
        local parent = p1
        local parent_2 = p2
        local v3 = p3
        while parent ~= parent_2 do
            v1 = parent.nodes[v3]
            assert(v1, "Not in currentFrom")
            v1 = 0 < parent.node_count
            assert(v1, "No nodes in currentFrom")
            parent.nodes[v3] = nil
            parent.node_count = parent.node_count - 1
            if parent.node_count <= 0 and parent.parentIndex then
                assert(parent.parent, "Bad currentFrom.parent")
                v1 = parent.parent.subRegions[parent.parentIndex] == parent
                assert(v1, "Not in subregion")
                parent.parent.subRegions[parent.parentIndex] = nil
            end
            assert(not parent_2.nodes[v3], "Failed to add")
            parent_2.nodes[v3] = v3
            parent_2.node_count = parent_2.node_count + 1
            parent = parent.parent
            parent_2 = parent_2.parent
        end
    end,
    removeNode = function(p1, p2) -- Line: 183
        local v1
        assert(p2, "Bad node")
        local parent = p1
        local v2 = p2
        while parent do
            v1 = parent.nodes[v2]
            assert(v1, "Not in current")
            v1 = 0 < parent.node_count
            assert(v1, "Current has bad node count")
            parent.nodes[v2] = nil
            parent.node_count = parent.node_count - 1
            if parent.node_count <= 0 and parent.parentIndex then
                assert(parent.parent, "No parent")
                v1 = parent.parent.subRegions[parent.parentIndex] == parent
                assert(v1, "Not in subregion")
                parent.parent.subRegions[parent.parentIndex] = nil
            end
            parent = parent.parent
        end
    end,
    getSearchRadiusSquared = function(p1, p2, p3) -- Line: 215
        local v1 = p1 + 0.8660254037844386 * p2
        return v1 * v1 + p3
    end,
}
function u36.getNeighborsWithinRadius(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 237 -- upvalues: u36 (val)
    local RawPosition, RawPosition_2, RawPosition_3, position, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
    assert(p8, "Bad maxDepth")
    local v16 = u36.getSearchRadiusSquared(p2, p1.size[1] / 2, 1e-06)
    local v17 = p2 * p2
    v2, v7, v12, v15, v13, v14, v1 = p3, p4, p5, p8, p6, p7, p2
    for k, v in pairs(p1.subRegions) do
        position = v.position
        v3 = v2 - position[1]
        v4 = v7 - position[2]
        v5 = v12 - position[3]
        v6 = v3 * v3 + v4 * v4
        if v6 + v5 * v5 <= v16 then
            if v.depth ~= v15 then
                u36.getNeighborsWithinRadius(v, v1, v2, v7, v12, v13, v14, v15)
            else
                for k2, i in pairs(v.nodes) do
                    RawPosition, RawPosition_2, RawPosition_3 = k2:GetRawPosition()
                    v8 = v2 - RawPosition
                    v9 = v7 - RawPosition_2
                    v10 = v12 - RawPosition_3
                    v11 = v8 * v8 + v9 * v9 + v10 * v10
                    if v11 <= v17 then
                        v13[#v13 + 1] = k2:GetObject()
                        v14[#v14 + 1] = v11
                    end
                end
            end
        end
    end
end
function u36.getOrCreateSubRegionAtDepth(p1, p2, p3, p4, p5) -- Line: 285 -- upvalues: u36 (val)
    local v1, v2, v3, v4, v5
    local v6 = p1
    local v7 = p5
    local v8 = 1
    v1, v3, v4 = p2, p3, p4
    for i = p1.depth, v7, v8 do
        v5 = u36.getSubRegionIndex(v6, v1, v3, v4)
        v2 = v6.subRegions[v5]
        if not v2 then
            v2 = u36.createSubRegion(v6, v5)
            v6.subRegions[v5] = v2
        end
        v6 = v2
    end
    return v6
end
function u36.createSubRegion(p1, p2) -- Line: 309 -- upvalues: u3 (val), u36 (val)
    local size = p1.size
    local position = p1.position
    local v1 = u3[p2]
    return u36.create(position[1] + v1[1] * size[1], position[2] + v1[2] * size[2], position[3] + v1[3] * size[3], size[1] / 2, size[2] / 2, size[3] / 2, p1, p2)
end
function u36.inRegionBounds(p1, p2, p3, p4) -- Line: 333
    local lowerBounds = p1.lowerBounds
    local upperBounds = p1.upperBounds
    local v1 = if lowerBounds[1] <= p2 then if p2 <= upperBounds[1] then if lowerBounds[2] <= p3 then if p3 <= upperBounds[2] then if lowerBounds[3] <= p4 then p4 <= upperBounds[3] else false else false else false else false else false
    return v1
end
function u36.getSubRegionIndex(p1, p2, p3, p4) -- Line: 352
    local v1
    if p1.position[1] >= p2 then
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
    local v1 = math.floor(p2 / p1[1] + 0.5)
    local v2 = math.floor(p3 / p1[2] + 0.5)
    return v1, v2, (math.floor(p4 / p1[3] + 0.5))
end
function u36.getTopLevelRegionPosition(p1, p2, p3, p4) -- Line: 407
    return p1[1] * p2, p1[2] * p3, p1[3] * p4
end
function u36.areEqualTopRegions(p1, p2, p3, p4) -- Line: 423
    local position = p1.position
    local v1 = if position[1] == p2 then if position[2] == p3 then position[3] == p4 else false else false
    return v1
end
function u36.findRegion(p1, p2, p3, p4, p5) -- Line: 440 -- upvalues: u36 (val)
    local v1, v2, v3, v4, v5, v6
    v4, v5, v6 = u36.getTopLevelRegionCellIndex(p2, p3, p4, p5)
    local v7 = p1[u36.getTopLevelRegionHash(v4, v5, v6)]
    if not v7 then
        return nil
    end
    v1, v2, v3 = u36.getTopLevelRegionPosition(p2, v4, v5, v6)
    for k, v in pairs(v7) do
        if u36.areEqualTopRegions(v, v1, v2, v3) then
            return v
        end
    end
    return nil
end
function u36.getOrCreateRegion(p1, p2, p3, p4, p5) -- Line: 469 -- upvalues: u36 (val)
    local v1, v2, v3, v4, v5, v6
    v4, v5, v6 = u36.getTopLevelRegionCellIndex(p2, p3, p4, p5)
    local v7 = u36.getTopLevelRegionHash(v4, v5, v6)
    local v8 = p1[v7]
    if not v8 then
        p1[v7] = {}
    end
    v1, v2, v3 = u36.getTopLevelRegionPosition(p2, v4, v5, v6)
    for k, v in pairs(v8) do
        if u36.areEqualTopRegions(v, v1, v2, v3) then
            return v
        end
    end
    local v9 = u36.create(v1, v2, v3, p2[1], p2[2], p2[3])
    table.insert(v8, v9)
    return v9
end
return u36