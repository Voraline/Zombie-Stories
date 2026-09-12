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
    local v1 = u11
    local u9 = setmetatable({}, v1)
    local min = p5.min
    assert(min, "sliderConfigurations need a min variable.")
    local max = p5.max
    assert(max, "sliderConfigurations need a max variable.")
    local snapFactor = p5.snapFactor
    assert(snapFactor, "sliderConfigurations need a snapFactor variable.")
    v1 = p1.AnchorPoint == Vector2.new(0.5, 0.5)
    local v2 = "Set the AnchorPoint of " .. p1.Name .. " to (0.5, 0.5)"
    assert(v1, v2)
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
    local v3 = UDim2.new(AbsoluteSize.X / ViewportSize.X, 0, AbsoluteSize.Y / ViewportSize.Y, 0)
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
    u9.lineSize = v3.X.Scale
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
    local v2 = p1 * v1
    return math.round(v2) / v1
end

local function snap(p1, p2) -- Line: 74
    local snapFactor = p1.snapFactor
    local v1 = p2 / snapFactor
    local v2 = (math.floor(v1)) * p1.snapFactor
    return (math.clamp(v2, 0, 1))
end

local function formatNumber(p1) -- Line: 79
    return string.format("%.2f", p1)
end

local function getText(p1, p2) -- Line: 83
    local v1 = 1 / p1.snapFactor
    local v2 = (p1.max - p1.min) / v1
    local snapFactor_2 = p1.snapFactor
    local v3 = v2 * (p2 / snapFactor_2) * 100
    return math.round(v3) / 100 + p1.min
end

function u11.Activate(p1) -- Line: 90 -- upvalues: RunService (val), UserInputService (val)
    local u1 = nil
    local u2 = 0
    p1.sliderButton.MouseButton1Down:Connect(function() -- Line: 94 -- upvalues: p1 (val), u1 (ref), RunService (upval), UserInputService (upval), u2 (ref)
        p1.InteractionBegan:Fire()
        local v1 = RunService
        u1 = v1.RenderStepped:Connect(function() -- Line: 97 -- upvalues: UserInputService (upval), u1 (upval), p1 (upval), u2 (upval)
            local v1, v2, v3, v4, v5, v6
            local v7 = UserInputService
            local MouseButton1 = Enum.UserInputType.MouseButton1
            if not v7:IsMouseButtonPressed(MouseButton1) then
                u1:Disconnect()
                v7 = p1
                local InteractionEnded = v7.InteractionEnded
                v3 = p1
                local CurrentValue = v3.CurrentValue
                InteractionEnded:Fire(CurrentValue)
                return
            end
            local X = workspace.Camera.ViewportSize.X
            local v8 = (UserInputService:GetMouseLocation().X - p1.firstPartPos.X.Scale * X) / X
            local v9 = p1
            local lineSize = v9.lineSize
            v3 = math.clamp(v8, 0, lineSize)
            if not (0 < v3) then
                p1.sliderMarker.Position = UDim2.new(0, 0, p1.sliderMarker.Position.Y.Scale, 0)
                p1.sliderFill.Size = UDim2.new(0, 0, p1.sliderFill.Size.Y.Scale, 0)
                v8 = p1
                v9 = p1
                v5 = p1
                v6 = p1
                v2 = v3 / v6.lineSize / v5.snapFactor
                v1 = (math.floor(v2)) * v5.snapFactor
                v4 = math.clamp(v1, 0, 1)
                v5 = 1 / v9.snapFactor
                v2 = (v9.max - v9.min) / v5 * (v4 / v9.snapFactor) * 100
                v8.CurrentValue = math.round(v2) / 100 + v9.min
                if p1.TargetTextLabel then
                    v8 = p1
                    local TargetTextLabel_2 = v8.TargetTextLabel
                    v9 = p1
                    local CurrentValue_4 = v9.CurrentValue
                    TargetTextLabel_2.Text = string.format("%.2f", CurrentValue_4)
                end
                return
            end
            if v3 < 1 then
                v8 = p1
                local sliderMarker = v8.sliderMarker
                local new = UDim2.new
                v4 = p1
                local v10 = p1
                local v11 = v3 / v10.lineSize / v4.snapFactor
                v6 = (math.floor(v11)) * v4.snapFactor
                v9 = math.clamp(v6, 0, 1)
                sliderMarker.Position = new(v9, 0, p1.sliderMarker.Position.Y.Scale, 0)
                v8 = p1
                local sliderFill = v8.sliderFill
                local new_2 = UDim2.new
                v4 = p1
                v10 = p1
                v11 = v3 / v10.lineSize / v4.snapFactor
                v6 = (math.floor(v11)) * v4.snapFactor
                v9 = math.clamp(v6, 0, 1)
                sliderFill.Size = new_2(v9, 0, p1.sliderFill.Size.Y.Scale, 0)
                v8 = p1
                v9 = p1
                v5 = p1
                v6 = p1
                v2 = v3 / v6.lineSize / v5.snapFactor
                v1 = (math.floor(v2)) * v5.snapFactor
                v4 = math.clamp(v1, 0, 1)
                v5 = 1 / v9.snapFactor
                v2 = (v9.max - v9.min) / v5 * (v4 / v9.snapFactor) * 100
                v8.CurrentValue = math.round(v2) / 100 + v9.min
                if p1.TargetTextLabel then
                    v8 = p1
                    local TargetTextLabel = v8.TargetTextLabel
                    v9 = p1
                    local CurrentValue_2 = v9.CurrentValue
                    TargetTextLabel.Text = string.format("%.2f", CurrentValue_2)
                end
                if u2 ~= p1.CurrentValue then
                    u2 = p1.CurrentValue
                    v8 = p1
                    local ValueChanged = v8.ValueChanged
                    v9 = p1
                    local CurrentValue_3 = v9.CurrentValue
                    ValueChanged:Fire(CurrentValue_3)
                    return
                end
            end
        end)
    end)

    local function update(p1_2) -- Line: 135 -- upvalues: p1 (val)
        local v1 = p1
        local Text = v1.TargetTextBox.Text
        local v2 = tonumber(Text)
        if p1_2 then
            v2 = p1_2
            p1.TargetTextBox.Text = string.format("%.2f", v2)
        end
        if v2 then
            v1 = p1
            local v3 = p1
            local min = v3.min
            local v4 = math.max(min, v2)
            v3 = p1
            local max = v3.max
            v1.CurrentValue = math.min(v4, max)
            v1 = p1
            local TargetTextBox_2 = v1.TargetTextBox
            v4 = p1
            local CurrentValue = v4.CurrentValue
            TargetTextBox_2.Text = string.format("%.2f", CurrentValue)
            v1 = (p1.CurrentValue - p1.min) / (p1.max - p1.min)
            p1.sliderMarker.Position = UDim2.new(v1, 0, p1.sliderMarker.Position.Y.Scale, 0)
            p1.sliderFill.Size = UDim2.new(v1, 0, p1.sliderFill.Size.Y.Scale, 0)
        end
    end

    p1.TargetTextBox.FocusLost:Connect(function(p1_2) -- Line: 161 -- upvalues: update (val), p1 (val)
        if p1_2 then
            update()
            local v1 = p1
            local InteractionEnded = v1.InteractionEnded
            local v2 = p1
            local CurrentValue = v2.CurrentValue
            InteractionEnded:Fire(CurrentValue)
        end
    end)
    update()
    return update
end

return v1