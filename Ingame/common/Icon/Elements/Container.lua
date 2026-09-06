return function(p1) -- Line: 1
    local v1, v2
    local GuiService_2 = game:GetService("GuiService")
    local isOldTopbar = p1.isOldTopbar
    local v3 = {}
    local GuiInset = GuiService_2:GetGuiInset()
    local v4 = GuiService_2:IsTenFootInterface()
    if not isOldTopbar then
        v1 = GuiInset.Y - 46
    else
        v1 = 12
    end
    if v4 then
        v1 = 10
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui:SetAttribute("StartInset", v1)
    ScreenGui.Name = "TopbarStandard"
    ScreenGui.Enabled = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    v3[ScreenGui.Name] = ScreenGui
    ScreenGui.DisplayOrder = p1.baseDisplayOrder
    p1.baseDisplayOrderChanged:Connect(function() -- Line: 22 -- upvalues: ScreenGui (val), p1 (val)
        ScreenGui.DisplayOrder = p1.baseDisplayOrder
    end)
    local Frame = Instance.new("Frame")
    if not isOldTopbar then
        v2 = 0
    else
        v2 = 2
    end
    local u58 = -2
    if v4 then
        v2 = v2 + 13
        u58 = 50
    end
    Frame.Name = "Holders"
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(0, 0, 0, v2)
    Frame.Size = UDim2.new(1, 0, 1, u58)
    Frame.Visible = true
    Frame.ZIndex = 1
    Frame.Parent = ScreenGui
    local u83 = ScreenGui:Clone()
    local Holders = u83.Holders
    local GuiService = game:GetService("GuiService")
    u83.Name = "TopbarCentered"
    u83.ScreenInsets = Enum.ScreenInsets.None
    p1.baseDisplayOrderChanged:Connect(function() -- Line: 49 -- upvalues: u83 (val), p1 (val)
        u83.DisplayOrder = p1.baseDisplayOrder
    end)
    v3[u83.Name] = u83
    local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("TopbarInset")
    PropertyChangedSignal:Connect(function() -- Line: 44 -- upvalues: Holders (val), GuiService (val), u58 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u58)
    end)
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u58)
    local u121 = ScreenGui:Clone()
    u121.Name = u121.Name .. "Clipped"
    u121.DisplayOrder = u121.DisplayOrder + 1
    p1.baseDisplayOrderChanged:Connect(function() -- Line: 59 -- upvalues: u121 (val), p1 (val)
        u121.DisplayOrder = p1.baseDisplayOrder + 1
    end)
    v3[u121.Name] = u121
    local u135 = u83:Clone()
    u135.Name = u135.Name .. "Clipped"
    u135.DisplayOrder = u135.DisplayOrder + 1
    p1.baseDisplayOrderChanged:Connect(function() -- Line: 67 -- upvalues: u135 (val), p1 (val)
        u135.DisplayOrder = p1.baseDisplayOrder + 1
    end)
    v3[u135.Name] = u135
    if isOldTopbar then
        task.defer(function() -- Line: 73 -- upvalues: GuiService (val), p1 (val)
            local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("MenuIsOpen")
            PropertyChangedSignal:Connect(function() -- Line: 74 -- upvalues: GuiService (upval), p1 (upval)
                if GuiService.MenuIsOpen then
                    p1.setTopbarEnabled(false, true)
                    return
                end
                p1.setTopbarEnabled()
            end)
            if GuiService.MenuIsOpen then
                p1.setTopbarEnabled(false, true)
                return
            end
            p1.setTopbarEnabled()
        end)
    end
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame:SetAttribute("IsAHolder", true)
    ScrollingFrame.Name = "Left"
    ScrollingFrame.Position = UDim2.fromOffset(v1, 0)
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Active = false
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ScrollBarThickness = 0
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false
    ScrollingFrame.ScrollingEnabled = false
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never
    ScrollingFrame.Parent = Frame
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, v1)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = ScrollingFrame
    local v5 = ScrollingFrame:Clone()
    v5.ScrollingEnabled = false
    v5.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    v5.Name = "Center"
    v5.Parent = Holders
    local v6 = ScrollingFrame:Clone()
    v6.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    v6.Name = "Right"
    v6.AnchorPoint = Vector2.new(1, 0)
    v6.Position = UDim2.new(1, -12, 0, 0)
    v6.Parent = Frame
    return v3
end