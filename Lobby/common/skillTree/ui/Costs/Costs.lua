local Packages = (game:GetService("ReplicatedStorage")).Packages
local Fusion = require(Packages.Fusion)
local Children = Fusion.Children
local ForPairs = Fusion.ForPairs
local u13 = require("./CostTemplate")
return function(p1) -- Line: 26 -- upvalues: u13 (val), Children (val)
    local scope = p1.scope
    local Costs = p1.Costs
    if not Costs then
        Costs = {}
    end
    local v1 = scope:ForPairs(Costs, function(p1, p2, p3, p4) -- Line: 30 -- upvalues: u13 (upval)
        local v1 = u13
        local v2 = {scope = p2, CostType = p4.type, Amount = p4.amount, LayoutOrder = p3}
        return p3, v1(v2)
    end)
    local v2 = scope:New("Frame")
    local v3 = {
        Name = "Costs",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 4,
        Size = UDim2.fromScale(1, 0.3),
    }
    local v4 = Children
    local v5 = {}
    local v6 = scope:New("UISizeConstraint")({MinSize = Vector2.new(120, 34)})
    local v7 = scope:New("UIListLayout")({
        Name = "UIListLayout",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    v5[1] = v6
    v5[2] = v7
    v5[3] = v1
    v3[v4] = v5
    return v2(v3)
end