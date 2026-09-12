local Util = require(script:WaitForChild("Util"))
local R6IK = require(script:WaitForChild("R6IK"))
local SpringUtil = require(script.Parent:WaitForChild("SpringUtil"))
local animations = script:FindFirstChild("animations")
local CurrentCamera = workspace.CurrentCamera

local function UpdateC0IfChanged(p1, p2, p3) -- Line: 34
    local v1, v2
    local C0 = p1.C0
    if not p3 then
        v1 = 0.005
    else
        v1 = 0.001
    end
    if not p3 then
        v2 = 0.005
    else
        v2 = 0.001
    end
    if v1 < (p2.Position - C0.Position).Magnitude then
        p1.C0 = p2
        return true
    end
    local LookVector = C0.LookVector
    local LookVector_2 = p2.LookVector
    local v3 = 1 - LookVector:Dot(LookVector_2)
    local UpVector_2 = C0.UpVector
    local UpVector = p2.UpVector
    local v4 = 1 - (UpVector_2:Dot(UpVector))
    if not (v2 < v3) and not (v2 < v4) then
        return false
    end
    p1.C0 = p2
    return true
end

local u30 = {}
u30.__index = u30

function u30.new(p1, p2) -- Line: 62 -- upvalues: u30 (val), R6IK (val), SpringUtil (val)
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        Humanoid = p1:WaitForChild("Humanoid", 5)
    end
    if Humanoid and Humanoid:IsA("Humanoid") then
        if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
            warn("[CharacterAnimator] Procedural animation only supports R6; skipping rig:", Humanoid.RigType.Name)
            return nil
        end
        local v1 = u30
        local v2 = setmetatable({}, v1)
        v2.character = p1
        v2.isLocalPlayer = p2
        v2.isDestroyed = false
        local success, result = pcall(function() -- Line: 80 -- upvalues: R6IK (upval), p1 (val), p2 (val)
            return R6IK.New(p1, p2)
        end)
        if not success then
            warn("[CharacterAnimator] Failed to initialize IK:", result)
            return nil
        end
        v2.ik = result
        v2.hrp = v2.ik.HumanoidRootPart
        v2.torso = v2.ik.Torso
        v2.Humanoid = Humanoid
        v2.cycle = 0
        v2.cycleStep = 0.18
        v2.cycleReturnStep = 0.22
        v2.cycleOffset = 1
        v2.maxSpeed = 16
        v2.lookMax = 1.32
        v2.lookMaxDist = 0.6
        v2.lastPosition = nil
        v2.currentDirection = Vector3.new(0, 0, 10)
        v2.oldOrientation = nil
        v2.lastUpdate = os.clock()
        v2.lastLegUpdate = os.clock()
        v2.shuffleStart = os.clock()
        v2.shuffleEnd = os.clock()
        v2.lastMovingTime = 0
        v2.RootJointTransform = CFrame.new()
        v2.RootJointLeanCF = CFrame.new()
        v2.forwardSpring = SpringUtil.new(0)
        v2.forwardSpring.Speed = 6
        v2.forwardSpring.Damper = 0.6
        v2.rightSpring = SpringUtil.new(0)
        v2.rightSpring.Speed = 6
        v2.rightSpring.Damper = 0.6
        v2.aimTwist = SpringUtil.new(0)
        v2.aimTwist.Speed = 9
        v2.aimTwist.Damper = 0.9
        v2.lookPitch = SpringUtil.new(0)
        v2.lookPitch.Speed = 12
        v2.lookPitch.Damper = 0.85
        v2.larmNormal = SpringUtil.new(1)
        v2.larmNormal.Speed = 8
        v2.larmNormal.Damper = 0.85
        v2.larmNormal.Target = 1
        v2.larmNormalStart = CFrame.new()
        v2.rarmNormal = SpringUtil.new(1)
        v2.rarmNormal.Speed = 8
        v2.rarmNormal.Damper = 0.85
        v2.rarmNormal.Target = 1
        v2.rarmNormalStart = CFrame.new()
        v2.larmNormalTF = SpringUtil.new(1)
        v2.larmNormalTF.Speed = 12
        v2.larmNormalTF.Damper = 0.9
        v2.larmNormalTF.Target = 1
        v2.rarmNormalTF = SpringUtil.new(1)
        v2.rarmNormalTF.Speed = 12
        v2.rarmNormalTF.Damper = 0.9
        v2.rarmNormalTF.Target = 1
        v2.armDirection = 0
        v2.legVars = {}
        v2.isMoving = false
        v2.locomotionSuspended = false
        v2.doingShuffle = false
        v2.stoodStill = true
        v2.hadRaycastResult = false
        v2.isSprinting = false
        v2.isJogging = false
        v2.isProning = false
        v2.isCrouching = false
        v2.isSliding = false
        v2.isDiving = false
        v2.isClimbing = false
        v2.isAiming = false
        v2.isGrounded = true
        v2.isDowned = false
        v2.isDead = false
        v2.ikEnabled = true
        v2.lookPoint = Vector3.new(0, 0, 0)
        v2.runWeight = SpringUtil.new(0)
        v2.runWeight.Speed = 8
        v2.runWeight.Damper = 0.9
        v2:setupAnimator()
        v2.raycastParams = nil
        v2.cachedFloorY = nil
        v2.lastRaycastPos = nil
        return v2
    end
    warn("[CharacterAnimator] Cannot initialize without a Humanoid:", p1:GetFullName())
    return nil
end

function u30.SetRaycastParams(p1, p2) -- Line: 212
    p1.raycastParams = p2
end

function u30:setupAnimator() -- Line: 216 -- upvalues: animations (val)
    if not animations then
        warn("[CharacterAnimator] No animations folder found")
        return
    end
    self.animator = self.Humanoid:FindFirstChildOfClass("Animator")
    if not self.animator then
        self.animator = Instance.new("Animator")
        self.animator.Parent = self.Humanoid
    end
    self.animTracks = {}
    local run = animations:FindFirstChild("run")
    local jump = animations:FindFirstChild("jump")
    local fall = animations:FindFirstChild("fall")
    local climb = animations:FindFirstChild("climb")
    if not run or not run:IsA("Animation") then
        warn("[CharacterAnimator] Run animation not found or invalid")
    else
        local animTracks = self.animTracks
        animTracks.run = self.animator:LoadAnimation(run)
        self.animTracks.run.Priority = Enum.AnimationPriority.Movement
        self.animTracks.run.Looped = true
    end
    if jump and jump:IsA("Animation") then
        local animTracks_2 = self.animTracks
        animTracks_2.jump = self.animator:LoadAnimation(jump)
        self.animTracks.jump.Priority = Enum.AnimationPriority.Action
        self.animTracks.jump.Looped = false
    end
    if fall and fall:IsA("Animation") then
        local animTracks_3 = self.animTracks
        animTracks_3.fall = self.animator:LoadAnimation(fall)
        self.animTracks.fall.Priority = Enum.AnimationPriority.Action
        self.animTracks.fall.Looped = true
    end
    if climb and climb:IsA("Animation") then
        local animTracks_4 = self.animTracks
        animTracks_4.climb = self.animator:LoadAnimation(climb)
        self.animTracks.climb.Priority = Enum.AnimationPriority.Action
        self.animTracks.climb.Looped = true
    end
    local walk = animations:FindFirstChild("walk")
    local idle = animations:FindFirstChild("idle")
    if walk and walk:IsA("Animation") then
        local animTracks_5 = self.animTracks
        animTracks_5.walk = self.animator:LoadAnimation(walk)
        self.animTracks.walk.Priority = Enum.AnimationPriority.Movement
        self.animTracks.walk.Looped = true
    end
    if idle and idle:IsA("Animation") then
        local animTracks_6 = self.animTracks
        animTracks_6.idle = self.animator:LoadAnimation(idle)
        self.animTracks.idle.Priority = Enum.AnimationPriority.Idle
        self.animTracks.idle.Looped = true
        self.animTracks.idle:Play()
    end
    self._isFalling = false
    self._isJumping = false
    self._connections = {}
    local _connections = self._connections
    local v1 = self.Humanoid.Jumping:Connect(function() -- Line: 288 -- upvalues: self (val)
        self._isJumping = true
        if self.animTracks.jump then
            self.animTracks.jump:Play(0.1)
        end
    end)
    table.insert(_connections, v1)
    local _connections_2 = self._connections
    v1 = self.Humanoid.StateChanged:Connect(function(p1, p2) -- Line: 298 -- upvalues: self (val)
        if p2 == Enum.HumanoidStateType.Freefall then
            if not self._isFalling then
                self._isFalling = true
                if self.animTracks.jump then
                    self.animTracks.jump:Stop(0.1)
                end
                if self.animTracks.fall then
                    self.animTracks.fall:Play(0.2)
                    return
                end
            end
            return
        end
        if p2 == Enum.HumanoidStateType.Landed or p2 == Enum.HumanoidStateType.Running then
            if self._isFalling or self._isJumping then
                self._isFalling = false
                self._isJumping = false
                if self.animTracks.jump then
                    self.animTracks.jump:Stop(0.1)
                end
                if self.animTracks.fall then
                    self.animTracks.fall:Stop(0.2)
                end
            end
        end
    end)
    table.insert(_connections_2, v1)
end

function u30.SetState(p1, p2) -- Line: 325
    if not p2 then
        return
    end
    p1.States = p2
    p1.isSprinting = p2.Sprinting or false
    p1.isJogging = p2.Jogging or false
    p1.isProning = p2.Proning or false
    p1.isCrouching = p2.Crouching or false
    p1.isSliding = p2.Sliding or false
    p1.isDiving = p2.Diving or false
    p1.isAiming = p2.Aiming or false
    local v1 = not p1.Humanoid
    if not v1 then
        v1 = p1.Humanoid.FloorMaterial ~= Enum.Material.Air
    end
    p1.isGrounded = v1
    if not p1.Humanoid then
        v1 = false
    else
        v1 = true
        if (p1.Humanoid:GetState()) ~= Enum.HumanoidStateType.Climbing then
            v1 = false
        end
    end
    p1.isClimbing = v1
    p1.isDowned = p2.IsDowned or false
    p1.isDead = p2.IsDead or false
end

function u30.SetLocomotionSuspended(p1, p2) -- Line: 346
    p1.locomotionSuspended = p2
end

function u30.SetLookPoint(p1, p2) -- Line: 350
    p1.lookPoint = p2
end

function u30.SetYaw(p1, p2) -- Line: 354
    p1.directYaw = p2
end

function u30.Heartbeat(p1, p2) end

function u30.UpdateStepped(p1, p2) -- Line: 362 -- upvalues: CurrentCamera (val)
    if p1.isDestroyed then
        return
    end
    if p1.character.Parent and p1.hrp.Parent and p1.torso.Parent then
        if not p1.ikEnabled then
            return
        end
        if not p1.isProning
            and not p1.isSliding
            and not p1.isDiving
            and not p1.isClimbing
            and not p1.isDowned
            and not p1.isDead then
            local C0, CFrame_5, Unit_2, Unit_3, v1, v2, v3, v4, v5, v6, v7, v8, v9
            local v10 = p2 * 20
            local v11 = math.clamp(v10, 0, 1)
            local new = CFrame.new
            local cycle = p1.cycle
            v10 = new(0, 0, math.sin(cycle) * 0.01)
            if p1.isMoving and 0 < p1.cycle then
                local Angles = CFrame.Angles
                local cycle_2 = p1.cycle
                v7 = v10 * Angles(0, 0, math.sin(cycle_2) * 0.08)
                local new_2 = CFrame.new
                v1 = p1.cycle * p1.cycleOffset
                v10 = v7 * new_2(0, 0, math.sin(v1) * 0.1)
            end
            local aimTwist = p1.aimTwist
            if not p1.isAiming then
                v8 = 0
            else
                v8 = 1
            end
            aimTwist.Target = v8
            v7 = CFrame.new()
            local v12 = CFrame.Angles(0, 0, -0.6108652381980153)
            local Position = p1.aimTwist.Position
            v10 = v10 * v7:Lerp(v12, Position)
            local Neck = p1.ik.Motor6Ds.Neck
            local Neck_2 = p1.ik.C0s.Neck
            v12 = CFrame.new()
            local v13 = CFrame.Angles(0, 0, 0.6108652381980153)
            local Position_2 = p1.aimTwist.Position
            v12 = v12:Lerp(v13, Position_2)
            local Position_4 = 0
            v13 = 0
            if not p1.lookPoint or p1.lookPoint == Vector3.new(0, 0, 0) then
                if p1.isLocalPlayer then
                    v9 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
                    p1.lookPitch.Target = v9
                    Position_4 = p1.lookPitch.Position
                    CFrame_5 = p1.hrp.CFrame
                    v3 = CurrentCamera
                    Unit_2 = (v3.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                    Unit_3 = (CFrame_5.LookVector * Vector3.new(1, 0, 1)).Unit
                    v13 = Unit_2:Cross(Unit_3).Y * 0.8
                end
            elseif not p1.isLocalPlayer then
                local Head = p1.ik.Head
                local CFrame_2 = p1.hrp.CFrame
                local Magnitude = (Head.CFrame.Position - p1.lookPoint).Magnitude
                local v14 = (Head.CFrame.Y - p1.lookPoint.Y) / Magnitude
                v4 = -math.atan(v14)
                p1.lookPitch.Target = v4
                Position_4 = p1.lookPitch.Position
                if not p1.directYaw or p1.directYaw == 0 then
                    local Unit = (p1.lookPoint - Head.Position).Unit
                    local LookVector = CFrame_2.LookVector
                    v13 = Unit:Cross(LookVector).Y * 0.8
                else
                    v13 = p1.directYaw * 0.8
                end
            elseif p1.isLocalPlayer then
                v9 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
                p1.lookPitch.Target = v9
                Position_4 = p1.lookPitch.Position
                CFrame_5 = p1.hrp.CFrame
                v3 = CurrentCamera
                Unit_2 = (v3.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
                Unit_3 = (CFrame_5.LookVector * Vector3.new(1, 0, 1)).Unit
                v13 = Unit_2:Cross(Unit_3).Y * 0.8
            end
            if Position_4 ~= 0 then
                v9 = Position_4 * 0.6
                v1 = -Position_4 * 0.4
                v2 = 1 - p1.aimTwist.Position * 0.9
                v3 = -v13 * v2
                v4 = CFrame.Angles(v9, v3, 0)
                C0 = Neck.C0
                v6 = v4 * Neck_2
                v5 = C0:Lerp(v6, 0.25).Rotation + Neck_2.Position
                if not Neck.C0:FuzzyEq(v5, 0.0001) then
                    Neck.C0 = v5
                end
                Neck.Transform = Neck.Transform * v12
                v10 = v10 * CFrame.Angles(v1, 0, 0)
            elseif v13 == 0 then
                Neck.Transform = Neck.Transform * v12
            else
                v9 = Position_4 * 0.6
                v1 = -Position_4 * 0.4
                v2 = 1 - p1.aimTwist.Position * 0.9
                v3 = -v13 * v2
                v4 = CFrame.Angles(v9, v3, 0)
                C0 = Neck.C0
                v6 = v4 * Neck_2
                v5 = C0:Lerp(v6, 0.25).Rotation + Neck_2.Position
                if not Neck.C0:FuzzyEq(v5, 0.0001) then
                    Neck.C0 = v5
                end
                Neck.Transform = Neck.Transform * v12
                v10 = v10 * CFrame.Angles(v1, 0, 0)
            end
            if not p1.isAiming then
                v9 = CFrame.Angles(
                    0.06981317007977318 * p1.forwardSpring.Position,
                    0.06981317007977318 * -p1.rightSpring.Position,
                    0
                )
            else
                v9 = CFrame.new()
            end
            p1.RootJointLeanCF = p1.RootJointLeanCF:Lerp(v9, v11)
            v10 = v10 * p1.RootJointLeanCF
            p1.RootJointTransform = p1.RootJointTransform:Lerp(v10, v11)
            v1 = 1 - p1.runWeight.Position
            if 0.01 < v1 then
                v2 = CFrame.new()
                local RootJointTransform = p1.RootJointTransform
                v2 = v2:Lerp(RootJointTransform, v1)
                local RootJoint = p1.ik.Motor6Ds.RootJoint
                RootJoint.Transform = RootJoint.Transform * v2
            end
            v2 = p1.ik.Motor6Ds["Left Shoulder"]
            v3 = p1.ik.Motor6Ds["Right Shoulder"]
            if not p1.leftArmControlledByViewmodel then
                local Transform = v2.Transform
                v5 = CFrame.new()
                local Position_7 = p1.larmNormalTF.Position
                v2.Transform = v5:Lerp(Transform, Position_7)
            end
            if not p1.rightArmControlledByViewmodel then
                local Transform_2 = v3.Transform
                v5 = CFrame.new()
                local Position_8 = p1.rarmNormalTF.Position
                v3.Transform = v5:Lerp(Transform_2, Position_8)
            end
            return
        end
        if p1.ik.Motor6Ds.Neck.C0 ~= p1.ik.C0s.Neck then
            p1.ik.Motor6Ds.Neck.C0 = p1.ik.C0s.Neck
        end
        return
    end
end

function u30:UpdateDistantAnimation(p2, p3) -- Line: 511
    local animTracks = self.animTracks
    if animTracks then
        animTracks = self.animTracks.walk
    end
    local animTracks_2 = self.animTracks
    if animTracks_2 then
        animTracks_2 = self.animTracks.idle
    end
    if not p2 or not (2 < p3) then
        if animTracks_2 and not animTracks_2.IsPlaying then
            animTracks_2:Play(0.2)
        end
        if animTracks and animTracks.IsPlaying then
            animTracks:Stop(0.2)
        end
    else
        if animTracks and not animTracks.IsPlaying then
            animTracks:Play(0.2)
        end
        if animTracks_2 and animTracks_2.IsPlaying then
            animTracks_2:Stop(0.2)
        end
        if animTracks then
            local v1 = p3 / 16
            local v2 = math.clamp(v1, 0.5, 1.5)
            animTracks:AdjustSpeed(v2)
        end
    end
    if not self._distantLegsReset then
        self._distantLegsReset = true
        local v3 = self.ik.Motor6Ds["Left Hip"]
        v3.C0 = self.ik.C0s["Left Hip"]
        v3 = self.ik.Motor6Ds["Right Hip"]
        v3.C0 = self.ik.C0s["Right Hip"]
        self.cachedFloorY = nil
        self.lastRaycastPos = nil
    end
end

function u30.UpdateRenderStepped(p1, p2, p3) -- Line: 549 -- upvalues: Util (val)
    if p1.isDestroyed then
        return
    end
    if p1.character.Parent and p1.hrp.Parent and p1.torso.Parent then
        local v1, v2, v3
        local v4 = os.clock()
        if p1._lastRenderTime and v4 - p1._lastRenderTime < 0.001 then
            return
        end
        p1._lastRenderTime = v4
        if not p1.isProning
            and not p1.isSliding
            and not p1.isDiving
            and not p1.isCrouching
            and not p1.isClimbing
            and not p1.isDowned
            and not p1.isDead then
            local Angles, Angles_2, Magnitude_2, Magnitude_3, Position_10, Position_3, Position_4, Position_5, Position_6, Position_7, Position_8, Position_9, Unit_2, Unit_3, Unit_4, X, X_2, Y, Z, Z_2, cachedFloorY, cachedFloorY_2, cycle, cycle_2, finalGoal, larmNormalStart, lastLookVectorDelta, legUpDirection, legVars, legVars_2, lookMax, new_2, oldGoal, rarmNormalStart, raycastParams, raycastParams_2, raycastParams_3, rotateDelta, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34
            if p1._limbsReset then
                local animTracks = p1.animTracks
                if animTracks then
                    animTracks = p1.animTracks.climb
                end
                if animTracks and animTracks.IsPlaying then
                    animTracks:Stop(0.2)
                end
            end
            p1._limbsReset = false
            local v35 = math.clamp(p2, 0.001, 0.1)
            local v36 = v35 * 60
            v2 = v35 * 10
            v1 = math.clamp(v2, 0, 1)
            local CFrame_2 = p1.torso.CFrame
            local CFrame_3 = p1.hrp.CFrame
            local Position = CFrame_3.Position
            local Orientation = p1.hrp.Orientation
            if not p1.oldOrientation then
                p1.oldOrientation = Orientation
            end
            local oldOrientation = p1.oldOrientation
            local v37 = p1.hrp.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
            local Magnitude = v37.Magnitude
            if p1.locomotionSuspended or p1.hrp.Anchored then
                Magnitude = 0
            end
            local Unit = v37.Unit
            if Unit ~= Unit then
                Unit = CFrame_2.LookVector.Unit
            end
            local lastPosition = p1.lastPosition
            p1.lastPosition = Position
            local v38 = (Position - (lastPosition or Position)) * Vector3.new(1, 0, 1)
            if v38 ~= v38 then
                v5 = Vector3.new()
            end
            v5 = 2 < Magnitude
            p1.isMoving = v5
            if not p1.ikEnabled then
                p1:UpdateDistantAnimation(v5, Magnitude)
                return
            end
            local v39 = "full"
            if not p1.isLocalPlayer and p3 then
                if 30 < p3 then
                    v39 = "animation"
                elseif 15 < p3 then
                    v39 = "reduced"
                end
            end
            if v39 == "animation" then
                p1:UpdateDistantAnimation(v5, Magnitude)
                return
            end
            if p1._distantLegsReset then
                p1._distantLegsReset = false
                local animTracks_2 = p1.animTracks
                if animTracks_2 then
                    animTracks_2 = p1.animTracks.walk
                end
                local animTracks_3 = p1.animTracks
                if animTracks_3 then
                    animTracks_3 = p1.animTracks.idle
                end
                if animTracks_2 and animTracks_2.IsPlaying then
                    animTracks_2:Stop(0.2)
                end
                if animTracks_3 and animTracks_3.IsPlaying then
                    animTracks_3:Stop(0.2)
                end
            end
            local isGrounded = p1.isGrounded
            local v40 = p1.isSprinting and v5
            local v41 = os.clock()
            if not v5 or not isGrounded then
                if 0.1 < v41 - p1.lastMovingTime then
                    if p1.cycle < 1.5707963267948966 then
                        v7 = p1.cycle - p1.cycleReturnStep * v36
                        p1.cycle = math.max(v7, 0)
                    elseif p1.cycle < 3.141592653589793 then
                        v7 = p1.cycle + p1.cycleReturnStep * v36
                        p1.cycle = math.min(v7, 3.141592653589793)
                    elseif not (p1.cycle < 4.71238898038469) then
                        p1.cycle = p1.cycle + p1.cycleReturnStep * v36
                        if 6.283185307179586 <= p1.cycle then
                            p1.cycle = 0
                        end
                    else
                        v7 = p1.cycle - p1.cycleReturnStep * v36
                        p1.cycle = math.max(v7, 3.141592653589793)
                    end
                end
            elseif not v40 then
                p1.lastMovingTime = v41
                v6 = Magnitude / p1.maxSpeed
                local v42 = math.clamp(v6, 0, 1)
                p1.cycle = p1.cycle + p1.cycleStep * v42 * v36
                p1.cycle = p1.cycle % 6.283185307179586
                p1.stoodStill = false
            elseif 0.1 < v41 - p1.lastMovingTime then
                if p1.cycle < 1.5707963267948966 then
                    v7 = p1.cycle - p1.cycleReturnStep * v36
                    p1.cycle = math.max(v7, 0)
                elseif p1.cycle < 3.141592653589793 then
                    v7 = p1.cycle + p1.cycleReturnStep * v36
                    p1.cycle = math.min(v7, 3.141592653589793)
                elseif not (p1.cycle < 4.71238898038469) then
                    p1.cycle = p1.cycle + p1.cycleReturnStep * v36
                    if 6.283185307179586 <= p1.cycle then
                        p1.cycle = 0
                    end
                else
                    v7 = p1.cycle - p1.cycleReturnStep * v36
                    p1.cycle = math.max(v7, 3.141592653589793)
                end
            end
            local _isFalling = p1._isFalling
            if not _isFalling then
                _isFalling = p1._isJumping
            end
            if not v40 then
                v6 = 0
            elseif not _isFalling then
                v6 = 1
            else
                v6 = 0.35
            end
            p1.runWeight.Target = v6
            local animTracks_4 = p1.animTracks
            if animTracks_4 then
                animTracks_4 = p1.animTracks.run
            end
            if animTracks_4 then
                if v40 ~= p1._wasRunning then
                    if not v40 then
                        animTracks_4:Stop(0.2)
                        v8 = p1.ik.Motor6Ds["Left Hip"]
                        v8.C0 = p1.ik.C0s["Left Hip"]
                        v8 = p1.ik.Motor6Ds["Right Hip"]
                        v8.C0 = p1.ik.C0s["Right Hip"]
                    else
                        p1.cycle = 0
                        animTracks_4:Play(0.2)
                        v8 = p1.ik.Motor6Ds["Left Hip"]
                        v8.C0 = p1.ik.C0s["Left Hip"]
                        v8 = p1.ik.Motor6Ds["Right Hip"]
                        v8.C0 = p1.ik.C0s["Right Hip"]
                    end
                    p1._wasRunning = v40
                end
                if animTracks_4.IsPlaying then
                    local Position_2 = p1.runWeight.Position
                    animTracks_4:AdjustWeight(Position_2, 0.05)
                    v9 = Magnitude / 19
                    v8 = math.clamp(v9, 0.5, 1.5)
                    v9 = (CFrame_3.LookVector:Dot(Unit)) < -0.3
                    v10 = v8
                    if v9 and p1.isLocalPlayer then
                        v10 = -v8
                    end
                    animTracks_4:AdjustSpeed(v10)
                end
            end
            v8 = CFrame_3.LookVector.Unit:Dot(Unit)
            if v8 ~= v8 or not v5 then
                v8 = 0
            end
            v9 = CFrame_3.RightVector.Unit:Dot(Unit)
            if v9 ~= v9 or not v5 then
                v9 = 0
            end
            p1.forwardSpring.Target = v8
            p1.rightSpring.Target = v9
            v10 = Util
            local armDirection = p1.armDirection
            if not (p1.forwardSpring.Position < 0) then
                v12 = 1
            else
                v12 = -1
            end
            p1.armDirection = v10:lerp(armDirection, v12, v1)
            v10 = Util
            local cycleOffset = p1.cycleOffset
            if not isGrounded or not v5 then
                v12 = 1
            else
                v12 = 2
            end
            p1.cycleOffset = v10:lerp(cycleOffset, v12, v1)
            v10 = Util
            local currentDirection = p1.currentDirection
            p1.currentDirection = v10:rotateAround(currentDirection, Unit, 10, v35, 3)
            v10 = CFrame.new(CFrame_2.Position, CFrame_2.Position + p1.currentDirection)
            local v43 = os.clock()
            if v39 ~= "reduced" then
                v11 = 120
            else
                v11 = 30
            end
            if v43 - p1.lastLegUpdate < 1 / v11 then
                return
            end
            p1.lastLegUpdate = v43
            v12 = {"Right", "Left"}
            local v44 = nil
            local v45 = nil
            local v46 = p1
            for i, j in v12, v44, v45 do
                cycle = v46.cycle
                if not v46.legVars[j] then
                    legVars = v46.legVars
                    v14 = {
                        rotateDelta = 0,
                        lastLookVector = CFrame_3.RightVector.Unit,
                        lastLookVectorDelta = CFrame_3.RightVector.Unit,
                    }
                    legVars[j] = v14
                end
                v13 = v46.legVars[j]
                if j == "Left" then
                    cycle = cycle + 3.141592653589793
                    if 6.283185307179586 < cycle then
                        cycle = cycle - 6.283185307179586
                    end
                end
                if j ~= "Left" then
                    if j == "Right" and not v46.rightArmControlledByViewmodel then
                        v15 = v46.ik.C0s["Right Shoulder"]
                        Angles_2 = CFrame.Angles
                        v17 = v46.rightSpring.Position * 0.1 * v46.armDirection
                        v22 = -v46.cycle
                        v14 = v15 * Angles_2(
                            v17,
                            -math.sin(v22) * 0.05 * v46.armDirection,
                            math.sin(cycle) * 0.5 * v46.armDirection
                        )
                        v15 = v46.ik.Motor6Ds["Right Shoulder"]
                        rarmNormalStart = v46.rarmNormalStart
                        Position_5 = v46.rarmNormal.Position
                        v15.C0 = rarmNormalStart:Lerp(v14, Position_5)
                        v15 = v46.ik.Motor6Ds["Right Shoulder"]
                        v16 = CFrame.Angles(0, 0, 0)
                        v18 = (CFrame.new(-0.5, 0.5, 0)) * CFrame.Angles(0, 1.5707963267948966, 0)
                        Position_6 = v46.rarmNormal.Position
                        v15.C1 = v16:Lerp(v18, Position_6)
                    end
                elseif not v46.leftArmControlledByViewmodel then
                    v15 = v46.ik.C0s["Left Shoulder"]
                    Angles = CFrame.Angles
                    v17 = -v46.rightSpring.Position * 0.1 * v46.armDirection
                    cycle_2 = v46.cycle
                    v14 = v15 * Angles(v17, -math.sin(cycle_2) * 0.05 * v46.armDirection, -math.sin(cycle) * 0.5 * v46.armDirection)
                    v15 = v46.ik.Motor6Ds["Left Shoulder"]
                    larmNormalStart = v46.larmNormalStart
                    Position_3 = v46.larmNormal.Position
                    v15.C0 = larmNormalStart:Lerp(v14, Position_3)
                    v15 = v46.ik.Motor6Ds["Left Shoulder"]
                    v16 = CFrame.Angles(0, 0, 0)
                    v18 = (CFrame.new(0.5, 0.5, 0)) * CFrame.Angles(0, -1.5707963267948966, 0)
                    Position_4 = v46.larmNormal.Position
                    v15.C1 = v16:Lerp(v18, Position_4)
                elseif j == "Right" and not v46.rightArmControlledByViewmodel then
                    v15 = v46.ik.C0s["Right Shoulder"]
                    Angles_2 = CFrame.Angles
                    v17 = v46.rightSpring.Position * 0.1 * v46.armDirection
                    v22 = -v46.cycle
                    v14 = v15 * Angles_2(v17, -math.sin(v22) * 0.05 * v46.armDirection, math.sin(cycle) * 0.5 * v46.armDirection)
                    v15 = v46.ik.Motor6Ds["Right Shoulder"]
                    rarmNormalStart = v46.rarmNormalStart
                    Position_5 = v46.rarmNormal.Position
                    v15.C0 = rarmNormalStart:Lerp(v14, Position_5)
                    v15 = v46.ik.Motor6Ds["Right Shoulder"]
                    v16 = CFrame.Angles(0, 0, 0)
                    v18 = (CFrame.new(-0.5, 0.5, 0)) * CFrame.Angles(0, 1.5707963267948966, 0)
                    Position_6 = v46.rarmNormal.Position
                    v15.C1 = v16:Lerp(v18, Position_6)
                end
                Unit_2 = CFrame_2.RightVector.Unit
                Unit_3 = CFrame_2.LookVector.Unit
                v17 = CFrame_2.Position + Vector3.new(0, -3.1500000953674316, 0)
                if i ~= 2 then
                    v21 = 1
                else
                    v21 = -1
                end
                v16 = v17 + Unit_2 * (0.5 * v21)
                new_2 = CFrame.new
                v24 = cycle / v46.cycleOffset
                v18 = v10 * new_2(0, math.sin(v24) * 0.6 + -3.15, math.sin(cycle) * 1.03).Position
                if i ~= 2 then
                    v22 = 1
                else
                    v22 = -1
                end
                finalGoal = v18 + Unit_2 * (0.5 * v22)
                v18 = finalGoal
                Position_7 = CFrame.new(finalGoal, finalGoal + v46.currentDirection).Position
                if v5 or not isGrounded then
                    v13.finalGoal = nil
                    if not isGrounded then
                        v13.rotateDelta = 0
                    end
                elseif v46.hadRaycastResult then
                    if j ~= "Left" then
                        if j == "Right" and v46.cycle <= 0 and not v13.finalGoal then
                            v13.finalGoal = finalGoal
                        end
                    elseif v46.cycleOffset <= 1.05 then
                        if not v13.finalGoal then
                            v13.finalGoal = finalGoal
                        end
                    elseif j == "Right" and v46.cycle <= 0 and not v13.finalGoal then
                        v13.finalGoal = finalGoal
                    end
                    if v13.finalGoal then
                        finalGoal = v13.finalGoal
                    end
                elseif not v46.doingShuffle then
                    v13.finalGoal = nil
                    if not isGrounded then
                        v13.rotateDelta = 0
                    end
                else
                    if j ~= "Left" then
                        if j == "Right" and v46.cycle <= 0 and not v13.finalGoal then
                            v13.finalGoal = finalGoal
                        end
                    elseif v46.cycleOffset <= 1.05 then
                        if not v13.finalGoal then
                            v13.finalGoal = finalGoal
                        end
                    elseif j == "Right" and v46.cycle <= 0 and not v13.finalGoal then
                        v13.finalGoal = finalGoal
                    end
                    if v13.finalGoal then
                        finalGoal = v13.finalGoal
                    end
                end
                v20 = (Orientation.Y - oldOrientation.Y) / 180
                Magnitude_2 = (v13.lastLookVectorDelta - CFrame_3.LookVector.Unit).Magnitude
                lastLookVectorDelta = v13.lastLookVectorDelta
                Unit_4 = CFrame_3.LookVector.Unit
                v23 = lastLookVectorDelta:Cross(Unit_4):Dot((Vector3.new(0, 1, 0)))
                v13.lastLookVectorDelta = CFrame_3.LookVector.Unit
                if v23 < -0.01 then
                    Magnitude_2 = Magnitude_2 * -1
                end
                v13.rotateDelta = v13.rotateDelta + Magnitude_2
                if v5 then
                    v13.rotateDelta = 0
                    v13.lastLookVector = CFrame_3.RightVector.Unit
                else
                    rotateDelta = v13.rotateDelta
                    lookMax = v46.lookMax
                    v26 = rotateDelta / lookMax
                    if i == 1 then
                        v26 = v26 * -1
                    end
                    v27 = false
                    if not (rotateDelta < 0) then
                        if 0.1 <= v26 and 0 < rotateDelta then
                            v27 = true
                        end
                    elseif v26 <= -0.1 or 0.1 <= v26 and 0 < rotateDelta then
                        v27 = true
                    end
                    if not v27 then
                        if not v46.doingShuffle then
                            Magnitude_3 = (v18 - finalGoal).Magnitude
                            if v46.lookMaxDist <= Magnitude_3
                                or not v46.stoodStill and Magnitude < 1 and 0.3 <= (v18 * Vector3.new(1, 0, 1) - finalGoal * Vector3.new(1, 0, 1)).Magnitude then
                                if Magnitude < 1 then
                                    v46.stoodStill = true
                                end
                                v46.doingShuffle = true
                                v13.isPrimaryLeg = true
                                v46.shuffleStart = os.clock()
                                v46.shuffleEnd = v46.shuffleStart + 0.4
                            end
                        end
                    elseif not v46.doingShuffle then
                        v28 = math.abs(rotateDelta)
                        if lookMax - 0.2 < v28 then
                            if Magnitude < 1 then
                                v46.stoodStill = true
                            end
                            v46.doingShuffle = true
                            v13.isPrimaryLeg = true
                            v46.shuffleStart = os.clock()
                            v46.shuffleEnd = v46.shuffleStart + 0.4
                        elseif not v46.doingShuffle then
                            Magnitude_3 = (v18 - finalGoal).Magnitude
                            if v46.lookMaxDist <= Magnitude_3
                                or not v46.stoodStill and Magnitude < 1 and 0.3 <= (v18 * Vector3.new(1, 0, 1) - finalGoal * Vector3.new(1, 0, 1)).Magnitude then
                                if Magnitude < 1 then
                                    v46.stoodStill = true
                                end
                                v46.doingShuffle = true
                                v13.isPrimaryLeg = true
                                v46.shuffleStart = os.clock()
                                v46.shuffleEnd = v46.shuffleStart + 0.4
                            end
                        end
                    elseif not v46.doingShuffle then
                        Magnitude_3 = (v18 - finalGoal).Magnitude
                        if v46.lookMaxDist <= Magnitude_3
                            or not v46.stoodStill and Magnitude < 1 and 0.3 <= (v18 * Vector3.new(1, 0, 1) - finalGoal * Vector3.new(1, 0, 1)).Magnitude then
                            if Magnitude < 1 then
                                v46.stoodStill = true
                            end
                            v46.doingShuffle = true
                            v13.isPrimaryLeg = true
                            v46.shuffleStart = os.clock()
                            v46.shuffleEnd = v46.shuffleStart + 0.4
                        end
                    end
                    if v46.doingShuffle then
                        if not v13.distanceFromStable then
                            v13.distanceFromStable = (v18 - finalGoal).Magnitude
                        end
                        v46.oldOrientation = v46.hrp.Orientation
                        v28 = v46.shuffleEnd - os.clock()
                        v29 = (os.clock() - v46.shuffleStart) / (v46.shuffleEnd - v46.shuffleStart)
                        if 1 <= v29 then
                            v46.doingShuffle = false
                            legVars_2 = v46.legVars
                            v31 = nil
                            v32 = nil
                            for k, n in legVars_2, v31, v32 do
                                n.lastLookVector = CFrame_3.RightVector.Unit
                                n.oldGoal = nil
                                n.isPrimaryLeg = nil
                                n.lookStrength = nil
                                n.distanceFromStable = nil
                            end
                        elseif not (v29 <= 0.5) then
                            if not (0.5 < v29) then
                                if 0.5 < v29 and v13.isPrimaryLeg then
                                    v13.lastLookVector = CFrame_3.RightVector.Unit
                                end
                            elseif not v13.isPrimaryLeg then
                                if 0.5 < v29 then
                                    v29 = v29 - 0.5
                                end
                                if not v13.oldGoal then
                                    v13.oldGoal = finalGoal
                                    v13.legUpDirection = v46.ik.Part1s[j .. " Hip"].CFrame.UpVector.Unit
                                end
                                if not v13.lookStrength then
                                    v13.lookStrength = math.abs(rotateDelta) / lookMax
                                end
                                v13.rotateDelta = 0
                                v13.finalGoal = nil
                                v13.lastLookVector = CFrame_3.RightVector.Unit
                                oldGoal = v13.oldGoal
                                v33 = v29 * 2
                                v17 = oldGoal:Lerp(v18, v33)
                                legUpDirection = v13.legUpDirection
                                v34 = 3.141592653589793 * (v29 * 2)
                                v31 = legUpDirection * math.sin(v34)
                                v33 = 0.45 * v13.lookStrength
                                finalGoal = v17 + v31 * math.clamp(v33, 0.25, 0.3)
                            elseif 0.5 < v29 and v13.isPrimaryLeg then
                                v13.lastLookVector = CFrame_3.RightVector.Unit
                            end
                        elseif v13.isPrimaryLeg then
                            if 0.5 < v29 then
                                v29 = v29 - 0.5
                            end
                            if not v13.oldGoal then
                                v13.oldGoal = finalGoal
                                v13.legUpDirection = v46.ik.Part1s[j .. " Hip"].CFrame.UpVector.Unit
                            end
                            if not v13.lookStrength then
                                v13.lookStrength = math.abs(rotateDelta) / lookMax
                            end
                            v13.rotateDelta = 0
                            v13.finalGoal = nil
                            v13.lastLookVector = CFrame_3.RightVector.Unit
                            oldGoal = v13.oldGoal
                            v33 = v29 * 2
                            v17 = oldGoal:Lerp(v18, v33)
                            legUpDirection = v13.legUpDirection
                            v34 = 3.141592653589793 * (v29 * 2)
                            v31 = legUpDirection * math.sin(v34)
                            v33 = 0.45 * v13.lookStrength
                            finalGoal = v17 + v31 * math.clamp(v33, 0.25, 0.3)
                        elseif not (0.5 < v29) then
                            if 0.5 < v29 and v13.isPrimaryLeg then
                                v13.lastLookVector = CFrame_3.RightVector.Unit
                            end
                        elseif not v13.isPrimaryLeg then
                            if 0.5 < v29 then
                                v29 = v29 - 0.5
                            end
                            if not v13.oldGoal then
                                v13.oldGoal = finalGoal
                                v13.legUpDirection = v46.ik.Part1s[j .. " Hip"].CFrame.UpVector.Unit
                            end
                            if not v13.lookStrength then
                                v13.lookStrength = math.abs(rotateDelta) / lookMax
                            end
                            v13.rotateDelta = 0
                            v13.finalGoal = nil
                            v13.lastLookVector = CFrame_3.RightVector.Unit
                            oldGoal = v13.oldGoal
                            v33 = v29 * 2
                            v17 = oldGoal:Lerp(v18, v33)
                            legUpDirection = v13.legUpDirection
                            v34 = 3.141592653589793 * (v29 * 2)
                            v31 = legUpDirection * math.sin(v34)
                            v33 = 0.45 * v13.lookStrength
                            finalGoal = v17 + v31 * math.clamp(v33, 0.25, 0.3)
                        elseif 0.5 < v29 and v13.isPrimaryLeg then
                            v13.lastLookVector = CFrame_3.RightVector.Unit
                        end
                    end
                end
                raycastParams = v46.raycastParams
                if raycastParams then
                    raycastParams = v46.isLocalPlayer
                    if not raycastParams then
                        raycastParams = false
                        if v39 == "full" then
                            raycastParams = not v5
                        end
                    end
                end
                if raycastParams then
                    v26 = CFrame_3 * CFrame.new(0, -1, 0)
                    if i ~= 2 then
                        v30 = 1
                    else
                        v30 = -1
                    end
                    v25 = v26 + Unit_2 * (0.5 * v30)
                    v26 = workspace
                    Position_8 = v25.Position
                    v29 = finalGoal - v25.Position
                    raycastParams_2 = v46.raycastParams
                    v26 = v26:Raycast(Position_8, v29, raycastParams_2)
                    v27 = v26 ~= nil
                    v46.hadRaycastResult = v27
                    if not v26 then
                        Position_9 = finalGoal
                    else
                        Position_9 = v26.Position
                        if not v46.isLocalPlayer then
                            v46.cachedFloorY = v26.Position.Y
                            v46.lastRaycastPos = Position
                        end
                        if not v46.isLocalPlayer then
                            v19 = Position_9 * Vector3.new(1, 0, 1)
                            Y = v16.Y
                            Position_9 = v19 + Vector3.new(0, Y, 0)
                        end
                    end
                elseif v39 ~= "reduced" or v5 or not v46.cachedFloorY then
                    Position_9 = finalGoal
                elseif not ((Position - (v46.lastRaycastPos or Position)).Magnitude < 2) then
                    v27 = CFrame_3 * CFrame.new(0, -1, 0)
                    if i ~= 2 then
                        v31 = 1
                    else
                        v31 = -1
                    end
                    v26 = v27 + Unit_2 * (0.5 * v31)
                    v27 = workspace
                    Position_10 = v26.Position
                    v30 = finalGoal - v26.Position
                    raycastParams_3 = v46.raycastParams
                    v27 = v27:Raycast(Position_10, v30, raycastParams_3)
                    if not v27 then
                        Position_9 = finalGoal
                    else
                        v46.cachedFloorY = v27.Position.Y
                        v46.lastRaycastPos = Position
                        X_2 = finalGoal.X
                        cachedFloorY_2 = v46.cachedFloorY
                        Z_2 = finalGoal.Z
                        Position_9 = Vector3.new(X_2, cachedFloorY_2, Z_2)
                    end
                else
                    X = finalGoal.X
                    cachedFloorY = v46.cachedFloorY
                    Z = finalGoal.Z
                    Position_9 = Vector3.new(X, cachedFloorY, Z)
                end
                if not isGrounded then
                    Position_9 = v16
                end
                if not v40 then
                    v46.ik:LegIK(j, Position_9)
                end
            end
            return
        end
        if not p1._limbsReset then
            p1._limbsReset = true
            p1.cycle = 0
            local animTracks_5 = p1.animTracks
            if animTracks_5 then
                animTracks_5 = p1.animTracks.run
            end
            if animTracks_5 and animTracks_5.IsPlaying then
                animTracks_5:Stop(0.2)
                p1._wasRunning = false
            end
            local animTracks_6 = p1.animTracks
            if animTracks_6 then
                animTracks_6 = p1.animTracks.walk
            end
            if animTracks_6 and animTracks_6.IsPlaying then
                animTracks_6:Stop(0.2)
            end
            local animTracks_7 = p1.animTracks
            if animTracks_7 then
                animTracks_7 = p1.animTracks.climb
            end
            if p1.isClimbing and animTracks_7 and not animTracks_7.IsPlaying then
                animTracks_7:Play(0.2)
            end
            v2 = p1.ik.Motor6Ds["Left Hip"]
            v2.C0 = p1.ik.C0s["Left Hip"]
            v2 = p1.ik.Motor6Ds["Right Hip"]
            v2.C0 = p1.ik.C0s["Right Hip"]
            p1.ik.Motor6Ds.Neck.C0 = p1.ik.C0s.Neck
            v2 = p1.ik.Motor6Ds["Left Shoulder"]
            v2.C0 = p1.ik.C0s["Left Shoulder"]
            v2 = p1.ik.Motor6Ds["Right Shoulder"]
            v2.C0 = p1.ik.C0s["Right Shoulder"]
            v2 = p1.ik.Motor6Ds["Left Shoulder"]
            v2.C1 = p1.ik.C1s["Left Shoulder"]
            v2 = p1.ik.Motor6Ds["Right Shoulder"]
            v2.C1 = p1.ik.C1s["Right Shoulder"]
            local legVars_3 = p1.legVars
            local v47 = nil
            v3 = nil
            for m, i5 in legVars_3, v47, v3 do
                i5.finalGoal = nil
                i5.cachedHipC0 = nil
                i5.oldGoal = nil
                i5.rotateDelta = 0
            end
            p1.doingShuffle = false
            p1.cachedFloorY = nil
            p1.lastRaycastPos = nil
        end
        if p1.isClimbing then
            local animTracks_8 = p1.animTracks
            if animTracks_8 then
                animTracks_8 = p1.animTracks.climb
            end
            if animTracks_8 and animTracks_8.IsPlaying then
                local Y_2 = p1.hrp.AssemblyLinearVelocity.Y
                v1 = math.abs(Y_2)
                if 0.5 < v1 then
                    v3 = v1 / 8
                    animTracks_8:AdjustSpeed(v3)
                    return
                end
                animTracks_8:AdjustSpeed(1e-07)
            end
        end
        return
    end
end

function u30.SetIKEnabled(p1, p2) -- Line: 1098
    if p1.ikEnabled == p2 then
        return
    end
    p1.ikEnabled = p2
    if p2 then
        p1._distantLegsReset = false
        local animTracks_3 = p1.animTracks
        if animTracks_3 then
            animTracks_3 = p1.animTracks.walk
        end
        local animTracks_4 = p1.animTracks
        if animTracks_4 then
            animTracks_4 = p1.animTracks.idle
        end
        if animTracks_3 and animTracks_3.IsPlaying then
            animTracks_3:Stop(0.2)
        end
        if animTracks_4 and animTracks_4.IsPlaying then
            animTracks_4:Stop(0.2)
        end
        return
    end
    p1.cycle = 0
    local v1 = p1.ik.Motor6Ds["Left Hip"]
    v1.C0 = p1.ik.C0s["Left Hip"]
    v1 = p1.ik.Motor6Ds["Right Hip"]
    v1.C0 = p1.ik.C0s["Right Hip"]
    p1.ik.Motor6Ds.Neck.C0 = p1.ik.C0s.Neck
    v1 = p1.ik.Motor6Ds["Left Shoulder"]
    v1.C0 = p1.ik.C0s["Left Shoulder"]
    v1 = p1.ik.Motor6Ds["Right Shoulder"]
    v1.C0 = p1.ik.C0s["Right Shoulder"]
    v1 = p1.ik.Motor6Ds["Left Shoulder"]
    v1.C1 = p1.ik.C1s["Left Shoulder"]
    v1 = p1.ik.Motor6Ds["Right Shoulder"]
    v1.C1 = p1.ik.C1s["Right Shoulder"]
    local legVars = p1.legVars
    local v2 = nil
    local v3 = nil
    for i, j in legVars, v2, v3 do
        j.finalGoal = nil
        j.cachedHipC0 = nil
        j.oldGoal = nil
        j.rotateDelta = 0
    end
    p1.doingShuffle = false
    p1.cachedFloorY = nil
    p1.lastRaycastPos = nil
    local animTracks = p1.animTracks
    if animTracks then
        animTracks = p1.animTracks.run
    end
    if animTracks and animTracks.IsPlaying then
        animTracks:Stop(0.2)
        p1._wasRunning = false
    end
    local animTracks_2 = p1.animTracks
    if animTracks_2 then
        animTracks_2 = p1.animTracks.idle
    end
    if animTracks_2 and not animTracks_2.IsPlaying then
        animTracks_2:Play(0.2)
    end
    p1._distantLegsReset = true
end

function u30.SetWeaponEquipped(p1, p2) -- Line: 1154
    p1.hasWeaponEquipped = p2
    if p2 then
        p1.leftArmControlledByViewmodel = true
        p1.rightArmControlledByViewmodel = true
        return
    end
    p1.leftArmControlledByViewmodel = false
    p1.rightArmControlledByViewmodel = false
end

function u30.SetArmControl(p1, p2, p3) -- Line: 1167
    p1.leftArmControlledByViewmodel = p2
    p1.rightArmControlledByViewmodel = p3
end

function u30.GetAimTwist(p1) -- Line: 1173
    return p1.aimTwist.Position
end

function u30.GetAimTwistAngle(p1) -- Line: 1178
    return 0.6108652381980153 * p1.aimTwist.Position
end

function u30.Destroy(p1) -- Line: 1182
    p1.isDestroyed = true
    if p1._connections then
        for k, v in pairs(p1._connections) do
            v:Disconnect()
        end
        p1._connections = nil
    end
    if p1.animTracks then
        for k2, i in pairs(p1.animTracks) do
            if i.IsPlaying then
                i:Stop(0.05)
            end
        end
        p1.animTracks = nil
    end
    p1.animator = nil
    p1.character = nil
    p1.ik = nil
end

return u30