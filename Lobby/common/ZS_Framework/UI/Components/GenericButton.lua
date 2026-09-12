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
    local v1 = p1.Text or ""
    local Font = p1.Font
    if not Font then
        Font = Enum.Font.SourceSans
    end
    local v2 = p1.TextScaled or false
    local v3 = p1.TextSize or 14
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
    local v4 = p1.TextTransparency or 0
    local v5 = p1.TextWrapped or false
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
    local v6 = p1.TextStrokeTransparency or 1
    local TextStrokeColor3 = p1.TextStrokeColor3
    if not TextStrokeColor3 then
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    end
    local v7 = p1.BackgroundTransparency or 1
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
    local v8 = p1.LayoutOrder or 0
    local u94 = p1.OutlineEnabled or false
    local OutlineColor3 = p1.OutlineColor3
    if not OutlineColor3 then
        OutlineColor3 = Color3.fromRGB(70, 96, 122)
    end
    local u104 = p1.OutlineHoverColor3 or OutlineColor3
    local v9 = p1.OutlineThickness or 2
    local v10 = scope:Computed(function(p1) -- Line: 79 -- upvalues: u94 (val)
        if not p1(u94) then
            return 1
        end
        return 0.12
    end)
    local v11 = scope:Computed(function(p1) -- Line: 86 -- upvalues: BackgroundColor3 (val), Disabled (val), isHovering (val)
        local v1 = p1(BackgroundColor3)
        if p1(Disabled) then
            return Color3.fromRGB(100, 100, 100)
        end
        if not p1(isHovering) then
            return v1
        end
        local v2 = Color3.new(0, 0, 0)
        return v1:Lerp(v2, 0.14)
    end)
    local UIAspectRatio = p1.UIAspectRatio
    local v12 = nil
    if UIAspectRatio then
        v12 = scope:New("UIAspectRatioConstraint")({AspectRatio = UIAspectRatio})
    end
    local u166 = nil
    local v13 = scope:New("TextButton")
    local v14 = {
        Text = v1,
        Font = Font,
        TextScaled = v2,
        TextSize = v3,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0.5, 0.5),
        TextColor3 = TextColor3,
        TextTransparency = v4,
        TextWrapped = v5,
        TextXAlignment = TextXAlignment,
        TextYAlignment = TextYAlignment,
        TextTruncate = TextTruncate,
        TextStrokeTransparency = v6,
        TextStrokeColor3 = TextStrokeColor3,
        BackgroundTransparency = v7,
        BackgroundColor3 = v11,
        ZIndex = (p1.ZIndex or 1) + 1,
    }
    local v15 = not (p1.OutlineEnabled ~= nil)
    v14.AutoButtonColor = v15
    local Activated = OnEvent("Activated")

    v14[Activated] = function() -- Line: 128 -- upvalues: p1 (val), peek (upval), Disabled (val)
        if p1.OnClick ~= nil and not peek(Disabled) then
            if p1.ButtonSound then
                p1.ButtonSound:Play()
            end
            p1.OnClick()
        end
    end

    local MouseButton1Down = OnEvent("MouseButton1Down")

    v14[MouseButton1Down] = function(p1_2, p2) -- Line: 137
        -- upvalues: peek (upval), Disabled (val), isHeldDown (val), ButtonFeedback (upval), u166 (ref), p1 (val)
        if peek(Disabled) then
            return
        end
        isHeldDown:set(true)
        local v1 = ButtonFeedback.PointFromMouseEvent(p1_2, p2)
        ButtonFeedback.Ripple(u166, v1, p1.RippleColor3, p1.RippleDuration)
    end

    local MouseButton1Up = OnEvent("MouseButton1Up")

    v14[MouseButton1Up] = function() -- Line: 145 -- upvalues: isHeldDown (val)
        isHeldDown:set(false)
    end

    local MouseEnter = OnEvent("MouseEnter")

    v14[MouseEnter] = function() -- Line: 149 -- upvalues: isHovering (val), p1 (val)
        isHovering:set(true)
        if p1.HoverSound then
            p1.HoverSound:Play()
        end
    end

    local MouseLeave = OnEvent("MouseLeave")

    v14[MouseLeave] = function() -- Line: 155 -- upvalues: isHeldDown (val), isHovering (val)
        isHeldDown:set(false)
        isHovering:set(false)
    end

    v15 = Children
    v14[v15] = {
        scope:New("UIStroke")({
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = scope:Computed(function(p1) -- Line: 163 -- upvalues: isHovering (val), u104 (val), OutlineColor3 (val)
                if p1(isHovering) then
                    return (p1(u104))
                end
                return (p1(OutlineColor3))
            end),
            Thickness = v9,
            Transparency = v10,
        }),
        p1.Children,
    }
    v14.ClipsDescendants = true
    u166 = v13(v14)
    u166:SetAttribute("UIKitFeedback", true)
    v13 = scope:New("Frame")
    v14 = {Size = Size, Position = Position, AnchorPoint = AnchorPoint, BackgroundTransparency = 1}
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v14.Visible = Visible
    v14.ZIndex = p1.ZIndex or 1
    v14.LayoutOrder = v8
    local Children_2 = scope.Children
    v14[Children_2] = {v12, u166}
    v13 = v13(v14)
    return v13
end