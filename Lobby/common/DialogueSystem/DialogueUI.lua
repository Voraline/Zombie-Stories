local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local BindUtil = require(ReplicatedStorage.common.BindUtil)
local Icons = require(ReplicatedStorage.common.ControlHints.Icons)
local BottomStack = require(ReplicatedStorage.common.HUDService.BottomStack)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local DialoguePortrait = require(script.Parent.DialoguePortrait)
local OnEvent = Fusion.OnEvent
local u55 = {}
u55.__index = u55
local function selectedBackground(p1, p2) -- Line: 21 -- upvalues: Theme (val)
    if p2 == "cancel" then
        local Fill = Theme.Menu.NavigationColors.Cancel.Fill
        if not p1 then
            return Fill
        end
        local v1 = Color3.new(1, 1, 1)
        return (Fill:Lerp(v1, 0.08))
    end
    if p1 then
        return Theme.Menu.Selected
    end
    if p2 == "positive" then
        return Theme.Menu.NavigationColors.Play.Fill
    end
    return Theme.Menu.Panel
end
local function selectedStroke(p1, p2) -- Line: 33 -- upvalues: Theme (val)
    if p2 == "cancel" then
        return Theme.Menu.NavigationColors.Cancel.Accent
    end
    if p1 then
        return Theme.Menu.Accent
    end
    if p2 == "positive" then
        return Theme.Menu.Positive
    end
    return Theme.Menu.Border
end
function u55._initialize(p1) -- Line: 44 -- upvalues: BindUtil (val), fusion_utils (val), UIKit (val), selectedBackground (val), Theme (val), Players (val), OnEvent (val), Fusion (val), BottomStack (val), DialoguePortrait (val), Icons (val), ContentProvider (val)
    local Children
    local _callbacks = p1._callbacks
    local _scope = p1._scope
    p1._speaker = _scope:Value("")
    p1._portrait = _scope:Value("")
    p1._line = _scope:Value("")
    p1._visibleGraphemes = _scope:Value(-1)
    local v1 = {}
    p1._options = _scope:Value(v1)
    p1._optionCount = _scope:Value(0)
    p1._selectedIndex = _scope:Value(0)
    p1._inputMethod = _scope:Value(BindUtil.getInputMethod())
    p1._stackOffset = _scope:Value(0)
    local u49 = _scope:Tween(p1._stackOffset, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
    local v2 = Vector2.new(1600, 900)
    local u62 = fusion_utils.usePx(_scope, v2, 0.58, 0.5)(1)
    local u66 = _scope:Computed(function(p1) -- Line: 61 -- upvalues: u62 (val)
        return (math.max(84, (math.floor(p1(u62) * 104))))
    end)
    local u70 = _scope:Computed(function(p1) -- Line: 64 -- upvalues: u62 (val)
        return (math.max(84, (math.floor(p1(u62) * 104))))
    end)
    local u74 = _scope:Computed(function(p1) -- Line: 67 -- upvalues: u62 (val)
        return (math.max(6, (math.floor(p1(u62) * 8))))
    end)
    local u78 = _scope:Computed(function(p1) -- Line: 70 -- upvalues: u62 (val)
        return (math.max(32, (math.floor(p1(u62) * 34))))
    end)
    local u82 = _scope:Computed(function(a1) -- Line: 73 -- upvalues: p1 (val), u78 (val)
        local v1 = a1(p1._optionCount)
        if v1 == 0 then
            return 0
        end
        local v2 = math.min(v1, 4)
        local v3 = v2 * a1(u78)
        return v3 + math.max(v2 - 1, 0) * 4 + 4
    end)
    local u86 = _scope:Computed(function(a1) -- Line: 81 -- upvalues: p1 (val), u62 (val)
        if a1(p1._optionCount) == 0 or a1(p1._inputMethod) ~= "Gamepad" then
            return 0
        end
        return math.max(22, (math.floor(a1(u62) * 26))) + 6
    end)
    local u90 = _scope:Computed(function(p1) -- Line: 87 -- upvalues: u70 (val), u82 (val), u86 (val)
        local v1 = p1(u70)
        local v2 = v1 + p1(u82)
        return v2 + p1(u86)
    end)
    local v3 = _scope:ForValues(p1._options, function(a1, p2, p3) -- Line: 91 -- upvalues: p1 (val), UIKit (upval), u78 (val), selectedBackground (upval), Theme (upval)
        local Accent, Gradient
        local u6 = p2:Computed(function(a1) -- Line: 92 -- upvalues: p1 (upval), p3 (val)
            local v1 = a1(p1._selectedIndex)
            local v2 = v1 == p3.index
            return v2
        end)
        local v1 = {
            StrokeThickness = 2,
            scope = p2,
            Name = "Option_" .. tostring(p3.index),
            Size = p2:Computed(function(p1) -- Line: 99 -- upvalues: u78 (upval)
                return UDim2.new(1, -2, 0, p1(u78))
            end),
            LayoutOrder = p3.index,
            BackgroundColor3 = p2:Computed(function(p1) -- Line: 103 -- upvalues: selectedBackground (upval), u6 (val), p3 (val)
                local v1 = p1(u6)
                return (selectedBackground(v1, p3.style))
            end),
            StrokeColor3 = p2:Computed(function(p1) -- Line: 106 -- upvalues: u6 (val), p3 (val), Theme (upval)
                local v1 = p1(u6)
                local style = p3.style
                if style == "cancel" then
                    return Theme.Menu.NavigationColors.Cancel.Accent
                end
                if v1 then
                    return Theme.Menu.Accent
                end
                if style == "positive" then
                    return Theme.Menu.Positive
                end
                return Theme.Menu.Border
            end),
        }
        if p3.style ~= "cancel" then
            Accent = Theme.Menu.Accent
        else
            Accent = Theme.Menu.NavigationColors.Cancel.Accent
        end
        v1.StrokeHoverColor3 = Accent
        if p3.style ~= "cancel" then
            Gradient = nil
        else
            Gradient = Theme.Menu.NavigationColors.Cancel.Gradient
        end
        v1.GradientColor = Gradient
        v1.ZIndex = Theme.ZIndex.Modal + 6
        function v1.OnClick() -- Line: 115 -- upvalues: p1 (upval), p3 (val)
            p1:ActivateOption(p3.index)
        end
        local v2 = {}
        local v3 = p2:New("TextLabel")
        local v4 = {
            Name = "Label",
            Size = UDim2.new(1, -20, 1, -8),
            Position = UDim2.fromOffset(10, 4),
            BackgroundTransparency = 1,
            Text = p2:Computed(function(a1) -- Line: 124 -- upvalues: p1 (upval), p3 (val)
                if a1(p1._inputMethod) == "Gamepad" then
                    return p3.text
                end
                return (string.format("%d. %s", p3.index, p3.text))
            end),
            Font = Theme.Menu.Fonts.Button,
            TextColor3 = Theme.Menu.Text,
            TextScaled = true,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = Theme.ZIndex.Modal + 7,
        }
        local Children = p2.Children
        local v5 = {}
        local v6 = p2:New("UITextSizeConstraint")
        v5[1] = v6({MinTextSize = 11, MaxTextSize = 16})
        v4[Children] = v5
        v2[1] = v3(v4)
        v1.Children = v2
        local u106 = UIKit.Card(v1)
        u106.Selectable = false
        p1._buttons[p3.index] = u106
        table.insert(p2, u106.Destroying:Connect(function() -- Line: 148 -- upvalues: p1 (upval), p3 (val), u106 (ref)
            local v1 = p1._buttons[p3.index]
            if v1 == u106 then
                p1._buttons[p3.index] = nil
            end
        end))
        return u106
    end)
    local v4 = _scope:New("ScreenGui")
    v4 = v4({
        Name = "FusionDialogue",
        ResetOnSpawn = false,
        ClipToDeviceSafeArea = true,
        DisplayOrder = 30,
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    p1.ScreenGui = v4
    local v5 = _scope:New("TextButton")
    local v6 = {
        Name = "InputShield",
        Parent = v4,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Selectable = false,
        ZIndex = Theme.ZIndex.Modal,
    }
    local Activated = OnEvent("Activated")
    v6[Activated] = function() -- Line: 178 -- upvalues: p1 (val)
        if p1._callbacks.OnAdvance then
            p1._callbacks.OnAdvance()
        end
    end
    v5(v6)
    fusion_utils.useEventListener(_scope, BindUtil.InputMethodChanged, function(a1) -- Line: 185 -- upvalues: p1 (val), Fusion (upval)
        local v1
        if p1._destroyed then
            return
        end
        p1._inputMethod:set(a1)
        if Fusion.peek(p1._optionCount) == 0 then
            return
        end
        if a1 ~= "Gamepad" then
            v1 = 0
        else
            v1 = 1
        end
        p1._selectedIndex:set(v1)
    end)
    v5 = _scope:New("Frame")
    v6 = {
        Name = "DialogueBanner",
        Parent = v4,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = _scope:Computed(function(p1) -- Line: 200 -- upvalues: u62 (val), u49 (val)
            local v1 = math.max(48, (math.floor(p1(u62) * 64)))
            return UDim2.new(0.5, 0, 1, -(v1 + p1(u49)))
        end),
        Size = _scope:Computed(function(p1) -- Line: 204 -- upvalues: u90 (val)
            return UDim2.new(0.66, 0, 0, p1(u90))
        end),
        BackgroundTransparency = 1,
        ZIndex = Theme.ZIndex.Modal + 1,
    }
    Children = _scope.Children
    local v7 = {}
    local v8 = _scope:New("UISizeConstraint")
    v7[1] = v8({MinSize = Vector2.new(320, 84), MaxSize = Vector2.new(720, 340)})
    v6[Children] = v7
    local u179 = v5(v6)
    p1._bottomStack = BottomStack.Register({
        Name = "LobbyDialogue",
        Layer = BottomStack.Layers.Dialogue,
        Reserve = function() -- Line: 219 -- upvalues: Fusion (upval), u62 (val), u179 (val)
            local v1 = math.max(48, (math.floor(Fusion.peek(u62) * 64)))
            return v1 + u179.AbsoluteSize.Y
        end,
        Bottom = function() -- Line: 223 -- upvalues: Fusion (upval), u62 (val)
            return (math.max(48, (math.floor(Fusion.peek(u62) * 64))))
        end,
        Apply = function(a1) -- Line: 226 -- upvalues: p1 (val)
            p1._stackOffset:set(a1)
        end,
    })
    table.insert(_scope, function() -- Line: 230 -- upvalues: p1 (val)
        if p1._bottomStack then
            p1._bottomStack:Destroy()
            p1._bottomStack = nil
        end
    end)
    p1._bottomStack:SetOccupying(true)
    local PropertyChangedSignal = u179:GetPropertyChangedSignal("AbsoluteSize")
    table.insert(_scope, PropertyChangedSignal:Connect(function() -- Line: 239 -- upvalues: p1 (val)
        if not p1._destroyed and p1._bottomStack then
            p1._bottomStack:Invalidate()
        end
    end))
    v6 = UIKit.Card({
        Name = "PortraitPanel",
        StrokeThickness = 2,
        ClipsDescendants = true,
        scope = _scope,
        Parent = u179,
        Position = UDim2.fromScale(0, 0),
        Size = _scope:Computed(function(p1) -- Line: 251 -- upvalues: u66 (val), u70 (val)
            local v1 = p1(u66)
            return UDim2.fromOffset(v1, p1(u70))
        end),
        BackgroundColor3 = Theme.Menu.PanelDeep,
        StrokeColor3 = Theme.Menu.Border,
        ZIndex = Theme.ZIndex.Modal + 2,
    })
    local v9 = _scope:New("ImageLabel")
    v7 = {
        Name = "Portrait",
        Parent = v6,
        Position = UDim2.fromOffset(8, 8),
        Size = UDim2.new(1, -16, 1, -16),
        BackgroundColor3 = Theme.Menu.PanelInset,
        BackgroundTransparency = 0,
        Image = p1._portrait,
        ScaleType = Enum.ScaleType.Crop,
        Visible = _scope:Computed(function(a1) -- Line: 270 -- upvalues: p1 (val)
            local v1 = a1(p1._portrait) ~= ""
            return v1
        end),
        ZIndex = Theme.ZIndex.Modal + 4,
    }
    local Children_2 = _scope.Children
    local v10 = {}
    local v11 = _scope:New("UICorner")
    v10[1] = v11({CornerRadius = UDim.new(0, (math.max(2, Theme.Menu.CornerRadius - 2)))})
    v7[Children_2] = v10
    v9(v7)
    v9 = _scope:Computed(function(a1) -- Line: 280 -- upvalues: p1 (val)
        local v1 = a1(p1._portrait) == ""
        return v1
    end)
    local u295 = DialoguePortrait.create(_scope, v6, _callbacks.Npc, v9, Theme.ZIndex.Modal + 3)
    v8 = _scope:New("TextLabel")
    v10 = {
        Name = "PortraitFallback",
        Parent = v6,
        Position = UDim2.fromOffset(8, 8),
        Size = UDim2.new(1, -16, 1, -16),
        BackgroundColor3 = Theme.Menu.PanelInset,
        BackgroundTransparency = 0,
        Text = _scope:Computed(function(a1) -- Line: 293 -- upvalues: p1 (val)
            local v1 = a1(p1._speaker)
            if v1 == "" then
                return "?"
            end
            return (string.sub(v1, 1, 1))
        end),
        Font = Theme.Menu.Fonts.Title,
        TextColor3 = Theme.Menu.Accent,
        TextScaled = true,
        Visible = _scope:Computed(function(a1) -- Line: 300 -- upvalues: p1 (val), u295 (val)
            local v1 = if a1(p1._portrait) == "" then not u295 else false
            return v1
        end),
        ZIndex = Theme.ZIndex.Modal + 4,
    }
    local Children_3 = _scope.Children
    local v12 = {}
    local v13 = _scope:New("UICorner")
    v13 = v13({CornerRadius = UDim.new(0, (math.max(2, Theme.Menu.CornerRadius - 2)))})
    local v14 = _scope:New("UITextSizeConstraint")
    v12[1] = v13
    v12[2] = v14({MaxTextSize = 72})
    v10[Children_3] = v12
    v8(v10)
    v8 = _scope:Computed(function(p1) -- Line: 312 -- upvalues: u66 (val), u74 (val)
        local v1 = p1(u66)
        local v2 = v1 + p1(u74)
        return UDim2.fromOffset(v2, 0)
    end)
    v10 = _scope:Computed(function(p1) -- Line: 315 -- upvalues: u66 (val), u74 (val), u70 (val)
        local v1 = p1(u66)
        local v2 = -(v1 + p1(u74))
        return UDim2.new(1, v2, 0, p1(u70))
    end)
    v11 = UIKit.Card({
        Name = "TextPanel",
        StrokeThickness = 2,
        ClipsDescendants = true,
        scope = _scope,
        Parent = u179,
        Position = v8,
        Size = v10,
        BackgroundColor3 = Theme.Menu.PanelDeep,
        StrokeColor3 = Theme.Menu.Border,
        ZIndex = Theme.ZIndex.Modal + 2,
    })
    v12 = _scope:New("TextLabel")
    v13 = {
        Name = "Speaker",
        Parent = v11,
        Position = UDim2.fromScale(0.055, 0.08),
        Size = UDim2.fromScale(0.89, 0.25),
        BackgroundTransparency = 1,
        Text = p1._speaker,
        Font = Theme.Menu.Fonts.Title,
        TextColor3 = Theme.Menu.Accent,
        TextScaled = true,
        TextStrokeColor3 = Theme.Menu.HeaderStroke,
        TextStrokeTransparency = 0.1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = Theme.ZIndex.Modal + 5,
    }
    local Children_4 = _scope.Children
    local v15 = {}
    local v16 = _scope:New("UITextSizeConstraint")
    v15[1] = v16({MinTextSize = 12, MaxTextSize = 26})
    v13[Children_4] = v15
    v12(v13)
    v12 = _scope:New("TextLabel")
    v13 = {
        Name = "Body",
        Parent = v11,
        Position = UDim2.fromScale(0.055, 0.32),
        Size = UDim2.fromScale(0.89, 0.58),
        BackgroundTransparency = 1,
        Text = p1._line,
        MaxVisibleGraphemes = p1._visibleGraphemes,
        Font = Theme.Menu.Fonts.Body,
        TextColor3 = Theme.Menu.Text,
        TextScaled = true,
        TextWrapped = true,
        TextStrokeColor3 = Theme.Menu.HeaderStroke,
        TextStrokeTransparency = 0.1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = Theme.ZIndex.Modal + 5,
    }
    local Children_5 = _scope.Children
    v15 = {}
    v16 = _scope:New("UITextSizeConstraint")
    v15[1] = v16({MinTextSize = 11, MaxTextSize = 19})
    v13[Children_5] = v15
    v12(v13)
    p1._optionsFrame = UIKit.ScrollList({
        Name = "Options",
        CanvasPadding = 0,
        ContentPadding = 2,
        ScrollBarThickness = 3,
        scope = _scope,
        Parent = u179,
        Position = _scope:Computed(function(p1) -- Line: 377 -- upvalues: u66 (val), u74 (val), u70 (val)
            local v1 = p1(u66)
            local v2 = v1 + p1(u74)
            return UDim2.fromOffset(v2, p1(u70) + 4)
        end),
        Size = _scope:Computed(function(p1) -- Line: 380 -- upvalues: u66 (val), u74 (val), u82 (val)
            local v1 = p1(u66)
            local v2 = -(v1 + p1(u74))
            return UDim2.new(1, v2, 0, p1(u82))
        end),
        Visible = _scope:Computed(function(a1) -- Line: 383 -- upvalues: p1 (val)
            local v1 = a1(p1._optionCount)
            local v2 = 0 < v1
            return v2
        end),
        Padding = UDim.new(0, 4),
        ZIndex = Theme.ZIndex.Modal + 6,
        Children = v3,
    })
    p1._optionsFrame.Selectable = false
    local function hintIcon(a1, p2) -- Line: 395 -- upvalues: _scope (val), p1 (val), Icons (upval), Theme (upval)
        local v1 = _scope:New("ImageLabel")
        return v1({
            Name = "Icon",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, p2, 0.5, 0),
            Size = UDim2.new(0, 22, 1, -4),
            Image = _scope:Computed(function(a1_2) -- Line: 402 -- upvalues: p1 (upval), Icons (upval), a1 (val)
                a1_2(p1._inputMethod)
                return Icons.Resolve(a1, false)
            end),
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = Theme.ZIndex.Modal + 7,
        })
    end
    local function hintLabel(p1, p2) -- Line: 411 -- upvalues: _scope (val), Theme (upval)
        local v1 = _scope:New("TextLabel")
        local v2 = {
            Name = "Text",
            Position = UDim2.fromOffset(p2, 0),
            Size = UDim2.new(1, -p2, 1, 0),
            BackgroundTransparency = 1,
            Text = p1,
            Font = Theme.Menu.Fonts.Body,
            TextColor3 = Theme.Menu.Text,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = Theme.ZIndex.Modal + 7,
        }
        local v3 = {}
        local v4 = _scope:New("UITextSizeConstraint")
        v3[1] = v4({MinTextSize = 10, MaxTextSize = 14})
        v2[_scope.Children] = v3
        return v1(v2)
    end
    local function hintItem(p1, p2, p3) -- Line: 429 -- upvalues: _scope (val), hintIcon (val), hintLabel (val)
        local v1 = _scope:New("Frame")
        local v2 = {BackgroundTransparency = 1, Size = UDim2.new(0.3333333333333333, -4, 1, 0), LayoutOrder = p3}
        local v3 = {}
        local v4 = hintIcon(p1, 0)
        v3[1] = v4
        v3[2] = hintLabel(p2, 26)
        v2[_scope.Children] = v3
        return v1(v2)
    end
    v16 = _scope:New("Frame")
    local v17 = {
        Name = "GamepadHints",
        Parent = u179,
        Position = _scope:Computed(function(p1) -- Line: 457 -- upvalues: u66 (val), u74 (val), u70 (val), u82 (val)
            local v1 = p1(u66)
            local v2 = v1 + p1(u74)
            local v3 = p1(u70)
            return UDim2.fromOffset(v2, v3 + p1(u82) + 6)
        end),
        Size = _scope:Computed(function(p1) -- Line: 460 -- upvalues: u66 (val), u74 (val), u86 (val)
            local v1 = p1(u66)
            local v2 = -(v1 + p1(u74))
            return UDim2.new(1, v2, 0, (math.max(0, p1(u86) - 6)))
        end),
        BackgroundTransparency = 1,
        Visible = _scope:Computed(function(a1) -- Line: 464 -- upvalues: p1 (val)
            local v1 = false
            local v2 = a1(p1._optionCount)
            if 0 < v2 then
                v1 = a1(p1._inputMethod) == "Gamepad"
            end
            return v1
        end),
        ZIndex = Theme.ZIndex.Modal + 6,
    }
    local Children_6 = _scope.Children
    local v18 = {}
    local v19 = _scope:New("UIListLayout")
    v19 = v19({FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Left, SortOrder = Enum.SortOrder.LayoutOrder})
    local v20 = hintItem(Enum.KeyCode.ButtonA, "Select", 2)
    v18[1] = v19
    v18[2] = (function() -- Line: 441 -- upvalues: _scope (val), hintIcon (val), hintLabel (val)
        local v1 = _scope:New("Frame")
        local v2 = {BackgroundTransparency = 1, Size = UDim2.new(0.3333333333333333, -4, 1, 0), LayoutOrder = 1}
        local v3 = {}
        local v4 = hintIcon(Enum.KeyCode.DPadUp, 0)
        local v5 = hintIcon(Enum.KeyCode.DPadDown, 24)
        v3[1] = v4
        v3[2] = v5
        v3[3] = hintLabel("Navigate", 50)
        v2[_scope.Children] = v3
        return v1(v2)
    end)()
    v18[3] = v20
    v18[4] = hintItem(Enum.KeyCode.ButtonB, "Leave", 3)
    v17[Children_6] = v18
    v16(v17)
    v16 = _scope:New("Sound")
    local u554 = v16({
        Name = "TypewriterClick",
        Volume = 0.12,
        PlaybackSpeed = 1.05,
        Parent = v4,
        SoundId = _callbacks.ClickSound,
    })
    p1._clickSound = u554
    task.spawn(function() -- Line: 488 -- upvalues: ContentProvider (upval), u554 (val)
        pcall(function() -- Line: 489 -- upvalues: ContentProvider (upval), u554 (upval)
            ContentProvider:PreloadAsync({u554})
        end)
    end)
end
function u55.new(p1) -- Line: 495 -- upvalues: Fusion (val), fusion_utils (val), u55 (val)
    local v1 = {_destroyed = false}
    local v2 = p1
    if not v2 then
        v2 = {}
    end
    v1._callbacks = v2
    v1._buttons = {}
    v1._scope = Fusion.scoped(Fusion, fusion_utils)
    local v3 = setmetatable(v1, u55)
    v1, v2 = pcall(v3._initialize, v3)
    if not v1 then
        local v4, v5
        v4, v5 = pcall(v3.Destroy, v3)
        if not v4 then
            warn("[DialogueUI] Failed to clean up initialization:", v5)
        end
        error(v2, 0)
    end
    return v3
end
function u55.SetSpeaker(p1, p2) -- Line: 513
    p1._speaker:set(p2 or "")
end
function u55.SetPortrait(p1, p2) -- Line: 517
    p1._portrait:set(p2 or "")
end
function u55.SetLine(p1, p2, p3) -- Line: 521
    local v1
    p1._line:set(p2 or "")
    if p3 ~= nil then
        v1 = p3
    else
        v1 = -1
    end
    p1._visibleGraphemes:set(v1)
end
function u55.SetVisibleGraphemes(p1, p2) -- Line: 526
    p1._visibleGraphemes:set(p2)
end
function u55.PlayTypeSound(p1) -- Line: 530
    if p1._clickSound and p1._clickSound.Parent then
        p1._clickSound.TimePosition = 0
        p1._clickSound:Play()
    end
end
function u55.SetOptions(p1, p2, p3) -- Line: 537
    p1._buttons = {}
    p1._optionCallback = p3
    p1._selectedIndex:set(0)
    p1._optionsFrame.CanvasPosition = Vector2.new(0, 0)
    p1._optionCount:set(#p2)
    p1._options:set(p2)
end
function u55.ClearOptions(p1) -- Line: 546
    p1._optionCallback = nil
    p1._buttons = {}
    p1._selectedIndex:set(0)
    p1._optionCount:set(0)
    p1._options:set({})
end
function u55.SetSelectedIndex(p1, p2) -- Line: 554
    if p1._destroyed then
        return
    end
    p1._selectedIndex:set(p2)
    if p2 < 1 then
        return
    end
    task.defer(function() -- Line: 562 -- upvalues: p1 (val), p2 (val)
        if p1._destroyed then
            return
        end
        local _optionsFrame = p1._optionsFrame
        local v1 = p1._buttons[p2]
        if not _optionsFrame or not _optionsFrame.Parent or not v1 or not v1.Parent then
            return
        end
        local v2 = v1.AbsolutePosition.Y - _optionsFrame.AbsolutePosition.Y + _optionsFrame.CanvasPosition.Y
        local v3 = v2 + v1.AbsoluteSize.Y
        local v4 = _optionsFrame.CanvasPosition.Y + _optionsFrame.AbsoluteWindowSize.Y
        if v2 < _optionsFrame.CanvasPosition.Y then
            _optionsFrame.CanvasPosition = Vector2.new(0, (math.max(0, v2)))
            return
        end
        if v4 < v3 then
            _optionsFrame.CanvasPosition = Vector2.new(0, (math.max(0, v3 - _optionsFrame.AbsoluteWindowSize.Y)))
        end
    end)
end
function u55.GetSelectedIndex(p1) -- Line: 582 -- upvalues: Fusion (val)
    return Fusion.peek(p1._selectedIndex)
end
function u55:ActivateOption(p2) -- Line: 586 -- upvalues: Fusion (val)
    if self._destroyed or p2 < 1 or Fusion.peek(self._optionCount) < p2 then
        return
    end
    if self._optionCallback then
        self._optionCallback(p2)
    end
end
function u55:Destroy() -- Line: 595
    if self._destroyed then
        return
    end
    self._destroyed = true
    self._callbacks = {}
    self._optionCallback = nil
    if self.ScreenGui then
        self.ScreenGui.Enabled = false
    end
    self._scope:doCleanup()
end
return u55