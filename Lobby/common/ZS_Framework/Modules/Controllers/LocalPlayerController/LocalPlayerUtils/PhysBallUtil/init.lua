local Utility = script:WaitForChild("Utility")
local Remotes = game.ReplicatedStorage.common:WaitForChild("Remotes")
local Enums = require(Utility:WaitForChild("Enums"))
local initChasis = Remotes:WaitForChild("initChasis")
local CurrentCamera = game.Workspace.CurrentCamera
local Terrain = game.Workspace:WaitForChild("Terrain")

local function lerpNumber(p1, p2, p3) -- Line: 16
    return (1 - p3) * p1 + p3 * p2
end

local function initAttachments(p1) -- Line: 20 -- upvalues: Terrain (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "diveAttachment"
    Attachment.Parent = Terrain
    local AlignPosition = Instance.new("AlignPosition")
    AlignPosition.RigidityEnabled = true
    AlignPosition.Enabled = false
    AlignPosition.Attachment0 = p1.rootAttach
    AlignPosition.Attachment1 = Attachment
    AlignPosition.Parent = p1.chasis
    local AlignOrientation = Instance.new("AlignOrientation")
    AlignOrientation.RigidityEnabled = true
    AlignOrientation.Enabled = false
    AlignOrientation.Attachment0 = p1.rootAttach
    AlignOrientation.Attachment1 = Attachment
    AlignOrientation.Parent = p1.chasis
    p1.humanoid.Died:Connect(function() -- Line: 41 -- upvalues: Attachment (val)
        Attachment:Destroy()
    end)
    return Attachment, AlignPosition, AlignOrientation
end

local v1 = {}
local u34 = {}
u34.__index = v1

function v1.new(p1) -- Line: 49 -- upvalues: initChasis (val), initAttachments (val), Enums (val), u34 (val)
    local u1 = {}
    local v1 = require
    local ControlScript = (p1:WaitForChild("PlayerScripts")):WaitForChild("ControlScript")
    u1.control = v1(ControlScript:WaitForChild("MasterControl"))

    local function setupCharacter(p1) -- Line: 54 -- upvalues: u1 (val), initChasis (upval), initAttachments (upval)
        local v1
        u1.character = p1
        u1.humanoid = u1.character:WaitForChild("Humanoid")
        u1.hrp = u1.character:WaitForChild("HumanoidRootPart", 5)
        if not u1.hrp then
            return
        end
        u1.rootAttach = u1.hrp:WaitForChild("RootAttachment")
        u1.loadingChasis = true
        local v2 = initChasis
        local v3 = u1
        local humanoid = v3.humanoid
        v2:InvokeServer(humanoid)
        u1.chasis = u1.character:WaitForChild("Vehicle")
        u1.force = u1.chasis:WaitForChild("VectorForce")
        u1.force2 = u1.chasis:WaitForChild("VectorForce2")
        u1.loadingChasis = false
        u1.chasisLoaded = true
        u1.chasis.Anchored = true
        v2, v1, v3 = initAttachments(u1)
        u1._mass = u1.chasis:GetMass()
        u1._worldAttach = v2
        u1._alignPosition = v1
        u1._alignOrientation = v3
        u1._fullyInitialized = true
    end

    u1.character = p1.Character
    if u1.character then
        setupCharacter(u1.character)
    end
    p1.CharacterAdded:Connect(function(p1) -- Line: 87 -- upvalues: setupCharacter (val)
        setupCharacter(p1)
    end)
    u1.isActive = false
    u1.isGrounded = false
    u1.floorMaterial = Enums.Material.Air
    u1._floorNormal = Vector3.new(0, 1, 0)
    u1._targetVelocity = Vector3.new(0, 0, 0)
    u1._turnForce = Vector3.new(0, 0, 0)
    u1._orientation = CFrame.new()
    u1._mode = Enums.PhysBallType.Default
    u1.acceleration = 1.25
    u1.speed = 25
    u1.jumpPower = 55
    u1.air_drag_const = 0.2
    u1.turn_brake_boost = 15
    u1.max_speed = 80
    local v2 = u34
    return (setmetatable(u1, v2))
end

function v1:Destroy() -- Line: 112
    self._worldAttach:Destroy()
    self.chasis:Destroy()
    self.isActive = false
end

function v1:setActive(p2, p3) -- Line: 118 -- upvalues: Enums (val)
    if not self.chasis.Parent then
        return
    end
    self.chasis.Parent = self.character
    self.chasis.Anchored = not p2
    self.chasis.CFrame = self.hrp.CFrame
    self.chasis.Velocity = Vector3.new()
    self.hrp.Velocity = Vector3.new()
    self._alignPosition.Enabled = p2
    self._alignOrientation.Enabled = p2
    self._orientation = self.hrp.CFrame - self.hrp.CFrame.p
    local Default = p3
    if not Default then
        Default = Enums.PhysBallType.Default
    end
    self._mode = Default
    self.isActive = p2
end

function v1.jump(p1) -- Line: 136
    local v1
    local chasis = p1.chasis
    local v2 = p1._floorNormal * 30
    if p1.isGrounded then
        v1 = 1
    else
        v1 = 1.1
    end
    local v3 = v2 * v1
    chasis:ApplyImpulse(v3)
end

function v1.update(p1, p2) -- Line: 140 -- upvalues: Enums (val), CurrentCamera (val)
    if not p1.humanoid.Sit and p1.humanoid.SeatPart == nil then
        local Air, Distance, Normal, Z_2, _floorNormal_2, _orientation_2, _turnForce, v1, v2, v3, v4, v5, v6, v7, v8
        if not p1.isActive then
            if p1.hrp and p1.chasis then
                p1.chasis.CFrame = p1.hrp.CFrame
            end
            p1.slideVector = CFrame.new()
            return
        end
        local v9 = RaycastParams.new()
        v9.IgnoreWater = true
        v9.RespectCanCollide = true
        v9.FilterType = Enums.RaycastFilterType.Exclude
        v9.FilterDescendantsInstances = {p1.character, workspace.Ignore, workspace.Zombies}
        local v10 = p1.chasis.Size.Y / 2 + 0.2
        local v11 = workspace
        local v12 = p1.chasis.Position + Vector3.new(0, 0.25, 0)
        v11 = v11:Spherecast(v12, v10, Vector3.new(0, -0.25, 0), v9)
        local Instance = nil
        local Material = nil
        if not v11 then
            Normal = Vector3.new(0, 1, 0)
        else
            Instance = v11.Instance
            Normal = v11.Normal
            Material = v11.Material
        end
        if not v11 then
            Distance = 5
        else
            Distance = v11.Distance
            if not Distance then
                Distance = 5
            end
        end
        local v13 = Distance <= 1.3
        p1.isGrounded = v13
        if not Material then
            v13 = 0
        else
            v13 = PhysicalProperties.new(Material).Friction * 2
            if not v13 then
                v13 = 0
            end
        end
        p1._floorFriction = v13
        if not (Distance <= p1.humanoid.HipHeight) then
            Air = Enums.Material.Air
        else
            Air = Material
            if not Air then
                Air = Enums.Material.Air
            end
        end
        p1._floorMaterial = Air
        if not Instance then
            _floorNormal_2 = p1._floorNormal
            v1 = math.min(p2, 1)
            v13 = _floorNormal_2:Lerp(Vector3.new(0, 1, 0), v1)
        else
            local _floorNormal
            if not p1.isGrounded then
                _floorNormal = p1._floorNormal
                v2 = p2 * 5
                v1 = math.min(v2, 1)
                v13 = _floorNormal:Lerp(Normal, v1)
                if not v13 then
                    _floorNormal_2 = p1._floorNormal
                    v1 = math.min(p2, 1)
                    v13 = _floorNormal_2:Lerp(Vector3.new(0, 1, 0), v1)
                end
            else
                v13 = Normal
                if not v13 then
                    _floorNormal = p1._floorNormal
                    v2 = p2 * 5
                    v1 = math.min(v2, 1)
                    v13 = _floorNormal:Lerp(Normal, v1)
                    if not v13 then
                        _floorNormal_2 = p1._floorNormal
                        v1 = math.min(p2, 1)
                        v13 = _floorNormal_2:Lerp(Vector3.new(0, 1, 0), v1)
                    end
                end
            end
        end
        p1._floorNormal = v13
        local v14 = CurrentCamera
        local unit = (v14.CFrame.lookVector * Vector3.new(1, 0, 1)).unit
        v14 = CFrame.new(Vector3.new(0, 0, 0), unit)
        local _floorNormal_3 = p1._floorNormal
        local v15 = v14:vectorToObjectSpace(_floorNormal_3)
        local v16 = -v15.X
        local Y = v15.Y
        v1 = math.atan2(v16, Y)
        local Z = v15.Z
        local Y_2 = v15.Y
        v2 = math.atan2(Z, Y_2)
        local v17 = (CFrame.Angles(v2, 0, 0)) * CFrame.Angles(0, 0, v1)
        v16 = (CFrame.Angles(0, 0, v1)) * (CFrame.Angles(v2, 0, 0))
        v14 = v14 * v17:Lerp(v16, 0.5)
        local speed = 0
        local MoveVector = p1.control:GetMoveVector()
        local X = MoveVector.X
        local Y_3 = MoveVector.Y
        if not (MoveVector.Z < 0) then
            Z_2 = MoveVector.Z
        else
            Z_2 = 0
        end
        local v18 = Vector3.new(X, Y_3, Z_2)
        local isGrounded = p1.isGrounded
        local Velocity = p1.chasis.Velocity
        local _floorNormal_4 = p1._floorNormal
        local v19 = Vector3.new(0, 1, 0):Dot(_floorNormal_4)
        if p1._mode == Enums.PhysBallType.Default then
            local unit_2
            speed = p1.speed
            if not (0 < (v18:Dot(v18))) then
                unit_2 = v18
            else
                unit_2 = v18.unit
                if not unit_2 then
                    unit_2 = v18
                end
            end
            v18 = unit_2
        elseif p1._mode == Enums.PhysBallType.Dive then
            local unit_3
            local speed_2 = p1.speed
            local magnitude = p1.chasis.Velocity.magnitude
            v3 = math.min(speed_2, magnitude)
            if v19 < 1 then
                v4 = v3
                if not v4 then
                    v4 = v3 * 0.1
                end
            elseif p1.isGrounded then
                v4 = v3 * 0.1
            else
                v4 = v3
                if not v4 then
                    v4 = v3 * 0.1
                end
            end
            speed = v4
            if not (0 < (v18:Dot(v18))) then
                unit_3 = Vector3.new(0, 0, 0)
            else
                unit_3 = v18.unit
                if not unit_3 then
                    unit_3 = Vector3.new(0, 0, 0)
                end
            end
            v18 = unit_3
        end
        v3 = workspace.Camera.CFrame.LookVector * 10
        local Y_4 = v3.Y
        v4 = v3 - Vector3.new(0, Y_4, 0)
        local v20 = -Velocity * (p1.air_drag_const + p1._floorFriction)
        local v21 = v14:vectorToWorldSpace(v18)
        local v22 = Velocity * Vector3.new(1, 0, 1)
        local v23 = 0
        if 1 < v22.magnitude and 0 < v21.magnitude then
            local unit_4 = v21.unit
            local unit_5 = v22.unit
            v6 = -unit_4:Dot(unit_5)
            v23 = math.clamp(v6, 0, 1)
        end
        if not (1 < Velocity.magnitude) then
            _orientation_2 = p1._orientation
        else
            local _orientation = p1._orientation
            v7 = CFrame.new(Vector3.new(), Velocity)
            v8 = p2 * 10
            local v24 = math.min(v8, 1)
            _orientation_2 = _orientation:lerp(v7, v24)
            if not _orientation_2 then
                _orientation_2 = p1._orientation
            end
        end
        p1._orientation = _orientation_2
        local turn_brake_boost = p1.turn_brake_boost
        v8 = v23
        local v25 = (1 - v8) * 1
        p1._turnForce = v21 * (v25 + v8 * turn_brake_boost) * speed
        local force = p1.force
        if not isGrounded then
            _turnForce = Vector3.new()
        else
            _turnForce = p1._turnForce
            if not _turnForce then
                _turnForce = Vector3.new()
            end
        end
        force.Force = _turnForce + v20
        local magnitude_2 = v22.magnitude
        if p1.max_speed < magnitude_2 then
            v5 = v22.unit * p1.max_speed
            local chasis_2 = p1.chasis
            local X_2 = v5.X
            local Y_5 = Velocity.Y
            local Z_3 = v5.Z
            chasis_2.AssemblyLinearVelocity = Vector3.new(X_2, Y_5, Z_3)
        end
        v5 = CFrame.lookAt(p1.hrp.CFrame.p, p1.hrp.CFrame.p + v4)
        v5 = v5 - v5.p
        v6 = CFrame.new(p1.chasis.CFrame.p + Vector3.new(0, 0.6000000238418579, 0)) * v5
        v7 = v6:VectorToObjectSpace(Normal)
        local LookVector = (CFrame.new()).LookVector
        local LookVector_2 = (CFrame.Angles(v7.z, 0, -v7.x)).LookVector
        v8 = LookVector:Dot(LookVector_2)
        v8 = 0.001 < math.acos(v8)
        p1.OnRamp = v8
        if not p1.slideVector then
            p1.slideVector = CFrame.new()
        end
        local slideVector = p1.slideVector
        local v26 = CFrame.Angles(v7.z, 0, -v7.x)
        local v27 = p2 * 10
        local v28 = math.min(v27, 1)
        p1.slideVector = slideVector:lerp(v26, v28)
        p1._worldAttach.CFrame = v6
        if p1._floorMaterial == Enums.Material.Water then
            p1.chasis.Anchored = true
        end
        return
    end
    if p1.isActive then
        p1:setActive(false)
    end
    p1.isGrounded = true
    p1.force.Force = Vector3.new(0, 0, 0)
    p1.slideVector = CFrame.new()
    if p1.hrp and p1.chasis then
        p1.chasis.CFrame = p1.hrp.CFrame
    end
end

return v1