local v_u_1 = require("@self/OctreeRegionUtil")
local v_u_2 = require("@self/OctreeNode")
local v_u_3 = {
	["ClassName"] = "Octree"
}
v_u_3.__index = v_u_3
function v_u_3.new() -- name: new
	-- upvalues: (copy) v_u_3
	local v4 = v_u_3
	local v5 = setmetatable({}, v4)
	v5._maxRegionSize = { 512, 512, 512 }
	v5._maxDepth = 4
	v5._regionHashMap = {}
	return v5
end
function v_u_3.GetAllNodes(p6) -- name: GetAllNodes
	local v7 = {}
	for _, v8 in pairs(p6._regionHashMap) do
		for _, v9 in pairs(v8) do
			for v10, _ in pairs(v9.nodes) do
				v7[#v7 + 1] = v10
			end
		end
	end
	return v7
end
function v_u_3.CreateNode(p11, p12, p13) -- name: CreateNode
	-- upvalues: (copy) v_u_2
	local v14 = typeof(p12) == "Vector3"
	assert(v14, "Bad position value")
	assert(p13, "Bad object value")
	local v15 = v_u_2.new(p11, p13)
	v15:SetPosition(p12)
	return v15
end
function v_u_3.RadiusSearch(p16, p17, p18) -- name: RadiusSearch
	local v19 = typeof(p17) == "Vector3"
	assert(v19, "Bad position")
	local v20 = type(p18) == "number"
	assert(v20, "Bad radius")
	return p16:_radiusSearch(p17.x, p17.y, p17.z, p18)
end
function v_u_3.KNearestNeighborsSearch(p21, p22, p23, p24) -- name: KNearestNeighborsSearch
	local v25 = typeof(p22) == "Vector3"
	assert(v25, "Bad position")
	local v26 = type(p24) == "number"
	assert(v26, "Bad radius")
	local v27, v28 = p21:_radiusSearch(p22.x, p22.y, p22.z, p24)
	local v29 = {}
	for v30, v31 in pairs(v28) do
		table.insert(v29, {
			["dist2"] = v31,
			["index"] = v30
		})
	end
	table.sort(v29, function(p32, p33)
		return p32.dist2 < p33.dist2
	end)
	local v34 = #v29
	local v35 = {}
	local v36 = {}
	for v37 = 1, math.min(v34, p23) do
		local v38 = v29[v37]
		v35[#v35 + 1] = v38.dist2
		v36[#v36 + 1] = v27[v38.index]
	end
	return v36, v35
end
function v_u_3.GetOrCreateLowestSubRegion(p39, p40, p41, p42) -- name: GetOrCreateLowestSubRegion
	-- upvalues: (copy) v_u_1
	local v43 = p39:_getOrCreateRegion(p40, p41, p42)
	return v_u_1.getOrCreateSubRegionAtDepth(v43, p40, p41, p42, p39._maxDepth)
end
function v_u_3._radiusSearch(p44, p45, p46, p47, p48) -- name: _radiusSearch
	-- upvalues: (copy) v_u_1
	local v49 = p44._maxRegionSize[1]
	local v50 = v_u_1.getSearchRadiusSquared(p48, v49, 1e-9)
	local v51 = {}
	local v52 = {}
	for _, v53 in pairs(p44._regionHashMap) do
		for _, v54 in pairs(v53) do
			local v55 = v54.position
			local v56 = v55[1]
			local v57 = v55[2]
			local v58 = v55[3]
			local v59 = p45 - v56
			local v60 = p46 - v57
			local v61 = p47 - v58
			if v59 * v59 + v60 * v60 + v61 * v61 <= v50 then
				v_u_1.getNeighborsWithinRadius(v54, p48, p45, p46, p47, v51, v52, p44._maxDepth)
			end
		end
	end
	return v51, v52
end
function v_u_3._getRegion(p62, p63, p64, p65) -- name: _getRegion
	-- upvalues: (copy) v_u_1
	return v_u_1.findRegion(p62._regionHashMap, p62._maxRegionSize, p63, p64, p65)
end
function v_u_3._getOrCreateRegion(p66, p67, p68, p69) -- name: _getOrCreateRegion
	-- upvalues: (copy) v_u_1
	return v_u_1.getOrCreateRegion(p66._regionHashMap, p66._maxRegionSize, p67, p68, p69)
end
return v_u_3