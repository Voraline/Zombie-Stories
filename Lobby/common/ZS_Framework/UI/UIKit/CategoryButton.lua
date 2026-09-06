local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u13 = require("../Theme")
local ButtonFeedback = require(script.Parent.ButtonFeedback)
local UISounds = require(script.Parent.UISounds)
return function(p1) -- Line: 62 -- upvalues: u13 (val), OnEvent (val), peek (val), UISounds (val), ButtonFeedback (val)
    local Children, Disabled, Selected, Visible, v1
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u13.ZIndex.Content
    end
    if type(p1.Selected) ~= "boolean" then
        Selected = p1.Selected
        if not Selected then
            Selected = scope:Value(false)
        end
    else
        Selected = scope:Value(p1.Selected)
    end
    if type(p1.Disabled) ~= "boolean" then
        Disabled = p1.Disabled
        if not Disabled then
            Disabled = scope:Value(false)
        end
    else
        Disabled = scope:Value(p1.Disabled)
    end
    local AccentColor3 = p1.AccentColor3
    if not AccentColor3 then
        AccentColor3 = u13.Menu.Accent
    end
    local u44 = scope:Value(false)
    local v2 = scope:Computed(function(a1) -- Line: 74 -- upvalues: Disabled (val), p1 (val), u13 (upval), Selected (val), u44 (val)
        local v1
        if a1(Disabled) then
            local DisabledBackgroundColor3 = p1.DisabledBackgroundColor3
            if not DisabledBackgroundColor3 then
                DisabledBackgroundColor3 = u13.Menu.PanelInset
            end
            v1 = DisabledBackgroundColor3
        elseif not (a1(Selected)) then
            local UnselectedBackgroundColor3 = p1.UnselectedBackgroundColor3
            if not UnselectedBackgroundColor3 then
                UnselectedBackgroundColor3 = Color3.fromRGB(0, 0, 0)
            end
            v1 = UnselectedBackgroundColor3
        else
            local SelectedBackgroundColor3 = p1.SelectedBackgroundColor3
            if not SelectedBackgroundColor3 then
                SelectedBackgroundColor3 = u13.Menu.Selected
            end
            v1 = SelectedBackgroundColor3
        end
        local v2 = a1(v1)
        if a1(Disabled) or not (a1(u44)) then
            return v2
        end
        local v3 = Color3.new(0, 0, 0)
        return (v2:Lerp(v3, 0.14))
    end)
    local v3 = scope:Computed(function(a1) -- Line: 86 -- upvalues: Disabled (val), p1 (val), Selected (val)
        if a1(Disabled) then
            return p1.DisabledBackgroundTransparency or 0.35
        end
        if a1(Selected) then
            return p1.SelectedBackgroundTransparency or 0
        end
        return p1.UnselectedBackgroundTransparency or 0.8
    end)
    local v4 = scope:Computed(function(a1) -- Line: 94 -- upvalues: Disabled (val), p1 (val), u13 (upval), Selected (val), AccentColor3 (val), u44 (val)
        local SelectedStrokeColor3, v1
        if a1(Disabled) then
            local DisabledStrokeColor3 = p1.DisabledStrokeColor3
            if not DisabledStrokeColor3 then
                DisabledStrokeColor3 = u13.Menu.Border
            end
            return DisabledStrokeColor3
        end
        local v2 = a1(Selected)
        if not v2 then
            SelectedStrokeColor3 = p1.UnselectedStrokeColor3
            if not SelectedStrokeColor3 then
                SelectedStrokeColor3 = u13.Menu.BorderUnselected
            end
        else
            SelectedStrokeColor3 = p1.SelectedStrokeColor3
            if not SelectedStrokeColor3 then
                SelectedStrokeColor3 = AccentColor3
            end
        end
        if not v2 then
            v1 = p1.UnselectedStrokeHoverColor3 or SelectedStrokeColor3
        else
            v1 = p1.SelectedStrokeHoverColor3 or SelectedStrokeColor3
        end
        if a1(u44) then
            return (a1(v1))
        end
        return (a1(SelectedStrokeColor3))
    end)
    local v5 = scope:Computed(function(a1) -- Line: 107 -- upvalues: Disabled (val), p1 (val), u13 (upval), Selected (val)
        local SelectedStrokeThickness
        if a1(Disabled) then
            local DisabledStrokeThickness = p1.DisabledStrokeThickness
            if not DisabledStrokeThickness then
                DisabledStrokeThickness = u13.Stroke.Medium
            end
            return DisabledStrokeThickness
        end
        if a1(Selected) then
            SelectedStrokeThickness = p1.SelectedStrokeThickness
            if not SelectedStrokeThickness then
                return u13.Stroke.Medium
            end
            return SelectedStrokeThickness
        end
        SelectedStrokeThickness = p1.UnselectedStrokeThickness
        if not SelectedStrokeThickness then
            SelectedStrokeThickness = u13.Stroke.Medium
        end
        return SelectedStrokeThickness
    end)
    local v6 = scope:Computed(function(a1) -- Line: 115 -- upvalues: Disabled (val), p1 (val), u13 (upval), Selected (val)
        local SelectedTextColor3
        if a1(Disabled) then
            local DisabledTextColor3 = p1.DisabledTextColor3
            if not DisabledTextColor3 then
                DisabledTextColor3 = u13.Menu.TextMuted
            end
            return DisabledTextColor3
        end
        if a1(Selected) then
            SelectedTextColor3 = p1.SelectedTextColor3
            if not SelectedTextColor3 then
                return u13.Menu.Text
            end
            return SelectedTextColor3
        end
        SelectedTextColor3 = p1.UnselectedTextColor3
        if not SelectedTextColor3 then
            SelectedTextColor3 = u13.Menu.Text
        end
        return SelectedTextColor3
    end)
    local v7 = {}
    local v8 = scope:New("UICorner")
    local v9 = {CornerRadius = u13.Menu.CornerScale}
    v8 = v8(v9)
    if p1.GradientColor == nil then
        v9 = nil
    else
        v9 = scope:New("UIGradient")
        v1 = {Color = p1.GradientColor}
        local GradientRotation = p1.GradientRotation
        if not GradientRotation then
            GradientRotation = u13.Menu.ShadeRotation
        end
        v1.Rotation = GradientRotation
        v9 = v9(v1)
    end
    v1 = scope:New("UIStroke")
    local v10 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = v4, Thickness = v5}
    v7[1] = v8
    v7[2] = v9
    v7[3] = v1(v10)
    if p1.Text ~= nil then
        v1 = scope:New("TextLabel")
        v10 = {
            Name = "Label",
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = p1.Text,
            Font = u13.Menu.Fonts.Button,
            TextColor3 = v6,
            TextScaled = true,
            TextWrapped = false,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = ZIndex + 1,
        }
        Children = scope.Children
        local v11 = {}
        local v12 = scope:New("UIPadding")
        v12 = v12({PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4)})
        local v13 = scope:New("UITextSizeConstraint")
        local v14 = {MaxTextSize = p1.TextMaxSize or 18}
        v11[1] = v12
        v11[2] = v13(v14)
        v10[Children] = v11
        table.insert(v7, v1(v10))
    end
    if p1.Children ~= nil then
        table.insert(v7, p1.Children)
    end
    local u190 = nil
    v9 = scope:New("TextButton")
    v1 = {Name = p1.Name or "CategoryButton"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.new(1, 0, 0, 44)
    end
    v1.Size = Size
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v1.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v1.AnchorPoint = AnchorPoint
    v1.LayoutOrder = p1.LayoutOrder or 0
    v1.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v1.Visible = Visible
    v1.Parent = p1.Parent
    v1.AutoButtonColor = false
    v1.Text = ""
    v1.BackgroundColor3 = v2
    v1.BackgroundTransparency = v3
    local Activated = OnEvent("Activated")
    v1[Activated] = function() -- Line: 185 -- upvalues: peek (upval), Disabled (val), p1 (val), UISounds (upval)
        if peek(Disabled) then
            return
        end
        local ButtonSound = p1.ButtonSound
        if not ButtonSound then
            ButtonSound = UISounds.ClickSound
        end
        ButtonSound:Play()
        if p1.OnClick then
            p1.OnClick()
        end
    end
    local MouseButton1Down = OnEvent("MouseButton1Down")
    v1[MouseButton1Down] = function() -- Line: 194 -- upvalues: peek (upval), Disabled (val), ButtonFeedback (upval), u190 (ref)
        if not (peek(Disabled)) then
            ButtonFeedback.Ripple(u190)
        end
    end
    local MouseEnter = OnEvent("MouseEnter")
    v1[MouseEnter] = function() -- Line: 199 -- upvalues: u44 (val), peek (upval), Disabled (val), p1 (val), UISounds (upval)
        u44:set(true)
        if not (peek(Disabled)) then
            local HoverSound = p1.HoverSound
            if not HoverSound then
                HoverSound = UISounds.HoverSound
            end
            HoverSound:Play()
        end
    end
    local MouseLeave = OnEvent("MouseLeave")
    v1[MouseLeave] = function() -- Line: 205 -- upvalues: u44 (val)
        u44:set(false)
    end
    v1[scope.Children] = v7
    u190 = v9(v1)
    return u190
end