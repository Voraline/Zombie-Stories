local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u16 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 32 -- upvalues: Children (val), u16 (val), OnEvent (val)
    local Visible, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    local scope = p1.scope
    local Default = p1.Default
    local u632 = scope:Value(Default)
    local v15 = p1.Description ~= nil
    local v16 = {}
    local v17 = {}
    local Options = p1.Options
    local v18 = nil
    local v19 = nil
    for i, j in Options, v18, v19 do
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
        table.insert(v17, i)
        v3 = scope:New("TextButton")
        v4 = {
            Name = v1,
            BackgroundTransparency = 1,
            LayoutOrder = v2,
            Size = UDim2.fromScale(0.5, 0.14),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
        }
        v5 = Children
        v6 = {}
        v7 = scope:New("Frame")
        v8 = {
            Name = "Frame",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0.95,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(1, 0, 0.8, -6),
        }
        v9 = Children
        v10 = {}
        v11 = scope:New("UICorner")({CornerRadius = UDim.new(0.2, 0)})
        v12 = scope:New("UIStroke")({Thickness = 3, Color = Color3.fromRGB(255, 184, 84)})
        v13 = scope:New("TextLabel")
        v14 = {
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
        v10[1] = v11
        v10[2] = v12
        v10[3] = v13(v14)
        v8[v9] = v10
        v6[1] = v7(v8)
        v4[v5] = v6
        v3 = v3(v4)
        table.insert(v16, v3)
    end
    local u22 = nil
    v18 = scope:New("ImageButton")
    v19 = {
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
    local v20 = Children
    local v21 = {}
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
    local v22 = Children
    v2[v22] = {
        scope:New("UIListLayout")({
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
        }),
        table.unpack(v16),
    }
    v1 = v1(v2)
    v2 = scope:New("TextButton")
    v22 = {
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

    v22[MouseButton1Click] = function() -- Line: 142 -- upvalues: p1 (val), u22 (ref)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        u22.Visible = false
    end

    local v23 = Children
    v3 = {}
    v4 = scope:New("UIStroke")({Thickness = 3, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 73, 73)})
    v5 = scope:New("UICorner")({CornerRadius = UDim.new(0.2, 0)})
    v6 = scope:New("TextLabel")
    v7 = {
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
    v3[2] = v5
    v3[3] = v6(v7)
    v22[v23] = v3
    v21[1] = v1
    v21[2] = v2(v22)
    v19[v20] = v21
    u22 = v18(v19)
    v18 = v16
    v19 = nil
    v20 = nil
    for k, n in v18, v19, v20 do
        local u482 = v17[k]
        v22 = p1.Options[u482]
        if type(v22) ~= "table" then
            u489 = v22
        else
            local u489 = v22[1]
        end
        n.MouseButton1Click:Connect(function() -- Line: 178 -- upvalues: p1 (val), u22 (ref), u632 (val), u489 (val), u482 (val)
            if p1.ButtonSound then
                p1.ButtonSound:Play()
            end
            u22.Visible = false
            local v1 = u632
            local v2 = u489
            v1:set(v2)
            if p1.OnChanged then
                p1.OnChanged(u482, u489)
            end
        end)
    end
    local Frame = u22:FindFirstChild("Frame")
    if Frame then
        local UIListLayout = Frame:FindFirstChildWhichIsA("UIListLayout")
        if UIListLayout then
            (UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function() -- Line: 195 -- upvalues: UIListLayout (val), Frame (val)
                local Y = UIListLayout.AbsoluteContentSize.Y
                Frame.CanvasSize = UDim2.new(0, 0, 0, Y)
                if Frame.AbsoluteSize.Y < Y then
                    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
                end
            end)
        end
    end
    v19 = scope:New("Frame")
    v20 = {Name = "Dropdown", BackgroundTransparency = 1, LayoutOrder = p1.LayoutOrder or 1}
    if not v15 then
        v21 = UDim2.fromScale(1, 0.08)
    else
        v21 = UDim2.fromScale(1, 0.11)
    end
    v20.Size = v21
    v20.SizeConstraint = Enum.SizeConstraint.RelativeXX
    if p1.Visible == nil then
        Visible = true
    else
        Visible = p1.Visible
    end
    v20.Visible = Visible
    v21 = Children
    v1 = {}
    v2 = scope:New("Frame")
    v22 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.new(),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
    }
    v23 = Children
    v3 = {}
    v4 = scope:New("UICorner")({})
    v5 = scope:New("ImageButton")
    v6 = {
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

    v6[MouseButton1Click_2] = function() -- Line: 239 -- upvalues: p1 (val), u22 (ref)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        u22.Visible = true
        if p1.OnDropdownOpened then
            p1.OnDropdownOpened(u22)
        end
    end

    v7 = Children
    v8 = {}
    v9 = scope:New("TextLabel")({
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
    v10 = scope:New("ImageLabel")({
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
    v11 = scope:New("UICorner")
    v12 = {CornerRadius = UDim.new(0.15, 0)}
    v8[1] = v9
    v8[2] = v10
    v8[3] = v11(v12)
    v6[v7] = v8
    v5 = v5(v6)
    v6 = scope:New("TextLabel")
    v7 = {
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        FontFace = u16,
        Position = UDim2.fromScale(0.01, 0.04),
        Size = UDim2.fromScale(0.76, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Text = p1.Text,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
    }
    v6 = v6(v7)
    if not v15 then
        v7 = nil
    else
        v7 = scope:New("TextLabel")({
            Name = "DescriptionLabel",
            BackgroundTransparency = 1,
            TextScaled = true,
            TextTransparency = 0.5,
            AnchorPoint = Vector2.new(0, 1),
            FontFace = u16,
            Position = UDim2.fromScale(0.01, 0.96),
            Size = UDim2.fromScale(0.76, 0.05),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            Text = p1.Description,
            TextColor3 = Color3.new(1, 1, 1),
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end
    v3[1] = v4
    v3[2] = v5
    v3[3] = v6
    v3[4] = v7
    v22[v23] = v3
    v1[1] = v2(v22)
    v20[v21] = v1
    v19 = v19(v20)
    v21 = u22
    return v19, v21, u632
end