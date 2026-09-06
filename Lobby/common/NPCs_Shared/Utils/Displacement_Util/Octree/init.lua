local u2 = require("@self/OctreeRegionUtil")
local u5 = require("@self/OctreeNode")
local u6 = {ClassName = "Octree"}
u6.__index = u6
function u6.new() -- Line: 57 -- upvalues: u6 (val)
    local v1 = setmetatable({}, u6)
    v1._maxRegionSize = {512, 512, 512}
    v1._maxDepth = 4
    v1._regionHashMap = {}
    return v1
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
    return p1:_radiusSearch(p2.x, p2.y, p2.z, p3)
end
function u6.KNearestNeighborsSearch(p1, p2, p3, p4) -- Line: 165
    local v1, v2, v3
    local v4 = typeof(p2) == "Vector3"
    assert(v4, "Bad position")
    v4 = type(p4) == "number"
    assert(v4, "Bad radius")
    v2, v3 = p1:_radiusSearch(p2.x, p2.y, p2.z, p4)
    local v5 = {}
    for k, v in pairs(v3) do
        table.insert(v5, {dist2 = v, index = k})
    end
    table.sort(v5, function(p1, p2) -- Line: 180
        local v1 = p1.dist2 < p2.dist2
        return v1
    end)
    local v6 = {}
    local v7 = {}
    local v8 = math.min(#v5, p3)
    local v9 = 1
    for i = 1, v8, v9 do
        v1 = v5[i]
        v7[#v7 + 1] = v1.dist2
        v6[#v6 + 1] = v2[v1.index]
    end
    return v6, v7
end
function u6.GetOrCreateLowestSubRegion(p1, p2, p3, p4) -- Line: 204 -- upvalues: u2 (val)
    local v1 = p1:_getOrCreateRegion(p2, p3, p4)
    return u2.getOrCreateSubRegionAtDepth(v1, p2, p3, p4, p1._maxDepth)
end
function u6:_radiusSearch(p2, p3, p4, p5) -- Line: 209 -- upvalues: u2 (val)
    local position, v1, v2, v3, v4
    local v5 = {}
    local v6 = {}
    local v7 = u2.getSearchRadiusSquared(p5, self._maxRegionSize[1], 1e-09)
    for k, v in pairs(self._regionHashMap) do
        for k2, i in pairs(v) do
            position = i.position
            v1 = v8 - position[1]
            v2 = v9 - position[2]
            v3 = v10 - position[3]
            v4 = v1 * v1 + v2 * v2
            if v4 + v3 * v3 <= v7 then
                u2.getNeighborsWithinRadius(i, v11, v8, v9, v10, v5, v6, v12._maxDepth)
            end
        end
    end
    return v5, v6
end
function u6._getRegion(p1, p2, p3, p4) -- Line: 233 -- upvalues: u2 (val)
    return u2.findRegion(p1._regionHashMap, p1._maxRegionSize, p2, p3, p4)
end
function u6:_getOrCreateRegion(p2, p3, p4) -- Line: 237 -- upvalues: u2 (val)
    return u2.getOrCreateRegion(self._regionHashMap, self._maxRegionSize, p2, p3, p4)
end
return u6