local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u13 = require("../Theme")
return function(p1) -- Line: 49 -- upvalues: u13 (val), peek (val), OnEvent (val)
    local Visible, v1, v2, v3
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u13.ZIndex.Content
    end
    local Value = p1.Value
    if not Value then
        local Default
        if p1.Default ~= nil then
            Default = p1.Default
        else
            Default = false
        end
        Value = scope:Value(Default)
    end
    local v4 = scope:Computed(function(p1) -- Line: 57 -- upvalues: Value (val)
        if p1(Value) then
            return (UDim2.fromScale(1, 0.5))
        end
        return (UDim2.fromScale(0.4, 0.5))
    end)
    local v5 = scope:Spring(v4, 30, 1)
    local v6 = scope:Computed(function(p1) -- Line: 64 -- upvalues: Value (val)
        if p1(Value) then
            return 0
        end
        return 1
    end)
    local v7 = scope:Spring(v6, 30, 1)
    v4 = p1.Description ~= nil

    local function toggle() -- Line: 73 -- upvalues: p1 (val), peek (upval), Value (val)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        local v1 = not peek(Value)
        Value:set(v1)
        if p1.OnChanged then
            p1.OnChanged(v1)
        end
    end

    local v8 = scope:New("Frame")
    local v9 = {}
    v9.Name = p1.Name or "Toggle"
    local Size = p1.Size
    if not Size then
        local new = UDim2.new
        if not v4 then
            v1 = 44
        else
            v1 = 56
        end
        Size = new(1, 0, 0, v1)
    end
    v9.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v9.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v9.AnchorPoint = AnchorPoint
    v9.LayoutOrder = p1.LayoutOrder or 0
    v9.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v9.Visible = Visible
    v9.BackgroundColor3 = u13.Menu.Panel
    v9.BackgroundTransparency = 0
    v9.Parent = p1.Parent
    local Children = scope.Children
    local v10 = {}
    local v11 = scope:New("UICorner")({CornerRadius = UDim.new(0, u13.Menu.CornerRadius)})
    local v12 = scope:New("UIStroke")({
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = u13.Menu.Border,
        Thickness = u13.Menu.StrokeThickness,
    })
    v1 = scope:New("UIGradient")({Color = u13.Menu.Shade, Rotation = u13.Menu.ShadeRotation})
    local v13 = scope:New("UIPadding")({
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingTop = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 6),
    })
    local v14 = scope:New("TextLabel")
    local v15 = {Name = "Label", BackgroundTransparency = 1, TextScaled = true}
    local new_2 = Vector2.new
    if not v4 then
        v3 = 0.5
    else
        v3 = 0
    end
    v15.AnchorPoint = new_2(0, v3)
    if not v4 then
        v2 = UDim2.fromScale(0, 0.5)
    else
        v2 = UDim2.fromScale(0, 0)
    end
    v15.Position = v2
    v15.Size = UDim2.new(1, -80, 0, 18)
    v15.Text = p1.Text or ""
    v15.Font = u13.Menu.Fonts.Button
    v15.TextColor3 = u13.Menu.Text
    v15.TextXAlignment = Enum.TextXAlignment.Left
    v15.ZIndex = ZIndex + 1
    v14 = v14(v15)
    if not v4 then
        v15 = nil
    else
        v15 = scope:New("TextLabel")({
            Name = "Description",
            BackgroundTransparency = 1,
            TextScaled = true,
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, -80, 0, 14),
            Text = p1.Description,
            Font = u13.Menu.Fonts.Body,
            TextColor3 = u13.Menu.TextMuted,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = ZIndex + 1,
        })
    end
    v2 = scope:New("TextButton")
    local v16 = {
        Name = "Switch",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(56, 24),
        AutoButtonColor = false,
        BackgroundColor3 = u13.Menu.Text,
        BackgroundTransparency = 0.95,
        Text = "",
        ZIndex = ZIndex + 1,
    }
    v16[OnEvent("Activated")] = toggle
    local Children_2 = scope.Children
    local v17 = {}
    local v18 = scope:New("UICorner")({CornerRadius = UDim.new(0.17, 0)})
    local v19 = scope:New("UIStroke")({
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = u13.Menu.Border,
        Thickness = u13.Menu.StrokeThickness,
    })
    local v20 = scope:New("Frame")
    local v21 = {
        Name = "Fill",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = u13.Menu.Accent,
        BackgroundTransparency = v7,
        ZIndex = ZIndex + 1,
    }
    local Children_3 = scope.Children
    v21[Children_3] = {scope:New("UICorner")({CornerRadius = UDim.new(0.17, 0)})}
    v20 = v20(v21)
    v21 = scope:New("Frame")
    local v22 = {
        Name = "Knob",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = v5,
        Size = UDim2.fromScale(0.4, 0.84),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
        BackgroundColor3 = u13.Menu.Text,
        ZIndex = ZIndex + 2,
    }
    local Children_4 = scope.Children
    v22[Children_4] = {scope:New("UICorner")({CornerRadius = UDim.new(1, 0)})}
    v17[1] = v18
    v17[2] = v19
    v17[3] = v20
    v17[4] = v21(v22)
    v16[Children_2] = v17
    v10[1] = v11
    v10[2] = v12
    v10[3] = v1
    v10[4] = v13
    v10[5] = v14
    v10[6] = v15
    v10[7] = v2(v16)
    v9[Children] = v10
    return v8(v9)
end