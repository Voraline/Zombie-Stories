return function(p1, p2) -- Line: 1
    local widget = p1.widget
    local v1 = p1:getInstance("Contents")
    local Frame = Instance.new("Frame")
    Frame.Name = "Indicator"
    Frame.LayoutOrder = 9999999
    Frame.ZIndex = 6
    Frame.Size = UDim2.new(0, 42, 0, 42)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(1, 0, 0.5, 0)
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Parent = v1
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "IndicatorButton"
    Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame_2.BorderSizePixel = 0
    Frame_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame_2.Parent = Frame
    local GuiService = game:GetService("GuiService")
    local GamepadService = game:GetService("GamepadService")
    local u69 = p1:getInstance("ClickRegion")
    local function selectionChanged() -- Line: 28 -- upvalues: GuiService (val), u69 (val), Frame_2 (val)
        if GuiService.SelectedObject == u69 then
            Frame_2.BackgroundTransparency = 1
            Frame_2.Position = UDim2.new(0.5, -2, 0.5, 0)
            Frame_2.Size = UDim2.fromScale(1.2, 1.2)
            return
        end
        Frame_2.BackgroundTransparency = 0.75
        Frame_2.Position = UDim2.new(0.5, 2, 0.5, 0)
        Frame_2.Size = UDim2.fromScale(1, 1)
    end
    local janitor = p1.janitor
    local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("SelectedObject")
    janitor:add(PropertyChangedSignal:Connect(selectionChanged))
    selectionChanged()
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
    ImageLabel.Parent = Frame_2
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame_2
    local UserInputService = game:GetService("UserInputService")
    local function setIndicatorVisible(a1) -- Line: 58 -- upvalues: Frame (val), GamepadService (val), p1 (val)
        local Visible
        if a1 ~= nil then
            Visible = a1
        else
            Visible = Frame.Visible
        end
        if GamepadService.GamepadCursorEnabled then
            Visible = false
        end
        if Visible then
            p1:modifyTheme({"PaddingRight", "Size", UDim2.new(0, 0, 1, 0)}, "IndicatorPadding")
        elseif Frame.Visible then
            p1:removeModification("IndicatorPadding")
        end
        p1:modifyTheme({"Indicator", "Visible", Visible})
        p1.updateSize:Fire()
    end
    local janitor_2 = p1.janitor
    local PropertyChangedSignal_2 = GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled")
    janitor_2:add(PropertyChangedSignal_2:Connect(setIndicatorVisible))
    p1.indicatorSet:Connect(function(p1) -- Line: 74 -- upvalues: ImageLabel (val), UserInputService (val), setIndicatorVisible (val)
        local v1 = false
        if p1 then
            ImageLabel.Image = UserInputService:GetImageForKeyCode(p1)
            v1 = true
        end
        setIndicatorVisible(v1)
    end)
    local PropertyChangedSignal_3 = widget:GetPropertyChangedSignal("AbsoluteSize")
    PropertyChangedSignal_3:Connect(function() -- Line: 83 -- upvalues: widget (val), Frame (val)
        local v1 = widget.AbsoluteSize.Y * 0.96
        Frame.Size = UDim2.new(0, v1, 0, v1)
    end)
    local v2 = widget.AbsoluteSize.Y * 0.96
    Frame.Size = UDim2.new(0, v2, 0, v2)
    return Frame
end