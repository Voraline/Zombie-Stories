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
    local v3 = 1 - C0.LookVector:Dot(p2.LookVector)
    if v2 < v3 then
        p1.C0 = p2
        return true
    end
    if v2 >= 1 - C0.UpVector:Dot(p2.UpVector) then
        return false
    end
    p1.C0 = p2
    return true
end
local u30 = {}
u30.__index = u30
function u30.new(p1, p2) -- Line: 62 -- upvalues: u30 (val), R6IK (val), SpringUtil (val)
    local v1, v2
    local Humanoid = p1:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        Humanoid = p1:WaitForChild("Humanoid", 5)
    end
    if not Humanoid or not (Humanoid:IsA("Humanoid")) then
        warn("[CharacterAnimator] Cannot initialize without a Humanoid:", p1:GetFullName())
        return nil
    end
    if Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
        warn("[CharacterAnimator] Procedural animation only supports R6; skipping rig:", Humanoid.RigType.Name)
        return nil
    end
    local v3 = setmetatable({}, u30)
    v3.character = p1
    v3.isLocalPlayer = p2
    v3.isDestroyed = false
    v1, v2 = pcall(function() -- Line: 80 -- upvalues: R6IK (upval), p1 (val), p2 (val)
        return R6IK.New(p1, p2)
    end)
    if not v1 then
        warn("[CharacterAnimator] Failed to initialize IK:", v2)
        return nil
    end
    v3.ik = v2
    v3.hrp = v3.ik.HumanoidRootPart
    v3.torso = v3.ik.Torso
    v3.Humanoid = Humanoid
    v3.cycle = 0
    v3.cycleStep = 0.18
    v3.cycleReturnStep = 0.22
    v3.cycleOffset = 1
    v3.maxSpeed = 16
    v3.lookMax = 1.32
    v3.lookMaxDist = 0.6
    v3.lastPosition = nil
    v3.currentDirection = Vector3.new(0, 0, 10)
    v3.oldOrientation = nil
    v3.lastUpdate = os.clock()
    v3.lastLegUpdate = os.clock()
    v3.shuffleStart = os.clock()
    v3.shuffleEnd = os.clock()
    v3.lastMovingTime = 0
    v3.RootJointTransform = CFrame.new()
    v3.RootJointLeanCF = CFrame.new()
    v3.forwardSpring = SpringUtil.new(0)
    v3.forwardSpring.Speed = 6
    v3.forwardSpring.Damper = 0.6
    v3.rightSpring = SpringUtil.new(0)
    v3.rightSpring.Speed = 6
    v3.rightSpring.Damper = 0.6
    v3.aimTwist = SpringUtil.new(0)
    v3.aimTwist.Speed = 9
    v3.aimTwist.Damper = 0.9
    v3.lookPitch = SpringUtil.new(0)
    v3.lookPitch.Speed = 12
    v3.lookPitch.Damper = 0.85
    v3.larmNormal = SpringUtil.new(1)
    v3.larmNormal.Speed = 8
    v3.larmNormal.Damper = 0.85
    v3.larmNormal.Target = 1
    v3.larmNormalStart = CFrame.new()
    v3.rarmNormal = SpringUtil.new(1)
    v3.rarmNormal.Speed = 8
    v3.rarmNormal.Damper = 0.85
    v3.rarmNormal.Target = 1
    v3.rarmNormalStart = CFrame.new()
    v3.larmNormalTF = SpringUtil.new(1)
    v3.larmNormalTF.Speed = 12
    v3.larmNormalTF.Damper = 0.9
    v3.larmNormalTF.Target = 1
    v3.rarmNormalTF = SpringUtil.new(1)
    v3.rarmNormalTF.Speed = 12
    v3.rarmNormalTF.Damper = 0.9
    v3.rarmNormalTF.Target = 1
    v3.armDirection = 0
    v3.legVars = {}
    v3.isMoving = false
    v3.locomotionSuspended = false
    v3.doingShuffle = false
    v3.stoodStill = true
    v3.hadRaycastResult = false
    v3.isSprinting = false
    v3.isJogging = false
    v3.isProning = false
    v3.isCrouching = false
    v3.isSliding = false
    v3.isDiving = false
    v3.isClimbing = false
    v3.isAiming = false
    v3.isGrounded = true
    v3.isDowned = false
    v3.isDead = false
    v3.ikEnabled = true
    v3.lookPoint = Vector3.new(0, 0, 0)
    v3.runWeight = SpringUtil.new(0)
    v3.runWeight.Speed = 8
    v3.runWeight.Damper = 0.9
    v3:setupAnimator()
    v3.raycastParams = nil
    v3.cachedFloorY = nil
    v3.lastRaycastPos = nil
    return v3
end
function u30.SetRaycastParams(p1, p2) -- Line: 212
    p1.raycastParams = p2
end
function u30:setupAnimator() -- Line: 216 -- upvalues: animations (val)
    local animTracks
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
    if not run then
        warn("[CharacterAnimator] Run animation not found or invalid")
    elseif run:IsA("Animation") then
        animTracks = self.animTracks
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
    table.insert(self._connections, self.Humanoid.Jumping:Connect(function() -- Line: 288 -- upvalues: self (val)
        self._isJumping = true
        if self.animTracks.jump then
            self.animTracks.jump:Play(0.1)
        end
    end))
    table.insert(self._connections, self.Humanoid.StateChanged:Connect(function(p1, p2) -- Line: 298 -- upvalues: self (val)
        if p2 == Enum.HumanoidStateType.Freefall then
            if self._isFalling then
                return
            end
            self._isFalling = true
            if self.animTracks.jump then
                self.animTracks.jump:Stop(0.1)
            end
            if not self.animTracks.fall then
                return
            end
            self.animTracks.fall:Play(0.2)
            return
        end
        if p2 == Enum.HumanoidStateType.Landed then
            if self._isFalling then
                self._isFalling = false
                self._isJumping = false
                if self.animTracks.jump then
                    self.animTracks.jump:Stop(0.1)
                end
                if self.animTracks.fall then
                    self.animTracks.fall:Stop(0.2)
                end
            elseif not self._isJumping then
            end
        elseif p2 ~= Enum.HumanoidStateType.Running then
        end
    end))
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
        local State = p1.Humanoid:GetState()
        if State ~= Enum.HumanoidStateType.Climbing then
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
    local v1, v2, v3, v4
    if p1.isDestroyed or not p1.character.Parent or not p1.hrp.Parent or not p1.torso.Parent or not p1.ikEnabled then
        return
    end
    if p1.isProning or p1.isSliding or p1.isDiving or p1.isClimbing or p1.isDowned or p1.isDead then
        p1.ik.Motor6Ds.Neck.C0 = p1.ik.C0s.Neck
        return
    end
    local v5 = math.clamp(p2 * 20, 0, 1)
    local v6 = CFrame.new(0, 0, math.sin(p1.cycle) * 0.01)
    if p1.isMoving and 0 < p1.cycle then
        local v7 = v6 * CFrame.Angles(0, 0, math.sin(p1.cycle) * 0.08)
        v6 = v7 * CFrame.new(0, 0, math.sin(p1.cycle * p1.cycleOffset) * 0.1)
    end
    if not p1.isAiming then
        v3 = 0
    else
        v3 = 1
    end
    p1.aimTwist.Target = v3
    local v8 = CFrame.Angles(0, 0, -0.6108652381980153)
    v6 = v6 * CFrame.new():Lerp(v8, p1.aimTwist.Position)
    local Neck = p1.ik.Motor6Ds.Neck
    local Neck_2 = p1.ik.C0s.Neck
    local v9 = CFrame.Angles(0, 0, 0.6108652381980153)
    v8 = CFrame.new():Lerp(v9, p1.aimTwist.Position)
    local Position = 0
    v9 = 0
    if not p1.lookPoint then
        if p1.isLocalPlayer then
            v4 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
            p1.lookPitch.Target = v4
            Position = p1.lookPitch.Position
            v9 = (CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit:Cross((p1.hrp.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit).Y * 0.8
        end
    elseif p1.lookPoint ~= Vector3.new(0, 0, 0) and not p1.isLocalPlayer then
        local Head = p1.ik.Head
        v2 = -math.atan((Head.CFrame.Y - p1.lookPoint.Y) / (Head.CFrame.Position - p1.lookPoint).Magnitude)
        p1.lookPitch.Target = v2
        Position = p1.lookPitch.Position
        if not p1.directYaw then
            v9 = (p1.lookPoint - Head.Position).Unit:Cross(p1.hrp.CFrame.LookVector).Y * 0.8
        elseif p1.directYaw ~= 0 then
            v9 = p1.directYaw * 0.8
        end
    end
    if Position ~= 0 then
        v2 = CFrame.Angles(Position * 0.6, -v9 * (1 - p1.aimTwist.Position * 0.9), 0)
        Neck.C0 = Neck.C0:lerp(v2 * Neck_2, 0.25).Rotation + Neck_2.Position
        Neck.Transform = Neck.Transform * v8
        v6 = v6 * CFrame.Angles(-Position * 0.4, 0, 0)
    elseif v9 == 0 then
        Neck.Transform = Neck.Transform * v8
    end
    if not p1.isAiming then
        v4 = CFrame.Angles(0.06981317007977318 * p1.forwardSpring.Position, 0.06981317007977318 * -p1.rightSpring.Position, 0)
    else
        v4 = CFrame.new()
    end
    p1.RootJointLeanCF = p1.RootJointLeanCF:Lerp(v4, v5)
    v6 = v6 * p1.RootJointLeanCF
    p1.RootJointTransform = p1.RootJointTransform:Lerp(v6, v5)
    local v10 = 1 - p1.runWeight.Position
    if 0.01 < v10 then
        v1 = CFrame.new():Lerp(p1.RootJointTransform, v10)
        local RootJoint = p1.ik.Motor6Ds.RootJoint
        RootJoint.Transform = RootJoint.Transform * v1
    end
    v1 = p1.ik.Motor6Ds["Left Shoulder"]
    local v11 = p1.ik.Motor6Ds["Right Shoulder"]
    if not p1.leftArmControlledByViewmodel then
        v1.Transform = CFrame.new():Lerp(v1.Transform, p1.larmNormalTF.Position)
    end
    if not p1.rightArmControlledByViewmodel then
        v11.Transform = CFrame.new():Lerp(v11.Transform, p1.rarmNormalTF.Position)
    end
end
function u30:UpdateDistantAnimation(p2, p3) -- Line: 505
    local animTracks = self.animTracks
    if animTracks then
        animTracks = self.animTracks.walk
    end
    local animTracks_2 = self.animTracks
    if animTracks_2 then
        animTracks_2 = self.animTracks.idle
    end
    if not p2 then
        if animTracks_2 and not animTracks_2.IsPlaying then
            animTracks_2:Play(0.2)
        end
        if animTracks and animTracks.IsPlaying then
            animTracks:Stop(0.2)
        end
    elseif 2 < p3 then
        if animTracks and not animTracks.IsPlaying then
            animTracks:Play(0.2)
        end
        if animTracks_2 and animTracks_2.IsPlaying then
            animTracks_2:Stop(0.2)
        end
        if animTracks then
            animTracks:AdjustSpeed((math.clamp(p3 / 16, 0.5, 1.5)))
        end
    end
    if not self._distantLegsReset then
        self._distantLegsReset = true
        local v1 = self.ik.Motor6Ds["Left Hip"]
        v1.C0 = self.ik.C0s["Left Hip"]
        v1 = self.ik.Motor6Ds["Right Hip"]
        v1.C0 = self.ik.C0s["Right Hip"]
        self.cachedFloorY = nil
        self.lastRaycastPos = nil
    end
end
function u30.UpdateRenderStepped(p1, p2, p3) -- Line: 543 -- upvalues: Util (val)
    if p1.isDestroyed then
        return
    end
    if not p1.character.Parent then
        return
    elseif not p1.hrp.Parent then
        return
    else
        local v1
        if not p1.torso.Parent then
            return
        end
        local v2 = os.clock()
        if not p1._lastRenderTime then
            local v3
            p1._lastRenderTime = v2
            if p1.isProning then
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
                    local v4 = p1.ik.Motor6Ds["Left Hip"]
                    v4.C0 = p1.ik.C0s["Left Hip"]
                    v4 = p1.ik.Motor6Ds["Right Hip"]
                    v4.C0 = p1.ik.C0s["Right Hip"]
                    p1.ik.Motor6Ds.Neck.C0 = p1.ik.C0s.Neck
                    v4 = p1.ik.Motor6Ds["Left Shoulder"]
                    v4.C0 = p1.ik.C0s["Left Shoulder"]
                    v4 = p1.ik.Motor6Ds["Right Shoulder"]
                    v4.C0 = p1.ik.C0s["Right Shoulder"]
                    v4 = p1.ik.Motor6Ds["Left Shoulder"]
                    v4.C1 = p1.ik.C1s["Left Shoulder"]
                    v4 = p1.ik.Motor6Ds["Right Shoulder"]
                    v4.C1 = p1.ik.C1s["Right Shoulder"]
                    local legVars_2 = p1.legVars
                    local v5 = nil
                    local v6 = nil
                    for i, j in legVars_2, v5, v6 do
                        j.finalGoal = nil
                        j.cachedHipC0 = nil
                        j.oldGoal = nil
                        j.rotateDelta = 0
                    end
                    p1.doingShuffle = false
                    p1.cachedFloorY = nil
                    p1.lastRaycastPos = nil
                end
                if not p1.isClimbing then
                    return
                end
                local animTracks_8 = p1.animTracks
                if animTracks_8 then
                    animTracks_8 = p1.animTracks.climb
                end
                if not animTracks_8 or not animTracks_8.IsPlaying then
                    return
                end
                v3 = math.abs(p1.hrp.AssemblyLinearVelocity.Y)
                if 0.5 < v3 then
                    animTracks_8:AdjustSpeed(v3 / 8)
                    return
                end
                animTracks_8:AdjustSpeed(1e-07)
                return
            elseif not p1.isSliding and not p1.isDiving and not p1.isCrouching and not p1.isClimbing and not p1.isDowned and not p1.isDead then
                local Magnitude_2, Position_2, Unit_2, cycle, finalGoal, legVars, lookMax, oldOrientation, raycastParams, rotateDelta, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31, v32
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
                v1 = math.clamp(p2, 0.001, 0.1)
                local v33 = v1 * 60
                v3 = math.clamp(v1 * 10, 0, 1)
                local CFrame = p1.torso.CFrame
                local CFrame_2 = p1.hrp.CFrame
                local Position = CFrame_2.Position
                local Orientation = p1.hrp.Orientation
                if not p1.oldOrientation then
                    p1.oldOrientation = Orientation
                end
                oldOrientation = p1.oldOrientation
                local v34 = p1.hrp.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
                local Magnitude = v34.Magnitude
                if p1.locomotionSuspended then
                    Magnitude = 0
                elseif not p1.hrp.Anchored then
                end
                local Unit = v34.Unit
                if Unit ~= Unit then
                    Unit = CFrame.LookVector.Unit
                end
                p1.lastPosition = Position
                local v35 = (Position - (p1.lastPosition or Position)) * Vector3.new(1, 0, 1)
                if v35 == v35 then end
                local v36 = 2 < Magnitude
                p1.isMoving = v36
                if not p1.ikEnabled then
                    p1:UpdateDistantAnimation(v36, Magnitude)
                    return
                end
                local v37 = "full"
                if not p1.isLocalPlayer and p3 then
                    if 30 < p3 then
                        v37 = "animation"
                    elseif 15 < p3 then
                        v37 = "reduced"
                    end
                end
                if v37 == "animation" then
                    p1:UpdateDistantAnimation(v36, Magnitude)
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
                local v38 = p1.isSprinting and v36
                local v39 = os.clock()
                if not v36 then
                    v7 = v39 - p1.lastMovingTime
                    if 0.1 < v7 then
                        if p1.cycle < 1.5707963267948966 then
                            p1.cycle = math.max(p1.cycle - p1.cycleReturnStep * v33, 0)
                        elseif p1.cycle < 3.141592653589793 then
                            p1.cycle = math.min(p1.cycle + p1.cycleReturnStep * v33, 3.141592653589793)
                        elseif p1.cycle >= 4.71238898038469 then
                            p1.cycle = p1.cycle + p1.cycleReturnStep * v33
                            if 6.283185307179586 <= p1.cycle then
                                p1.cycle = 0
                            end
                        else
                            p1.cycle = math.max(p1.cycle - p1.cycleReturnStep * v33, 3.141592653589793)
                        end
                    end
                elseif isGrounded and not v38 then
                    p1.lastMovingTime = v39
                    v7 = math.clamp(Magnitude / p1.maxSpeed, 0, 1)
                    p1.cycle = p1.cycle + p1.cycleStep * v7 * v33
                    p1.cycle = p1.cycle % 6.283185307179586
                    p1.stoodStill = false
                end
                local _isFalling = p1._isFalling
                if not _isFalling then
                    _isFalling = p1._isJumping
                end
                if not v38 then
                    v8 = 0
                elseif not _isFalling then
                    v8 = 1
                else
                    v8 = 0.35
                end
                p1.runWeight.Target = v8
                local animTracks_4 = p1.animTracks
                if animTracks_4 then
                    animTracks_4 = p1.animTracks.run
                end
                if animTracks_4 then
                    if v38 ~= p1._wasRunning then
                        if not v38 then
                            animTracks_4:Stop(0.2)
                            v9 = p1.ik.Motor6Ds["Left Hip"]
                            v9.C0 = p1.ik.C0s["Left Hip"]
                            v9 = p1.ik.Motor6Ds["Right Hip"]
                            v9.C0 = p1.ik.C0s["Right Hip"]
                        else
                            p1.cycle = 0
                            animTracks_4:Play(0.2)
                            v9 = p1.ik.Motor6Ds["Left Hip"]
                            v9.C0 = p1.ik.C0s["Left Hip"]
                            v9 = p1.ik.Motor6Ds["Right Hip"]
                            v9.C0 = p1.ik.C0s["Right Hip"]
                        end
                        p1._wasRunning = v38
                    end
                    if animTracks_4.IsPlaying then
                        animTracks_4:AdjustWeight(p1.runWeight.Position, 0.05)
                        v9 = math.clamp(Magnitude / 19, 0.5, 1.5)
                        v11 = CFrame_2.LookVector:Dot(Unit)
                        v10 = v11 < -0.3
                        v11 = if v10 and p1.isLocalPlayer then -v9 else v9
                        animTracks_4:AdjustSpeed(v11)
                    end
                end
                v9 = CFrame_2.LookVector.Unit:Dot(Unit)
                if v9 ~= v9 then
                    v9 = 0
                end
                v10 = CFrame_2.RightVector.Unit:Dot(Unit)
                if v10 ~= v10 then
                    v10 = 0
                end
                p1.forwardSpring.Target = v9
                p1.rightSpring.Target = v10
                if p1.forwardSpring.Position >= 0 then
                    v13 = 1
                else
                    v13 = -1
                end
                p1.armDirection = Util:lerp(p1.armDirection, v13, v3)
                local cycleOffset = p1.cycleOffset
                if not isGrounded then
                    v13 = 1
                elseif v36 then
                    v13 = 2
                end
                p1.cycleOffset = Util:lerp(cycleOffset, v13, v3)
                p1.currentDirection = Util:rotateAround(p1.currentDirection, Unit, 10, v1, 3)
                v11 = CFrame.new(CFrame.Position, CFrame.Position + p1.currentDirection)
                local v40 = os.clock()
                if v37 ~= "reduced" then
                    v12 = 120
                else
                    v12 = 30
                end
                v13 = v40 - p1.lastLegUpdate
                if v13 < 1 / v12 then
                    return
                end
                p1.lastLegUpdate = v40
                v13 = {"Right", "Left"}
                local v41 = nil
                local v42 = nil
                local v43 = p1
                for k, n in v13, v41, v42 do
                    cycle = v43.cycle
                    if not (v43.legVars[n]) then
                        v43.legVars[n] = {rotateDelta = 0, lastLookVector = CFrame_2.RightVector.Unit, lastLookVectorDelta = CFrame_2.RightVector.Unit}
                    end
                    v14 = v43.legVars[n]
                    if n == "Left" then
                        cycle = cycle + 3.141592653589793
                        if 6.283185307179586 < cycle then
                            cycle = cycle - 6.283185307179586
                        end
                    end
                    if n ~= "Left" then
                        if n == "Right" and not v43.rightArmControlledByViewmodel then
                            v16 = v43.ik.C0s["Right Shoulder"]
                            v18 = v43.rightSpring.Position * 0.1 * v43.armDirection
                            v20 = -math.sin(-v43.cycle) * 0.05
                            v19 = v20 * v43.armDirection
                            v21 = math.sin(cycle) * 0.5
                            v15 = v16 * CFrame.Angles(v18, v19, v21 * v43.armDirection)
                            v16 = v43.ik.Motor6Ds["Right Shoulder"]
                            v16.C0 = v43.rarmNormalStart:Lerp(v15, v43.rarmNormal.Position)
                            v16 = v43.ik.Motor6Ds["Right Shoulder"]
                            v17 = CFrame.Angles(0, 0, 0)
                            v20 = CFrame.new(-0.5, 0.5, 0)
                            v19 = v20 * CFrame.Angles(0, 1.5707963267948966, 0)
                            v16.C1 = v17:Lerp(v19, v43.rarmNormal.Position)
                        end
                    elseif not v43.leftArmControlledByViewmodel then
                        v16 = v43.ik.C0s["Left Shoulder"]
                        v18 = -v43.rightSpring.Position * 0.1 * v43.armDirection
                        v20 = -math.sin(v43.cycle) * 0.05
                        v19 = v20 * v43.armDirection
                        v21 = -math.sin(cycle) * 0.5
                        v15 = v16 * CFrame.Angles(v18, v19, v21 * v43.armDirection)
                        v16 = v43.ik.Motor6Ds["Left Shoulder"]
                        v16.C0 = v43.larmNormalStart:Lerp(v15, v43.larmNormal.Position)
                        v16 = v43.ik.Motor6Ds["Left Shoulder"]
                        v17 = CFrame.Angles(0, 0, 0)
                        v20 = CFrame.new(0.5, 0.5, 0)
                        v19 = v20 * CFrame.Angles(0, -1.5707963267948966, 0)
                        v16.C1 = v17:Lerp(v19, v43.larmNormal.Position)
                    end
                    Unit_2 = CFrame.RightVector.Unit
                    if k ~= 2 then
                        v22 = 1
                    else
                        v22 = -1
                    end
                    v17 = CFrame.Position + Vector3.new(0, -3.1500000953674316, 0) + Unit_2 * (0.5 * v22)
                    v22 = math.sin(cycle / v43.cycleOffset) * 0.6 + -3.15
                    if k ~= 2 then
                        v23 = 1
                    else
                        v23 = -1
                    end
                    finalGoal = v11 * CFrame.new(0, v22, math.sin(cycle) * 1.03).Position + Unit_2 * (0.5 * v23)
                    v19 = finalGoal
                    if v36 then
                        v14.finalGoal = nil
                        if not isGrounded then
                            v14.rotateDelta = 0
                        end
                    elseif isGrounded then
                        if v43.hadRaycastResult then
                            if n ~= "Left" then
                                if n == "Right" and v43.cycle <= 0 and not v14.finalGoal then
                                    v14.finalGoal = finalGoal
                                end
                            elseif v43.cycleOffset <= 1.05 then
                            end
                            if v14.finalGoal then
                                finalGoal = v14.finalGoal
                            end
                        elseif not v43.doingShuffle then
                        end
                    end
                    Magnitude_2 = (v14.lastLookVectorDelta - CFrame_2.LookVector.Unit).Magnitude
                    v24 = v14.lastLookVectorDelta:Cross(CFrame_2.LookVector.Unit):Dot((Vector3.new(0, 1, 0)))
                    v14.lastLookVectorDelta = CFrame_2.LookVector.Unit
                    if v24 < -0.01 then
                        Magnitude_2 = Magnitude_2 * -1
                    end
                    v14.rotateDelta = v14.rotateDelta + Magnitude_2
                    if v36 then
                        v14.rotateDelta = 0
                        v14.lastLookVector = CFrame_2.RightVector.Unit
                    else
                        rotateDelta = v14.rotateDelta
                        lookMax = v43.lookMax
                        v26 = rotateDelta / lookMax
                        if k == 1 then
                            v26 = v26 * -1
                        end
                        v27 = false
                        if rotateDelta >= 0 then
                            if 0.1 <= v26 and 0 < rotateDelta then
                                v27 = true
                            end
                        elseif v26 <= -0.1 then
                        end
                        if not v27 then
                            if not v43.doingShuffle then
                                if v43.lookMaxDist <= (v19 - finalGoal).Magnitude then
                                    if Magnitude < 1 then
                                        v43.stoodStill = true
                                    end
                                    v43.doingShuffle = true
                                    v14.isPrimaryLeg = true
                                    v43.shuffleStart = os.clock()
                                    v43.shuffleEnd = v43.shuffleStart + 0.4
                                elseif not v43.stoodStill and Magnitude < 1 then
                                    v29 = v19 * Vector3.new(1, 0, 1)
                                    if 0.3 > (v29 - finalGoal * Vector3.new(1, 0, 1)).Magnitude then end
                                end
                            end
                        elseif not v43.doingShuffle then
                            v28 = math.abs(rotateDelta)
                            if lookMax - 0.2 < v28 then end
                        end
                        if v43.doingShuffle then
                            if not v14.distanceFromStable then
                                v14.distanceFromStable = (v19 - finalGoal).Magnitude
                            end
                            v43.oldOrientation = v43.hrp.Orientation
                            v30 = os.clock() - v43.shuffleStart
                            v29 = v30 / (v43.shuffleEnd - v43.shuffleStart)
                            if 1 <= v29 then
                                v43.doingShuffle = false
                                legVars = v43.legVars
                                v31 = nil
                                v32 = nil
                                for m, i5 in legVars, v31, v32 do
                                    i5.lastLookVector = CFrame_2.RightVector.Unit
                                    i5.oldGoal = nil
                                    i5.isPrimaryLeg = nil
                                    i5.lookStrength = nil
                                    i5.distanceFromStable = nil
                                end
                            elseif v29 > 0.5 then
                                if 0.5 >= v29 then
                                    if 0.5 < v29 and v14.isPrimaryLeg then
                                        v14.lastLookVector = CFrame_2.RightVector.Unit
                                    end
                                elseif not v14.isPrimaryLeg then
                                    if 0.5 < v29 then
                                        v29 = v29 - 0.5
                                    end
                                    if not v14.oldGoal then
                                        v14.oldGoal = finalGoal
                                        v14.legUpDirection = v43.ik.Part1s[n .. " Hip"].CFrame.UpVector.Unit
                                    end
                                    if not v14.lookStrength then
                                        v14.lookStrength = math.abs(rotateDelta) / lookMax
                                    end
                                    v14.rotateDelta = 0
                                    v14.finalGoal = nil
                                    v14.lastLookVector = CFrame_2.RightVector.Unit
                                    v18 = v14.oldGoal:Lerp(v19, v29 * 2)
                                    v31 = v14.legUpDirection * math.sin(3.141592653589793 * (v29 * 2))
                                    finalGoal = v18 + v31 * math.clamp(0.45 * v14.lookStrength, 0.25, 0.3)
                                end
                            elseif v14.isPrimaryLeg then
                            end
                        end
                    end
                    raycastParams = v43.raycastParams
                    if raycastParams then
                        raycastParams = v43.isLocalPlayer
                        if not raycastParams then
                            raycastParams = if v37 == "full" then not v36 else false
                        end
                    end
                    if raycastParams then
                        if k ~= 2 then
                            v30 = 1
                        else
                            v30 = -1
                        end
                        v25 = CFrame_2 * CFrame.new(0, -1, 0) + Unit_2 * (0.5 * v30)
                        v26 = workspace:Raycast(v25.Position, finalGoal - v25.Position, v43.raycastParams)
                        v27 = v26 ~= nil
                        v43.hadRaycastResult = v27
                        if not v26 then
                            Position_2 = finalGoal
                        else
                            Position_2 = v26.Position
                            if not v43.isLocalPlayer then
                                v43.cachedFloorY = v26.Position.Y
                                v43.lastRaycastPos = Position
                            end
                            if not v43.isLocalPlayer then
                                v20 = Position_2 * Vector3.new(1, 0, 1)
                                Position_2 = v20 + Vector3.new(0, v17.Y, 0)
                            end
                        end
                    elseif v37 ~= "reduced" then
                        Position_2 = finalGoal
                    elseif not v36 and v43.cachedFloorY then
                        if (Position - (v43.lastRaycastPos or Position)).Magnitude >= 2 then
                            if k ~= 2 then
                                v31 = 1
                            else
                                v31 = -1
                            end
                            v26 = CFrame_2 * CFrame.new(0, -1, 0) + Unit_2 * (0.5 * v31)
                            v27 = workspace:Raycast(v26.Position, finalGoal - v26.Position, v43.raycastParams)
                            if not v27 then
                                Position_2 = finalGoal
                            else
                                v43.cachedFloorY = v27.Position.Y
                                v43.lastRaycastPos = Position
                                Position_2 = Vector3.new(finalGoal.X, v43.cachedFloorY, finalGoal.Z)
                            end
                        else
                            Position_2 = Vector3.new(finalGoal.X, v43.cachedFloorY, finalGoal.Z)
                        end
                    end
                    if not isGrounded then
                        Position_2 = v17
                    end
                    if not v38 then
                        v43.ik:LegIK(n, Position_2)
                    end
                end
                return
            end
        else
            v1 = v2 - p1._lastRenderTime
            if v1 < 0.001 then
                return
            end
        end
    end
end
function u30.SetIKEnabled(p1, p2) -- Line: 1092
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
function u30.SetWeaponEquipped(p1, p2) -- Line: 1148
    p1.hasWeaponEquipped = p2
    if p2 then
        p1.leftArmControlledByViewmodel = true
        p1.rightArmControlledByViewmodel = true
        return
    end
    p1.leftArmControlledByViewmodel = false
    p1.rightArmControlledByViewmodel = false
end
function u30.SetArmControl(p1, p2, p3) -- Line: 1161
    p1.leftArmControlledByViewmodel = p2
    p1.rightArmControlledByViewmodel = p3
end
function u30.GetAimTwist(p1) -- Line: 1167
    return p1.aimTwist.Position
end
function u30.GetAimTwistAngle(p1) -- Line: 1172
    return 0.6108652381980153 * p1.aimTwist.Position
end
function u30.Destroy(p1) -- Line: 1176
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