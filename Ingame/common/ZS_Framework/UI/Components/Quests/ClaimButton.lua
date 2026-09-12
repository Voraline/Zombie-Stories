local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../GenericButton")
return function(p1) -- Line: 25 -- upvalues: u11 (val)
    local v1 = p1.scope:innerScope()
    local v2 = u11
    local v3 = {BackgroundTransparency = 0.75, OnClick = p1.OnClaim, Size = p1.Size}
    local Position = p1.Position
    if not Position then
        Position = UDim2.new(0, 0, 0, 0)
    end
    v3.Position = Position
    v3.AnchorPoint = Vector2.new(0.5, 0.5)
    local v4 = {}
    local v5 = v1:New("TextLabel")({
        BackgroundTransparency = 1,
        TextScaled = true,
        Text = v1:Computed(function(p1_2) -- Line: 37 -- upvalues: p1 (val)
            local v1 = p1_2(p1.IsClaimed)
            local v2 = p1_2(p1.IsCompleted)
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
    local v6 = v1:New("UIStroke")({Thickness = p1.StrokeSize, Color = p1.StrokeColor, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
    local v7 = v1:New("UICorner")
    local v8 = {CornerRadius = p1.CornerRadius}
    v4[1] = v5
    v4[2] = v6
    v4[3] = v7(v8)
    v3.Children = v4
    v3.scope = v1
    return v2(v3)
end