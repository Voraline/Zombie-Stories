local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u14 = require("./GenericButton")
return function(p1) -- Line: 47 -- upvalues: u14 (val)
    local TextScaled
    local Font = p1.Font
    if not Font then
        Font = Enum.Font.GothamBold
    end
    if p1.TextScaled ~= nil then
        TextScaled = p1.TextScaled
    else
        TextScaled = true
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
    return u14({
        scope = p1.scope,
        isHovering = p1.isHovering,
        isHeldDown = p1.isHeldDown,
        Disabled = p1.Disabled,
        OnClick = p1.OnClick,
        ButtonSound = p1.ButtonSound,
        HoverSound = p1.HoverSound,
        OutlineColor3 = p1.OutlineColor3,
        OutlineHoverColor3 = p1.OutlineHoverColor3,
        OutlineThickness = p1.OutlineThickness,
        OutlineEnabled = p1.OutlineEnabled,
        RippleColor3 = p1.RippleColor3,
        RippleDuration = p1.RippleDuration,
        Text = p1.Text or "X",
        Font = Font,
        TextScaled = TextScaled,
        TextSize = p1.TextSize or 14,
        Position = Position,
        Size = Size,
        AnchorPoint = AnchorPoint,
        TextColor3 = TextColor3,
        TextTransparency = p1.TextTransparency or 0,
        TextWrapped = p1.TextWrapped or false,
        TextXAlignment = TextXAlignment,
        TextYAlignment = TextYAlignment,
        TextTruncate = TextTruncate,
        TextStrokeTransparency = p1.TextStrokeTransparency or 1,
        TextStrokeColor3 = TextStrokeColor3,
        BackgroundTransparency = p1.BackgroundTransparency or 1,
        BackgroundColor3 = BackgroundColor3,
        Visible = p1.Visible,
        UIAspectRatio = 1,
        ZIndex = p1.ZIndex or 1,
        Children = {p1.Children},
    })
end