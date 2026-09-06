local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../GenericButton")
return function(p1) -- Line: 25 -- upvalues: u11 (val)
    local v1 = p1.scope:innerScope()
    local v2 = {BackgroundTransparency = 0.75, OnClick = p1.OnClaim, Size = p1.Size}
    local Position = p1.Position
    if not Position then
        Position = UDim2.new(0, 0, 0, 0)
    end
    v2.Position = Position
    v2.AnchorPoint = Vector2.new(0.5, 0.5)
    local v3 = {}
    local v4 = v1:New("TextLabel")
    v4 = v4({
        BackgroundTransparency = 1,
        TextScaled = true,
        Text = v1:Computed(function(a1) -- Line: 37 -- upvalues: p1 (val)
            local v1 = a1(p1.IsClaimed)
            local v2 = a1(p1.IsCompleted)
            if v1 then
                return "CLAIMED"
            end
            if v2 then
                return "CLAIM"
            end
            return "IN PROGRESS"
        end),
        Size = UDim2.new(0.9, 0, 0.9, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.GothamBold,
    })
    local v5 = v1:New("UIStroke")
    v5 = v5({Thickness = p1.StrokeSize, Color = p1.StrokeColor, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
    local v6 = v1:New("UICorner")
    local v7 = {CornerRadius = p1.CornerRadius}
    v3[1] = v4
    v3[2] = v5
    v3[3] = v6(v7)
    v2.Children = v3
    v2.scope = v1
    return u11(v2)
end