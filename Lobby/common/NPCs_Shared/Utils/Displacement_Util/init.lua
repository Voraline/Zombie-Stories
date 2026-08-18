local v_u_1 = require(script:WaitForChild("Octree")).new()
local v2 = -32768
local v_u_3 = {}
local v4 = game:GetService("ReplicatedStorage")
local v5 = not (v4:FindFirstChild("chapter") and v4.chapter:FindFirstChild("NPCs_WalkableSpace")) and v4:FindFirstChild("arc")
if v5 then
	v5 = v4.arc:FindFirstChild("NPCs_WalkableSpace")
end
local v6 = v5:GetChildren()
table.sort(v6, function(p7, p8)
	return p7.Name < p8.Name
end)
for _, v9 in v6 do
	if v9:IsA("BasePart") then
		local v10 = -v9.Size / 2
		local v11 = v9.Size / 2
		for v12 = v10.X, v11.X, 326 do
			for v13 = v10.Y, v11.Y, 326 do
				for v14 = v10.Z, v11.Z, 326 do
					local v15 = Vector3.new(v12, v13, v14)
					local v16 = v2 + 1
					local v17 = v9.CFrame:PointToWorldSpace(v15)
					local v18 = v16
					v_u_1:CreateNode(v17, (tostring(v18)))
					local v19 = v16
					v_u_3[tostring(v19)] = v17
					v2 = v16
				end
			end
		end
	end
end
if v2 > 32767 then
	error("too many uids")
end
local v20 = {}
for _ = 1, 50 do
	v2 = v2 + 1
	local v21 = tostring(v2)
	table.insert(v20, v21)
end
local v_u_22 = {}
if game:GetService("RunService"):IsServer() then
	for _, _ in game.Players:GetPlayers() do

	end
end
return {
	["GetClosestNode"] = function(_, p23) -- name: GetClosestNode
		-- upvalues: (copy) v_u_1, (copy) v_u_3
		local v24 = v_u_1:KNearestNeighborsSearch(p23, 1, 326)
		if v24 and v24[1] then
			local v25 = v_u_3[v24[1]] - p23
			return v24[1], v25
		end
	end,
	["GetPlayerDisplacement"] = function(_, p26, p27) -- name: GetPlayerDisplacement
		-- upvalues: (copy) v_u_22
		if p26 then
			local v28 = v_u_22[p26.Name]
			if v28 then
				if p26.Character and (p26.Character.Parent and p26.Character.PrimaryPart) then
					return p26.Character.PrimaryPart.Position - p27, v28
				else
					return Vector3.new(0, 0, 0)
				end
			else
				return Vector3.new(0, 0, 0)
			end
		else
			return Vector3.new(0, 0, 0)
		end
	end,
	["GetNodePos"] = function(_, p29) -- name: GetNodePos
		-- upvalues: (copy) v_u_3
		if v_u_3[tostring(p29)] == nil then
			return nil
		else
			local v30 = v_u_3[tostring(p29)]
			if typeof(v30) == "Vector3" then
				return v_u_3[tostring(p29)]
			else
				return v_u_3[tostring(p29)].Character.PrimaryPart.Position, v_u_3[tostring(p29)].Character.PrimaryPart
			end
		end
	end
}