local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local ButtonFeedback = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.ButtonFeedback)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
return function(p1) -- Line: 21
    -- upvalues: Theme (val), OnEvent (val), peek (val), UIKit (val), ButtonFeedback (val), Children (val)
    local scope = p1.scope
    local Play = Theme.Menu.NavigationColors.Play
    local u9 = scope:Computed(function(p1_2) -- Line: 24 -- upvalues: p1 (val)
        local v1 = true
        if p1.Enabled ~= nil then
            v1 = p1_2(p1.Enabled)
        end
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
        if not p1(u9) then
            return ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 70, 76)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(38, 42, 47)),
            })
        end
        local Value = Play.Gradient.Keypoints[1].Value
        local Value_2 = Play.Gradient.Keypoints[#Play.Gradient.Keypoints].Value
        if p1(u13) then
            local v1 = Color3.new(1, 1, 1)
            Value = Value:Lerp(v1, 0.08)
            v1 = Color3.new(1, 1, 1)
            Value_2 = Value_2:Lerp(v1, 0.05)
        end
        return ColorSequence.new({ColorSequenceKeypoint.new(0, Value), ColorSequenceKeypoint.new(1, Value_2)})
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
            local v1 = ButtonFeedback
            local Ripple = v1.Ripple
            local v2 = u34
            Ripple(v2, ButtonFeedback.PointFromMouseEvent(p1, p2), Play.Accent)
        end
    end

    local v8 = Children
    local v9 = {}
    local v10 = scope:New("UICorner")({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
    local v11 = scope:New("UIGradient")({Color = v3, Rotation = Theme.Menu.ShadeRotation})
    local v12 = scope:New("UIStroke")({ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = v2, Thickness = Theme.Stroke.Thin})
    local v13 = scope:New("UIAspectRatioConstraint")({AspectRatio = 2.93})
    local v14 = scope:New("UISizeConstraint")({MinSize = Vector2.new(120, 41)})
    local v15 = scope:New("TextLabel")
    local v16 = {
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
    v9[1] = v10
    v9[2] = v11
    v9[3] = v12
    v9[4] = v13
    v9[5] = v14
    v9[6] = v15(v16)
    v7[v8] = v9
    v6 = v6(v7)
    u34 = v6
    return u34
end