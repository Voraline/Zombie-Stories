local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local v1 = {}
local u11 = {}
u11.__index = u11
local function calculateScalePosFromScreenSize(p1) -- Line: 9
    local AbsolutePosition = p1.AbsolutePosition
    local ViewportSize = workspace.CurrentCamera.ViewportSize
    return UDim2.new(AbsolutePosition.X / ViewportSize.X, 0, (AbsolutePosition.Y + 36) / ViewportSize.Y, 0)
end
local function calculateScaleSizeFromScreenSize(p1) -- Line: 16
    local AbsoluteSize = p1.AbsoluteSize
    local ViewportSize = workspace.CurrentCamera.ViewportSize
    return UDim2.new(AbsoluteSize.X / ViewportSize.X, 0, AbsoluteSize.Y / ViewportSize.Y, 0)
end
function v1.new(p1, p2, p3, p4, p5, p6) -- Line: 23 -- upvalues: u11 (val)
    local u9 = setmetatable({}, u11)
    assert(p5.min, "sliderConfigurations need a min variable.")
    assert(p5.max, "sliderConfigurations need a max variable.")
    assert(p5.snapFactor, "sliderConfigurations need a snapFactor variable.")
    local AnchorPoint = p1.AnchorPoint
    local v1 = AnchorPoint == Vector2.new(0.5, 0.5)
    assert(v1, "Set the AnchorPoint of " .. p1.Name .. " to (0.5, 0.5)")
    v1 = p3:IsDescendantOf(p2)
    assert(v1, "SliderButton needs to be a descendant of sliderMarker.")
    u9.slidingBase = p1
    u9.sliderMarker = p2
    u9.sliderButton = p3
    u9.sliderFill = p4
    u9.min = p5.min
    u9.max = p5.max
    u9.snapFactor = p5.snapFactor
    local AbsoluteSize = p1.AbsoluteSize
    local ViewportSize = workspace.CurrentCamera.ViewportSize
    local v2 = UDim2.new(AbsoluteSize.X / ViewportSize.X, 0, AbsoluteSize.Y / ViewportSize.Y, 0)
    local AbsolutePosition = p1.AbsolutePosition
    local ViewportSize_2 = workspace.CurrentCamera.ViewportSize
    v1 = UDim2.new(AbsolutePosition.X / ViewportSize_2.X, 0, (AbsolutePosition.Y + 36) / ViewportSize_2.Y, 0)
    p1.Changed:Connect(function() -- Line: 42 -- upvalues: p1 (val), u9 (val)
        local AbsoluteSize = p1.AbsoluteSize
        local ViewportSize = workspace.CurrentCamera.ViewportSize
        local v1 = UDim2.new(AbsoluteSize.X / ViewportSize.X, 0, AbsoluteSize.Y / ViewportSize.Y, 0)
        local AbsolutePosition = p1.AbsolutePosition
        local ViewportSize_2 = workspace.CurrentCamera.ViewportSize
        local v2 = UDim2.new(AbsolutePosition.X / ViewportSize_2.X, 0, (AbsolutePosition.Y + 36) / ViewportSize_2.Y, 0)
        u9.firstPartPos = UDim2.new(v2.X.Scale, 0, v2.Y.Scale, 0)
        u9.lineSize = v1.X.Scale
    end)
    u9.firstPartPos = UDim2.new(v1.X.Scale, 0, v1.Y.Scale, 0)
    u9.lineSize = v2.X.Scale
    if p6 then
        u9.TargetTextLabel = p6.TextBox
        u9.TargetTextBox = p6.TextBox
        if p6.TextLabel then
            u9.TargetTextLabel = p6.TextLabel
        end
    end
    u9.InteractionBegan = Instance.new("BindableEvent")
    u9.InteractionEnded = Instance.new("BindableEvent")
    u9.ValueChanged = Instance.new("BindableEvent")
    return u9
end
local function decimalRound(p1, p2) -- Line: 69
    local v1 = 10 ^ p2
    return math.round(p1 * v1) / v1
end
local function snap(p1, p2) -- Line: 74
    local v1 = math.floor(p2 / p1.snapFactor)
    local v2 = v1 * p1.snapFactor
    return (math.clamp(v2, 0, 1))
end
local function formatNumber(p1) -- Line: 79
    return string.format("%.2f", p1)
end
local function getText(p1, p2) -- Line: 83
    return math.round((p1.max - p1.min) / (1 / p1.snapFactor) * (p2 / p1.snapFactor) * 100) / 100 + p1.min
end
function u11.Activate(p1) -- Line: 90 -- upvalues: RunService (val), UserInputService (val)
    local u1 = nil
    local u2 = 0
    p1.sliderButton.MouseButton1Down:Connect(function() -- Line: 94 -- upvalues: p1 (val), u1 (ref), RunService (upval), UserInputService (upval), u2 (ref)
        p1.InteractionBegan:Fire()
        u1 = RunService.RenderStepped:Connect(function() -- Line: 97 -- upvalues: UserInputService (upval), u1 (upval), p1 (upval), u2 (upval)
            local v1, v2, v3, v4
            if not (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then
                u1:Disconnect()
                p1.InteractionEnded:Fire(p1.CurrentValue)
                return
            end
            local X = workspace.Camera.ViewportSize.X
            local v5 = (UserInputService:GetMouseLocation().X - p1.firstPartPos.X.Scale * X) / X
            local v6 = math.clamp(v5, 0, p1.lineSize)
            if 0 >= v6 then
                p1.sliderMarker.Position = UDim2.new(0, 0, p1.sliderMarker.Position.Y.Scale, 0)
                p1.sliderFill.Size = UDim2.new(0, 0, p1.sliderFill.Size.Y.Scale, 0)
                v2 = p1
                v4 = p1
                v1 = math.floor(v6 / p1.lineSize / v4.snapFactor)
                v3 = math.clamp(v1 * v4.snapFactor, 0, 1)
                p1.CurrentValue = math.round((v2.max - v2.min) / (1 / v2.snapFactor) * (v3 / v2.snapFactor) * 100) / 100 + v2.min
                if p1.TargetTextLabel then
                    p1.TargetTextLabel.Text = string.format("%.2f", p1.CurrentValue)
                end
                return
            end
            if v6 >= 1 then
                return
            end
            v3 = p1
            local v7 = math.floor(v6 / p1.lineSize / v3.snapFactor)
            v2 = math.clamp(v7 * v3.snapFactor, 0, 1)
            p1.sliderMarker.Position = UDim2.new(v2, 0, p1.sliderMarker.Position.Y.Scale, 0)
            v3 = p1
            v7 = math.floor(v6 / p1.lineSize / v3.snapFactor)
            v2 = math.clamp(v7 * v3.snapFactor, 0, 1)
            p1.sliderFill.Size = UDim2.new(v2, 0, p1.sliderFill.Size.Y.Scale, 0)
            v2 = p1
            v4 = p1
            v1 = math.floor(v6 / p1.lineSize / v4.snapFactor)
            v3 = math.clamp(v1 * v4.snapFactor, 0, 1)
            p1.CurrentValue = math.round((v2.max - v2.min) / (1 / v2.snapFactor) * (v3 / v2.snapFactor) * 100) / 100 + v2.min
            if p1.TargetTextLabel then
                p1.TargetTextLabel.Text = string.format("%.2f", p1.CurrentValue)
            end
            if u2 == p1.CurrentValue then
                return
            end
            u2 = p1.CurrentValue
            p1.ValueChanged:Fire(p1.CurrentValue)
        end)
    end)
    local function update(a1) -- Line: 135 -- upvalues: p1 (val)
        local v1 = tonumber(p1.TargetTextBox.Text)
        if a1 then
            p1.TargetTextBox.Text = string.format("%.2f", a1)
        end
        if v1 then
            local v2 = math.max(p1.min, v1)
            p1.CurrentValue = math.min(v2, p1.max)
            p1.TargetTextBox.Text = string.format("%.2f", p1.CurrentValue)
            local v3 = (p1.CurrentValue - p1.min) / (p1.max - p1.min)
            p1.sliderMarker.Position = UDim2.new(v3, 0, p1.sliderMarker.Position.Y.Scale, 0)
            p1.sliderFill.Size = UDim2.new(v3, 0, p1.sliderFill.Size.Y.Scale, 0)
        end
    end
    p1.TargetTextBox.FocusLost:Connect(function(a1) -- Line: 161 -- upvalues: update (val), p1 (val)
        if a1 then
            update()
            p1.InteractionEnded:Fire(p1.CurrentValue)
        end
    end)
    update()
    return update
end
return v1