local Binds
local BindGui = script.BindGui
local PressLabel = BindGui.PressLabel
local ClearLabel = BindGui.ClearLabel
local ConfirmationFrame = BindGui.ConfirmationFrame
local LabelFrame = ConfirmationFrame.SelectedInputFrame.LabelFrame
local UserInputService = game:GetService("UserInputService")
local common = game.ReplicatedStorage.common
local Parent = require(script.Parent)
local u21 = require("./DefaultSettings")
local InputLabel = require(common.InputLabel)
local Signal = require(common.Signal)
local u28 = "MouseKeyboard"
local u29 = nil
local u30 = {}
local u31 = {
    Reload = {LayoutOrder = 2, DisplayText = "RELOAD"},
    PrimaryAttack = {LayoutOrder = 3, DisplayText = "PRIMARY ATTACK"},
    SecondaryAttack = {LayoutOrder = 4, DisplayText = "SECONDARY ATTACK"},
    ToggleSecondaryAttack = {LayoutOrder = 5, DisplayText = "TOGGLE SECONDARY ATTACK"},
    Firemode = {LayoutOrder = 6, DisplayText = "FIREMODE"},
    QuickMeleeAndBlock = {LayoutOrder = 7, DisplayText = "QUICK MELEE/BLOCK", Description = "TAP TO MELEE, HOLD TO BLOCK"},
    OffHandUse = {LayoutOrder = 8, DisplayText = "ABILITY/OFF-HAND", Description = "USE FOCUS OR OFF-HAND ITEM"},
    SprintHold = {LayoutOrder = 9, DisplayText = "SPRINT [HOLD]"},
    SprintToggle = {LayoutOrder = 10, DisplayText = "SPRINT [TOGGLE]"},
    CrouchHold = {LayoutOrder = 11, DisplayText = "CROUCH [HOLD]"},
    CrouchToggle = {LayoutOrder = 12, DisplayText = "CROUCH [TOGGLE]"},
    ProneToggle = {LayoutOrder = 13, DisplayText = "PRONE [TOGGLE]"},
    CrouchProneToggle = {LayoutOrder = 14, DisplayText = "CROUCH/PRONE [TOGGLE]", Description = "TAP TO CROUCH, HOLD TO PRONE"},
    ToggleControlHints = {LayoutOrder = 15, DisplayText = "CONTROL HINTS [TOGGLE]", Description = "Show or hide the control hints on the right side of the screen."},
    Thirdperson = {LayoutOrder = 16, DisplayText = "THIRD PERSON"},
    PromptInteract = {LayoutOrder = 17, DisplayText = "INTERACT"},
    LeaderboardToggle = {LayoutOrder = 18, DisplayText = "LEADERBOARD [TOGGLE]"},
    LeaderboardHold = {LayoutOrder = 19, DisplayText = "LEADERBOARD [HOLD]"},
    NVGToggle = {LayoutOrder = 20, DisplayText = "NIGHT VISION GOOGLES [TOGGLE]"},
}
local u51 = {}
u51[Enum.KeyCode.Escape] = true
u51[Enum.UserInputType.Focus] = true
u51[Enum.UserInputType.Touch] = true
u51[Enum.UserInputType.Gyro] = true
u51[Enum.UserInputType.Accelerometer] = true
u51[Enum.UserInputType.MouseMovement] = true
local u64 = {IsBinding = false, BindingChanged = Signal.new()}
function u64.CreateSection(p1) -- Line: 142 -- upvalues: Parent (val), u31 (val), u30 (val), u64 (val), u28 (ref), u29 (ref), BindGui (val), PressLabel (val), ClearLabel (val), InputLabel (val), LabelFrame (val), ConfirmationFrame (val)
    local Frame, GamepadButton, KeyboardButton, MouseButton, setupInputDeviceButton, v1, v2, v3, v4, v5, v6
    local v7 = p1:Tab("BINDS")
    v7:BindsHeader()
    local Binds = Parent.Controls.Binds
    local v8 = nil
    local v9 = nil
    for i, j in Binds, v8, v9 do
        if u31[i] then
            u30[i] = {}
            v5 = v7:Bind(u31[i].DisplayText, u31[i].Description)
            Frame = v5:WaitForChild("Frame")
            v5.LayoutOrder = u31[i].LayoutOrder
            v6 = j
            v1 = nil
            v2 = nil
            for k, n in v6, v1, v2 do
                v3 = Frame:WaitForChild(k .. "Button")
                setButtonLabel(v3, n)
            end
            function setupInputDeviceButton(p1, p2) -- Line: 165 -- upvalues: u30 (upval), i (val), u64 (upval), u28 (upval), u29 (upval), BindGui (upval), Parent (upval), PressLabel (upval), ClearLabel (upval), InputLabel (upval), LabelFrame (upval), ConfirmationFrame (upval)
                u30[i][p1] = p2
                p2.MouseButton1Click:Connect(function() -- Line: 168 -- upvalues: u64 (upval), u28 (upval), u29 (upval), BindGui (upval), Parent (upval), i (upval), p1 (val), PressLabel (upval), ClearLabel (upval), InputLabel (upval), LabelFrame (upval), ConfirmationFrame (upval)
                    if not u64.IsBinding and u28 ~= "Touch" then
                        local u4 = os.clock()
                        u29 = u4
                        u64.IsBinding = true
                        BindGui.Parent = game.Players.LocalPlayer.PlayerGui
                        BindGui.Enabled = true
                        local v1 = getNextInput()
                        local v2 = true
                        local v3 = Parent.Controls.Binds[i]
                        if v1 ~= v3[p1] then
                            v3 = Parent.Controls.Binds[i]
                            if v1 ~= v3[p1] and inputAlreadyInUse(v1) then
                                PressLabel.Visible = false
                                ClearLabel.Visible = false
                                local v4 = InputLabel.new(v1, 3, nil, false)
                                v4.UIObject.Size = UDim2.new(1, 0, 1, 0)
                                v4.UIObject.Parent = LabelFrame
                                ConfirmationFrame.Visible = true
                                v2 = getNextInput() == v1
                                v4:Destroy()
                            end
                        else
                            v1 = nil
                        end
                        if v2 then
                            setBind(i, p1, v1)
                        end
                        BindGui.Enabled = false
                        BindGui.Parent = nil
                        PressLabel.Visible = true
                        ClearLabel.Visible = true
                        ConfirmationFrame.Visible = false
                        task.delay(1, function() -- Line: 205 -- upvalues: u4 (val), u29 (upval), u64 (upval)
                            if u4 == u29 then
                                u64.IsBinding = false
                            end
                        end)
                    end
                end)
            end
            KeyboardButton = Frame:WaitForChild("KeyboardButton")
            u30[i].Keyboard = KeyboardButton
            local u83 = "Keyboard"
            KeyboardButton.MouseButton1Click:Connect(function() -- Line: 168 -- upvalues: u64 (upval), u28 (upval), u29 (upval), BindGui (upval), Parent (upval), i (val), u83 (val), PressLabel (upval), ClearLabel (upval), InputLabel (upval), LabelFrame (upval), ConfirmationFrame (upval)
                if not u64.IsBinding and u28 ~= "Touch" then
                    local u4 = os.clock()
                    u29 = u4
                    u64.IsBinding = true
                    BindGui.Parent = game.Players.LocalPlayer.PlayerGui
                    BindGui.Enabled = true
                    local v1 = getNextInput()
                    local v2 = true
                    local v3 = Parent.Controls.Binds[i]
                    if v1 ~= v3[u83] then
                        v3 = Parent.Controls.Binds[i]
                        if v1 ~= v3[u83] and inputAlreadyInUse(v1) then
                            PressLabel.Visible = false
                            ClearLabel.Visible = false
                            local v4 = InputLabel.new(v1, 3, nil, false)
                            v4.UIObject.Size = UDim2.new(1, 0, 1, 0)
                            v4.UIObject.Parent = LabelFrame
                            ConfirmationFrame.Visible = true
                            v2 = getNextInput() == v1
                            v4:Destroy()
                        end
                    else
                        v1 = nil
                    end
                    if v2 then
                        setBind(i, u83, v1)
                    end
                    BindGui.Enabled = false
                    BindGui.Parent = nil
                    PressLabel.Visible = true
                    ClearLabel.Visible = true
                    ConfirmationFrame.Visible = false
                    task.delay(1, function() -- Line: 205 -- upvalues: u4 (val), u29 (upval), u64 (upval)
                        if u4 == u29 then
                            u64.IsBinding = false
                        end
                    end)
                end
            end)
            MouseButton = Frame:WaitForChild("MouseButton")
            u30[i].Mouse = MouseButton
            local u95 = "Mouse"
            MouseButton.MouseButton1Click:Connect(function() -- Line: 168 -- upvalues: u64 (upval), u28 (upval), u29 (upval), BindGui (upval), Parent (upval), i (val), u95 (val), PressLabel (upval), ClearLabel (upval), InputLabel (upval), LabelFrame (upval), ConfirmationFrame (upval)
                if not u64.IsBinding and u28 ~= "Touch" then
                    local u4 = os.clock()
                    u29 = u4
                    u64.IsBinding = true
                    BindGui.Parent = game.Players.LocalPlayer.PlayerGui
                    BindGui.Enabled = true
                    local v1 = getNextInput()
                    local v2 = true
                    local v3 = Parent.Controls.Binds[i]
                    if v1 ~= v3[u95] then
                        v3 = Parent.Controls.Binds[i]
                        if v1 ~= v3[u95] and inputAlreadyInUse(v1) then
                            PressLabel.Visible = false
                            ClearLabel.Visible = false
                            local v4 = InputLabel.new(v1, 3, nil, false)
                            v4.UIObject.Size = UDim2.new(1, 0, 1, 0)
                            v4.UIObject.Parent = LabelFrame
                            ConfirmationFrame.Visible = true
                            v2 = getNextInput() == v1
                            v4:Destroy()
                        end
                    else
                        v1 = nil
                    end
                    if v2 then
                        setBind(i, u95, v1)
                    end
                    BindGui.Enabled = false
                    BindGui.Parent = nil
                    PressLabel.Visible = true
                    ClearLabel.Visible = true
                    ConfirmationFrame.Visible = false
                    task.delay(1, function() -- Line: 205 -- upvalues: u4 (val), u29 (upval), u64 (upval)
                        if u4 == u29 then
                            u64.IsBinding = false
                        end
                    end)
                end
            end)
            GamepadButton = Frame:WaitForChild("GamepadButton")
            u30[i].Gamepad = GamepadButton
            local u107 = "Gamepad"
            GamepadButton.MouseButton1Click:Connect(function() -- Line: 168 -- upvalues: u64 (upval), u28 (upval), u29 (upval), BindGui (upval), Parent (upval), i (val), u107 (val), PressLabel (upval), ClearLabel (upval), InputLabel (upval), LabelFrame (upval), ConfirmationFrame (upval)
                if not u64.IsBinding and u28 ~= "Touch" then
                    local u4 = os.clock()
                    u29 = u4
                    u64.IsBinding = true
                    BindGui.Parent = game.Players.LocalPlayer.PlayerGui
                    BindGui.Enabled = true
                    local v1 = getNextInput()
                    local v2 = true
                    local v3 = Parent.Controls.Binds[i]
                    if v1 ~= v3[u107] then
                        v3 = Parent.Controls.Binds[i]
                        if v1 ~= v3[u107] and inputAlreadyInUse(v1) then
                            PressLabel.Visible = false
                            ClearLabel.Visible = false
                            local v4 = InputLabel.new(v1, 3, nil, false)
                            v4.UIObject.Size = UDim2.new(1, 0, 1, 0)
                            v4.UIObject.Parent = LabelFrame
                            ConfirmationFrame.Visible = true
                            v2 = getNextInput() == v1
                            v4:Destroy()
                        end
                    else
                        v1 = nil
                    end
                    if v2 then
                        setBind(i, u107, v1)
                    end
                    BindGui.Enabled = false
                    BindGui.Parent = nil
                    PressLabel.Visible = true
                    ClearLabel.Visible = true
                    ConfirmationFrame.Visible = false
                    task.delay(1, function() -- Line: 205 -- upvalues: u4 (val), u29 (upval), u64 (upval)
                        if u4 == u29 then
                            u64.IsBinding = false
                        end
                    end)
                end
            end)
        end
    end
    v5 = Color3.fromRGB(255, 73, 73)
    local v10 = Color3.fromRGB(49, 49, 49)
    v4 = v7:Button("RESET TO DEFAULT", "RESET", function() -- Line: 219
        resetBinds()
    end, v5, v10, Color3.fromRGB(255, 73, 73))
    v4.LayoutOrder = 100
    return v7
end
function u64.SetInputMethod(p1) -- Line: 226 -- upvalues: u28 (ref)
    u28 = p1
end
function setButtonLabel(p1, p2) -- Line: 231 -- upvalues: InputLabel (val)
    local GuiObject = p1:FindFirstChildWhichIsA("GuiObject")
    if GuiObject then
        GuiObject:Destroy()
    end
    if p2 then
        local v1 = InputLabel.new(p2, 3, nil, false)
        v1.UIObject.AnchorPoint = Vector2.new(0.5, 0.5)
        v1.UIObject.Position = UDim2.new(0.5, 0, 0.5, 0)
        v1.UIObject.Size = UDim2.new(0.7, 0, 0.7, 0)
        v1.UIObject.Parent = p1
    end
end
function setBind(p1, p2, p3) -- Line: 245 -- upvalues: Parent (val), InputLabel (val), u30 (val), u64 (val)
    local v1 = Parent.Controls.Binds[p1][p2]
    Parent.Controls.Binds[p1][p2] = p3
    InputLabel.UpdateBind(p1, Parent.Controls.Binds[p1])
    setButtonLabel(u30[p1][p2], p3)
    u64.BindingChanged:Fire(p1, p2, v1, p3)
end
function resetBinds() -- Line: 253 -- upvalues: Parent (val), u21 (val)
    local v1, v2, v3, v4
    local Binds = Parent.Controls.Binds
    local v5 = nil
    local v6 = nil
    for i, j in Binds, v5, v6 do
        v2 = {"Keyboard", "Mouse", "Gamepad"}
        v3 = nil
        v4 = nil
        for k, n in v2, v3, v4 do
            v1 = u21.Controls.Binds[i][n]
            if v1 ~= j[n] then
                setBind(i, n, v1)
            end
        end
    end
end
function inputAlreadyInUse(p1) -- Line: 265 -- upvalues: Parent (val)
    local v1, v2, v3
    local Binds = Parent.Controls.Binds
    local v4 = nil
    local v5 = nil
    for i, j in Binds, v4, v5 do
        v1 = j
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            if n == v6 then
                return true
            end
        end
    end
    return false
end
function getNextInput() -- Line: 276 -- upvalues: UserInputService (val), u51 (val)
    local KeyCode, UserInputType, v1, v2, v3
    while true do
        v2, v3 = UserInputService.InputBegan:Wait()
        v1 = v2
        UserInputType = v1.UserInputType
        KeyCode = v1.KeyCode
        if not (u51[UserInputType]) and not (u51[KeyCode]) then
            break
        end
    end
    if KeyCode == Enum.KeyCode.Unknown then
        return UserInputType
    end
    return KeyCode
end
Binds = Parent.Controls.Binds
local v1 = nil
local v2 = nil
for i, j in Binds, v1, v2 do
    InputLabel.UpdateBind(i, j)
end
u64.BindingChanged:Connect(function(p1, p2, p3, p4) -- Line: 292 -- upvalues: Parent (val)
    Parent.SettingsChanged:Fire({"Controls", "Binds", p1, p2}, p4)
end)
return u64