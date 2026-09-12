local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Theme")
local u14 = require("./Card")
return function(p1) -- Line: 69 -- upvalues: u11 (val), u14 (val)
    local Equipped, Locked
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u11.ZIndex.Content
    end
    local v1 = scope:New("ViewportFrame")({
        Name = "ViewportFrame",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.04),
        Size = UDim2.fromScale(0.9, 0.62),
        ZIndex = ZIndex,
    })
    local v2 = u14
    local v3 = {scope = scope, Name = p1.Name or "ItemTile"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(118, 132)
    end
    v3.Size = Size
    v3.Position = p1.Position
    v3.AnchorPoint = p1.AnchorPoint
    v3.LayoutOrder = p1.LayoutOrder
    v3.ZIndex = ZIndex
    v3.Parent = p1.Parent
    v3.BackgroundColor3 = p1.BackgroundColor3
    local BorderColor3 = p1.BorderColor3
    if not BorderColor3 then
        BorderColor3 = u11.Menu.Border
    end
    v3.StrokeColor3 = BorderColor3
    local StrokeThickness = p1.StrokeThickness
    if not StrokeThickness then
        StrokeThickness = u11.Menu.StrokeThickness
    end
    v3.StrokeThickness = StrokeThickness
    v3.OnClick = p1.OnClick
    v3.InteractionEnabled = p1.InteractionEnabled
    v3.HoverScale = p1.HoverScale
    v3.HoverSheen = p1.HoverSheen
    v3.OnHoverChanged = p1.OnHoverChanged
    local v4 = {}
    local v5 = scope:New("TextLabel")
    local v6 = {
        Name = "NameLabel",
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.fromScale(0.5, 0.98),
        Size = UDim2.fromScale(0.92, 0.22),
        BackgroundTransparency = 1,
        Text = p1.DisplayName or "",
        Font = u11.Menu.Fonts.Body,
    }
    local NameColor = p1.NameColor
    if not NameColor then
        NameColor = u11.Menu.Text
    end
    v6.TextColor3 = NameColor
    v6.TextScaled = true
    v6.TextXAlignment = Enum.TextXAlignment.Center
    v6.ZIndex = ZIndex + 1
    local Children = scope.Children
    local v7 = {}
    local v8 = scope:New("UIStroke")({Thickness = 1, Color = u11.Menu.HeaderStroke})
    local v9 = scope:New("UITextSizeConstraint")
    v7[1] = v8
    v7[2] = v9({MaxTextSize = 16})
    v6[Children] = v7
    v5 = v5(v6)
    v6 = scope:New("TextLabel")
    local v10 = {Name = "Equipped"}
    if p1.Equipped ~= nil then
        Equipped = p1.Equipped
    else
        Equipped = false
    end
    v10.Visible = Equipped
    v10.AnchorPoint = Vector2.new(1, 0)
    v10.Position = UDim2.new(1, -4, 0, 4)
    v10.Size = UDim2.fromOffset(22, 22)
    v10.BackgroundColor3 = u11.Menu.Positive
    v10.Text = "✓"
    v10.Font = u11.Menu.Fonts.Button
    v10.TextColor3 = u11.Menu.PanelInset
    v10.TextScaled = true
    v10.ZIndex = ZIndex + 2
    local Children_2 = scope.Children
    v10[Children_2] = {scope:New("UICorner")({CornerRadius = UDim.new(0, u11.Menu.CornerRadius)})}
    v6 = v6(v10)
    v10 = scope:New("Frame")
    v7 = {Name = "LockedFrame"}
    if p1.Locked ~= nil then
        Locked = p1.Locked
    else
        Locked = false
    end
    v7.Visible = Locked
    v7.Size = UDim2.fromScale(1, 1)
    v7.BackgroundColor3 = u11.Menu.PanelInset
    v7.BackgroundTransparency = 0.35
    v7.ZIndex = ZIndex + 3
    local Children_3 = scope.Children
    v9 = {}
    local v11 = scope:New("UICorner")({CornerRadius = UDim.new(0, u11.Menu.CornerRadius)})
    local v12 = scope:New("TextLabel")
    local v13 = {
        Name = "UnlockLevelLabel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.9, 0.3),
        BackgroundTransparency = 1,
        Text = p1.LockText or "LOCKED",
        Font = u11.Menu.Fonts.Button,
        TextColor3 = u11.Menu.TextMuted,
        TextScaled = true,
        ZIndex = ZIndex + 4,
    }
    local Children_4 = scope.Children
    local v14 = {}
    local v15 = scope:New("UIStroke")({Thickness = 1, Color = u11.Menu.HeaderStroke})
    local v16 = scope:New("UITextSizeConstraint")
    v14[1] = v15
    v14[2] = v16({MaxTextSize = 14})
    v13[Children_4] = v14
    v9[1] = v11
    v9[2] = v12(v13)
    v7[Children_3] = v9
    v4[1] = v1
    v4[2] = v5
    v4[3] = v6
    v4[4] = v10(v7)
    v3.Children = v4
    v2 = v2(v3)
    if p1.RenderViewport then
        p1.RenderViewport(v1)
    end
    return v2
end