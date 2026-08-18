local v_u_1 = game:GetService("GuiService")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("TextChatService")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch }
local v_u_6 = {
	["Valid"] = true,
	["AutoComplete"] = nil,
	["ProcessEntry"] = nil,
	["OnTextChanged"] = nil,
	["Cmdr"] = nil,
	["HistoryState"] = nil
}
local v_u_7 = v_u_4:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame")
local v_u_8 = v_u_7:WaitForChild("Line")
local v_u_9 = v_u_7:WaitForChild("Entry")
v_u_8.Parent = nil
function v_u_6.UpdateLabel(p10) -- name: UpdateLabel
	-- upvalues: (copy) v_u_9, (copy) v_u_4
	v_u_9.TextLabel.Text = v_u_4.Name .. "@" .. p10.Cmdr.PlaceName .. "$"
end
function v_u_6.GetLabel(_) -- name: GetLabel
	-- upvalues: (copy) v_u_9
	return v_u_9.TextLabel.Text
end
function v_u_6.UpdateWindowHeight(_) -- name: UpdateWindowHeight
	-- upvalues: (copy) v_u_7
	local v11 = v_u_7.UIListLayout.AbsoluteContentSize.Y + v_u_7.UIPadding.PaddingTop.Offset + v_u_7.UIPadding.PaddingBottom.Offset
	v_u_7.Size = UDim2.new(v_u_7.Size.X.Scale, v_u_7.Size.X.Offset, 0, (math.clamp(v11, 0, 300)))
	v_u_7.CanvasPosition = Vector2.new(0, v11)
end
function v_u_6.AddLine(p12, p13, p14) -- name: AddLine
	-- upvalues: (copy) v_u_6, (copy) v_u_8, (copy) v_u_7
	local v15 = p14 or {}
	local v16 = tostring(p13)
	local v17 = typeof(v15) == "Color3" and {
		["Color"] = v15
	} or v15
	if #v16 == 0 then
		v_u_6:UpdateWindowHeight()
	else
		local v18 = p12.Cmdr.Util.EmulateTabstops(v16 or "nil", 8)
		local v19 = v_u_8:Clone()
		v19.Text = v18
		v19.TextColor3 = v17.Color or v19.TextColor3
		v19.RichText = v17.RichText or false
		v19.Parent = v_u_7
	end
end
function v_u_6.IsVisible(_) -- name: IsVisible
	-- upvalues: (copy) v_u_7
	return v_u_7.Visible
end
function v_u_6.SetVisible(p20, p21) -- name: SetVisible
	-- upvalues: (copy) v_u_7, (copy) v_u_3, (copy) v_u_9, (copy) v_u_2
	v_u_7.Visible = p21
	if p21 then
		p20.PreviousChatWindowConfigurationEnabled = v_u_3.ChatWindowConfiguration.Enabled
		p20.PreviousChatInputBarConfigurationEnabled = v_u_3.ChatInputBarConfiguration.Enabled
		p20.PreviousChannelTabsConfigurationEnabled = v_u_3.ChannelTabsConfiguration.Enabled
		v_u_3.ChatWindowConfiguration.Enabled = false
		v_u_3.ChatInputBarConfiguration.Enabled = false
		v_u_3.ChannelTabsConfiguration.Enabled = false
		v_u_9.TextBox:CaptureFocus()
		p20:SetEntryText("")
		if p20.Cmdr.ActivationUnlocksMouse then
			p20.PreviousMouseBehavior = v_u_2.MouseBehavior
			v_u_2.MouseBehavior = Enum.MouseBehavior.Default
			return
		end
	else
		v_u_3.ChatWindowConfiguration.Enabled = p20.PreviousChatWindowConfigurationEnabled == nil and true or p20.PreviousChatWindowConfigurationEnabled
		v_u_3.ChatInputBarConfiguration.Enabled = p20.PreviousChatInputBarConfigurationEnabled == nil and true or p20.PreviousChatInputBarConfigurationEnabled
		v_u_3.ChannelTabsConfiguration.Enabled = p20.PreviousChannelTabsConfigurationEnabled == nil and true or p20.PreviousChannelTabsConfigurationEnabled
		v_u_9.TextBox:ReleaseFocus()
		p20.AutoComplete:Hide()
		if p20.PreviousMouseBehavior then
			v_u_2.MouseBehavior = p20.PreviousMouseBehavior
			p20.PreviousMouseBehavior = nil
		end
	end
end
function v_u_6.Hide(p22) -- name: Hide
	return p22:SetVisible(false)
end
function v_u_6.Show(p23) -- name: Show
	return p23:SetVisible(true)
end
function v_u_6.SetEntryText(p24, p25) -- name: SetEntryText
	-- upvalues: (copy) v_u_9, (copy) v_u_6
	v_u_9.TextBox.Text = p25
	if p24:IsVisible() then
		v_u_9.TextBox:CaptureFocus()
		v_u_9.TextBox.CursorPosition = #p25 + 1
		v_u_6:UpdateWindowHeight()
	end
end
function v_u_6.GetEntryText(_) -- name: GetEntryText
	-- upvalues: (copy) v_u_9
	return v_u_9.TextBox.Text:gsub("\t", "")
end
function v_u_6.SetIsValidInput(p26, p27, p28) -- name: SetIsValidInput
	-- upvalues: (copy) v_u_9
	v_u_9.TextBox.TextColor3 = p27 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73)
	p26.Valid = p27
	p26._errorText = p28
end
function v_u_6.HideInvalidState(_) -- name: HideInvalidState
	-- upvalues: (copy) v_u_9
	v_u_9.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
end
function v_u_6.LoseFocus(p29, p30) -- name: LoseFocus
	-- upvalues: (copy) v_u_9, (copy) v_u_7, (copy) v_u_1
	local v31 = v_u_9.TextBox.Text
	p29:ClearHistoryState()
	if v_u_7.Visible and not v_u_1.MenuIsOpen then
		v_u_9.TextBox:CaptureFocus()
	elseif v_u_1.MenuIsOpen and v_u_7.Visible then
		p29:Hide()
	end
	if p30 and p29.Valid then
		wait()
		p29:SetEntryText("")
		p29.ProcessEntry(v31)
	elseif p30 then
		p29:AddLine(p29._errorText, Color3.fromRGB(255, 153, 153))
	end
end
function v_u_6.TraverseHistory(p32, p33) -- name: TraverseHistory
	local v34 = p32.Cmdr.Dispatcher:GetHistory()
	if p32.HistoryState == nil then
		p32.HistoryState = {
			["Position"] = #v34 + 1,
			["InitialText"] = p32:GetEntryText()
		}
	end
	local v35 = p32.HistoryState
	local v36 = p32.HistoryState.Position + p33
	local v37 = #v34 + 1
	v35.Position = math.clamp(v36, 1, v37)
	p32:SetEntryText(p32.HistoryState.Position == #v34 + 1 and p32.HistoryState.InitialText or v34[p32.HistoryState.Position])
end
function v_u_6.ClearHistoryState(p38) -- name: ClearHistoryState
	p38.HistoryState = nil
end
function v_u_6.SelectVertical(p39, p40) -- name: SelectVertical
	if p39.AutoComplete:IsVisible() and not p39.HistoryState then
		p39.AutoComplete:Select(p40)
	else
		p39:TraverseHistory(p40)
	end
end
local v_u_41 = 0
local v_u_42 = 0
function v_u_6.BeginInput(p43, p44, p45) -- name: BeginInput
	-- upvalues: (copy) v_u_1, (ref) v_u_41, (ref) v_u_42, (copy) v_u_5, (copy) v_u_7
	if v_u_1.MenuIsOpen then
		p43:Hide()
	end
	if p45 and p43:IsVisible() == false then
		return
	elseif p43.Cmdr.ActivationKeys[p44.KeyCode] then
		if p43.Cmdr.MashToEnable and not p43.Cmdr.Enabled then
			if tick() - v_u_41 < 1 then
				if v_u_42 >= 5 then
					return p43.Cmdr:SetEnabled(true)
				end
				v_u_42 = v_u_42 + 1
			else
				v_u_42 = 1
			end
			v_u_41 = tick()
		elseif p43.Cmdr.Enabled then
			p43:SetVisible(not p43:IsVisible())
			wait()
			p43:SetEntryText("")
			if v_u_1.MenuIsOpen then
				p43:Hide()
			end
		end
	elseif p43.Cmdr.Enabled == false or not p43:IsVisible() then
		if p43:IsVisible() then
			p43:Hide()
		end
	elseif p43.Cmdr.HideOnLostFocus and table.find(v_u_5, p44.UserInputType) then
		local v46 = p44.Position
		local v47 = v_u_7.AbsolutePosition
		local v48 = v_u_7.AbsoluteSize
		if v46.X < v47.X or (v46.X > v47.X + v48.X or (v46.Y < v47.Y or v46.Y > v47.Y + v48.Y)) then
			p43:Hide()
			return
		end
	else
		if p44.KeyCode == Enum.KeyCode.Down then
			p43:SelectVertical(1)
			return
		end
		if p44.KeyCode == Enum.KeyCode.Up then
			p43:SelectVertical(-1)
			return
		end
		if p44.KeyCode == Enum.KeyCode.Return then
			wait()
			p43:SetEntryText(p43:GetEntryText():gsub("\n", ""):gsub("\r", ""))
			return
		end
		if p44.KeyCode == Enum.KeyCode.Tab then
			local v49 = p43.AutoComplete:GetSelectedItem()
			local v50 = p43:GetEntryText()
			if v49 and not (v50:sub(#v50, #v50):match("%s") and p43.AutoComplete.LastItem) then
				local v51 = v49[2]
				local v52 = p43.AutoComplete.Command
				local v53, v54
				if v52 then
					local v55 = p43.AutoComplete.Arg
					v53 = v52.Alias
					if p43.AutoComplete.NumArgs == #v52.ArgumentDefinitions then
						v54 = false
					else
						v54 = p43.AutoComplete.IsPartial == false
					end
					local v56 = v52.Arguments
					for v57 = 1, #v56 do
						local v58 = v56[v57]
						local v59 = v58.RawSegments
						if v58 == v55 then
							v59[#v59] = v51
						end
						local v60 = v58.Prefix .. table.concat(v59, ",")
						if v60:find(" ") or v60 == "" then
							v60 = ("%q"):format(v60)
						end
						v53 = ("%s %s"):format(v53, v60)
						if v58 == v55 then
							break
						end
					end
				else
					v53 = v51
					v54 = true
				end
				wait()
				p43:SetEntryText(v53 .. (v54 and " " or ""))
			else
				wait()
				p43:SetEntryText(p43:GetEntryText())
			end
		end
		p43:ClearHistoryState()
	end
end
v_u_9.TextBox.FocusLost:Connect(function(p61)
	-- upvalues: (copy) v_u_6
	return v_u_6:LoseFocus(p61)
end)
v_u_2.InputBegan:Connect(function(p62, p63)
	-- upvalues: (copy) v_u_6
	return v_u_6:BeginInput(p62, p63)
end)
v_u_9.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_9, (copy) v_u_6
	v_u_7.CanvasPosition = Vector2.new(0, v_u_7.AbsoluteCanvasSize.Y)
	if v_u_9.TextBox.Text:match("\t") then
		v_u_9.TextBox.Text = v_u_9.TextBox.Text:gsub("\t", "")
	elseif v_u_6.OnTextChanged then
		return v_u_6.OnTextChanged(v_u_9.TextBox.Text)
	end
end)
v_u_7.ChildAdded:Connect(function()
	-- upvalues: (copy) v_u_6
	task.defer(v_u_6.UpdateWindowHeight)
end)
return v_u_6