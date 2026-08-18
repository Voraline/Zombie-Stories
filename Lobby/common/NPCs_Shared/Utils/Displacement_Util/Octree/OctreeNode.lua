local v_u_1 = require("./OctreeRegionUtil")
local v_u_2 = {
	["ClassName"] = "OctreeNode"
}
v_u_2.__index = v_u_2
function v_u_2.new(p3, p4) -- name: new
	-- upvalues: (copy) v_u_2
	local v5 = v_u_2
	local v6 = setmetatable({}, v5)
	v6._octree = p3 or error("No octree")
	v6._object = p4 or error("No object")
	v6._currentLowestRegion = nil
	v6._position = nil
	return v6
end
function v_u_2.KNearestNeighborsSearch(p7, p8, p9) -- name: KNearestNeighborsSearch
	return p7._octree:KNearestNeighborsSearch(p7._position, p8, p9)
end
function v_u_2.GetObject(p10) -- name: GetObject
	return p10._object
end
function v_u_2.RadiusSearch(p11, p12) -- name: RadiusSearch
	return p11._octree:RadiusSearch(p11._position, p12)
end
function v_u_2.GetPosition(p13) -- name: GetPosition
	return p13._position
end
function v_u_2.GetRawPosition(p14) -- name: GetRawPosition
	return p14._px, p14._py, p14._pz
end
function v_u_2.SetPosition(p15, p16) -- name: SetPosition
	-- upvalues: (copy) v_u_1
	if p15._position == p16 then
		return
	else
		local v17 = p16.x
		local v18 = p16.y
		local v19 = p16.z
		p15._px = v17
		p15._py = v18
		p15._pz = v19
		p15._position = p16
		if not (p15._currentLowestRegion and v_u_1.inRegionBounds(p15._currentLowestRegion, v17, v18, v19)) then
			local v20 = p15._octree:GetOrCreateLowestSubRegion(v17, v18, v19)
			if p15._currentLowestRegion then
				v_u_1.moveNode(p15._currentLowestRegion, v20, p15)
			else
				v_u_1.addNode(v20, p15)
			end
			p15._currentLowestRegion = v20
		end
	end
end
function v_u_2.Destroy(p21) -- name: Destroy
	-- upvalues: (copy) v_u_1
	if p21._currentLowestRegion then
		v_u_1.removeNode(p21._currentLowestRegion, p21)
	end
end
return v_u_2