return function(p1) -- Line: 1
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "Menu"
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Size = UDim2.fromScale(1, 1)
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.TopImage = ""
    ScrollingFrame.BottomImage = ""
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ZIndex = 20
    ScrollingFrame.ScrollBarThickness = 3
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false
    local iconModule = require(p1.iconModule)
    local u46 = iconModule.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()
    u46.Name = "MenuUIListLayout"
    u46.VerticalAlignment = Enum.VerticalAlignment.Center
    u46.Parent = ScrollingFrame
    local Frame = Instance.new("Frame")
    Frame.Name = "MenuGap"
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    Frame.AnchorPoint = Vector2.new(0, 0.5)
    Frame.ZIndex = 5
    Frame.Parent = ScrollingFrame
    local u60 = false
    local u63 = require("../Features/Themes")
    p1.menuChildAdded:Connect(function() -- Line: 39 -- upvalues: p1 (val), u60 (ref), ScrollingFrame (val), u63 (val), u46 (val)
        local u30
        local menuJanitor = p1.menuJanitor
        local v1 = #p1.menuIcons
        if u60 then
            if v1 <= 0 then
                menuJanitor:clean()
                u60 = false
            end
            return
        end
        u60 = true
        local v2 = p1
        v2 = v2.toggled:Connect(function() -- Line: 53 -- upvalues: p1 (upval)
            if 0 < #p1.menuIcons then
                p1.updateSize:Fire()
            end
        end)
        menuJanitor:add(v2)
        local v3 = p1
        _, u30 = v3:modifyTheme({
            {"Menu", "Active", true},
        })
        task.defer(function() -- Line: 63 -- upvalues: menuJanitor (val), p1 (upval), u30 (val)
            local v1 = menuJanitor
            v1:add(function() -- Line: 64 -- upvalues: p1 (upval), u30 (upval)
                local v1 = p1
                local v2 = u30
                v1:removeModification(v2)
            end)
        end)
        v2 = ScrollingFrame
        local X = v2.AbsoluteCanvasSize.X

        local function rightAlignCanvas() -- Line: 73 -- upvalues: p1 (upval), ScrollingFrame (upval), X (ref)
            if p1.alignment == "Right" then
                local X_2 = ScrollingFrame.AbsoluteCanvasSize.X
                local v1 = X - X_2
                X = X_2
                local v2 = ScrollingFrame
                v2.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X - v1, 0)
            end
        end

        local v4 = p1.selected:Connect(rightAlignCanvas)
        menuJanitor:add(v4)
        v4 = (ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize")):Connect(rightAlignCanvas)
        menuJanitor:add(v4)
        local v5 = p1:getStateGroup()
        if (u63.getThemeValue(v5, "IconImage", "Image", "Deselected")) == u63.getThemeValue(v5, "IconImage", "Image", "Selected") then
            local v6 = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)
            p1:removeModificationWith("IconLabel", "Text", "Viewing")
            p1:removeModificationWith("IconLabel", "Image", "Viewing")
            local v7 = p1
            local v8 = {
                {"IconLabel", "FontFace", v6, "Selected"},
                {"IconLabel", "Text", "X", "Selected"},
                {"IconLabel", "TextSize", 20, "Selected"},
                {"IconLabel", "TextStrokeTransparency", 0.8, "Selected"},
                {"IconImage", "Image", "", "Selected"},
            }
            v7:modifyTheme(v8)
        end
        local u130 = p1:getInstance("IconSpot")
        local u135 = p1:getInstance("MenuGap")
        local v9 = p1.alignmentChanged:Connect(function() -- Line: 105 -- upvalues: p1 (upval), u130 (val), u135 (val)
            if p1.alignment == "Right" then
                u130.LayoutOrder = 99999
                u135.LayoutOrder = 99998
                return
            end
            u130.LayoutOrder = -99999
            u135.LayoutOrder = -99998
        end)
        menuJanitor:add(v9)
        if p1.alignment ~= "Right" then
            u130.LayoutOrder = -99999
            u135.LayoutOrder = -99998
        else
            u130.LayoutOrder = 99999
            u135.LayoutOrder = 99998
        end
        ;(ScrollingFrame:GetAttributeChangedSignal("MenuCanvasWidth")):Connect(function() -- Line: 120 -- upvalues: ScrollingFrame (upval)
            local Attribute = ScrollingFrame:GetAttribute("MenuCanvasWidth")
            local Y = ScrollingFrame.CanvasSize.Y
            ScrollingFrame.CanvasSize = UDim2.new(0, Attribute, Y.Scale, Y.Offset)
        end)
        v9 = p1
        v9 = v9.updateMenu:Connect(function() -- Line: 125 -- upvalues: ScrollingFrame (upval), u46 (upval)
            local v1, v2
            local Attribute = ScrollingFrame:GetAttribute("MaxIcons")
            if not Attribute then
                return
            end
            local v3 = {}
            for k, v in pairs(ScrollingFrame:GetChildren()) do
                if v:GetAttribute("WidgetUID") and v.Visible then
                    v1 = {v, v.AbsolutePosition.X}
                    table.insert(v3, v1)
                end
            end
            table.sort(v3, function(p1, p2) -- Line: 137
                local v1 = p1[2] < p2[2]
                return v1
            end)
            local v4 = 0
            local v5 = Attribute
            for i = 1, v5 do
                v2 = v3[i]
                if not v2 then
                    break
                end
                v4 = v4 + (v2[1].AbsoluteSize.X + u46.Padding.Offset)
            end
            ScrollingFrame:SetAttribute("MenuWidth", v4)
        end)
        menuJanitor:add(v9)

        local function startMenuUpdate() -- Line: 152 -- upvalues: p1 (upval)
            task.delay(0.1, function() -- Line: 153 -- upvalues: p1 (upval)
                p1.startMenuUpdate:Fire()
            end)
        end

        local X_2 = p1:getInstance("IconButton").AbsoluteSize.X
        local v10 = ScrollingFrame.ChildAdded:Connect(startMenuUpdate)
        menuJanitor:add(v10)
        v10 = ScrollingFrame.ChildRemoved:Connect(startMenuUpdate)
        menuJanitor:add(v10)
        v10 = (ScrollingFrame:GetAttributeChangedSignal("MaxIcons")):Connect(startMenuUpdate)
        menuJanitor:add(v10)
        v10 = (ScrollingFrame:GetAttributeChangedSignal("MaxWidth")):Connect(startMenuUpdate)
        menuJanitor:add(v10)
        task.delay(0.1, function() -- Line: 153 -- upvalues: p1 (upval)
            p1.startMenuUpdate:Fire()
        end)
    end)
    p1.menuSet:Connect(function(p1_2) -- Line: 167 -- upvalues: p1 (val), iconModule (val)
        for k, v in pairs(p1.menuIcons) do
            iconModule.getIconByUID(v):destroy()
        end
        local v1 = #p1_2
        if type(p1_2) == "table" then
            local v2
            for k2, i in pairs(p1_2) do
                v2 = p1
                i:joinMenu(v2)
            end
        end
    end)
    return ScrollingFrame
end