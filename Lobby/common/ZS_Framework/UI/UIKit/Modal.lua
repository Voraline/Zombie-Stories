local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u23 = require("../Theme")
local UISounds = require(script.Parent.UISounds)
local u33 = Color3.fromRGB(74, 255, 249)
local u38 = Color3.fromRGB(255, 236, 176)
return function(p1) -- Line: 110
    -- upvalues: u23 (val), GuiService (val), RunService (val), peek (val), u33 (val), OnEvent (val), UISounds (val)
    -- upvalues: u38 (val)
    local Parent, ScrimTransparency, Text, TextColor, v1, v2, v3
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u23.ZIndex.Modal
    end
    local Open = p1.Open
    if not Open then
        local DefaultOpen
        if p1.DefaultOpen ~= nil then
            DefaultOpen = p1.DefaultOpen
        else
            DefaultOpen = false
        end
        Open = scope:Value(DefaultOpen)
    end
    local Loading = p1.Loading
    local Buttons = p1.Buttons
    if not Buttons then
        Buttons = {}
    end
    local v4 = scope:Computed(function(p1) -- Line: 121 -- upvalues: Open (val)
        if p1(Open) then
            return 0.5
        end
        return 1
    end)
    local u34 = scope:Spring(v4, 28, 1)
    if p1.ScrimTransparency ~= nil then
        ScrimTransparency = p1.ScrimTransparency
    else
        ScrimTransparency = u34
    end
    local v5 = scope:Computed(function(p1_2) -- Line: 131 -- upvalues: p1 (val), Open (val)
        local v1, v2
        if p1.PanelScale ~= nil then
            v1 = p1_2(p1.PanelScale)
        else
            v1 = 1
        end
        if not p1_2(Open) then
            v2 = 0.92
        else
            v2 = 1
        end
        return v2 * v1
    end)
    v4 = scope:Spring(v5, 28, 1)
    local v6 = scope:Computed(function(p1_2) -- Line: 142 -- upvalues: p1 (val), Open (val), u34 (val)
        local v1
        if p1.Visible ~= nil then
            v1 = p1_2(p1.Visible)
        else
            v1 = true
        end
        local v2 = v1
        if v2 then
            v2 = p1_2(Open)
            if not v2 then
                v2 = (p1_2(u34)) < 0.99
            end
        end
        return v2
    end)
    local u61 = scope:Computed(function(p1) -- Line: 147 -- upvalues: Loading (val)
        if Loading == nil then
            return false
        end
        return (p1(Loading))
    end)
    local v7 = scope:Computed(function(p1) -- Line: 150 -- upvalues: Buttons (val), u61 (val)
        local v1 = false
        if 0 < #Buttons then
            v1 = not p1(u61)
        end
        return v1
    end)
    if not p1.Parent or not p1.Parent:IsA("ScreenGui") then
        Parent = p1.Parent
        if Parent then
            Parent = p1.Parent:FindFirstAncestorWhichIsA("ScreenGui")
        end
    else
        Parent = p1.Parent
    end
    local v8 = UDim2.fromScale(0, 0)
    local u90 = scope:Value(v8)
    local v9 = UDim2.fromScale(1, 1)
    local u97 = scope:Value(v9)

    local function updateScrimBounds() -- Line: 159 -- upvalues: Parent (val), u90 (val), u97 (val), GuiService (upval)
        local v1
        if Parent and not Parent.IgnoreGuiInset then
            local GuiInset, GuiInset_2 = GuiService:GetGuiInset()
            v1 = u90
            local v2 = UDim2.fromOffset(-GuiInset.X, -GuiInset.Y)
            v1:set(v2)
            v1 = u97
            v2 = UDim2.new(1, GuiInset.X + GuiInset_2.X, 1, GuiInset.Y + GuiInset_2.Y)
            v1:set(v2)
            return
        end
        local v3 = u90
        v1 = UDim2.fromScale(0, 0)
        v3:set(v1)
        v3 = u97
        v1 = UDim2.fromScale(1, 1)
        v3:set(v1)
    end

    updateScrimBounds()
    if Parent and not Parent.IgnoreGuiInset then
        local v10 = (GuiService:GetPropertyChangedSignal("TopbarInset")):Connect(updateScrimBounds)
        table.insert(scope, v10)
    end
    local u119 = scope:Value(0)
    if Loading ~= nil then
        local v11 = RunService
        v11 = v11.Heartbeat:Connect(function(p1) -- Line: 179 -- upvalues: peek (upval), Open (val), Loading (val), u119 (val)
            if peek(Open) and peek(Loading) then
                local v1 = u119
                local v2 = ((peek(u119)) + p1 * 360) % 360
                v1:set(v2)
            end
        end)
        table.insert(scope, v11)
    end

    local function makeButton(p1_2, p2) -- Line: 197
        -- upvalues: u33 (upval), u23 (upval), scope (val), p1 (val), ZIndex (val), OnEvent (upval), peek (upval)
        -- upvalues: UISounds (upval), Open (val)
        local Disabled
        local Color = p1_2.Color
        if not Color then
            Color = u33
        end
        local u7 = p1_2.StrokeColor or Color
        local BackgroundColor = p1_2.BackgroundColor
        if not BackgroundColor then
            BackgroundColor = u23.Menu.PanelInset
        end
        local u15 = p1_2.TextColor or Color
        if p1_2.Disabled ~= nil then
            Disabled = p1_2.Disabled
        else
            Disabled = false
        end
        local u23_2 = scope:Value(false)
        local v1 = scope
        v1 = v1:Computed(function(p1) -- Line: 204 -- upvalues: Disabled (val), u23 (upval)
            if p1(Disabled) then
                return u23.Transparency.High
            end
            return 0
        end)
        local v2 = scope
        local v3 = scope
        v3 = v3:Computed(function(p1) -- Line: 208 -- upvalues: u23_2 (val)
            if p1(u23_2) then
                return 1.035
            end
            return 1
        end)
        v2 = v2:Spring(v3, 30, 1)
        local v4 = scope
        v4 = v4:Computed(function(p1) -- Line: 216 -- upvalues: u23_2 (val), u7 (val)
            if not p1(u23_2) then
                return u7
            end
            local v1 = u7
            local v2 = Color3.new(1, 1, 1)
            return (v1:Lerp(v2, 0.18))
        end)
        v3 = scope
        v3 = v3:Computed(function(p1) -- Line: 219 -- upvalues: u23_2 (val), BackgroundColor (val)
            if not p1(u23_2) then
                return BackgroundColor
            end
            local v1 = BackgroundColor
            local v2 = Color3.new(1, 1, 1)
            return (v1:Lerp(v2, 0.1))
        end)
        local v5 = scope
        v5 = v5:Computed(function(p1) -- Line: 222 -- upvalues: u23_2 (val), u15 (val)
            if not p1(u23_2) then
                return u15
            end
            local v1 = u15
            local v2 = Color3.new(1, 1, 1)
            return (v1:Lerp(v2, 0.16))
        end)
        local v6 = scope:New("TextButton")
        local v7 = {
            Name = "Button" .. p2,
            LayoutOrder = p2,
            Size = UDim2.fromOffset(p1_2.Width or 140, p1.ButtonHeight or 40),
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Text = "",
            ZIndex = ZIndex + 3,
        }
        local MouseEnter = OnEvent("MouseEnter")

        v7[MouseEnter] = function() -- Line: 233 -- upvalues: peek (upval), Disabled (val), u23_2 (val), UISounds (upval)
            if not peek(Disabled) then
                u23_2:set(true)
                UISounds.Hover()
            end
        end

        local MouseLeave = OnEvent("MouseLeave")

        v7[MouseLeave] = function() -- Line: 239 -- upvalues: u23_2 (val)
            u23_2:set(false)
        end

        local Activated = OnEvent("Activated")

        v7[Activated] = function() -- Line: 242 -- upvalues: peek (upval), Disabled (val), p1 (upval), p1_2 (val), Open (upval)
            if peek(Disabled) then
                return
            end
            if p1.ButtonSound then
                p1.ButtonSound:Play()
            end
            if p1_2.OnClick then
                p1_2.OnClick()
            end
            if not p1_2.KeepOpen and peek(Open) then
                Open:set(false)
            end
        end

        local Children = scope.Children
        local v8 = {}
        local v9 = scope:New("UIScale")({Scale = v2})
        local v10 = scope:New("UICorner")({CornerRadius = UDim.new(0, u23.Menu.CornerRadius)})
        local v11 = scope:New("UIStroke")({
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = v4,
            Thickness = u23.Stroke.Thin,
            Transparency = v1,
        })
        local v12 = scope:New("Frame")
        local v13 = {
            Name = "GradientFill",
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = v3,
            BackgroundTransparency = v1,
            BorderSizePixel = 0,
            ZIndex = ZIndex + 3,
        }
        local Children_2 = scope.Children
        local v14 = {}
        local v15 = scope:New("UICorner")
        local v16 = {CornerRadius = UDim.new(0, u23.Menu.CornerRadius)}
        v15 = v15(v16)
        if not p1_2.GradientColor then
            v16 = nil
        else
            v16 = scope:New("UIGradient")({Color = p1_2.GradientColor, Rotation = u23.Menu.ShadeRotation})
        end
        v14[1] = v15
        v14[2] = v16
        v13[Children_2] = v14
        v12 = v12(v13)
        v13 = scope:New("TextLabel")
        local v17 = {
            Name = "Label",
            BackgroundTransparency = 1,
            TextSize = 20,
            Size = UDim2.fromScale(1, 1),
            Text = p1_2.Text,
            Font = u23.Menu.Fonts.Button,
            TextColor3 = v5,
            TextTransparency = v1,
            ZIndex = ZIndex + 4,
        }
        v8[1] = v9
        v8[2] = v10
        v8[3] = v11
        v8[4] = v12
        v8[5] = v13(v17)
        v7[Children] = v8
        return v6(v7)
    end

    local v12 = {}
    local v13 = Buttons
    local v14 = nil
    local v15 = nil
    for i, j in v13, v14, v15 do
        v1 = makeButton(j, i)
        table.insert(v12, v1)
    end
    v13 = {
        Name = p1.Name or "Modal",
        Size = u97,
        Position = u90,
        BackgroundColor3 = u23.Colors.MainBackground,
        BackgroundTransparency = ScrimTransparency,
        BorderSizePixel = 0,
        Active = true,
        Text = "",
        AutoButtonColor = false,
        Visible = v6,
        ZIndex = ZIndex,
        Parent = p1.Parent,
    }
    local Children = scope.Children
    v15 = {}
    local v16 = scope:New("Frame")
    local v17 = {Name = "Dialog", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(380, 0)
    end
    v17.Size = Size
    v17.AutomaticSize = Enum.AutomaticSize.Y
    v17.BackgroundColor3 = u23.Menu.Panel
    v17.ZIndex = ZIndex + 1
    local Children_2 = scope.Children
    local v18 = {}
    v1 = scope:New("UIScale")({Scale = v4})
    local v19 = scope:New("UICorner")({CornerRadius = UDim.new(0, u23.Menu.CornerRadius)})
    local v20 = scope:New("UIStroke")({
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = u23.Menu.Border,
        Thickness = u23.Stroke.Medium,
    })
    local v21 = scope:New("UIGradient")({Color = u23.Menu.Shade, Rotation = u23.Menu.ShadeRotation})
    local v22 = scope:New("UIPadding")({
        PaddingLeft = UDim.new(0, p1.HorizontalPadding or 20),
        PaddingRight = UDim.new(0, p1.HorizontalPadding or 20),
        PaddingTop = UDim.new(0, p1.VerticalPadding or 18),
        PaddingBottom = UDim.new(0, p1.VerticalPadding or 18),
    })
    local v23 = scope:New("UIListLayout")
    local v24 = {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, p1.Spacing or 14),
    }
    v23 = v23(v24)
    if p1.Title == nil then
        v24 = nil
    else
        v24 = scope:New("TextLabel")
        v2 = {
            Name = "Title",
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, 24),
            BackgroundTransparency = 1,
            Text = p1.Title,
            Font = u23.Menu.Fonts.Header,
            TextColor3 = u23.Menu.Text,
            TextSize = p1.TitleTextSize or 22,
            TextWrapped = true,
            ZIndex = ZIndex + 2,
        }
        local Children_3 = scope.Children
        v2[Children_3] = {scope:New("UIStroke")({Color = u23.Menu.HeaderStroke, Thickness = u23.Stroke.Thin})}
        v24 = v24(v2)
    end
    v2 = scope:New("TextLabel")
    local v25 = {
        Name = "Body",
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        TextWrapped = true,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
    }
    if p1.Text ~= nil then
        Text = p1.Text
    else
        Text = ""
    end
    v25.Text = Text
    v25.Font = u23.Menu.Fonts.Body
    if p1.TextColor ~= nil then
        TextColor = p1.TextColor
    else
        TextColor = u38
    end
    v25.TextColor3 = TextColor
    v25.TextSize = p1.BodyTextSize or 18
    v25.ZIndex = ZIndex + 2
    v2 = v2(v25)
    if p1.Children == nil then
        v25 = nil
    else
        v25 = scope:New("Frame")
        v3 = {
            Name = "Content",
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ZIndex = ZIndex + 2,
        }
        v3[scope.Children] = p1.Children
        v25 = v25(v3)
    end
    v3 = scope:New("Frame")
    local v26 = {
        Name = "Spinner",
        LayoutOrder = 4,
        Size = UDim2.fromOffset(28, 28),
        BackgroundColor3 = u23.Menu.Accent,
        Rotation = u119,
        Visible = u61,
        ZIndex = ZIndex + 3,
    }
    local Children_4 = scope.Children
    v26[Children_4] = {scope:New("UICorner")({CornerRadius = UDim.new(0, 6)})}
    v3 = v3(v26)
    v26 = scope:New("Frame")
    local v27 = {
        Name = "Buttons",
        LayoutOrder = 5,
        Size = UDim2.new(1, 0, 0, p1.ButtonHeight or 40),
        BackgroundTransparency = 1,
        Visible = v7,
        ZIndex = ZIndex + 2,
    }
    local Children_5 = scope.Children
    v27[Children_5] = {
        scope:New("UIListLayout")({
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 14),
        }),
        table.unpack(v12),
    }
    v18[1] = v1
    v18[2] = v19
    v18[3] = v20
    v18[4] = v21
    v18[5] = v22
    v18[6] = v23
    v18[7] = v24
    v18[8] = v2
    v18[9] = v25
    v18[10] = v3
    v18[11] = v26(v27)
    v17[Children_2] = v18
    v15[1] = v16(v17)
    v13[Children] = v15
    if p1.Dismissable then
        v13[OnEvent("Activated")] = function() -- Line: 187 -- upvalues: peek (upval), Open (val), p1 (val)
            if peek(Open) then
                Open:set(false)
            end
            if p1.OnClose then
                p1.OnClose()
            end
        end
    end
    return scope:New("TextButton")(v13)
end