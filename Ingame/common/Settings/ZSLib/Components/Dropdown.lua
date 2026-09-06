local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local u16 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 32 -- upvalues: Children (val), u16 (val), OnEvent (val)
    local Visible, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local scope = p1.scope
    local u632 = scope:Value(p1.Default)
    local v13 = p1.Description ~= nil
    local v14 = {}
    local v15 = {}
    local Options = p1.Options
    local v16 = nil
    local v17 = nil
    local u628 = p1
    for i, j in Options, v16, v17 do
        if type(j) ~= "table" then
            v1 = j
        else
            v1 = j[1]
        end
        if type(j) ~= "table" then
            v2 = i
        else
            v2 = j[2]
        end
        table.insert(v15, i)
        v3 = scope:New("TextButton")
        v4 = {
            Name = v1,
            BackgroundTransparency = 1,
            LayoutOrder = v2,
            Size = UDim2.fromScale(0.5, 0.14),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
        }
        v5 = {}
        v6 = scope:New("Frame")
        v7 = {
            Name = "Frame",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0.95,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, 0, 0.8, -6),
        }
        v8 = {}
        v9 = scope:New("UICorner")
        v9 = v9({CornerRadius = UDim.new(0.2, 0)})
        v10 = scope:New("UIStroke")
        v10 = v10({Thickness = 3, Color = Color3.fromRGB(255, 184, 84)})
        v11 = scope:New("TextLabel")
        v12 = {
            Name = "Label",
            BackgroundTransparency = 1,
            TextScaled = true,
            AnchorPoint = Vector2.new(0.5, 0.5),
            FontFace = u16,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.9, 0.8),
            Text = v1,
            TextColor3 = Color3.fromRGB(255, 184, 84),
        }
        v8[1] = v9
        v8[2] = v10
        v8[3] = v11(v12)
        v7[Children] = v8
        v5[1] = v6(v7)
        v4[Children] = v5
        table.insert(v14, v3(v4))
    end
    local u22 = nil
    v16 = scope:New("ImageButton")
    v17 = {
        Name = "Dropdown",
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Image = "rbxassetid://2851928361",
        ImageColor3 = Color3.fromRGB(6, 14, 24),
        ImageTransparency = 0.2,
        Position = UDim2.fromScale(1, 1),
        ScaleType = Enum.ScaleType.Slice,
        Selectable = false,
        Size = UDim2.fromScale(1, 1),
        SliceCenter = Rect.new(7, 7, 7, 7),
        Visible = false,
        ZIndex = 2,
    }
    local v18 = {}
    v1 = scope:New("ScrollingFrame")
    v2 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        CanvasSize = UDim2.new(),
        ClipsDescendants = false,
        Position = UDim2.fromScale(0.5, 0.5),
        ScrollBarImageColor3 = Color3.fromRGB(16, 16, 16),
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = false,
        Size = UDim2.new(1, -5, 1, -5),
    }
    local v19 = {}
    v3 = scope:New("UIListLayout")
    v3 = v3({HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center})
    v19[1] = v3
    v19[2] = table.unpack(v14)
    v2[Children] = v19
    v1 = v1(v2)
    v2 = scope:New("TextButton")
    local v20 = {
        Name = "Exit",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(50, 17, 17),
        BackgroundTransparency = 0.5,
        LayoutOrder = 1000,
        Position = UDim2.fromScale(0.98, 0.02),
        Size = UDim2.fromScale(0.1, 0.1),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = "X",
        TextColor3 = Color3.fromRGB(255, 73, 73),
        TextScaled = true,
        TextTransparency = 1,
    }
    local MouseButton1Click = OnEvent("MouseButton1Click")
    v20[MouseButton1Click] = function() -- Line: 142 -- upvalues: u628 (val), u22 (ref)
        if u628.ButtonSound then
            u628.ButtonSound:Play()
        end
        u22.Visible = false
    end
    v3 = {}
    v4 = scope:New("UIStroke")
    v4 = v4({Thickness = 3, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 73, 73)})
    local v21 = scope:New("UICorner")
    v21 = v21({CornerRadius = UDim.new(0.2, 0)})
    v5 = scope:New("TextLabel")
    v6 = {
        Name = "Label",
        BackgroundTransparency = 1,
        Text = "X",
        TextScaled = true,
        AnchorPoint = Vector2.new(0.5, 0.5),
        FontFace = u16,
        Position = UDim2.fromScale(0.525, 0.5),
        Size = UDim2.fromScale(0.85, 0.8),
        TextColor3 = Color3.fromRGB(255, 73, 73),
    }
    v3[1] = v4
    v3[2] = v21
    v3[3] = v5(v6)
    v20[Children] = v3
    v18[1] = v1
    v18[2] = v2(v20)
    v17[Children] = v18
    u22 = v16(v17)
    v16 = v14
    v17 = nil
    local v22 = nil
    for k, n in v16, v17, v22 do
        local u482 = v15[k]
        v20 = u628.Options[u482]
        if type(v20) ~= "table" then
            u489 = v20
        else
            local u489 = v20[1]
        end
        n.MouseButton1Click:Connect(function() -- Line: 178 -- upvalues: u628 (val), u22 (ref), u632 (val), u489 (val), u482 (val)
            if u628.ButtonSound then
                u628.ButtonSound:Play()
            end
            u22.Visible = false
            u632:set(u489)
            if u628.OnChanged then
                u628.OnChanged(u482, u489)
            end
        end)
    end
    local Frame = u22:FindFirstChild("Frame")
    if Frame then
        local UIListLayout = Frame:FindFirstChildWhichIsA("UIListLayout")
        if UIListLayout then
            local PropertyChangedSignal = UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize")
            PropertyChangedSignal:Connect(function() -- Line: 195 -- upvalues: UIListLayout (val), Frame (val)
                local Y = UIListLayout.AbsoluteContentSize.Y
                Frame.CanvasSize = UDim2.new(0, 0, 0, Y)
                if Frame.AbsoluteSize.Y < Y then
                    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                end
            end)
        end
    end
    v17 = scope:New("Frame")
    v22 = {Name = "Dropdown", BackgroundTransparency = 1, LayoutOrder = u628.LayoutOrder or 1}
    if not v13 then
        v18 = UDim2.fromScale(1, 0.08)
    else
        v18 = UDim2.fromScale(1, 0.11)
    end
    v22.Size = v18
    v22.SizeConstraint = Enum.SizeConstraint.RelativeXX
    if u628.Visible == nil then
        Visible = true
    else
        Visible = u628.Visible
    end
    v22.Visible = Visible
    v1 = {}
    v2 = scope:New("Frame")
    v20 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    v3 = {}
    v4 = scope:New("UICorner")
    v4 = v4({})
    v21 = scope:New("ImageButton")
    v5 = {
        Name = "Toggle",
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0.9,
        Image = "rbxassetid://2851928361",
        ImageColor3 = Color3.fromRGB(33, 33, 33),
        ImageTransparency = 1,
        Position = UDim2.fromScale(1, 0.5),
        ScaleType = Enum.ScaleType.Slice,
        Size = UDim2.fromScale(0.22, 1),
        SliceCenter = Rect.new(7, 7, 7, 7),
    }
    local MouseButton1Click_2 = OnEvent("MouseButton1Click")
    v5[MouseButton1Click_2] = function() -- Line: 239 -- upvalues: u628 (val), u22 (ref)
        if u628.ButtonSound then
            u628.ButtonSound:Play()
        end
        u22.Visible = true
        if u628.OnDropdownOpened then
            u628.OnDropdownOpened(u22)
        end
    end
    v7 = {}
    local v23 = scope:New("TextLabel")
    v23 = v23({
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0.5),
        FontFace = u16,
        Position = UDim2.fromScale(0.05, 0.5),
        Size = UDim2.fromScale(0.78, 0.6),
        Text = u632,
        TextColor3 = Color3.new(1, 1, 1),
    })
    v8 = scope:New("ImageLabel")
    v8 = v8({
        Name = "keyboard_arrow_down",
        BackgroundTransparency = 1,
        Image = "rbxassetid://3926305904",
        LayoutOrder = 19,
        Selectable = true,
        ZIndex = 2,
        AnchorPoint = Vector2.new(1, 0.5),
        ImageRectOffset = Vector2.new(404, 284),
        ImageRectSize = Vector2.new(36, 36),
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromScale(0.2, 0.2),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    })
    v9 = scope:New("UICorner")
    v10 = {CornerRadius = UDim.new(0.15, 0)}
    v7[1] = v23
    v7[2] = v8
    v7[3] = v9(v10)
    v5[Children] = v7
    v21 = v21(v5)
    v5 = scope:New("TextLabel")
    v6 = {
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        FontFace = u16,
        Position = UDim2.fromScale(0.01, 0.04),
        Size = UDim2.fromScale(0.76, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = u628.Text,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
    }
    v5 = v5(v6)
    if not v13 then
        v6 = nil
    else
        v6 = scope:New("TextLabel")
        v6 = v6({
            Name = "DescriptionLabel",
            BackgroundTransparency = 1,
            TextScaled = true,
            TextTransparency = 0.5,
            AnchorPoint = Vector2.new(0, 1),
            FontFace = u16,
            Position = UDim2.fromScale(0.01, 0.96),
            Size = UDim2.fromScale(0.76, 0.05),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Text = u628.Description,
            TextColor3 = Color3.new(1, 1, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end
    v3[1] = v4
    v3[2] = v21
    v3[3] = v5
    v3[4] = v6
    v20[Children] = v3
    v1[1] = v2(v20)
    v22[Children] = v1
    return v17(v22), u22, u632
end