local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
return function(p1) -- Line: 53 -- upvalues: u11 (val)
    local Visible, X
    local scope = p1.scope
    local u8 = scope:Value(Vector2.new(0, 0))
    local u10 = p1.CanvasPadding or 8
    local ContentPadding = p1.ContentPadding
    if not ContentPadding then
        ContentPadding = u11.Menu.StrokeThickness
    end
    local FillDirection = p1.FillDirection
    if not FillDirection then
        FillDirection = Enum.FillDirection.Vertical
    end
    local v1 = scope:Computed(function(a1) -- Line: 62 -- upvalues: u8 (val), p1 (val), FillDirection (val), u10 (val), ContentPadding (val)
        local v1
        local v2 = a1(u8)
        if p1.Scale ~= nil then
            v1 = a1(p1.Scale)
        else
            v1 = 1
        end
        if v1 <= 0 then
            v1 = 1
        end
        if FillDirection == Enum.FillDirection.Horizontal then
            return UDim2.fromOffset(v2.X / v1 + u10 + ContentPadding * 2, 0)
        end
        return UDim2.fromOffset(0, v2.Y / v1 + u10 + ContentPadding * 2)
    end)
    local v2 = scope:New("ScrollingFrame")
    local v3 = {Name = p1.Name or "ScrollList"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromScale(1, 1)
    end
    v3.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v3.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v3.AnchorPoint = AnchorPoint
    v3.BackgroundTransparency = 1
    v3.BorderSizePixel = 0
    v3.LayoutOrder = p1.LayoutOrder or 0
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Content
    end
    v3.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v3.Visible = Visible
    v3.Parent = p1.Parent
    v3.CanvasSize = v1
    if FillDirection ~= Enum.FillDirection.Horizontal then
        X = Enum.ScrollingDirection.Y
    else
        X = Enum.ScrollingDirection.X
    end
    v3.ScrollingDirection = X
    v3.ScrollBarThickness = p1.ScrollBarThickness or 4
    local ScrollBarImageColor3 = p1.ScrollBarImageColor3
    if not ScrollBarImageColor3 then
        ScrollBarImageColor3 = u11.Menu.Border
    end
    v3.ScrollBarImageColor3 = ScrollBarImageColor3
    v3.ScrollBarImageTransparency = 0.4
    local v4 = {}
    local v5 = scope:New("UIPadding")
    v5 = v5({PaddingLeft = UDim.new(0, ContentPadding), PaddingRight = UDim.new(0, ContentPadding), PaddingTop = UDim.new(0, ContentPadding), PaddingBottom = UDim.new(0, ContentPadding)})
    local v6 = scope:New("UIListLayout")
    local v7 = {FillDirection = FillDirection, SortOrder = Enum.SortOrder.LayoutOrder}
    local Padding = p1.Padding
    if not Padding then
        Padding = UDim.new(0, 6)
    end
    v7.Padding = Padding
    local HorizontalAlignment = p1.HorizontalAlignment
    if not HorizontalAlignment then
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    end
    v7.HorizontalAlignment = HorizontalAlignment
    local VerticalAlignment = p1.VerticalAlignment
    if not VerticalAlignment then
        VerticalAlignment = Enum.VerticalAlignment.Top
    end
    v7.VerticalAlignment = VerticalAlignment
    v7[scope.Out("AbsoluteContentSize")] = u8
    v6 = v6(v7)
    v4[1] = v5
    v4[2] = v6
    v4[3] = p1.Children
    v3[scope.Children] = v4
    return v2(v3)
end