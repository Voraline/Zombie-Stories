local v_u_1 = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7
}
local v_u_2 = {
	0,
	1,
	3,
	4,
	5,
	7
}
local v_u_3 = {
	0,
	1,
	4,
	5,
	6
}
local v_u_4 = {}
v_u_4.__index = v_u_4
v_u_4.ClassName = "ViewportModel"
local function v_u_16(p5, p6, p7) -- name: getCorners
	local v8 = {}
	for _, v9 in pairs(p7) do
		local v10 = v9 + 1
		local v11 = v9 / 4
		local v12 = math.floor(v11) % 2 * 2 - 1
		local v13 = v9 / 2
		local v14 = math.floor(v13) % 2 * 2 - 1
		local v15 = 2 * (v9 % 2) - 1
		v8[v10] = p5 * (p6 * Vector3.new(v12, v14, v15))
	end
	return v8
end
local function v_u_23(p17) -- name: getModelPointCloud
	-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_1, (copy) v_u_16
	local v18 = {}
	for _, v19 in p17:QueryDescendants("BasePart") do
		local v20
		if v19:IsA("WedgePart") then
			v20 = v_u_2
		elseif v19:IsA("CornerWedgePart") then
			v20 = v_u_3
		else
			v20 = v_u_1
		end
		local v21 = v_u_16(v19.CFrame, v19.Size / 2, v20)
		for _, v22 in pairs(v21) do
			table.insert(v18, v22)
		end
	end
	return v18
end
local function v_u_34(p24, p25, p26, p27) -- name: viewProjectionEdgeHits
	local v28 = (-1 / 0)
	local v29 = (1 / 0)
	for _, v30 in pairs(p24) do
		local v31 = p27 * (p26 - v30.Z)
		local v32 = v30[p25] + v31
		local v33 = v30[p25] - v31
		v28 = math.max(v28, v32, v33)
		v29 = math.min(v29, v32, v33)
	end
	return v28, v29
end
function v_u_4.new(p35, p36) -- name: new
	-- upvalues: (copy) v_u_4
	local v37 = v_u_4
	local v38 = setmetatable({}, v37)
	v38.Model = nil
	v38.ViewportFrame = p35
	v38.Camera = p36
	v38._points = {}
	v38._modelCFrame = CFrame.new()
	v38._modelSize = Vector3.new()
	v38._modelRadius = 0
	v38._viewport = {}
	v38:Calibrate()
	return v38
end
function v_u_4.SetModel(p39, p40) -- name: SetModel
	-- upvalues: (copy) v_u_23
	p39.Model = p40
	local v41, v42 = p40:GetBoundingBox()
	p39._points = v_u_23(p40)
	p39._modelCFrame = v41
	p39._modelSize = v42
	p39._modelRadius = v42.Magnitude / 2
end
function v_u_4.Calibrate(p43) -- name: Calibrate
	local v44 = {}
	local v45 = p43.ViewportFrame.AbsoluteSize
	v44.aspect = v45.X / v45.Y
	local v46 = p43.Camera.FieldOfView / 2
	v44.yFov2 = math.rad(v46)
	local v47 = v44.yFov2
	v44.tanyFov2 = math.tan(v47)
	local v48 = v44.tanyFov2 * v44.aspect
	v44.xFov2 = math.atan(v48)
	local v49 = v44.xFov2
	v44.tanxFov2 = math.tan(v49)
	local v50 = v44.tanyFov2
	local v51 = v44.aspect
	local v52 = v50 * math.min(1, v51)
	v44.cFov2 = math.atan(v52)
	local v53 = v44.cFov2
	v44.sincFov2 = math.sin(v53)
	p43._viewport = v44
end
function v_u_4.GetFitDistance(p54, p55) -- name: GetFitDistance
	local v56 = p55 and ((p55 - p54._modelCFrame.Position).Magnitude or 0) or 0
	return (p54._modelRadius + v56) / p54._viewport.sincFov2
end
function v_u_4.GetMinimumFitCFrame(p57, p58) -- name: GetMinimumFitCFrame
	-- upvalues: (copy) v_u_34
	if not p57.Model then
		return CFrame.new()
	end
	local v59 = (p58 - p58.Position):Inverse()
	local v60 = p57._points
	local v61 = { v59 * v60[1] }
	local v62 = v61[1].Z
	for v63 = 2, #v60 do
		local v64 = v59 * v60[v63]
		local v65 = v64.Z
		v62 = math.min(v62, v65)
		v61[v63] = v64
	end
	local v66, v67 = v_u_34(v61, "X", v62, p57._viewport.tanxFov2)
	local v68, v69 = v_u_34(v61, "Y", v62, p57._viewport.tanyFov2)
	local v70 = (v66 - v67) / 2 / p57._viewport.tanxFov2
	local v71 = (v68 - v69) / 2 / p57._viewport.tanyFov2
	local v72 = math.max(v70, v71)
	return p58 * CFrame.new((v66 + v67) / 2, (v68 + v69) / 2, v62 + v72)
end
return v_u_4