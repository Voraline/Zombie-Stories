local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local layout = require(ReplicatedStorage.common.skillTree.config.SkillConfig).layout
local function thumbstickCurve(p1) -- Line: 61
    local v1 = (math.abs(p1) - 0.1) / 0.9
    if v1 <= 0 then
        return 0
    end
    local v2 = math.sign(p1)
    return v2 * math.clamp((math.exp(v1 * 2) - 1) / 6.38905609893065, 0, 1)
end
local u23 = {}
u23.__index = u23
function u23.new() -- Line: 110 -- upvalues: u23 (val)
    local v1 = setmetatable({}, u23)
    v1.camera = workspace.CurrentCamera
    v1.enabled = false
    v1.targetPosition = Vector3.new(2500, 500, 2500)
    v1.currentZoom = 80
    v1.isPanning = false
    v1.lastMousePosition = Vector2.zero
    v1.connections = {}
    v1.fovTweenGeneration = 0
    v1.gamepadInput = Vector2.zero
    v1.gamepadZoomInput = 0
    v1.gamepadPanTime = 0
    v1.activeTouches = {}
    v1.lastPinchDistance = nil
    v1.pinchAccumulator = 0
    v1.isTouchPanning = false
    v1.lastTouchPosition = Vector2.zero
    v1.touchVelocity = Vector3.new(0, 0, 0)
    v1.inertiaVelocity = Vector3.new(0, 0, 0)
    return v1
end
function u23.getSkillWorldPosition(p1) -- Line: 145 -- upvalues: layout (val)
    local v1 = layout.getPosition(p1)
    if not v1 then
        return nil
    end
    return Vector3.new(2500, 500, 2500) + Vector3.new(-v1.row * 65, 0, v1.column * 65)
end
function u23.enable(p1, p2) -- Line: 160 -- upvalues: u23 (val), RunService (val)
    if p1.enabled then
        return
    end
    p1.camera = workspace.CurrentCamera
    p1.enabled = true
    p1.camera.CameraType = Enum.CameraType.Scriptable
    local v1 = u23.getSkillWorldPosition(p2 or "core1")
    if v1 then
        p1.targetPosition = Vector3.new(v1.X, 500, v1.Z)
    end
    p1:connectInputs()
    local v2 = RunService.RenderStepped:Connect(function(a1) -- Line: 183 -- upvalues: p1 (val)
        p1:update(a1)
    end)
    table.insert(p1.connections, v2)
end
function u23.disable(p1) -- Line: 192
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
function u23:connectInputs() -- Line: 213 -- upvalues: UserInputService (val)
    local v1, v2, v3, v4
    local v5 = UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 215 -- upvalues: self (val), UserInputService (upval)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            self.isPanning = true
            self.lastMousePosition = UserInputService:GetMouseLocation()
        end
    end)
    table.insert(self.connections, v5)
    local v6 = UserInputService.InputEnded:Connect(function(p1) -- Line: 224 -- upvalues: self (val)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            self.isPanning = false
        end
    end)
    table.insert(self.connections, v6)
    v1 = UserInputService.InputChanged:Connect(function(p1, p2) -- Line: 232 -- upvalues: self (val), UserInputService (upval)
        local v1
        if p1.UserInputType == Enum.UserInputType.MouseMovement and self.isPanning then
            local MouseLocation = UserInputService:GetMouseLocation()
            local v2 = MouseLocation - self.lastMousePosition
            self.lastMousePosition = MouseLocation
            v1 = 0.3 * (self.currentZoom / 400)
            self.targetPosition = self.targetPosition + Vector3.new(v2.Y * v1, 0, -v2.X * v1)
        end
        if p1.UserInputType == Enum.UserInputType.MouseWheel and not p2 and self.enabled then
            self.currentZoom = math.clamp(self.currentZoom - p1.Position.Z * 10, 40, 400)
        end
        if p1.KeyCode == Enum.KeyCode.Thumbstick1 then
            local v3, v4, v5
            local Position = p1.Position
            local X = Position.X
            local v6 = (math.abs(X) - 0.1) / 0.9
            if v6 > 0 then
                v4 = (math.exp(v6 * 2) - 1) / 6.38905609893065
                v5 = math.sign(X)
                v1 = v5 * math.clamp(v4, 0, 1)
            else
                v1 = 0
            end
            local Y = Position.Y
            v4 = (math.abs(Y) - 0.1) / 0.9
            if v4 > 0 then
                v5 = (math.exp(v4 * 2) - 1) / 6.38905609893065
                local v7 = math.sign(Y)
                v3 = v7 * math.clamp(v5, 0, 1)
            else
                v3 = 0
            end
            self.gamepadInput = Vector2.new(v1, v3)
        end
        if p1.KeyCode == Enum.KeyCode.ButtonR2 then
            self.gamepadZoomInput = -p1.Position.Z
            return
        end
        if p1.KeyCode == Enum.KeyCode.ButtonL2 then
            self.gamepadZoomInput = p1.Position.Z
        end
    end)
    table.insert(self.connections, v1)
    v2 = UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 269 -- upvalues: self (val)
        if p1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        self.activeTouches[p1] = Vector2.new(p1.Position.X, p1.Position.Y)
        self.inertiaVelocity = Vector3.new(0, 0, 0)
        self.touchVelocity = Vector3.new(0, 0, 0)
        local v1 = 0
        local activeTouches = self.activeTouches
        local v2 = nil
        local v3 = nil
        for i in activeTouches, v2, v3 do
            v1 = v1 + 1
        end
        if v1 ~= 1 then
            self.isTouchPanning = false
            return
        end
        self.isTouchPanning = true
        self.lastTouchPosition = Vector2.new(p1.Position.X, p1.Position.Y)
    end)
    table.insert(self.connections, v2)
    v3 = UserInputService.InputEnded:Connect(function(p1) -- Line: 295 -- upvalues: self (val)
        if p1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
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
                if 800 >= Magnitude then
                    self.inertiaVelocity = self.touchVelocity
                else
                    self.inertiaVelocity = self.touchVelocity.Unit * 800
                end
            end
            self.touchVelocity = Vector3.new(0, 0, 0)
        end
    end)
    table.insert(self.connections, v3)
    v4 = UserInputService.InputChanged:Connect(function(p1) -- Line: 332 -- upvalues: self (val)
        if p1.UserInputType ~= Enum.UserInputType.Touch then
            return
        else
            local activeTouches
            if self.activeTouches[p1] then
                self.activeTouches[p1] = Vector2.new(p1.Position.X, p1.Position.Y)
            end
            local v1 = 0
            local v2 = {}
            activeTouches = self.activeTouches
            local v3 = nil
            local v4 = nil
            for i, j in activeTouches, v3, v4 do
                v1 = v1 + 1
                table.insert(v2, j)
            end
            if v1 ~= 1 then
                if v1 == 2 then
                    local Magnitude = (v2[1] - v2[2]).Magnitude
                    if self.lastPinchDistance then
                        self.pinchAccumulator = self.pinchAccumulator + (self.lastPinchDistance - Magnitude)
                        while true do
                            v4 = math.abs(self.pinchAccumulator)
                            if 50 > v4 then
                                break
                            end
                            if 0 >= self.pinchAccumulator then
                                self.currentZoom = math.clamp(self.currentZoom - 20, 40, 400)
                                self.pinchAccumulator = self.pinchAccumulator + 50
                            else
                                self.currentZoom = math.clamp(self.currentZoom + 20, 40, 400)
                                self.pinchAccumulator = self.pinchAccumulator - 50
                            end
                        end
                    end
                    self.lastPinchDistance = Magnitude
                end
                return
            elseif self.isTouchPanning then
                local v5 = Vector2.new(p1.Position.X, p1.Position.Y)
                v3 = v5 - self.lastTouchPosition
                self.lastTouchPosition = v5
                local v6 = 0.5 * (self.currentZoom / 400)
                local v7 = Vector3.new(v3.Y * v6, 0, -v3.X * v6)
                self.targetPosition = self.targetPosition + v7
                self.touchVelocity = self.touchVelocity:Lerp(v7 * 60, 0.5)
                return
            end
        end
    end)
    table.insert(self.connections, v4)
end
function u23:clampToBounds() -- Line: 398
    local v1 = math.clamp(self.targetPosition.X, 2010, 2665)
    self.targetPosition = Vector3.new(v1, self.targetPosition.Y, (math.clamp(self.targetPosition.Z, 2140, 2860)))
end
function u23:update(p2) -- Line: 409 -- upvalues: UserInputService (val)
    local v1
    if not self.enabled then
        return
    end
    local v2 = Vector3.new(0, 0, 0)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        v2 = v2 + Vector3.new(1, 0, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        v2 = v2 + Vector3.new(-1, 0, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        v2 = v2 + Vector3.new(0, 0, -1)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        v2 = v2 + Vector3.new(0, 0, 1)
    end
    if 0 < v2.Magnitude then
        self.targetPosition = self.targetPosition + v2.Unit * (200 * (self.currentZoom / 400)) * p2
    end
    if 0 >= self.gamepadInput.Magnitude then
        self.gamepadPanTime = 0
    else
        self.gamepadPanTime = self.gamepadPanTime + p2
        v1 = math.min(self.gamepadPanTime / 1.5, 1)
        local v3 = (v1 * v1 * 400 + 200) * (self.currentZoom / 400)
        self.targetPosition = self.targetPosition + Vector3.new(self.gamepadInput.Y * v3 * p2, 0, self.gamepadInput.X * v3 * p2)
    end
    if self.gamepadZoomInput ~= 0 then
        self.currentZoom = math.clamp(self.currentZoom + self.gamepadZoomInput * 100 * p2, 40, 400)
    end
    if 0.5 >= self.inertiaVelocity.Magnitude then
        self.inertiaVelocity = Vector3.new(0, 0, 0)
    else
        self.targetPosition = self.targetPosition + self.inertiaVelocity * p2
        self.inertiaVelocity = self.inertiaVelocity * math.exp(p2 * -5)
    end
    self:clampToBounds()
    v1 = self.targetPosition + Vector3.new(0, self.currentZoom, 0)
    local v4 = CFrame.lookAt(v1, self.targetPosition)
    self.camera.CFrame = v4 * CFrame.Angles(0.017453292519943295, 0, 0)
end
function u23.focusSkill(p1, p2) -- Line: 493 -- upvalues: u23 (val)
    local v1 = u23.getSkillWorldPosition(p2)
    if v1 then
        p1.targetPosition = Vector3.new(v1.X, 500, v1.Z)
    end
end
function u23.setFieldOfView(p1, p2) -- Line: 503
    p1.fovTweenGeneration = p1.fovTweenGeneration + 1
    p1.camera.FieldOfView = p2
end
function u23.tweenFieldOfView(p1, p2, p3, p4) -- Line: 514
    local u4 = p3 or 0.5
    local FieldOfView = p1.camera.FieldOfView
    local u7 = 0
    p1.fovTweenGeneration = p1.fovTweenGeneration + 1
    local fovTweenGeneration = p1.fovTweenGeneration
    task.spawn(function() -- Line: 526 -- upvalues: u7 (ref), u4 (val), fovTweenGeneration (val), p1 (val), FieldOfView (val), p2 (val), p4 (val)
        local v1
        while u7 < u4 do
            if fovTweenGeneration ~= p1.fovTweenGeneration then
                return
            end
            u7 = u7 + task.wait()
            v1 = 1 - (1 - math.min(u7 / u4, 1)) ^ 2
            p1.camera.FieldOfView = FieldOfView + (p2 - FieldOfView) * v1
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
function u23.getDefaultFOV() -- Line: 552
    return 70
end
function u23.getTransitionFOVStart() -- Line: 559
    return 1
end
function u23.getBounds() -- Line: 567
    return 2010, 2665, 2140, 2860
end
function u23.getTreeOrigin() -- Line: 574
    return (Vector3.new(2500, 500, 2500))
end
return u23