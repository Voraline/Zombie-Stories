local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)
local Children = Fusion.Children
local u13 = require("./CostTemplate")
return function(p1) -- Line: 26 -- upvalues: u13 (val), Children (val)
    local scope = p1.scope
    local Costs = p1.Costs
    if not Costs then
        Costs = {}
    end
    local v1 = scope:ForPairs(Costs, function(p1, p2, p3, p4) -- Line: 30 -- upvalues: u13 (upval)
        return p3, u13({scope = p2, CostType = p4.type, Amount = p4.amount, LayoutOrder = p3})
    end)
    local v2 = scope:New("Frame")
    local v3 = {
        Name = "Costs",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = 4,
        Size = UDim2.fromScale(1, 0.3),
    }
    local v4 = {}
    local v5 = scope:New("UISizeConstraint")
    v5 = v5({MinSize = Vector2.new(120, 34)})
    local v6 = scope:New("UIListLayout")
    v6 = v6({
        Name = "UIListLayout",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    v4[1] = v5
    v4[2] = v6
    v4[3] = v1
    v3[Children] = v4
    return v2(v3)
end