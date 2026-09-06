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
return function(p1) -- Line: 110 -- upvalues: u23 (val), GuiService (val), RunService (val), peek (val), u33 (val), OnEvent (val), UISounds (val), u38 (val)
    local Children, Parent, ScrimTransparency, Text, TextColor, v1, v2, v3, v4, v5, v6
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
    local v7 = scope:Computed(function(p1) -- Line: 121 -- upvalues: Open (val)
        if p1(Open) then
            return 0.5
        end
        return 1
    end)
    local u34 = scope:Spring(v7, 28, 1)
    if p1.ScrimTransparency ~= nil then
        ScrimTransparency = p1.ScrimTransparency
    else
        ScrimTransparency = u34
    end
    local v8 = scope:Computed(function(a1) -- Line: 131 -- upvalues: p1 (val), Open (val)
        local v1, v2
        if p1.PanelScale ~= nil then
            v1 = a1(p1.PanelScale)
        else
            v1 = 1
        end
        if not (a1(Open)) then
            v2 = 0.92
        else
            v2 = 1
        end
        return v2 * v1
    end)
    v7 = scope:Spring(v8, 28, 1)
    local v9 = scope:Computed(function(a1) -- Line: 142 -- upvalues: p1 (val), Open (val), u34 (val)
        local v1
        if p1.Visible ~= nil then
            v1 = a1(p1.Visible)
        else
            v1 = true
        end
        local v2 = v1
        if v2 then
            v2 = a1(Open)
            if not v2 then
                local v3 = a1(u34)
                v2 = v3 < 0.99
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
    local v10 = scope:Computed(function(p1) -- Line: 150 -- upvalues: Buttons (val), u61 (val)
        local v1 = false
        local v2 = #Buttons
        if 0 < v2 then
            v1 = not p1(u61)
        end
        return v1
    end)
    if not p1.Parent then
        Parent = p1.Parent
        if Parent then
            Parent = p1.Parent:FindFirstAncestorWhichIsA("ScreenGui")
        end
    elseif p1.Parent:IsA("ScreenGui") then
        Parent = p1.Parent
    end
    local u90 = scope:Value(UDim2.fromScale(0, 0))
    local u97 = scope:Value(UDim2.fromScale(1, 1))
    local function updateScrimBounds() -- Line: 159 -- upvalues: Parent (val), u90 (val), u97 (val), GuiService (upval)
        local GuiInset, GuiInset_2
        if not Parent or Parent.IgnoreGuiInset then
            u90:set(UDim2.fromScale(0, 0))
            u97:set(UDim2.fromScale(1, 1))
            return
        end
        GuiInset, GuiInset_2 = GuiService:GetGuiInset()
        u90:set(UDim2.fromOffset(-GuiInset.X, -GuiInset.Y))
        u97:set(UDim2.new(1, GuiInset.X + GuiInset_2.X, 1, GuiInset.Y + GuiInset_2.Y))
    end
    updateScrimBounds()
    if Parent and not Parent.IgnoreGuiInset then
        local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("TopbarInset")
        table.insert(scope, PropertyChangedSignal:Connect(updateScrimBounds))
    end
    local u119 = scope:Value(0)
    if Loading ~= nil then
        v1 = RunService.Heartbeat:Connect(function(p1) -- Line: 179 -- upvalues: peek (upval), Open (val), Loading (val), u119 (val)
            if peek(Open) and peek(Loading) then
                local v1 = peek(u119)
                u119:set((v1 + p1 * 360) % 360)
            end
        end)
        table.insert(scope, v1)
    end
    local v11 = {}
    local v12 = Buttons
    local v13 = nil
    local v14 = nil
    for i, j in v12, v13, v14 do
        table.insert(v11, (function(a1, p2) -- Line: 197 -- upvalues: u33 (upval), u23 (upval), scope (val), p1 (val), ZIndex (val), OnEvent (upval), peek (upval), UISounds (upval), Open (val)
            local Disabled, u23
            local Color = a1.Color
            if not Color then
                Color = u33
            end
            local u7 = a1.StrokeColor or Color
            local BackgroundColor = a1.BackgroundColor
            if not BackgroundColor then
                BackgroundColor = u23.Menu.PanelInset
            end
            local u15 = a1.TextColor or Color
            if a1.Disabled ~= nil then
                Disabled = a1.Disabled
            else
                Disabled = false
            end
            u23 = scope:Value(false)
            local v1 = scope:Computed(function(p1) -- Line: 204 -- upvalues: Disabled (val), u23 (upval)
                if p1(Disabled) then
                    return u23.Transparency.High
                end
                return 0
            end)
            local v2 = scope:Computed(function(p1) -- Line: 208 -- upvalues: u23 (val)
                if p1(u23) then
                    return 1.035
                end
                return 1
            end)
            local v3 = scope:Spring(v2, 30, 1)
            local v4 = scope:Computed(function(p1) -- Line: 216 -- upvalues: u23 (val), u7 (val)
                if not (p1(u23)) then
                    return u7
                end
                local v1 = Color3.new(1, 1, 1)
                return (u7:Lerp(v1, 0.18))
            end)
            v2 = scope:Computed(function(p1) -- Line: 219 -- upvalues: u23 (val), BackgroundColor (val)
                if not (p1(u23)) then
                    return BackgroundColor
                end
                local v1 = Color3.new(1, 1, 1)
                return (BackgroundColor:Lerp(v1, 0.1))
            end)
            local v5 = scope:Computed(function(p1) -- Line: 222 -- upvalues: u23 (val), u15 (val)
                if not (p1(u23)) then
                    return u15
                end
                local v1 = Color3.new(1, 1, 1)
                return (u15:Lerp(v1, 0.16))
            end)
            local v6 = scope:New("TextButton")
            local v7 = {
                Name = "Button" .. p2,
                LayoutOrder = p2,
                Size = UDim2.fromOffset(a1.Width or 140, p1.ButtonHeight or 40),
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                Text = "",
                ZIndex = ZIndex + 3,
            }
            local MouseEnter = OnEvent("MouseEnter")
            v7[MouseEnter] = function() -- Line: 233 -- upvalues: peek (upval), Disabled (val), u23 (val), UISounds (upval)
                if not (peek(Disabled)) then
                    u23:set(true)
                    UISounds.Hover()
                end
            end
            local MouseLeave = OnEvent("MouseLeave")
            v7[MouseLeave] = function() -- Line: 239 -- upvalues: u23 (val)
                u23:set(false)
            end
            local Activated = OnEvent("Activated")
            v7[Activated] = function() -- Line: 242 -- upvalues: peek (upval), Disabled (val), p1 (upval), a1 (val), Open (upval)
                if peek(Disabled) then
                    return
                end
                if p1.ButtonSound then
                    p1.ButtonSound:Play()
                end
                if a1.OnClick then
                    a1.OnClick()
                end
                if not a1.KeepOpen and peek(Open) then
                    Open:set(false)
                end
            end
            local v8 = {}
            local v9 = scope:New("UIScale")
            v9 = v9({Scale = v3})
            local v10 = scope:New("UICorner")
            v10 = v10({CornerRadius = UDim.new(0, u23.Menu.CornerRadius)})
            local v11 = scope:New("UIStroke")
            v11 = v11({ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = v4, Thickness = u23.Stroke.Thin, Transparency = v1})
            local v12 = scope:New("Frame")
            local v13 = {
                Name = "GradientFill",
                Size = UDim2.fromScale(1, 1),
                BackgroundColor3 = v2,
                BackgroundTransparency = v1,
                BorderSizePixel = 0,
                ZIndex = ZIndex + 3,
            }
            local v14 = {}
            local v15 = scope:New("UICorner")
            local v16 = {CornerRadius = UDim.new(0, u23.Menu.CornerRadius)}
            v15 = v15(v16)
            if not a1.GradientColor then
                v16 = nil
            else
                v16 = scope:New("UIGradient")
                v16 = v16({Color = a1.GradientColor, Rotation = u23.Menu.ShadeRotation})
            end
            v14[1] = v15
            v14[2] = v16
            v13[scope.Children] = v14
            v12 = v12(v13)
            v13 = scope:New("TextLabel")
            local v17 = {
                Name = "Label",
                BackgroundTransparency = 1,
                TextSize = 20,
                Size = UDim2.fromScale(1, 1),
                Text = a1.Text,
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
            v7[scope.Children] = v8
            return v6(v7)
        end)(j, i))
    end
    v12 = {
        Name = p1.Name or "Modal",
        Size = u97,
        Position = u90,
        BackgroundColor3 = u23.Colors.MainBackground,
        BackgroundTransparency = ScrimTransparency,
        BorderSizePixel = 0,
        Active = true,
        Text = "",
        AutoButtonColor = false,
        Visible = v9,
        ZIndex = ZIndex,
        Parent = p1.Parent,
    }
    v14 = {}
    v2 = scope:New("Frame")
    v3 = {Name = "Dialog", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5)}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(380, 0)
    end
    v3.Size = Size
    v3.AutomaticSize = Enum.AutomaticSize.Y
    v3.BackgroundColor3 = u23.Menu.Panel
    v3.ZIndex = ZIndex + 1
    local v15 = {}
    local v16 = scope:New("UIScale")
    v16 = v16({Scale = v7})
    local v17 = scope:New("UICorner")
    v17 = v17({CornerRadius = UDim.new(0, u23.Menu.CornerRadius)})
    local v18 = scope:New("UIStroke")
    v18 = v18({ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = u23.Menu.Border, Thickness = u23.Stroke.Medium})
    local v19 = scope:New("UIGradient")
    v19 = v19({Color = u23.Menu.Shade, Rotation = u23.Menu.ShadeRotation})
    local v20 = scope:New("UIPadding")
    v20 = v20({PaddingLeft = UDim.new(0, p1.HorizontalPadding or 20), PaddingRight = UDim.new(0, p1.HorizontalPadding or 20), PaddingTop = UDim.new(0, p1.VerticalPadding or 18), PaddingBottom = UDim.new(0, p1.VerticalPadding or 18)})
    local v21 = scope:New("UIListLayout")
    local v22 = {FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, p1.Spacing or 14)}
    v21 = v21(v22)
    if p1.Title == nil then
        v22 = nil
    else
        v22 = scope:New("TextLabel")
        v4 = {
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
        Children = scope.Children
        v5 = {}
        v6 = scope:New("UIStroke")
        v5[1] = v6({Color = u23.Menu.HeaderStroke, Thickness = u23.Stroke.Thin})
        v4[Children] = v5
        v22 = v22(v4)
    end
    v4 = scope:New("TextLabel")
    local v23 = {
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
    v23.Text = Text
    v23.Font = u23.Menu.Fonts.Body
    if p1.TextColor ~= nil then
        TextColor = p1.TextColor
    else
        TextColor = u38
    end
    v23.TextColor3 = TextColor
    v23.TextSize = p1.BodyTextSize or 18
    v23.ZIndex = ZIndex + 2
    v4 = v4(v23)
    if p1.Children == nil then
        v23 = nil
    else
        v23 = scope:New("Frame")
        v5 = {
            Name = "Content",
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            ZIndex = ZIndex + 2,
        }
        v5[scope.Children] = p1.Children
        v23 = v23(v5)
    end
    v5 = scope:New("Frame")
    v6 = {
        Name = "Spinner",
        LayoutOrder = 4,
        Size = UDim2.fromOffset(28, 28),
        BackgroundColor3 = u23.Menu.Accent,
        Rotation = u119,
        Visible = u61,
        ZIndex = ZIndex + 3,
    }
    local Children_2 = scope.Children
    local v24 = {}
    local v25 = scope:New("UICorner")
    v24[1] = v25({CornerRadius = UDim.new(0, 6)})
    v6[Children_2] = v24
    v5 = v5(v6)
    v6 = scope:New("Frame")
    local v26 = {
        Name = "Buttons",
        LayoutOrder = 5,
        Size = UDim2.new(1, 0, 0, p1.ButtonHeight or 40),
        BackgroundTransparency = 1,
        Visible = v10,
        ZIndex = ZIndex + 2,
    }
    local Children_3 = scope.Children
    v25 = {}
    local v27 = scope:New("UIListLayout")
    v27 = v27({
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 14),
    })
    v25[1] = v27
    v25[2] = table.unpack(v11)
    v26[Children_3] = v25
    v15[1] = v16
    v15[2] = v17
    v15[3] = v18
    v15[4] = v19
    v15[5] = v20
    v15[6] = v21
    v15[7] = v22
    v15[8] = v4
    v15[9] = v23
    v15[10] = v5
    v15[11] = v6(v26)
    v3[scope.Children] = v15
    v14[1] = v2(v3)
    v12[scope.Children] = v14
    if p1.Dismissable then
        v12[OnEvent("Activated")] = function() -- Line: 187 -- upvalues: peek (upval), Open (val), p1 (val)
            if peek(Open) then
                Open:set(false)
            end
            if p1.OnClose then
                p1.OnClose()
            end
        end
    end
    v13 = scope:New("TextButton")
    return v13(v12)
end