local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local layout = (require(ReplicatedStorage.common.skillTree.config.SkillConfig)).layout

local function getInitialZoom() -- Line: 39
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera and not (CurrentCamera.ViewportSize.Y <= 0) then
        local v1 = CurrentCamera.ViewportSize.Y / 720
        local v2 = (math.clamp(v1, 0.65, 1)) * 80
        return (math.clamp(v2, 40, 80))
    end
    return 80
end

local function thumbstickCurve(p1) -- Line: 75
    local v1 = (math.abs(p1) - 0.1) / 0.9
    if v1 <= 0 then
        return 0
    end
    local v2 = v1 * 2
    local v3 = ((math.exp(v2)) - 1) / 6.38905609893065
    return (math.sign(p1)) * math.clamp(v3, 0, 1)
end

local u24 = {}
u24.__index = u24

function u24.new() -- Line: 124 -- upvalues: u24 (val)
    local v1 = u24
    local v2 = setmetatable({}, v1)
    v2.camera = workspace.CurrentCamera
    v2.enabled = false
    v2.targetPosition = Vector3.new(2500, 500, 2500)
    v2.currentZoom = 80
    v2.isPanning = false
    v2.lastMousePosition = Vector2.zero
    v2.connections = {}
    v2.fovTweenGeneration = 0
    v2.gamepadInput = Vector2.zero
    v2.gamepadZoomInput = 0
    v2.gamepadPanTime = 0
    v2.activeTouches = {}
    v2.lastPinchDistance = nil
    v2.pinchAccumulator = 0
    v2.isTouchPanning = false
    v2.lastTouchPosition = Vector2.zero
    v2.touchVelocity = Vector3.new(0, 0, 0)
    v2.inertiaVelocity = Vector3.new(0, 0, 0)
    return v2
end

function u24.getSkillWorldPosition(p1) -- Line: 159 -- upvalues: layout (val)
    local v1 = layout.getPosition(p1)
    if not v1 then
        return nil
    end
    local v2 = -v1.row * 65
    local v3 = v1.column * 65
    return Vector3.new(2500, 500, 2500) + Vector3.new(v2, 0, v3)
end

function u24.enable(p1, p2) -- Line: 174 -- upvalues: u24 (val), RunService (val)
    local v1
    if p1.enabled then
        return
    end
    p1.camera = workspace.CurrentCamera
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        v1 = 80
    elseif not (CurrentCamera.ViewportSize.Y <= 0) then
        local v2 = CurrentCamera.ViewportSize.Y / 720
        local v3 = (math.clamp(v2, 0.65, 1)) * 80
        v1 = math.clamp(v3, 40, 80)
    else
        v1 = 80
    end
    p1.currentZoom = v1
    p1.enabled = true
    p1.camera.CameraType = Enum.CameraType.Scriptable
    v1 = u24.getSkillWorldPosition(p2 or "core1")
    if v1 then
        local X = v1.X
        local Z = v1.Z
        p1.targetPosition = Vector3.new(X, 500, Z)
    end
    p1:connectInputs()
    local v4 = RunService
    v4 = v4.RenderStepped:Connect(function(p1_2) -- Line: 198 -- upvalues: p1 (val)
        p1:update(p1_2)
    end)
    local connections = p1.connections
    table.insert(connections, v4)
end

function u24.disable(p1) -- Line: 207
    p1.fovTweenGeneration = p1.fovTweenGeneration + 1
    if not p1.enabled then
        return
    end
    p1.enabled = false
    local connections = p1.connections
    local v1 = nil
    local v2 = nil
    for i, j in connections, v1, v2 do
        j:Disconnect()
    end
    p1.connections = {}
    p1.camera.CameraType = Enum.CameraType.Custom
end

function u24:connectInputs() -- Line: 228 -- upvalues: UserInputService (val)
    local v1 = UserInputService
    v1 = v1.InputBegan:Connect(function(p1, p2) -- Line: 230 -- upvalues: self (val), UserInputService (upval)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            self.isPanning = true
            self.lastMousePosition = UserInputService:GetMouseLocation()
        end
    end)
    local connections = self.connections
    table.insert(connections, v1)
    local v2 = UserInputService
    v2 = v2.InputEnded:Connect(function(p1) -- Line: 239 -- upvalues: self (val)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            self.isPanning = false
        end
    end)
    local connections_2 = self.connections
    table.insert(connections_2, v2)
    local v3 = UserInputService
    v3 = v3.InputChanged:Connect(function(p1, p2) -- Line: 247 -- upvalues: self (val), UserInputService (upval)
        local v1, v2, v3, v4, v5
        if p1.UserInputType == Enum.UserInputType.MouseMovement and self.isPanning then
            local MouseLocation = UserInputService:GetMouseLocation()
            v2 = MouseLocation - self.lastMousePosition
            self.lastMousePosition = MouseLocation
            v3 = 0.3 * (self.currentZoom / 400)
            v4 = self
            v5 = self
            local targetPosition = v5.targetPosition
            local v6 = v2.Y * v3
            v1 = -v2.X * v3
            v4.targetPosition = targetPosition + Vector3.new(v6, 0, v1)
        end
        if p1.UserInputType == Enum.UserInputType.MouseWheel and not p2 and self.enabled then
            local Z = p1.Position.Z
            v2 = self
            v3 = self.currentZoom - Z * 10
            v2.currentZoom = math.clamp(v3, 40, 400)
        end
        if p1.KeyCode == Enum.KeyCode.Thumbstick1 then
            local Position_2 = p1.Position
            v2 = self
            local new = Vector2.new
            local X_2 = Position_2.X
            local v7 = (math.abs(X_2) - 0.1) / 0.9
            if not (v7 <= 0) then
                local v8 = v7 * 2
                v5 = (math.exp(v8) - 1) / 6.38905609893065
                v3 = (math.sign(X_2)) * math.clamp(v5, 0, 1)
            else
                v3 = 0
            end
            local Y = Position_2.Y
            v5 = (math.abs(Y) - 0.1) / 0.9
            if not (v5 <= 0) then
                v1 = v5 * 2
                local v9 = (math.exp(v1) - 1) / 6.38905609893065
                v4 = (math.sign(Y)) * math.clamp(v9, 0, 1)
            else
                v4 = 0
            end
            v2.gamepadInput = new(v3, v4)
        end
        if p1.KeyCode == Enum.KeyCode.ButtonR2 then
            self.gamepadZoomInput = -p1.Position.Z
            return
        end
        if p1.KeyCode == Enum.KeyCode.ButtonL2 then
            self.gamepadZoomInput = p1.Position.Z
        end
    end)
    local connections_3 = self.connections
    table.insert(connections_3, v3)
    local v4 = UserInputService
    v4 = v4.InputBegan:Connect(function(p1, p2) -- Line: 284 -- upvalues: self (val)
        if p1.UserInputType == Enum.UserInputType.Touch then
            self.activeTouches[p1] = (Vector2.new(p1.Position.X, p1.Position.Y))
            self.inertiaVelocity = Vector3.new(0, 0, 0)
            self.touchVelocity = Vector3.new(0, 0, 0)
            local v1 = 0
            local activeTouches = self.activeTouches
            local v2 = nil
            local v3 = nil
            for i in activeTouches, v2, v3 do
                v1 = v1 + 1
            end
            if v1 == 1 then
                self.isTouchPanning = true
                self.lastTouchPosition = Vector2.new(p1.Position.X, p1.Position.Y)
                return
            end
            self.isTouchPanning = false
        end
    end)
    local connections_4 = self.connections
    table.insert(connections_4, v4)
    local v5 = UserInputService
    v5 = v5.InputEnded:Connect(function(p1) -- Line: 310 -- upvalues: self (val)
        if p1.UserInputType == Enum.UserInputType.Touch then
            self.activeTouches[p1] = nil
            self.lastPinchDistance = nil
            self.pinchAccumulator = 0
            local v1 = 0
            local activeTouches = self.activeTouches
            local v2 = nil
            local v3 = nil
            for i in activeTouches, v2, v3 do
                v1 = v1 + 1
            end
            if v1 == 1 then
                local activeTouches_2 = self.activeTouches
                v2 = nil
                v3 = nil
                for j, k in activeTouches_2, v2, v3 do
                    self.isTouchPanning = true
                    self.lastTouchPosition = Vector2.new(j.Position.X, j.Position.Y)
                    return
                end
                return
            end
            if v1 == 0 then
                self.isTouchPanning = false
                local Magnitude = self.touchVelocity.Magnitude
                if 0.5 < Magnitude then
                    if not (800 < Magnitude) then
                        self.inertiaVelocity = self.touchVelocity
                    else
                        self.inertiaVelocity = self.touchVelocity.Unit * 800
                    end
                end
                self.touchVelocity = Vector3.new(0, 0, 0)
            end
        end
    end)
    local connections_5 = self.connections
    table.insert(connections_5, v5)
    local v6 = UserInputService
    v6 = v6.InputChanged:Connect(function(p1) -- Line: 347 -- upvalues: self (val)
        if p1.UserInputType == Enum.UserInputType.Touch then
            local v1, v2
            if self.activeTouches[p1] then
                self.activeTouches[p1] = (Vector2.new(p1.Position.X, p1.Position.Y))
            end
            local v3 = 0
            local v4 = {}
            local activeTouches = self.activeTouches
            local v5 = nil
            local v6 = nil
            for i, j in activeTouches, v5, v6 do
                v3 = v3 + 1
                table.insert(v4, j)
            end
            if v3 == 1 and self.isTouchPanning then
                local v7 = Vector2.new(p1.Position.X, p1.Position.Y)
                v5 = v7 - self.lastTouchPosition
                self.lastTouchPosition = v7
                v1 = 0.5 * (self.currentZoom / 400)
                local v8 = v5.Y * v1
                local v9 = -v5.X * v1
                v2 = Vector3.new(v8, 0, v9)
                self.targetPosition = self.targetPosition + v2
                v8 = v2 * 60
                self.touchVelocity = self.touchVelocity:Lerp(v8, 0.5)
                return
            end
            if v3 == 2 then
                local Magnitude = (v4[1] - v4[2]).Magnitude
                if self.lastPinchDistance then
                    local pinchAccumulator
                    v5 = self.lastPinchDistance - Magnitude
                    self.pinchAccumulator = self.pinchAccumulator + v5
                    while true do
                        v1 = self
                        pinchAccumulator = v1.pinchAccumulator
                        v6 = math.abs(pinchAccumulator)
                        if not (50 <= v6) then
                            break
                        end
                        if not (0 < self.pinchAccumulator) then
                            v6 = self
                            v2 = self.currentZoom - 20
                            v6.currentZoom = math.clamp(v2, 40, 400)
                            self.pinchAccumulator = self.pinchAccumulator + 50
                        else
                            v6 = self
                            v2 = self.currentZoom + 20
                            v6.currentZoom = math.clamp(v2, 40, 400)
                            self.pinchAccumulator = self.pinchAccumulator - 50
                        end
                    end
                end
                self.lastPinchDistance = Magnitude
            end
        end
    end)
    local connections_6 = self.connections
    table.insert(connections_6, v6)
end

function u24:clampToBounds() -- Line: 413
    local X = self.targetPosition.X
    local v1 = math.clamp(X, 2010, 2665)
    local Y = self.targetPosition.Y
    local Z = self.targetPosition.Z
    local v2 = math.clamp(Z, 2140, 2860)
    self.targetPosition = Vector3.new(v1, Y, v2)
end

function u24:update(p2) -- Line: 424 -- upvalues: UserInputService (val)
    local v1, v2
    if not self.enabled then
        return
    end
    local v3 = Vector3.new(0, 0, 0)
    local v4 = UserInputService
    local W = Enum.KeyCode.W
    if v4:IsKeyDown(W) then
        v3 = v3 + Vector3.new(1, 0, 0)
    end
    v4 = UserInputService
    local S = Enum.KeyCode.S
    if v4:IsKeyDown(S) then
        v3 = v3 + Vector3.new(-1, 0, 0)
    end
    v4 = UserInputService
    local A = Enum.KeyCode.A
    if v4:IsKeyDown(A) then
        v3 = v3 + Vector3.new(0, 0, -1)
    end
    v4 = UserInputService
    local D = Enum.KeyCode.D
    if v4:IsKeyDown(D) then
        v3 = v3 + Vector3.new(0, 0, 1)
    end
    if 0 < v3.Magnitude then
        v1 = 200 * (self.currentZoom / 400)
        self.targetPosition = self.targetPosition + v3.Unit * v1 * p2
    end
    if not (0 < self.gamepadInput.Magnitude) then
        self.gamepadPanTime = 0
    else
        self.gamepadPanTime = self.gamepadPanTime + p2
        v1 = self.gamepadPanTime / 1.5
        v4 = math.min(v1, 1)
        v2 = (v4 * v4 * 400 + 200) * (self.currentZoom / 400)
        local targetPosition = self.targetPosition
        local v5 = self.gamepadInput.Y * v2 * p2
        local v6 = self.gamepadInput.X * v2 * p2
        self.targetPosition = targetPosition + Vector3.new(v5, 0, v6)
    end
    if self.gamepadZoomInput ~= 0 then
        v1 = self.currentZoom + self.gamepadZoomInput * 100 * p2
        self.currentZoom = math.clamp(v1, 40, 400)
    end
    if not (0.5 < self.inertiaVelocity.Magnitude) then
        self.inertiaVelocity = Vector3.new(0, 0, 0)
    else
        self.targetPosition = self.targetPosition + self.inertiaVelocity * p2
        local inertiaVelocity = self.inertiaVelocity
        v2 = p2 * -5
        self.inertiaVelocity = inertiaVelocity * math.exp(v2)
    end
    self:clampToBounds()
    local targetPosition_2 = self.targetPosition
    local currentZoom_2 = self.currentZoom
    v4 = targetPosition_2 + Vector3.new(0, currentZoom_2, 0)
    local targetPosition_3 = self.targetPosition
    local camera = self.camera
    camera.CFrame = (CFrame.lookAt(v4, targetPosition_3)) * CFrame.Angles(0.017453292519943295, 0, 0)
end

function u24.focusSkill(p1, p2) -- Line: 508 -- upvalues: u24 (val)
    local v1 = u24.getSkillWorldPosition(p2)
    if v1 then
        local X = v1.X
        local Z = v1.Z
        p1.targetPosition = Vector3.new(X, 500, Z)
    end
end

function u24.setFieldOfView(p1, p2) -- Line: 518
    p1.fovTweenGeneration = p1.fovTweenGeneration + 1
    p1.camera.FieldOfView = p2
end

function u24.tweenFieldOfView(p1, p2, p3, p4) -- Line: 529
    local u4 = p3 or 0.5
    local FieldOfView = p1.camera.FieldOfView
    local u7 = 0
    p1.fovTweenGeneration = p1.fovTweenGeneration + 1
    local fovTweenGeneration = p1.fovTweenGeneration
    task.spawn(function() -- Line: 541
        -- upvalues: u7 (ref), u4 (val), fovTweenGeneration (val), p1 (val), FieldOfView (val), p2 (val), p4 (val)
        local v1, v2
        while u7 < u4 do
            v1 = task.wait()
            if fovTweenGeneration ~= p1.fovTweenGeneration then
                return
            end
            u7 = u7 + v1
            v2 = u7 / u4
            v2 = 1 - (1 - math.min(v2, 1)) ^ 2
            p1.camera.FieldOfView = FieldOfView + (p2 - FieldOfView) * v2
        end
        if fovTweenGeneration ~= p1.fovTweenGeneration then
            return
        end
        p1.camera.FieldOfView = p2
        if p4 then
            p4()
        end
    end)
end

function u24.getDefaultFOV() -- Line: 567
    return 70
end

function u24.getTransitionFOVStart() -- Line: 574
    return 1
end

function u24.getBounds() -- Line: 582
    return 2010, 2665, 2140, 2860
end

function u24.getTreeOrigin() -- Line: 589
    return (Vector3.new(2500, 500, 2500))
end

return u24