return function(p1) -- Line: 7
    local scope = p1.scope
    local PlayerList = p1.PlayerList
    local v1 = scope:ForPairs(PlayerList, function(p1, p2, p3, p4) -- Line: 10
        local v1 = p2:New("Frame")
        local v2 = {
            Size = UDim2.new(0.2, 0, 1, 0),
            BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.180392),
            LayoutOrder = p2:Computed(function(p1) -- Line: 14 -- upvalues: p4 (val)
                return p1(p4.Score) * -1
            end),
            Visible = p4.Visible,
        }
        local Children = p2.Children
        local v3 = {}
        local v4 = p2:New("TextLabel")({
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
        local v5 = p2:New("TextLabel")({
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
        local v6 = p2:New("UICorner")({CornerRadius = UDim.new(0.1, 0)})
        local v7 = p2:New("UIAspectRatioConstraint")({AspectRatio = 1})
        local v8 = p2:New("ImageLabel")
        local v9 = {
            Size = UDim2.new(0.9, 0, 0.9, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Image = p4.Headshot,
            BackgroundColor3 = Color3.new(0.078431, 0.078431, 0.078431),
        }
        local Children_2 = p2.Children
        v9[Children_2] = {p2:New("UICorner")({CornerRadius = UDim.new(0.1, 0)})}
        v3[1] = v4
        v3[2] = v5
        v3[3] = v6
        v3[4] = v7
        v3[5] = v8(v9)
        v2[Children] = v3
        return p3, v1(v2)
    end)
    local v2 = UDim2.new(0.5, 0, -1, 0)
    local u15 = scope:Value(v2)
    task.delay(0.25, function() -- Line: 69 -- upvalues: u15 (val)
        local v1 = u15
        local v2 = UDim2.new(0.5, 0, 0, 0)
        v1:set(v2)
    end)
    local v3 = scope:New("Frame")
    v2 = {Size = UDim2.new(0.45, 0, 0.15, 0)}
    local v4 = TweenInfo.new(0.25)
    v2.Position = scope:Tween(u15, v4)
    v2.AnchorPoint = Vector2.new(0.5, 0)
    v2.BackgroundTransparency = 1
    local Children = scope.Children
    local v5 = {}
    local v6 = scope:New("TextLabel")({
        BackgroundTransparency = 0,
        TextScaled = true,
        Size = UDim2.new(0.125, 0, 0.3, 0),
        Position = UDim2.new(0.5, 0, -0.05, 0),
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = Color3.new(0.113725, 0.113725, 0.113725),
        Text = scope:Computed(function(p1_2) -- Line: 86 -- upvalues: p1 (val)
            local v1 = p1_2(p1.TimeLeft)
            local format = string.format
            local v2 = v1 / 60
            return format("%02d:%02d", math.floor(v2), v1 % 60)
        end),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBlack,
    })
    v4 = scope:New("Frame")
    local v7 = {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1}
    local Children_2 = scope.Children
    local v8 = {}
    local v9 = scope:New("UIListLayout")
    local v10 = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.05, 0),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }
    v8[1] = v1
    v8[2] = v9(v10)
    v7[Children_2] = v8
    v5[1] = v6
    v5[2] = v4(v7)
    v2[Children] = v5
    return v3(v2)
end