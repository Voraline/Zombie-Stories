local u2 = require("./OctreeRegionUtil")
local u3 = {ClassName = "OctreeNode"}
u3.__index = u3
function u3.new(p1, p2) -- Line: 35 -- upvalues: u3 (val)
    local v1 = setmetatable({}, u3)
    local v2 = p1
    if not v2 then
        v2 = error("No octree")
    end
    v1._octree = v2
    v2 = p2
    if not v2 then
        v2 = error("No object")
    end
    v1._object = v2
    v1._currentLowestRegion = nil
    v1._position = nil
    return v1
end
function u3:KNearestNeighborsSearch(p2, p3) -- Line: 62
    return self._octree:KNearestNeighborsSearch(self._position, p2, p3)
end
function u3.GetObject(p1) -- Line: 77
    return p1._object
end
function u3:RadiusSearch(p2) -- Line: 88
    return self._octree:RadiusSearch(self._position, p2)
end
function u3.GetPosition(p1) -- Line: 97
    return p1._position
end
function u3.GetRawPosition(p1) -- Line: 108
    return p1._px, p1._py, p1._pz
end
function u3.SetPosition(p1, p2) -- Line: 126 -- upvalues: u2 (val)
    local OrCreateLowestSubRegion
    if p1._position == p2 then
        return
    end
    local x = p2.x
    local y = p2.y
    local z = p2.z
    p1._px = x
    p1._py = y
    p1._pz = z
    p1._position = p2
    if not p1._currentLowestRegion then
        OrCreateLowestSubRegion = p1._octree:GetOrCreateLowestSubRegion(x, y, z)
        if not p1._currentLowestRegion then
            u2.addNode(OrCreateLowestSubRegion, p1)
        else
            u2.moveNode(p1._currentLowestRegion, OrCreateLowestSubRegion, p1)
        end
        p1._currentLowestRegion = OrCreateLowestSubRegion
        return
    end
    if u2.inRegionBounds(p1._currentLowestRegion, x, y, z) then
        return
    end
    OrCreateLowestSubRegion = p1._octree:GetOrCreateLowestSubRegion(x, y, z)
    if not p1._currentLowestRegion then
        u2.addNode(OrCreateLowestSubRegion, p1)
    else
        u2.moveNode(p1._currentLowestRegion, OrCreateLowestSubRegion, p1)
    end
    p1._currentLowestRegion = OrCreateLowestSubRegion
end
function u3.Destroy(p1) -- Line: 163 -- upvalues: u2 (val)
    if p1._currentLowestRegion then
        u2.removeNode(p1._currentLowestRegion, p1)
    end
end
return u3