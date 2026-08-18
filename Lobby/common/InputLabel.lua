local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("UserInputService")
local _ = game.ReplicatedStorage.common
local v_u_3 = {}
local v_u_4 = "MouseKeyboard"
local v_u_5 = {}
local v_u_6 = true
local v_u_7 = {
	[Enum.KeyCode.Unknown] = "rbxassetid://4436536648",
	[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
	[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
	[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
	[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
	[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
	[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
	[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
	[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
	[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
	[Enum.KeyCode.ButtonStart] = "rbxasset://textures/ui/Controls/xboxView.png",
	[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLB.png",
	[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRB.png",
	[Enum.KeyCode.ButtonL2] = "rbxasset://textures/ui/Controls/xboxLT.png",
	[Enum.KeyCode.ButtonR2] = "rbxasset://textures/ui/Controls/xboxRT.png",
	[Enum.KeyCode.ButtonL3] = "rbxasset://textures/ui/Controls/xboxLS.png",
	[Enum.KeyCode.ButtonR3] = "rbxasset://textures/ui/Controls/xboxRS.png",
	[Enum.KeyCode.Thumbstick1] = "rbxasset://textures/ui/Controls/xboxLSDirectional.png",
	[Enum.KeyCode.Thumbstick2] = "rbxasset://textures/ui/Controls/xboxRSDirectional.png",
	[Enum.UserInputType.Touch] = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
}
local v_u_8 = {
	[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
	[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
	[Enum.KeyCode.KeypadEnter] = "rbxasset://textures/ui/Controls/return.png",
	[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
	[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png",
	[Enum.KeyCode.Quote] = "rbxasset://textures/ui/Controls/apostrophe.png",
	[Enum.KeyCode.Comma] = "rbxasset://textures/ui/Controls/comma.png",
	[Enum.KeyCode.Backquote] = "rbxasset://textures/ui/Controls/graveaccent.png",
	[Enum.KeyCode.Period] = "rbxasset://textures/ui/Controls/period.png",
	[Enum.KeyCode.Space] = "rbxasset://textures/ui/Controls/spacebar.png"
}
local v_u_9 = {
	[Enum.KeyCode.Escape] = "Esc",
	[Enum.KeyCode.QuotedDouble] = "\"",
	[Enum.KeyCode.Hash] = "#",
	[Enum.KeyCode.Dollar] = "$",
	[Enum.KeyCode.Percent] = "%",
	[Enum.KeyCode.Ampersand] = "&",
	[Enum.KeyCode.LeftParenthesis] = "(",
	[Enum.KeyCode.RightParenthesis] = ")",
	[Enum.KeyCode.Asterisk] = "*",
	[Enum.KeyCode.Plus] = "+",
	[Enum.KeyCode.Comma] = ",",
	[Enum.KeyCode.Minus] = "-",
	[Enum.KeyCode.Period] = ".",
	[Enum.KeyCode.Slash] = "/",
	[Enum.KeyCode.Zero] = "0",
	[Enum.KeyCode.One] = "1",
	[Enum.KeyCode.Two] = "2",
	[Enum.KeyCode.Three] = "3",
	[Enum.KeyCode.Four] = "4",
	[Enum.KeyCode.Five] = "5",
	[Enum.KeyCode.Six] = "6",
	[Enum.KeyCode.Seven] = "7",
	[Enum.KeyCode.Eight] = "8",
	[Enum.KeyCode.Nine] = "9",
	[Enum.KeyCode.Colon] = ":",
	[Enum.KeyCode.Semicolon] = ";",
	[Enum.KeyCode.LessThan] = "<",
	[Enum.KeyCode.Equals] = "=",
	[Enum.KeyCode.GreaterThan] = ">",
	[Enum.KeyCode.Question] = "?",
	[Enum.KeyCode.At] = "@",
	[Enum.KeyCode.LeftBracket] = "[",
	[Enum.KeyCode.BackSlash] = "\\",
	[Enum.KeyCode.RightBracket] = "]",
	[Enum.KeyCode.Caret] = "^",
	[Enum.KeyCode.Underscore] = "_",
	[Enum.KeyCode.Backquote] = "`",
	[Enum.KeyCode.LeftCurly] = "{",
	[Enum.KeyCode.Pipe] = "|",
	[Enum.KeyCode.RightCurly] = "}",
	[Enum.KeyCode.Tilde] = "~",
	[Enum.KeyCode.Delete] = "Del",
	[Enum.KeyCode.KeypadZero] = "NP0",
	[Enum.KeyCode.KeypadOne] = "NP1",
	[Enum.KeyCode.KeypadTwo] = "NP2",
	[Enum.KeyCode.KeypadThree] = "NP3",
	[Enum.KeyCode.KeypadFour] = "NP4",
	[Enum.KeyCode.KeypadFive] = "NP5",
	[Enum.KeyCode.KeypadSix] = "NP6",
	[Enum.KeyCode.KeypadSeven] = "NP7",
	[Enum.KeyCode.KeypadEight] = "NP8",
	[Enum.KeyCode.KeypadNine] = "NP9",
	[Enum.KeyCode.KeypadPeriod] = ".",
	[Enum.KeyCode.KeypadDivide] = "/",
	[Enum.KeyCode.KeypadMultiply] = "*",
	[Enum.KeyCode.KeypadMinus] = "-",
	[Enum.KeyCode.KeypadPlus] = "+",
	[Enum.KeyCode.KeypadEnter] = "Ent",
	[Enum.KeyCode.KeypadEquals] = "=",
	[Enum.KeyCode.Up] = "\226\134\145",
	[Enum.KeyCode.Down] = "\226\134\147",
	[Enum.KeyCode.Right] = "\226\134\146",
	[Enum.KeyCode.Left] = "\226\134\144",
	[Enum.KeyCode.Insert] = "Ins",
	[Enum.KeyCode.Home] = "Hm",
	[Enum.KeyCode.End] = "End",
	[Enum.KeyCode.PageUp] = "PgU",
	[Enum.KeyCode.PageDown] = "PgD",
	[Enum.KeyCode.LeftShift] = "Sh",
	[Enum.KeyCode.RightShift] = "Sh",
	[Enum.KeyCode.LeftMeta] = "Me",
	[Enum.KeyCode.RightMeta] = "Me",
	[Enum.KeyCode.LeftAlt] = "Alt",
	[Enum.KeyCode.RightAlt] = "Alt",
	[Enum.KeyCode.LeftControl] = "Ctrl",
	[Enum.KeyCode.RightControl] = "Ctrl",
	[Enum.KeyCode.CapsLock] = "Caps",
	[Enum.KeyCode.NumLock] = "NL",
	[Enum.KeyCode.ScrollLock] = "SL",
	[Enum.KeyCode.LeftSuper] = "Sup",
	[Enum.KeyCode.RightSuper] = "Sup",
	[Enum.UserInputType.MouseButton1] = "M1",
	[Enum.UserInputType.MouseButton2] = "M2",
	[Enum.UserInputType.MouseButton3] = "M3"
}
local v_u_10 = { "", "@2x", "@3x" }
local v_u_11 = {}
v_u_11.__index = v_u_11
function v_u_11.new(p12, p13, p14, p15) -- name: new
	-- upvalues: (copy) v_u_11, (copy) v_u_3
	local v16 = {}
	local v17 = v_u_11
	setmetatable(v16, v17)
	local v18
	if typeof(p12) == "EnumItem" then
		v18 = nil
	else
		v18 = p12
		p12 = nil
	end
	if v18 then
		p12 = getActionInputDeviceCode(v18)
	end
	local v19 = p13 == nil and 3 or p13
	if p14 == nil then
		p14 = Color3.new(1, 1, 1)
	end
	local v20 = (v19 == 1 or v19 == 2) and true or v19 == 3
	assert(v20, "Icon size must be 1, 2, or 3 (SMALL, MEDIUM, or LARGE)")
	local v21, v22 = createInputImage(p12, p14, v19)
	v16.Type = v22
	v16.UIObject = v21
	v16.IconSize = v19
	v16.Color = p14
	v16.ActionName = v18
	v16.Transparency = 0
	v16.AutoUpdate = p15 or true or true
	local v23 = v_u_3
	table.insert(v23, v16)
	return v16
end
function v_u_11.SetInputMethod(p24) -- name: SetInputMethod
	-- upvalues: (ref) v_u_4, (copy) v_u_3
	v_u_4 = p24
	for _, v25 in v_u_3 do
		if v25.AutoUpdate and v25.ActionName then
			v25:_ChangeInput((getActionInputDeviceCode(v25.ActionName)))
		end
	end
end
function v_u_11.SetUseNativeControllerImages(p26) -- name: SetUseNativeControllerImages
	-- upvalues: (ref) v_u_6, (copy) v_u_3
	v_u_6 = p26
	for _, v27 in v_u_3 do
		if v27.AutoUpdate and v27.ActionName then
			v27:_ChangeInput((getActionInputDeviceCode(v27.ActionName)))
		end
	end
end
function v_u_11.GetUseNativeControllerImages() -- name: GetUseNativeControllerImages
	-- upvalues: (ref) v_u_6
	return v_u_6
end
function v_u_11.UpdateBind(p28, p29) -- name: UpdateBind
	-- upvalues: (copy) v_u_5, (copy) v_u_3
	v_u_5[p28] = p29
	for _, v30 in v_u_3 do
		if v30.AutoUpdate and v30.ActionName == p28 then
			v30:_ChangeInput((getActionInputDeviceCode(v30.ActionName)))
		end
	end
end
function v_u_11.Destroy(p31) -- name: Destroy
	-- upvalues: (copy) v_u_3
	if p31.UpdateConnection then
		p31.UpdateConnection:Disconnect()
	end
	p31.UIObject:Destroy()
	local v32 = table.find(v_u_3, p31)
	if v32 then
		table.remove(v_u_3, v32)
	end
end
function v_u_11.SetColor(p33, p34) -- name: SetColor
	p33.Color = p34
	if p33.Type == "UniqueImage" then
		p33.UIObject.ImageColor3 = p34
		return
	elseif p33.Type == "KeyWithText" then
		p33.UIObject.OutlineImageLabel.ImageColor3 = p34
		p33.UIObject.KeyTextLabel.TextColor3 = p34
	elseif p33.Type == "KeyWithImage" then
		p33.UIObject.OutlineImageLabel.ImageColor3 = p34
		p33.UIObject.KeyImageLabel.ImageColor3 = p34
	end
end
function v_u_11.SetTransparency(p35, p36) -- name: SetTransparency
	p35.Transparency = p36
	if p35.Type == "UniqueImage" then
		p35.UIObject.ImageTransparency = p36
		return
	elseif p35.Type == "KeyWithText" then
		p35.UIObject.OutlineImageLabel.ImageTransparency = p36
		p35.UIObject.KeyTextLabel.TextTransparency = p36
	elseif p35.Type == "KeyWithImage" then
		p35.UIObject.OutlineImageLabel.ImageTransparency = p36
		p35.UIObject.KeyImageLabel.ImageTransparency = p36
	end
end
function v_u_11.TweenTransparency(p37, p38, p39) -- name: TweenTransparency
	-- upvalues: (copy) v_u_1
	local v40 = {}
	if p37.Type == "UniqueImage" then
		local v41 = p37.UIObject
		table.insert(v40, v41)
	elseif p37.Type == "KeyWithText" then
		local v42 = p37.UIObject.OutlineImageLabel
		table.insert(v40, v42)
		local v43 = p37.UIObject.KeyTextLabel
		table.insert(v40, v43)
	elseif p37.Type == "KeyWithImage" then
		local v44 = p37.UIObject.OutlineImageLabel
		table.insert(v40, v44)
		local v45 = p37.UIObject.KeyImageLabel
		table.insert(v40, v45)
	end
	local v46 = {}
	for _, v47 in v40 do
		local v48
		if v47:IsA("ImageLabel") then
			v48 = {
				["ImageTransparency"] = p38
			}
		else
			v48 = {
				["TextTransparency"] = p38
			}
		end
		local v49 = v_u_1:Create(v47, p39, v48)
		v49:Play()
		table.insert(v46, v49)
	end
	return v46
end
function v_u_11._ChangeInput(p50, p51) -- name: _ChangeInput
	local v52 = p50.IconSize
	local v53 = p50.Color
	local v54, v55 = createInputImage(p51, v53, v52)
	local v56 = p50.UIObject
	v56.BackgroundTransparency = 0.5
	local v57 = v56.Size
	local v58 = v56.Position
	local v59 = v56.AnchorPoint
	local v60 = v56.SizeConstraint
	local v61 = v56.AutomaticSize
	local v62 = v56.Visible
	v54.Size = v57
	v54.Position = v58
	v54.AnchorPoint = v59
	v54.SizeConstraint = v60
	v54.AutomaticSize = v61
	v54.Visible = v62
	v54.Parent = v56.Parent
	p50.Type = v55
	p50.UIObject = v54
	p50:SetTransparency(p50.Transparency)
	v56:Destroy()
end
function addSizeSuffix(p63, p64) -- name: addSizeSuffix
	-- upvalues: (copy) v_u_10
	local v65 = #p63 - 3
	local v66 = #p63
	if string.sub(p63, v65, v66) ~= ".png" then
		return p63
	end
	local v67 = #p63 - 4
	local v68 = string.sub(p63, 1, v67)
	local v69 = #p63 - 3
	local v70 = string.sub(p63, v69)
	return v68 .. v_u_10[p64] .. v70
end
function createInputImage(p71, p72, p73) -- name: createInputImage
	-- upvalues: (copy) v_u_7, (ref) v_u_6, (copy) v_u_2, (copy) v_u_8, (copy) v_u_9
	local v74 = v_u_7[p71]
	if v74 then
		local v75 = Instance.new("ImageLabel")
		v75.Name = "InputLabel"
		v75.BackgroundTransparency = 1
		v75.ImageColor3 = p72
		v75.ScaleType = Enum.ScaleType.Fit
		local v76 = false
		local v77
		if v_u_6 and (typeof(p71) == "EnumItem" and p71.EnumType == Enum.KeyCode) then
			v77 = v_u_2:GetImageForKeyCode(p71)
			if v77 and v77 ~= "" then
				v76 = true
			else
				v77 = v74
			end
		else
			v77 = v74
		end
		if not v76 then
			v77 = addSizeSuffix(v77, p73)
		end
		v75.Image = v77
		return v75, "UniqueImage"
	end
	local v78 = Instance.new("Frame")
	v78.Name = "InputLabel"
	v78.BackgroundTransparency = 1
	local v79 = Instance.new("ImageLabel")
	v79.Name = "OutlineImageLabel"
	v79.BackgroundTransparency = 1
	v79.Image = addSizeSuffix("rbxasset://textures/ui/Controls/key_single.png", p73)
	v79.ImageColor3 = p72
	v79.Size = UDim2.new(1, 0, 1, 0)
	v79.Parent = v78
	local v80 = v_u_8[p71]
	local v81
	if v80 then
		local v82 = Instance.new("ImageLabel")
		v82.Name = "KeyImageLabel"
		v82.BackgroundTransparency = 1
		v82.Image = addSizeSuffix(v80, p73)
		v82.ImageColor3 = p72
		v82.Size = UDim2.new(1, 0, 1, 0)
		v82.Parent = v79
		v81 = "KeyWithImage"
	else
		local v83 = v_u_9[p71]
		if v83 == nil then
			v83 = p71.Name
		end
		local v84 = Instance.new("TextLabel")
		v84.Name = "KeyTextLabel"
		v84.BackgroundTransparency = 1
		v84.FontFace = Font.new("SourceSansPro", Enum.FontWeight.Bold)
		v84.Text = v83
		v84.TextColor3 = p72
		v84.TextScaled = true
		v84.Size = UDim2.new(0.8, 0, 0.8, 0)
		v84.Position = UDim2.new(0.5, 0, 0.45, 0)
		v84.AnchorPoint = Vector2.new(0.5, 0.5)
		v84.Parent = v78
		v81 = "KeyWithText"
	end
	return v78, v81
end
function getActionInputDeviceCode(p85) -- name: getActionInputDeviceCode
	-- upvalues: (copy) v_u_5, (ref) v_u_4
	local v86 = nil
	local v87 = v_u_5[p85]
	if v87 then
		if v_u_4 == "MouseKeyboard" then
			if v87.Mouse then
				v86 = v87.Mouse
			else
				v86 = nil
			end
			if not v86 then
				if v87.Keyboard then
					v86 = v87.Keyboard
				else
					v86 = nil
				end
			end
		elseif v_u_4 == "Gamepad" then
			if v87.Gamepad then
				v86 = v87.Gamepad
			else
				v86 = nil
			end
		elseif v_u_4 == "Touch" then
			v86 = Enum.UserInputType.Touch
		end
	end
	return v86 or Enum.KeyCode.Unknown
end
return v_u_11