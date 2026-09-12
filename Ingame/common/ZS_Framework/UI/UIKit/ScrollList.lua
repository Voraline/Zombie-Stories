local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
return function(p1) -- Line: 53 -- upvalues: u11 (val)
    local Visible, X
    local scope = p1.scope
    local v1 = Vector2.new(0, 0)
    local u8 = scope:Value(v1)
    local u10 = p1.CanvasPadding or 8
    local ContentPadding = p1.ContentPadding
    if not ContentPadding then
        ContentPadding = u11.Menu.StrokeThickness
    end
    local FillDirection = p1.FillDirection
    if not FillDirection then
        FillDirection = Enum.FillDirection.Vertical
    end
    local v2 = scope:Computed(function(p1_2) -- Line: 62 -- upvalues: u8 (val), p1 (val), FillDirection (val), u10 (val), ContentPadding (val)
        local v1
        local v2 = p1_2(u8)
        if p1.Scale ~= nil then
            v1 = p1_2(p1.Scale)
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
    local v3 = scope:New("ScrollingFrame")
    local v4 = {Name = p1.Name or "ScrollList"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromScale(1, 1)
    end
    v4.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v4.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v4.AnchorPoint = AnchorPoint
    v4.BackgroundTransparency = 1
    v4.BorderSizePixel = 0
    v4.LayoutOrder = p1.LayoutOrder or 0
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Content
    end
    v4.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v4.Visible = Visible
    v4.Parent = p1.Parent
    v4.CanvasSize = v2
    if FillDirection ~= Enum.FillDirection.Horizontal then
        X = Enum.ScrollingDirection.Y
    else
        X = Enum.ScrollingDirection.X
    end
    v4.ScrollingDirection = X
    v4.ScrollBarThickness = p1.ScrollBarThickness or 4
    local ScrollBarImageColor3 = p1.ScrollBarImageColor3
    if not ScrollBarImageColor3 then
        ScrollBarImageColor3 = u11.Menu.Border
    end
    v4.ScrollBarImageColor3 = ScrollBarImageColor3
    v4.ScrollBarImageTransparency = 0.4
    local Children = scope.Children
    local v5 = {}
    local v6 = scope:New("UIPadding")({
        PaddingLeft = UDim.new(0, ContentPadding),
        PaddingRight = UDim.new(0, ContentPadding),
        PaddingTop = UDim.new(0, ContentPadding),
        PaddingBottom = UDim.new(0, ContentPadding),
    })
    local v7 = scope:New("UIListLayout")
    local v8 = {FillDirection = FillDirection, SortOrder = Enum.SortOrder.LayoutOrder}
    local Padding = p1.Padding
    if not Padding then
        Padding = UDim.new(0, 6)
    end
    v8.Padding = Padding
    local HorizontalAlignment = p1.HorizontalAlignment
    if not HorizontalAlignment then
        HorizontalAlignment = Enum.HorizontalAlignment.Center
    end
    v8.HorizontalAlignment = HorizontalAlignment
    local VerticalAlignment = p1.VerticalAlignment
    if not VerticalAlignment then
        VerticalAlignment = Enum.VerticalAlignment.Top
    end
    v8.VerticalAlignment = VerticalAlignment
    v8[scope.Out("AbsoluteContentSize")] = u8
    v7 = v7(v8)
    v5[1] = v6
    v5[2] = v7
    v5[3] = p1.Children
    v4[Children] = v5
    return v3(v4)
end