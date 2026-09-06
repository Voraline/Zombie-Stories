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
local u34 = {__index = v1}
function v1.new(p1) -- Line: 49 -- upvalues: initChasis (val), initAttachments (val), Enums (val), u34 (val)
    local u1 = {}
    local PlayerScripts = p1:WaitForChild("PlayerScripts")
    local ControlScript = PlayerScripts:WaitForChild("ControlScript")
    u1.control = require(ControlScript:WaitForChild("MasterControl"))
    local function setupCharacter(p1) -- Line: 54 -- upvalues: u1 (val), initChasis (upval), initAttachments (upval)
        local v1, v2, v3
        u1.character = p1
        u1.humanoid = u1.character:WaitForChild("Humanoid")
        u1.hrp = u1.character:WaitForChild("HumanoidRootPart", 5)
        if not u1.hrp then
            return
        end
        u1.rootAttach = u1.hrp:WaitForChild("RootAttachment")
        u1.loadingChasis = true
        initChasis:InvokeServer(u1.humanoid)
        u1.chasis = u1.character:WaitForChild("Vehicle")
        u1.force = u1.chasis:WaitForChild("VectorForce")
        u1.force2 = u1.chasis:WaitForChild("VectorForce2")
        u1.loadingChasis = false
        u1.chasisLoaded = true
        u1.chasis.Anchored = true
        v1, v2, v3 = initAttachments(u1)
        u1._mass = u1.chasis:GetMass()
        u1._worldAttach = v1
        u1._alignPosition = v2
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
    return (setmetatable(u1, u34))
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
    if p1.isGrounded then
        v1 = 1
    else
        v1 = 1.1
    end
    p1.chasis:ApplyImpulse(p1._floorNormal * 30 * v1)
end
function v1.update(p1, p2) -- Line: 140 -- upvalues: Enums (val), CurrentCamera (val)
    if p1.humanoid.Sit then
        if p1.isActive then
            p1:setActive(false)
        end
        p1.isGrounded = true
        p1.force.Force = Vector3.new(0, 0, 0)
        p1.slideVector = CFrame.new()
        if p1.hrp and p1.chasis then
            p1.chasis.CFrame = p1.hrp.CFrame
        end
        return
    elseif p1.humanoid.SeatPart == nil then
        local Air, Distance, Normal, Z, _orientation, _turnForce, isGrounded, v1, v2, v3, v4, v5, v6
        if not p1.isActive then
            if p1.hrp and p1.chasis then
                p1.chasis.CFrame = p1.hrp.CFrame
            end
            p1.slideVector = CFrame.new()
            return
        end
        local v7 = RaycastParams.new()
        v7.IgnoreWater = true
        v7.RespectCanCollide = true
        v7.FilterType = Enums.RaycastFilterType.Exclude
        v7.FilterDescendantsInstances = {p1.character, workspace.Ignore, workspace.Zombies}
        local v8 = p1.chasis.Size.Y / 2 + 0.2
        local v9 = p1.chasis.Position + Vector3.new(0, 0.25, 0)
        local v10 = workspace:Spherecast(v9, v8, Vector3.new(0, -0.25, 0), v7)
        local Instance = nil
        local Material = nil
        if not v10 then
            Normal = Vector3.new(0, 1, 0)
        else
            Instance = v10.Instance
            Normal = v10.Normal
            Material = v10.Material
        end
        if not v10 then
            Distance = 5
        else
            Distance = v10.Distance
        end
        local v11 = Distance <= 1.3
        p1.isGrounded = v11
        if not Material then
            v11 = 0
        else
            v11 = PhysicalProperties.new(Material).Friction * 2
        end
        p1._floorFriction = v11
        if Distance > p1.humanoid.HipHeight then
            Air = Enums.Material.Air
        else
            Air = Material
        end
        p1._floorMaterial = Air
        if not Instance then
            v11 = p1._floorNormal:Lerp(Vector3.new(0, 1, 0), (math.min(p2, 1)))
        elseif not p1.isGrounded then
            v11 = p1._floorNormal:Lerp(Normal, (math.min(p2 * 5, 1)))
        else
            v11 = Normal
        end
        p1._floorNormal = v11
        local v12 = CFrame.new(Vector3.new(0, 0, 0), (CurrentCamera.CFrame.lookVector * Vector3.new(1, 0, 1)).unit)
        local v13 = v12:vectorToObjectSpace(p1._floorNormal)
        local v14 = math.atan2(-v13.X, v13.Y)
        local v15 = math.atan2(v13.Z, v13.Y)
        local v16 = CFrame.Angles(v15, 0, 0)
        local v17 = v16 * CFrame.Angles(0, 0, v14)
        local v18 = CFrame.Angles(0, 0, v14)
        v12 = v12 * v17:Lerp(v18 * CFrame.Angles(v15, 0, 0), 0.5)
        local speed = 0
        local MoveVector = p1.control:GetMoveVector()
        if MoveVector.Z >= 0 then
            Z = MoveVector.Z
        else
            Z = 0
        end
        local v19 = Vector3.new(MoveVector.X, MoveVector.Y, Z)
        isGrounded = p1.isGrounded
        local Velocity = p1.chasis.Velocity
        local v20 = Vector3.new(0, 1, 0):Dot(p1._floorNormal)
        if p1._mode == Enums.PhysBallType.Default then
            local unit
            speed = p1.speed
            v2 = v19:Dot(v19)
            if 0 >= v2 then
                unit = v19
            else
                unit = v19.unit
            end
            v19 = unit
        elseif p1._mode == Enums.PhysBallType.Dive then
            local unit_2
            v1 = math.min(p1.speed, p1.chasis.Velocity.magnitude)
            if v20 < 1 then
                v2 = v1
                if not v2 then
                    v2 = v1 * 0.1
                end
            elseif p1.isGrounded then
            end
            speed = v2
            v3 = v19:Dot(v19)
            if 0 >= v3 then
                unit_2 = Vector3.new(0, 0, 0)
            else
                unit_2 = v19.unit
            end
            v19 = unit_2
        end
        v1 = workspace.Camera.CFrame.LookVector * 10
        v2 = v1 - Vector3.new(0, v1.Y, 0)
        v3 = -Velocity * (p1.air_drag_const + p1._floorFriction)
        local v21 = v12:vectorToWorldSpace(v19)
        local v22 = Velocity * Vector3.new(1, 0, 1)
        local v23 = 0
        if 1 < v22.magnitude and 0 < v21.magnitude then
            v5 = -v21.unit:Dot(v22.unit)
            v23 = math.clamp(v5, 0, 1)
        end
        if 1 >= Velocity.magnitude then
            _orientation = p1._orientation
        else
            v6 = CFrame.new(Vector3.new(), Velocity)
            _orientation = p1._orientation:lerp(v6, (math.min(p2 * 10, 1)))
        end
        p1._orientation = _orientation
        local v24 = v23
        p1._turnForce = v21 * ((1 - v24) * 1 + v24 * p1.turn_brake_boost) * speed
        local force = p1.force
        if not isGrounded then
            _turnForce = Vector3.new()
        else
            _turnForce = p1._turnForce
        end
        force.Force = _turnForce + v3
        if p1.max_speed < v22.magnitude then
            v4 = v22.unit * p1.max_speed
            p1.chasis.AssemblyLinearVelocity = Vector3.new(v4.X, Velocity.Y, v4.Z)
        end
        v4 = CFrame.lookAt(p1.hrp.CFrame.p, p1.hrp.CFrame.p + v2)
        v5 = CFrame.new(p1.chasis.CFrame.p + Vector3.new(0, 0.6000000238418579, 0)) * (v4 - v4.p)
        v6 = v5:VectorToObjectSpace(Normal)
        v24 = 0.001 < math.acos((CFrame.new().LookVector:Dot(CFrame.Angles(v6.z, 0, -v6.x).LookVector)))
        p1.OnRamp = v24
        if not p1.slideVector then
            p1.slideVector = CFrame.new()
        end
        local v25 = CFrame.Angles(v6.z, 0, -v6.x)
        p1.slideVector = p1.slideVector:lerp(v25, (math.min(p2 * 10, 1)))
        p1._worldAttach.CFrame = v5
        if p1._floorMaterial == Enums.Material.Water then
            p1.chasis.Anchored = true
        end
        return
    end
end
return v1