local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local u21 = {}
u21[1] = Enum.UserInputType.MouseButton1
u21[2] = Enum.UserInputType.MouseButton2
u21[3] = Enum.UserInputType.Touch
local u25 = {Valid = true}
local Frame = ((LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("Cmdr")):WaitForChild("Frame")
local Line = Frame:WaitForChild("Line")
local Entry = Frame:WaitForChild("Entry")
Line.Parent = nil

function u25.UpdateLabel(p1) -- Line: 29 -- upvalues: Entry (val), LocalPlayer (val)
    Entry.TextLabel.Text = LocalPlayer.Name .. "@" .. p1.Cmdr.PlaceName .. "$"
end

function u25.GetLabel(p1) -- Line: 34 -- upvalues: Entry (val)
    return Entry.TextLabel.Text
end

function u25.UpdateWindowHeight(p1) -- Line: 39 -- upvalues: Frame (val)
    local v1 = Frame.UIListLayout.AbsoluteContentSize.Y + Frame.UIPadding.PaddingTop.Offset + Frame.UIPadding.PaddingBottom.Offset
    Frame.Size = UDim2.new(Frame.Size.X.Scale, Frame.Size.X.Offset, 0, (math.clamp(v1, 0, 300)))
    Frame.CanvasPosition = Vector2.new(0, v1)
end

function u25:AddLine(p2, p3) -- Line: 48 -- upvalues: u25 (val), Line (val), Frame (val)
    local v1 = p3 or {}
    local v2 = v1
    local v3 = tostring(p2)
    if typeof(v2) == "Color3" then
        v2 = {Color = v2}
    end
    if #v3 == 0 then
        u25:UpdateWindowHeight()
        return
    end
    v1 = self.Cmdr.Util.EmulateTabstops(v3 or "nil", 8)
    local v4 = Line:Clone()
    v4.Text = v1
    local Color = v2.Color
    if not Color then
        Color = v4.TextColor3
    end
    v4.TextColor3 = Color
    v4.RichText = v2.RichText or false
    v4.Parent = Frame
end

function u25.IsVisible(p1) -- Line: 71 -- upvalues: Frame (val)
    return Frame.Visible
end

function u25:SetVisible(p2) -- Line: 76
    -- upvalues: Frame (val), TextChatService (val), Entry (val), UserInputService (val)
    local PreviousChannelTabsConfigurationEnabled, PreviousChatInputBarConfigurationEnabled, PreviousChatWindowConfigurationEnabled
    Frame.Visible = p2
    if p2 then
        self.PreviousChatWindowConfigurationEnabled = TextChatService.ChatWindowConfiguration.Enabled
        self.PreviousChatInputBarConfigurationEnabled = TextChatService.ChatInputBarConfiguration.Enabled
        self.PreviousChannelTabsConfigurationEnabled = TextChatService.ChannelTabsConfiguration.Enabled
        TextChatService.ChatWindowConfiguration.Enabled = false
        TextChatService.ChatInputBarConfiguration.Enabled = false
        TextChatService.ChannelTabsConfiguration.Enabled = false
        Entry.TextBox:CaptureFocus()
        self:SetEntryText("")
        if not self.Cmdr.ActivationUnlocksMouse then
            return
        end
        self.PreviousMouseBehavior = UserInputService.MouseBehavior
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        return
    end
    local ChatWindowConfiguration = TextChatService.ChatWindowConfiguration
    if self.PreviousChatWindowConfigurationEnabled == nil then
        PreviousChatWindowConfigurationEnabled = true
    else
        PreviousChatWindowConfigurationEnabled = self.PreviousChatWindowConfigurationEnabled
    end
    ChatWindowConfiguration.Enabled = PreviousChatWindowConfigurationEnabled
    local ChatInputBarConfiguration = TextChatService.ChatInputBarConfiguration
    if self.PreviousChatInputBarConfigurationEnabled == nil then
        PreviousChatInputBarConfigurationEnabled = true
    else
        PreviousChatInputBarConfigurationEnabled = self.PreviousChatInputBarConfigurationEnabled
    end
    ChatInputBarConfiguration.Enabled = PreviousChatInputBarConfigurationEnabled
    local ChannelTabsConfiguration = TextChatService.ChannelTabsConfiguration
    if self.PreviousChannelTabsConfigurationEnabled == nil then
        PreviousChannelTabsConfigurationEnabled = true
    else
        PreviousChannelTabsConfigurationEnabled = self.PreviousChannelTabsConfigurationEnabled
    end
    ChannelTabsConfiguration.Enabled = PreviousChannelTabsConfigurationEnabled
    Entry.TextBox:ReleaseFocus()
    self.AutoComplete:Hide()
    if self.PreviousMouseBehavior then
        UserInputService.MouseBehavior = self.PreviousMouseBehavior
        self.PreviousMouseBehavior = nil
    end
end

function u25:Hide() -- Line: 113
    return self:SetVisible(false)
end

function u25.Show(p1) -- Line: 118
    return p1:SetVisible(true)
end

function u25:SetEntryText(p2) -- Line: 123 -- upvalues: Entry (val), u25 (val)
    Entry.TextBox.Text = p2
    if self:IsVisible() then
        Entry.TextBox:CaptureFocus()
        Entry.TextBox.CursorPosition = #p2 + 1
        u25:UpdateWindowHeight()
    end
end

function u25.GetEntryText(p1) -- Line: 134 -- upvalues: Entry (val)
    return Entry.TextBox.Text:gsub("\t", "")
end

function u25.SetIsValidInput(p1, p2, p3) -- Line: 140 -- upvalues: Entry (val)
    local v1
    local TextBox = Entry.TextBox
    if not p2 then
        v1 = Color3.fromRGB(255, 73, 73)
    else
        v1 = Color3.fromRGB(255, 255, 255)
        if not v1 then
            v1 = Color3.fromRGB(255, 73, 73)
        end
    end
    TextBox.TextColor3 = v1
    p1.Valid = p2
    p1._errorText = p3
end

function u25.HideInvalidState(p1) -- Line: 146 -- upvalues: Entry (val)
    Entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end

function u25:LoseFocus(p2) -- Line: 151 -- upvalues: Entry (val), Frame (val), GuiService (val)
    local Text = Entry.TextBox.Text
    self:ClearHistoryState()
    if not Frame.Visible then
        if GuiService.MenuIsOpen and Frame.Visible then
            self:Hide()
        end
    elseif not GuiService.MenuIsOpen then
        Entry.TextBox:CaptureFocus()
    elseif GuiService.MenuIsOpen and Frame.Visible then
        self:Hide()
    end
    if p2 and self.Valid then
        wait()
        self:SetEntryText("")
        self.ProcessEntry(Text)
        return
    end
    if p2 then
        local _errorText = self._errorText
        local v1 = Color3.fromRGB(255, 153, 153)
        self:AddLine(_errorText, v1)
    end
end

function u25:TraverseHistory(p2) -- Line: 172
    local InitialText
    local History = self.Cmdr.Dispatcher:GetHistory()
    if self.HistoryState == nil then
        local v1 = {Position = #History + 1, InitialText = self:GetEntryText()}
        self.HistoryState = v1
    end
    local HistoryState = self.HistoryState
    local v2 = self.HistoryState.Position + p2
    local v3 = #History + 1
    HistoryState.Position = math.clamp(v2, 1, v3)
    if self.HistoryState.Position ~= #History + 1 then
        InitialText = History[self.HistoryState.Position]
    else
        InitialText = self.HistoryState.InitialText
        if not InitialText then
            InitialText = History[self.HistoryState.Position]
        end
    end
    self:SetEntryText(InitialText)
end

function u25:ClearHistoryState() -- Line: 190
    self.HistoryState = nil
end

function u25:SelectVertical(p2) -- Line: 194
    if self.AutoComplete:IsVisible() and not self.HistoryState then
        self.AutoComplete:Select(p2)
        return
    end
    self:TraverseHistory(p2)
end

local u63 = 0
local u64 = 0

function u25:BeginInput(p2, p3) -- Line: 205 -- upvalues: GuiService (val), u63 (ref), u64 (ref), u21 (val), Frame (val)
    if GuiService.MenuIsOpen then
        self:Hide()
    end
    if p3 and self:IsVisible() == false then
        return
    end
    if self.Cmdr.ActivationKeys[p2.KeyCode] then
        if self.Cmdr.MashToEnable and not self.Cmdr.Enabled then
            if not (tick() - u63 < 1) then
                u64 = 1
                u63 = tick()
                return
            end
            if 5 <= u64 then
                return self.Cmdr:SetEnabled(true)
            end
            u64 = u64 + 1
            u63 = tick()
            return
        end
        if self.Cmdr.Enabled then
            local v1 = self:IsVisible()
            self:SetVisible(not v1)
            wait()
            self:SetEntryText("")
            if GuiService.MenuIsOpen then
                self:Hide()
            end
        end
        return
    end
    if self.Cmdr.Enabled ~= false and self:IsVisible() then
        local Alias, EntryText_2, v2, v3, v4, v5
        if self.Cmdr.HideOnLostFocus and table.find(u21, p2.UserInputType) then
            local Position = p2.Position
            local AbsolutePosition = Frame.AbsolutePosition
            local AbsoluteSize = Frame.AbsoluteSize
            if not (Position.X < AbsolutePosition.X) then
                local X = Position.X
                if not (AbsolutePosition.X + AbsoluteSize.X < X) and not (Position.Y < AbsolutePosition.Y) then
                    local Y = Position.Y
                    if not (AbsolutePosition.Y + AbsoluteSize.Y < Y) then
                        return
                    end
                end
            end
            self:Hide()
            return
        end
        if p2.KeyCode == Enum.KeyCode.Down then
            self:SelectVertical(1)
            return
        end
        if p2.KeyCode == Enum.KeyCode.Up then
            self:SelectVertical(-1)
            return
        end
        if p2.KeyCode == Enum.KeyCode.Return then
            wait()
            v5 = (self:GetEntryText():gsub("\n", "")):gsub("\r", "")
            self:SetEntryText(v5)
            return
        end
        if p2.KeyCode ~= Enum.KeyCode.Tab then
            self:ClearHistoryState()
            return
        end
        local SelectedItem = self.AutoComplete:GetSelectedItem()
        local EntryText = self:GetEntryText()
        if not SelectedItem then
            wait()
            EntryText_2 = self:GetEntryText()
            self:SetEntryText(EntryText_2)
            return
        end
        local v6 = #EntryText
        local v7 = #EntryText
        if (EntryText:sub(v6, v7)):match("%s") and self.AutoComplete.LastItem then
            wait()
            EntryText_2 = self:GetEntryText()
            self:SetEntryText(EntryText_2)
            return
        end
        v5 = SelectedItem[2]
        v6 = true
        local Command = self.AutoComplete.Command
        if not Command then
            Alias = v5
        else
            local RawSegments, v8, v9
            local Arg = self.AutoComplete.Arg
            Alias = Command.Alias
            local v10 = false
            if self.AutoComplete.NumArgs ~= #Command.ArgumentDefinitions then
                v10 = self.AutoComplete.IsPartial == false
            end
            v6 = v10
            local Arguments = Command.Arguments
            v3 = #Arguments
            for i = 1, v3 do
                v8 = Arguments[i]
                RawSegments = v8.RawSegments
                if v8 == Arg then
                    RawSegments[#RawSegments] = v5
                end
                v9 = v8.Prefix .. table.concat(RawSegments, ",")
                if v9:find(" ") or v9 == "" then
                    v9 = ("%q"):format(v9)
                end
                Alias = ("%s %s"):format(Alias, v9)
                if v8 == Arg then
                    wait()
                    if not v6 then
                        v4 = ""
                    else
                        v4 = " "
                    end
                    v3 = Alias .. v4
                    v2:SetEntryText(v3)
                    return
                end
            end
        end
        wait()
        if not v6 then
            v4 = ""
        else
            v4 = " "
        end
        v3 = Alias .. v4
        v2:SetEntryText(v3)
        return
    end
    if self:IsVisible() then
        self:Hide()
    end
end

Entry.TextBox.FocusLost:Connect(function(p1) -- Line: 316 -- upvalues: u25 (val)
    return u25:LoseFocus(p1)
end)
UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 320 -- upvalues: u25 (val)
    return u25:BeginInput(p1, p2)
end)
;(Entry.TextBox:GetPropertyChangedSignal("Text")):Connect(function() -- Line: 324 -- upvalues: Frame (val), Entry (val), u25 (val)
    Frame.CanvasPosition = Vector2.new(0, Frame.AbsoluteCanvasSize.Y)
    if Entry.TextBox.Text:match("\t") then
        Entry.TextBox.Text = Entry.TextBox.Text:gsub("\t", "")
        return
    end
    if u25.OnTextChanged then
        return u25.OnTextChanged(Entry.TextBox.Text)
    end
end)
Frame.ChildAdded:Connect(function() -- Line: 336 -- upvalues: u25 (val)
    task.defer(u25.UpdateWindowHeight)
end)
return u25