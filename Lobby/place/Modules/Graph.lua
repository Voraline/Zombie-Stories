local TextService = game:GetService("TextService")
local v1 = {}
local u6 = {Name = "Dark"}
u6.Background = Color3.fromRGB(35, 35, 40)
u6.LightBackground = Color3.fromRGB(45, 45, 50)
u6.Text = Color3.fromRGB(220, 220, 230)
local u22 = {}
u22.DMG = Color3.new(1, 0, 0)
u22["HS DMG"] = Color3.new(1, 0.682353, 0)

local function getKeyColor(p1) -- Line: 38 -- upvalues: u22 (val)
    if u22[p1] then
        return u22[p1]
    end
    local v1 = 0
    local v2 = #p1
    for i = 1, v2 do
        v1 = v1 + p1:byte(i)
    end
    local v3 = Random.new(v1):NextInteger(0, 50) / 50
    return Color3.fromHSV(v3, 0.63, 0.84)
end

function v1.new(p1) -- Line: 55 -- upvalues: u6 (ref), getKeyColor (val), TextService (val)
    if not p1 then
        error("Must give graph a frame")
    end
    local u4 = {Resolution = 75}
    u4.Frame = p1
    local u6_2 = false
    local ZIndex = u4.Frame.ZIndex
    local Frame = Instance.new("Frame")
    Frame.Name = "Background"
    Frame.BackgroundColor3 = u6.Background
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.ZIndex = ZIndex + 1
    Frame.Parent = u4.Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "MarkerBackground"
    Frame_2.Size = UDim2.new(0.1, 0, 1, 0)
    Frame_2.BackgroundColor3 = u6.LightBackground
    Frame_2.BorderSizePixel = 0
    Frame_2.ZIndex = ZIndex + 2
    Frame_2.Parent = u4.Frame
    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "Markers"
    Frame_3.Size = UDim2.new(0.1, 0, 0.85, 0)
    Frame_3.Position = UDim2.new(0, 0, 0.15, 0)
    Frame_3.BackgroundTransparency = 1
    Frame_3.BorderSizePixel = 0
    Frame_3.ZIndex = ZIndex + 2
    Frame_3.Parent = u4.Frame
    local Frame_4 = Instance.new("Frame")
    Frame_4.Name = "GraphingFrame"
    Frame_4.Size = UDim2.new(0.9, 0, 0.85, 0)
    Frame_4.Position = UDim2.new(0.1, 0, 0.15, 0)
    Frame_4.BackgroundTransparency = 1
    Frame_4.ZIndex = ZIndex + 2
    Frame_4.Parent = u4.Frame
    local Frame_5 = Instance.new("Frame")
    Frame_5.Name = "KeyNames"
    Frame_5.Size = UDim2.new(1, 0, 0.1, 0)
    Frame_5.Position = UDim2.new(0, 0, 0, 0)
    Frame_5.BackgroundColor3 = u6.LightBackground
    Frame_5.BorderSizePixel = 0
    Frame_5.ZIndex = ZIndex + 2
    Frame_5.Parent = u4.Frame
    ;(u4.Frame:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 107 -- upvalues: u4 (val)
        local v1 = u4
        local AbsoluteSize = v1.Frame.AbsoluteSize
        wait(0.04)
        if AbsoluteSize == u4.Frame.AbsoluteSize then
            u4.Render()
        end
    end)

    function u4.Theme(p1) -- Line: 115 -- upvalues: u6 (upval), Frame (val), Frame_2 (val), Frame_5 (val), u4 (val)
        wait()
        local v1 = {Name = p1.Name or "Dark"}
        local Background = p1.Background
        if not Background then
            Background = Color3.fromRGB(46, 46, 46)
        end
        v1.Background = Background
        local LightBackground = p1.LightBackground
        if not LightBackground then
            LightBackground = Color3.fromRGB(70, 70, 70)
        end
        v1.LightBackground = LightBackground
        local Text = p1.Text
        if not Text then
            Text = Color3.fromRGB(220, 220, 230)
        end
        v1.Text = Text
        u6 = v1
        Frame.BackgroundColor3 = u6.Background
        Frame_2.BackgroundColor3 = u6.LightBackground
        Frame_5.BackgroundColor3 = u6.LightBackground
        u4.Render()
    end

    function u4.Render() -- Line: 135
        -- upvalues: u4 (val), u6_2 (ref), Frame_3 (val), Frame_4 (val), Frame_5 (val), ZIndex (ref), Frame (val)
        -- upvalues: Frame_2 (val), u6 (upval), getKeyColor (upval), TextService (upval)
        if u4.Frame and u4.Data and u4.Resolution then
            local AbsoluteSize, AbsoluteSize_2, Font, Frame_6, Magnitude, SourceSansSemibold, Text, TextLabel_2, TextLabel_3, TextSize, TextSize_4, TextSize_5, new_3, new_4, new_6, new_8, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23
            while u6_2 do
                wait(0.1)
            end
            u6_2 = true
            Frame_3:ClearAllChildren()
            Frame_4:ClearAllChildren()
            Frame_5:ClearAllChildren()
            ZIndex = u4.Frame.ZIndex
            Frame.ZIndex = ZIndex + 1
            Frame_2.ZIndex = ZIndex + 2
            Frame_3.ZIndex = ZIndex + 2
            Frame_4.ZIndex = ZIndex + 2
            Frame_5.ZIndex = ZIndex + 2
            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
            UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
            UIListLayout.Padding = UDim.new(0.01, 0)
            UIListLayout.Parent = Frame_5
            local v24 = (-1 / 0)
            local v25 = (1 / 0)
            for k, v in pairs(u4.Data) do
                v23 = #v
                v1 = v23
                v5 = u4
                v4 = v23 / v5.Resolution
                v2 = math.ceil(v4)
                for i = 1, v1, v2 do
                    v3 = v[i]
                    if v3 then
                        v25 = math.min(v25, v3)
                        v24 = math.max(v24, v3)
                    end
                end
            end
            if u4.BaselineZero then
                v25 = 0
                v24 = v24 * 1.75
            end
            local v26 = v24 - v25
            for j = 0, 1, 0.2 do
                TextLabel_2 = Instance.new("TextLabel")
                TextLabel_2.Name = j
                TextLabel_2.Size = UDim2.new(1, 0, 0.08, 0)
                TextLabel_2.AnchorPoint = Vector2.new(0, 0.5)
                TextLabel_2.Position = UDim2.new(0, 0, 0.9 - j * 0.9, 0)
                TextLabel_2.Text = string.format("%.2f  ", v25 + v26 * j)
                TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
                TextLabel_2.TextColor3 = u6.Text
                TextLabel_2.Font = Enum.Font.SourceSans
                TextLabel_2.BackgroundTransparency = 1
                TextLabel_2.TextSize = u4.Frame.AbsoluteSize.X * 0.03
                TextLabel_2.ZIndex = ZIndex + 3
                TextLabel_2.Parent = Frame_3
            end
            local v27 = {}
            for k2, k3 in pairs(u4.Data) do
                v27[k2] = (getKeyColor(k2))
                v1 = u4.Frame.AbsoluteSize.Y * 0.08
                v2 = TextService
                SourceSansSemibold = Enum.Font.SourceSansSemibold
                v6 = Frame_5
                AbsoluteSize = v6.AbsoluteSize
                TextSize = v2:GetTextSize(k2, v1, SourceSansSemibold, AbsoluteSize)
                TextLabel_3 = Instance.new("TextLabel")
                TextLabel_3.Text = k2
                TextLabel_3.TextColor3 = v27[k2]
                TextLabel_3.Font = Enum.Font.SourceSansSemibold
                TextLabel_3.BackgroundTransparency = 1
                TextLabel_3.TextSize = v1
                TextLabel_3.Size = UDim2.new(0, TextSize.X + v1, 1, 0)
                TextLabel_3.ZIndex = ZIndex + 3
                TextLabel_3.Parent = Frame_5
                v3 = #k3
                v4 = nil
                v7 = u4
                v6 = v3 / v7.Resolution
                v5 = math.ceil(v6)
                v6 = v3 + v5
                v7 = v5
                for n = 1, v6, v7 do
                    v8 = n
                    if v3 < n then
                        v8 = v3
                    end
                    v9 = k3[v8]
                    if v9 then
                        local ImageLabel = Instance.new("ImageLabel")
                        ImageLabel.Name = k2 .. v8
                        new_3 = UDim2.new
                        v10 = v8 / v3 * 0.9 + 0.05
                        v12 = 0.9 - (v9 - v25) / v26 * 0.9
                        ImageLabel.Position = new_3(v10, 0, v12, 0)
                        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                        ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeXX
                        new_4 = UDim2.new
                        v11 = 0.5 / u4.Resolution
                        v10 = math.clamp(v11, 0.003, 0.016)
                        v13 = 0.5 / u4.Resolution
                        v12 = math.clamp(v13, 0.003, 0.016)
                        ImageLabel.Size = new_4(v10, 0, v12, 0)
                        ImageLabel.ImageColor3 = v27[k2]
                        ImageLabel.BorderSizePixel = 0
                        ImageLabel.BackgroundTransparency = 1
                        ImageLabel.Image = "rbxassetid://200182847"
                        ImageLabel.ZIndex = ZIndex + 5
                        local TextLabel = Instance.new("TextLabel")
                        TextLabel.Visible = false
                        v12 = string.format("%.1f", v9)
                        v13 = v8 - 1
                        TextLabel.Text = ("Damage: %*\nDistance: %*"):format(v12, v13)
                        TextLabel.BackgroundColor3 = u6.LightBackground
                        TextLabel.TextColor3 = u6.Text
                        TextLabel.Font = Enum.Font.Code
                        TextLabel.TextSize = u4.Frame.AbsoluteSize.X * 0.025
                        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                        TextLabel.TextYAlignment = Enum.TextYAlignment.Center
                        TextLabel.BorderSizePixel = 0
                        TextLabel.AnchorPoint = Vector2.new(0, 0.5)
                        v13 = TextLabel.TextSize * 0.4
                        v12 = math.floor(v13)
                        local u287 = math.max(12, v12)
                        v14 = TextLabel.TextSize * 0.3
                        v13 = math.floor(v14)
                        v11 = math.max(6, v13)
                        v12 = TextService
                        Text = TextLabel.Text
                        TextSize_4 = TextLabel.TextSize
                        Font = TextLabel.Font
                        v17 = Vector2.new(10000, 10000)
                        TextSize_5 = v12:GetTextSize(Text, TextSize_4, Font, v17)
                        new_6 = UDim2.new
                        v15 = TextSize_5.X + u287
                        TextLabel.Size = new_6(0, v15, 0, TextSize_5.Y + v11)
                        TextLabel.Position = UDim2.new(1, u287, 0.5, 0)
                        TextLabel.Parent = ImageLabel
                        TextLabel.ZIndex = ZIndex + 10

                        local function updateLabelPosition() -- Line: 288
                            -- upvalues: TextLabel (val), u4 (upval), ImageLabel (val), u287 (val)
                            local v1, v2, v3, v4
                            if not TextLabel.Parent then
                                return
                            end
                            local AbsolutePosition = u4.Frame.AbsolutePosition
                            local AbsoluteSize = u4.Frame.AbsoluteSize
                            local AbsolutePosition_2 = ImageLabel.AbsolutePosition
                            local AbsoluteSize_2 = ImageLabel.AbsoluteSize
                            local v5 = Vector2.new(
                                AbsolutePosition_2.X + AbsoluteSize_2.X * 0.5,
                                AbsolutePosition_2.Y + AbsoluteSize_2.Y * 0.5
                            )
                            local AbsoluteSize_3 = TextLabel.AbsoluteSize
                            local v6 = AbsolutePosition.X + AbsoluteSize.X - v5.X
                            local v7 = AbsoluteSize_3.X + u287 <= v6
                            if not v7 then
                                v3 = 1
                            else
                                v3 = 0
                            end
                            if not v7 then
                                v4 = 0
                            else
                                v4 = 1
                            end
                            if not v7 then
                                v1 = -u287
                            else
                                v1 = u287
                                if not v1 then
                                    v1 = -u287
                                end
                            end
                            local Y = AbsolutePosition.Y
                            local v8 = AbsolutePosition.Y + AbsoluteSize.Y
                            local v9 = Y - (v5.Y - AbsoluteSize_3.Y * 0.5)
                            local v10 = v8 - (v5.Y + AbsoluteSize_3.Y * 0.5)
                            if not (v10 < v9) then
                                v2 = math.clamp(0, v9, v10)
                            else
                                v2 = (v9 + v10) * 0.5
                            end
                            TextLabel.AnchorPoint = Vector2.new(v3, 0.5)
                            TextLabel.Position = UDim2.new(v4, v1, 0.5, v2)
                        end

                        ImageLabel.MouseEnter:Connect(function() -- Line: 329 -- upvalues: TextLabel (val), updateLabelPosition (val)
                            TextLabel.Visible = true
                            updateLabelPosition()
                        end)
                        ImageLabel.MouseLeave:Connect(function() -- Line: 333 -- upvalues: TextLabel (val)
                            TextLabel.Visible = false
                        end)
                        ;(TextLabel:GetPropertyChangedSignal("AbsoluteSize")):Connect(updateLabelPosition)
                        ;(ImageLabel:GetPropertyChangedSignal("AbsolutePosition")):Connect(function() -- Line: 337 -- upvalues: TextLabel (val), updateLabelPosition (val)
                            if TextLabel.Visible then
                                updateLabelPosition()
                            end
                        end)
                        if v4 then
                            Frame_6 = Instance.new("Frame")
                            Frame_6.Name = k2 .. v8 .. "-" .. v8 - 1
                            Frame_6.BackgroundColor3 = v27[k2]
                            Frame_6.BorderSizePixel = 0
                            Frame_6.SizeConstraint = Enum.SizeConstraint.RelativeXX
                            Frame_6.AnchorPoint = Vector2.new(0.5, 0.5)
                            Frame_6.ZIndex = ZIndex + 4
                            AbsoluteSize_2 = Frame_4.AbsoluteSize
                            v16 = ImageLabel.Position.X.Scale * AbsoluteSize_2.X
                            v17 = ImageLabel.Position.Y.Scale * AbsoluteSize_2.Y
                            v18 = v4.Position.X.Scale * AbsoluteSize_2.X
                            v19 = v4.Position.Y.Scale * AbsoluteSize_2.Y
                            Magnitude = ((Vector2.new(v16, v17)) - (Vector2.new(v18, v19))).Magnitude
                            new_8 = UDim2.new
                            v22 = 0.2 / u4.Resolution
                            Frame_6.Size = new_8(0, Magnitude, math.clamp(v22, 0.002, 0.0035), 0)
                            Frame_6.Position = UDim2.new(0, (v16 + v18) / 2, 0, (v17 + v19) / 2)
                            v20 = v19 - v17
                            v21 = v18 - v16
                            Frame_6.Rotation = math.atan2(v20, v21) * 57.29577951308232
                            Frame_6.Parent = Frame_4
                        end
                        v4 = ImageLabel
                        ImageLabel.Parent = Frame_4
                    end
                end
            end
            u6_2 = false
            return
        end
    end

    local v1 = {
        __index = function(p1, p2) -- Line: 378 -- upvalues: u4 (val)
            return u4[p2]
        end,
        __newindex = function(p1, p2, p3) -- Line: 381 -- upvalues: u4 (val)
            if p2 == "Data" and type(p3) == "table" then
                u4.Data = p3
                u4.Render()
                return
            end
            if p2 == "Resolution" and type(p3) == "number" then
                u4.Resolution = math.clamp(p3, 3, 500)
                u4.Render()
                return
            end
            if p2 == "BaselineZero" and type(p3) == "boolean" then
                u4.BaselineZero = p3
                u4.Render()
            end
        end,
    }
    return (setmetatable({}, v1))
end

return v1