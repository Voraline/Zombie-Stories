local v_u_1 = require("../Controllers/LocalPlayerController")
local v2 = script:WaitForChild("Resources")
local v_u_3 = {
	[Enum.Material.Concrete] = "Concrete",
	[Enum.Material.Grass] = "Grass",
	[Enum.Material.Sand] = "Grass",
	[Enum.Material.Ice] = "Grass",
	[Enum.Material.LeafyGrass] = "Grass",
	[Enum.Material.Snow] = "Grass",
	[Enum.Material.Glacier] = "Grass",
	[Enum.Material.Mud] = "Dirt",
	[Enum.Material.Fabric] = "Dirt",
	[Enum.Material.Ground] = "Dirt",
	[Enum.Material.Wood] = "Wood",
	[Enum.Material.WoodPlanks] = "Wood",
	[Enum.Material.Pebble] = "Gravel",
	[Enum.Material.Metal] = "Metal",
	[Enum.Material.CorrodedMetal] = "Metal",
	[Enum.Material.DiamondPlate] = "Metal",
	[Enum.Material.Foil] = "Metal"
}
local v_u_4 = {
	[Enum.Material.Concrete] = {
		{ 27.499095938007, 28.191199290016 },
		{ 28.191199290016, 28.841360940965 },
		{ 28.841360940965, 29.459017269974 },
		{ 29.459017269974, 30.10904514397 },
		{ 30.10904514397, 30.759077816937 }
	},
	[Enum.Material.Ground] = {
		{ 52.089024086044, 52.865063716015 },
		{ 52.865063716015, 53.59772350804 },
		{ 53.59772350804, 54.349850330061 },
		{ 54.349850330061, 55.049090898034 },
		{ 55.049090898034, 55.765139073025 }
	},
	[Enum.Material.Grass] = {
		{ 69.490977494005, 70.18383049398 },
		{ 70.18383049398, 70.883929414011 },
		{ 70.883929414011, 71.634821655975 },
		{ 71.634821655975, 72.300559200943 },
		{ 72.300559200943, 73.001347635015 },
		{ 73.001347635015, 73.833708473982 }
	},
	[Enum.Material.Pebble] = {
		{ 93.751799195995, 94.861757991969 },
		{ 94.861757991969, 96.01217642598 },
		{ 96.01217642598, 96.895755909973 }
	}
}
local v_u_5 = {
	[Enum.Material.SmoothPlastic] = {
		{ 17.587918779957, 18.247896654019 },
		{ 18.247896654019, 18.863809216006 },
		{ 18.863809216006, 19.463111553951 },
		{ 19.463111553951, 20.064853589997 },
		{ 20.064853589997, 20.714110644009 },
		{ 20.714110644009, 21.347603467945 },
		{ 21.347603467945, 21.979916113962 }
	},
	[Enum.Material.Plastic] = {
		{ 17.587918779957, 18.247896654019 },
		{ 18.247896654019, 18.863809216006 },
		{ 18.863809216006, 19.463111553951 },
		{ 19.463111553951, 20.064853589997 },
		{ 20.064853589997, 20.714110644009 },
		{ 20.714110644009, 21.347603467945 },
		{ 21.347603467945, 21.979916113962 }
	},
	[Enum.Material.Metal] = {
		{ 37.680434650031, 38.475547555016 },
		{ 38.475547555016, 39.257744491053 },
		{ 39.257744491053, 40.092227406016 },
		{ 40.092227406016, 40.923779830011 }
	}
}
v_u_5[Enum.Material.Marble] = v_u_5[Enum.Material.SmoothPlastic]
v_u_5[Enum.Material.Ice] = v_u_5[Enum.Material.Sand]
v_u_5[Enum.Material.Snow] = v_u_5[Enum.Material.Sand]
v_u_5[Enum.Material.Glacier] = v_u_5[Enum.Material.Sand]
v_u_5[Enum.Material.Foil] = v_u_5[Enum.Material.Metal]
v_u_4[Enum.Material.Brick] = v_u_4[Enum.Material.Concrete]
v_u_5[Enum.Material.CorrodedMetal] = v_u_5[Enum.Material.Metal]
v_u_4[Enum.Material.Wood] = v_u_4[Enum.Material.WoodPlanks]
v_u_5[Enum.Material.DiamondPlate] = v_u_5[Enum.Material.Metal]
v_u_4[Enum.Material.Cobblestone] = v_u_4[Enum.Material.Concrete]
v_u_4[Enum.Material.Slate] = v_u_4[Enum.Material.Concrete]
v_u_4[Enum.Material.Granite] = v_u_4[Enum.Material.Concrete]
v_u_5[Enum.Material.Neon] = v_u_5[Enum.Material.Metal]
v_u_5[Enum.Material.Glass] = v_u_5[Enum.Material.Metal]
v_u_5[Enum.Material.LeafyGrass] = v_u_4[Enum.Material.Grass]
v_u_5[Enum.Material.Mud] = v_u_4[Enum.Material.Grass]
local v_u_6 = {}
for _, v7 in v2:GetChildren() do
	v_u_6[v7.Name] = { v7:WaitForChild("Walk"):GetChildren(), v7:FindFirstChild("Run") and v7.Run:GetChildren() or nil }
end
local v_u_8 = v_u_1.humanoid
local v_u_9 = nil
local v_u_10 = -1
local function v_u_27(p11, p12, p13, p14) -- name: FootstepPlayer
	-- upvalues: (copy) v_u_8, (copy) v_u_1, (copy) v_u_3, (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (ref) v_u_10, (ref) v_u_9
	if v_u_8.Humanoid then
		local v15 = p12 or v_u_8.Humanoid.FloorMaterial
		if not v_u_1.States.IsDead and v15 ~= Enum.Material.Air or p11 == true then
			if p11 and (p13 and v15 == Enum.Material.Air) then
				repeat
					task.wait()
					v15 = v_u_8.Humanoid.FloorMaterial
				until v15 ~= Enum.Material.Air
			end
			local v16 = v_u_8.WaterSensor
			local v17 = v16 and v16.TouchingSurface and "Water" or (v_u_3[v15] or "Concrete")
			local v18 = v_u_6[v17][1]
			if v_u_8.Humanoid.WalkSpeed > 16 and v_u_6[v17][2] then
				v18 = v_u_6[v17][2]
			end
			local v19 = false
			if p14 then
				local v20 = v_u_4[v15]
				if v20 then
					v19 = script.Footsteps1
				else
					v20 = v_u_5[v15]
					if v20 then
						v19 = script.Footsteps2
					end
				end
				v18 = v20 or v18
			end
			if v18 and v_u_8.Humanoid.MoveDirection.Magnitude > 0 or v18 and p11 then
				if v19 then
					local v21 = math.random(1, #v18)
					local v22 = v19:Clone()
					v22.Name = "Yeet"
					v22.Volume = 0.4
					v22.Parent = v_u_8.Humanoid.Parent.HumanoidRootPart
					v22.PlaybackSpeed = v22.PlaybackSpeed + math.random(3, 7) * 0.02 * v_u_10
					v_u_10 = v_u_10 * -1
					v22:Play()
					local v23 = v18[v21][1] - 0.076918916
					v22.TimePosition = math.max(v23, 0)
					game.Debris:AddItem(v22, v18[v21][2] - v18[v21][1] - 0.09)
					v_u_9 = v22
					return
				end
				local v24 = v18[math.random(1, #v18)]:Clone()
				v24.Name = "Yeet"
				v24.Volume = 0.4
				v24.Parent = v_u_8.Humanoid.Parent.HumanoidRootPart
				v24.PlaybackSpeed = v24.PlaybackSpeed + math.random(3, 7) * 0.02 * v_u_10
				v_u_10 = v_u_10 * -1
				v24:Play()
				game.Debris:AddItem(v24, 3)
				v_u_9 = v24
				local v25 = v_u_6.Cloth[1]
				local v26 = v25[math.random(1, #v25)]:Clone()
				v26.Name = "Yeet"
				v26.Volume = 0.4
				v26.Parent = v_u_8.Humanoid.Parent.HumanoidRootPart
				v26.PlaybackSpeed = v26.PlaybackSpeed + math.random(3, 7) * 0.02 * v_u_10
				v26:Play()
				game.Debris:AddItem(v26, 3)
			end
		end
	end
end
v_u_1.PlayerMovementUtil.ShuffleEvent:Connect(function()
	-- upvalues: (copy) v_u_27
	v_u_27(true, nil, nil, true)
end)
v_u_8.Jumped:Connect(function()
	-- upvalues: (copy) v_u_8, (ref) v_u_9, (copy) v_u_27
	if v_u_8.HasLanded == true then
		if v_u_9 then
			v_u_9:Stop()
		end
		v_u_27(true, nil, nil, true)
	end
end)
v_u_8.Landed:Connect(function()
	-- upvalues: (copy) v_u_27
	v_u_27(true, nil, true)
end)
return v_u_27