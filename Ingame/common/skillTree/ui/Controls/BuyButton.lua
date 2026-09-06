local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local ButtonFeedback = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.ButtonFeedback)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
return function(p1) -- Line: 21 -- upvalues: Theme (val), OnEvent (val), peek (val), UIKit (val), ButtonFeedback (val), Children (val)
    local scope = p1.scope
    local Play = Theme.Menu.NavigationColors.Play
    local u9 = scope:Computed(function(a1) -- Line: 24 -- upvalues: p1 (val)
        local v1 = if p1.Enabled ~= nil then a1(p1.Enabled) else true
        return v1
    end)
    local u13 = scope:Value(false)
    local v1 = scope:Computed(function(p1) -- Line: 28 -- upvalues: u9 (val), Play (val)
        if p1(u9) then
            return Play.Fill
        end
        return (Color3.fromRGB(64, 70, 76))
    end)
    local v2 = scope:Computed(function(p1) -- Line: 31 -- upvalues: u9 (val), Play (val), Theme (upval)
        if p1(u9) then
            return Play.Accent
        end
        return Theme.Menu.Border
    end)
    local v3 = scope:Computed(function(p1) -- Line: 34 -- upvalues: u9 (val), Play (val), u13 (val)
        local v1
        if not (p1(u9)) then
            local v2 = {}
            local v3 = ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 70, 76))
            v2[1] = v3
            v2[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 42, 47))
            return ColorSequence.new(v2)
        end
        local Value = Play.Gradient.Keypoints[1].Value
        local Value_2 = Play.Gradient.Keypoints[#Play.Gradient.Keypoints].Value
        if p1(u13) then
            v1 = Color3.new(1, 1, 1)
            Value = Value:Lerp(v1, 0.08)
            v1 = Color3.new(1, 1, 1)
            Value_2 = Value_2:Lerp(v1, 0.05)
        end
        local v4 = {}
        v1 = ColorSequenceKeypoint.new(0, Value)
        v4[1] = v1
        v4[2] = ColorSequenceKeypoint.new(1, Value_2)
        return ColorSequence.new(v4)
    end)
    local v4 = scope:Computed(function(p1) -- Line: 53 -- upvalues: u9 (val), Theme (upval)
        if p1(u9) then
            return Theme.Menu.Text
        end
        return Theme.Menu.TextMuted
    end)
    local v5 = scope:Computed(function(p1) -- Line: 56 -- upvalues: u9 (val)
        if p1(u9) then
            return 0
        end
        return 0.35
    end)
    local u34 = nil
    local v6 = scope:New("TextButton")
    local v7 = {
        Name = "Buy",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = v1,
        BackgroundTransparency = 0,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(3, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        Text = "",
    }
    local Activated = OnEvent("Activated")
    v7[Activated] = function() -- Line: 73 -- upvalues: peek (upval), u9 (val), p1 (val), UIKit (upval)
        if peek(u9) and p1.OnClick then
            UIKit.UISounds.ClickSound:Play()
            p1.OnClick()
        end
    end
    local MouseEnter = OnEvent("MouseEnter")
    v7[MouseEnter] = function() -- Line: 79 -- upvalues: peek (upval), u9 (val), u13 (val), UIKit (upval)
        if peek(u9) then
            u13:set(true)
            UIKit.UISounds.HoverSound:Play()
        end
    end
    local MouseLeave = OnEvent("MouseLeave")
    v7[MouseLeave] = function() -- Line: 85 -- upvalues: u13 (val)
        u13:set(false)
    end
    local MouseButton1Down = OnEvent("MouseButton1Down")
    v7[MouseButton1Down] = function(p1, p2) -- Line: 88 -- upvalues: peek (upval), u9 (val), ButtonFeedback (upval), u34 (ref), Play (val)
        if peek(u9) then
            local v1 = ButtonFeedback.PointFromMouseEvent(p1, p2)
            ButtonFeedback.Ripple(u34, v1, Play.Accent)
        end
    end
    local v8 = {}
    local v9 = scope:New("UICorner")
    v9 = v9({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
    local v10 = scope:New("UIGradient")
    v10 = v10({Color = v3, Rotation = Theme.Menu.ShadeRotation})
    local v11 = scope:New("UIStroke")
    v11 = v11({ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = v2, Thickness = Theme.Stroke.Thin})
    local v12 = scope:New("UIAspectRatioConstraint")
    v12 = v12({AspectRatio = 2.93})
    local v13 = scope:New("UISizeConstraint")
    v13 = v13({MinSize = Vector2.new(120, 41)})
    local v14 = scope:New("TextLabel")
    local v15 = {
        Name = "Label",
        BackgroundTransparency = 1,
        Text = "BUY",
        TextScaled = true,
        ZIndex = 1,
        Size = UDim2.fromScale(1, 1),
        Font = Theme.Menu.Fonts.Button,
        TextColor3 = v4,
        TextTransparency = v5,
    }
    v8[1] = v9
    v8[2] = v10
    v8[3] = v11
    v8[4] = v12
    v8[5] = v13
    v8[6] = v14(v15)
    v7[Children] = v8
    u34 = v6(v7)
    return u34
end