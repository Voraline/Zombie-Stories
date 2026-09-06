local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local u21 = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch}
local u25 = {Valid = true}
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Cmdr = PlayerGui:WaitForChild("Cmdr")
local Frame = Cmdr:WaitForChild("Frame")
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
    local v1 = p3
    if not v1 then
        v1 = {}
    end
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
function u25:SetVisible(p2) -- Line: 76 -- upvalues: Frame (val), TextChatService (val), Entry (val), UserInputService (val)
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
    if self.PreviousChatWindowConfigurationEnabled == nil then
        PreviousChatWindowConfigurationEnabled = true
    else
        PreviousChatWindowConfigurationEnabled = self.PreviousChatWindowConfigurationEnabled
    end
    TextChatService.ChatWindowConfiguration.Enabled = PreviousChatWindowConfigurationEnabled
    if self.PreviousChatInputBarConfigurationEnabled == nil then
        PreviousChatInputBarConfigurationEnabled = true
    else
        PreviousChatInputBarConfigurationEnabled = self.PreviousChatInputBarConfigurationEnabled
    end
    TextChatService.ChatInputBarConfiguration.Enabled = PreviousChatInputBarConfigurationEnabled
    if self.PreviousChannelTabsConfigurationEnabled == nil then
        PreviousChannelTabsConfigurationEnabled = true
    else
        PreviousChannelTabsConfigurationEnabled = self.PreviousChannelTabsConfigurationEnabled
    end
    TextChatService.ChannelTabsConfiguration.Enabled = PreviousChannelTabsConfigurationEnabled
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
    end
    if not p2 or not self.Valid then
        if p2 then
            self:AddLine(self._errorText, Color3.fromRGB(255, 153, 153))
        end
        return
    end
    wait()
    self:SetEntryText("")
    self.ProcessEntry(Text)
end
function u25:TraverseHistory(p2) -- Line: 172
    local InitialText
    local History = self.Cmdr.Dispatcher:GetHistory()
    if self.HistoryState == nil then
        self.HistoryState = {Position = #History + 1, InitialText = self:GetEntryText()}
    end
    self.HistoryState.Position = math.clamp(self.HistoryState.Position + p2, 1, #History + 1)
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
    if not (self.AutoComplete:IsVisible()) then
        self:TraverseHistory(p2)
        return
    end
    if not self.HistoryState then
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
    if not p3 then
        if self.Cmdr.ActivationKeys[p2.KeyCode] then
            if not self.Cmdr.MashToEnable or self.Cmdr.Enabled then
                if self.Cmdr.Enabled then
                    self:SetVisible(not self:IsVisible())
                    wait()
                    self:SetEntryText("")
                    if GuiService.MenuIsOpen then
                        self:Hide()
                    end
                end
                return
            end
            local v1 = tick() - u63
            if v1 >= 1 then
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
        if self.Cmdr.Enabled == false then
            if self:IsVisible() then
                self:Hide()
            end
            return
        else
            if not (self:IsVisible()) then
                if self:IsVisible() then
                    self:Hide()
                end
                return
            end
            if not self.Cmdr.HideOnLostFocus then
                local v2
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
                    v2 = self:GetEntryText():gsub("\n", "")
                    self:SetEntryText(v2:gsub("\r", ""))
                    return
                end
                if p2.KeyCode ~= Enum.KeyCode.Tab then
                    self:ClearHistoryState()
                    return
                else
                    local SelectedItem = self.AutoComplete:GetSelectedItem()
                    local EntryText = self:GetEntryText()
                    if not SelectedItem then
                        wait()
                        self:SetEntryText(self:GetEntryText())
                        return
                    else
                        local v3 = #EntryText
                        v2 = EntryText:sub(v3, #EntryText)
                        if not (v2:match("%s")) then
                            local Alias, v4, v5
                            v2 = SelectedItem[2]
                            v3 = true
                            local Command = self.AutoComplete.Command
                            if not Command then
                                Alias = v2
                            else
                                local RawSegments, v6, v7
                                local Arg = self.AutoComplete.Arg
                                Alias = Command.Alias
                                local v8 = if self.AutoComplete.NumArgs ~= #Command.ArgumentDefinitions then self.AutoComplete.IsPartial == false else false
                                v3 = v8
                                local Arguments = Command.Arguments
                                local v9 = #Arguments
                                local v10 = 1
                                for i = 1, v9, v10 do
                                    v6 = Arguments[i]
                                    RawSegments = v6.RawSegments
                                    if v6 == Arg then
                                        RawSegments[#RawSegments] = v2
                                    end
                                    v7 = v6.Prefix .. table.concat(RawSegments, ",")
                                    if v7:find(" ") then
                                        v7 = ("%q"):format(v7)
                                    elseif v7 ~= "" then
                                    end
                                    Alias = ("%s %s"):format(Alias, v7)
                                    if v6 == Arg then
                                        wait()
                                        if not v3 then
                                            v5 = ""
                                        else
                                            v5 = " "
                                        end
                                        v4:SetEntryText(Alias .. v5)
                                        return
                                    end
                                end
                            end
                            wait()
                            if not v3 then
                                v5 = ""
                            else
                                v5 = " "
                            end
                            v4:SetEntryText(Alias .. v5)
                            return
                        elseif self.AutoComplete.LastItem then
                            wait()
                            self:SetEntryText(self:GetEntryText())
                            return
                        end
                    end
                end
            elseif table.find(u21, p2.UserInputType) then
                local Position = p2.Position
                local AbsolutePosition = Frame.AbsolutePosition
                local AbsoluteSize = Frame.AbsoluteSize
                if Position.X < AbsolutePosition.X or AbsolutePosition.X + AbsoluteSize.X < Position.X or Position.Y < AbsolutePosition.Y then
                    self:Hide()
                    return
                end
                if AbsolutePosition.Y + AbsoluteSize.Y >= Position.Y then
                    return
                end
                self:Hide()
                return
            end
        end
    elseif self:IsVisible() == false then
        return
    end
end
Entry.TextBox.FocusLost:Connect(function(p1) -- Line: 316 -- upvalues: u25 (val)
    return u25:LoseFocus(p1)
end)
UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 320 -- upvalues: u25 (val)
    return u25:BeginInput(p1, p2)
end)
local PropertyChangedSignal = Entry.TextBox:GetPropertyChangedSignal("Text")
PropertyChangedSignal:Connect(function() -- Line: 324 -- upvalues: Frame (val), Entry (val), u25 (val)
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