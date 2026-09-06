local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
return function(p1) -- Line: 35 -- upvalues: u11 (val)
    local Visible
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Buttons
    end
    local v1 = scope:New("Frame")
    local v2 = {Name = p1.Name or "PriceTag"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(132, 34)
    end
    v2.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v2.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v2.AnchorPoint = AnchorPoint
    v2.LayoutOrder = p1.LayoutOrder or 0
    v2.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v2.Visible = Visible
    v2.BackgroundTransparency = 1
    v2.BorderSizePixel = 0
    v2.ClipsDescendants = true
    v2.Parent = p1.Parent
    local v3 = {}
    local v4 = scope:New("UICorner")
    v4 = v4({CornerRadius = UDim.new(0, u11.Menu.CornerRadius)})
    local v5 = scope:New("UIStroke")
    local v6 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border}
    local StrokeColor3 = p1.StrokeColor3
    if not StrokeColor3 then
        StrokeColor3 = u11.Menu.NavigationColors.Play.Accent
    end
    v6.Color = StrokeColor3
    v6.Thickness = u11.Stroke.Thin
    v5 = v5(v6)
    v6 = scope:New("Frame")
    local v7 = {Name = "GradientFill", Size = UDim2.fromScale(1, 1)}
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = u11.Menu.NavigationColors.Play.Fill
    end
    v7.BackgroundColor3 = BackgroundColor3
    v7.BorderSizePixel = 0
    v7.ZIndex = ZIndex
    local v8 = {}
    local v9 = scope:New("UICorner")
    v9 = v9({CornerRadius = UDim.new(0, u11.Menu.CornerRadius)})
    local v10 = scope:New("UIGradient")
    local v11 = {}
    local GradientColor = p1.GradientColor
    if not GradientColor then
        GradientColor = u11.Menu.NavigationColors.Play.Gradient
    end
    v11.Color = GradientColor
    v11.Rotation = u11.Menu.ShadeRotation
    v8[1] = v9
    v8[2] = v10(v11)
    v7[scope.Children] = v8
    v6 = v6(v7)
    v7 = scope:New("TextLabel")
    local v12 = {
        Name = "Label",
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = p1.Text,
        Font = u11.Menu.Fonts.Button,
    }
    local TextColor3 = p1.TextColor3
    if not TextColor3 then
        TextColor3 = u11.Menu.Positive
    end
    v12.TextColor3 = TextColor3
    v12.TextSize = p1.TextSize or 14
    v12.TextTruncate = Enum.TextTruncate.AtEnd
    v12.ZIndex = ZIndex + 1
    v3[1] = v4
    v3[2] = v5
    v3[3] = v6
    v3[4] = v7(v12)
    v2[scope.Children] = v3
    return v1(v2)
end