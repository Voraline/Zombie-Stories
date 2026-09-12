local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local peek = require(ReplicatedStorage.Packages.Fusion).peek
local Settings = require(ReplicatedStorage.common:WaitForChild("Settings"))
local BindUtil = require(ReplicatedStorage.common:WaitForChild("BindUtil"))
local Icons = require(script:WaitForChild("Icons"))
local Sorting = require(script:WaitForChild("Sorting"))
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local u58 = nil
local u59 = nil
local u60 = {}
u60[Enum.UserInputType.MouseButton1] = Enum.KeyCode.MouseLeftButton
u60[Enum.UserInputType.MouseButton2] = Enum.KeyCode.MouseRightButton
u60[Enum.UserInputType.MouseButton3] = Enum.KeyCode.MouseMiddleButton
local u67 = {}
local v1 = u60
local v2 = nil
local v3 = nil
for i, j in v1, v2, v3 do
    u67[j] = i
end

local function getIconId(p1, p2, p3) -- Line: 36 -- upvalues: Icons (val), BindUtil (val)
    local v1
    local v2 = p3 == true
    if not p2 then
        if BindUtil.getInputMethod() ~= "Gamepad" then
            local keyboard_solid_2
            if not v2 then
                keyboard_solid_2 = Icons.keyboard
            else
                keyboard_solid_2 = Icons.keyboard_solid
            end
            return keyboard_solid_2[p1] or ""
        end
        return Icons.Resolve(p1, v2)
    end
    if p2 == "keyboard" then
        local keyboard_solid
        if not v2 then
            keyboard_solid = Icons.keyboard
        else
            keyboard_solid = Icons.keyboard_solid
        end
        return keyboard_solid[p1] or ""
    end
    if not v2 then
        v1 = Icons[p2]
    else
        v1 = Icons[p2 .. "_solid"]
    end
    if v1 then
        return v1[p1] or ""
    end
    return ""
end

local function alive() -- Line: 57 -- upvalues: u59 (ref)
    if not u59 then
        return false
    end
    return not u59.States.IsDead
end

local function hasGun() -- Line: 62 -- upvalues: u59 (ref), u58 (ref)
    local v1
    if u59 then
        v1 = not u59.States.IsDead
    else
        v1 = false
    end
    if v1 and u58 then
        local CurrentWeapon = u58:GetCurrentWeapon()
        local v2 = false
        if CurrentWeapon ~= nil then
            v2 = not CurrentWeapon.Config.IsMelee
        end
        return v2
    end
    return false
end

local function hasMelee() -- Line: 68 -- upvalues: u59 (ref), u58 (ref)
    local v1
    if u59 then
        v1 = not u59.States.IsDead
    else
        v1 = false
    end
    if v1 and u58 then
        local CurrentWeapon = u58:GetCurrentWeapon()
        local v2 = false
        if CurrentWeapon ~= nil then
            v2 = CurrentWeapon.Config.IsMelee == true
        end
        return v2
    end
    return false
end

local u88 = {}
local v4 = {
    id = "Firemode",
    label = "Fire Mode",
    priority = 4,
    actions = {"Firemode"},
    condition = function() -- Line: 80 -- upvalues: u59 (ref), u58 (ref)
        local v1, v2
        if u59 then
            v2 = not u59.States.IsDead
        else
            v2 = false
        end
        if not v2 then
            v1 = false
        elseif u58 then
            local CurrentWeapon = u58:GetCurrentWeapon()
            v1 = false
            if CurrentWeapon ~= nil then
                v1 = not CurrentWeapon.Config.IsMelee
            end
        else
            v1 = false
        end
        if v1 and u58 then
            local CurrentWeapon_2 = u58:GetCurrentWeapon()
            v2 = false
            if CurrentWeapon_2 ~= nil then
                v2 = false
                if CurrentWeapon_2.Config.FireMode ~= nil then
                    v2 = 1 < #CurrentWeapon_2.Config.FireMode
                end
            end
            return v2
        end
        return false
    end,
}
local v5 = {
    id = "Charge",
    label = "Hold to Charge",
    priority = 3,
    actions = {"PrimaryAttack"},
    condition = function() -- Line: 74 -- upvalues: u59 (ref), u58 (ref)
        local v1, v2
        if u59 then
            v2 = not u59.States.IsDead
        else
            v2 = false
        end
        if not v2 then
            v1 = false
        elseif u58 then
            local CurrentWeapon = u58:GetCurrentWeapon()
            v1 = false
            if CurrentWeapon ~= nil then
                v1 = CurrentWeapon.Config.IsMelee == true
            end
        else
            v1 = false
        end
        if v1 and u58 then
            local CurrentWeapon_2 = u58:GetCurrentWeapon()
            v2 = false
            if CurrentWeapon_2 ~= nil then
                v2 = CurrentWeapon_2.Config.ChargeTime ~= nil
            end
            return v2
        end
        return false
    end,
}
local v6 = {
    id = "ToggleControlHints",
    label = "Toggle Controls",
    priority = 0,
    actions = {"ToggleControlHints"},
    condition = function() -- Line: 100
        return true
    end,
}
u88[1] = {
    id = "Shoot",
    label = "Shoot",
    priority = 1,
    actions = {"PrimaryAttack"},
    condition = hasGun,
}
u88[2] = {
    id = "Aim",
    label = "Aim",
    priority = 2,
    actions = {"SecondaryAttack"},
    condition = hasGun,
}
u88[3] = {
    id = "Reload",
    label = "Reload",
    priority = 3,
    actions = {"Reload"},
    condition = hasGun,
}
u88[4] = v4
u88[5] = {
    id = "Attack",
    label = "Attack",
    priority = 1,
    actions = {"PrimaryAttack"},
    condition = hasMelee,
}
u88[6] = {
    id = "Block",
    label = "Block",
    priority = 2,
    actions = {"SecondaryAttack"},
    condition = hasMelee,
}
u88[7] = v5
u88[8] = v6
u88[9] = {
    id = "Ability",
    label = "Ability",
    priority = 5,
    actions = {"OffHandUse"},
    condition = alive,
}
u88[10] = {
    id = "QuickMelee",
    label = "Quick Melee",
    priority = 6,
    actions = {"QuickMeleeAndBlock"},
    condition = hasGun,
}
u88[11] = {
    id = "Sprint",
    label = "Sprint",
    priority = 10,
    actions = {"SprintHold", "SprintToggle"},
    condition = alive,
}
u88[12] = {
    id = "Crouch",
    label = "Crouch",
    priority = 11,
    actions = {"CrouchToggle", "CrouchHold", "CrouchProneToggle"},
    condition = alive,
}
u88[13] = {
    id = "Prone",
    label = "Prone",
    priority = 12,
    actions = {"ProneToggle"},
    condition = alive,
}
u88[14] = {
    id = "ThirdPerson",
    label = "Third Person (Hold)",
    priority = 13,
    actions = {"Thirdperson"},
    condition = alive,
}
u88[15] = {
    id = "NVG",
    label = "Night Vision",
    priority = 14,
    actions = {"NVGToggle"},
    condition = alive,
}
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ControlHints"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 5
ScreenGui.Parent = PlayerGui
local Frame = Instance.new("Frame")
Frame.Name = "HintsFrame"
Frame.AnchorPoint = Vector2.new(1, 0.5)
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(1, -10, 0.5, 0)
Frame.Size = UDim2.fromScale(0.15, 0.3)
Frame.Parent = ScreenGui
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Name = "UIListLayout"
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Parent = Frame
local UISizeConstraint = Instance.new("UISizeConstraint")
UISizeConstraint.MaxSize = Vector2.new((1 / 0), 300)
UISizeConstraint.MinSize = Vector2.new(150, 150)
UISizeConstraint.Parent = Frame
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
UIAspectRatioConstraint.AspectRatio = 1.078
UIAspectRatioConstraint.Parent = Frame
local Frame_2 = Instance.new("Frame")
Frame_2.Name = "HintTemplate"
Frame_2.AnchorPoint = Vector2.new(1, 0.5)
Frame_2.BackgroundTransparency = 1
Frame_2.Size = UDim2.fromScale(1, 0.12)
Frame_2.Visible = false
local UIListLayout_2 = Instance.new("UIListLayout")
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout_2.Padding = UDim.new(0, 4)
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout_2.Parent = Frame_2
local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "ActionText"
TextLabel.AnchorPoint = Vector2.new(1, 0.5)
TextLabel.AutomaticSize = Enum.AutomaticSize.X
TextLabel.BackgroundTransparency = 1
TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium)
TextLabel.Position = UDim2.fromScale(0.795, 0.5)
TextLabel.Size = UDim2.fromScale(0.7, 0.7)
TextLabel.Text = "Action"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextScaled = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Right
TextLabel.Parent = Frame_2
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "IconImage"
ImageLabel.BackgroundTransparency = 1
ImageLabel.Image = ""
ImageLabel.LayoutOrder = 1
ImageLabel.ScaleType = Enum.ScaleType.Fit
ImageLabel.Size = UDim2.fromScale(0.3, 1)
Instance.new("UIAspectRatioConstraint").Parent = ImageLabel
ImageLabel.Parent = Frame_2
local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.Name = "Separator"
TextLabel_2.AnchorPoint = Vector2.new(1, 0.5)
TextLabel_2.AutomaticSize = Enum.AutomaticSize.X
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
TextLabel_2.LayoutOrder = 2
TextLabel_2.Position = UDim2.fromScale(0.795, 0.5)
TextLabel_2.Size = UDim2.fromScale(0.01, 0.5)
TextLabel_2.Text = "/"
TextLabel_2.TextColor3 = Color3.new(1, 1, 1)
TextLabel_2.TextScaled = true
TextLabel_2.Visible = false
TextLabel_2.Parent = Frame_2
Frame_2.Parent = Frame
local u288 = {}
local u289 = {}
local u290 = false

local function resolveKeyCodes(p1, p2) -- Line: 209 -- upvalues: Settings (val), u60 (val), Sorting (val)
    local Gamepad, Keyboard, Mouse, gamepad_sort_index, v1, v2
    local v3 = {}
    local v4 = {}
    local actions = p1.actions
    local v5 = nil
    local v6 = nil
    local v7 = p2
    for i, j in actions, v5, v6 do
        v2 = Settings.Controls.Binds[j]
        if v2 then
            if v7 == "MouseKeyboard" then
                Keyboard = v2.Keyboard
                if Keyboard and not v4[Keyboard] then
                    v4[Keyboard] = true
                    table.insert(v3, Keyboard)
                end
                Mouse = v2.Mouse
                if Mouse then
                    v1 = u60[Mouse]
                    if v1 and not v4[v1] then
                        v4[v1] = true
                        table.insert(v3, v1)
                    end
                end
            elseif v7 == "Gamepad" then
                Gamepad = v2.Gamepad
                if Gamepad and not v4[Gamepad] then
                    v4[Gamepad] = true
                    table.insert(v3, Gamepad)
                end
            end
        end
    end
    if v7 ~= "Gamepad" then
        gamepad_sort_index = Sorting.keyboard_sort_index
    else
        gamepad_sort_index = Sorting.gamepad_sort_index
    end
    table.sort(v3, function(p1, p2) -- Line: 243 -- upvalues: gamepad_sort_index (val)
        local v1 = (gamepad_sort_index[p1] or (1 / 0)) < (gamepad_sort_index[p2] or (1 / 0))
        return v1
    end)
    return v3
end

local u295 = {IsShowing = false}

function u295.Update(p1) -- Line: 256
    -- upvalues: u290 (ref), BindUtil (val), ScreenGui (val), peek (val), Settings (val), u295 (val), Icons (val)
    -- upvalues: Frame (val), u288 (val), u289 (val), u88 (val), resolveKeyCodes (val), Frame_2 (val), getIconId (val)
    -- upvalues: u67 (val), ContentProvider (val)
    local ActionText, IconImage, Separator, hintDef, keyCodes, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    if not u290 then
        return
    end
    local v12 = BindUtil.getInputMethod()
    if v12 == "Touch" or not peek(Settings.Controls.ShowControlHints) then
        ScreenGui.Enabled = false
        return
    end
    ScreenGui.Enabled = u295.IsShowing
    if v12 ~= "Gamepad" then
        v6 = "keyboard"
    else
        v6 = Icons.GetGamepadType()
    end
    for i, j in Frame:GetChildren() do
        if j:IsA("Frame") and j.Name == "HintLabel" then
            j:Destroy()
        end
    end
    table.clear(u288)
    table.clear(u289)
    local v13 = {}
    local v14 = u88
    local v15 = nil
    local v16 = nil
    for k, n in v14, v15, v16 do
        if n.condition() then
            v11 = resolveKeyCodes(n, v12)
            if 0 < #v11 then
                v1 = {hintDef = n, keyCodes = v11}
                table.insert(v13, v1)
            end
        end
    end
    table.sort(v13, function(p1, p2) -- Line: 304
        local v1 = p1.hintDef.priority < p2.hintDef.priority
        return v1
    end)
    local u273 = {}
    v15 = v13
    v16 = nil
    local v17 = nil
    for m, i5 in v15, v16, v17 do
        hintDef = i5.hintDef
        keyCodes = i5.keyCodes
        v1 = Frame_2:Clone()
        v1.Name = "HintLabel"
        v1.LayoutOrder = hintDef.priority
        ActionText = v1:FindFirstChild("ActionText")
        if ActionText then
            ActionText.Text = hintDef.label
        end
        IconImage = v1:FindFirstChild("IconImage")
        Separator = v1:FindFirstChild("Separator")
        if IconImage and Separator and 0 < #keyCodes then
            v2 = getIconId(keyCodes[1], v6, false)
            v3 = getIconId(keyCodes[1], v6, true)
            IconImage.Image = v2
            IconImage.Visible = true
            Separator.Visible = false
            if v2 ~= "" then
                table.insert(u273, v2)
            end
            if v3 ~= "" then
                table.insert(u273, v3)
            end
            v4 = IconImage.LayoutOrder + 1
            v5 = #keyCodes
            for i6 = 2, v5 do
                v7 = Separator:Clone()
                v7.Name = "Separator" .. i6 - 1
                v7.Text = "/"
                v7.LayoutOrder = v4
                v7.Visible = true
                v7.Parent = v1
                v4 = v4 + 1
                v8 = IconImage:Clone()
                v8.Name = "IconImage" .. i6
                v9 = getIconId(keyCodes[i6], v6, false)
                v10 = getIconId(keyCodes[i6], v6, true)
                v8.Image = v9
                v8.LayoutOrder = v4
                v8.Visible = true
                v8.Parent = v1
                v4 = v4 + 1
                if v9 ~= "" then
                    table.insert(u273, v9)
                end
                if v10 ~= "" then
                    table.insert(u273, v10)
                end
            end
        end
        v1.Visible = true
        v1.Parent = Frame
        v2 = {hintDef = hintDef, keyCodes = keyCodes, frame = v1}
        v4 = u288
        table.insert(v4, v2)
        v3 = keyCodes
        v4 = nil
        v5 = nil
        for i7, i8 in v3, v4, v5 do
            if not u289[i8] then
                u289[i8] = {}
            end
            v8 = u289[i8]
            table.insert(v8, v1)
            v7 = u67[i8]
            if v7 then
                if not u289[v7] then
                    u289[v7] = {}
                end
                v9 = u289[v7]
                table.insert(v9, v1)
            end
        end
    end
    if 0 < #u273 then
        task.spawn(function() -- Line: 391 -- upvalues: u273 (val), ContentProvider (upval)
            local ImageLabel
            local Folder = Instance.new("Folder")
            local v1 = u273
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                ImageLabel = Instance.new("ImageLabel")
                ImageLabel.Image = j
                ImageLabel.Parent = Folder
            end
            v1 = ContentProvider
            local Children = Folder:GetChildren()
            v1:PreloadAsync(Children)
            Folder:Destroy()
        end)
    end
end

function u295.Toggle(p1) -- Line: 404 -- upvalues: Settings (val), peek (val)
    local v1 = Settings
    local ShowControlHints = v1.Controls.ShowControlHints
    local v2 = peek
    local v3 = Settings
    v2 = v2(v3.Controls.ShowControlHints)
    ShowControlHints:set(not v2)
end

local function updateIconsForKey(p1, p2) -- Line: 409
    -- upvalues: BindUtil (val), Icons (val), u289 (val), u288 (val), u67 (val), getIconId (val)
    local keyCodes, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    if BindUtil.getInputMethod() ~= "Gamepad" then
        v11 = "keyboard"
    else
        v11 = Icons.GetGamepadType()
    end
    local v12 = u289[p1]
    if not v12 then
        return
    end
    local v13 = v12
    local v14 = nil
    local v15 = nil
    for i, j in v13, v14, v15 do
        for k, n in j:GetChildren() do
            if n:IsA("ImageLabel") and n.Name:match("^IconImage") then
                v3 = u288
                v4 = nil
                v5 = nil
                for m, i5 in v3, v4, v5 do
                    if i5.frame == j then
                        keyCodes = i5.keyCodes
                        v6 = nil
                        v7 = nil
                        for i6, i7 in keyCodes, v6, v7 do
                            if i6 ~= 1 then
                                v8 = "IconImage" .. i6
                            else
                                v8 = "IconImage"
                            end
                            v9 = j:FindFirstChild(v8)
                            if v9 then
                                v10 = true
                                if i7 ~= v1 then
                                    v10 = u67[i7] == v1
                                end
                                if v10 then
                                    v9.Image = getIconId(i7, v11, v2)
                                end
                            end
                        end
                        -- <loop back-edge to L27>
                    end
                end
                break
            end
        end
    end
end

function u295.Show(p1) -- Line: 444
    -- upvalues: u295 (val), u290 (ref), BindUtil (val), ScreenGui (val), peek (val), Settings (val)
    u295.IsShowing = true
    if u290 then
        u295:Update()
        return
    end
    if BindUtil.getInputMethod() ~= "Touch" then
        ScreenGui.Enabled = peek(Settings.Controls.ShowControlHints)
    end
end

function u295.Hide(p1) -- Line: 453 -- upvalues: u295 (val), ScreenGui (val)
    u295.IsShowing = false
    ScreenGui.Enabled = false
end

function u295.Init(p1, p2, p3) -- Line: 458
    -- upvalues: u290 (ref), u58 (ref), u59 (ref), u295 (val), BindUtil (val), Settings (val), UserInputService (val)
    -- upvalues: updateIconsForKey (val)
    if u290 then
        return
    end
    u290 = true
    u58 = p2
    u59 = p3
    local v1 = u58
    v1.WeaponEquipped:Connect(function() -- Line: 466 -- upvalues: u295 (upval)
        u295:Update()
    end)
    v1 = u58
    v1.WeaponUnequipped:Connect(function() -- Line: 469 -- upvalues: u295 (upval)
        u295:Update()
    end)
    v1 = BindUtil
    v1.InputMethodChanged:Connect(function() -- Line: 474 -- upvalues: u295 (upval)
        u295:Update()
    end)
    v1 = Settings
    v1.SettingsChanged:Connect(function(p1) -- Line: 479 -- upvalues: u295 (upval)
        if p1 and p1[1] == "Controls" then
            u295:Update()
        end
    end)
    v1 = UserInputService
    v1.InputBegan:Connect(function(p1, p2) -- Line: 486 -- upvalues: updateIconsForKey (upval)
        if p2 then
            return
        end
        local KeyCode = p1.KeyCode
        if KeyCode == Enum.KeyCode.Unknown then
            KeyCode = p1.UserInputType
        end
        updateIconsForKey(KeyCode, true)
    end)
    v1 = UserInputService
    v1.InputEnded:Connect(function(p1) -- Line: 496 -- upvalues: updateIconsForKey (upval)
        local KeyCode = p1.KeyCode
        if KeyCode == Enum.KeyCode.Unknown then
            KeyCode = p1.UserInputType
        end
        updateIconsForKey(KeyCode, false)
    end)
    u295:Update()
end

return u295