local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local u21 = {}
u21.__index = u21
local function formatRemaining(p1) -- Line: 10
    local v1 = math.max(0, (math.ceil(p1)))
    local v2 = math.floor(v1 / 3600)
    local v3 = math.floor(v1 % 3600 / 60)
    return string.format("%02d:%02d:%02d", v2, v3, v1 % 60)
end
function u21.new(p1, p2) -- Line: 18 -- upvalues: u21 (val), Theme (val), RunService (val), Workspace (val), formatRemaining (val)
    local Label
    local v1 = {}
    local u5 = setmetatable(v1, u21)
    local Deadline = p2
    if Deadline then
        Deadline = p2.Deadline
    end
    u5._deadline = tonumber(Deadline) or 0
    if not p2 then
        Label = "LIVE EVENT STARTS IN"
    else
        Label = p2.Label
    end
    u5._label = Label
    u5._message = nil
    local TimerLabel = p2
    if TimerLabel then
        TimerLabel = p2.TimerLabel
    end
    u5._adoptedTimer = TimerLabel
    if not u5._adoptedTimer then
        local Position, Size
        local Frame = Instance.new("Frame")
        Frame.Name = "LiveEventCountdown"
        Frame.AnchorPoint = Vector2.new(0.5, 0)
        if not p2 then
            Position = UDim2.fromScale(0.5, 0.04)
        else
            Position = p2.Position
        end
        Frame.Position = Position
        if not p2 then
            Size = UDim2.fromOffset(360, 92)
        else
            Size = p2.Size
            if not Size then
                Size = UDim2.fromOffset(360, 92)
            end
        end
        Frame.Size = Size
        Frame.BackgroundColor3 = Theme.Menu.PanelDeep
        Frame.BackgroundTransparency = 0.08
        Frame.BorderSizePixel = 0
        Frame.Parent = p1
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)
        UICorner.Parent = Frame
        local UIStroke = Instance.new("UIStroke")
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        UIStroke.Color = Theme.Menu.Accent
        UIStroke.Thickness = Theme.Stroke.Medium
        UIStroke.Parent = Frame
        local UIGradient = Instance.new("UIGradient")
        UIGradient.Color = Theme.Menu.Shade
        UIGradient.Rotation = Theme.Menu.ShadeRotation
        UIGradient.Parent = Frame
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "Label"
        TextLabel.Size = UDim2.new(1, -24, 0, 28)
        TextLabel.Position = UDim2.fromOffset(12, 10)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Font = Theme.Menu.Fonts.Header
        TextLabel.Text = u5._label
        TextLabel.TextColor3 = Theme.Menu.TextMuted
        TextLabel.TextScaled = true
        TextLabel.Parent = Frame
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Name = "Timer"
        TextLabel_2.Size = UDim2.new(1, -24, 0, 42)
        TextLabel_2.Position = UDim2.fromOffset(12, 40)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Font = Theme.Menu.Fonts.Title
        TextLabel_2.TextColor3 = Theme.Menu.Text
        TextLabel_2.TextScaled = true
        TextLabel_2.Parent = Frame
        u5._frame = Frame
        u5._labelObject = TextLabel
        u5._timerObject = TextLabel_2
        u5._visibilityObjects = {Frame}
    else
        u5._timerObject = u5._adoptedTimer
        u5._visibilityObjects = {u5._adoptedTimer}
    end
    u5._lastSecond = nil
    u5._connection = RunService.Heartbeat:Connect(function() -- Line: 81 -- upvalues: u5 (val), Workspace (upval), formatRemaining (upval), Theme (upval)
        if u5._message then
            return
        end
        local v1 = math.max(0, u5._deadline - Workspace:GetServerTimeNow())
        local v2 = math.ceil(v1)
        if v2 ~= u5._lastSecond then
            local v3
            u5._lastSecond = v2
            if not u5._adoptedTimer then
                local v4 = math.max(0, (math.ceil(v1)))
                local v5 = math.floor(v4 / 3600)
                local v6 = math.floor(v4 % 3600 / 60)
                v3 = string.format("%02d:%02d:%02d", v5, v6, v4 % 60)
            else
                v3 = string.format("%s\n%s", u5._label, formatRemaining(v1))
            end
            u5._timerObject.Text = v3
            if not u5._adoptedTimer then
                local InsufficientFunds
                if v1 > 60 then
                    InsufficientFunds = Theme.Menu.Text
                else
                    InsufficientFunds = Theme.Colors.InsufficientFunds
                end
                u5._timerObject.TextColor3 = InsufficientFunds
            end
        end
    end)
    return u5
end
function u21.SetDeadline(p1, p2) -- Line: 103
    p1._deadline = p2
    p1._message = nil
    p1._lastSecond = nil
end
function u21.SetLabel(p1, p2) -- Line: 109
    p1._label = p2
    p1._lastSecond = nil
    if p1._labelObject then
        p1._labelObject.Text = p2
    end
end
function u21.ShowMessage(p1, p2) -- Line: 117
    p1._message = p2
    p1._timerObject.Text = p2
end
function u21.SetVisible(p1, p2) -- Line: 122
    for i, v in ipairs(p1._visibilityObjects) do
        v.Visible = p2
    end
end
function u21:Destroy() -- Line: 128
    if self._connection then
        self._connection:Disconnect()
        self._connection = nil
    end
    if self._frame then
        self._frame:Destroy()
        self._frame = nil
    end
end
return u21