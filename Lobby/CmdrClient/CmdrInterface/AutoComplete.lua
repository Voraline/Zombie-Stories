local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1) -- Line: 5 -- upvalues: LocalPlayer (val)
    local u1 = {SelectedItem = 0, Items = {}, ItemOptions = {}}
    local Util = p1.Util
    local Autocomplete = ((LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("Cmdr")):WaitForChild("Autocomplete")
    local TextButton = Autocomplete:WaitForChild("TextButton")
    local Title = Autocomplete:WaitForChild("Title")
    local Description = Autocomplete:WaitForChild("Description")
    local Entry = (Autocomplete.Parent:WaitForChild("Frame")):WaitForChild("Entry")
    TextButton.Parent = nil
    local ScrollBarThickness = Autocomplete.ScrollBarThickness

    local function SetText(p1, p2, p3, p4) -- Line: 24 -- upvalues: Util (val)
        local v1 = p3 ~= nil
        p1.Visible = v1
        p2.Text = p3 or ""
        if p4 then
            local new = UDim2.new
            local v2 = Util
            local GetTextSize = v2.GetTextSize
            local v3 = Vector2.new(1000, 1000)
            p2.Size = new(0, GetTextSize(p3 or "", p2, v3, 1, 0).X, p1.Size.Y.Scale, p1.Size.Y.Offset)
        end
    end

    local function UpdateContainerSize() -- Line: 38 -- upvalues: Autocomplete (val), Title (val)
        local v1 = Autocomplete
        local new = UDim2.new
        local v2 = Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X
        local v3 = Autocomplete
        local Offset = v3.Size.X.Offset
        local v4 = math.max(v2, Offset)
        local v5 = Autocomplete
        local Y = v5.UIListLayout.AbsoluteContentSize.Y
        local v6 = Autocomplete
        local Y_2 = v6.Parent.AbsoluteSize.Y
        local v7 = Autocomplete
        local v8 = Y_2 - v7.AbsolutePosition.Y - 10
        v1.Size = new(0, v4, 0, (math.min(Y, v8)))
    end

    local function UpdateInfoDisplay(p1) -- Line: 48
        -- upvalues: SetText (val), Title (val), Description (val), Autocomplete (val), UpdateContainerSize (val)
        -- upvalues: ScrollBarThickness (val)
        local v1
        SetText(Title, Title.Field, p1.name, true)
        local Type = Title.Field.Type
        local Type_2 = Title.Field.Type
        local type = p1.type
        if type then
            type = ": " .. (p1.type:sub(1, 1):upper()) .. p1.type:sub(2)
        end
        local v2 = type ~= nil
        Type.Visible = v2
        Type_2.Text = type or ""
        local v3 = Description
        local Label = Description.Label
        local description = p1.description
        v2 = description ~= nil
        v3.Visible = v2
        Label.Text = description or ""
        local Label_2 = Description.Label
        if not p1.invalid then
            v1 = Color3.fromRGB(255, 255, 255)
        else
            v1 = Color3.fromRGB(255, 73, 73)
            if not v1 then
                v1 = Color3.fromRGB(255, 255, 255)
            end
        end
        Label_2.TextColor3 = v1
        Description.Size = UDim2.new(1, 0, 0, 40)
        while not Description.Label.TextFits do
            Description.Size = Description.Size + UDim2.new(0, 0, 0, 2)
            if 500 < Description.Size.Y.Offset then
                break
            end
        end
        task.wait()
        Autocomplete.UIListLayout:ApplyLayout()
        UpdateContainerSize()
        Autocomplete.ScrollBarThickness = ScrollBarThickness
    end

    function u1.Show(p1, p2, p3) -- Line: 88
        -- upvalues: Autocomplete (val), TextButton (val), Entry (val), Util (val), UpdateInfoDisplay (val)
        local Suggest, Typed, X, X_2, at, options, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
        local v12 = p3 or {}
        local v13 = v12
        for k, v in pairs(p1.Items) do
            if v.gui then
                v.gui:Destroy()
            end
        end
        p1.SelectedItem = 1
        p1.Items = p2
        p1.Prefix = v13.prefix or ""
        p1.LastItem = v13.isLast or false
        p1.Command = v13.command
        p1.Arg = v13.arg
        p1.NumArgs = v13.numArgs
        p1.IsPartial = v13.isPartial
        v12 = 200
        Autocomplete.ScrollBarThickness = 0
        local v14 = p1
        for k2, i in pairs(p1.Items) do
            v11 = i[1]
            v1 = i[2]
            v2 = TextButton:Clone()
            v2.Name = v11 .. v1
            if k2 ~= v14.SelectedItem then
                v3 = 1
            else
                v3 = 0.5
            end
            v2.BackgroundTransparency = v3
            v3, v4 = string.find(v1:lower(), v11:lower(), 1, true)
            Typed = v2.Typed
            Typed.Text = (string.rep(" ", v3 - 1)) .. v11
            Suggest = v2.Suggest
            v8 = v3 - 1
            v6 = string.sub(v1, 0, v8)
            v7 = string.rep(" ", #v11)
            v9 = v4 + 1
            Suggest.Text = v6 .. v7 .. string.sub(v1, v9)
            v2.Parent = Autocomplete
            v2.LayoutOrder = k2
            X = v2.Typed.TextBounds.X
            X_2 = v2.Suggest.TextBounds.X
            v5 = math.max(X, X_2) + 20
            if v12 < v5 then
                v12 = v5
            end
            i.gui = v2
        end
        Autocomplete.UIListLayout:ApplyLayout()
        local Text = Entry.TextBox.Text
        local v15 = Util.SplitString(Text)
        local v16 = #Text
        v11 = #Text
        if Text:sub(v16, v11) == " " and not v13.at then
            v10 = #v15 + 1
            v15[v10] = "e"
        end
        table.remove(v15, #v15)
        if not v13.at then
            at = #table.concat(v15, " ") + 1
        else
            at = v13.at
            if not at then
                at = #table.concat(v15, " ") + 1
            end
        end
        v10 = at * 7
        local v17 = Autocomplete
        v17.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + v10, 0, Entry.TextBox.AbsolutePosition.Y + 30)
        Autocomplete.Size = UDim2.new(0, v12, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
        Autocomplete.Visible = true
        v17 = UpdateInfoDisplay
        if not v14.Items[1] then
            options = v13
        else
            options = v14.Items[1].options
            if not options then
                options = v13
            end
        end
        v17(options)
    end

    function u1.GetSelectedItem(p1) -- Line: 161 -- upvalues: Autocomplete (val), u1 (val)
        if Autocomplete.Visible == false then
            return nil
        end
        return u1.Items[u1.SelectedItem]
    end

    function u1.Hide(p1) -- Line: 170 -- upvalues: Autocomplete (val)
        Autocomplete.Visible = false
    end

    function u1.IsVisible(p1) -- Line: 175 -- upvalues: Autocomplete (val)
        return Autocomplete.Visible
    end

    function u1.Select(p1, p2) -- Line: 180
        -- upvalues: Autocomplete (val), Title (val), Description (val), TextButton (val), UpdateInfoDisplay (val)
        local gui, v1
        if not Autocomplete.Visible then
            return
        end
        p1.SelectedItem = p1.SelectedItem + p2
        local SelectedItem = p1.SelectedItem
        if #p1.Items < SelectedItem then
            p1.SelectedItem = 1
        elseif p1.SelectedItem < 1 then
            p1.SelectedItem = #p1.Items
        end
        local v2 = p1
        for k, v in pairs(p1.Items) do
            gui = v.gui
            if k ~= v2.SelectedItem then
                v1 = 1
            else
                v1 = 0.5
            end
            gui.BackgroundTransparency = v1
        end
        local v3 = Autocomplete
        local new = Vector2.new
        v1 = Title.Size.Y.Offset + Description.Size.Y.Offset + v2.SelectedItem * TextButton.Size.Y.Offset
        local v4 = Autocomplete
        local v5 = v1 - v4.Size.Y.Offset
        v3.CanvasPosition = new(0, (math.max(0, v5)))
        if v2.Items[v2.SelectedItem] and v2.Items[v2.SelectedItem].options then
            v3 = UpdateInfoDisplay
            local options = v2.Items[v2.SelectedItem].options
            if not options then
                options = {}
            end
            v3(options)
        end
    end

    ;(Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize")):Connect(UpdateContainerSize)
    return u1
end