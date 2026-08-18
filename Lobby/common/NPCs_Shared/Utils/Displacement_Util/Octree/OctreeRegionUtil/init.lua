local v_u_1 = require("@self/Draw")
local v_u_2 = {
	{ 0.25, 0.25, -0.25 },
	{ -0.25, 0.25, -0.25 },
	{ 0.25, 0.25, 0.25 },
	{ -0.25, 0.25, 0.25 },
	{ 0.25, -0.25, -0.25 },
	{ -0.25, -0.25, -0.25 },
	{ 0.25, -0.25, 0.25 },
	{ -0.25, -0.25, 0.25 }
}
local v_u_154 = {
	["visualize"] = function(p3) -- name: visualize
		-- upvalues: (copy) v_u_1
		local v4 = p3.size
		local v5 = p3.position
		local v6 = v4[1]
		local v7 = v4[2]
		local v8 = v4[3]
		local v9 = v5[1]
		local v10 = v5[2]
		local v11 = v5[3]
		local v12 = v_u_1.box(Vector3.new(v9, v10, v11), (Vector3.new(v6, v7, v8)))
		v12.Transparency = 0.9
		local v13 = p3.depth
		v12.Name = "OctreeRegion_" .. tostring(v13)
		return v12
	end,
	["create"] = function(p14, p15, p16, p17, p18, p19, p20, p21) -- name: create
		local v22 = p17 / 2
		local v23 = p18 / 2
		local v24 = p19 / 2
		return {
			["subRegions"] = nil,
			["lowerBounds"] = nil,
			["upperBounds"] = nil,
			["position"] = nil,
			["size"] = nil,
			["parent"] = nil,
			["depth"] = nil,
			["parentIndex"] = nil,
			["nodes"] = nil,
			["node_count"] = 0,
			["subRegions"] = {},
			["lowerBounds"] = { p14 - v22, p15 - v23, p16 - v24 },
			["upperBounds"] = { p14 + v22, p15 + v23, p16 + v24 },
			["position"] = { p14, p15, p16 },
			["size"] = { p17, p18, p19 },
			["parent"] = p20,
			["depth"] = p20 and p20.depth + 1 or 1,
			["parentIndex"] = p21,
			["nodes"] = {}
		}
	end,
	["addNode"] = function(p25, p26) -- name: addNode
		assert(p26, "Bad node")
		while p25 do
			if not p25.nodes[p26] then
				p25.nodes[p26] = p26
				p25.node_count = p25.node_count + 1
			end
			p25 = p25.parent
		end
	end,
	["moveNode"] = function(p27, p28, p29) -- name: moveNode
		local v30 = p27.depth == p28.depth
		assert(v30, "fromLowest.depth ~= toLowest.depth")
		local v31 = p27 ~= p28
		assert(v31, "fromLowest == toLowest")
		while p27 ~= p28 do
			local v32 = p27.nodes[p29]
			assert(v32, "Not in currentFrom")
			local v33 = p27.node_count > 0
			assert(v33, "No nodes in currentFrom")
			p27.nodes[p29] = nil
			p27.node_count = p27.node_count - 1
			if p27.node_count <= 0 and p27.parentIndex then
				local v34 = p27.parent
				assert(v34, "Bad currentFrom.parent")
				local v35 = p27.parent.subRegions[p27.parentIndex] == p27
				assert(v35, "Not in subregion")
				p27.parent.subRegions[p27.parentIndex] = nil
			end
			local v36 = not p28.nodes[p29]
			assert(v36, "Failed to add")
			p28.nodes[p29] = p29
			p28.node_count = p28.node_count + 1
			p27 = p27.parent
			p28 = p28.parent
		end
	end,
	["removeNode"] = function(p37, p38) -- name: removeNode
		assert(p38, "Bad node")
		while p37 do
			local v39 = p37.nodes[p38]
			assert(v39, "Not in current")
			local v40 = p37.node_count > 0
			assert(v40, "Current has bad node count")
			p37.nodes[p38] = nil
			p37.node_count = p37.node_count - 1
			if p37.node_count <= 0 and p37.parentIndex then
				local v41 = p37.parent
				assert(v41, "No parent")
				local v42 = p37.parent.subRegions[p37.parentIndex] == p37
				assert(v42, "Not in subregion")
				p37.parent.subRegions[p37.parentIndex] = nil
			end
			p37 = p37.parent
		end
	end,
	["getSearchRadiusSquared"] = function(p43, p44, p45) -- name: getSearchRadiusSquared
		local v46 = p43 + 0.8660254037844386 * p44
		return v46 * v46 + p45
	end,
	["getNeighborsWithinRadius"] = function(p47, p48, p49, p50, p51, p52, p53, p54) -- name: getNeighborsWithinRadius
		-- upvalues: (copy) v_u_154
		assert(p54, "Bad maxDepth")
		local v55 = p47.size[1] / 2
		local v56 = v_u_154.getSearchRadiusSquared(p48, v55, 1e-6)
		local v57 = p48 * p48
		for _, v58 in pairs(p47.subRegions) do
			local v59 = v58.position
			local v60 = v59[1]
			local v61 = v59[2]
			local v62 = v59[3]
			local v63 = p49 - v60
			local v64 = p50 - v61
			local v65 = p51 - v62
			if v63 * v63 + v64 * v64 + v65 * v65 <= v56 then
				if v58.depth == p54 then
					for v66, _ in pairs(v58.nodes) do
						local v67, v68, v69 = v66:GetRawPosition()
						local v70 = p49 - v67
						local v71 = p50 - v68
						local v72 = p51 - v69
						local v73 = v70 * v70 + v71 * v71 + v72 * v72
						if v73 <= v57 then
							p52[#p52 + 1] = v66:GetObject()
							p53[#p53 + 1] = v73
						end
					end
				else
					v_u_154.getNeighborsWithinRadius(v58, p48, p49, p50, p51, p52, p53, p54)
				end
			end
		end
	end,
	["getOrCreateSubRegionAtDepth"] = function(p74, p75, p76, p77, p78) -- name: getOrCreateSubRegionAtDepth
		-- upvalues: (copy) v_u_154
		for _ = p74.depth, p78 do
			local v79 = v_u_154.getSubRegionIndex(p74, p75, p76, p77)
			local v80 = p74.subRegions[v79]
			if not v80 then
				v80 = v_u_154.createSubRegion(p74, v79)
				p74.subRegions[v79] = v80
			end
			p74 = v80
		end
		return p74
	end,
	["createSubRegion"] = function(p81, p82) -- name: createSubRegion
		-- upvalues: (copy) v_u_2, (copy) v_u_154
		local v83 = p81.size
		local v84 = p81.position
		local v85 = v_u_2[p82]
		local v86 = v84[1] + v85[1] * v83[1]
		local v87 = v84[2] + v85[2] * v83[2]
		local v88 = v84[3] + v85[3] * v83[3]
		local v89 = v83[1] / 2
		local v90 = v83[2] / 2
		local v91 = v83[3] / 2
		return v_u_154.create(v86, v87, v88, v89, v90, v91, p81, p82)
	end,
	["inRegionBounds"] = function(p92, p93, p94, p95) -- name: inRegionBounds
		local v96 = p92.lowerBounds
		local v97 = p92.upperBounds
		local v98
		if v96[1] <= p93 and (p93 <= v97[1] and (v96[2] <= p94 and (p94 <= v97[2] and v96[3] <= p95))) then
			v98 = p95 <= v97[3]
		else
			v98 = false
		end
		return v98
	end,
	["getSubRegionIndex"] = function(p99, p100, p101, p102) -- name: getSubRegionIndex
		local v103 = p99.position[1] < p100 and 1 or 2
		if p101 <= p99.position[2] then
			v103 = v103 + 4
		end
		if p99.position[3] <= p102 then
			v103 = v103 + 2
		end
		return v103
	end,
	["getTopLevelRegionHash"] = function(p104, p105, p106) -- name: getTopLevelRegionHash
		return p104 * 73856093 + p105 * 19351301 + p106 * 83492791
	end,
	["getTopLevelRegionCellIndex"] = function(p107, p108, p109, p110) -- name: getTopLevelRegionCellIndex
		local v111 = p108 / p107[1] + 0.5
		local v112 = math.floor(v111)
		local v113 = p109 / p107[2] + 0.5
		local v114 = math.floor(v113)
		local v115 = p110 / p107[3] + 0.5
		return v112, v114, math.floor(v115)
	end,
	["getTopLevelRegionPosition"] = function(p116, p117, p118, p119) -- name: getTopLevelRegionPosition
		return p116[1] * p117, p116[2] * p118, p116[3] * p119
	end,
	["areEqualTopRegions"] = function(p120, p121, p122, p123) -- name: areEqualTopRegions
		local v124 = p120.position
		local v125
		if v124[1] == p121 and v124[2] == p122 then
			v125 = v124[3] == p123
		else
			v125 = false
		end
		return v125
	end,
	["findRegion"] = function(p126, p127, p128, p129, p130) -- name: findRegion
		-- upvalues: (copy) v_u_154
		local v131, v132, v133 = v_u_154.getTopLevelRegionCellIndex(p127, p128, p129, p130)
		local v134 = p126[v_u_154.getTopLevelRegionHash(v131, v132, v133)]
		if not v134 then
			return nil
		end
		local v135, v136, v137 = v_u_154.getTopLevelRegionPosition(p127, v131, v132, v133)
		for _, v138 in pairs(v134) do
			if v_u_154.areEqualTopRegions(v138, v135, v136, v137) then
				return v138
			end
		end
		return nil
	end,
	["getOrCreateRegion"] = function(p139, p140, p141, p142, p143) -- name: getOrCreateRegion
		-- upvalues: (copy) v_u_154
		local v144, v145, v146 = v_u_154.getTopLevelRegionCellIndex(p140, p141, p142, p143)
		local v147 = v_u_154.getTopLevelRegionHash(v144, v145, v146)
		local v148 = p139[v147]
		if not v148 then
			v148 = {}
			p139[v147] = v148
		end
		local v149, v150, v151 = v_u_154.getTopLevelRegionPosition(p140, v144, v145, v146)
		for _, v152 in pairs(v148) do
			if v_u_154.areEqualTopRegions(v152, v149, v150, v151) then
				return v152
			end
		end
		local v153 = v_u_154.create(v149, v150, v151, p140[1], p140[2], p140[3])
		table.insert(v148, v153)
		return v153
	end
}
return v_u_154