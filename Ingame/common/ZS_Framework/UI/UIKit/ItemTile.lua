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
    local v1 = scope:New("ViewportFrame")
    v1 = v1({
        Name = "ViewportFrame",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0.04),
        Size = UDim2.fromScale(0.9, 0.62),
        ZIndex = ZIndex,
    })
    local v2 = {scope = scope, Name = p1.Name or "ItemTile"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(118, 132)
    end
    v2.Size = Size
    v2.Position = p1.Position
    v2.AnchorPoint = p1.AnchorPoint
    v2.LayoutOrder = p1.LayoutOrder
    v2.ZIndex = ZIndex
    v2.Parent = p1.Parent
    v2.BackgroundColor3 = p1.BackgroundColor3
    local BorderColor3 = p1.BorderColor3
    if not BorderColor3 then
        BorderColor3 = u11.Menu.Border
    end
    v2.StrokeColor3 = BorderColor3
    local StrokeThickness = p1.StrokeThickness
    if not StrokeThickness then
        StrokeThickness = u11.Menu.StrokeThickness
    end
    v2.StrokeThickness = StrokeThickness
    v2.OnClick = p1.OnClick
    v2.InteractionEnabled = p1.InteractionEnabled
    v2.HoverScale = p1.HoverScale
    v2.HoverSheen = p1.HoverSheen
    v2.OnHoverChanged = p1.OnHoverChanged
    local v3 = {}
    local v4 = scope:New("TextLabel")
    local v5 = {
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
    v5.TextColor3 = NameColor
    v5.TextScaled = true
    v5.TextXAlignment = Enum.TextXAlignment.Center
    v5.ZIndex = ZIndex + 1
    local Children = scope.Children
    local v6 = {}
    local v7 = scope:New("UIStroke")
    v7 = v7({Thickness = 1, Color = u11.Menu.HeaderStroke})
    local v8 = scope:New("UITextSizeConstraint")
    v6[1] = v7
    v6[2] = v8({MaxTextSize = 16})
    v5[Children] = v6
    v4 = v4(v5)
    v5 = scope:New("TextLabel")
    local v9 = {Name = "Equipped"}
    if p1.Equipped ~= nil then
        Equipped = p1.Equipped
    else
        Equipped = false
    end
    v9.Visible = Equipped
    v9.AnchorPoint = Vector2.new(1, 0)
    v9.Position = UDim2.new(1, -4, 0, 4)
    v9.Size = UDim2.fromOffset(22, 22)
    v9.BackgroundColor3 = u11.Menu.Positive
    v9.Text = "✓"
    v9.Font = u11.Menu.Fonts.Button
    v9.TextColor3 = u11.Menu.PanelInset
    v9.TextScaled = true
    v9.ZIndex = ZIndex + 2
    local Children_2 = scope.Children
    v7 = {}
    v8 = scope:New("UICorner")
    v7[1] = v8({CornerRadius = UDim.new(0, u11.Menu.CornerRadius)})
    v9[Children_2] = v7
    v5 = v5(v9)
    v9 = scope:New("Frame")
    v6 = {Name = "LockedFrame"}
    if p1.Locked ~= nil then
        Locked = p1.Locked
    else
        Locked = false
    end
    v6.Visible = Locked
    v6.Size = UDim2.fromScale(1, 1)
    v6.BackgroundColor3 = u11.Menu.PanelInset
    v6.BackgroundTransparency = 0.35
    v6.ZIndex = ZIndex + 3
    local Children_3 = scope.Children
    v8 = {}
    local v10 = scope:New("UICorner")
    v10 = v10({CornerRadius = UDim.new(0, u11.Menu.CornerRadius)})
    local v11 = scope:New("TextLabel")
    local v12 = {
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
    local v13 = {}
    local v14 = scope:New("UIStroke")
    v14 = v14({Thickness = 1, Color = u11.Menu.HeaderStroke})
    local v15 = scope:New("UITextSizeConstraint")
    v13[1] = v14
    v13[2] = v15({MaxTextSize = 14})
    v12[Children_4] = v13
    v8[1] = v10
    v8[2] = v11(v12)
    v6[Children_3] = v8
    v3[1] = v1
    v3[2] = v4
    v3[3] = v5
    v3[4] = v9(v6)
    v2.Children = v3
    local v16 = u14(v2)
    if p1.RenderViewport then
        p1.RenderViewport(v1)
    end
    return v16
end