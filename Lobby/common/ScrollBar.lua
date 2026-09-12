local UserInputService = game:GetService("UserInputService")
game.Players.LocalPlayer:GetMouse()
local u12 = Vector2.new()

local function updateMousePosition(p1) -- Line: 8 -- upvalues: u12 (ref)
    if p1.UserInputType == Enum.UserInputType.MouseMovement or p1.UserInputType == Enum.UserInputType.Touch then
        local Position = p1.Position
        u12 = Vector2.new(Position.X, Position.Y)
    end
end

UserInputService.InputChanged:Connect(updateMousePosition)
UserInputService.InputBegan:Connect(updateMousePosition)
local u24 = {}
u24.__index = u24

function u24.new(p1, p2, p3, p4) -- Line: 22 -- upvalues: u24 (val), u12 (ref), UserInputService (val)
    local u4 = false
    local u6 = {Visible = true, Hidden = false}
    u6.ScrollBarFrame = p1
    u6.ScrollingFrame = p2
    u6.Button = p1:WaitForChild("ScrollButton")
    u6.Connections = {}
    u6.MoveDimension = p3 or "Y"
    u6.AutoHide = p4 or true
    local v1 = u24
    setmetatable(u6, v1)

    local function updateSize() -- Line: 38 -- upvalues: u6 (val)
        u6:_UpdateSize()
    end

    u6:_UpdateSize()
    local Connections = u6.Connections
    local v2 = (p2:GetPropertyChangedSignal("CanvasSize")):Connect(updateSize)
    table.insert(Connections, v2)
    local Connections_2 = u6.Connections
    v2 = (p2:GetPropertyChangedSignal("AbsoluteSize")):Connect(updateSize)
    table.insert(Connections_2, v2)
    local Connections_3 = u6.Connections
    v2 = (p2:GetPropertyChangedSignal("CanvasPosition")):Connect(function() -- Line: 45 -- upvalues: u6 (val)
        u6:_UpdatePosition()
    end)
    table.insert(Connections_3, v2)
    local Connections_4 = u6.Connections
    v2 = u6.Button.MouseButton1Down:Connect(function(p1_2, p2_2) -- Line: 49 -- upvalues: u12 (upval), u6 (val), u4 (ref), p1 (val), p2 (val)
        local v1, v2
        u12 = Vector2.new(p1_2, p2_2 - 36)
        local MoveDimension = u6.MoveDimension
        u4 = true
        local v3 = u6.Button.AbsolutePosition[MoveDimension]
        local v4 = v3 - u12[MoveDimension]
        local v5 = v4 / p1.AbsoluteSize[MoveDimension]
        u6:_UpdateSize()
        while u4 do
            v4 = 1 - u6.Button.Size[MoveDimension].Scale
            v2 = u12[MoveDimension] - p1.AbsolutePosition[MoveDimension]
            v3 = v2 / p1.AbsoluteSize[MoveDimension] + v5
            v1 = p2.AbsoluteCanvasSize[MoveDimension]
            if u6.MoveDimension ~= "X" then
                p2.CanvasPosition = Vector2.new(0, Lerp(0, v1, v3))
            else
                v2 = p2
                v2.CanvasPosition = Vector2.new(Lerp(0, v1, v3), 0)
            end
            task.wait()
        end
    end)
    table.insert(Connections_4, v2)
    local Connections_5 = u6.Connections
    v2 = UserInputService
    v2 = v2.InputEnded:Connect(function(p1) -- Line: 71 -- upvalues: u4 (ref)
        if p1.UserInputType == Enum.UserInputType.MouseButton1 or p1.UserInputType == Enum.UserInputType.Touch then
            u4 = false
        end
    end)
    table.insert(Connections_5, v2)
    return u6
end

function u24:Destroy() -- Line: 80
    local Connections = self.Connections
    local v1 = nil
    local v2 = nil
    for i, j in Connections, v1, v2 do
        j:Disconnect()
    end
    self.ScrollBarFrame:Destroy()
end

function u24.SetVisible(p1, p2) -- Line: 87
    p1.Visible = p2
    local ScrollBarFrame = p1.ScrollBarFrame
    local v1 = p2 and not p1.Hidden
    ScrollBarFrame.Visible = v1
end

function u24:_UpdateSize() -- Line: 92
    local v1 = self.ScrollingFrame.AbsoluteWindowSize / self.ScrollingFrame.AbsoluteCanvasSize
    if not self.AutoHide then
        self.Hidden = false
        self.ScrollBarFrame.Visible = self.Visible
        if self.MoveDimension ~= "X" then
            self.Button.Size = UDim2.fromScale(1, v1.Y)
        else
            self.Button.Size = UDim2.fromScale(v1.X, 1)
        end
    else
        local v2 = self.ScrollingFrame.AbsoluteWindowSize[self.MoveDimension]
        if not (self.ScrollingFrame.AbsoluteCanvasSize[self.MoveDimension] <= v2) then
            self.Hidden = false
            self.ScrollBarFrame.Visible = self.Visible
            if self.MoveDimension ~= "X" then
                self.Button.Size = UDim2.fromScale(1, v1.Y)
            else
                self.Button.Size = UDim2.fromScale(v1.X, 1)
            end
        else
            self.Hidden = true
            self.ScrollBarFrame.Visible = false
        end
    end
    self:_UpdatePosition()
end

function u24:_UpdatePosition() -- Line: 109
    if self.MoveDimension == "X" then
        local Button = self.Button
        Button.Position = UDim2.new(self.ScrollingFrame.CanvasPosition.X / self.ScrollingFrame.AbsoluteCanvasSize.X, 0, 0.5, 0)
        return
    end
    local Button_2 = self.Button
    Button_2.Position = UDim2.new(0.5, 0, self.ScrollingFrame.CanvasPosition.Y / self.ScrollingFrame.AbsoluteCanvasSize.Y, 0)
end

function Lerp(p1, p2, p3) -- Line: 118
    return p1 + (p2 - p1) * p3
end

return u24