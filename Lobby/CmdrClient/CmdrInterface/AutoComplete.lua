local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1) -- Line: 5 -- upvalues: LocalPlayer (val)
    local u1 = {SelectedItem = 0, Items = {}}
    local v1 = {}
    u1.ItemOptions = v1
    local Util = p1.Util
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local Cmdr = PlayerGui:WaitForChild("Cmdr")
    local Autocomplete = Cmdr:WaitForChild("Autocomplete")
    local TextButton = Autocomplete:WaitForChild("TextButton")
    local Title = Autocomplete:WaitForChild("Title")
    local Description = Autocomplete:WaitForChild("Description")
    local Frame = Autocomplete.Parent:WaitForChild("Frame")
    local Entry = Frame:WaitForChild("Entry")
    TextButton.Parent = nil
    local ScrollBarThickness = Autocomplete.ScrollBarThickness
    local function SetText(p1, p2, p3, p4) -- Line: 24 -- upvalues: Util (val)
        local v1 = p3 ~= nil
        p1.Visible = v1
        p2.Text = p3 or ""
        if p4 then
            local v2 = Vector2.new(1000, 1000)
            p2.Size = UDim2.new(0, Util.GetTextSize(p3 or "", p2, v2, 1, 0).X, p1.Size.Y.Scale, p1.Size.Y.Offset)
        end
    end
    local function UpdateContainerSize() -- Line: 38 -- upvalues: Autocomplete (val), Title (val)
        local v1 = math.max(Title.Field.TextBounds.X + Title.Field.Type.TextBounds.X, Autocomplete.Size.X.Offset)
        Autocomplete.Size = UDim2.new(0, v1, 0, (math.min(Autocomplete.UIListLayout.AbsoluteContentSize.Y, Autocomplete.Parent.AbsoluteSize.Y - Autocomplete.AbsolutePosition.Y - 10)))
    end
    local function UpdateInfoDisplay(p1) -- Line: 48 -- upvalues: SetText (val), Title (val), Description (val), Autocomplete (val), UpdateContainerSize (val), ScrollBarThickness (val)
        local v1
        SetText(Title, Title.Field, p1.name, true)
        local type = p1.type
        if type then
            local v2 = p1.type:sub(1, 1):upper()
            type = ": " .. v2 .. p1.type:sub(2)
        end
        local v3 = type ~= nil
        Title.Field.Type.Visible = v3
        Title.Field.Type.Text = type or ""
        local description = p1.description
        v3 = description ~= nil
        Description.Visible = v3
        Description.Label.Text = description or ""
        local Label = Description.Label
        if not p1.invalid then
            v1 = Color3.fromRGB(255, 255, 255)
        else
            v1 = Color3.fromRGB(255, 73, 73)
        end
        Label.TextColor3 = v1
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
    function u1.Show(p1, p2, p3) -- Line: 88 -- upvalues: Autocomplete (val), TextButton (val), Entry (val), Util (val), UpdateInfoDisplay (val)
        local at, options, v1, v2, v3, v4, v5, v6, v7, v8
        local v9 = p3
        if not v9 then
            v9 = {}
        end
        local v10 = v9
        for k, v in pairs(p1.Items) do
            if v.gui then
                v.gui:Destroy()
            end
        end
        p1.SelectedItem = 1
        p1.Items = p2
        p1.Prefix = v10.prefix or ""
        p1.LastItem = v10.isLast or false
        p1.Command = v10.command
        p1.Arg = v10.arg
        p1.NumArgs = v10.numArgs
        p1.IsPartial = v10.isPartial
        v9 = 200
        Autocomplete.ScrollBarThickness = 0
        local v11 = p1
        for k2, i in pairs(p1.Items) do
            v8 = i[1]
            v1 = i[2]
            v2 = TextButton:Clone()
            v2.Name = v8 .. v1
            if k2 ~= v11.SelectedItem then
                v3 = 1
            else
                v3 = 0.5
            end
            v2.BackgroundTransparency = v3
            v4 = v1:lower()
            v5 = v8:lower()
            v3, v4 = string.find(v4, v5, 1, true)
            v6 = string.rep(" ", v3 - 1)
            v2.Typed.Text = v6 .. v8
            v6 = string.sub(v1, 0, v3 - 1)
            v7 = string.rep(" ", #v8)
            v2.Suggest.Text = v6 .. v7 .. string.sub(v1, v4 + 1)
            v2.Parent = Autocomplete
            v2.LayoutOrder = k2
            v5 = math.max(v2.Typed.TextBounds.X, v2.Suggest.TextBounds.X) + 20
            if v9 < v5 then
                v9 = v5
            end
            i.gui = v2
        end
        Autocomplete.UIListLayout:ApplyLayout()
        local Text = Entry.TextBox.Text
        local v12 = Util.SplitString(Text)
        local v13 = #Text
        v8 = #Text
        if Text:sub(v13, v8) == " " and not v10.at then
            v12[#v12 + 1] = "e"
        end
        table.remove(v12, #v12)
        if not v10.at then
            at = #table.concat(v12, " ") + 1
        else
            at = v10.at
        end
        Autocomplete.Position = UDim2.new(0, Entry.TextBox.AbsolutePosition.X - 10 + at * 7, 0, Entry.TextBox.AbsolutePosition.Y + 30)
        Autocomplete.Size = UDim2.new(0, v9, 0, Autocomplete.UIListLayout.AbsoluteContentSize.Y)
        Autocomplete.Visible = true
        if not (v11.Items[1]) then
            options = v10
        else
            options = v11.Items[1].options
            if not options then
                options = v10
            end
        end
        UpdateInfoDisplay(options)
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
    function u1.Select(p1, p2) -- Line: 180 -- upvalues: Autocomplete (val), Title (val), Description (val), TextButton (val), UpdateInfoDisplay (val)
        local options, v1
        if not Autocomplete.Visible then
            return
        end
        p1.SelectedItem = p1.SelectedItem + p2
        if #p1.Items < p1.SelectedItem then
            p1.SelectedItem = 1
        elseif p1.SelectedItem < 1 then
            p1.SelectedItem = #p1.Items
        end
        local v2 = p1
        for k, v in pairs(p1.Items) do
            if k ~= v2.SelectedItem then
                v1 = 1
            else
                v1 = 0.5
            end
            v.gui.BackgroundTransparency = v1
        end
        v1 = Title.Size.Y.Offset + Description.Size.Y.Offset + v2.SelectedItem * TextButton.Size.Y.Offset
        Autocomplete.CanvasPosition = Vector2.new(0, (math.max(0, v1 - Autocomplete.Size.Y.Offset)))
        if v2.Items[v2.SelectedItem] and v2.Items[v2.SelectedItem].options then
            options = v2.Items[v2.SelectedItem].options
            if not options then
                options = {}
            end
            UpdateInfoDisplay(options)
        end
    end
    local PropertyChangedSignal = Autocomplete.Parent:GetPropertyChangedSignal("AbsoluteSize")
    PropertyChangedSignal:Connect(UpdateContainerSize)
    return u1
end