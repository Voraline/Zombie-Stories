local v_u_1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = require(v3.common.skillTree.config.SkillConfig).layout
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new() -- name: new
	-- upvalues: (copy) v_u_5
	local v6 = v_u_5
	local v7 = setmetatable({}, v6)
	v7.camera = workspace.CurrentCamera
	v7.enabled = false
	v7.targetPosition = Vector3.new(2500, 500, 2500)
	v7.currentZoom = 80
	v7.isPanning = false
	v7.lastMousePosition = Vector2.zero
	v7.connections = {}
	v7.gamepadInput = Vector2.zero
	v7.gamepadZoomInput = 0
	v7.gamepadPanTime = 0
	v7.activeTouches = {}
	v7.lastPinchDistance = nil
	v7.pinchAccumulator = 0
	v7.isTouchPanning = false
	v7.lastTouchPosition = Vector2.zero
	v7.touchVelocity = Vector3.new(0, 0, 0)
	v7.inertiaVelocity = Vector3.new(0, 0, 0)
	return v7
end
function v_u_5.getSkillWorldPosition(p8) -- name: getSkillWorldPosition
	-- upvalues: (copy) v_u_4
	local v9 = v_u_4.getPosition(p8)
	if not v9 then
		return nil
	end
	local v10 = -v9.row * 65
	local v11 = v9.column * 65
	return Vector3.new(2500, 500, 2500) + Vector3.new(v10, 0, v11)
end
function v_u_5.enable(p_u_12, p13) -- name: enable
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	if not p_u_12.enabled then
		p_u_12.enabled = true
		p_u_12.camera.CameraType = Enum.CameraType.Scriptable
		local v14 = v_u_5.getSkillWorldPosition(p13 or "core1")
		if v14 then
			local v15 = v14.X
			local v16 = v14.Z
			p_u_12.targetPosition = Vector3.new(v15, 500, v16)
		end
		p_u_12:connectInputs()
		local v18 = v_u_2.RenderStepped:Connect(function(p17)
			-- upvalues: (copy) p_u_12
			p_u_12:update(p17)
		end)
		local v19 = p_u_12.connections
		table.insert(v19, v18)
	end
end
function v_u_5.disable(p20) -- name: disable
	if p20.enabled then
		p20.enabled = false
		for _, v21 in p20.connections do
			v21:Disconnect()
		end
		p20.connections = {}
		p20.camera.CameraType = Enum.CameraType.Custom
	end
end
function v_u_5.connectInputs(p_u_22) -- name: connectInputs
	-- upvalues: (copy) v_u_1
	local v24 = v_u_1.InputBegan:Connect(function(p23, _)
		-- upvalues: (copy) p_u_22, (ref) v_u_1
		if p23.UserInputType == Enum.UserInputType.MouseButton2 then
			p_u_22.isPanning = true
			p_u_22.lastMousePosition = v_u_1:GetMouseLocation()
		end
	end)
	local v25 = p_u_22.connections
	table.insert(v25, v24)
	local v27 = v_u_1.InputEnded:Connect(function(p26)
		-- upvalues: (copy) p_u_22
		if p26.UserInputType == Enum.UserInputType.MouseButton2 then
			p_u_22.isPanning = false
		end
	end)
	local v28 = p_u_22.connections
	table.insert(v28, v27)
	local v53 = v_u_1.InputChanged:Connect(function(p29)
		-- upvalues: (copy) p_u_22, (ref) v_u_1
		if p29.UserInputType == Enum.UserInputType.MouseMovement and p_u_22.isPanning then
			local v30 = v_u_1:GetMouseLocation()
			local v31 = v30 - p_u_22.lastMousePosition
			p_u_22.lastMousePosition = v30
			local v32 = 0.3 * (p_u_22.currentZoom / 400)
			local v33 = p_u_22
			local v34 = p_u_22.targetPosition
			local v35 = v31.Y * v32
			local v36 = -v31.X * v32
			v33.targetPosition = v34 + Vector3.new(v35, 0, v36)
		end
		if p29.UserInputType == Enum.UserInputType.MouseWheel then
			local v37 = p29.Position.Z
			local v38 = p_u_22
			local v39 = p_u_22.currentZoom - v37 * 10
			v38.currentZoom = math.clamp(v39, 40, 400)
		end
		if p29.KeyCode == Enum.KeyCode.Thumbstick1 then
			local v40 = p29.Position
			local v41 = p_u_22
			local v42 = Vector2.new
			local v43 = v40.X
			local v44 = (math.abs(v43) - 0.1) / 0.9
			local v45
			if v44 <= 0 then
				v45 = 0
			else
				local v46 = v44 * 2
				local v47 = (math.exp(v46) - 1) / 6.38905609893065
				v45 = math.sign(v43) * math.clamp(v47, 0, 1)
			end
			local v48 = v40.Y
			local v49 = (math.abs(v48) - 0.1) / 0.9
			local v50
			if v49 <= 0 then
				v50 = 0
			else
				local v51 = v49 * 2
				local v52 = (math.exp(v51) - 1) / 6.38905609893065
				v50 = math.sign(v48) * math.clamp(v52, 0, 1)
			end
			v41.gamepadInput = v42(v45, v50)
		end
		if p29.KeyCode == Enum.KeyCode.ButtonR2 then
			p_u_22.gamepadZoomInput = -p29.Position.Z
		elseif p29.KeyCode == Enum.KeyCode.ButtonL2 then
			p_u_22.gamepadZoomInput = p29.Position.Z
		end
	end)
	local v54 = p_u_22.connections
	table.insert(v54, v53)
	local v57 = v_u_1.InputBegan:Connect(function(p55, _)
		-- upvalues: (copy) p_u_22
		if p55.UserInputType == Enum.UserInputType.Touch then
			p_u_22.activeTouches[p55] = Vector2.new(p55.Position.X, p55.Position.Y)
			p_u_22.inertiaVelocity = Vector3.new(0, 0, 0)
			p_u_22.touchVelocity = Vector3.new(0, 0, 0)
			local v56 = 0
			for _ in p_u_22.activeTouches do
				v56 = v56 + 1
			end
			if v56 == 1 then
				p_u_22.isTouchPanning = true
				p_u_22.lastTouchPosition = Vector2.new(p55.Position.X, p55.Position.Y)
				return
			end
			p_u_22.isTouchPanning = false
		end
	end)
	local v58 = p_u_22.connections
	table.insert(v58, v57)
	local v59 = v_u_1.InputEnded:Connect(function()
		-- upvalues: (copy) p_u_22
		-- -- failed to decompile
	end)
	local v60 = p_u_22.connections
	table.insert(v60, v59)
	local v79 = v_u_1.InputChanged:Connect(function(p61)
		-- upvalues: (copy) p_u_22
		if p61.UserInputType == Enum.UserInputType.Touch then
			if p_u_22.activeTouches[p61] then
				p_u_22.activeTouches[p61] = Vector2.new(p61.Position.X, p61.Position.Y)
			end
			local v62 = 0
			local v63 = {}
			for _, v64 in p_u_22.activeTouches do
				v62 = v62 + 1
				table.insert(v63, v64)
			end
			if v62 == 1 and p_u_22.isTouchPanning then
				local v65 = Vector2.new(p61.Position.X, p61.Position.Y)
				local v66 = v65 - p_u_22.lastTouchPosition
				p_u_22.lastTouchPosition = v65
				local v67 = 0.5 * (p_u_22.currentZoom / 400)
				local v68 = v66.Y * v67
				local v69 = -v66.X * v67
				local v70 = Vector3.new(v68, 0, v69)
				p_u_22.targetPosition = p_u_22.targetPosition + v70
				local v71 = v70 * 60
				p_u_22.touchVelocity = p_u_22.touchVelocity:Lerp(v71, 0.5)
				return
			end
			if v62 == 2 then
				local v72 = (v63[1] - v63[2]).Magnitude
				if p_u_22.lastPinchDistance then
					local v73 = p_u_22.lastPinchDistance - v72
					p_u_22.pinchAccumulator = p_u_22.pinchAccumulator + v73
					while true do
						local v74 = p_u_22.pinchAccumulator
						if math.abs(v74) < 50 then
							break
						end
						if p_u_22.pinchAccumulator > 0 then
							local v75 = p_u_22
							local v76 = p_u_22.currentZoom + 20
							v75.currentZoom = math.clamp(v76, 40, 400)
							p_u_22.pinchAccumulator = p_u_22.pinchAccumulator - 50
						else
							local v77 = p_u_22
							local v78 = p_u_22.currentZoom - 20
							v77.currentZoom = math.clamp(v78, 40, 400)
							p_u_22.pinchAccumulator = p_u_22.pinchAccumulator + 50
						end
					end
				end
				p_u_22.lastPinchDistance = v72
			end
		end
	end)
	local v80 = p_u_22.connections
	table.insert(v80, v79)
end
function v_u_5.clampToBounds(p81) -- name: clampToBounds
	local v82 = p81.targetPosition.X
	local v83 = math.clamp(v82, 2010, 2665)
	local v84 = p81.targetPosition.Y
	local v85 = p81.targetPosition.Z
	local v86 = math.clamp(v85, 2140, 2860)
	p81.targetPosition = Vector3.new(v83, v84, v86)
end
function v_u_5.update(p87, p88) -- name: update
	-- upvalues: (copy) v_u_1
	if p87.enabled then
		local v89 = Vector3.new(0, 0, 0)
		if v_u_1:IsKeyDown(Enum.KeyCode.W) then
			v89 = v89 + Vector3.new(1, 0, 0)
		end
		if v_u_1:IsKeyDown(Enum.KeyCode.S) then
			v89 = v89 + Vector3.new(-1, 0, 0)
		end
		if v_u_1:IsKeyDown(Enum.KeyCode.A) then
			v89 = v89 + Vector3.new(0, 0, -1)
		end
		if v_u_1:IsKeyDown(Enum.KeyCode.D) then
			v89 = v89 + Vector3.new(0, 0, 1)
		end
		if v89.Magnitude > 0 then
			local v90 = 200 * (p87.currentZoom / 400)
			p87.targetPosition = p87.targetPosition + v89.Unit * v90 * p88
		end
		if p87.gamepadInput.Magnitude > 0 then
			p87.gamepadPanTime = p87.gamepadPanTime + p88
			local v91 = p87.gamepadPanTime / 1.5
			local v92 = math.min(v91, 1)
			local v93 = (v92 * v92 * 400 + 200) * (p87.currentZoom / 400)
			local v94 = p87.targetPosition
			local v95 = p87.gamepadInput.Y * v93 * p88
			local v96 = p87.gamepadInput.X * v93 * p88
			p87.targetPosition = v94 + Vector3.new(v95, 0, v96)
		else
			p87.gamepadPanTime = 0
		end
		if p87.gamepadZoomInput ~= 0 then
			local v97 = p87.currentZoom + p87.gamepadZoomInput * 100 * p88
			p87.currentZoom = math.clamp(v97, 40, 400)
		end
		if p87.inertiaVelocity.Magnitude > 0.5 then
			p87.targetPosition = p87.targetPosition + p87.inertiaVelocity * p88
			local v98 = p87.inertiaVelocity
			local v99 = p88 * -5
			p87.inertiaVelocity = v98 * math.exp(v99)
		else
			p87.inertiaVelocity = Vector3.new(0, 0, 0)
		end
		p87:clampToBounds()
		local v100 = p87.targetPosition
		local v101 = p87.currentZoom
		local v102 = v100 + Vector3.new(0, v101, 0)
		local v103 = p87.targetPosition
		p87.camera.CFrame = CFrame.lookAt(v102, v103) * CFrame.Angles(0.017453292519943295, 0, 0)
	end
end
function v_u_5.focusSkill(p104, p105) -- name: focusSkill
	-- upvalues: (copy) v_u_5
	local v106 = v_u_5.getSkillWorldPosition(p105)
	if v106 then
		local v107 = v106.X
		local v108 = v106.Z
		p104.targetPosition = Vector3.new(v107, 500, v108)
	end
end
function v_u_5.setFieldOfView(p109, p110) -- name: setFieldOfView
	p109.camera.FieldOfView = p110
end
function v_u_5.tweenFieldOfView(p_u_111, p_u_112, p113, p_u_114) -- name: tweenFieldOfView
	local v_u_115 = p113 or 0.5
	local v_u_116 = p_u_111.camera.FieldOfView
	local v_u_117 = 0
	task.spawn(function()
		-- upvalues: (ref) v_u_117, (copy) v_u_115, (copy) p_u_111, (copy) v_u_116, (copy) p_u_112, (copy) p_u_114
		while v_u_117 < v_u_115 do
			v_u_117 = v_u_117 + task.wait()
			local v118 = v_u_117 / v_u_115
			local v119 = 1 - (1 - math.min(v118, 1)) ^ 2
			p_u_111.camera.FieldOfView = v_u_116 + (p_u_112 - v_u_116) * v119
		end
		p_u_111.camera.FieldOfView = p_u_112
		if p_u_114 then
			p_u_114()
		end
	end)
end
function v_u_5.getDefaultFOV() -- name: getDefaultFOV
	return 70
end
function v_u_5.getTransitionFOVStart() -- name: getTransitionFOVStart
	return 1
end
function v_u_5.getBounds() -- name: getBounds
	return 2010, 2665, 2140, 2860
end
function v_u_5.getTreeOrigin() -- name: getTreeOrigin
	return Vector3.new(2500, 500, 2500)
end
return v_u_5