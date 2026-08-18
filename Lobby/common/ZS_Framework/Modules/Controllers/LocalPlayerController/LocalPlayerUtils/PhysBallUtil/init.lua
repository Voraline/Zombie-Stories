local v1 = script:WaitForChild("Utility")
local v2 = game.ReplicatedStorage.common:WaitForChild("Remotes")
local v_u_3 = require(v1:WaitForChild("Enums"))
local v_u_4 = v2:WaitForChild("initChasis")
local v_u_5 = game.Workspace.CurrentCamera
local v_u_6 = game.Workspace:WaitForChild("Terrain")
local function v_u_11(p7) -- name: initAttachments
	-- upvalues: (copy) v_u_6
	local v_u_8 = Instance.new("Attachment")
	v_u_8.Name = "diveAttachment"
	v_u_8.Parent = v_u_6
	local v9 = Instance.new("AlignPosition")
	v9.RigidityEnabled = true
	v9.Enabled = false
	v9.Attachment0 = p7.rootAttach
	v9.Attachment1 = v_u_8
	v9.Parent = p7.chasis
	local v10 = Instance.new("AlignOrientation")
	v10.RigidityEnabled = true
	v10.Enabled = false
	v10.Attachment0 = p7.rootAttach
	v10.Attachment1 = v_u_8
	v10.Parent = p7.chasis
	p7.humanoid.Died:Connect(function()
		-- upvalues: (copy) v_u_8
		v_u_8:Destroy()
	end)
	return v_u_8, v9, v10
end
local v12 = {}
local v_u_13 = {
	["__index"] = v12
}
function v12.new(p14) -- name: new
	-- upvalues: (copy) v_u_4, (copy) v_u_11, (copy) v_u_3, (copy) v_u_13
	local v_u_15 = {
		["control"] = require(p14:WaitForChild("PlayerScripts"):WaitForChild("ControlScript"):WaitForChild("MasterControl"))
	}
	local function v_u_20(p16) -- name: setupCharacter
		-- upvalues: (copy) v_u_15, (ref) v_u_4, (ref) v_u_11
		v_u_15.character = p16
		v_u_15.humanoid = v_u_15.character:WaitForChild("Humanoid")
		v_u_15.hrp = v_u_15.character:WaitForChild("HumanoidRootPart", 5)
		if v_u_15.hrp then
			v_u_15.rootAttach = v_u_15.hrp:WaitForChild("RootAttachment")
			v_u_15.loadingChasis = true
			v_u_4:InvokeServer(v_u_15.humanoid)
			v_u_15.chasis = v_u_15.character:WaitForChild("Vehicle")
			v_u_15.force = v_u_15.chasis:WaitForChild("VectorForce")
			v_u_15.force2 = v_u_15.chasis:WaitForChild("VectorForce2")
			v_u_15.loadingChasis = false
			v_u_15.chasisLoaded = true
			v_u_15.chasis.Anchored = true
			local v17, v18, v19 = v_u_11(v_u_15)
			v_u_15._mass = v_u_15.chasis:GetMass()
			v_u_15._worldAttach = v17
			v_u_15._alignPosition = v18
			v_u_15._alignOrientation = v19
			v_u_15._fullyInitialized = true
		end
	end
	v_u_15.character = p14.Character
	if v_u_15.character then
		v_u_20(v_u_15.character)
	end
	p14.CharacterAdded:Connect(function(p21)
		-- upvalues: (copy) v_u_20
		v_u_20(p21)
	end)
	v_u_15.isActive = false
	v_u_15.isGrounded = false
	v_u_15.floorMaterial = v_u_3.Material.Air
	v_u_15._floorNormal = Vector3.new(0, 1, 0)
	v_u_15._targetVelocity = Vector3.new(0, 0, 0)
	v_u_15._turnForce = Vector3.new(0, 0, 0)
	v_u_15._orientation = CFrame.new()
	v_u_15._mode = v_u_3.PhysBallType.Default
	v_u_15.acceleration = 1.25
	v_u_15.speed = 25
	v_u_15.jumpPower = 55
	v_u_15.air_drag_const = 0.2
	local v22 = v_u_13
	return setmetatable(v_u_15, v22)
end
function v12.Destroy(p23) -- name: Destroy
	p23._worldAttach:Destroy()
	p23.chasis:Destroy()
	p23.isActive = false
end
function v12.setActive(p24, p25, p26) -- name: setActive
	-- upvalues: (copy) v_u_3
	if p24.chasis.Parent then
		p24.chasis.Parent = p24.character
		p24.chasis.Anchored = not p25
		p24.chasis.CFrame = p24.hrp.CFrame
		p24.chasis.Velocity = Vector3.new()
		p24.hrp.Velocity = Vector3.new()
		p24._alignPosition.Enabled = p25
		p24._alignOrientation.Enabled = p25
		p24._orientation = p24.hrp.CFrame - p24.hrp.CFrame.p
		p24._mode = p26 or v_u_3.PhysBallType.Default
		p24.isActive = p25
	end
end
function v12.jump(p27) -- name: jump
	p27.chasis:ApplyImpulse(p27._floorNormal * 30 * (p27.isGrounded and 1 or 1.1))
end
function v12.update(p28, p29) -- name: update
	-- upvalues: (copy) v_u_3, (copy) v_u_5
	if not p28.isActive then
		if p28.hrp and p28.chasis then
			p28.chasis.CFrame = p28.hrp.CFrame
		end
		p28.slideVector = CFrame.new()
		return
	end
	local v30 = RaycastParams.new()
	v30.IgnoreWater = true
	v30.RespectCanCollide = true
	v30.FilterType = v_u_3.RaycastFilterType.Exclude
	v30.FilterDescendantsInstances = { p28.character, workspace.Ignore, workspace.Zombies }
	local v31 = p28.chasis.Size.Y / 2 + 0.2
	local v32 = workspace:Spherecast(p28.chasis.Position + Vector3.new(0, 0.25, 0), v31, Vector3.new(0, -0.25, 0), v30)
	local v33, v34, v35
	if v32 then
		v33 = v32.Instance
		v34 = v32.Normal
		v35 = v32.Material
	else
		v35 = nil
		v33 = nil
		v34 = Vector3.new(0, 1, 0)
	end
	local v36 = v32 and v32.Distance or 5
	p28.isGrounded = v36 <= 1.3
	p28._floorFriction = v35 and (PhysicalProperties.new(v35).Friction * 2 or 0) or 0
	p28._floorMaterial = v36 <= p28.humanoid.HipHeight and v35 and v35 or v_u_3.Material.Air
	local v37
	if v33 then
		if p28.isGrounded and v34 then
			v37 = v34
		else
			local v38 = p28._floorNormal
			local v39 = p29 * 5
			v37 = v38:Lerp(v34, (math.min(v39, 1)))
			if not v37 then
				goto l22
			end
		end
		::l25::
		p28._floorNormal = v37
		local v40 = (v_u_5.CFrame.lookVector * Vector3.new(1, 0, 1)).unit
		local v41 = CFrame.new(Vector3.new(0, 0, 0), v40)
		local v42 = v41:vectorToObjectSpace(p28._floorNormal)
		local v43 = -v42.X
		local v44 = v42.Y
		local v45 = math.atan2(v43, v44)
		local v46 = v42.Z
		local v47 = v42.Y
		local v48 = math.atan2(v46, v47)
		local v49 = v41 * (CFrame.Angles(v48, 0, 0) * CFrame.Angles(0, 0, v45)):Lerp(CFrame.Angles(0, 0, v45) * CFrame.Angles(v48, 0, 0), 0.5)
		local v50 = 0
		local v51 = p28.control:GetMoveVector()
		local v52 = v51.X
		local v53 = v51.Y
		local v54 = v51.Z < 0 and 0 or v51.Z
		local v55 = Vector3.new(v52, v53, v54)
		local v56 = p28.isGrounded
		local v57 = p28.chasis.Velocity
		local v58 = (Vector3.new(0, 1, 0)):Dot(p28._floorNormal)
		if p28._mode == v_u_3.PhysBallType.Default then
			v50 = p28.speed
			if v55:Dot(v55) > 0 then
				v55 = v55.unit or v55
			end
		elseif p28._mode == v_u_3.PhysBallType.Dive then
			local v59 = p28.speed
			local v60 = p28.chasis.Velocity.magnitude
			local v61 = math.min(v59, v60)
			v50 = (v58 < 1 or not p28.isGrounded) and v61 and v61 or v61 * 0.1
			v55 = v55:Dot(v55) > 0 and v55.unit or Vector3.new(0, 0, 0)
		end
		local v62 = p28.humanoid.MoveDirection:Dot(v57.unit) < 0.01
		local v63 = workspace.Camera.CFrame.LookVector * 10
		local v64 = v63.Y
		local v65 = v63 - Vector3.new(0, v64, 0)
		local v66 = -v57 * (p28.air_drag_const + p28._floorFriction)
		if v57.magnitude > 1 then
			local v67 = p28._orientation
			local v68 = CFrame.new(Vector3.new(), v57)
			local v69 = p29 * 10
			v78 = v67:lerp(v68, (math.min(v69, 1)))
			if v78 then
				::l48::
				p28._orientation = v78
				p28._turnForce = v49:vectorToWorldSpace(v55 * (v62 and 15 or 1) * v50)
				p28.force.Force = (v56 and p28._turnForce or Vector3.new()) + v66
				local v70 = CFrame.lookAt(p28.hrp.CFrame.p, p28.hrp.CFrame.p + v65)
				local v71 = v70 - v70.p
				local v72 = CFrame.new(p28.chasis.CFrame.p + Vector3.new(0, 0.6, 0)) * v71
				local v73 = v72:VectorToObjectSpace(v34)
				local v74 = CFrame.new().LookVector:Dot(CFrame.Angles(v73.z, 0, -v73.x).LookVector)
				p28.OnRamp = math.acos(v74) > 0.001
				if not p28.slideVector then
					p28.slideVector = CFrame.new()
				end
				local v75 = p28.slideVector
				local v76 = CFrame.Angles(v73.z, 0, -v73.x)
				local v77 = p29 * 10
				p28.slideVector = v75:lerp(v76, (math.min(v77, 1)))
				p28._worldAttach.CFrame = v72
				if p28._floorMaterial == v_u_3.Material.Water then
					p28.chasis.Anchored = true
				end
				return
			end
		end
		local v78 = p28._orientation
		goto l48
	else
		::l22::
		v37 = p28._floorNormal:Lerp(Vector3.new(0, 1, 0), (math.min(p29, 1)))
		goto l25
	end
end
return v12