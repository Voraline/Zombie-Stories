return function(p1, p2) -- Line: 6
    local Frame = Instance.new("Frame")
    local UID = p1.UID
    Frame:SetAttribute("WidgetUID", UID)
    Frame.Name = "Widget"
    Frame.BackgroundTransparency = 1
    Frame.Visible = true
    Frame.ZIndex = 20
    Frame.Active = false
    Frame.ClipsDescendants = true
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "IconButton"
    Frame_2.Visible = true
    Frame_2.ZIndex = 2
    Frame_2.BorderSizePixel = 0
    Frame_2.Parent = Frame
    Frame_2.ClipsDescendants = true
    Frame_2.Active = false
    p1.deselected:Connect(function() -- Line: 25 -- upvalues: Frame_2 (val)
        Frame_2.ClipsDescendants = true
    end)
    p1.selected:Connect(function() -- Line: 28 -- upvalues: p1 (val), Frame_2 (val)
        task.defer(function() -- Line: 29 -- upvalues: p1 (upval), Frame_2 (upval)
            local v1 = p1
            v1.resizingComplete:Once(function() -- Line: 30 -- upvalues: p1 (upval), Frame_2 (upval)
                if p1.isSelected then
                    Frame_2.ClipsDescendants = false
                end
            end)
        end)
    end)
    local UICorner = Instance.new("UICorner")
    UICorner:SetAttribute("Collective", "IconCorners")
    UICorner.Parent = Frame_2
    local u47 = require("./Menu")(p1)
    local MenuUIListLayout = u47.MenuUIListLayout
    local MenuGap = u47.MenuGap
    u47.Parent = Frame_2
    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "IconSpot"
    Frame_3.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
    Frame_3.BackgroundTransparency = 0.9
    Frame_3.Visible = true
    Frame_3.AnchorPoint = Vector2.new(0, 0.5)
    Frame_3.ZIndex = 5
    Frame_3.Parent = u47
    UICorner:Clone().Parent = Frame_3
    local v1 = Frame_3:Clone()
    v1.Name = "IconOverlay"
    v1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v1.ZIndex = Frame_3.ZIndex + 1
    v1.Size = UDim2.new(1, 0, 1, 0)
    v1.Position = UDim2.new(0, 0, 0, 0)
    v1.AnchorPoint = Vector2.new(0, 0)
    v1.Visible = false
    v1.Parent = Frame_3
    local TextButton = Instance.new("TextButton")
    local UID_2 = p1.UID
    TextButton:SetAttribute("CorrespondingIconUID", UID_2)
    TextButton.Name = "ClickRegion"
    TextButton.BackgroundTransparency = 1
    TextButton.Visible = true
    TextButton.Text = ""
    TextButton.ZIndex = 20
    TextButton.Selectable = true
    TextButton.SelectionGroup = true
    TextButton.Parent = Frame_3
    require("../Features/Gamepad").registerButton(TextButton)
    UICorner:Clone().Parent = TextButton
    local Frame_4 = Instance.new("Frame")
    Frame_4.Name = "Contents"
    Frame_4.BackgroundTransparency = 1
    Frame_4.Size = UDim2.fromScale(1, 1)
    Frame_4.Parent = Frame_3
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "ContentsList"
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Padding = UDim.new(0, 3)
    UIListLayout.Parent = Frame_4
    local Frame_5 = Instance.new("Frame")
    Frame_5.Name = "PaddingLeft"
    Frame_5.LayoutOrder = 1
    Frame_5.ZIndex = 5
    Frame_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_5.BackgroundTransparency = 1
    Frame_5.BorderSizePixel = 0
    Frame_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_5.Parent = Frame_4
    local Frame_6 = Instance.new("Frame")
    Frame_6.Name = "PaddingCenter"
    Frame_6.LayoutOrder = 3
    Frame_6.ZIndex = 5
    Frame_6.Size = UDim2.new(0, 0, 1, 0)
    Frame_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_6.BackgroundTransparency = 1
    Frame_6.BorderSizePixel = 0
    Frame_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_6.Parent = Frame_4
    local Frame_7 = Instance.new("Frame")
    Frame_7.Name = "PaddingRight"
    Frame_7.LayoutOrder = 5
    Frame_7.ZIndex = 5
    Frame_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_7.BackgroundTransparency = 1
    Frame_7.BorderSizePixel = 0
    Frame_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_7.Parent = Frame_4
    local Frame_8 = Instance.new("Frame")
    Frame_8.Name = "IconLabelContainer"
    Frame_8.LayoutOrder = 4
    Frame_8.ZIndex = 3
    Frame_8.AnchorPoint = Vector2.new(0, 0.5)
    Frame_8.Size = UDim2.new(0, 0, 0.5, 0)
    Frame_8.BackgroundTransparency = 1
    Frame_8.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame_8.Parent = Frame_4
    local TextLabel = Instance.new("TextLabel")
    local u232 = workspace.CurrentCamera.ViewportSize.X + 200
    TextLabel.Name = "IconLabel"
    TextLabel.LayoutOrder = 4
    TextLabel.ZIndex = 15
    TextLabel.AnchorPoint = Vector2.new(0, 0)
    TextLabel.Size = UDim2.new(0, u232, 1, 0)
    TextLabel.ClipsDescendants = false
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromScale(0, 0)
    TextLabel.RichText = true
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ""
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.TextScaled = false
    TextLabel.Active = false
    TextLabel.AutoLocalize = true
    TextLabel.Parent = Frame_8
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "IconImage"
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel.Size = UDim2.new(0, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0, 11, 0.5, 0)
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    ImageLabel.Active = false
    ImageLabel.Parent = Frame_4
    local v2 = UICorner:Clone()
    v2:SetAttribute("Collective", nil)
    v2.CornerRadius = UDim.new(0, 0)
    v2.Name = "IconImageCorner"
    v2.Parent = ImageLabel
    local TweenService = game:GetService("TweenService")
    local u308 = 0
    local u316 = require("../Utility").createStagger(0.01, function(p1_2) -- Line: 184
        -- upvalues: p1 (val), TextLabel (val), ImageLabel (val), Frame_8 (val), Frame_5 (val), Frame_6 (val)
        -- upvalues: Frame_7 (val), Frame_2 (val), UIListLayout (val), Frame_4 (val), Frame (val), u232 (val), u47 (val)
        -- upvalues: Frame_3 (val), MenuUIListLayout (val), MenuGap (val), TweenService (val), TextButton (val)
        -- upvalues: u308 (ref), p2 (val)
        task.defer(function() -- Line: 191
            -- upvalues: p1 (upval), TextLabel (upval), ImageLabel (upval), Frame_8 (upval), Frame_5 (upval)
            -- upvalues: Frame_6 (upval), Frame_7 (upval), Frame_2 (upval), UIListLayout (upval), Frame_4 (upval)
            -- upvalues: Frame (upval), u232 (upval), u47 (upval), Frame_3 (upval), MenuUIListLayout (upval)
            -- upvalues: MenuGap (upval), TweenService (upval), TextButton (upval), u308 (upval), p2 (upval)
            local Attribute_11, Left
            local indicator = p1.indicator
            local Visible = indicator
            if Visible then
                Visible = indicator.Visible
            end
            local v1 = Visible
            if not v1 then
                v1 = TextLabel.Text ~= ""
            end
            local v2 = false
            if ImageLabel.Image ~= "" then
                v2 = ImageLabel.Image ~= nil
            end
            local Center = Enum.HorizontalAlignment.Center
            local v3 = UDim2.fromScale(1, 1)
            if not v2 then
                if v2 then
                    if v2 and v1 then
                        Frame_8.Visible = true
                        ImageLabel.Visible = true
                        Frame_5.Visible = true
                        Frame_6.Visible = not Visible
                        Frame_7.Visible = not Visible
                        Left = Enum.HorizontalAlignment.Left
                    end
                elseif v1 then
                    Frame_8.Visible = true
                    ImageLabel.Visible = false
                    Frame_5.Visible = true
                    Frame_6.Visible = false
                    Frame_7.Visible = true
                elseif v2 and v1 then
                    Frame_8.Visible = true
                    ImageLabel.Visible = true
                    Frame_5.Visible = true
                    Frame_6.Visible = not Visible
                    Frame_7.Visible = not Visible
                    Left = Enum.HorizontalAlignment.Left
                end
            elseif not v1 then
                Frame_8.Visible = false
                ImageLabel.Visible = true
                Frame_5.Visible = false
                Frame_6.Visible = false
                Frame_7.Visible = false
            elseif v2 then
                if v2 and v1 then
                    Frame_8.Visible = true
                    ImageLabel.Visible = true
                    Frame_5.Visible = true
                    Frame_6.Visible = not Visible
                    Frame_7.Visible = not Visible
                    Left = Enum.HorizontalAlignment.Left
                end
            elseif v1 then
                Frame_8.Visible = true
                ImageLabel.Visible = false
                Frame_5.Visible = true
                Frame_6.Visible = false
                Frame_7.Visible = true
            elseif v2 and v1 then
                Frame_8.Visible = true
                ImageLabel.Visible = true
                Frame_5.Visible = true
                Frame_6.Visible = not Visible
                Frame_7.Visible = not Visible
                Left = Enum.HorizontalAlignment.Left
            end
            Frame_2.Size = v3

            local function getItemWidth(p1) -- Line: 221
                local Attribute = p1:GetAttribute("TargetWidth")
                if not Attribute then
                    Attribute = p1.AbsoluteSize.X
                end
                return Attribute
            end

            local Offset = UIListLayout.Padding.Offset
            local v4 = Offset
            local v5 = TextLabel
            local X = v5.TextBounds.X
            Frame_8.Size = UDim2.new(0, X, TextLabel.Size.Y.Scale, 0)
            for k, v in pairs(Frame_4:GetChildren()) do
                if v:IsA("GuiObject") and v.Visible == true then
                    Attribute_11 = v:GetAttribute("TargetWidth")
                    if not Attribute_11 then
                        Attribute_11 = v.AbsoluteSize.X
                    end
                    v4 = v4 + (Attribute_11 + Offset)
                end
            end
            local Attribute = Frame:GetAttribute("MinimumWidth")
            local Attribute_2 = Frame:GetAttribute("MinimumHeight")
            local Attribute_3 = Frame:GetAttribute("BorderSize")
            local v6 = u232
            local v7 = math.clamp(v4, Attribute, v6)
            local v8 = 0
            v6 = 0 < #p1.menuIcons
            local isSelected = v6
            if isSelected then
                isSelected = p1.isSelected
            end
            if isSelected then
                local Attribute_5
                for k2, i in pairs(u47:GetChildren()) do
                    if i ~= Frame_3 and i:IsA("GuiObject") and i.Visible then
                        Attribute_5 = i:GetAttribute("TargetWidth")
                        if not Attribute_5 then
                            Attribute_5 = i.AbsoluteSize.X
                        end
                        v8 = v8 + (Attribute_5 + MenuUIListLayout.Padding.Offset)
                    end
                end
                if not Frame_3.Visible then
                    local v9 = Frame_3
                    local Attribute_4 = v9:GetAttribute("TargetWidth")
                    if not Attribute_4 then
                        Attribute_4 = v9.AbsoluteSize.X
                    end
                    v7 = v7 - (Attribute_4 + MenuUIListLayout.Padding.Offset * 2 + Attribute_3)
                end
                v8 = v8 - Attribute_3 * 0.5
                v7 = v7 + (v8 - Attribute_3 * 0.75)
            end
            local v10 = MenuGap
            local Visible_2 = isSelected
            if Visible_2 then
                Visible_2 = Frame_3.Visible
            end
            v10.Visible = Visible_2
            local Attribute_6 = Frame:GetAttribute("DesiredWidth")
            if Attribute_6 and v7 < Attribute_6 then
                v7 = Attribute_6
            end
            p1.updateMenu:Fire()
            local v11 = v7 - v8
            v11 = (math.max(v11, Attribute)) - Attribute_3 * 2
            local Attribute_7 = u47:GetAttribute("MenuWidth")
            local v12 = Attribute_7
            if v12 then
                v12 = Attribute_7 + v11 + MenuUIListLayout.Padding.Offset + 10
            end
            if v12 then
                local Attribute_8 = u47:GetAttribute("MaxWidth")
                if Attribute_8 then
                    v12 = math.max(Attribute_8, Attribute)
                end
                u47:SetAttribute("MenuCanvasWidth", v7)
                if v12 < v7 then
                    v7 = v12
                end
            end
            local Quint = Enum.EasingStyle.Quint
            local Out = Enum.EasingDirection.Out
            local v13 = Frame_3
            local Attribute_9 = v13:GetAttribute("TargetWidth")
            if not Attribute_9 then
                Attribute_9 = v13.AbsoluteSize.X
            end
            v13 = Frame_3
            local X_2 = v13.AbsoluteSize.X
            local v14 = math.max(v11, Attribute_9, X_2)
            local v15 = Frame
            local Attribute_10 = v15:GetAttribute("TargetWidth")
            if not Attribute_10 then
                Attribute_10 = v15.AbsoluteSize.X
            end
            v15 = Frame
            local X_3 = v15.AbsoluteSize.X
            local v16 = math.max(v7, Attribute_10, X_3)
            local v17 = TweenInfo.new(v14 / 750, Quint, Out)
            v13 = TweenInfo.new(v16 / 750, Quint, Out)
            v15 = TweenService
            local v18 = Frame_3
            local v19 = {
                Position = UDim2.new(0, Attribute_3, 0.5, 0),
                Size = UDim2.new(0, v11, 1, -Attribute_3 * 2),
            }
            v15:Create(v18, v17, v19):Play()
            v15 = TweenService
            v18 = TextButton
            v19 = {Size = UDim2.new(0, v11, 1, 0)}
            v15:Create(v18, v17, v19):Play()
            v15 = UDim2.fromOffset(v7, Attribute_2)
            local v20 = Frame.Size.Y.Offset ~= Attribute_2
            if v20 then
                Frame.Size = v15
            end
            v18 = Frame
            local Offset_2 = v15.X.Offset
            v18:SetAttribute("TargetWidth", Offset_2)
            v18 = TweenService
            v19 = Frame
            local v21 = {Size = v15}
            v18:Create(v19, v13, v21):Play()
            u308 = u308 + 1
            local v22 = v13.Time * 100
            for j = 1, v22 do
                task.delay(j / 100, function() -- Line: 303 -- upvalues: p2 (upval), p1 (upval)
                    local v1 = p2
                    local iconChanged = v1.iconChanged
                    local v2 = p1
                    iconChanged:Fire(v2)
                end)
            end
            task.delay(v13.Time - 0.2, function() -- Line: 307 -- upvalues: u308 (upval), p1 (upval)
                u308 = u308 - 1
                task.defer(function() -- Line: 309 -- upvalues: u308 (upval), p1 (upval)
                    if u308 == 0 then
                        p1.resizingComplete:Fire()
                    end
                end)
            end)
            p1:updateParent()
        end)
    end)
    local u317 = true
    p1:setBehaviour("IconLabel", "Text", u316)
    p1:setBehaviour("IconLabel", "FontFace", function(p1) -- Line: 322 -- upvalues: TextLabel (val), u316 (val), u317 (ref)
        if TextLabel.FontFace == p1 then
            return
        end
        task.spawn(function() -- Line: 327 -- upvalues: u316 (upval), u317 (upval)
            u316()
            if u317 then
                u317 = false
                for i = 1, 10 do
                    task.wait(1)
                    u316()
                end
            end
        end)
    end)

    local function updateBorderSize() -- Line: 350
        -- upvalues: Frame (val), p1 (val), Frame_3 (val), u47 (val), MenuGap (val), MenuUIListLayout (val), u316 (val)
        task.defer(function() -- Line: 351
            -- upvalues: Frame (upval), p1 (upval), Frame_3 (upval), u47 (upval), MenuGap (upval)
            -- upvalues: MenuUIListLayout (upval), u316 (upval)
            local v1
            local Attribute = Frame:GetAttribute("BorderSize")
            local v2 = p1
            local alignment = v2.alignment
            if Frame_3.Visible == false then
                v1 = 0
            elseif alignment ~= "Right" then
                v1 = Attribute
            else
                v1 = -Attribute
                if not v1 then
                    v1 = Attribute
                end
            end
            u47.Position = UDim2.new(0, v1, 0, 0)
            MenuGap.Size = UDim2.fromOffset(Attribute, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            u316()
        end)
    end

    p1:setBehaviour("Widget", "BorderSize", updateBorderSize)
    p1:setBehaviour("IconSpot", "Visible", updateBorderSize)
    p1.startMenuUpdate:Connect(u316)
    p1.updateSize:Connect(u316)
    p1:setBehaviour("ContentsList", "HorizontalAlignment", u316)
    p1:setBehaviour("Widget", "Visible", u316)
    p1:setBehaviour("Widget", "DesiredWidth", u316)
    p1:setBehaviour("Widget", "MinimumWidth", u316)
    p1:setBehaviour("Widget", "MinimumHeight", u316)
    p1:setBehaviour("Indicator", "Visible", u316)
    p1:setBehaviour("IconImageRatio", "AspectRatio", u316)
    p1:setBehaviour("IconImage", "Image", function(p1) -- Line: 372 -- upvalues: ImageLabel (val), u316 (val)
        local v1
        if not tonumber(p1) then
            v1 = p1 or ""
        else
            v1 = "http://www.roblox.com/asset/?id=" .. p1
            if not v1 then
                v1 = p1 or ""
            end
        end
        if ImageLabel.Image ~= v1 then
            u316()
        end
        return v1
    end)
    p1.alignmentChanged:Connect(function(p1_2) -- Line: 379
        -- upvalues: MenuUIListLayout (val), Frame (val), p1 (val), Frame_3 (val), u47 (val), MenuGap (val), u316 (val)
        local v1
        if p1_2 ~= "Center" then
            v1 = p1_2
        else
            v1 = "Left"
        end
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[v1]
        task.defer(function() -- Line: 351
            -- upvalues: Frame (upval), p1 (upval), Frame_3 (upval), u47 (upval), MenuGap (upval)
            -- upvalues: MenuUIListLayout (upval), u316 (upval)
            local v1
            local Attribute = Frame:GetAttribute("BorderSize")
            local v2 = p1
            local alignment = v2.alignment
            if Frame_3.Visible == false then
                v1 = 0
            elseif alignment ~= "Right" then
                v1 = Attribute
            else
                v1 = -Attribute
                if not v1 then
                    v1 = Attribute
                end
            end
            u47.Position = UDim2.new(0, v1, 0, 0)
            MenuGap.Size = UDim2.fromOffset(Attribute, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            u316()
        end)
    end)
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Name = "IconImageScale"
    NumberValue.Parent = ImageLabel
    ;(NumberValue:GetPropertyChangedSignal("Value")):Connect(function() -- Line: 390 -- upvalues: ImageLabel (val), NumberValue (val)
        ImageLabel.Size = UDim2.new(NumberValue.Value, 0, NumberValue.Value, 0)
    end)
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.Name = "IconImageRatio"
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = ImageLabel
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Name = "IconGradient"
    UIGradient.Enabled = true
    UIGradient.Parent = Frame_2
    local UIGradient_2 = Instance.new("UIGradient")
    UIGradient_2.Name = "IconSpotGradient"
    UIGradient_2.Enabled = true
    UIGradient_2.Parent = Frame_3
    return Frame
end