return function(p1) -- Line: 1
    local KeyboardEnabled, u269, v1, v2
    local u4 = p1:getInstance("ClickRegion")
    local CanvasGroup = Instance.new("CanvasGroup")
    CanvasGroup.Name = "Caption"
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0)
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.BorderSizePixel = 0
    CanvasGroup.GroupTransparency = 1
    CanvasGroup.Position = UDim2.fromOffset(0, 0)
    CanvasGroup.Visible = true
    CanvasGroup.ZIndex = 30
    CanvasGroup.Parent = u4
    local Frame = Instance.new("Frame")
    Frame.Name = "Box"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundColor3 = Color3.fromRGB(101, 102, 104)
    Frame.Position = UDim2.fromOffset(4, 7)
    Frame.ZIndex = 12
    Frame.Parent = CanvasGroup
    local TextLabel_2 = Instance.new("TextLabel")
    TextLabel_2.Name = "Header"
    TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel_2.Text = "Caption"
    TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel_2.TextSize = 14
    TextLabel_2.TextTruncate = Enum.TextTruncate.None
    TextLabel_2.TextWrapped = false
    TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
    TextLabel_2.BackgroundTransparency = 1
    TextLabel_2.LayoutOrder = 1
    TextLabel_2.Size = UDim2.fromOffset(0, 16)
    TextLabel_2.ZIndex = 18
    TextLabel_2.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "Layout"
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame
    local UICorner = Instance.new("UICorner")
    UICorner.Name = "CaptionCorner"
    UICorner.Parent = Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "Padding"
    UIPadding.PaddingBottom = UDim.new(0, 12)
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.PaddingTop = UDim.new(0, 12)
    UIPadding.Parent = Frame
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Hotkeys"
    Frame_2.AutomaticSize = Enum.AutomaticSize.Y
    Frame_2.BackgroundTransparency = 1
    Frame_2.LayoutOrder = 3
    Frame_2.Size = UDim2.fromScale(1, 0)
    Frame_2.Visible = false
    Frame_2.Parent = Frame
    local UIListLayout_2 = Instance.new("UIListLayout")
    UIListLayout_2.Name = "Layout1"
    UIListLayout_2.Padding = UDim.new(0, 6)
    UIListLayout_2.FillDirection = Enum.FillDirection.Vertical
    UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout_2.HorizontalFlex = Enum.UIFlexAlignment.None
    UIListLayout_2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
    UIListLayout_2.VerticalFlex = Enum.UIFlexAlignment.None
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Parent = Frame_2
    local ImageLabel_3 = Instance.new("ImageLabel")
    ImageLabel_3.Name = "Key1"
    ImageLabel_3.Image = "rbxasset://textures/ui/Controls/key_single.png"
    ImageLabel_3.ImageTransparency = 0.7
    ImageLabel_3.ScaleType = Enum.ScaleType.Slice
    ImageLabel_3.SliceCenter = Rect.new(5, 5, 23, 24)
    ImageLabel_3.AutomaticSize = Enum.AutomaticSize.X
    ImageLabel_3.BackgroundTransparency = 1
    ImageLabel_3.LayoutOrder = 1
    ImageLabel_3.Size = UDim2.fromOffset(0, 30)
    ImageLabel_3.ZIndex = 15
    ImageLabel_3.Parent = Frame_2
    local UIPadding_2 = Instance.new("UIPadding")
    UIPadding_2.Name = "Inset"
    UIPadding_2.PaddingLeft = UDim.new(0, 8)
    UIPadding_2.PaddingRight = UDim.new(0, 8)
    UIPadding_2.Parent = ImageLabel_3
    local TextLabel = Instance.new("TextLabel")
    TextLabel.AutoLocalize = false
    TextLabel.Name = "LabelContent"
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel.Text = ""
    TextLabel.TextColor3 = Color3.fromRGB(189, 190, 190)
    TextLabel.TextSize = 14
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromOffset(0, -1)
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.ZIndex = 16
    TextLabel.Parent = ImageLabel_3
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "Caret"
    ImageLabel.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
    ImageLabel.ImageColor3 = Color3.fromRGB(101, 102, 104)
    ImageLabel.ImageRectOffset = Vector2.new(260, 440)
    ImageLabel.ImageRectSize = Vector2.new(16, 8)
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0, 0, 0, 4)
    ImageLabel.Rotation = 180
    ImageLabel.Size = UDim2.fromOffset(16, 8)
    ImageLabel.ZIndex = 12
    ImageLabel.Parent = CanvasGroup
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "DropShadow"
    ImageLabel_2.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
    ImageLabel_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel_2.ImageRectOffset = Vector2.new(217, 486)
    ImageLabel_2.ImageRectSize = Vector2.new(25, 25)
    ImageLabel_2.ImageTransparency = 0.45
    ImageLabel_2.ScaleType = Enum.ScaleType.Slice
    ImageLabel_2.SliceCenter = Rect.new(12, 12, 13, 13)
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Position = UDim2.fromOffset(0, 5)
    ImageLabel_2.Size = UDim2.new(1, 0, 0, 48)
    ImageLabel_2.Parent = CanvasGroup
    ;(Frame:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 147 -- upvalues: ImageLabel_2 (val), Frame (val)
        ImageLabel_2.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8)
    end)
    local captionJanitor = p1.captionJanitor
    _, u269 = p1:clipOutside(CanvasGroup)
    u269.AutomaticSize = Enum.AutomaticSize.None
    local v3 = (CanvasGroup:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 157 -- upvalues: CanvasGroup (val), u269 (val)
        local AbsoluteSize = CanvasGroup.AbsoluteSize
        u269.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    end)
    captionJanitor:add(v3)
    local AbsoluteSize = CanvasGroup.AbsoluteSize
    u269.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    local u288 = false
    local Header = CanvasGroup.Box.Header
    local UserInputService = game:GetService("UserInputService")

    local function updateHotkey(p1_2) -- Line: 170
        -- upvalues: UserInputService (val), CanvasGroup (val), p1 (val), Header (val), TextLabel (val), Frame_2 (val)
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v1 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v2 = v1 == "_hotkey_"
        if not KeyboardEnabled and v2 then
            p1:setCaption()
            return
        end
        Header.Text = v1
        Header.Visible = not v2
        if p1_2 then
            TextLabel.Text = p1_2.Name
            Frame_2.Visible = true
        end
        if not KeyboardEnabled then
            Frame_2.Visible = false
        end
    end

    ;(CanvasGroup:GetAttributeChangedSignal("CaptionText")):Connect(updateHotkey)
    local Quad = Enum.EasingStyle.Quad
    local u310 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In)
    local u315 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out)
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")

    local function getCaptionPosition(p1) -- Line: 196 -- upvalues: u288 (ref)
        local v1, v2
        if p1 == nil then
            v1 = u288
        else
            v1 = p1
        end
        if not v1 then
            v2 = 2
        else
            v2 = 10
        end
        return UDim2.new(0.5, 0, 1, v2)
    end

    local function updatePosition(p1) -- Line: 203
        -- upvalues: u288 (ref), ImageLabel (val), CanvasGroup (val), u4 (val), u269 (val), u310 (val), u315 (val)
        -- upvalues: TweenService (val), RunService (val)
        local v1, v2, v3, v4
        if not u288 then
            return
        end
        if p1 == nil then
            v1 = u288
        else
            v1 = p1
        end
        local v5 = not v1
        if v5 == nil then
            v2 = u288
        else
            v2 = v5
        end
        if not v2 then
            v3 = 2
        else
            v3 = 10
        end
        local v6 = UDim2.new(0.5, 0, 1, v3)
        if v1 == nil then
            v2 = u288
        else
            v2 = v1
        end
        if not v2 then
            v3 = 2
        else
            v3 = 10
        end
        v5 = UDim2.new(0.5, 0, 1, v3)
        if not v1 then
            local AbsoluteSize = CanvasGroup.AbsoluteSize
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        else
            v2 = ImageLabel
            local Offset = v2.Position.Y.Offset
            ImageLabel.Position = UDim2.fromOffset(0, Offset)
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY
            CanvasGroup.Size = UDim2.fromOffset(32, 53)
        end
        local u61 = nil

        local function updateCaret() -- Line: 232
            -- upvalues: u4 (upval), CanvasGroup (upval), ImageLabel (upval), u61 (ref)
            local v1 = u4.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + u4.AbsoluteSize.X / 2 - ImageLabel.AbsoluteSize.X / 2
            local Offset = ImageLabel.Position.Y.Offset
            local v2 = UDim2.fromOffset(v1, Offset)
            if u61 ~= v1 then
                u61 = v1
                ImageLabel.Position = UDim2.fromOffset(0, Offset)
                task.wait()
            end
            ImageLabel.Position = v2
        end

        u269.Position = v6
        updateCaret()
        if not v1 then
            v4 = u315
        else
            v4 = u310
            if not v4 then
                v4 = u315
            end
        end
        local v7 = TweenService
        local v8 = u269
        local v9 = {Position = v5}
        v7 = v7:Create(v8, v4, v9)
        local u90 = RunService.Heartbeat:Connect(updateCaret)
        v7:Play()
        v7.Completed:Once(function() -- Line: 255 -- upvalues: u90 (val)
            u90:Disconnect()
        end)
    end

    local v4 = (u4:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 260 -- upvalues: updatePosition (val)
        updatePosition()
    end)
    captionJanitor:add(v4)
    updatePosition(false)
    v4 = p1.toggleKeyAdded:Connect(updateHotkey)
    captionJanitor:add(v4)
    for k, v in pairs(p1.bindedToggleKeys) do
        KeyboardEnabled = UserInputService.KeyboardEnabled
        v1 = CanvasGroup:GetAttribute("CaptionText") or ""
        v2 = v1 == "_hotkey_"
        if not KeyboardEnabled and v2 then
            p1:setCaption()
            break
        end
        Header.Text = v1
        Header.Visible = not v2
        if k then
            TextLabel.Text = k.Name
            Frame_2.Visible = true
        end
        if KeyboardEnabled then
            break
        end
        Frame_2.Visible = false
        break
    end
    v4 = p1.fakeToggleKeyChanged:Connect(updateHotkey)
    captionJanitor:add(v4)
    local fakeToggleKey = p1.fakeToggleKey
    if fakeToggleKey then
        local KeyboardEnabled_2 = UserInputService.KeyboardEnabled
        v4 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v5 = v4 == "_hotkey_"
        if KeyboardEnabled_2 or not v5 then
            Header.Text = v4
            Header.Visible = not v5
            if fakeToggleKey then
                TextLabel.Text = fakeToggleKey.Name
                Frame_2.Visible = true
            end
            if not KeyboardEnabled_2 then
                Frame_2.Visible = false
            end
        else
            p1:setCaption()
        end
    end

    local function setCaptionEnabled(p1_2) -- Line: 276
        -- upvalues: u288 (ref), p1 (val), u310 (val), u315 (val), TweenService (val), CanvasGroup (val)
        -- upvalues: updatePosition (val), UserInputService (val), Header (val), Frame_2 (val)
        local v1, v2, v3
        if u288 == p1_2 then
            return
        end
        local joinedFrame = p1.joinedFrame
        if not joinedFrame or not string.match(joinedFrame.Name, "Dropdown") then
            v1 = p1_2
        else
            v1 = false
        end
        u288 = v1
        if not v1 then
            v2 = 1
        else
            v2 = 0
        end
        if not v1 then
            v3 = u315
        else
            v3 = u310
            if not v3 then
                v3 = u315
            end
        end
        local v4 = TweenService
        local v5 = CanvasGroup
        local v6 = {GroupTransparency = v2}
        v4:Create(v5, v3, v6):Play()
        updatePosition()
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        v5 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v7 = v5 == "_hotkey_"
        if not KeyboardEnabled and v7 then
            p1:setCaption()
            return
        end
        Header.Text = v5
        Header.Visible = not v7
        if not KeyboardEnabled then
            Frame_2.Visible = false
        end
    end

    local iconModule = require(p1.iconModule)
    local v6 = p1.stateChanged:Connect(function(p1_2) -- Line: 298 -- upvalues: iconModule (val), p1 (val), setCaptionEnabled (val)
        local v1, v2
        if p1_2 ~= "Viewing" then
            iconModule.captionLastClosedClock = os.clock()
            setCaptionEnabled(false)
            return
        end
        local captionLastClosedClock = iconModule.captionLastClosedClock
        if not captionLastClosedClock then
            v1 = 999
        else
            v1 = os.clock() - captionLastClosedClock
            if not v1 then
                v1 = 999
            end
        end
        if not (v1 < 0.3) then
            v2 = 0.5
        else
            v2 = 0
        end
        task.delay(v2, function() -- Line: 303 -- upvalues: p1 (upval), setCaptionEnabled (upval)
            if p1.activeState == "Viewing" then
                setCaptionEnabled(true)
            end
        end)
    end)
    captionJanitor:add(v6)
    return CanvasGroup
end