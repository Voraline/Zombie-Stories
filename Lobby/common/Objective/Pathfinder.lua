local v_u_1 = {}
local v_u_2 = nil
local v_u_3 = nil
function BuildNodes(p4) -- name: BuildNodes
	-- upvalues: (ref) v_u_3, (ref) v_u_2
	if v_u_3 ~= p4 then
		v_u_3 = p4
		local v5 = {}
		local v6 = {}
		for _, v7 in ipairs(p4:GetChildren()) do
			if v7:IsA("Folder") then
				local v8 = {
					["Position"] = nil,
					["Neighbors"] = nil,
					["F"] = 0,
					["G"] = 0,
					["H"] = 0,
					["Parent"] = nil,
					["Position"] = v7:GetAttribute("NodePosition"),
					["Neighbors"] = {}
				}
				table.insert(v5, v8)
				v6[v7:GetAttribute("NodeId")] = v8
			end
		end
		for _, v9 in ipairs(p4:GetChildren()) do
			if v9:IsA("Folder") then
				local v10 = v9:GetAttribute("NodeLinks"):split(",")
				local v11 = v6[v9:GetAttribute("NodeId")]
				for _, v12 in ipairs(v10) do
					local v13 = v6[v12]
					local v14 = v12 ~= ""
					assert(v14, ("Node \'%s\' has no neighbors"):format(v9:GetAttribute("NodeId")))
					local v15 = v11.Neighbors
					table.insert(v15, v13)
					local v16 = v13.Neighbors
					table.insert(v16, v11)
				end
			end
		end
		v_u_2 = v5
	end
end
function v_u_1.FindNearestNode(_, p17, p18) -- name: FindNearestNode
	-- upvalues: (ref) v_u_2
	local v19 = (1 / 0)
	local v20 = nil
	for _, v21 in ipairs(v_u_2) do
		if p18 == nil or not p18[v21] then
			local v22 = (p17 - v21.Position).Magnitude
			if v22 < v19 then
				v20 = v21
				v19 = v22
			end
		end
	end
	return v20
end
function v_u_1.FindPath(_, p23, p24, p25, p26) -- name: FindPath
	-- upvalues: (copy) v_u_1
	local v27 = p25 or v_u_1:FindNearestNode(p23)
	local v28 = p26 or v_u_1:FindNearestNode(p24)
	local v29 = {
		[v27] = true
	}
	local v30 = {}
	local v31 = false
	local v32 = {}
	while next(v29) do
		local v33 = (1 / 0)
		local v34 = nil
		for v35 in pairs(v29) do
			if v35.F < v33 then
				v33 = v35.F
				v34 = v35
			end
		end
		v29[v34] = nil
		v30[v34] = true
		if v34 == v28 then
			v31 = true
			break
		end
		for _, v36 in ipairs(v34.Neighbors) do
			if not v30[v36] then
				if v29[v36] then
					if v36.G < v34.G then
						v36.Parent = v34
						v36.G = v34.G + (v36.Position - v34.Position).Magnitude
						v36.F = v36.G + v36.H
					end
				else
					v29[v36] = true
					v36.Parent = v34
					v36.G = v34.G + (v36.Position - v34.Position).Magnitude
					v36.H = (v36.Position - v28.Position).Magnitude
					v36.F = v36.G + v36.H
				end
			end
		end
	end
	local v37 = {}
	if v31 then
		while v28 do
			local v38 = v28.Position
			table.insert(v32, 1, v38)
			table.insert(v37, 1, v28)
			v28 = v28.Parent
		end
	end
	for v39 in pairs(v29) do
		v39.F = 0
		v39.G = 0
		v39.H = 0
		v39.Parent = nil
	end
	for v40 in pairs(v30) do
		v40.F = 0
		v40.G = 0
		v40.H = 0
		v40.Parent = nil
	end
	if v31 == nil then
		return nil
	else
		return v32, v37
	end
end
function v_u_1.Init(_, p41, _) -- name: Init
	BuildNodes(p41)
end
return v_u_1