local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local u18 = require("./BuyButton")
return function(p1) -- Line: 21 -- upvalues: Theme (val), Children (val), u18 (val)
    local scope = p1.scope
    local v1 = scope:New("Frame")
    local v2 = {
        Name = "Controls",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = Theme.ZIndex.Modal + 1,
        LayoutOrder = 5,
        Size = UDim2.fromScale(1, 0.3),
    }
    local v3 = {}
    local v4 = scope:New("UISizeConstraint")
    v4 = v4({MinSize = Vector2.new(120, 52)})
    local v5 = scope:New("UIListLayout")
    v5 = v5({
        Name = "UIListLayout",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    local v6 = scope:New("UIPadding")
    v6 = v6({Name = "UIPadding", PaddingBottom = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0)})
    local v7 = {scope = scope, OnClick = p1.OnBuy, Enabled = p1.BuyEnabled}
    v3[1] = v4
    v3[2] = v5
    v3[3] = v6
    v3[4] = u18(v7)
    v2[Children] = v3
    return v1(v2)
end