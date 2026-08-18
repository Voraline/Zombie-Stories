local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.__tostring(p2) -- name: __tostring
	local v3 = "\n"
	for v4 = 1, p2.length do
		if v4 == 1 then
			v3 = v3 .. "\n"
		end
		local v5 = ""
		for v6 = 1, p2.width do
			if v6 == p2.width then
				v5 = v5 .. ("%*"):format(p2.matrix[v4][v6])
			else
				v5 = v5 .. ("%*, "):format(p2.matrix[v4][v6])
			end
		end
		v3 = v3 .. v5 .. "\n"
	end
	return v3
end
function v_u_1.extend(p7) -- name: extend
	p7.length = p7.length + 1
	p7.width = p7.length + 1
	p7.matrix[p7.length] = {}
	for v8 = 1, p7.width do
		p7.matrix[p7.length][v8] = 0
	end
	for v9 = 1, p7.length do
		p7.matrix[v9][p7.width] = 0
	end
end
function v_u_1.setEdge(p10, p11, p12, p13) -- name: setEdge
	p10.matrix[p11][p12] = p13
end
function v_u_1.toAdjacencyList(p14) -- name: toAdjacencyList
	local v15 = {}
	for v16 = 1, p14.length do
		v15[v16] = {}
		for v17 = 1, p14.width do
			if p14.matrix[v16][v17] ~= 0 then
				local v18 = v15[v16]
				table.insert(v18, v17)
			end
		end
	end
	return v15
end
function v_u_1.topologicalSort(p19) -- name: topologicalSort
	local v20 = p19:toAdjacencyList()
	local v21 = table.create(p19.length, 0)
	local v22 = {}
	for v23 = 1, p19.length do
		for _, v24 in v20[v23] do
			v21[v24] = v21[v24] + 1
		end
	end
	local v25 = {}
	for v26 = 1, p19.length do
		if v21[v26] == 0 then
			table.insert(v25, v26)
		end
	end
	while #v25 ~= 0 do
		local v27 = table.remove(v25, 1)
		table.insert(v22, v27)
		for _, v28 in v20[v27] do
			v21[v28] = v21[v28] - 1
			if v21[v28] == 0 then
				table.insert(v25, v28)
			end
		end
	end
	if #v22 == p19.length then
		return v22
	else
		return nil
	end
end
function v_u_1.new() -- name: new
	-- upvalues: (copy) v_u_1
	local v29 = v_u_1
	return setmetatable({
		["matrix"] = nil,
		["length"] = 0,
		["width"] = 0,
		["matrix"] = {}
	}, v29)
end
local v_u_30 = {}
v_u_30.__index = v_u_30
function v_u_30.getOrderedList(p31) -- name: getOrderedList
	local v32 = {}
	local v33 = p31.matrix:topologicalSort()
	if not v33 then
		return nil
	end
	for _, v34 in v33 do
		local v35 = p31.nodes[v34]
		table.insert(v32, v35)
	end
	return v32
end
function v_u_30.insertBefore(p36, p37, p38) -- name: insertBefore
	if not table.find(p36.nodes, p38) then
		error("Node not found in DependencyGraph:insertBefore(_, unknown)")
	end
	local v39 = table.find(p36.nodes, p37)
	if not v39 then
		local v40 = p36.nodes
		table.insert(v40, p37)
		v39 = #p36.nodes
	end
	local v41 = table.find(p36.nodes, p38)
	p36.matrix:extend()
	p36.matrix:setEdge(v39, v41, 1)
	return p36
end
function v_u_30.insertAfter(p42, p43, p44) -- name: insertAfter
	if not table.find(p42.nodes, p44) then
		error("Node not found in DependencyGraph:insertAfter(_, unknown)")
	end
	local v45 = table.find(p42.nodes, p43)
	if not v45 then
		local v46 = p42.nodes
		table.insert(v46, p43)
		v45 = #p42.nodes
	end
	local v47 = table.find(p42.nodes, p44)
	p42.matrix:extend()
	p42.matrix:setEdge(v47, v45, 1)
	return p42
end
function v_u_30.insert(p48, p49) -- name: insert
	local v50 = #p48.nodes
	local v51 = p48.nodes
	table.insert(v51, p49)
	local v52 = #p48.nodes
	p48.matrix:extend()
	if v50 ~= 0 then
		p48.matrix:setEdge(v50, v52, 1)
	end
	return p48
end
function v_u_30.new() -- name: new
	-- upvalues: (copy) v_u_1, (copy) v_u_30
	local v53 = {
		["nodes"] = nil,
		["matrix"] = nil,
		["length"] = 0,
		["width"] = 0,
		["nodes"] = {},
		["matrix"] = v_u_1.new()
	}
	local v54 = v_u_30
	return setmetatable(v53, v54)
end
return v_u_30