require(game:GetService("ReplicatedStorage").Packages.Fusion)
local u11 = require("../Theme")
return function(p1) -- Line: 21 -- upvalues: u11 (val)
    local scope = p1.scope
    local v1 = scope:New("UIStroke")
    local v2 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.new(1, 1, 1)}
    local Thickness = p1.Thickness
    if not Thickness then
        Thickness = u11.Menu.StrokeThickness
    end
    v2.Thickness = Thickness
    v2.Transparency = p1.Transparency or 0
    local Children = scope.Children
    local v3 = {}
    local v4 = scope:New("UIGradient")
    local v5 = {}
    local Color = p1.Color
    if not Color then
        Color = u11.Menu.ButtonGradient
    end
    v5.Color = Color
    v5.Rotation = p1.Rotation or 0
    v3[1] = v4(v5)
    v2[Children] = v3
    return v1(v2)
end