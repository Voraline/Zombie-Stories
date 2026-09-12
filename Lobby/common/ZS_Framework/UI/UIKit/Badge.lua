local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
local Card = require(script.Parent.Card)
return function(p1) -- Line: 30 -- upvalues: u11 (val), Card (val)
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Overlay
    end
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = u11.Menu.Accent
    end
    local v1 = Card
    local v2 = {BackgroundTransparency = 0.25, Shade = false, scope = scope, Name = p1.Name or "Badge"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(96, 20)
    end
    v2.Size = Size
    v2.Position = p1.Position
    v2.AnchorPoint = p1.AnchorPoint
    v2.LayoutOrder = p1.LayoutOrder
    v2.ZIndex = ZIndex
    v2.Visible = p1.Visible
    v2.Parent = p1.Parent
    v2.BackgroundColor3 = BackgroundColor3
    v2.StrokeColor3 = p1.StrokeColor3 or BackgroundColor3
    v2.StrokeThickness = u11.Stroke.Thin
    local v3 = {}
    local v4 = scope:New("TextLabel")
    local v5 = {BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = p1.Text}
    local TextColor3 = p1.TextColor3
    if not TextColor3 then
        TextColor3 = u11.Menu.Text
    end
    v5.TextColor3 = TextColor3
    v5.Font = u11.Menu.Fonts.Title
    v5.TextSize = p1.TextSize or 12
    v5.ZIndex = ZIndex + 1
    v3[1] = v4(v5)
    v2.Children = v3
    return v1(v2)
end