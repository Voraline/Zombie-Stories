local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Children = (require(Packages.Fusion)).Children
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
    local v3 = Children
    local v4 = {}
    local v5 = scope:New("UISizeConstraint")({MinSize = Vector2.new(120, 52)})
    local v6 = scope:New("UIListLayout")({
        Name = "UIListLayout",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    local v7 = scope:New("UIPadding")({Name = "UIPadding", PaddingBottom = UDim.new(0.1, 0), PaddingTop = UDim.new(0.1, 0)})
    local v8 = u18
    local v9 = {scope = scope, OnClick = p1.OnBuy, Enabled = p1.BuyEnabled}
    v4[1] = v5
    v4[2] = v6
    v4[3] = v7
    v4[4] = v8(v9)
    v2[v3] = v4
    return v1(v2)
end