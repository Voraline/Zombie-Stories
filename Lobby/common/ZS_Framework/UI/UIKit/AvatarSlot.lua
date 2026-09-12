local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
return function(p1) -- Line: 41 -- upvalues: u11 (val)
    local IsLeader
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Content
    end
    local v1 = scope:New("ImageLabel")
    local v2 = {Name = p1.Name or "AvatarSlot"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(48, 48)
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
    v2.BackgroundColor3 = u11.Menu.PanelInset
    v2.BackgroundTransparency = p1.BackgroundTransparency or 0
    v2.Image = p1.Thumb or ""
    v2.ImageTransparency = p1.ImageTransparency or 0
    local Children = scope.Children
    local v3 = {}
    local v4 = scope:New("UICorner")
    local v5 = {}
    local CornerRadius = p1.CornerRadius
    if not CornerRadius then
        CornerRadius = UDim.new(0, u11.Menu.CornerRadius)
    end
    v5.CornerRadius = CornerRadius
    v4 = v4(v5)
    v5 = scope:New("UIAspectRatioConstraint")({AspectRatio = 1})
    local v6 = scope:New("UIStroke")
    local v7 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border}
    local BorderColor3 = p1.BorderColor3
    if not BorderColor3 then
        BorderColor3 = u11.Menu.Border
    end
    v7.Color = BorderColor3
    local BorderThickness = p1.BorderThickness
    if not BorderThickness then
        BorderThickness = u11.Menu.StrokeThickness
    end
    v7.Thickness = BorderThickness
    v7.Transparency = p1.StrokeTransparency or 0
    v6 = v6(v7)
    v7 = scope:New("TextLabel")
    local v8 = {Name = "Leader"}
    if p1.IsLeader ~= nil then
        IsLeader = p1.IsLeader
    else
        IsLeader = false
    end
    v8.Visible = IsLeader
    v8.AnchorPoint = Vector2.new(0, 0)
    v8.Position = UDim2.fromScale(0.04, 0.02)
    v8.Size = UDim2.fromScale(0.42, 0.42)
    v8.BackgroundTransparency = 1
    v8.Text = "★"
    v8.Font = u11.Menu.Fonts.Title
    v8.TextColor3 = u11.Menu.Positive
    v8.TextScaled = true
    v8.ZIndex = ZIndex + 1
    local Children_2 = scope.Children
    v8[Children_2] = {scope:New("UIStroke")({Thickness = 1, Color = u11.Menu.HeaderStroke})}
    v3[1] = v4
    v3[2] = v5
    v3[3] = v6
    v3[4] = v7(v8)
    v2[Children] = v3
    return v1(v2)
end