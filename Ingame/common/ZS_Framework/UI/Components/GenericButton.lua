local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local ButtonFeedback = require(script.Parent.Parent.UIKit.ButtonFeedback)
return function(p1) -- Line: 49 -- upvalues: OnEvent (val), peek (val), ButtonFeedback (val), Children (val)
    local Visible
    local scope = p1.scope
    local Disabled = p1.Disabled
    if not Disabled then
        Disabled = scope:Value(false)
    end
    local isHovering = p1.isHovering
    if not isHovering then
        isHovering = scope:Value(false)
    end
    local isHeldDown = p1.isHeldDown
    if not isHeldDown then
        isHeldDown = scope:Value(false)
    end
    local Font = p1.Font
    if not Font then
        Font = Enum.Font.SourceSans
    end
    local Position = p1.Position
    if not Position then
        Position = UDim2.new(0.5, 0, 0.5, 0)
    end
    local Size = p1.Size
    if not Size then
        Size = UDim2.new(1, 0, 1, 0)
    end
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0.5, 0.5)
    end
    local TextColor3 = p1.TextColor3
    if not TextColor3 then
        TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    local TextXAlignment = p1.TextXAlignment
    if not TextXAlignment then
        TextXAlignment = Enum.TextXAlignment.Center
    end
    local TextYAlignment = p1.TextYAlignment
    if not TextYAlignment then
        TextYAlignment = Enum.TextYAlignment.Center
    end
    local TextTruncate = p1.TextTruncate
    if not TextTruncate then
        TextTruncate = Enum.TextTruncate.None
    end
    local TextStrokeColor3 = p1.TextStrokeColor3
    if not TextStrokeColor3 then
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    end
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
    local u94 = p1.OutlineEnabled or false
    local OutlineColor3 = p1.OutlineColor3
    if not OutlineColor3 then
        OutlineColor3 = Color3.fromRGB(70, 96, 122)
    end
    local u104 = p1.OutlineHoverColor3 or OutlineColor3
    local v1 = scope:Computed(function(p1) -- Line: 79 -- upvalues: u94 (val)
        if not (p1(u94)) then
            return 1
        end
        return 0.12
    end)
    local v2 = scope:Computed(function(p1) -- Line: 86 -- upvalues: BackgroundColor3 (val), Disabled (val), isHovering (val)
        local v1 = p1(BackgroundColor3)
        if p1(Disabled) then
            return Color3.fromRGB(100, 100, 100)
        end
        if not (p1(isHovering)) then
            return v1
        end
        local v2 = Color3.new(0, 0, 0)
        return v1:Lerp(v2, 0.14)
    end)
    local UIAspectRatio = p1.UIAspectRatio
    local v3 = nil
    if UIAspectRatio then
        local v4 = scope:New("UIAspectRatioConstraint")
        v3 = v4({AspectRatio = UIAspectRatio})
    end
    local u166 = nil
    local v5 = scope:New("TextButton")
    local v6 = {
        Text = p1.Text or "",
        Font = Font,
        TextScaled = p1.TextScaled or false,
        TextSize = p1.TextSize or 14,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        TextColor3 = TextColor3,
        TextTransparency = p1.TextTransparency or 0,
        TextWrapped = p1.TextWrapped or false,
        TextXAlignment = TextXAlignment,
        TextYAlignment = TextYAlignment,
        TextTruncate = TextTruncate,
        TextStrokeTransparency = p1.TextStrokeTransparency or 1,
        TextStrokeColor3 = TextStrokeColor3,
        BackgroundTransparency = p1.BackgroundTransparency or 1,
        BackgroundColor3 = v2,
        ZIndex = (p1.ZIndex or 1) + 1,
    }
    local v7 = not (p1.OutlineEnabled ~= nil)
    v6.AutoButtonColor = v7
    local Activated = OnEvent("Activated")
    v6[Activated] = function() -- Line: 128 -- upvalues: p1 (val), peek (upval), Disabled (val)
        if p1.OnClick ~= nil and not (peek(Disabled)) then
            if p1.ButtonSound then
                p1.ButtonSound:Play()
            end
            p1.OnClick()
        end
    end
    local MouseButton1Down = OnEvent("MouseButton1Down")
    v6[MouseButton1Down] = function(a1, p2) -- Line: 137 -- upvalues: peek (upval), Disabled (val), isHeldDown (val), ButtonFeedback (upval), u166 (ref), p1 (val)
        if peek(Disabled) then
            return
        end
        isHeldDown:set(true)
        local v1 = ButtonFeedback.PointFromMouseEvent(a1, p2)
        ButtonFeedback.Ripple(u166, v1, p1.RippleColor3, p1.RippleDuration)
    end
    local MouseButton1Up = OnEvent("MouseButton1Up")
    v6[MouseButton1Up] = function() -- Line: 145 -- upvalues: isHeldDown (val)
        isHeldDown:set(false)
    end
    local MouseEnter = OnEvent("MouseEnter")
    v6[MouseEnter] = function() -- Line: 149 -- upvalues: isHovering (val), p1 (val)
        isHovering:set(true)
        if p1.HoverSound then
            p1.HoverSound:Play()
        end
    end
    local MouseLeave = OnEvent("MouseLeave")
    v6[MouseLeave] = function() -- Line: 155 -- upvalues: isHeldDown (val), isHovering (val)
        isHeldDown:set(false)
        isHovering:set(false)
    end
    local v8 = {}
    local v9 = scope:New("UIStroke")
    v9 = v9({ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = scope:Computed(function(p1) -- Line: 163 -- upvalues: isHovering (val), u104 (val), OutlineColor3 (val)
        if p1(isHovering) then
            return (p1(u104))
        end
        return (p1(OutlineColor3))
    end), Thickness = p1.OutlineThickness or 2, Transparency = v1})
    v8[1] = v9
    v8[2] = p1.Children
    v6[Children] = v8
    v6.ClipsDescendants = true
    u166 = v5(v6)
    u166:SetAttribute("UIKitFeedback", true)
    v5 = scope:New("Frame")
    v6 = {Size = Size, Position = Position, AnchorPoint = AnchorPoint, BackgroundTransparency = 1}
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v6.Visible = Visible
    v6.ZIndex = p1.ZIndex or 1
    v6.LayoutOrder = p1.LayoutOrder or 0
    v6[scope.Children] = {v3, u166}
    return v5(v6)
end