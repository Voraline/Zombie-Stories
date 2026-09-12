local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u13 = require("../Theme")
local ButtonFeedback = require(script.Parent.ButtonFeedback)
local UISounds = require(script.Parent.UISounds)
return function(p1) -- Line: 66 -- upvalues: u13 (val), peek (val), OnEvent (val), UISounds (val), ButtonFeedback (val)
    local InteractionEnabled, Visible, v1, v2, v3, v4, v5, v6
    local scope = p1.scope
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = u13.Menu.Panel
    end
    local StrokeColor3 = p1.StrokeColor3
    if not StrokeColor3 then
        StrokeColor3 = u13.Menu.Border
    end
    if p1.InteractionEnabled ~= nil then
        InteractionEnabled = p1.InteractionEnabled
    else
        InteractionEnabled = true
    end
    local u21 = scope:Value(false)
    local v7 = true
    if p1.OnClick == nil then
        v7 = true
        if p1.HoverScale == nil then
            v7 = true
            if p1.HoverSheen ~= true then
                v7 = p1.OnHoverChanged ~= nil
            end
        end
    end
    if not v7 then
        v5 = StrokeColor3
    else
        v5 = scope:Computed(function(p1_2) -- Line: 77 -- upvalues: u21 (val), p1 (val), StrokeColor3 (val)
            if not p1_2(u21) then
                return (p1_2(StrokeColor3))
            end
            local StrokeHoverColor3 = p1.StrokeHoverColor3
            if not StrokeHoverColor3 then
                StrokeHoverColor3 = StrokeColor3
            end
            return (p1_2(StrokeHoverColor3))
        end)
    end
    if not p1.HoverScale then
        v6 = nil
    else
        v1 = scope:Computed(function(p1_2) -- Line: 83 -- upvalues: u21 (val), p1 (val)
            if p1_2(u21) then
                return p1.HoverScale
            end
            return 1
        end)
        v6 = scope:Spring(v1, 28, 1)
    end

    local function setHovering(p1_2) -- Line: 91
        -- upvalues: peek (upval), InteractionEnabled (val), u21 (val), p1 (val)
        if p1_2 and not peek(InteractionEnabled) then
            return
        end
        if peek(u21) == p1_2 then
            return
        end
        u21:set(p1_2)
        if p1.OnHoverChanged then
            p1.OnHoverChanged(p1_2)
        end
    end

    if p1.InteractionEnabled ~= nil then
        local InteractionEnabled_2 = p1.InteractionEnabled
        if type(InteractionEnabled_2) ~= "boolean" then
            local InteractionEnabled_3 = p1.InteractionEnabled
            ;(scope:Observer(InteractionEnabled_3)):onChange(function() -- Line: 105 -- upvalues: peek (upval), InteractionEnabled (val), u21 (val), p1 (val)
                if not peek(InteractionEnabled) then
                    if peek(u21) == false then
                        return
                    end
                    u21:set(false)
                    if p1.OnHoverChanged then
                        p1.OnHoverChanged(false)
                    end
                end
            end)
        end
    end
    if not p1.HoverSheen then
        v1 = nil
    else
        v2 = scope:Computed(function(p1) -- Line: 113 -- upvalues: u21 (val)
            if p1(u21) then
                return (Vector2.new(0.75, 0))
            end
            return (Vector2.new(-0.75, 0))
        end)
        v1 = scope:Spring(v2, 24, 1)
    end
    local v8 = nil
    if p1.Shade ~= false then
        v2 = scope:New("UIGradient")
        v3 = {}
        local GradientColor = p1.GradientColor
        if not GradientColor then
            GradientColor = u13.Menu.Shade
        end
        v3.Color = GradientColor
        local GradientRotation = p1.GradientRotation
        if not GradientRotation then
            GradientRotation = u13.Menu.ShadeRotation
        end
        v3.Rotation = GradientRotation
        v8 = v2(v3)
    end
    v2 = {}
    if not v6 then
        v3 = nil
    else
        v3 = scope:New("UIScale")({Scale = v6})
    end
    local v9 = scope:New("UICorner")
    local v10 = {}
    local CornerRadius = p1.CornerRadius
    if not CornerRadius then
        CornerRadius = UDim.new(0, u13.Menu.CornerRadius)
    end
    v10.CornerRadius = CornerRadius
    v9 = v9(v10)
    v10 = scope:New("UIStroke")
    local v11 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = v5}
    local StrokeThickness = p1.StrokeThickness
    if not StrokeThickness then
        StrokeThickness = u13.Stroke.Medium
    end
    v11.Thickness = StrokeThickness
    v11.Transparency = p1.StrokeTransparency or 0
    v10 = v10(v11)
    v11 = v8
    local Children = p1.Children
    if not p1.HoverSheen then
        v4 = nil
    else
        v4 = scope:New("Frame")
        local v12 = {
            Name = "HoverSheen",
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 0.9,
            BorderSizePixel = 0,
            Active = false,
        }
        local ZIndex = p1.ZIndex
        if not ZIndex then
            ZIndex = u13.ZIndex.Content
        end
        v12.ZIndex = ZIndex + 1
        local Children_2 = scope.Children
        local v13 = {}
        local v14 = scope:New("UICorner")
        local v15 = {}
        local CornerRadius_2 = p1.CornerRadius
        if not CornerRadius_2 then
            CornerRadius_2 = UDim.new(0, u13.Menu.CornerRadius)
        end
        v15.CornerRadius = CornerRadius_2
        v14 = v14(v15)
        v15 = scope:New("UIGradient")
        local v16 = {Rotation = 18, Offset = v1}
        local new = NumberSequence.new
        local v17 = {}
        local v18 = NumberSequenceKeypoint.new(0, 1)
        local v19 = NumberSequenceKeypoint.new(0.5, 0.4)
        v17[1] = v18
        v17[2] = v19
        v17[3] = NumberSequenceKeypoint.new(1, 1)
        v16.Transparency = new(v17)
        v13[1] = v14
        v13[2] = v15(v16)
        v12[Children_2] = v13
        v4 = v4(v12)
    end
    v2[1] = v3
    v2[2] = v9
    v2[3] = v10
    v2[4] = v11
    v2[5] = Children
    v2[6] = v4
    v3 = {}
    v3.Name = p1.Name or "Card"
    local Size = p1.Size
    if not Size then
        Size = UDim2.new(1, 0, 0, 64)
    end
    v3.Size = Size
    local AutomaticSize = p1.AutomaticSize
    if not AutomaticSize then
        AutomaticSize = Enum.AutomaticSize.None
    end
    v3.AutomaticSize = AutomaticSize
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v3.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v3.AnchorPoint = AnchorPoint
    v3.BackgroundColor3 = BackgroundColor3
    v3.BackgroundTransparency = p1.BackgroundTransparency or 0
    v3.BorderSizePixel = 0
    v3.LayoutOrder = p1.LayoutOrder or 0
    local ZIndex_2 = p1.ZIndex
    if not ZIndex_2 then
        ZIndex_2 = u13.ZIndex.Content
    end
    v3.ZIndex = ZIndex_2
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v3.Visible = Visible
    v3.ClipsDescendants = p1.ClipsDescendants or false
    if not v7 then
        v9 = false
    else
        v9 = scope:Computed(function(p1) -- Line: 183 -- upvalues: InteractionEnabled (val)
            return p1(InteractionEnabled)
        end)
    end
    v3.Active = v9
    v3.Parent = p1.Parent
    v3[scope.Children] = v2
    if v7 then
        local MouseEnter = OnEvent("MouseEnter")

        v3[MouseEnter] = function() -- Line: 192 -- upvalues: peek (upval), InteractionEnabled (val), u21 (val), p1 (val), UISounds (upval)
            if not peek(InteractionEnabled) then
                return
            end
            if peek(InteractionEnabled) and peek(u21) ~= true then
                u21:set(true)
                if p1.OnHoverChanged then
                    p1.OnHoverChanged(true)
                end
            end
            if p1.OnClick and peek(u21) then
                UISounds.Hover()
            end
        end

        local MouseLeave = OnEvent("MouseLeave")

        v3[MouseLeave] = function() -- Line: 201 -- upvalues: peek (upval), u21 (val), p1 (val)
            if peek(u21) == false then
                return
            end
            u21:set(false)
            if p1.OnHoverChanged then
                p1.OnHoverChanged(false)
            end
        end
    end
    if not p1.OnClick then
        return scope:New("Frame")(v3)
    end
    v3.BackgroundColor3 = scope:Computed(function(p1) -- Line: 207 -- upvalues: BackgroundColor3 (val), u21 (val)
        local v1 = p1(BackgroundColor3)
        if not p1(u21) then
            return v1
        end
        local v2 = Color3.new(0, 0, 0)
        return (v1:Lerp(v2, 0.14))
    end)
    local u478 = nil
    v3.Text = ""
    v3.AutoButtonColor = false
    local MouseButton1Down = OnEvent("MouseButton1Down")

    v3[MouseButton1Down] = function() -- Line: 214 -- upvalues: peek (upval), InteractionEnabled (val), ButtonFeedback (upval), u478 (ref)
        if peek(InteractionEnabled) then
            ButtonFeedback.Ripple(u478)
        end
    end

    local Activated = OnEvent("Activated")

    v3[Activated] = function() -- Line: 219 -- upvalues: peek (upval), InteractionEnabled (val), UISounds (upval), p1 (val)
        if not peek(InteractionEnabled) then
            return
        end
        UISounds.Click()
        if p1.OnClick then
            p1.OnClick()
        end
    end

    u478 = (scope:New("TextButton")(v3))
    return u478
end