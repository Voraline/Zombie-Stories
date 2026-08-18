local v_u_1 = game:GetService("Workspace")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("TextService")
local v_u_5 = v_u_1.Terrain
local v_u_6 = Color3.new(1, 0, 0)
local v_u_138 = {
	["_defaultColor"] = v_u_6,
	["setColor"] = function(p7) -- name: setColor
		-- upvalues: (copy) v_u_138
		v_u_138._defaultColor = p7
	end,
	["resetColor"] = function() -- name: resetColor
		-- upvalues: (copy) v_u_138, (copy) v_u_6
		v_u_138._defaultColor = v_u_6
	end,
	["setRandomColor"] = function() -- name: setRandomColor
		-- upvalues: (copy) v_u_138
		v_u_138.setColor(Color3.fromHSV(math.random(), 0.5 + 0.5 * math.random(), 1))
	end,
	["ray"] = function(p8, p9, p10, p11, p12) -- name: ray
		-- upvalues: (copy) v_u_138
		local v13 = typeof(p8) == "Ray"
		assert(v13, "Bad typeof(ray) for Ray")
		local v14 = p9 or v_u_138._defaultColor
		local v15 = p10 or v_u_138.getDefaultParent()
		local v16 = p11 or 0.2
		local v17 = p12 or 0.2
		local v18 = p8.Origin + p8.Direction / 2
		local v19 = Instance.new("Part")
		v19.Material = Enum.Material.ForceField
		v19.Anchored = true
		v19.Archivable = false
		v19.CanCollide = false
		v19.CanQuery = false
		v19.CanTouch = false
		v19.CastShadow = false
		v19.CFrame = CFrame.new(v18, p8.Origin + p8.Direction) * CFrame.Angles(1.5707963267948966, 0, 0)
		v19.Color = v14
		v19.Name = "DebugRay"
		v19.Shape = Enum.PartType.Cylinder
		local v20 = p8.Direction.Magnitude
		v19.Size = Vector3.new(v17, v20, v17)
		v19.TopSurface = Enum.SurfaceType.Smooth
		v19.Transparency = 0.5
		local v21 = Instance.new("Part")
		v21.Name = "RotatedPart"
		v21.Anchored = true
		v21.Archivable = false
		v21.CanCollide = false
		v21.CanQuery = false
		v21.CanTouch = false
		v21.CastShadow = false
		v21.CFrame = CFrame.new(p8.Origin, p8.Origin + p8.Direction)
		v21.Transparency = 1
		v21.Size = Vector3.new(1, 1, 1)
		v21.Parent = v19
		local v22 = Instance.new("LineHandleAdornment")
		v22.Name = "DrawRayLineHandleAdornment"
		v22.Length = p8.Direction.Magnitude
		v22.Thickness = 5 * v17
		v22.ZIndex = 3
		v22.Color3 = v14
		v22.AlwaysOnTop = true
		v22.Transparency = 0
		v22.Adornee = v21
		v22.Parent = v21
		local v23 = Instance.new("SpecialMesh")
		v23.Name = "DrawRayMesh"
		v23.Scale = Vector3.new(0, 1, 0) + Vector3.new(v16, 0, v16) / v17
		v23.Parent = v19
		v19.Parent = v15
		return v19
	end,
	["updateRay"] = function(p24, p25, p26) -- name: updateRay
		local v27 = p26 or p24.Color
		local v28 = p24.Size.x
		local v29 = p25.Origin + p25.Direction / 2
		p24.CFrame = CFrame.new(v29, p25.Origin + p25.Direction) * CFrame.Angles(1.5707963267948966, 0, 0)
		local v30 = p25.Direction.Magnitude
		p24.Size = Vector3.new(v28, v30, v28)
		p24.Color = v27
		local v31 = p24:FindFirstChild("RotatedPart")
		if v31 then
			v31.CFrame = CFrame.new(p25.Origin, p25.Origin + p25.Direction)
		end
		if v31 then
			v31 = v31:FindFirstChild("DrawRayLineHandleAdornment")
		end
		if v31 then
			v31.Length = p25.Direction.Magnitude
			v31.Thickness = 5 * v28
			v31.Color3 = v27
		end
	end,
	["text"] = function(p32, p33, p34) -- name: text
		-- upvalues: (copy) v_u_5, (copy) v_u_138
		if typeof(p32) == "Vector3" then
			local v35 = Instance.new("Attachment")
			v35.WorldPosition = p32
			v35.Parent = v_u_5
			v35.Name = "DebugTextAttachment"
			v_u_138._textOnAdornee(v35, p33, p34)
			return v35
		end
		if typeof(p32) == "Instance" then
			return v_u_138._textOnAdornee(p32, p33, p34)
		end
		error("Bad adornee")
	end,
	["_textOnAdornee"] = function(p36, p37, p38) -- name: _textOnAdornee
		-- upvalues: (copy) v_u_138, (copy) v_u_4
		local v39 = Instance.new("BillboardGui")
		v39.Name = "DebugBillboardGui"
		v39.SizeOffset = Vector2.new(0, 0.5)
		v39.ExtentsOffset = Vector3.new(0, 1, 0)
		v39.AlwaysOnTop = true
		v39.Adornee = p36
		v39.StudsOffset = Vector3.new(0, 0, 0.01)
		local v40 = Instance.new("Frame")
		v40.Name = "Background"
		v40.Size = UDim2.new(1, 0, 1, 0)
		v40.Position = UDim2.new(0.5, 0, 1, 0)
		v40.AnchorPoint = Vector2.new(0.5, 1)
		v40.BackgroundTransparency = 0.3
		v40.BorderSizePixel = 0
		v40.BackgroundColor3 = p38 or v_u_138._defaultColor
		v40.Parent = v39
		local v41 = Instance.new("TextLabel")
		v41.Text = tostring(p37)
		v41.TextScaled = true
		v41.TextSize = 32
		v41.BackgroundTransparency = 1
		v41.BorderSizePixel = 0
		v41.TextColor3 = Color3.new(1, 1, 1)
		v41.Size = UDim2.new(1, 0, 1, 0)
		v41.Parent = v40
		if tonumber(p37) then
			v41.Font = Enum.Font.Code
		else
			v41.Font = Enum.Font.GothamMedium
		end
		local v42 = v_u_4:GetTextSize(v41.Text, v41.TextSize, v41.Font, Vector2.new(1024, 1000000))
		local v43 = v42.y / v41.TextSize
		local v44 = v41.TextSize * 0.5
		local v45 = v42.y + 2 * v44
		local v46 = v42.x + 2 * v44
		local v47 = v46 / v45
		local v48 = Instance.new("UIAspectRatioConstraint")
		v48.AspectRatio = v47
		v48.Parent = v40
		local v49 = Instance.new("UIPadding")
		v49.PaddingBottom = UDim.new(v44 / v45, 0)
		v49.PaddingTop = UDim.new(v44 / v45, 0)
		v49.PaddingLeft = UDim.new(v44 / v46, 0)
		v49.PaddingRight = UDim.new(v44 / v46, 0)
		v49.Parent = v40
		local v50 = Instance.new("UICorner")
		v50.CornerRadius = UDim.new(v44 / v45 / 2, 0)
		v50.Parent = v40
		local v51 = v43 * 2 * 2 * 0.5
		v39.Size = UDim2.new(v51 * v47, 0, v51, 0)
		v39.Parent = p36
		return v39
	end,
	["sphere"] = function(p52, p53, p54, p55) -- name: sphere
		-- upvalues: (copy) v_u_138
		return v_u_138.point(p52, p54, p55, p53 * 2)
	end,
	["point"] = function(p56, p57, p58, p59) -- name: point
		-- upvalues: (copy) v_u_138
		if typeof(p56) == "CFrame" then
			p56 = p56.Position
		end
		local v60 = typeof(p56) == "Vector3"
		assert(v60, "Bad position")
		local v61 = p57 or v_u_138._defaultColor
		local v62 = p58 or v_u_138.getDefaultParent()
		local v63 = p59 or 1
		local v64 = Instance.new("Part")
		v64.Material = Enum.Material.ForceField
		v64.Anchored = true
		v64.Archivable = false
		v64.BottomSurface = Enum.SurfaceType.Smooth
		v64.CanCollide = false
		v64.CanQuery = false
		v64.CanTouch = false
		v64.CastShadow = false
		v64.CFrame = CFrame.new(p56)
		v64.Color = v61
		v64.Name = "DebugPoint"
		v64.Shape = Enum.PartType.Ball
		v64.Size = Vector3.new(v63, v63, v63)
		v64.TopSurface = Enum.SurfaceType.Smooth
		v64.Transparency = 0.5
		local v65 = Instance.new("SphereHandleAdornment")
		v65.Archivable = false
		v65.Radius = v63 / 4
		v65.Color3 = v61
		v65.AlwaysOnTop = true
		v65.Adornee = v64
		v65.ZIndex = 2
		v65.Parent = v64
		v64.Parent = v62
		return v64
	end,
	["labelledPoint"] = function(p66, p67, p68, p69) -- name: labelledPoint
		-- upvalues: (copy) v_u_138
		if typeof(p66) == "CFrame" then
			p66 = p66.Position
		end
		local v70 = v_u_138.point(p66, p68, p69)
		v_u_138.text(v70, p67, p68)
		return v70
	end,
	["cframe"] = function(p71) -- name: cframe
		-- upvalues: (copy) v_u_138
		local v72 = Instance.new("Model")
		v72.Name = "DebugCFrame"
		local v73 = p71.Position
		v_u_138.point(v73, nil, v72, 0.1)
		v_u_138.ray(Ray.new(v73, p71.XVector), Color3.new(0.75, 0.25, 0.25), v72, 0.1).Name = "XVector"
		v_u_138.ray(Ray.new(v73, p71.YVector), Color3.new(0.25, 0.75, 0.25), v72, 0.1).Name = "YVector"
		v_u_138.ray(Ray.new(v73, p71.ZVector), Color3.new(0.25, 0.25, 0.75), v72, 0.1).Name = "ZVector"
		v72.Parent = v_u_138.getDefaultParent()
		return v72
	end,
	["part"] = function(p74, p75, p76, p77) -- name: part
		-- upvalues: (copy) v_u_138
		local v78
		if typeof(p74) == "Instance" then
			v78 = p74:IsA("BasePart")
		else
			v78 = false
		end
		assert(v78, "Bad template")
		local v79 = p74:Clone()
		for _, v80 in pairs(v79:GetChildren()) do
			if v80:IsA("Mesh") then
				v_u_138._sanitize(v80)
				v80:ClearAllChildren()
			else
				v80:Destroy()
			end
		end
		v79.Color = p76 or v_u_138._defaultColor
		v79.Material = Enum.Material.ForceField
		v79.Transparency = p77 or 0.75
		v79.Name = "Debug" .. p74.Name
		v79.Anchored = true
		v79.CanCollide = false
		v79.CanQuery = false
		v79.CanTouch = false
		v79.CastShadow = false
		v79.Archivable = false
		if p75 then
			v79.CFrame = p75
		end
		v_u_138._sanitize(v79)
		v79.Parent = v_u_138.getDefaultParent()
		return v79
	end,
	["_sanitize"] = function(p81) -- name: _sanitize
		-- upvalues: (copy) v_u_3
		for v82, _ in pairs(p81:GetAttributes()) do
			p81:SetAttribute(v82, nil)
		end
		for _, v83 in pairs(v_u_3:GetTags(p81)) do
			v_u_3:RemoveTag(p81, v83)
		end
	end,
	["box"] = function(p84, p85, p86) -- name: box
		-- upvalues: (copy) v_u_138
		local v87 = typeof(p85) == "Vector3"
		assert(v87, "Bad size")
		local v88 = p86 or v_u_138._defaultColor
		if typeof(p84) == "Vector3" then
			p84 = CFrame.new(p84) or p84
		end
		local v89 = Instance.new("Part")
		v89.Color = v88
		v89.Material = Enum.Material.ForceField
		v89.Name = "DebugPart"
		v89.Anchored = true
		v89.CanCollide = false
		v89.CanQuery = false
		v89.CanTouch = false
		v89.CastShadow = false
		v89.Archivable = false
		v89.BottomSurface = Enum.SurfaceType.Smooth
		v89.TopSurface = Enum.SurfaceType.Smooth
		v89.Transparency = 0.75
		v89.Size = p85
		v89.CFrame = p84
		local v90 = Instance.new("BoxHandleAdornment")
		v90.Adornee = v89
		v90.Size = p85
		v90.Color3 = v88
		v90.AlwaysOnTop = true
		v90.Transparency = 0.75
		v90.ZIndex = 1
		v90.Parent = v89
		v89.Parent = v_u_138.getDefaultParent()
		return v89
	end,
	["region3"] = function(p91, p92) -- name: region3
		-- upvalues: (copy) v_u_138
		return v_u_138.box(p91.CFrame, p91.Size, p92)
	end,
	["terrainCell"] = function(p93, p94) -- name: terrainCell
		-- upvalues: (copy) v_u_5, (copy) v_u_138
		local v95 = v_u_5:WorldToCell(p93)
		local v96 = v_u_5:CellCenterToWorld(v95.x, v95.y, v95.z)
		local v97 = v_u_138.box(CFrame.new(v96), Vector3.new(4, 4, 4), p94)
		v97.Name = "DebugTerrainCell"
		return v97
	end,
	["screenPointLine"] = function(p98, p99, p100, p101) -- name: screenPointLine
		-- upvalues: (copy) v_u_138
		local v102 = p99 - p98
		local v103 = p98 + v102 / 2
		local v104 = Instance.new("Frame")
		v104.Name = "DebugScreenLine"
		local v105 = UDim2.fromScale
		local v106 = v102.x
		local v107 = math.abs(v106)
		local v108 = v102.y
		v104.Size = v105(v107, (math.abs(v108)))
		v104.BackgroundTransparency = 1
		v104.Position = UDim2.fromScale(v103.x, v103.y)
		v104.AnchorPoint = Vector2.new(0.5, 0.5)
		v104.BorderSizePixel = 0
		v104.ZIndex = 10000
		v104.Parent = p100
		if v102.magnitude == 0 then
			return v104
		elseif v102.y / v102.x > 0 then
			for v109 = 0, 25 do
				v_u_138.screenPoint(Vector2.new(v109 / 25, v109 / 25), v104, p101, 3)
			end
			return v104
		else
			for v110 = 0, 25 do
				v_u_138.screenPoint(Vector2.new(v110 / 25, 1 - v110 / 25), v104, p101, 3)
			end
			return v104
		end
	end,
	["screenPoint"] = function(p111, p112, p113, p114) -- name: screenPoint
		local v115 = Instance.new("Frame")
		v115.Name = "DebugScreenPoint"
		v115.Size = UDim2.new(0, p114, 0, p114)
		v115.BackgroundColor3 = p113 or Color3.new(1, 0.1, 0.1)
		v115.BackgroundTransparency = 0.5
		v115.Position = UDim2.fromScale(p111.x, p111.y)
		v115.AnchorPoint = Vector2.new(0.5, 0.5)
		v115.BorderSizePixel = 0
		v115.ZIndex = 20000
		local v116 = Instance.new("UICorner")
		v116.CornerRadius = UDim.new(0.5, 0)
		v116.Parent = v115
		v115.Parent = p112
		return v115
	end,
	["vector"] = function(p117, p118, p119, p120, p121) -- name: vector
		-- upvalues: (copy) v_u_138
		return v_u_138.ray(Ray.new(p117, p118), p119, p120, p121)
	end,
	["ring"] = function(p122, p123, p124, p125, p126) -- name: ring
		-- upvalues: (copy) v_u_138
		local v127 = CFrame.new(p122, p122 + p123)
		local v128 = {}
		for v129 = 0, 6.283185307179586, 0.39269908169872414 do
			local v130 = math.cos(v129) * p124
			local v131 = math.sin(v129) * p124
			local v132 = v127:pointToWorldSpace((Vector3.new(v130, v131, 0)))
			table.insert(v128, v132)
		end
		local v133 = Instance.new("Folder")
		v133.Name = "DebugRing"
		for v134 = 1, #v128 do
			local v135 = v128[v134]
			local v136 = v128[v134 % #v128 + 1]
			local v137 = Ray.new(v135, v136 - v135)
			v_u_138.ray(v137, p125, v133)
		end
		v133.Parent = p126 or v_u_138.getDefaultParent()
		return v133
	end,
	["getDefaultParent"] = function() -- name: getDefaultParent
		-- upvalues: (copy) v_u_2, (copy) v_u_1
		if v_u_2:IsRunning() then
			if v_u_2:IsServer() then
				return v_u_1
			else
				return v_u_1.CurrentCamera
			end
		else
			return v_u_1.CurrentCamera
		end
	end
}
return v_u_138