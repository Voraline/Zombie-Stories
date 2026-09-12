game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local AvatarProvider = require(script.Parent.MarauderLoading.AvatarProvider)
local DragYaw = require(script.Parent.DragYaw)
local WepConfig = require(ReplicatedStorage.common.WepConfig)
local u30 = {}
u30.__index = u30
local u31 = {
    HumanoidRootPart = true,
    Head = true,
    Torso = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
}

local function cloneModel(p1) -- Line: 32
    if p1 and p1:IsA("Model") then
        local Archivable = p1.Archivable
        p1.Archivable = true
        local success, result = pcall(function() -- Line: 38 -- upvalues: p1 (val)
            return p1:Clone()
        end)
        p1.Archivable = Archivable
        if success and result and result:IsA("Model") then
            return result
        end
        return nil
    end
    return nil
end

local function jointParts(p1) -- Line: 45
    if not p1:IsA("JointInstance") and not p1:IsA("WeldConstraint") then
        return nil, nil
    end
    return p1.Part0, p1.Part1
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
        if not Name_2 then
            Name_2 = ""
        end
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
    local v1
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
    local HumanoidRootPart_2 = p2
    if HumanoidRootPart_2 then
        HumanoidRootPart_2 = p2:FindFirstChild("HumanoidRootPart")
    end
    if HumanoidRootPart
        and HumanoidRootPart:IsA("BasePart")
        and HumanoidRootPart_2
        and HumanoidRootPart_2:IsA("BasePart") then
        local CFrame_2, CFrame_3, CFrame_4, CFrame_5, Part0, Part1, part0, part1, v2, v3, v4, v5, v6
        local v7 = {}
        for k in pairs(u31) do
            v2 = p2:FindFirstChild(k)
            if v2 and v2:IsA("BasePart") then
                CFrame_4 = HumanoidRootPart_2.CFrame
                CFrame_5 = v2.CFrame
                v7[k] = (CFrame_4:ToObjectSpace(CFrame_5))
            end
        end
        local v8 = {}
        local v9, v10 = p2, p1
        for i, v in ipairs(p1:GetDescendants()) do
            if v:IsA("JointInstance") then
                Part0 = v.Part0
                Part1 = v.Part1
            elseif not v:IsA("WeldConstraint") then
                Part0 = nil
                Part1 = nil
            else
                Part0 = v.Part0
                Part1 = v.Part1
            end
            if Part0 and Part1 then
                if not Part0:IsDescendantOf(v10) or not Part1:IsDescendantOf(v10) then
                    v:Destroy()
                else
                    v6 = {part0 = Part0, part1 = Part1}
                    CFrame_2 = Part0.CFrame
                    CFrame_3 = Part1.CFrame
                    v6.relative = CFrame_2:ToObjectSpace(CFrame_3)
                    table.insert(v8, v6)
                end
            end
        end
        v1 = {}
        for i2, i3 in ipairs(v9:GetDescendants()) do
            if i3:IsA("Motor6D") then
                v1[motorKey(i3)] = i3
            end
        end
        for i4, j in ipairs(v10:GetDescendants()) do
            if j:IsA("Motor6D") then
                v3 = v1[motorKey(j)]
                if v3 then
                    j.C0 = v3.C0
                    j.C1 = v3.C1
                end
                j.Transform = CFrame.new()
            end
        end
        local v11 = {}
        for k2 in pairs(u31) do
            v4 = v10:FindFirstChild(k2)
            v5 = v7[k2]
            if v4 and v4:IsA("BasePart") and v5 then
                v4.CFrame = v5
                v11[v4] = true
            end
        end
        HumanoidRootPart.CFrame = CFrame.new()
        v11[HumanoidRootPart] = true
        local v12 = true
        while v12 do
            v12 = false
            for i5, k3 in ipairs(v8) do
                part0 = k3.part0
                part1 = k3.part1
                if part0.Parent and part1.Parent then
                    if not v11[part0] then
                        if v11[part1] and not v11[part0] then
                            part0.CFrame = part1.CFrame * k3.relative:Inverse()
                            v11[part0] = true
                            v12 = true
                        end
                    elseif not v11[part1] then
                        part1.CFrame = part0.CFrame * k3.relative
                        v11[part1] = true
                        v12 = true
                    elseif v11[part1] and not v11[part0] then
                        part0.CFrame = part1.CFrame * k3.relative:Inverse()
                        v11[part0] = true
                        v12 = true
                    end
                end
            end
        end
        for i6, n in ipairs(v10:GetDescendants()) do
            if n:IsA("BasePart") and not v11[n] then
                n:Destroy()
            end
        end
        return
    end
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        v1 = CFrame.new()
        p1:PivotTo(v1)
    end
    for i7, m in ipairs(p1:GetDescendants()) do
        if m:IsA("Motor6D") then
            m.Transform = CFrame.new()
        end
    end
end

local function sanitizeRig(p1) -- Line: 163
    local v1
    local v2 = ipairs
    local v3 = {"Vehicle", "Animate", "LoadoutModel"}
    for i, v in v2(v3) do
        v1 = p1:FindFirstChild(v)
        if v1 then
            v1:Destroy()
        end
    end
    local v4 = p1
    for i2, i3 in ipairs(p1:GetDescendants()) do
        if i3:IsA("LuaSourceContainer")
            or i3:IsA("Tool")
            or i3:IsA("Sound")
            or i3:IsA("ParticleEmitter")
            or i3:IsA("Trail")
            or i3:IsA("Beam")
            or i3:IsA("Smoke")
            or i3:IsA("Fire")
            or i3:IsA("Sparkles")
            or i3:IsA("BodyMover")
            or i3:IsA("LinearVelocity")
            or i3:IsA("AngularVelocity")
            or i3:IsA("VectorForce")
            or i3:IsA("AlignPosition")
            or i3:IsA("AlignOrientation") then
            i3:Destroy()
        elseif i3:IsA("BasePart") then
            i3.Anchored = false
            i3.CanCollide = false
            i3.CanTouch = false
            i3.CanQuery = false
            i3.Massless = true
            i3.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            i3.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end
    end
    local Humanoid = v4:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.AutoRotate = false
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
        Humanoid.NameDisplayDistance = 0
    end
    local HumanoidRootPart = v4:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        HumanoidRootPart.Anchored = true
        v4.PrimaryPart = HumanoidRootPart
    end
    v4.Archivable = true
    return v4
end

local function createCanonicalRig(p1, p2, p3) -- Line: 218
    -- upvalues: cloneModel (val), AvatarProvider (val), neutralizeFromTemplate (val), sanitizeRig (val)
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
    for i, v in ipairs(p1:GetChildren()) do
        if v.Name ~= "KeyParts"
            and v.Name ~= "Weapon"
            and v.Name ~= "Attachments"
            and v.Name ~= "GlobalParts"
            and v.Name ~= "Animations" then
            v:Destroy()
        end
    end
    local KeyParts = p1:FindFirstChild("KeyParts")
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
    local v1
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Size = v.Size * p2
        elseif v:IsA("JointInstance") and v.Name ~= "Grip" then
            v1 = v.C0 - v.C0.Position
            v.C0 = v1 + v.C0.Position * p2
            v1 = v.C1 - v.C1.Position
            v.C1 = v1 + v.C1.Position * p2
        end
    end
end

local function getRootCenteredExtents(p1) -- Line: 285
    local CFrame, Magnitude, Y, Y_2, v1, v2, v3, v4, v5, v6, v7
    local Pivot = p1:GetPivot()
    local v8 = (1 / 0)
    local v9 = (-1 / 0)
    local v10 = 0
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "PreviewPivot" then
            v1 = v.Size * 0.5
            for i2 = -1, 1, 2 do
                for j = -1, 1, 2 do
                    for k = -1, 1, 2 do
                        CFrame = v.CFrame
                        v5 = v1.X * i2
                        v6 = v1.Y * j
                        v7 = v1.Z * k
                        v4 = Vector3.new(v5, v6, v7)
                        v3 = CFrame:PointToWorldSpace(v4)
                        v2 = Pivot:PointToObjectSpace(v3)
                        Y = v2.Y
                        v8 = math.min(v8, Y)
                        Y_2 = v2.Y
                        v9 = math.max(v9, Y_2)
                        Magnitude = (Vector2.new(v2.X, v2.Z)).Magnitude
                        v10 = math.max(v10, Magnitude)
                    end
                end
            end
        end
    end
    if v8 == (1 / 0) then
        return -3, 3, 3
    end
    return v8, v9, (math.max(v10, 0.1))
end

function u30:_playAnimation(p2) -- Line: 315
    if not self.destroyed and p2 and p2:IsA("Animation") and self.rig then
        local Humanoid = self.rig:FindFirstChildOfClass("Humanoid")
        if not Humanoid then
            return
        end
        local Animator = Humanoid:FindFirstChildOfClass("Animator")
        if not Animator then
            Animator = Instance.new("Animator")
        end
        Animator.Parent = Humanoid
        local success, result = pcall(function() -- Line: 325 -- upvalues: Animator (val), p2 (val)
            local v1 = Animator
            local v2 = p2
            return v1:LoadAnimation(v2)
        end)
        if success and result and not self.destroyed then
            if self.animationTrack then
                pcall(function() -- Line: 332 -- upvalues: self (val)
                    self.animationTrack:Stop(0.1)
                end)
            end
            result.Looped = true
            result:Play(0.1)
            self.animationTrack = result
            return
        end
        return
    end
end

function u30:_fitCamera() -- Line: 341 -- upvalues: getRootCenteredExtents (val)
    local viewport = self.viewport
    local previewModel = self.previewModel
    local camera = self.camera
    if not self.destroyed
        and viewport
        and previewModel
        and camera
        and not (viewport.AbsoluteSize.X <= 0)
        and not (viewport.AbsoluteSize.Y <= 0) then
        local v1, v2, v3 = getRootCenteredExtents(previewModel)
        local v4 = v2 - v1
        local v5 = math.max(v4, 0.1)
        v4 = (v1 + v2) * 0.5 + v5 * (self.focusOffset or 0.08)
        local v6 = v2 - v4
        local v7 = v4 - v1
        local v8 = math.max(v6, v7)
        v7 = camera.FieldOfView * 0.5
        v6 = math.rad(v7)
        v7 = viewport.AbsoluteSize.X / viewport.AbsoluteSize.Y
        local v9 = (math.tan(v6)) * v7
        local v10 = math.atan(v9)
        v9 = v3 + v3 / math.tan(v10)
        local v11 = v3 + v8 / (math.tan(v6))
        local v12 = (math.max(v9, v11)) * (self.cameraPadding or 1.04)
        local v13 = Vector3.new(0, v4, 0)
        camera.CFrame = CFrame.lookAt(Vector3.new(0, v4, v12), v13)
        return
    end
end

function u30:_applyRotation() -- Line: 370
    if not self.destroyed and self.previewModel and self.previewModel.Parent then
        local previewModel = self.previewModel
        local v1 = CFrame.Angles(0, self.yaw, 0)
        previewModel:PivotTo(v1)
    end
end

function u30:_bindDrag() -- Line: 376 -- upvalues: DragYaw (val)
    local v1 = DragYaw
    local bind = v1.bind
    local v2 = {
        Surface = self.viewport,
        Sensitivity = self.dragSensitivity,
        InitialYaw = self.yaw,
        OnChanged = function(p1) -- Line: 381 -- upvalues: self (val)
            self.yaw = p1
            self:_applyRotation()
        end,
    }
    self.drag = bind(v2)
end

function u30:_attachWeapon() -- Line: 388
    -- upvalues: WepConfig (val), cleanViewmodel (val), scaleModel (val), RunService (val)
    if not self.destroyed and self.weaponName and self.rig then
        local rig = self.rig
        local v1 = WepConfig
        local weaponName = self.weaponName
        v1 = v1:StreamViewmodel(weaponName)
        v1 = v1:andThen(function(p1) -- Line: 394
            -- upvalues: self (val), rig (val), WepConfig (upval), cleanViewmodel (upval), scaleModel (upval)
            -- upvalues: RunService (upval)
            if not self.destroyed and rig.Parent then
                local v1 = p1:Clone()
                local v2 = WepConfig
                local weaponId = self.weaponId
                if not weaponId then
                    weaponId = self.weaponName
                end
                local WeaponConfig = v2:GetWeaponConfig(weaponId)
                local v3 = cleanViewmodel(v1)
                if v3 and v3:IsA("BasePart") then
                    local WorldScaleValue
                    local v4 = scaleModel
                    local v5 = v1
                    if not WeaponConfig then
                        WorldScaleValue = 1
                    else
                        WorldScaleValue = WeaponConfig.WorldScaleValue
                        if not WorldScaleValue then
                            WorldScaleValue = 1
                        end
                    end
                    v4(v5, WorldScaleValue)
                    local RightHand = rig:FindFirstChild("Right Arm")
                    if not RightHand then
                        RightHand = rig:FindFirstChild("RightHand")
                    end
                    if RightHand and RightHand:IsA("BasePart") then
                        local v6, v7, v8
                        local Grip = v3:FindFirstChild("Grip")
                        if not Grip or not Grip:IsA("Motor6D") then
                            v6 = RightHand
                            if Grip and Grip:IsA("StringValue") then
                                v7 = rig
                                local Value_2 = Grip.Value
                                v7 = v7:FindFirstChild(Value_2)
                                if v7 and v7:IsA("BasePart") then
                                    v6 = v7
                                end
                            end
                            if Grip then
                                Grip:Destroy()
                            end
                            local Motor6D = Instance.new("Motor6D")
                            Motor6D.Name = "Grip"
                            Motor6D.Part0 = v6
                            Motor6D.Part1 = v3
                            Motor6D.C0 = (CFrame.new(0, -1.1, -0.2)) * CFrame.Angles(3.141592653589793, 0, 0)
                            Motor6D.Parent = RightHand
                        else
                            local BodyPart = Grip:FindFirstChild("BodyPart")
                            v7 = BodyPart
                            if v7 then
                                v7 = BodyPart:IsA("StringValue")
                                if v7 then
                                    v7 = rig
                                    local Value = BodyPart.Value
                                    v7 = v7:FindFirstChild(Value)
                                end
                            end
                            if not v7 or not v7:IsA("BasePart") then
                                v8 = RightHand
                            else
                                v8 = v7
                            end
                            Grip.Part0 = v8
                            Grip.Part1 = v3
                            Grip.Parent = RightHand
                        end
                        v1.Name = "PreviewWeapon"
                        v1.Parent = rig
                        v6 = nil
                        if WeaponConfig and WeaponConfig.UseIdleForPreview then
                            local Animations = v1:FindFirstChild("Animations")
                            v8 = Animations
                            if v8 then
                                v8 = Animations:FindFirstChild("3P")
                            end
                            local Idle3P = v8
                            if Idle3P then
                                Idle3P = v8:FindFirstChild("Idle3P")
                            end
                            v6 = Idle3P
                        end
                        if not v6 and self.animations then
                            if not WeaponConfig or not WeaponConfig.IsMelee then
                                v7 = "StandingGunV1"
                            else
                                v7 = "StandingMeleeV1"
                            end
                            v6 = self.animations:FindFirstChild(v7)
                        end
                        self:_playAnimation(v6)
                        task.defer(function() -- Line: 453 -- upvalues: self (upval), RunService (upval)
                            if self.destroyed then
                                return
                            end
                            RunService.RenderStepped:Wait()
                            RunService.RenderStepped:Wait()
                            self:_fitCamera()
                        end)
                        return
                    end
                    v1:Destroy()
                    return
                end
                v1:Destroy()
                return
            end
        end)
        v1:catch(function() end)
        return
    end
end

function u30:_attachHolsters() -- Line: 465 -- upvalues: WepConfig (val)
    if not self.destroyed and self.rig and self.holsterWeapons and self.attachHolster then
        local rig = self.rig
        local Folder = Instance.new("Folder")
        Folder.Name = "HolsterCosmetics"
        Folder.Parent = rig
        for k, v in pairs(self.holsterWeapons) do
            if not table.find(self.removeHolsters, k) then
                ((WepConfig:StreamViewmodel(v)):andThen(function(p1) -- Line: 476 -- upvalues: self (val), rig (val), k (val), Folder (val)
                    if not self.destroyed and rig.Parent then
                        local success, result = pcall(self.attachHolster, p1, rig, k, Folder)
                        if success and result then
                            self:_fitCamera()
                            return
                        end
                        p1:Destroy()
                        return
                    end
                    p1:Destroy()
                end)):catch(function() end)
            end
        end
        return
    end
end

function u30:_build() -- Line: 494 -- upvalues: createCanonicalRig (val), RunService (val)
    local v1
    local v2 = createCanonicalRig
    local userId = self.userId
    local appearanceSource = self.appearanceSource
    local v3 = self.holsterWeapons ~= nil
    v2 = v2(userId, appearanceSource, v3)
    if self.destroyed then
        if v2 then
            v2:Destroy()
        end
        return
    end
    if not v2 then
        return
    end
    self.rig = v2
    local HolsterCosmetics = v2:FindFirstChild("HolsterCosmetics")
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
    v2.Parent = Model
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
    for i2 = 1, 2 do
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
    v1 = {destroyed = false, viewport = p1.ViewportFrame}
    local UserId = p1.UserId
    v1.userId = tonumber(UserId) or 0
    v1.appearanceSource = p1.AppearanceSource
    v1.weaponId = p1.WeaponId
    v1.weaponName = p1.WeaponName
    v1.animations = p1.Animations
    v1.worldName = p1.WorldName or "CharacterPreviewWorld"
    local FieldOfView = p1.FieldOfView
    v1.fieldOfView = tonumber(FieldOfView) or 35
    local CameraPadding = p1.CameraPadding
    v1.cameraPadding = tonumber(CameraPadding) or 1.04
    local FocusOffset = p1.FocusOffset
    v1.focusOffset = tonumber(FocusOffset) or 0.08
    local DragSensitivity = p1.DragSensitivity
    v1.dragSensitivity = tonumber(DragSensitivity) or 0.012
    local InitialYaw = p1.InitialYaw
    v1.yaw = tonumber(InitialYaw) or 3.141592653589793
    local RemoveHolsters = p1.RemoveHolsters
    if not RemoveHolsters then
        RemoveHolsters = {"HolsterPrimary"}
    end
    v1.removeHolsters = RemoveHolsters
    v1.holsterWeapons = p1.HolsterWeapons
    v1.attachHolster = p1.AttachHolster
    v1.onReady = p1.OnReady
    v1.connections = {}
    local v2 = u30
    local u66 = setmetatable(v1, v2)
    task.spawn(function() -- Line: 627 -- upvalues: u66 (val)
        u66:_build()
    end)
    return u66
end

return u30