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

function u55._initialize(p1) -- Line: 44
    -- upvalues: BindUtil (val), fusion_utils (val), UIKit (val), selectedBackground (val), Theme (val), Players (val)
    -- upvalues: OnEvent (val), Fusion (val), BottomStack (val), DialoguePortrait (val), Icons (val)
    -- upvalues: ContentProvider (val)
    local _callbacks = p1._callbacks
    local _scope = p1._scope
    p1._speaker = _scope:Value("")
    p1._portrait = _scope:Value("")
    p1._line = _scope:Value("")
    p1._visibleGraphemes = _scope:Value(-1)
    p1._options = _scope:Value({})
    p1._optionCount = _scope:Value(0)
    p1._selectedIndex = _scope:Value(0)
    local v1 = BindUtil
    v1 = v1.getInputMethod()
    p1._inputMethod = _scope:Value(v1)
    p1._stackOffset = _scope:Value(0)
    local _stackOffset = p1._stackOffset
    local v2 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local u49 = _scope:Tween(_stackOffset, v2)
    local v3 = fusion_utils
    local usePx = v3.usePx
    v2 = Vector2.new(1600, 900)
    local u62 = usePx(_scope, v2, 0.58, 0.5)(1)
    local u66 = _scope:Computed(function(p1) -- Line: 61 -- upvalues: u62 (val)
        local v1 = u62
        local v2 = (p1(v1)) * 104
        local v3 = math.floor(v2)
        return (math.max(84, v3))
    end)
    local u70 = _scope:Computed(function(p1) -- Line: 64 -- upvalues: u62 (val)
        local v1 = u62
        local v2 = (p1(v1)) * 104
        local v3 = math.floor(v2)
        return (math.max(84, v3))
    end)
    local u74 = _scope:Computed(function(p1) -- Line: 67 -- upvalues: u62 (val)
        local v1 = u62
        local v2 = (p1(v1)) * 8
        local v3 = math.floor(v2)
        return (math.max(6, v3))
    end)
    local u78 = _scope:Computed(function(p1) -- Line: 70 -- upvalues: u62 (val)
        local v1 = u62
        local v2 = (p1(v1)) * 34
        local v3 = math.floor(v2)
        return (math.max(32, v3))
    end)
    local u82 = _scope:Computed(function(p1_2) -- Line: 73 -- upvalues: p1 (val), u78 (val)
        local v1 = p1_2(p1._optionCount)
        if v1 == 0 then
            return 0
        end
        local v2 = math.min(v1, 4)
        local v3 = v2 * p1_2(u78)
        local v4 = v2 - 1
        return v3 + math.max(v4, 0) * 4 + 4
    end)
    local u86 = _scope:Computed(function(p1_2) -- Line: 81 -- upvalues: p1 (val), u62 (val)
        if p1_2(p1._optionCount) ~= 0 and p1_2(p1._inputMethod) == "Gamepad" then
            local v1 = u62
            local v2 = (p1_2(v1)) * 26
            local v3 = math.floor(v2)
            return math.max(22, v3) + 6
        end
        return 0
    end)
    local u90 = _scope:Computed(function(p1) -- Line: 87 -- upvalues: u70 (val), u82 (val), u86 (val)
        return (p1(u70)) + p1(u82) + p1(u86)
    end)
    local _options = p1._options
    local v4 = _scope:ForValues(_options, function(p1_2, p2, p3) -- Line: 91
        -- upvalues: p1 (val), UIKit (upval), u78 (val), selectedBackground (upval), Theme (upval)
        local Accent, Gradient
        local u6 = p2:Computed(function(p1_2) -- Line: 92 -- upvalues: p1 (upval), p3 (val)
            local v1 = (p1_2(p1._selectedIndex)) == p3.index
            return v1
        end)
        local Card = UIKit.Card
        local v1 = {StrokeThickness = 2, scope = p2}
        local index = p3.index
        v1.Name = "Option_" .. tostring(index)
        v1.Size = p2:Computed(function(p1) -- Line: 99 -- upvalues: u78 (upval)
            return UDim2.new(1, -2, 0, p1(u78))
        end)
        v1.LayoutOrder = p3.index
        v1.BackgroundColor3 = p2:Computed(function(p1) -- Line: 103 -- upvalues: selectedBackground (upval), u6 (val), p3 (val)
            local v1 = selectedBackground
            return (v1(p1(u6), p3.style))
        end)
        v1.StrokeColor3 = p2:Computed(function(p1) -- Line: 106 -- upvalues: u6 (val), p3 (val), Theme (upval)
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
        end)
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
            local v1 = p1
            local v2 = p3
            local index = v2.index
            v1:ActivateOption(index)
        end

        local v2 = {}
        local v3 = p2:New("TextLabel")
        local v4 = {
            Name = "Label",
            Size = UDim2.new(1, -20, 1, -8),
            Position = UDim2.fromOffset(10, 4),
            BackgroundTransparency = 1,
            Text = p2:Computed(function(p1_2) -- Line: 124 -- upvalues: p1 (upval), p3 (val)
                if p1_2(p1._inputMethod) == "Gamepad" then
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
        v4[Children] = {p2:New("UITextSizeConstraint")({MinTextSize = 11, MaxTextSize = 16})}
        v2[1] = v3(v4)
        v1.Children = v2
        local u106 = Card(v1)
        u106.Selectable = false
        p1._buttons[p3.index] = u106
        v2 = u106.Destroying:Connect(function() -- Line: 148 -- upvalues: p1 (upval), p3 (val), u106 (ref)
            if p1._buttons[p3.index] == u106 then
                p1._buttons[p3.index] = nil
            end
        end)
        table.insert(p2, v2)
        return u106
    end)
    local v5 = _scope:New("ScreenGui")({
        Name = "FusionDialogue",
        ResetOnSpawn = false,
        ClipToDeviceSafeArea = true,
        DisplayOrder = 30,
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        ScreenInsets = Enum.ScreenInsets.CoreUISafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    p1.ScreenGui = v5
    local v6 = _scope:New("TextButton")
    local v7 = {
        Name = "InputShield",
        Parent = v5,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Selectable = false,
        ZIndex = Theme.ZIndex.Modal,
    }
    local Activated = OnEvent("Activated")

    v7[Activated] = function() -- Line: 178 -- upvalues: p1 (val)
        if p1._callbacks.OnAdvance then
            p1._callbacks.OnAdvance()
        end
    end

    v6(v7)
    v6 = fusion_utils
    local useEventListener = v6.useEventListener
    local v8 = BindUtil
    local InputMethodChanged = v8.InputMethodChanged
    useEventListener(_scope, InputMethodChanged, function(p1_2) -- Line: 185 -- upvalues: p1 (val), Fusion (upval)
        local v1
        if p1._destroyed then
            return
        end
        p1._inputMethod:set(p1_2)
        if Fusion.peek(p1._optionCount) == 0 then
            return
        end
        local _selectedIndex = p1._selectedIndex
        if p1_2 ~= "Gamepad" then
            v1 = 0
        else
            v1 = 1
        end
        _selectedIndex:set(v1)
    end)
    v6 = _scope:New("Frame")
    v7 = {
        Name = "DialogueBanner",
        Parent = v5,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = _scope:Computed(function(p1) -- Line: 200 -- upvalues: u62 (val), u49 (val)
            local v1 = u62
            local v2 = (p1(v1)) * 64
            local v3 = math.floor(v2)
            local v4 = math.max(48, v3)
            return UDim2.new(0.5, 0, 1, -(v4 + p1(u49)))
        end),
        Size = _scope:Computed(function(p1) -- Line: 204 -- upvalues: u90 (val)
            return UDim2.new(0.66, 0, 0, p1(u90))
        end),
        BackgroundTransparency = 1,
        ZIndex = Theme.ZIndex.Modal + 1,
    }
    local Children = _scope.Children
    v7[Children] = {_scope:New("UISizeConstraint")({MinSize = Vector2.new(320, 84), MaxSize = Vector2.new(720, 340)})}
    local u179 = v6(v7)
    v7 = BottomStack
    local Register = v7.Register
    v8 = {
        Name = "LobbyDialogue",
        Layer = BottomStack.Layers.Dialogue,
        Reserve = function() -- Line: 219 -- upvalues: Fusion (upval), u62 (val), u179 (val)
            local v1 = Fusion
            local peek = v1.peek
            local v2 = u62
            local v3 = (peek(v2)) * 64
            local v4 = math.floor(v3)
            return (math.max(48, v4)) + u179.AbsoluteSize.Y
        end,
        Bottom = function() -- Line: 223 -- upvalues: Fusion (upval), u62 (val)
            local v1 = Fusion
            local peek = v1.peek
            local v2 = u62
            local v3 = (peek(v2)) * 64
            local v4 = math.floor(v3)
            return (math.max(48, v4))
        end,
        Apply = function(p1_2) -- Line: 226 -- upvalues: p1 (val)
            p1._stackOffset:set(p1_2)
        end,
    }
    p1._bottomStack = Register(v8)
    table.insert(_scope, function() -- Line: 230 -- upvalues: p1 (val)
        if p1._bottomStack then
            p1._bottomStack:Destroy()
            p1._bottomStack = nil
        end
    end)
    p1._bottomStack:SetOccupying(true)
    local v9 = (u179:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 239 -- upvalues: p1 (val)
        if not p1._destroyed and p1._bottomStack then
            p1._bottomStack:Invalidate()
        end
    end)
    table.insert(_scope, v9)
    v7 = UIKit
    v7 = v7.Card({
        Name = "PortraitPanel",
        StrokeThickness = 2,
        ClipsDescendants = true,
        scope = _scope,
        Parent = u179,
        Position = UDim2.fromScale(0, 0),
        Size = _scope:Computed(function(p1) -- Line: 251 -- upvalues: u66 (val), u70 (val)
            return UDim2.fromOffset(p1(u66), p1(u70))
        end),
        BackgroundColor3 = Theme.Menu.PanelDeep,
        StrokeColor3 = Theme.Menu.Border,
        ZIndex = Theme.ZIndex.Modal + 2,
    })
    v8 = _scope:New("ImageLabel")
    v9 = {
        Name = "Portrait",
        Parent = v7,
        Position = UDim2.fromOffset(8, 8),
        Size = UDim2.new(1, -16, 1, -16),
        BackgroundColor3 = Theme.Menu.PanelInset,
        BackgroundTransparency = 0,
        Image = p1._portrait,
        ScaleType = Enum.ScaleType.Crop,
        Visible = _scope:Computed(function(p1_2) -- Line: 270 -- upvalues: p1 (val)
            local v1 = p1_2(p1._portrait) ~= ""
            return v1
        end),
        ZIndex = Theme.ZIndex.Modal + 4,
    }
    local Children_2 = _scope.Children
    local v10 = {}
    local v11 = _scope:New("UICorner")
    local v12 = {}
    local new_2 = UDim.new
    local v13 = Theme
    local v14 = v13.Menu.CornerRadius - 2
    v12.CornerRadius = new_2(0, (math.max(2, v14)))
    v10[1] = v11(v12)
    v9[Children_2] = v10
    v8(v9)
    v8 = _scope:Computed(function(p1_2) -- Line: 280 -- upvalues: p1 (val)
        local v1 = p1_2(p1._portrait) == ""
        return v1
    end)
    local u295 = DialoguePortrait.create(_scope, v7, _callbacks.Npc, v8, Theme.ZIndex.Modal + 3)
    local v15 = _scope:New("TextLabel")
    v10 = {
        Name = "PortraitFallback",
        Parent = v7,
        Position = UDim2.fromOffset(8, 8),
        Size = UDim2.new(1, -16, 1, -16),
        BackgroundColor3 = Theme.Menu.PanelInset,
        BackgroundTransparency = 0,
        Text = _scope:Computed(function(p1_2) -- Line: 293 -- upvalues: p1 (val)
            local v1 = p1_2(p1._speaker)
            if v1 == "" then
                return "?"
            end
            return (string.sub(v1, 1, 1))
        end),
        Font = Theme.Menu.Fonts.Title,
        TextColor3 = Theme.Menu.Accent,
        TextScaled = true,
        Visible = _scope:Computed(function(p1_2) -- Line: 300 -- upvalues: p1 (val), u295 (val)
            local v1 = false
            if p1_2(p1._portrait) == "" then
                v1 = not u295
            end
            return v1
        end),
        ZIndex = Theme.ZIndex.Modal + 4,
    }
    local Children_3 = _scope.Children
    v12 = {}
    local v16 = _scope:New("UICorner")
    local v17 = {}
    local new_3 = UDim.new
    local v18 = Theme
    local v19 = v18.Menu.CornerRadius - 2
    v17.CornerRadius = new_3(0, (math.max(2, v19)))
    v16 = v16(v17)
    v17 = _scope:New("UITextSizeConstraint")
    v12[1] = v16
    v12[2] = v17({MaxTextSize = 72})
    v10[Children_3] = v12
    v15(v10)
    v15 = _scope:Computed(function(p1) -- Line: 312 -- upvalues: u66 (val), u74 (val)
        return UDim2.fromOffset((p1(u66)) + p1(u74), 0)
    end)
    v10 = _scope:Computed(function(p1) -- Line: 315 -- upvalues: u66 (val), u74 (val), u70 (val)
        return UDim2.new(1, -((p1(u66)) + p1(u74)), 0, p1(u70))
    end)
    v11 = UIKit
    v11 = v11.Card({
        Name = "TextPanel",
        StrokeThickness = 2,
        ClipsDescendants = true,
        scope = _scope,
        Parent = u179,
        Position = v15,
        Size = v10,
        BackgroundColor3 = Theme.Menu.PanelDeep,
        StrokeColor3 = Theme.Menu.Border,
        ZIndex = Theme.ZIndex.Modal + 2,
    })
    v12 = _scope:New("TextLabel")
    v16 = {
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
    v16[Children_4] = {_scope:New("UITextSizeConstraint")({MinTextSize = 12, MaxTextSize = 26})}
    v12(v16)
    v12 = _scope:New("TextLabel")
    v16 = {
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
    v16[Children_5] = {_scope:New("UITextSizeConstraint")({MinTextSize = 11, MaxTextSize = 19})}
    v12(v16)
    local ScrollList = UIKit.ScrollList
    v16 = {
        Name = "Options",
        CanvasPadding = 0,
        ContentPadding = 2,
        ScrollBarThickness = 3,
        scope = _scope,
        Parent = u179,
        Position = _scope:Computed(function(p1) -- Line: 377 -- upvalues: u66 (val), u74 (val), u70 (val)
            return UDim2.fromOffset((p1(u66)) + p1(u74), p1(u70) + 4)
        end),
        Size = _scope:Computed(function(p1) -- Line: 380 -- upvalues: u66 (val), u74 (val), u82 (val)
            return UDim2.new(1, -((p1(u66)) + p1(u74)), 0, p1(u82))
        end),
        Visible = _scope:Computed(function(p1_2) -- Line: 383 -- upvalues: p1 (val)
            local v1 = 0 < (p1_2(p1._optionCount))
            return v1
        end),
        Padding = UDim.new(0, 4),
        ZIndex = Theme.ZIndex.Modal + 6,
        Children = v4,
    }
    p1._optionsFrame = ScrollList(v16)
    p1._optionsFrame.Selectable = false

    local function hintIcon(p1_2, p2) -- Line: 395 -- upvalues: _scope (val), p1 (val), Icons (upval), Theme (upval)
        local v1 = _scope:New("ImageLabel")
        local v2 = {
            Name = "Icon",
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, p2, 0.5, 0),
            Size = UDim2.new(0, 22, 1, -4),
        }
        local v3 = _scope
        v2.Image = v3:Computed(function(p1_3) -- Line: 402 -- upvalues: p1 (upval), Icons (upval), p1_2 (val)
            p1_3(p1._inputMethod)
            return Icons.Resolve(p1_2, false)
        end)
        v2.ScaleType = Enum.ScaleType.Fit
        v2.ZIndex = Theme.ZIndex.Modal + 7
        return v1(v2)
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
        local v3 = _scope
        local Children = v3.Children
        v2[Children] = {_scope:New("UITextSizeConstraint")({MinTextSize = 10, MaxTextSize = 14})}
        return v1(v2)
    end

    local function hintItem(p1, p2, p3) -- Line: 429 -- upvalues: _scope (val), hintIcon (val), hintLabel (val)
        local v1 = _scope:New("Frame")
        local v2 = {BackgroundTransparency = 1, Size = UDim2.new(0.3333333333333333, -4, 1, 0), LayoutOrder = p3}
        local v3 = _scope
        local Children = v3.Children
        v2[Children] = {hintIcon(p1, 0), hintLabel(p2, 26)}
        return v1(v2)
    end

    local function navigationHint() -- Line: 441 -- upvalues: _scope (val), hintIcon (val), hintLabel (val)
        local v1 = _scope:New("Frame")
        local v2 = {BackgroundTransparency = 1, Size = UDim2.new(0.3333333333333333, -4, 1, 0), LayoutOrder = 1}
        local v3 = _scope
        local Children = v3.Children
        local v4 = {}
        local v5 = hintIcon(Enum.KeyCode.DPadUp, 0)
        local v6 = hintIcon(Enum.KeyCode.DPadDown, 24)
        v4[1] = v5
        v4[2] = v6
        v4[3] = hintLabel("Navigate", 50)
        v2[Children] = v4
        return v1(v2)
    end

    local v20 = _scope:New("Frame")
    v14 = {
        Name = "GamepadHints",
        Parent = u179,
        Position = _scope:Computed(function(p1) -- Line: 457 -- upvalues: u66 (val), u74 (val), u70 (val), u82 (val)
            return UDim2.fromOffset((p1(u66)) + p1(u74), (p1(u70)) + p1(u82) + 6)
        end),
        Size = _scope:Computed(function(p1) -- Line: 460 -- upvalues: u66 (val), u74 (val), u86 (val)
            local new = UDim2.new
            local v1 = -((p1(u66)) + p1(u74))
            local v2 = u86
            local v3 = (p1(v2)) - 6
            return new(1, v1, 0, (math.max(0, v3)))
        end),
        BackgroundTransparency = 1,
        Visible = _scope:Computed(function(p1_2) -- Line: 464 -- upvalues: p1 (val)
            local v1 = false
            if 0 < (p1_2(p1._optionCount)) then
                v1 = p1_2(p1._inputMethod) == "Gamepad"
            end
            return v1
        end),
        ZIndex = Theme.ZIndex.Modal + 6,
    }
    local Children_6 = _scope.Children
    v19 = {}
    v18 = _scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    local v21 = navigationHint()
    local v22 = hintItem(Enum.KeyCode.ButtonA, "Select", 2)
    v19[1] = v18
    v19[2] = v21
    v19[3] = v22
    v19[4] = hintItem(Enum.KeyCode.ButtonB, "Leave", 3)
    v14[Children_6] = v19
    v20(v14)
    local u554 = _scope:New("Sound")({
        Name = "TypewriterClick",
        Volume = 0.12,
        PlaybackSpeed = 1.05,
        Parent = v5,
        SoundId = _callbacks.ClickSound,
    })
    p1._clickSound = u554
    task.spawn(function() -- Line: 488 -- upvalues: ContentProvider (upval), u554 (val)
        pcall(function() -- Line: 489 -- upvalues: ContentProvider (upval), u554 (upval)
            local v1 = ContentProvider
            local v2 = {u554}
            v1:PreloadAsync(v2)
        end)
    end)
end

function u55.new(p1) -- Line: 495 -- upvalues: Fusion (val), fusion_utils (val), u55 (val)
    local v1 = {_destroyed = false}
    local v2 = p1 or {}
    v1._callbacks = v2
    v1._buttons = {}
    v1._scope = Fusion.scoped(Fusion, fusion_utils)
    v2 = u55
    local v3 = setmetatable(v1, v2)
    local success, result = pcall(v3._initialize, v3)
    if not success then
        local success_2, result_2 = pcall(v3.Destroy, v3)
        if not success_2 then
            warn("[DialogueUI] Failed to clean up initialization:", result_2)
        end
        error(result, 0)
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
    local _visibleGraphemes = p1._visibleGraphemes
    if p3 ~= nil then
        v1 = p3
    else
        v1 = -1
    end
    _visibleGraphemes:set(v1)
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
    local _optionCount = p1._optionCount
    local v1 = #p2
    _optionCount:set(v1)
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
        if _optionsFrame and _optionsFrame.Parent and v1 and v1.Parent then
            local v2 = v1.AbsolutePosition.Y - _optionsFrame.AbsolutePosition.Y + _optionsFrame.CanvasPosition.Y
            local v3 = v2 + v1.AbsoluteSize.Y
            local v4 = _optionsFrame.CanvasPosition.Y + _optionsFrame.AbsoluteWindowSize.Y
            if v2 < _optionsFrame.CanvasPosition.Y then
                _optionsFrame.CanvasPosition = Vector2.new(0, (math.max(0, v2)))
                return
            end
            if v4 < v3 then
                local new = Vector2.new
                local v5 = v3 - _optionsFrame.AbsoluteWindowSize.Y
                _optionsFrame.CanvasPosition = new(0, (math.max(0, v5)))
            end
            return
        end
    end)
end

function u55.GetSelectedIndex(p1) -- Line: 582 -- upvalues: Fusion (val)
    return Fusion.peek(p1._selectedIndex)
end

function u55:ActivateOption(p2) -- Line: 586 -- upvalues: Fusion (val)
    if not self._destroyed and not (p2 < 1) and not (Fusion.peek(self._optionCount) < p2) then
        if self._optionCallback then
            self._optionCallback(p2)
        end
        return
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