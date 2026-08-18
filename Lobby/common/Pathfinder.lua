local v_u_1 = game:GetService("PathfindingService")
local v_u_2 = {
	["NodesAreSetup"] = false
}
local v_u_3 = nil
function BuildNodes(p4) -- name: BuildNodes
	-- upvalues: (ref) v_u_3, (copy) v_u_2
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
	v_u_3 = v5
	v_u_2.NodesAreSetup = true
end
function v_u_2.FindNearestNode(_, p17, p18, p19) -- name: FindNearestNode
	-- upvalues: (ref) v_u_3
	local v20 = p19 or 1
	local v21 = (1 / 0)
	local v22 = nil
	for _, v23 in ipairs(v_u_3) do
		if p18 == nil or not p18[v23] then
			local v24 = ((p17 - v23.Position) * Vector3.new(1, v20, 1)).Magnitude
			if v24 < v21 then
				v22 = v23
				v21 = v24
			end
		end
	end
	return v22
end
function v_u_2.UseRoblox(_, p_u_25, p_u_26) -- name: UseRoblox
	-- upvalues: (copy) v_u_1
	local v_u_27 = v_u_1:CreatePath({
		["AgentRadius"] = 1,
		["AgentHeight"] = 5,
		["AgentCanJump"] = true,
		["AgentCanClimb"] = true,
		["WaypointSpacing"] = 4
	})
	local v28, _ = pcall(function()
		-- upvalues: (copy) v_u_27, (copy) p_u_25, (copy) p_u_26
		v_u_27:ComputeAsync(p_u_25, p_u_26)
	end)
	if not v28 or v_u_27.Status ~= Enum.PathStatus.Success then
		return nil
	end
	local v29 = {}
	for _, v30 in v_u_27:GetWaypoints() do
		local v31 = v30.Position
		table.insert(v29, v31)
	end
	return v29
end
function v_u_2.FindPath(_, p32, p33, p34, p35) -- name: FindPath
	-- upvalues: (copy) v_u_2
	local v36 = p34 or v_u_2:FindNearestNode(p32, nil, 1.15)
	local v37 = p35 or v_u_2:FindNearestNode(p33, nil, 1.25)
	local v38 = {
		[v36] = true
	}
	local v39 = {}
	local v40 = false
	local v41 = {}
	while next(v38) do
		local v42 = (1 / 0)
		local v43 = nil
		for v44 in pairs(v38) do
			if v44.F < v42 then
				v42 = v44.F
				v43 = v44
			end
		end
		v38[v43] = nil
		v39[v43] = true
		if v43 == v37 then
			v40 = true
			break
		end
		for _, v45 in ipairs(v43.Neighbors) do
			if not v39[v45] then
				if v38[v45] then
					if v45.G < v43.G then
						v45.Parent = v43
						v45.G = v43.G + (v45.Position - v43.Position).Magnitude
						v45.F = v45.G + v45.H
					end
				else
					v38[v45] = true
					v45.Parent = v43
					v45.G = v43.G + (v45.Position - v43.Position).Magnitude
					local v46 = v45.Position
					local v47 = v37.Position
					local v48 = (v46 - v47).Magnitude
					if v48 < 5 then
						v48 = ((v46 - v47) * Vector3.new(1, 1.25, 1)).Magnitude
					end
					v45.H = v48
					v45.F = v45.G + v45.H
				end
			end
		end
	end
	local v49 = {}
	if v40 then
		while v37 do
			local v50 = v37.Position
			table.insert(v41, 1, v50)
			table.insert(v49, 1, v37)
			v37 = v37.Parent
		end
	end
	for v51 in pairs(v38) do
		v51.F = 0
		v51.G = 0
		v51.H = 0
		v51.Parent = nil
	end
	for v52 in pairs(v39) do
		v52.F = 0
		v52.G = 0
		v52.H = 0
		v52.Parent = nil
	end
	if v40 == nil then
		return nil
	else
		return v41, v49
	end
end
function v_u_2.Init(_, p53) -- name: Init
	BuildNodes(p53)
end
return v_u_2