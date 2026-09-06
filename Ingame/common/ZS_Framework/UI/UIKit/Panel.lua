local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
return function(p1) -- Line: 30 -- upvalues: u11 (val)
    local Visible, v1
    local scope = p1.scope
    local v2 = nil
    if p1.GradientColor then
        v1 = scope:New("UIGradient")
        v2 = v1({Color = p1.GradientColor, Rotation = p1.GradientRotation or 90})
    end
    v1 = scope:New("Frame")
    local v3 = {Name = p1.Name or "Panel"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromScale(1, 1)
    end
    v3.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0.5, 0.5)
    end
    v3.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0.5, 0.5)
    end
    v3.AnchorPoint = AnchorPoint
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = u11.Colors.FrameFill
    end
    v3.BackgroundColor3 = BackgroundColor3
    local BackgroundTransparency = p1.BackgroundTransparency
    if not BackgroundTransparency then
        BackgroundTransparency = u11.Transparency.None
    end
    v3.BackgroundTransparency = BackgroundTransparency
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Content
    end
    v3.ZIndex = ZIndex
    v3.LayoutOrder = p1.LayoutOrder or 0
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v3.Visible = Visible
    v3.Parent = p1.Parent
    local v4 = {}
    local v5 = scope:New("UICorner")
    local v6 = {}
    local CornerRadius = p1.CornerRadius
    if not CornerRadius then
        CornerRadius = UDim.new(0, u11.Radius.Medium)
    end
    v6.CornerRadius = CornerRadius
    v5 = v5(v6)
    v6 = scope:New("UIStroke")
    local v7 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border}
    local StrokeColor3 = p1.StrokeColor3
    if not StrokeColor3 then
        StrokeColor3 = u11.Colors.FrameBack
    end
    v7.Color = StrokeColor3
    local StrokeThickness = p1.StrokeThickness
    if not StrokeThickness then
        StrokeThickness = u11.Menu.StrokeThickness
    end
    v7.Thickness = StrokeThickness
    v7.Transparency = p1.StrokeTransparency or 0
    v6 = v6(v7)
    v4[1] = v5
    v4[2] = v6
    v4[3] = v2
    v4[4] = p1.Children
    v3[scope.Children] = v4
    return v1(v3)
end