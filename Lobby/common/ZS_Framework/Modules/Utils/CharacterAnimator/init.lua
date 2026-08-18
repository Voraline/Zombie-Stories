local v_u_1 = require(script:WaitForChild("Util"))
local v_u_2 = require(script:WaitForChild("R6IK"))
local v_u_3 = require(script.Parent:WaitForChild("SpringUtil"))
local v_u_4 = script:FindFirstChild("animations")
local v_u_5 = workspace.CurrentCamera
local v_u_6 = {}
v_u_6.__index = v_u_6
function v_u_6.new(p_u_7, p_u_8) -- name: new
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_3
	local v9 = v_u_6
	local v10 = setmetatable({}, v9)
	v10.character = p_u_7
	v10.isLocalPlayer = p_u_8
	v10.isDestroyed = false
	local v11, v12 = pcall(function()
		-- upvalues: (ref) v_u_2, (copy) p_u_7, (copy) p_u_8
		return v_u_2.New(p_u_7, p_u_8)
	end)
	if not v11 then
		warn("[CharacterAnimator] Failed to initialize IK:", v12)
		return nil
	end
	v10.ik = v12
	v10.hrp = v10.ik.HumanoidRootPart
	v10.torso = v10.ik.Torso
	v10.Humanoid = p_u_7:WaitForChild("Humanoid")
	v10.cycle = 0
	v10.cycleStep = 0.18
	v10.cycleReturnStep = 0.22
	v10.cycleOffset = 1
	v10.maxSpeed = 16
	v10.lookMax = 1.32
	v10.lookMaxDist = 0.6
	v10.lastPosition = nil
	v10.currentDirection = Vector3.new(0, 0, 10)
	v10.oldOrientation = nil
	v10.lastUpdate = os.clock()
	v10.lastLegUpdate = os.clock()
	v10.shuffleStart = os.clock()
	v10.shuffleEnd = os.clock()
	v10.lastMovingTime = 0
	v10.RootJointTransform = CFrame.new()
	v10.RootJointLeanCF = CFrame.new()
	v10.forwardSpring = v_u_3.new(0)
	v10.forwardSpring.Speed = 6
	v10.forwardSpring.Damper = 0.6
	v10.rightSpring = v_u_3.new(0)
	v10.rightSpring.Speed = 6
	v10.rightSpring.Damper = 0.6
	v10.aimTwist = v_u_3.new(0)
	v10.aimTwist.Speed = 9
	v10.aimTwist.Damper = 0.9
	v10.lookPitch = v_u_3.new(0)
	v10.lookPitch.Speed = 12
	v10.lookPitch.Damper = 0.85
	v10.larmNormal = v_u_3.new(1)
	v10.larmNormal.Speed = 8
	v10.larmNormal.Damper = 0.85
	v10.larmNormal.Target = 1
	v10.larmNormalStart = CFrame.new()
	v10.rarmNormal = v_u_3.new(1)
	v10.rarmNormal.Speed = 8
	v10.rarmNormal.Damper = 0.85
	v10.rarmNormal.Target = 1
	v10.rarmNormalStart = CFrame.new()
	v10.larmNormalTF = v_u_3.new(1)
	v10.larmNormalTF.Speed = 12
	v10.larmNormalTF.Damper = 0.9
	v10.larmNormalTF.Target = 1
	v10.rarmNormalTF = v_u_3.new(1)
	v10.rarmNormalTF.Speed = 12
	v10.rarmNormalTF.Damper = 0.9
	v10.rarmNormalTF.Target = 1
	v10.armDirection = 0
	v10.legVars = {}
	v10.isMoving = false
	v10.doingShuffle = false
	v10.stoodStill = true
	v10.hadRaycastResult = false
	v10.isSprinting = false
	v10.isJogging = false
	v10.isProning = false
	v10.isCrouching = false
	v10.isSliding = false
	v10.isDiving = false
	v10.isClimbing = false
	v10.isAiming = false
	v10.isGrounded = true
	v10.isDowned = false
	v10.isDead = false
	v10.ikEnabled = true
	v10.lookPoint = Vector3.new(0, 0, 0)
	v10.runWeight = v_u_3.new(0)
	v10.runWeight.Speed = 8
	v10.runWeight.Damper = 0.9
	v10:setupAnimator()
	v10.raycastParams = nil
	v10.cachedFloorY = nil
	v10.lastRaycastPos = nil
	return v10
end
function v_u_6.SetRaycastParams(p13, p14) -- name: SetRaycastParams
	p13.raycastParams = p14
end
function v_u_6.setupAnimator(p_u_15) -- name: setupAnimator
	-- upvalues: (copy) v_u_4
	if v_u_4 then
		p_u_15.animator = p_u_15.Humanoid:FindFirstChildOfClass("Animator")
		if not p_u_15.animator then
			p_u_15.animator = Instance.new("Animator")
			p_u_15.animator.Parent = p_u_15.Humanoid
		end
		p_u_15.animTracks = {}
		local v16 = v_u_4:FindFirstChild("run")
		local v17 = v_u_4:FindFirstChild("jump")
		local v18 = v_u_4:FindFirstChild("fall")
		local v19 = v_u_4:FindFirstChild("climb")
		if v16 and v16:IsA("Animation") then
			p_u_15.animTracks.run = p_u_15.animator:LoadAnimation(v16)
			p_u_15.animTracks.run.Priority = Enum.AnimationPriority.Movement
			p_u_15.animTracks.run.Looped = true
		else
			warn("[CharacterAnimator] Run animation not found or invalid")
		end
		if v17 and v17:IsA("Animation") then
			p_u_15.animTracks.jump = p_u_15.animator:LoadAnimation(v17)
			p_u_15.animTracks.jump.Priority = Enum.AnimationPriority.Action
			p_u_15.animTracks.jump.Looped = false
		end
		if v18 and v18:IsA("Animation") then
			p_u_15.animTracks.fall = p_u_15.animator:LoadAnimation(v18)
			p_u_15.animTracks.fall.Priority = Enum.AnimationPriority.Action
			p_u_15.animTracks.fall.Looped = true
		end
		if v19 and v19:IsA("Animation") then
			p_u_15.animTracks.climb = p_u_15.animator:LoadAnimation(v19)
			p_u_15.animTracks.climb.Priority = Enum.AnimationPriority.Action
			p_u_15.animTracks.climb.Looped = true
		end
		local v20 = v_u_4:FindFirstChild("walk")
		local v21 = v_u_4:FindFirstChild("idle")
		if v20 and v20:IsA("Animation") then
			p_u_15.animTracks.walk = p_u_15.animator:LoadAnimation(v20)
			p_u_15.animTracks.walk.Priority = Enum.AnimationPriority.Movement
			p_u_15.animTracks.walk.Looped = true
		end
		if v21 and v21:IsA("Animation") then
			p_u_15.animTracks.idle = p_u_15.animator:LoadAnimation(v21)
			p_u_15.animTracks.idle.Priority = Enum.AnimationPriority.Idle
			p_u_15.animTracks.idle.Looped = true
			p_u_15.animTracks.idle:Play()
		end
		p_u_15._isFalling = false
		p_u_15._isJumping = false
		p_u_15._connections = {}
		local v22 = p_u_15._connections
		local v23 = p_u_15.Humanoid.Jumping
		table.insert(v22, v23:Connect(function()
			-- upvalues: (copy) p_u_15
			p_u_15._isJumping = true
			if p_u_15.animTracks.jump then
				p_u_15.animTracks.jump:Play(0.1)
			end
		end))
		local v24 = p_u_15._connections
		local v25 = p_u_15.Humanoid.StateChanged
		table.insert(v24, v25:Connect(function(_, p26)
			-- upvalues: (copy) p_u_15
			if p26 == Enum.HumanoidStateType.Freefall then
				if not p_u_15._isFalling then
					p_u_15._isFalling = true
					if p_u_15.animTracks.jump then
						p_u_15.animTracks.jump:Stop(0.1)
					end
					if p_u_15.animTracks.fall then
						p_u_15.animTracks.fall:Play(0.2)
						return
					end
				end
			elseif (p26 == Enum.HumanoidStateType.Landed or p26 == Enum.HumanoidStateType.Running) and (p_u_15._isFalling or p_u_15._isJumping) then
				p_u_15._isFalling = false
				p_u_15._isJumping = false
				if p_u_15.animTracks.jump then
					p_u_15.animTracks.jump:Stop(0.1)
				end
				if p_u_15.animTracks.fall then
					p_u_15.animTracks.fall:Stop(0.2)
				end
			end
		end))
	else
		warn("[CharacterAnimator] No animations folder found")
	end
end
function v_u_6.SetState(p27, p28) -- name: SetState
	if p28 then
		p27.States = p28
		p27.isSprinting = p28.Sprinting or false
		p27.isJogging = p28.Jogging or false
		p27.isProning = p28.Proning or false
		p27.isCrouching = p28.Crouching or false
		p27.isSliding = p28.Sliding or false
		p27.isDiving = p28.Diving or false
		p27.isAiming = p28.Aiming or false
		p27.isGrounded = not p27.Humanoid or p27.Humanoid.FloorMaterial ~= Enum.Material.Air
		p27.isClimbing = p27.Humanoid and p27.Humanoid:GetState() == Enum.HumanoidStateType.Climbing and true or false
		p27.isDowned = p28.IsDowned or false
		p27.isDead = p28.IsDead or false
	end
end
function v_u_6.SetLookPoint(p29, p30) -- name: SetLookPoint
	p29.lookPoint = p30
end
function v_u_6.SetYaw(p31, p32) -- name: SetYaw
	p31.directYaw = p32
end
function v_u_6.Heartbeat(_, _) -- name: Heartbeat end
function v_u_6.UpdateStepped(p33, p34) -- name: UpdateStepped
	-- upvalues: (copy) v_u_5
	if p33.isDestroyed then
		return
	elseif p33.character.Parent and (p33.hrp.Parent and p33.torso.Parent) then
		if p33.ikEnabled then
			if p33.isProning or (p33.isSliding or (p33.isDiving or (p33.isClimbing or (p33.isDowned or p33.isDead)))) then
				p33.ik.Motor6Ds.Neck.C0 = p33.ik.C0s.Neck
			else
				local v35 = p34 * 20
				local v36 = math.clamp(v35, 0, 1)
				local v37 = CFrame.new
				local v38 = p33.cycle
				local v39 = v37(0, 0, math.sin(v38) * 0.01)
				if p33.isMoving and p33.cycle > 0 then
					local v40 = CFrame.Angles
					local v41 = p33.cycle
					local v42 = v39 * v40(0, 0, math.sin(v41) * 0.08)
					local v43 = CFrame.new
					local v44 = p33.cycle * p33.cycleOffset
					v39 = v42 * v43(0, 0, math.sin(v44) * 0.1)
				end
				p33.aimTwist.Target = p33.isAiming and 1 or 0
				local v45 = v39 * CFrame.new():Lerp(CFrame.Angles(0, 0, -0.6108652381980153), p33.aimTwist.Position)
				local v46 = p33.ik.Motor6Ds.Neck
				local v47 = p33.ik.C0s.Neck
				local v48 = CFrame.new():Lerp(CFrame.Angles(0, 0, 0.6108652381980153), p33.aimTwist.Position)
				local v49 = 0
				local v50 = 0
				if p33.lookPoint and (p33.lookPoint ~= Vector3.new(0, 0, 0) and not p33.isLocalPlayer) then
					local v51 = p33.ik.Head
					local v52 = p33.hrp.CFrame
					local v53 = (v51.CFrame.Position - p33.lookPoint).Magnitude
					local v54 = (v51.CFrame.Y - p33.lookPoint.Y) / v53
					local v55 = -math.atan(v54)
					p33.lookPitch.Target = v55
					v49 = p33.lookPitch.Position
					if p33.directYaw and p33.directYaw ~= 0 then
						v50 = p33.directYaw * 0.8
					else
						v50 = (p33.lookPoint - v51.Position).Unit:Cross(v52.LookVector).Y * 0.8
					end
				elseif p33.isLocalPlayer then
					local v56 = v_u_5.CFrame:ToEulerAnglesYXZ()
					p33.lookPitch.Target = v56
					v49 = p33.lookPitch.Position
					local v57 = p33.hrp.CFrame
					v50 = (v_u_5.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit:Cross((v57.LookVector * Vector3.new(1, 0, 1)).Unit).Y * 0.8
				end
				if v49 == 0 and v50 == 0 then
					v46.Transform = v46.Transform * v48
				else
					local v58 = v49 * 0.6
					local v59 = -v49 * 0.4
					local v60 = 1 - p33.aimTwist.Position * 0.9
					local v61 = -v50 * v60
					local v62 = CFrame.Angles(v58, v61, 0)
					v46.C0 = v46.C0:lerp(v62 * v47, 0.25).Rotation + v47.Position
					v46.Transform = v46.Transform * v48
					v45 = v45 * CFrame.Angles(v59, 0, 0)
				end
				local v63
				if p33.isAiming then
					v63 = CFrame.new()
				else
					v63 = CFrame.Angles(0.06981317007977318 * p33.forwardSpring.Position, 0.06981317007977318 * -p33.rightSpring.Position, 0)
				end
				p33.RootJointLeanCF = p33.RootJointLeanCF:Lerp(v63, v36)
				local v64 = v45 * p33.RootJointLeanCF
				p33.RootJointTransform = p33.RootJointTransform:Lerp(v64, v36)
				local v65 = 1 - p33.runWeight.Position
				if v65 > 0.01 then
					local v66 = CFrame.new():Lerp(p33.RootJointTransform, v65)
					local v67 = p33.ik.Motor6Ds.RootJoint
					v67.Transform = v67.Transform * v66
				end
				local v68 = p33.ik.Motor6Ds["Left Shoulder"]
				local v69 = p33.ik.Motor6Ds["Right Shoulder"]
				if not p33.leftArmControlledByViewmodel then
					local v70 = v68.Transform
					v68.Transform = CFrame.new():Lerp(v70, p33.larmNormalTF.Position)
				end
				if not p33.rightArmControlledByViewmodel then
					local v71 = v69.Transform
					v69.Transform = CFrame.new():Lerp(v71, p33.rarmNormalTF.Position)
				end
			end
		else
			return
		end
	else
		return
	end
end
function v_u_6.UpdateDistantAnimation(p72, p73, p74) -- name: UpdateDistantAnimation
	local v75 = p72.animTracks
	if v75 then
		v75 = p72.animTracks.walk
	end
	local v76 = p72.animTracks
	if v76 then
		v76 = p72.animTracks.idle
	end
	if p73 and p74 > 2 then
		if v75 and not v75.IsPlaying then
			v75:Play(0.2)
		end
		if v76 and v76.IsPlaying then
			v76:Stop(0.2)
		end
		if v75 then
			local v77 = p74 / 16
			v75:AdjustSpeed((math.clamp(v77, 0.5, 1.5)))
		end
	else
		if v76 and not v76.IsPlaying then
			v76:Play(0.2)
		end
		if v75 and v75.IsPlaying then
			v75:Stop(0.2)
		end
	end
	if not p72._distantLegsReset then
		p72._distantLegsReset = true
		p72.ik.Motor6Ds["Left Hip"].C0 = p72.ik.C0s["Left Hip"]
		p72.ik.Motor6Ds["Right Hip"].C0 = p72.ik.C0s["Right Hip"]
		p72.cachedFloorY = nil
		p72.lastRaycastPos = nil
	end
end
function v_u_6.UpdateRenderStepped(p78, p79, p80) -- name: UpdateRenderStepped
	-- upvalues: (copy) v_u_1
	if p78.isDestroyed then
		return
	elseif p78.character.Parent and (p78.hrp.Parent and p78.torso.Parent) then
		local v81 = os.clock()
		if p78._lastRenderTime and v81 - p78._lastRenderTime < 0.001 then
			return
		else
			p78._lastRenderTime = v81
			if p78.isProning or (p78.isSliding or (p78.isDiving or (p78.isCrouching or (p78.isClimbing or (p78.isDowned or p78.isDead))))) then
				if not p78._limbsReset then
					p78._limbsReset = true
					p78.cycle = 0
					local v82 = p78.animTracks
					if v82 then
						v82 = p78.animTracks.run
					end
					if v82 and v82.IsPlaying then
						v82:Stop(0.2)
						p78._wasRunning = false
					end
					local v83 = p78.animTracks
					if v83 then
						v83 = p78.animTracks.walk
					end
					if v83 and v83.IsPlaying then
						v83:Stop(0.2)
					end
					local v84 = p78.animTracks
					if v84 then
						v84 = p78.animTracks.climb
					end
					if p78.isClimbing and (v84 and not v84.IsPlaying) then
						v84:Play(0.2)
					end
					p78.ik.Motor6Ds["Left Hip"].C0 = p78.ik.C0s["Left Hip"]
					p78.ik.Motor6Ds["Right Hip"].C0 = p78.ik.C0s["Right Hip"]
					p78.ik.Motor6Ds.Neck.C0 = p78.ik.C0s.Neck
					p78.ik.Motor6Ds["Left Shoulder"].C0 = p78.ik.C0s["Left Shoulder"]
					p78.ik.Motor6Ds["Right Shoulder"].C0 = p78.ik.C0s["Right Shoulder"]
					p78.ik.Motor6Ds["Left Shoulder"].C1 = p78.ik.C1s["Left Shoulder"]
					p78.ik.Motor6Ds["Right Shoulder"].C1 = p78.ik.C1s["Right Shoulder"]
					for _, v85 in p78.legVars do
						v85.finalGoal = nil
						v85.cachedHipC0 = nil
						v85.oldGoal = nil
						v85.rotateDelta = 0
					end
					p78.doingShuffle = false
					p78.cachedFloorY = nil
					p78.lastRaycastPos = nil
				end
				if p78.isClimbing then
					local v86 = p78.animTracks
					if v86 then
						v86 = p78.animTracks.climb
					end
					if v86 and v86.IsPlaying then
						local v87 = p78.hrp.AssemblyLinearVelocity.Y
						local v88 = math.abs(v87)
						if v88 > 0.5 then
							v86:AdjustSpeed(v88 / 8)
							return
						end
						v86:AdjustSpeed(1e-7)
					end
				end
				return
			else
				if p78._limbsReset then
					local v89 = p78.animTracks
					if v89 then
						v89 = p78.animTracks.climb
					end
					if v89 and v89.IsPlaying then
						v89:Stop(0.2)
					end
				end
				p78._limbsReset = false
				local v90 = math.clamp(p79, 0.001, 0.1)
				local v91 = v90 * 60
				local v92 = v90 * 10
				local v93 = math.clamp(v92, 0, 1)
				local v94 = p78.torso.CFrame
				local v95 = p78.hrp.CFrame
				local v96 = v95.Position
				local v97 = p78.hrp.Orientation
				if not p78.oldOrientation then
					p78.oldOrientation = v97
				end
				local v98 = p78.oldOrientation
				local v99 = p78.hrp.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
				local v100 = v99.Magnitude
				local v101 = v99.Unit
				if v101 ~= v101 then
					v101 = v94.LookVector.Unit
				end
				local v102 = p78.lastPosition or v96
				p78.lastPosition = v96
				local v103 = (v96 - v102) * Vector3.new(1, 0, 1)
				if v103 ~= v103 then
					Vector3.new()
				end
				local v104 = v100 > 2
				p78.isMoving = v104
				if p78.ikEnabled then
					local v105 = "full"
					if not p78.isLocalPlayer and p80 then
						v105 = p80 > 30 and "animation" or (p80 > 15 and "reduced" or v105)
					end
					if v105 == "animation" then
						p78:UpdateDistantAnimation(v104, v100)
						return
					else
						if p78._distantLegsReset then
							p78._distantLegsReset = false
							local v106 = p78.animTracks
							if v106 then
								v106 = p78.animTracks.walk
							end
							local v107 = p78.animTracks
							if v107 then
								v107 = p78.animTracks.idle
							end
							if v106 and v106.IsPlaying then
								v106:Stop(0.2)
							end
							if v107 and v107.IsPlaying then
								v107:Stop(0.2)
							end
						end
						local v108 = p78.isGrounded
						local v109 = p78.isSprinting and v104
						local v110 = os.clock()
						if v104 and (v108 and not v109) then
							p78.lastMovingTime = v110
							local v111 = v100 / p78.maxSpeed
							local v112 = math.clamp(v111, 0, 1)
							p78.cycle = p78.cycle + p78.cycleStep * v112 * v91
							p78.cycle = p78.cycle % 6.283185307179586
							p78.stoodStill = false
						elseif v110 - p78.lastMovingTime > 0.1 then
							if p78.cycle < 1.5707963267948966 then
								local v113 = p78.cycle - p78.cycleReturnStep * v91
								p78.cycle = math.max(v113, 0)
							elseif p78.cycle < 3.141592653589793 then
								local v114 = p78.cycle + p78.cycleReturnStep * v91
								p78.cycle = math.min(v114, 3.141592653589793)
							elseif p78.cycle < 4.71238898038469 then
								local v115 = p78.cycle - p78.cycleReturnStep * v91
								p78.cycle = math.max(v115, 3.141592653589793)
							else
								p78.cycle = p78.cycle + p78.cycleReturnStep * v91
								if p78.cycle >= 6.283185307179586 then
									p78.cycle = 0
								end
							end
						end
						local v116 = v109 and ((p78._isFalling or p78._isJumping) and 0.35 or 1) or 0
						p78.runWeight.Target = v116
						local v117 = p78.animTracks
						if v117 then
							v117 = p78.animTracks.run
						end
						if v117 then
							if v109 ~= p78._wasRunning then
								if v109 then
									p78.cycle = 0
									v117:Play(0.2)
									p78.ik.Motor6Ds["Left Hip"].C0 = p78.ik.C0s["Left Hip"]
									p78.ik.Motor6Ds["Right Hip"].C0 = p78.ik.C0s["Right Hip"]
								else
									v117:Stop(0.2)
									p78.ik.Motor6Ds["Left Hip"].C0 = p78.ik.C0s["Left Hip"]
									p78.ik.Motor6Ds["Right Hip"].C0 = p78.ik.C0s["Right Hip"]
								end
								p78._wasRunning = v109
							end
							if v117.IsPlaying then
								v117:AdjustWeight(p78.runWeight.Position, 0.05)
								local v118 = v100 / 19
								local v119 = math.clamp(v118, 0.5, 1.5)
								if v95.LookVector:Dot(v101) < -0.3 and p78.isLocalPlayer then
									v119 = -v119
								end
								v117:AdjustSpeed(v119)
							end
						end
						local v120 = v95.LookVector.Unit:Dot(v101)
						local v121 = (v120 ~= v120 or not v104) and 0 or v120
						local v122 = v95.RightVector.Unit:Dot(v101)
						local v123 = (v122 ~= v122 or not v104) and 0 or v122
						p78.forwardSpring.Target = v121
						p78.rightSpring.Target = v123
						p78.armDirection = v_u_1:lerp(p78.armDirection, p78.forwardSpring.Position < 0 and -1 or 1, v93)
						p78.cycleOffset = v_u_1:lerp(p78.cycleOffset, v108 and v104 and 2 or 1, v93)
						p78.currentDirection = v_u_1:rotateAround(p78.currentDirection, v101, 10, v90, 3)
						local v124 = CFrame.new(v94.Position, v94.Position + p78.currentDirection)
						local v125 = os.clock()
						local v126 = v105 == "reduced" and 30 or 120
						if v125 - p78.lastLegUpdate >= 1 / v126 then
							p78.lastLegUpdate = v125
							for v127, v128 in { "Right", "Left" } do
								local v129 = p78.cycle
								if not p78.legVars[v128] then
									p78.legVars[v128] = {
										["lastLookVector"] = nil,
										["lastLookVectorDelta"] = nil,
										["rotateDelta"] = 0,
										["lastLookVector"] = v95.RightVector.Unit,
										["lastLookVectorDelta"] = v95.RightVector.Unit
									}
								end
								local v130 = p78.legVars[v128]
								if v128 == "Left" then
									v129 = v129 + 3.141592653589793
									if v129 > 6.283185307179586 then
										v129 = v129 - 6.283185307179586
									end
								end
								if v128 == "Left" and not p78.leftArmControlledByViewmodel then
									local v131 = p78.ik.C0s["Left Shoulder"]
									local v132 = CFrame.Angles
									local v133 = -p78.rightSpring.Position * 0.1 * p78.armDirection
									local v134 = p78.cycle
									local v135 = v131 * v132(v133, -math.sin(v134) * 0.05 * p78.armDirection, -math.sin(v129) * 0.5 * p78.armDirection)
									p78.ik.Motor6Ds["Left Shoulder"].C0 = p78.larmNormalStart:Lerp(v135, p78.larmNormal.Position)
									p78.ik.Motor6Ds["Left Shoulder"].C1 = CFrame.Angles(0, 0, 0):Lerp(CFrame.new(0.5, 0.5, 0) * CFrame.Angles(0, -1.5707963267948966, 0), p78.larmNormal.Position)
								elseif v128 == "Right" and not p78.rightArmControlledByViewmodel then
									local v136 = p78.ik.C0s["Right Shoulder"]
									local v137 = CFrame.Angles
									local v138 = p78.rightSpring.Position * 0.1 * p78.armDirection
									local v139 = -p78.cycle
									local v140 = v136 * v137(v138, -math.sin(v139) * 0.05 * p78.armDirection, math.sin(v129) * 0.5 * p78.armDirection)
									p78.ik.Motor6Ds["Right Shoulder"].C0 = p78.rarmNormalStart:Lerp(v140, p78.rarmNormal.Position)
									p78.ik.Motor6Ds["Right Shoulder"].C1 = CFrame.Angles(0, 0, 0):Lerp(CFrame.new(-0.5, 0.5, 0) * CFrame.Angles(0, 1.5707963267948966, 0), p78.rarmNormal.Position)
								end
								local v141 = v94.RightVector.Unit
								local _ = v94.LookVector.Unit
								local v142 = v94.Position + Vector3.new(0, -3.15, 0) + v141 * (0.5 * (v127 == 2 and -1 or 1))
								local v143 = CFrame.new
								local v144 = v129 / p78.cycleOffset
								local v145 = v124 * v143(0, math.sin(v144) * 0.6 + -3.15, math.sin(v129) * 1.03).Position + v141 * (0.5 * (v127 == 2 and -1 or 1))
								local _ = CFrame.new(v145, v145 + p78.currentDirection).Position
								local v146
								if v104 or not (v108 and (p78.hadRaycastResult or p78.doingShuffle)) then
									v130.finalGoal = nil
									if v108 then
										v146 = v145
									else
										v130.rotateDelta = 0
										v146 = v145
									end
								else
									if (v128 == "Left" and p78.cycleOffset <= 1.05 or v128 == "Right" and p78.cycle <= 0) and not v130.finalGoal then
										v130.finalGoal = v145
									end
									if v130.finalGoal then
										v146 = v130.finalGoal
									else
										v146 = v145
									end
								end
								local _ = (v97.Y - v98.Y) / 180
								local v147 = (v130.lastLookVectorDelta - v95.LookVector.Unit).Magnitude
								local v148 = v130.lastLookVectorDelta:Cross(v95.LookVector.Unit):Dot(Vector3.new(0, 1, 0))
								v130.lastLookVectorDelta = v95.LookVector.Unit
								if v148 < -0.01 then
									v147 = v147 * -1
								end
								v130.rotateDelta = v130.rotateDelta + v147
								if v104 then
									v130.rotateDelta = 0
									v130.lastLookVector = v95.RightVector.Unit
								else
									local v149 = v130.rotateDelta
									local v150 = p78.lookMax
									local v151 = v149 / v150
									if v127 == 1 then
										v151 = v151 * -1
									end
									if (v149 < 0 and v151 <= -0.1 and true or (v151 >= 0.1 and v149 > 0 and true or false)) and (not p78.doingShuffle and math.abs(v149) > v150 - 0.2) or not p78.doingShuffle and ((v145 - v146).Magnitude >= p78.lookMaxDist or not p78.stoodStill and (v100 < 1 and (v145 * Vector3.new(1, 0, 1) - v146 * Vector3.new(1, 0, 1)).Magnitude >= 0.3)) then
										if v100 < 1 then
											p78.stoodStill = true
										end
										p78.doingShuffle = true
										v130.isPrimaryLeg = true
										p78.shuffleStart = os.clock()
										p78.shuffleEnd = p78.shuffleStart + 0.4
									end
									if p78.doingShuffle then
										if not v130.distanceFromStable then
											v130.distanceFromStable = (v145 - v146).Magnitude
										end
										p78.oldOrientation = p78.hrp.Orientation
										local _ = p78.shuffleEnd - os.clock()
										local v152 = (os.clock() - p78.shuffleStart) / (p78.shuffleEnd - p78.shuffleStart)
										if v152 >= 1 then
											p78.doingShuffle = false
											for _, v153 in p78.legVars do
												v153.lastLookVector = v95.RightVector.Unit
												v153.oldGoal = nil
												v153.isPrimaryLeg = nil
												v153.lookStrength = nil
												v153.distanceFromStable = nil
											end
										elseif v152 <= 0.5 and v130.isPrimaryLeg or v152 > 0.5 and not v130.isPrimaryLeg then
											if v152 > 0.5 then
												v152 = v152 - 0.5
											end
											if not v130.oldGoal then
												v130.oldGoal = v146
												v130.legUpDirection = p78.ik.Part1s[v128 .. " Hip"].CFrame.UpVector.Unit
											end
											if not v130.lookStrength then
												v130.lookStrength = math.abs(v149) / v150
											end
											v130.rotateDelta = 0
											v130.finalGoal = nil
											v130.lastLookVector = v95.RightVector.Unit
											local v154 = v130.oldGoal:Lerp(v145, v152 * 2)
											local v155 = v130.legUpDirection
											local v156 = 3.141592653589793 * (v152 * 2)
											local v157 = v155 * math.sin(v156)
											local v158 = 0.45 * v130.lookStrength
											v146 = v154 + v157 * math.clamp(v158, 0.25, 0.3)
										elseif v152 > 0.5 and v130.isPrimaryLeg then
											v130.lastLookVector = v95.RightVector.Unit
										end
									end
								end
								local v159 = not p78.raycastParams or p78.isLocalPlayer
								if not v159 then
									if v105 == "full" then
										v159 = not v104
									else
										v159 = false
									end
								end
								if v159 then
									local v160 = v95 * CFrame.new(0, -1, 0) + v141 * (0.5 * (v127 == 2 and -1 or 1))
									local v161 = workspace:Raycast(v160.Position, v146 - v160.Position, p78.raycastParams)
									p78.hadRaycastResult = v161 ~= nil
									if v161 then
										v146 = v161.Position
										if not p78.isLocalPlayer then
											p78.cachedFloorY = v161.Position.Y
											p78.lastRaycastPos = v96
										end
										if not p78.isLocalPlayer then
											local v162 = v146 * Vector3.new(1, 0, 1)
											local v163 = v142.Y
											v146 = v162 + Vector3.new(0, v163, 0)
										end
									end
								elseif v105 == "reduced" and (not v104 and p78.cachedFloorY) then
									if (v96 - (p78.lastRaycastPos or v96)).Magnitude < 2 then
										local v164 = v146.X
										local v165 = p78.cachedFloorY
										local v166 = v146.Z
										v146 = Vector3.new(v164, v165, v166)
									else
										local v167 = v95 * CFrame.new(0, -1, 0) + v141 * (0.5 * (v127 == 2 and -1 or 1))
										local v168 = workspace:Raycast(v167.Position, v146 - v167.Position, p78.raycastParams)
										if v168 then
											p78.cachedFloorY = v168.Position.Y
											p78.lastRaycastPos = v96
											local v169 = v146.X
											local v170 = p78.cachedFloorY
											local v171 = v146.Z
											v146 = Vector3.new(v169, v170, v171)
										end
									end
								end
								if v108 then
									v142 = v146
								end
								if not v109 then
									p78.ik:LegIK(v128, v142)
								end
							end
						end
					end
				else
					p78:UpdateDistantAnimation(v104, v100)
					return
				end
			end
		end
	else
		return
	end
end
function v_u_6.SetIKEnabled(p172, p173) -- name: SetIKEnabled
	if p172.ikEnabled == p173 then
		return
	else
		p172.ikEnabled = p173
		if p173 then
			p172._distantLegsReset = false
			local v174 = p172.animTracks
			if v174 then
				v174 = p172.animTracks.walk
			end
			local v175 = p172.animTracks
			if v175 then
				v175 = p172.animTracks.idle
			end
			if v174 and v174.IsPlaying then
				v174:Stop(0.2)
			end
			if v175 and v175.IsPlaying then
				v175:Stop(0.2)
			end
		else
			p172.cycle = 0
			p172.ik.Motor6Ds["Left Hip"].C0 = p172.ik.C0s["Left Hip"]
			p172.ik.Motor6Ds["Right Hip"].C0 = p172.ik.C0s["Right Hip"]
			p172.ik.Motor6Ds.Neck.C0 = p172.ik.C0s.Neck
			p172.ik.Motor6Ds["Left Shoulder"].C0 = p172.ik.C0s["Left Shoulder"]
			p172.ik.Motor6Ds["Right Shoulder"].C0 = p172.ik.C0s["Right Shoulder"]
			p172.ik.Motor6Ds["Left Shoulder"].C1 = p172.ik.C1s["Left Shoulder"]
			p172.ik.Motor6Ds["Right Shoulder"].C1 = p172.ik.C1s["Right Shoulder"]
			for _, v176 in p172.legVars do
				v176.finalGoal = nil
				v176.cachedHipC0 = nil
				v176.oldGoal = nil
				v176.rotateDelta = 0
			end
			p172.doingShuffle = false
			p172.cachedFloorY = nil
			p172.lastRaycastPos = nil
			local v177 = p172.animTracks
			if v177 then
				v177 = p172.animTracks.run
			end
			if v177 and v177.IsPlaying then
				v177:Stop(0.2)
				p172._wasRunning = false
			end
			local v178 = p172.animTracks
			if v178 then
				v178 = p172.animTracks.idle
			end
			if v178 and not v178.IsPlaying then
				v178:Play(0.2)
			end
			p172._distantLegsReset = true
		end
	end
end
function v_u_6.SetWeaponEquipped(p179, p180) -- name: SetWeaponEquipped
	p179.hasWeaponEquipped = p180
	if p180 then
		p179.leftArmControlledByViewmodel = true
		p179.rightArmControlledByViewmodel = true
	else
		p179.leftArmControlledByViewmodel = false
		p179.rightArmControlledByViewmodel = false
	end
end
function v_u_6.SetArmControl(p181, p182, p183) -- name: SetArmControl
	p181.leftArmControlledByViewmodel = p182
	p181.rightArmControlledByViewmodel = p183
end
function v_u_6.GetAimTwist(p184) -- name: GetAimTwist
	return p184.aimTwist.Position
end
function v_u_6.GetAimTwistAngle(p185) -- name: GetAimTwistAngle
	return 0.6108652381980153 * p185.aimTwist.Position
end
function v_u_6.Destroy(p186) -- name: Destroy
	p186.isDestroyed = true
	if p186._connections then
		for _, v187 in pairs(p186._connections) do
			v187:Disconnect()
		end
		p186._connections = nil
	end
	if p186.animTracks then
		for _, v188 in pairs(p186.animTracks) do
			if v188.IsPlaying then
				v188:Stop(0.05)
			end
		end
		p186.animTracks = nil
	end
	p186.animator = nil
	p186.character = nil
	p186.ik = nil
end
return v_u_6