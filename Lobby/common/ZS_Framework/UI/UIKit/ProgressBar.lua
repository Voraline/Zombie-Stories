local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
local u14 = require("../Components/GradientFade")
return function(p1) -- Line: 33 -- upvalues: u11 (val), u14 (val)
    local Visible, v1
    local scope = p1.scope
    v1 = scope:Computed(function(a1) -- Line: 35 -- upvalues: p1 (val), u11 (upval)
        local FillColor3
        local v1 = a1(p1.Value)
        local v2 = a1(p1.Max)
        if 0 >= v2 then
            FillColor3 = p1.FillColor3
            if not FillColor3 then
                FillColor3 = u11.Menu.Accent
            end
            return a1(FillColor3)
        end
        if v2 <= v1 then
            local CompleteColor3 = p1.CompleteColor3
            if not CompleteColor3 then
                CompleteColor3 = u11.Menu.Positive
            end
            return a1(CompleteColor3)
        end
        FillColor3 = p1.FillColor3
        if not FillColor3 then
            FillColor3 = u11.Menu.Accent
        end
        return a1(FillColor3)
    end)
    local CornerRadius = p1.CornerRadius
    if not CornerRadius then
        CornerRadius = UDim.new(0, 4)
    end
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Content
    end
    local v2 = scope:New("Frame")
    local v3 = {Name = p1.Name or "ProgressBar"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.new(1, 0, 0, 24)
    end
    v3.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v3.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.zero
    end
    v3.AnchorPoint = AnchorPoint
    v3.LayoutOrder = p1.LayoutOrder or 0
    v3.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v3.Visible = Visible
    v3.Parent = p1.Parent
    local TrackColor3 = p1.TrackColor3
    if not TrackColor3 then
        TrackColor3 = u11.Menu.PanelInset
    end
    v3.BackgroundColor3 = TrackColor3
    v3.BorderSizePixel = 0
    v3.ClipsDescendants = true
    local Children = scope.Children
    local v4 = {}
    local v5 = scope:New("UICorner")
    v5 = v5({CornerRadius = CornerRadius})
    local v6 = scope:New("UIStroke")
    v6 = v6({Thickness = u11.Stroke.Thin, Color = u11.Menu.Border, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
    local v7 = scope:New("Frame")
    local v8 = {
        Name = "Fill",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = v1,
        BorderSizePixel = 0,
        ZIndex = ZIndex,
    }
    local Children_2 = scope.Children
    local v9 = {}
    local v10 = u14({
        Rotation = 0,
        MinTransparency = 0,
        MaxTransparency = 1,
        CurrentValue = p1.Value,
        MaxValue = p1.Max,
        scope = scope,
    })
    local v11 = scope:New("UICorner")
    v9[1] = v10
    v9[2] = v11({CornerRadius = CornerRadius})
    v8[Children_2] = v9
    v7 = v7(v8)
    if p1.Text == nil then
        v8 = nil
    else
        v8 = scope:New("TextLabel")
        local v12 = {
            Name = "Label",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = p1.Text,
            TextSize = 13,
            Font = u11.Menu.Fonts.Header,
        }
        local TextColor3 = p1.TextColor3
        if not TextColor3 then
            TextColor3 = u11.Menu.Text
        end
        v12.TextColor3 = TextColor3
        v12.ZIndex = u11.ZIndex.Overlay
        local Children_3 = scope.Children
        v10 = {}
        v11 = scope:New("UIStroke")
        v10[1] = v11({Thickness = u11.Stroke.Thin, Color = u11.Menu.HeaderStroke})
        v12[Children_3] = v10
        v8 = v8(v12)
    end
    v4[1] = v5
    v4[2] = v6
    v4[3] = v7
    v4[4] = v8
    v3[Children] = v4
    return v2(v3)
end