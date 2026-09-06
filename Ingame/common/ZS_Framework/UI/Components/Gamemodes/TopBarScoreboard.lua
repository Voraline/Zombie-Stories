return function(p1) -- Line: 7
    local Children, Children_2, v1, v2, v3, v4, v5, v6
    local scope = p1.scope
    local v7 = scope:ForPairs(p1.PlayerList, function(p1, p2, p3, p4) -- Line: 10
        local v1 = p2:New("Frame")
        local v2 = {Size = UDim2.new(0.2, 0, 1, 0), BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.180392), LayoutOrder = p2:Computed(function(p1) -- Line: 14 -- upvalues: p4 (val)
            return p1(p4.Score) * -1
        end), Visible = p4.Visible}
        local Children = p2.Children
        local v3 = {}
        local v4 = p2:New("TextLabel")
        v4 = v4({
            BackgroundTransparency = 1,
            TextScaled = true,
            ZIndex = 2,
            Size = UDim2.new(0.8, 0, 0.2, 0),
            Position = UDim2.new(0.5, 0, 0.1, 0),
            AnchorPoint = Vector2.new(0.5, 0),
            Text = p4.Name,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.GothamBlack,
        })
        local v5 = p2:New("TextLabel")
        v5 = v5({
            BackgroundTransparency = 1,
            TextScaled = true,
            ZIndex = 2,
            Size = UDim2.new(0.8, 0, 0.2, 0),
            Position = UDim2.new(0.5, 0, 0.9, 0),
            AnchorPoint = Vector2.new(0.5, 1),
            Text = p4.Score,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.GothamBold,
        })
        local v6 = p2:New("UICorner")
        v6 = v6({CornerRadius = UDim.new(0.1, 0)})
        local v7 = p2:New("UIAspectRatioConstraint")
        v7 = v7({AspectRatio = 1})
        local v8 = p2:New("ImageLabel")
        local v9 = {
            Size = UDim2.new(0.9, 0, 0.9, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = p4.Headshot,
            BackgroundColor3 = Color3.new(0.078431, 0.078431, 0.078431),
        }
        local Children_2 = p2.Children
        local v10 = {}
        local v11 = p2:New("UICorner")
        v10[1] = v11({CornerRadius = UDim.new(0.1, 0)})
        v9[Children_2] = v10
        v3[1] = v4
        v3[2] = v5
        v3[3] = v6
        v3[4] = v7
        v3[5] = v8(v9)
        v2[Children] = v3
        return p3, v1(v2)
    end)
    local u15 = scope:Value(UDim2.new(0.5, 0, -1, 0))
    task.delay(0.25, function() -- Line: 69 -- upvalues: u15 (val)
        u15:set(UDim2.new(0.5, 0, 0, 0))
    end)
    local v8 = scope:New("Frame")
    v4 = {Size = UDim2.new(0.45, 0, 0.15, 0), Position = scope:Tween(u15, TweenInfo.new(0.25)), AnchorPoint = Vector2.new(0.5, 0), BackgroundTransparency = 1}
    Children = scope.Children
    local v9 = {}
    v5 = scope:New("TextLabel")
    v5 = v5({
        BackgroundTransparency = 0,
        TextScaled = true,
        Size = UDim2.new(0.125, 0, 0.3, 0),
        Position = UDim2.new(0.5, 0, -0.05, 0),
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = Color3.new(0.113725, 0.113725, 0.113725),
        Text = scope:Computed(function(a1) -- Line: 86 -- upvalues: p1 (val)
            local v1 = a1(p1.TimeLeft)
            local v2 = math.floor(v1 / 60)
            return string.format("%02d:%02d", v2, v1 % 60)
        end),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBlack,
    })
    v6 = scope:New("Frame")
    v1 = {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1}
    Children_2 = scope.Children
    v2 = {}
    v3 = scope:New("UIListLayout")
    local v10 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.05, 0),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }
    v2[1] = v7
    v2[2] = v3(v10)
    v1[Children_2] = v2
    v9[1] = v5
    v9[2] = v6(v1)
    v4[Children] = v9
    return v8(v4)
end