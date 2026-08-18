local v_u_1 = game:GetService("RunService")
local v2 = require("./SkillTreeCamera")
local v3, v4, v5, v6 = v2.getBounds()
local v_u_7 = v2.getTreeOrigin()
local v_u_8 = v4 - v3 + 100
local v_u_9 = v6 - v5 + 100
local v_u_10 = (v4 + v3) / 2
local v_u_11 = (v6 + v5) / 2
local v_u_12 = Color3.fromRGB(37, 161, 255)
local v_u_13 = {}
v_u_13.__index = v_u_13
function v_u_13.new() -- name: new
	-- upvalues: (copy) v_u_13, (copy) v_u_10, (copy) v_u_7, (copy) v_u_11, (copy) v_u_8, (copy) v_u_9, (copy) v_u_12
	local v14 = v_u_13
	local v15 = setmetatable({}, v14)
	v15.circleBin = {}
	v15.circleData = {}
	v15.lineList = {}
	v15.connections = {}
	v15.running = false
	v15.grid = {}
	for v16 = -5, 40 do
		v15.grid[v16] = {}
		for v17 = -5, 40 do
			v15.grid[v16][v17] = {}
		end
	end
	v15.backgroundPart = Instance.new("Part")
	v15.backgroundPart.Name = "BackgroundPlaceholder"
	v15.backgroundPart.Anchored = true
	v15.backgroundPart.BottomSurface = Enum.SurfaceType.Smooth
	v15.backgroundPart.TopSurface = Enum.SurfaceType.Smooth
	v15.backgroundPart.CFrame = CFrame.new(v_u_10, v_u_7.Y - 35, v_u_11)
	v15.backgroundPart.CastShadow = false
	v15.backgroundPart.Color = Color3.fromRGB(63, 75, 86)
	v15.backgroundPart.Locked = true
	v15.backgroundPart.Material = Enum.Material.Neon
	local v18 = v_u_8
	local v19 = v_u_9
	v15.backgroundPart.Size = Vector3.new(v18, 48, v19)
	v15.surfaceGui = Instance.new("SurfaceGui")
	v15.surfaceGui.Name = "BackgroundEffect"
	v15.surfaceGui.Face = Enum.NormalId.Top
	v15.surfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	v15.surfaceGui.PixelsPerStud = 2
	v15.surfaceGui.LightInfluence = 0
	v15.surfaceGui.Brightness = 1
	v15.surfaceGui.Parent = v15.backgroundPart
	v15.container = Instance.new("Frame")
	v15.container.Name = "Container"
	v15.container.BackgroundTransparency = 1
	v15.container.Size = UDim2.fromScale(1, 1)
	v15.container.Parent = v15.surfaceGui
	local v20 = Instance.new("ImageLabel")
	v20.Name = "background"
	v20.AnchorPoint = Vector2.new(0.5, 0.5)
	v20.BackgroundColor3 = Color3.fromRGB(4, 14, 34)
	v20.BorderSizePixel = 0
	v20.Image = "rbxassetid://924320031"
	v20.ImageTransparency = 1
	v20.Position = UDim2.fromScale(0.5, 0.5)
	v20.Size = UDim2.fromScale(2.5, 2.5)
	v20.ZIndex = 0
	v20.Parent = v15.container
	v15.effectFrame = Instance.new("Frame")
	v15.effectFrame.Name = "Frame"
	v15.effectFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	v15.effectFrame.BackgroundTransparency = 1
	v15.effectFrame.Position = UDim2.fromScale(0.5, 0.5)
	v15.effectFrame.Size = UDim2.fromScale(1.5, 1.5)
	v15.effectFrame.ZIndex = 1
	v15.effectFrame.Parent = v15.container
	local v21 = Instance.new("ImageLabel")
	v21.Name = "crosstexture"
	v21.AnchorPoint = Vector2.new(0.5, 0.5)
	v21.BackgroundTransparency = 1
	v21.BorderSizePixel = 0
	v21.Image = "rbxassetid://1826269153"
	v21.ImageColor3 = Color3.fromRGB(17, 57, 118)
	v21.ImageTransparency = 0.8
	v21.Position = UDim2.fromScale(0.5, 0.5)
	v21.ScaleType = Enum.ScaleType.Tile
	v21.Size = UDim2.fromScale(2.5, 2.5)
	v21.TileSize = UDim2.fromOffset(20, 20)
	v21.ZIndex = 2
	v21.Parent = v15.container
	local v22 = Instance.new("ImageLabel")
	v22.Name = "fade"
	v22.AnchorPoint = Vector2.new(0.5, 0.5)
	v22.BackgroundTransparency = 1
	v22.BorderSizePixel = 0
	v22.Image = "rbxassetid://1826269005"
	v22.ImageColor3 = Color3.fromRGB(115, 183, 255)
	v22.ImageTransparency = 0.75
	v22.Position = UDim2.fromScale(0.5, 0.5)
	v22.ScaleType = Enum.ScaleType.Fit
	v22.Size = UDim2.fromScale(1.5, 1.5)
	v22.ZIndex = 2
	v22.Parent = v15.container
	v15.lineTemplate = Instance.new("Frame")
	v15.lineTemplate.Name = "LineTemplate"
	v15.lineTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
	v15.lineTemplate.BackgroundColor3 = v_u_12
	v15.lineTemplate.BackgroundTransparency = 0.6
	v15.lineTemplate.BorderSizePixel = 0
	v15.lineTemplate.Size = UDim2.fromOffset(200, 2)
	v15.lineTemplate.Visible = false
	local v23 = Instance.new("Frame")
	v23.Name = "fade"
	v23.AnchorPoint = Vector2.new(0.5, 0.5)
	v23.BackgroundColor3 = v_u_12
	v23.BackgroundTransparency = 0.8
	v23.BorderSizePixel = 0
	v23.Position = UDim2.fromScale(0.5, 0.5)
	v23.Size = UDim2.new(1, 0, 0, 6)
	v23.Parent = v15.lineTemplate
	v15.circleTemplate = Instance.new("ImageLabel")
	v15.circleTemplate.Name = "CircleTemplate"
	v15.circleTemplate.AnchorPoint = Vector2.new(0.5, 0.5)
	v15.circleTemplate.BackgroundTransparency = 1
	v15.circleTemplate.BorderSizePixel = 0
	v15.circleTemplate.Image = "rbxassetid://357953997"
	v15.circleTemplate.ImageColor3 = v_u_12
	v15.circleTemplate.ImageTransparency = 0.85
	v15.circleTemplate.Size = UDim2.fromOffset(6, 6)
	v15.circleTemplate.Visible = false
	return v15
end
function v_u_13.getLine(p24, p25) -- name: getLine
	local v26 = p24.lineList[p25]
	if not v26 then
		v26 = p24.lineTemplate:Clone()
		v26.Parent = p24.effectFrame
		p24.lineList[p25] = v26
	end
	return v26
end
function v_u_13.drawLine(p27, p28, p29, p30, p31) -- name: drawLine
	local v32 = p27:getLine(p30)
	local v33 = (p28.X + p29.X) * 0.5
	local v34 = (p28.Y + p29.Y) * 0.5
	local v35 = (p28 - p29).Magnitude
	local v36 = p29.Y - p28.Y
	local v37 = p29.X - p28.X
	local v38 = math.atan2(v36, v37)
	v32.Position = UDim2.fromOffset(v33, v34)
	v32.Size = UDim2.fromOffset(v35, 2)
	v32.Rotation = math.deg(v38)
	v32.Visible = true
	v32.BackgroundTransparency = p31 * 0.15 + 0.6
	local v39 = v32:FindFirstChild("fade")
	if v39 then
		v39.BackgroundTransparency = p31 * 0.1 + 0.8
	end
end
function v_u_13.getCircle(p40) -- name: getCircle
	if #p40.circleBin <= 0 then
		return p40.circleTemplate:Clone()
	end
	local v41 = p40.circleBin[#p40.circleBin]
	p40.circleBin[#p40.circleBin] = nil
	return v41
end
function v_u_13.createTerminateFunctions(p_u_42) -- name: createTerminateFunctions
	local v_u_43 = p_u_42.surfaceGui.AbsoluteSize
	function p_u_42.side1Terminate(p44)
		-- upvalues: (copy) v_u_43, (copy) p_u_42
		local v45 = p44.Position
		local v46 = p44.Size
		if v45.X.Offset - v46.X.Offset / 2 > v_u_43.X or (v45.Y.Offset + v46.Y.Offset / 2 < 0 or v45.Y.Offset - v46.Y.Offset / 2 > v_u_43.Y) then
			p44.Parent = nil
			p_u_42.circleData[p44] = nil
			local v47 = p_u_42.circleBin
			table.insert(v47, p44)
		end
	end
	function p_u_42.side2Terminate(p48)
		-- upvalues: (copy) v_u_43, (copy) p_u_42
		local v49 = p48.Position
		local v50 = p48.Size
		if v49.Y.Offset - v50.Y.Offset / 2 > v_u_43.Y or (v49.X.Offset + v50.X.Offset / 2 < 0 or v49.X.Offset - v50.X.Offset / 2 > v_u_43.X) then
			p48.Parent = nil
			p_u_42.circleData[p48] = nil
			local v51 = p_u_42.circleBin
			table.insert(v51, p48)
		end
	end
	function p_u_42.side3Terminate(p52)
		-- upvalues: (copy) v_u_43, (copy) p_u_42
		local v53 = p52.Position
		local v54 = p52.Size
		if v53.X.Offset + v54.X.Offset / 2 < 0 or (v53.Y.Offset + v54.Y.Offset / 2 < 0 or v53.Y.Offset - v54.Y.Offset / 2 > v_u_43.Y) then
			p52.Parent = nil
			p_u_42.circleData[p52] = nil
			local v55 = p_u_42.circleBin
			table.insert(v55, p52)
		end
	end
	function p_u_42.side4Terminate(p56)
		-- upvalues: (copy) v_u_43, (copy) p_u_42
		local v57 = p56.Position
		local v58 = p56.Size
		if v57.Y.Offset + v58.Y.Offset / 2 < 0 or (v57.X.Offset + v58.X.Offset / 2 < 0 or v57.X.Offset - v58.X.Offset / 2 > v_u_43.X) then
			p56.Parent = nil
			p_u_42.circleData[p56] = nil
			local v59 = p_u_42.circleBin
			table.insert(v59, p56)
		end
	end
end
function v_u_13.spawnCircle(p60) -- name: spawnCircle
	local v61 = p60.surfaceGui.AbsoluteSize
	local v62 = math.random(1, 4)
	local v63 = math.random()
	local v64 = math.random() * 50 + 50
	local v65 = math.random() * 50 + 50
	local v66 = p60:getCircle()
	local v67
	if v62 == 1 then
		v67 = {
			["Velocity"] = nil,
			["LastPos"] = nil,
			["LastTick"] = nil,
			["Terminate"] = nil,
			["Connected"] = nil,
			["GX"] = -5,
			["GY"] = nil,
			["Velocity"] = Vector2.new(v64, v65 * (math.random(0, 1) == 0 and -1 or 1)),
			["LastPos"] = Vector2.new(-3, v61.Y * v63),
			["LastTick"] = tick(),
			["Terminate"] = p60.side1Terminate,
			["Connected"] = {}
		}
		local v68 = v61.Y * v63 / 250
		v67.GY = math.floor(v68)
	elseif v62 == 2 then
		v67 = {
			["Velocity"] = nil,
			["LastPos"] = nil,
			["LastTick"] = nil,
			["Terminate"] = nil,
			["Connected"] = nil,
			["GX"] = nil,
			["GY"] = -5,
			["Velocity"] = Vector2.new(v64 * (math.random(0, 1) == 0 and -1 or 1), v65),
			["LastPos"] = Vector2.new(v61.X * v63, -3),
			["LastTick"] = tick(),
			["Terminate"] = p60.side2Terminate,
			["Connected"] = {}
		}
		local v69 = v61.X * v63 / 250
		v67.GX = math.floor(v69)
	elseif v62 == 3 then
		v67 = {
			["Velocity"] = nil,
			["LastPos"] = nil,
			["LastTick"] = nil,
			["Terminate"] = nil,
			["Connected"] = nil,
			["GX"] = 40,
			["GY"] = nil,
			["Velocity"] = Vector2.new(-v64, v65 * (math.random(0, 1) == 0 and -1 or 1)),
			["LastPos"] = Vector2.new(v61.X + 3, v61.Y * v63),
			["LastTick"] = tick(),
			["Terminate"] = p60.side3Terminate,
			["Connected"] = {}
		}
		local v70 = v61.Y * v63 / 250
		v67.GY = math.floor(v70)
	else
		v67 = {
			["Velocity"] = nil,
			["LastPos"] = nil,
			["LastTick"] = nil,
			["Terminate"] = nil,
			["Connected"] = nil,
			["GX"] = nil,
			["GY"] = 40,
			["Velocity"] = Vector2.new(v64 * (math.random(0, 1) == 0 and -1 or 1), -v65),
			["LastPos"] = Vector2.new(v61.X * v63, v61.Y + 3),
			["LastTick"] = tick(),
			["Terminate"] = p60.side4Terminate,
			["Connected"] = {}
		}
		local v71 = v61.X * v63 / 250
		v67.GX = math.floor(v71)
	end
	local v72 = v67.GX
	local v73 = v67.GY
	local v74 = math.clamp(v72, -5, 40)
	local v75 = math.clamp(v73, -5, 40)
	v67.GX = v74
	v67.GY = v75
	p60.circleData[v66] = v67
	v66.Parent = p60.effectFrame
	v66.Visible = true
end
function v_u_13.update(p76) -- name: update
	local v77 = tick()
	for v78, v79 in p76.circleData do
		local v80 = v77 - v79.LastTick
		local v81 = v79.LastPos.X + v79.Velocity.X * v80
		local v82 = v79.LastPos.Y + v79.Velocity.Y * v80
		v78.Position = UDim2.fromOffset(v81, v82)
		v79.LastTick = v77
		v79.LastPos = Vector2.new(v81, v82)
		v79.Terminate(v78)
		if v78.Parent then
			local v83 = v79.GX
			local v84 = v79.GY
			local v85 = v81 / 250
			local v86 = math.floor(v85)
			local v87 = v82 / 250
			local v88 = math.floor(v87)
			local v89 = math.clamp(v86, -5, 40)
			local v90 = math.clamp(v88, -5, 40)
			if v83 ~= v89 or v84 ~= v90 then
				p76.grid[v83][v84][v78] = nil
				v79.GX = v89
				v79.GY = v90
			end
			p76.grid[v89][v90][v78] = true
		else
			p76.grid[v79.GX][v79.GY][v78] = nil
		end
	end
	local v91 = 1
	for v92, v93 in p76.circleData do
		table.clear(v93.Connected)
		for v94 = -1, 1 do
			for v95 = -1, 1 do
				local v96 = v93.GX + v94
				local v97 = v93.GY + v95
				local v98 = math.clamp(v96, -5, 40)
				local v99 = math.clamp(v97, -5, 40)
				for v100 in p76.grid[v98][v99] do
					if v100 ~= v92 then
						local v101 = p76.circleData[v100]
						if v101 and not v101.Connected[v92] then
							local v102 = v101.LastPos
							local v103 = v93.LastPos
							local v104 = (v102 - v103).Magnitude
							if v104 <= 250 then
								v93.Connected[v100] = true
								p76:drawLine(v102, v103, v91, v104 / 250)
								v91 = v91 + 1
							end
						end
					end
				end
			end
		end
	end
	for v105 = v91, #p76.lineList do
		p76.lineList[v105].Visible = false
	end
end
function v_u_13.start(p_u_106, p107) -- name: start
	-- upvalues: (copy) v_u_1
	if not p_u_106.running then
		p_u_106.running = true
		p_u_106.backgroundPart.Parent = p107 or workspace
		task.defer(function()
			-- upvalues: (copy) p_u_106
			p_u_106:createTerminateFunctions()
		end)
		local v108 = v_u_1.Heartbeat:Connect(function()
			-- upvalues: (copy) p_u_106
			p_u_106:update()
		end)
		local v109 = p_u_106.connections
		table.insert(v109, v108)
		task.spawn(function()
			-- upvalues: (copy) p_u_106
			while p_u_106.running do
				local v110 = math.random() * 0.15000000000000002 + 0.25
				task.wait(v110)
				if p_u_106.running and p_u_106.side1Terminate then
					p_u_106:spawnCircle()
				end
			end
		end)
	end
end
function v_u_13.stop(p111) -- name: stop
	p111.running = false
	for _, v112 in p111.connections do
		v112:Disconnect()
	end
	p111.connections = {}
end
function v_u_13.destroy(p113) -- name: destroy
	p113:stop()
	for v114 in p113.circleData do
		v114:Destroy()
	end
	p113.circleData = {}
	for _, v115 in p113.circleBin do
		v115:Destroy()
	end
	p113.circleBin = {}
	for _, v116 in p113.lineList do
		v116:Destroy()
	end
	p113.lineList = {}
	for v117 = -5, 40 do
		for v118 = -5, 40 do
			table.clear(p113.grid[v117][v118])
		end
	end
	p113.backgroundPart:Destroy()
end
return v_u_13