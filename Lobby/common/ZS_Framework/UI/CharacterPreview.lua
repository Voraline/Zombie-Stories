game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local AvatarProvider = require(script.Parent.MarauderLoading.AvatarProvider)
local DragYaw = require(script.Parent.DragYaw)
local WepConfig = require(ReplicatedStorage.common.WepConfig)
local u30 = {}
u30.__index = u30
local u31 = {HumanoidRootPart = true, Head = true, Torso = true}
u31["Left Arm"] = true
u31["Right Arm"] = true
u31["Left Leg"] = true
u31["Right Leg"] = true
local function cloneModel(p1) -- Line: 32
    local v1, v2
    if not p1 or not (p1:IsA("Model")) then
        return nil
    end
    local Archivable = p1.Archivable
    p1.Archivable = true
    v1, v2 = pcall(function() -- Line: 38 -- upvalues: p1 (val)
        return p1:Clone()
    end)
    p1.Archivable = Archivable
    if not v1 or not v2 then
        return nil
    end
    if v2:IsA("Model") then
        return v2
    end
    return nil
end
local function jointParts(p1) -- Line: 45
    if p1:IsA("JointInstance") or p1:IsA("WeldConstraint") then
        return p1.Part0, p1.Part1
    end
    return nil, nil
end
local function motorKey(p1) -- Line: 52
    local Name_2, Name_3
    local Part0 = p1.Part0
    local Part1 = p1.Part1
    local concat = table.concat
    local v1 = {}
    local Name = p1.Name
    if not Part0 then
        Name_2 = ""
    else
        Name_2 = Part0.Name
    end
    if not Part1 then
        Name_3 = ""
    else
        Name_3 = Part1.Name
        if not Name_3 then
            Name_3 = ""
        end
    end
    v1[1] = Name
    v1[2] = Name_2
    v1[3] = Name_3
    return concat(v1, "|")
end
local function neutralizeFromTemplate(p1, p2) -- Line: 58 -- upvalues: u31 (val), motorKey (val)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
    local HumanoidRootPart_2 = p2
    if HumanoidRootPart_2 then
        HumanoidRootPart_2 = p2:FindFirstChild("HumanoidRootPart")
    end
    if not HumanoidRootPart then
        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            p1:PivotTo(CFrame.new())
        end
        for i, v in ipairs(p1:GetDescendants()) do
            if v:IsA("Motor6D") then
                v.Transform = CFrame.new()
            end
        end
        return
    elseif HumanoidRootPart:IsA("BasePart") and HumanoidRootPart_2 and HumanoidRootPart_2:IsA("BasePart") then
        local Part0, Part1, part0, part1, v1, v2, v3, v4, v5, v6
        local v7 = {}
        for k in pairs(u31) do
            v3 = p2:FindFirstChild(k)
            if v3 and v3:IsA("BasePart") then
                v7[k] = HumanoidRootPart_2.CFrame:ToObjectSpace(v3.CFrame)
            end
        end
        local v8 = {}
        v2, v1 = p2, p1
        for i2, i3 in ipairs(p1:GetDescendants()) do
            if i3:IsA("JointInstance") then
                Part0 = i3.Part0
                Part1 = i3.Part1
            elseif not (i3:IsA("WeldConstraint")) then
                Part0 = nil
                Part1 = nil
            end
            if Part0 and Part1 then
                if not (Part0:IsDescendantOf(v1)) then
                    i3:Destroy()
                elseif Part1:IsDescendantOf(v1) then
                    table.insert(v8, {part0 = Part0, part1 = Part1, relative = Part0.CFrame:ToObjectSpace(Part1.CFrame)})
                end
            end
        end
        local v9 = {}
        for i4, j in ipairs(v2:GetDescendants()) do
            if j:IsA("Motor6D") then
                v9[motorKey(j)] = j
            end
        end
        for i5, k2 in ipairs(v1:GetDescendants()) do
            if k2:IsA("Motor6D") then
                v4 = v9[motorKey(k2)]
                if v4 then
                    k2.C0 = v4.C0
                    k2.C1 = v4.C1
                end
                k2.Transform = CFrame.new()
            end
        end
        local v10 = {}
        for k3 in pairs(u31) do
            v5 = v1:FindFirstChild(k3)
            v6 = v7[k3]
            if v5 and v5:IsA("BasePart") and v6 then
                v5.CFrame = v6
                v10[v5] = true
            end
        end
        HumanoidRootPart.CFrame = CFrame.new()
        v10[HumanoidRootPart] = true
        local v11 = true
        while v11 do
            v11 = false
            for i6, n in ipairs(v8) do
                part0 = n.part0
                part1 = n.part1
                if part0.Parent and part1.Parent then
                    if not (v10[part0]) then
                        if v10[part1] and not (v10[part0]) then
                            part0.CFrame = part1.CFrame * n.relative:Inverse()
                            v10[part0] = true
                            v11 = true
                        end
                    elseif not (v10[part1]) then
                        part1.CFrame = part0.CFrame * n.relative
                        v10[part1] = true
                        v11 = true
                    end
                end
            end
        end
        for i7, m in ipairs(v1:GetDescendants()) do
            if m:IsA("BasePart") and not (v10[m]) then
                m:Destroy()
            end
        end
        return
    end
end
local function sanitizeRig(p1) -- Line: 163
    local v1
    local v2 = {"Vehicle", "Animate", "LoadoutModel"}
    for i, v in ipairs(v2) do
        v1 = p1:FindFirstChild(v)
        if v1 then
            v1:Destroy()
        end
    end
    local v3 = p1
    for i2, i3 in ipairs(p1:GetDescendants()) do
        if i3:IsA("LuaSourceContainer") then
            i3:Destroy()
        elseif not (i3:IsA("Tool")) and not (i3:IsA("Sound")) and not (i3:IsA("ParticleEmitter")) and not (i3:IsA("Trail")) and not (i3:IsA("Beam")) and not (i3:IsA("Smoke")) and not (i3:IsA("Fire")) and not (i3:IsA("Sparkles")) and not (i3:IsA("BodyMover")) and not (i3:IsA("LinearVelocity")) and not (i3:IsA("AngularVelocity")) and not (i3:IsA("VectorForce")) and not (i3:IsA("AlignPosition")) and not (i3:IsA("AlignOrientation")) and i3:IsA("BasePart") then
            i3.Anchored = false
            i3.CanCollide = false
            i3.CanTouch = false
            i3.CanQuery = false
            i3.Massless = true
            i3.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            i3.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
    local Humanoid = v3:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.AutoRotate = false
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        Humanoid.NameDisplayDistance = 0
    end
    local HumanoidRootPart = v3:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        HumanoidRootPart.Anchored = true
        v3.PrimaryPart = HumanoidRootPart
    end
    v3.Archivable = true
    return v3
end
local function createCanonicalRig(p1, p2, p3) -- Line: 218 -- upvalues: cloneModel (val), AvatarProvider (val), neutralizeFromTemplate (val), sanitizeRig (val)
    local v1 = cloneModel(p2)
    if p3 then
        local HolsterCosmetics = v1
        if HolsterCosmetics then
            HolsterCosmetics = v1:FindFirstChild("HolsterCosmetics")
        end
        if HolsterCosmetics then
            HolsterCosmetics:Destroy()
        end
    end
    local v2 = AvatarProvider.GetR6Clone(p1)
    if not v2 then
        v2 = AvatarProvider.GetFallbackR6Clone()
    end
    local v3 = v1
    if not v3 then
        v3 = v2
        if v3 then
            v3 = v2:Clone()
        end
    end
    if not v3 then
        return nil
    end
    if not v2 then
        neutralizeFromTemplate(v3, v3)
    else
        neutralizeFromTemplate(v3, v2)
    end
    if v2 then
        v2:Destroy()
    end
    return (sanitizeRig(v3))
end
local function cleanViewmodel(p1) -- Line: 246
    local KeyParts
    for i, v in ipairs(p1:GetChildren()) do
        if v.Name ~= "KeyParts" and v.Name ~= "Weapon" and v.Name ~= "Attachments" and v.Name ~= "GlobalParts" and v.Name ~= "Animations" then
            v:Destroy()
        end
    end
    KeyParts = p1:FindFirstChild("KeyParts")
    if not KeyParts then
        return nil
    end
    local Mag2 = KeyParts:FindFirstChild("Mag2")
    if Mag2 then
        Mag2:Destroy()
    end
    local ViewCenter = KeyParts:FindFirstChild("ViewCenter")
    if ViewCenter and ViewCenter:IsA("BasePart") then
        p1.PrimaryPart = ViewCenter
    end
    return KeyParts:FindFirstChild("Handle")
end
local function scaleModel(p1, p2) -- Line: 274
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Size = v.Size * p2
        elseif v:IsA("JointInstance") and v.Name ~= "Grip" then
            v.C0 = v.C0 - v.C0.Position + v.C0.Position * p2
            v.C1 = v.C1 - v.C1.Position + v.C1.Position * p2
        end
    end
end
local function getRootCenteredExtents(p1) -- Line: 285
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local Pivot = p1:GetPivot()
    local v11 = (1 / 0)
    local v12 = (-1 / 0)
    local v13 = 0
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "PreviewPivot" then
            v1 = v.Size * 0.5
            v2 = 1
            v3 = 2
            for i2 = -1, v2, v3 do
                v4 = 1
                v5 = 2
                for j = -1, v4, v5 do
                    v6 = 1
                    v7 = 2
                    for k = -1, v6, v7 do
                        v9 = v1.X * i2
                        v10 = v1.Y * j
                        v8 = Pivot:PointToObjectSpace(v.CFrame:PointToWorldSpace((Vector3.new(v9, v10, v1.Z * k))))
                        v11 = math.min(v11, v8.Y)
                        v12 = math.max(v12, v8.Y)
                        v13 = math.max(v13, Vector2.new(v8.X, v8.Z).Magnitude)
                    end
                end
            end
        end
    end
    if v11 == (1 / 0) then
        return -3, 3, 3
    end
    return v11, v12, (math.max(v13, 0.1))
end
function u30:_playAnimation(p2) -- Line: 315
    local v1, v2
    if self.destroyed or not p2 or not (p2:IsA("Animation")) or not self.rig then
        return
    end
    local Humanoid = self.rig:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        return
    end
    local Animator = Humanoid:FindFirstChildOfClass("Animator")
    if not Animator then
        Animator = Instance.new("Animator")
    end
    Animator.Parent = Humanoid
    v1, v2 = pcall(function() -- Line: 325 -- upvalues: Animator (val), p2 (val)
        return Animator:LoadAnimation(p2)
    end)
    if not v1 or not v2 or self.destroyed then
        return
    end
    if self.animationTrack then
        pcall(function() -- Line: 332 -- upvalues: self (val)
            self.animationTrack:Stop(0.1)
        end)
    end
    v2.Looped = true
    v2:Play(0.1)
    self.animationTrack = v2
end
function u30:_fitCamera() -- Line: 341 -- upvalues: getRootCenteredExtents (val)
    local v1, v2, v3
    local viewport = self.viewport
    local previewModel = self.previewModel
    local camera = self.camera
    if self.destroyed or not viewport or not previewModel or not camera or viewport.AbsoluteSize.X <= 0 or viewport.AbsoluteSize.Y <= 0 then
        return
    end
    v1, v2, v3 = getRootCenteredExtents(previewModel)
    local v4 = math.max(v2 - v1, 0.1)
    local v5 = (v1 + v2) * 0.5 + v4 * (self.focusOffset or 0.08)
    local v6 = math.max(v2 - v5, v5 - v1)
    local v7 = math.rad(camera.FieldOfView * 0.5)
    local v8 = v3 + v3 / math.tan((math.atan(math.tan(v7) * (viewport.AbsoluteSize.X / viewport.AbsoluteSize.Y))))
    local v9 = math.max(v8, v3 + v6 / math.tan(v7))
    local v10 = v9 * (self.cameraPadding or 1.04)
    v9 = Vector3.new(0, v5, 0)
    local v11 = Vector3.new(0, v5, v10)
    camera.CFrame = CFrame.lookAt(v11, v9)
end
function u30:_applyRotation() -- Line: 370
    if not self.destroyed and self.previewModel and self.previewModel.Parent then
        self.previewModel:PivotTo(CFrame.Angles(0, self.yaw, 0))
    end
end
function u30:_bindDrag() -- Line: 376 -- upvalues: DragYaw (val)
    self.drag = DragYaw.bind({
        Surface = self.viewport,
        Sensitivity = self.dragSensitivity,
        InitialYaw = self.yaw,
        OnChanged = function(p1) -- Line: 381 -- upvalues: self (val)
            self.yaw = p1
            self:_applyRotation()
        end,
    })
end
function u30:_attachWeapon() -- Line: 388 -- upvalues: WepConfig (val), cleanViewmodel (val), scaleModel (val), RunService (val)
    local rig, weaponName
    if self.destroyed or not self.weaponName or not self.rig then
        return
    end
    rig = self.rig
    local v1 = WepConfig:StreamViewmodel(self.weaponName)
    v1 = v1:andThen(function(p1) -- Line: 394 -- upvalues: self (val), rig (val), WepConfig (upval), cleanViewmodel (upval), scaleModel (upval), RunService (upval)
        local Motor6D, WorldScaleValue, v1, v2, v3
        if self.destroyed or not rig.Parent then
            return
        end
        local v4 = p1:Clone()
        local weaponId = self.weaponId
        if not weaponId then
            weaponId = self.weaponName
        end
        local WeaponConfig = WepConfig:GetWeaponConfig(weaponId)
        local v5 = cleanViewmodel(v4)
        if not v5 or not (v5:IsA("BasePart")) then
            v4:Destroy()
            return
        end
        if not WeaponConfig then
            WorldScaleValue = 1
        else
            WorldScaleValue = WeaponConfig.WorldScaleValue
        end
        scaleModel(v4, WorldScaleValue)
        local RightHand = rig:FindFirstChild("Right Arm")
        if not RightHand then
            RightHand = rig:FindFirstChild("RightHand")
        end
        if not RightHand or not (RightHand:IsA("BasePart")) then
            v4:Destroy()
            return
        end
        local Grip = v5:FindFirstChild("Grip")
        if not Grip then
            v1 = RightHand
            if Grip and Grip:IsA("StringValue") then
                v2 = rig:FindFirstChild(Grip.Value)
                if v2 and v2:IsA("BasePart") then
                    v1 = v2
                end
            end
            if Grip then
                Grip:Destroy()
            end
            Motor6D = Instance.new("Motor6D")
            Motor6D.Name = "Grip"
            Motor6D.Part0 = v1
            Motor6D.Part1 = v5
            local v6 = CFrame.new(0, -1.1, -0.2)
            Motor6D.C0 = v6 * CFrame.Angles(3.141592653589793, 0, 0)
            Motor6D.Parent = RightHand
        elseif Grip:IsA("Motor6D") then
            local BodyPart = Grip:FindFirstChild("BodyPart")
            v2 = BodyPart
            if v2 then
                v2 = BodyPart:IsA("StringValue")
                if v2 then
                    v2 = rig:FindFirstChild(BodyPart.Value)
                end
            end
            if not v2 then
                v3 = RightHand
            elseif v2:IsA("BasePart") then
                v3 = v2
            end
            Grip.Part0 = v3
            Grip.Part1 = v5
            Grip.Parent = RightHand
        end
        v4.Name = "PreviewWeapon"
        v4.Parent = rig
        v1 = nil
        if WeaponConfig and WeaponConfig.UseIdleForPreview then
            local Animations = v4:FindFirstChild("Animations")
            v3 = Animations
            if v3 then
                v3 = Animations:FindFirstChild("3P")
            end
            local Idle3P = v3
            if Idle3P then
                Idle3P = v3:FindFirstChild("Idle3P")
            end
            v1 = Idle3P
        end
        if not v1 and self.animations then
            if not WeaponConfig then
                v2 = "StandingGunV1"
            elseif not WeaponConfig.IsMelee then
                v2 = "StandingGunV1"
            else
                v2 = "StandingMeleeV1"
            end
            v1 = self.animations:FindFirstChild(v2)
        end
        self:_playAnimation(v1)
        task.defer(function() -- Line: 453 -- upvalues: self (upval), RunService (upval)
            if self.destroyed then
                return
            end
            RunService.RenderStepped:Wait()
            RunService.RenderStepped:Wait()
            self:_fitCamera()
        end)
    end)
    v1:catch(function() end)
end
function u30:_attachHolsters() -- Line: 465 -- upvalues: WepConfig (val)
    local rig, v1
    if self.destroyed or not self.rig or not self.holsterWeapons or not self.attachHolster then
        return
    end
    rig = self.rig
    local Folder = Instance.new("Folder")
    Folder.Name = "HolsterCosmetics"
    Folder.Parent = rig
    for k, v in pairs(self.holsterWeapons) do
        if not (table.find(self.removeHolsters, k)) then
            v1 = WepConfig:StreamViewmodel(v)
            v1 = v1:andThen(function(p1) -- Line: 476 -- upvalues: self (val), rig (val), k (val), Folder (val)
                local v1, v2
                if self.destroyed or not rig.Parent then
                    p1:Destroy()
                    return
                end
                v1, v2 = pcall(self.attachHolster, p1, rig, k, Folder)
                if not v1 or not v2 then
                    p1:Destroy()
                    return
                end
                self:_fitCamera()
            end)
            v1:catch(function() end)
        end
    end
end
function u30:_build() -- Line: 494 -- upvalues: createCanonicalRig (val), RunService (val)
    local v1
    local v2 = self.holsterWeapons ~= nil
    local v3 = createCanonicalRig(self.userId, self.appearanceSource, v2)
    if self.destroyed then
        if v3 then
            v3:Destroy()
        end
        return
    end
    if not v3 then
        return
    end
    self.rig = v3
    local HolsterCosmetics = v3:FindFirstChild("HolsterCosmetics")
    local v4 = self
    for i, v in ipairs(self.removeHolsters) do
        v1 = HolsterCosmetics
        if v1 then
            v1 = HolsterCosmetics:FindFirstChild(v)
        end
        if v1 then
            v1:Destroy()
        end
    end
    local WorldModel = Instance.new("WorldModel")
    WorldModel.Name = v4.worldName
    v4.world = WorldModel
    local Model = Instance.new("Model")
    Model.Name = "CenteredCharacter"
    Model.Parent = WorldModel
    v3.Parent = Model
    local Part = Instance.new("Part")
    Part.Name = "PreviewPivot"
    Part.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806)
    Part.CFrame = CFrame.new()
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.Parent = Model
    Model.PrimaryPart = Part
    v4.previewModel = Model
    local Camera = Instance.new("Camera")
    Camera.Name = "CharacterPreviewCamera"
    Camera.FieldOfView = v4.fieldOfView
    Camera.Parent = v4.viewport
    v4.camera = Camera
    WorldModel.Parent = v4.viewport
    v4.viewport.CurrentCamera = Camera
    local animations = v4.animations
    if animations then
        animations = v4.animations:FindFirstChild("StandingGunV1")
    end
    v4:_playAnimation(animations)
    v4:_applyRotation()
    v4:_bindDrag()
    v1 = 2
    local v5 = 1
    for i2 = 1, v1, v5 do
        if 0 < v4.viewport.AbsoluteSize.X and 0 < v4.viewport.AbsoluteSize.Y then
            break
        end
        RunService.RenderStepped:Wait()
    end
    if v4.destroyed then
        return
    end
    RunService.RenderStepped:Wait()
    v4:_fitCamera()
    v4:_attachHolsters()
    v4:_attachWeapon()
    if v4.onReady then
        task.defer(v4.onReady, v4)
    end
end
function u30:Destroy() -- Line: 567
    if self.destroyed then
        return
    end
    self.destroyed = true
    if self.drag then
        self.drag:Destroy()
        self.drag = nil
    end
    for i, v in ipairs(self.connections) do
        v:Disconnect()
    end
    table.clear(self.connections)
    if self.animationTrack then
        pcall(function() -- Line: 581 -- upvalues: self (val)
            self.animationTrack:Stop(0)
        end)
        self.animationTrack = nil
    end
    if self.viewport and self.viewport.CurrentCamera == self.camera then
        self.viewport.CurrentCamera = nil
    end
    if self.world then
        self.world:Destroy()
        self.world = nil
    end
    if self.camera then
        self.camera:Destroy()
        self.camera = nil
    end
    self.rig = nil
    self.previewModel = nil
end
function u30.Mount(p1) -- Line: 601 -- upvalues: u30 (val)
    local v1 = type(p1) == "table"
    assert(v1, "CharacterPreview.Mount requires a config table")
    local ViewportFrame = p1.ViewportFrame
    if ViewportFrame then
        ViewportFrame = p1.ViewportFrame:IsA("ViewportFrame")
    end
    assert(ViewportFrame, "ViewportFrame is required")
    v1 = {
        destroyed = false,
        viewport = p1.ViewportFrame,
        userId = tonumber(p1.UserId) or 0,
        appearanceSource = p1.AppearanceSource,
        weaponId = p1.WeaponId,
        weaponName = p1.WeaponName,
        animations = p1.Animations,
        worldName = p1.WorldName or "CharacterPreviewWorld",
        fieldOfView = tonumber(p1.FieldOfView) or 35,
        cameraPadding = tonumber(p1.CameraPadding) or 1.04,
        focusOffset = tonumber(p1.FocusOffset) or 0.08,
        dragSensitivity = tonumber(p1.DragSensitivity) or 0.012,
        yaw = tonumber(p1.InitialYaw) or 3.141592653589793,
    }
    local RemoveHolsters = p1.RemoveHolsters
    if not RemoveHolsters then
        RemoveHolsters = {"HolsterPrimary"}
    end
    v1.removeHolsters = RemoveHolsters
    v1.holsterWeapons = p1.HolsterWeapons
    v1.attachHolster = p1.AttachHolster
    v1.onReady = p1.OnReady
    v1.connections = {}
    local u66 = setmetatable(v1, u30)
    task.spawn(function() -- Line: 627 -- upvalues: u66 (val)
        u66:_build()
    end)
    return u66
end
return u30