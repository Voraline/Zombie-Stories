local u2 = require("@self/OctreeRegionUtil")
local u5 = require("@self/OctreeNode")
local u6 = {ClassName = "Octree"}
u6.__index = u6

function u6.new() -- Line: 57 -- upvalues: u6 (val)
    local v1 = u6
    local v2 = setmetatable({}, v1)
    v2._maxRegionSize = {512, 512, 512}
    v2._maxDepth = 4
    v2._regionHashMap = {}
    return v2
end

function u6.GetAllNodes(p1) -- Line: 85
    local v1 = {}
    for k, v in pairs(p1._regionHashMap) do
        for k2, i in pairs(v) do
            for k3, j in pairs(i.nodes) do
                v1[#v1 + 1] = k3
            end
        end
    end
    return v1
end

function u6.CreateNode(p1, p2, p3) -- Line: 117 -- upvalues: u5 (val)
    local v1 = typeof(p2) == "Vector3"
    assert(v1, "Bad position value")
    assert(p3, "Bad object value")
    local v2 = u5.new(p1, p3)
    v2:SetPosition(p2)
    return v2
end

function u6.RadiusSearch(p1, p2, p3) -- Line: 145
    local v1 = typeof(p2) == "Vector3"
    assert(v1, "Bad position")
    v1 = type(p3) == "number"
    assert(v1, "Bad radius")
    local x = p2.x
    local y = p2.y
    local z = p2.z
    return p1:_radiusSearch(x, y, z, p3)
end

function u6.KNearestNeighborsSearch(p1, p2, p3, p4) -- Line: 165
    local v1, v2
    local v3 = typeof(p2) == "Vector3"
    assert(v3, "Bad position")
    v3 = type(p4) == "number"
    assert(v3, "Bad radius")
    local x = p2.x
    local y = p2.y
    local z = p2.z
    local v4, v5 = p1:_radiusSearch(x, y, z, p4)
    local v6 = {}
    for k, v in pairs(v5) do
        v2 = {dist2 = v, index = k}
        table.insert(v6, v2)
    end
    table.sort(v6, function(p1, p2) -- Line: 180
        local v1 = p1.dist2 < p2.dist2
        return v1
    end)
    local v7 = {}
    local v8 = {}
    local v9 = #v6
    local v10 = math.min(v9, p3)
    for i = 1, v10 do
        v1 = v6[i]
        v9 = #v8 + 1
        v8[v9] = v1.dist2
        v9 = #v7 + 1
        v7[v9] = v4[v1.index]
    end
    return v7, v8
end

function u6.GetOrCreateLowestSubRegion(p1, p2, p3, p4) -- Line: 204 -- upvalues: u2 (val)
    local v1 = p1:_getOrCreateRegion(p2, p3, p4)
    return u2.getOrCreateSubRegionAtDepth(v1, p2, p3, p4, p1._maxDepth)
end

function u6:_radiusSearch(p2, p3, p4, p5) -- Line: 209 -- upvalues: u2 (val)
    local position, v1, v2, v3, v4, v5, v6
    local v7 = {}
    local v8 = {}
    local v9 = self._maxRegionSize[1]
    local v10 = u2.getSearchRadiusSquared(p5, v9, 1e-09)
    for k, v in pairs(self._regionHashMap) do
        for k2, i in pairs(v) do
            position = i.position
            v1 = position[1]
            v2 = position[2]
            v3 = position[3]
            v4 = v11 - v1
            v5 = v12 - v2
            v6 = v13 - v3
            if v4 * v4 + v5 * v5 + v6 * v6 <= v10 then
                u2.getNeighborsWithinRadius(i, v14, v11, v12, v13, v7, v8, v15._maxDepth)
            end
        end
    end
    return v7, v8
end

function u6._getRegion(p1, p2, p3, p4) -- Line: 233 -- upvalues: u2 (val)
    return u2.findRegion(p1._regionHashMap, p1._maxRegionSize, p2, p3, p4)
end

function u6:_getOrCreateRegion(p2, p3, p4) -- Line: 237 -- upvalues: u2 (val)
    return u2.getOrCreateRegion(self._regionHashMap, self._maxRegionSize, p2, p3, p4)
end

return u6