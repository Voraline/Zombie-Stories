local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local u13 = {}
local u14 = "MouseKeyboard"
local u15 = {}
local u16 = true
local u17 = {}
u17[Enum.KeyCode.Unknown] = "rbxassetid://4436536648"
u17[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png"
u17[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png"
u17[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png"
u17[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png"
u17[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png"
u17[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png"
u17[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png"
u17[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png"
u17[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png"
u17[Enum.KeyCode.ButtonStart] = "rbxasset://textures/ui/Controls/xboxView.png"
u17[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLB.png"
u17[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRB.png"
u17[Enum.KeyCode.ButtonL2] = "rbxasset://textures/ui/Controls/xboxLT.png"
u17[Enum.KeyCode.ButtonR2] = "rbxasset://textures/ui/Controls/xboxRT.png"
u17[Enum.KeyCode.ButtonL3] = "rbxasset://textures/ui/Controls/xboxLS.png"
u17[Enum.KeyCode.ButtonR3] = "rbxasset://textures/ui/Controls/xboxRS.png"
u17[Enum.KeyCode.Thumbstick1] = "rbxasset://textures/ui/Controls/xboxLSDirectional.png"
u17[Enum.KeyCode.Thumbstick2] = "rbxasset://textures/ui/Controls/xboxRSDirectional.png"
u17[Enum.UserInputType.Touch] = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
local u58 = {}
u58[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png"
u58[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png"
u58[Enum.KeyCode.KeypadEnter] = "rbxasset://textures/ui/Controls/return.png"
u58[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png"
u58[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png"
u58[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
u58[Enum.KeyCode.Quote] = "rbxasset://textures/ui/Controls/apostrophe.png"
u58[Enum.KeyCode.Comma] = "rbxasset://textures/ui/Controls/comma.png"
u58[Enum.KeyCode.Backquote] = "rbxasset://textures/ui/Controls/graveaccent.png"
u58[Enum.KeyCode.Period] = "rbxasset://textures/ui/Controls/period.png"
u58[Enum.KeyCode.Space] = "rbxasset://textures/ui/Controls/spacebar.png"
local u81 = {}
u81[Enum.KeyCode.Escape] = "Esc"
u81[Enum.KeyCode.QuotedDouble] = "\""
u81[Enum.KeyCode.Hash] = "#"
u81[Enum.KeyCode.Dollar] = "$"
u81[Enum.KeyCode.Percent] = "%"
u81[Enum.KeyCode.Ampersand] = "&"
u81[Enum.KeyCode.LeftParenthesis] = "("
u81[Enum.KeyCode.RightParenthesis] = ")"
u81[Enum.KeyCode.Asterisk] = "*"
u81[Enum.KeyCode.Plus] = "+"
u81[Enum.KeyCode.Comma] = ","
u81[Enum.KeyCode.Minus] = "-"
u81[Enum.KeyCode.Period] = "."
u81[Enum.KeyCode.Slash] = "/"
u81[Enum.KeyCode.Zero] = "0"
u81[Enum.KeyCode.One] = "1"
u81[Enum.KeyCode.Two] = "2"
u81[Enum.KeyCode.Three] = "3"
u81[Enum.KeyCode.Four] = "4"
u81[Enum.KeyCode.Five] = "5"
u81[Enum.KeyCode.Six] = "6"
u81[Enum.KeyCode.Seven] = "7"
u81[Enum.KeyCode.Eight] = "8"
u81[Enum.KeyCode.Nine] = "9"
u81[Enum.KeyCode.Colon] = ":"
u81[Enum.KeyCode.Semicolon] = ";"
u81[Enum.KeyCode.LessThan] = "<"
u81[Enum.KeyCode.Equals] = "="
u81[Enum.KeyCode.GreaterThan] = ">"
u81[Enum.KeyCode.Question] = "?"
u81[Enum.KeyCode.At] = "@"
u81[Enum.KeyCode.LeftBracket] = "["
u81[Enum.KeyCode.BackSlash] = "\\"
u81[Enum.KeyCode.RightBracket] = "]"
u81[Enum.KeyCode.Caret] = "^"
u81[Enum.KeyCode.Underscore] = "_"
u81[Enum.KeyCode.Backquote] = "`"
u81[Enum.KeyCode.LeftCurly] = "{"
u81[Enum.KeyCode.Pipe] = "|"
u81[Enum.KeyCode.RightCurly] = "}"
u81[Enum.KeyCode.Tilde] = "~"
u81[Enum.KeyCode.Delete] = "Del"
u81[Enum.KeyCode.KeypadZero] = "NP0"
u81[Enum.KeyCode.KeypadOne] = "NP1"
u81[Enum.KeyCode.KeypadTwo] = "NP2"
u81[Enum.KeyCode.KeypadThree] = "NP3"
u81[Enum.KeyCode.KeypadFour] = "NP4"
u81[Enum.KeyCode.KeypadFive] = "NP5"
u81[Enum.KeyCode.KeypadSix] = "NP6"
u81[Enum.KeyCode.KeypadSeven] = "NP7"
u81[Enum.KeyCode.KeypadEight] = "NP8"
u81[Enum.KeyCode.KeypadNine] = "NP9"
u81[Enum.KeyCode.KeypadPeriod] = "."
u81[Enum.KeyCode.KeypadDivide] = "/"
u81[Enum.KeyCode.KeypadMultiply] = "*"
u81[Enum.KeyCode.KeypadMinus] = "-"
u81[Enum.KeyCode.KeypadPlus] = "+"
u81[Enum.KeyCode.KeypadEnter] = "Ent"
u81[Enum.KeyCode.KeypadEquals] = "="
u81[Enum.KeyCode.Up] = "↑"
u81[Enum.KeyCode.Down] = "↓"
u81[Enum.KeyCode.Right] = "→"
u81[Enum.KeyCode.Left] = "←"
u81[Enum.KeyCode.Insert] = "Ins"
u81[Enum.KeyCode.Home] = "Hm"
u81[Enum.KeyCode.End] = "End"
u81[Enum.KeyCode.PageUp] = "PgU"
u81[Enum.KeyCode.PageDown] = "PgD"
u81[Enum.KeyCode.LeftShift] = "Sh"
u81[Enum.KeyCode.RightShift] = "Sh"
u81[Enum.KeyCode.LeftMeta] = "Me"
u81[Enum.KeyCode.RightMeta] = "Me"
u81[Enum.KeyCode.LeftAlt] = "Alt"
u81[Enum.KeyCode.RightAlt] = "Alt"
u81[Enum.KeyCode.LeftControl] = "Ctrl"
u81[Enum.KeyCode.RightControl] = "Ctrl"
u81[Enum.KeyCode.CapsLock] = "Caps"
u81[Enum.KeyCode.NumLock] = "NL"
u81[Enum.KeyCode.ScrollLock] = "SL"
u81[Enum.KeyCode.LeftSuper] = "Sup"
u81[Enum.KeyCode.RightSuper] = "Sup"
u81[Enum.UserInputType.MouseButton1] = "M1"
u81[Enum.UserInputType.MouseButton2] = "M2"
u81[Enum.UserInputType.MouseButton3] = "M3"
local u250 = {"", "@2x", "@3x"}
local u254 = {}
u254.__index = u254
function u254.new(p1, p2, p3, p4) -- Line: 148 -- upvalues: u254 (val), u13 (val)
    local v1, v2, v3
    local v4 = {}
    setmetatable(v4, u254)
    local v5 = nil
    local v6 = nil
    if typeof(p1) ~= "EnumItem" then
        v6 = p1
    else
        v5 = p1
    end
    if v6 then
        v5 = getActionInputDeviceCode(v6)
    end
    if p2 == nil then
        v1 = 3
    else
        v1 = p2
    end
    if p3 == nil then
        v2 = Color3.new(1, 1, 1)
    else
        v2 = p3
    end
    local v7 = if v1 ~= 1 then if v1 ~= 2 then v1 == 3 else true else true
    assert(v7, "Icon size must be 1, 2, or 3 (SMALL, MEDIUM, or LARGE)")
    v3, v7 = createInputImage(v5, v2, v1)
    v4.Type = v7
    v4.UIObject = v3
    v4.IconSize = v1
    v4.Color = v2
    v4.ActionName = v6
    v4.Transparency = 0
    v4.AutoUpdate = p4 or true or true
    table.insert(u13, v4)
    return v4
end
function u254.SetInputMethod(p1) -- Line: 183 -- upvalues: u14 (ref), u13 (val)
    u14 = p1
    local v1 = u13
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j.AutoUpdate and j.ActionName then
            j:_ChangeInput((getActionInputDeviceCode(j.ActionName)))
        end
    end
end
function u254.SetUseNativeControllerImages(p1) -- Line: 193 -- upvalues: u16 (ref), u13 (val)
    u16 = p1
    local v1 = u13
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j.AutoUpdate and j.ActionName then
            j:_ChangeInput((getActionInputDeviceCode(j.ActionName)))
        end
    end
end
function u254.GetUseNativeControllerImages() -- Line: 204 -- upvalues: u16 (ref)
    return u16
end
function u254.UpdateBind(p1, p2) -- Line: 208 -- upvalues: u15 (val), u13 (val)
    u15[p1] = p2
    local v1 = u13
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j.AutoUpdate and j.ActionName == p1 then
            j:_ChangeInput((getActionInputDeviceCode(j.ActionName)))
        end
    end
end
function u254:Destroy() -- Line: 218 -- upvalues: u13 (val)
    if self.UpdateConnection then
        self.UpdateConnection:Disconnect()
    end
    self.UIObject:Destroy()
    local v1 = table.find(u13, self)
    if v1 then
        table.remove(u13, v1)
    end
end
function u254.SetColor(p1, p2) -- Line: 229
    p1.Color = p2
    if p1.Type == "UniqueImage" then
        p1.UIObject.ImageColor3 = p2
        return
    end
    if p1.Type == "KeyWithText" then
        p1.UIObject.OutlineImageLabel.ImageColor3 = p2
        p1.UIObject.KeyTextLabel.TextColor3 = p2
        return
    end
    if p1.Type == "KeyWithImage" then
        p1.UIObject.OutlineImageLabel.ImageColor3 = p2
        p1.UIObject.KeyImageLabel.ImageColor3 = p2
    end
end
function u254:SetTransparency(p2) -- Line: 242
    self.Transparency = p2
    if self.Type == "UniqueImage" then
        self.UIObject.ImageTransparency = p2
        return
    end
    if self.Type == "KeyWithText" then
        self.UIObject.OutlineImageLabel.ImageTransparency = p2
        self.UIObject.KeyTextLabel.TextTransparency = p2
        return
    end
    if self.Type == "KeyWithImage" then
        self.UIObject.OutlineImageLabel.ImageTransparency = p2
        self.UIObject.KeyImageLabel.ImageTransparency = p2
    end
end
function u254.TweenTransparency(p1, p2, p3) -- Line: 255 -- upvalues: TweenService (val)
    local v1, v2
    local v3 = {}
    if p1.Type == "UniqueImage" then
        table.insert(v3, p1.UIObject)
    elseif p1.Type == "KeyWithText" then
        table.insert(v3, p1.UIObject.OutlineImageLabel)
        table.insert(v3, p1.UIObject.KeyTextLabel)
    elseif p1.Type == "KeyWithImage" then
        table.insert(v3, p1.UIObject.OutlineImageLabel)
        table.insert(v3, p1.UIObject.KeyImageLabel)
    end
    local v4 = {}
    local v5 = v3
    local v6 = nil
    local v7 = nil
    local v8 = p2
    for i, j in v5, v6, v7 do
        if not (j:IsA("ImageLabel")) then
            v1 = {TextTransparency = v8}
        else
            v1 = {ImageTransparency = v8}
        end
        v2 = TweenService:Create(j, v9, v1)
        v2:Play()
        table.insert(v4, v2)
    end
    return v4
end
function u254:_ChangeInput(p2) -- Line: 284
    local v1, v2
    v1, v2 = createInputImage(p2, self.Color, self.IconSize)
    local UIObject = self.UIObject
    UIObject.BackgroundTransparency = 0.5
    v1.Size = UIObject.Size
    v1.Position = UIObject.Position
    v1.AnchorPoint = UIObject.AnchorPoint
    v1.SizeConstraint = UIObject.SizeConstraint
    v1.AutomaticSize = UIObject.AutomaticSize
    v1.Visible = UIObject.Visible
    v1.Parent = UIObject.Parent
    self.Type = v2
    self.UIObject = v1
    self:SetTransparency(self.Transparency)
    UIObject:Destroy()
end
function addSizeSuffix(p1, p2) -- Line: 317 -- upvalues: u250 (val)
    local v1 = #p1 - 3
    if string.sub(p1, v1, #p1) ~= ".png" then
        return p1
    end
    local v2 = string.sub(p1, 1, #p1 - 4)
    local v3 = string.sub(p1, #p1 - 3)
    return v2 .. u250[p2] .. v3
end
function createInputImage(p1, p2, p3) -- Line: 326 -- upvalues: u17 (val), u16 (ref), UserInputService (val), u58 (val), u81 (val)
    local v1, v2
    local v3 = u17[p1]
    if v3 then
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "InputLabel"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.ImageColor3 = p2
        ImageLabel.ScaleType = Enum.ScaleType.Fit
        local v4 = v3
        v1 = false
        if u16 and typeof(p1) == "EnumItem" and p1.EnumType == Enum.KeyCode then
            local ImageForKeyCode = UserInputService:GetImageForKeyCode(p1)
            if ImageForKeyCode and ImageForKeyCode ~= "" then
                v4 = ImageForKeyCode
                v1 = true
            end
        end
        if not v1 then
            v2 = addSizeSuffix(v4, p3)
        else
            v2 = v4
        end
        ImageLabel.Image = v2
        return ImageLabel, "UniqueImage"
    end
    local Frame = Instance.new("Frame")
    Frame.Name = "InputLabel"
    Frame.BackgroundTransparency = 1
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Name = "OutlineImageLabel"
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.Image = addSizeSuffix("rbxasset://textures/ui/Controls/key_single.png", p3)
    ImageLabel_2.ImageColor3 = p2
    ImageLabel_2.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel_2.Parent = Frame
    v1 = u58[p1]
    if not v1 then
        local Name = u81[p1]
        if Name == nil then
            Name = p1.Name
        end
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "KeyTextLabel"
        TextLabel.BackgroundTransparency = 1
        TextLabel.FontFace = Font.new("SourceSansPro", Enum.FontWeight.Bold)
        TextLabel.Text = Name
        TextLabel.TextColor3 = p2
        TextLabel.TextScaled = true
        TextLabel.Size = UDim2.new(0.8, 0, 0.8, 0)
        TextLabel.Position = UDim2.new(0.5, 0, 0.45, 0)
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel.Parent = Frame
        v2 = "KeyWithText"
    else
        local ImageLabel_3 = Instance.new("ImageLabel")
        ImageLabel_3.Name = "KeyImageLabel"
        ImageLabel_3.BackgroundTransparency = 1
        ImageLabel_3.Image = addSizeSuffix(v1, p3)
        ImageLabel_3.ImageColor3 = p2
        ImageLabel_3.Size = UDim2.new(1, 0, 1, 0)
        ImageLabel_3.Parent = ImageLabel_2
        v2 = "KeyWithImage"
    end
    return Frame, v2
end
function getActionInputDeviceCode(p1) -- Line: 401 -- upvalues: u15 (val), u14 (ref)
    local Mouse = nil
    local v1 = u15[p1]
    if v1 then
        if u14 == "MouseKeyboard" then
            if not v1.Mouse then
                Mouse = nil
            else
                Mouse = v1.Mouse
            end
            if not Mouse then
                if not v1.Keyboard then
                    Mouse = nil
                else
                    Mouse = v1.Keyboard
                end
            end
        elseif u14 ~= "Gamepad" then
            if u14 == "Touch" then
                Mouse = Enum.UserInputType.Touch
            end
        elseif not v1.Gamepad then
            Mouse = nil
        else
            Mouse = v1.Gamepad
        end
    end
    if Mouse then
        return Mouse
    end
    return Enum.KeyCode.Unknown
end
return u254