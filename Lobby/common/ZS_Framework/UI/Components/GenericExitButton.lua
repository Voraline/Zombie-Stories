local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u14 = require("./GenericButton")
return function(p1) -- Line: 47 -- upvalues: u14 (val)
    local TextScaled
    local scope = p1.scope
    local v1 = p1.Text or "X"
    local Font = p1.Font
    if not Font then
        Font = Enum.Font.GothamBold
    end
    if p1.TextScaled ~= nil then
        TextScaled = p1.TextScaled
    else
        TextScaled = true
    end
    local v2 = p1.TextSize or 14
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
    local v3 = p1.TextTransparency or 0
    local v4 = p1.TextWrapped or false
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
    local v5 = p1.TextStrokeTransparency or 1
    local TextStrokeColor3 = p1.TextStrokeColor3
    if not TextStrokeColor3 then
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    end
    local v6 = p1.BackgroundTransparency or 1
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    end
    local v7 = u14
    return v7({
        scope = scope,
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
        Text = v1,
        Font = Font,
        TextScaled = TextScaled,
        TextSize = v2,
        Position = Position,
        Size = Size,
        AnchorPoint = AnchorPoint,
        TextColor3 = TextColor3,
        TextTransparency = v3,
        TextWrapped = v4,
        TextXAlignment = TextXAlignment,
        TextYAlignment = TextYAlignment,
        TextTruncate = TextTruncate,
        TextStrokeTransparency = v5,
        TextStrokeColor3 = TextStrokeColor3,
        BackgroundTransparency = v6,
        BackgroundColor3 = BackgroundColor3,
        Visible = p1.Visible,
        UIAspectRatio = 1,
        ZIndex = p1.ZIndex or 1,
        Children = {p1.Children},
    })
end