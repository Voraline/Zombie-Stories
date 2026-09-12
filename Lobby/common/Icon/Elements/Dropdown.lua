return function(p1) -- Line: 1
    local updateMaxIcons
    local Frame = Instance.new("Frame")
    Frame.Name = "Dropdown"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 10)
    Frame.ZIndex = -2
    Frame.ClipsDescendants = true
    Frame.Parent = p1.widget
    local UICorner = Instance.new("UICorner")
    UICorner.Name = "DropdownCorner"
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "DropdownScroller"
    ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.ZIndex = -1
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.Visible = true
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    ScrollingFrame.Active = false
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Selectable = false
    ScrollingFrame.Active = true
    ScrollingFrame.Parent = Frame
    local UIPadding = Instance.new("UIPadding")
    UIPadding.Name = "DropdownPadding"
    UIPadding.PaddingTop = UDim.new(0, 8)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.Parent = ScrollingFrame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "DropdownList"
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Parent = ScrollingFrame
    local dropdownJanitor = p1.dropdownJanitor
    local iconModule = require(p1.iconModule)
    p1.dropdownChildAdded:Connect(function(p1) -- Line: 58
        local u66
        local v1 = {}
        local v2 = {"IconCorners", "CornerRadius", UDim.new(0, 4)}
        local v3 = {"PaddingLeft", "Size", UDim2.fromOffset(25, 0)}
        local v4 = {"Notice", "Position", UDim2.new(1, -24, 0, 5)}
        local v5 = {"ContentsList", "HorizontalAlignment", Enum.HorizontalAlignment.Left}
        local v6 = {"Selection", "Size", UDim2.new(1, -8, 1, -8)}
        local v7 = {"Selection", "Position", UDim2.new(0, 4, 0, 4)}
        v1[1] = {"Widget", "BorderSize", 0}
        v1[2] = v2
        v1[3] = {"Widget", "MinimumWidth", 190}
        v1[4] = {"Widget", "MinimumHeight", 56}
        v1[5] = {"IconLabel", "TextSize", 19}
        v1[6] = v3
        v1[7] = v4
        v1[8] = v5
        v1[9] = v6
        v1[10] = v7
        _, u66 = p1:modifyTheme(v1)
        task.defer(function() -- Line: 72 -- upvalues: p1 (val), u66 (val)
            local v1 = p1
            v1.joinJanitor:add(function() -- Line: 73 -- upvalues: p1 (upval), u66 (upval)
                local v1 = p1
                local v2 = u66
                v1:removeModification(v2)
            end)
        end)
    end)
    p1.dropdownSet:Connect(function(p1_2) -- Line: 78 -- upvalues: p1 (val), iconModule (val)
        for k, v in pairs(p1.dropdownIcons) do
            iconModule.getIconByUID(v):destroy()
        end
        local v1 = #p1_2
        if type(p1_2) == "table" then
            local v2
            for k2, i in pairs(p1_2) do
                v2 = p1
                i:joinDropdown(v2)
            end
        end
    end)
    local u105 = require("../Utility")
    local v1 = p1.toggled:Connect(function() -- Line: 95 -- upvalues: u105 (val), Frame (val), p1 (val)
        u105.setVisible(Frame, p1.isSelected, "InternalDropdown")
    end)
    dropdownJanitor:add(v1)
    u105.setVisible(Frame, p1.isSelected, "InternalDropdown")
    local u120 = 0
    local u121 = false

    function updateMaxIcons() -- Line: 107
        -- upvalues: u120 (ref), u121 (ref), updateMaxIcons (val), Frame (val), ScrollingFrame (val), iconModule (val)
        -- upvalues: p1 (val), UIPadding (val)
        local Attribute_2, v1, v2, v3, v4, v5
        u120 = u120 + 1
        if u121 then
            return
        end
        local u3 = u120
        u121 = true
        task.defer(function() -- Line: 116 -- upvalues: u121 (upval), u120 (upval), u3 (val), updateMaxIcons (upval)
            u121 = false
            if u120 ~= u3 then
                updateMaxIcons()
            end
        end)
        local Attribute = Frame:GetAttribute("MaxIcons")
        if not Attribute then
            return
        end
        local v6 = {}
        for k, v in pairs(ScrollingFrame:GetChildren()) do
            if v:IsA("GuiObject") then
                v1 = {v, v.AbsolutePosition.Y}
                table.insert(v6, v1)
            end
        end
        table.sort(v6, function(p1, p2) -- Line: 133
            local v1 = p1[2] < p2[2]
            return v1
        end)
        local v7 = 0
        local v8 = false
        local v9 = Attribute
        for i = 1, v9 do
            v4 = v6[i]
            if not v4 then
                break
            end
            v5 = v4[1]
            v7 = v7 + v5.AbsoluteSize.Y
            Attribute_2 = v5:GetAttribute("WidgetUID")
            v2 = Attribute_2
            if v2 then
                v2 = iconModule.getIconByUID(Attribute_2)
            end
            if v2 then
                v3 = nil
                if not v8 then
                    v8 = true
                    v3 = p1:getInstance("ClickRegion")
                end
                v2:getInstance("ClickRegion").NextSelectionUp = v3
            end
        end
        v7 = v7 + UIPadding.PaddingTop.Offset
        v7 = v7 + UIPadding.PaddingBottom.Offset
        ScrollingFrame.Size = UDim2.fromOffset(0, v7)
    end

    local v2 = (ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize")):Connect(updateMaxIcons)
    dropdownJanitor:add(v2)
    v2 = ScrollingFrame.ChildAdded:Connect(updateMaxIcons)
    dropdownJanitor:add(v2)
    v2 = ScrollingFrame.ChildRemoved:Connect(updateMaxIcons)
    dropdownJanitor:add(v2)
    v2 = (Frame:GetAttributeChangedSignal("MaxIcons")):Connect(updateMaxIcons)
    dropdownJanitor:add(v2)
    v2 = p1.childThemeModified:Connect(updateMaxIcons)
    dropdownJanitor:add(v2)
    updateMaxIcons()
    return Frame
end