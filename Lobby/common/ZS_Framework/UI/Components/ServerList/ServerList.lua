local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local peek = Fusion.peek
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local function infoFrame(p1, p2, p3, p4, p5, p6) -- Line: 26 -- upvalues: Children (val), Theme (val)
    local v1 = p1:New("Frame")
    local v2 = {Size = p5, BackgroundTransparency = 1, LayoutOrder = p4}
    local v3 = {}
    local v4 = p1:New("TextLabel")
    v4 = v4({
        BackgroundTransparency = 1,
        TextScaled = false,
        Size = UDim2.new(0.44, 0, 1, 0),
        Text = p2,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Menu.Text,
        TextSize = p6,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
    })
    local v5 = p1:New("TextLabel")
    local v6 = {
        BackgroundTransparency = 1,
        TextScaled = false,
        Size = UDim2.new(0.56, 0, 1, 0),
        Position = UDim2.new(0.44, 0, 0, 0),
        Text = p3,
        Font = Theme.Menu.Fonts.Body,
        TextColor3 = Theme.Menu.TextMuted,
        TextSize = p6,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
    }
    v3[1] = v4
    v3[2] = v5(v6)
    v2[Children] = v3
    return v1(v2)
end
local function actionButton(p1, p2) -- Line: 61 -- upvalues: UIKit (val), Theme (val), Children (val)
    local Colors = p2.Colors
    local v1 = {
        Text = "",
        TextTransparency = 1,
        TextScaled = false,
        BackgroundTransparency = 0,
        OutlineEnabled = true,
        OutlineThickness = 2,
        scope = p1,
        Size = p2.Size,
        Position = p2.Position,
        AnchorPoint = p2.AnchorPoint,
        LayoutOrder = p2.LayoutOrder,
        TextSize = p2.TextSize,
        Font = Theme.Menu.Fonts.Button,
        BackgroundColor3 = Color3.new(1, 1, 1),
        Disabled = p2.Disabled,
        OutlineColor3 = Colors.Accent,
        RippleColor3 = Colors.Accent,
        OnClick = p2.OnClick,
    }
    local v2 = {}
    local v3 = p1:New("UIGradient")
    v3 = v3({Color = Colors.Gradient, Rotation = Theme.Menu.ShadeRotation})
    local v4 = p1:New("UICorner")
    v4 = v4({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
    local v5 = p1:New("TextLabel")
    local v6 = {
        Name = "Label",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = p2.Text,
        Font = Theme.Menu.Fonts.Button,
    }
    local TextColor3 = p2.TextColor3
    if not TextColor3 then
        TextColor3 = Theme.Menu.Text
    end
    v6.TextColor3 = TextColor3
    v6.TextSize = p2.TextSize
    v6.TextTruncate = Enum.TextTruncate.AtEnd
    v6.TextXAlignment = Enum.TextXAlignment.Center
    v6.TextYAlignment = Enum.TextYAlignment.Center
    local ZIndex = p2.ZIndex
    if not ZIndex then
        ZIndex = Theme.ZIndex.Content
    end
    v6.ZIndex = ZIndex + 2
    local v7 = {}
    local v8 = p1:New("UIPadding")
    v7[1] = v8({PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})
    v6[Children] = v7
    v2[1] = v3
    v2[2] = v4
    v2[3] = v5(v6)
    v1.Children = v2
    return UIKit.Button(v1)
end
return function(p1) -- Line: 116 -- upvalues: UIKit (val), Theme (val), peek (val), Children (val), infoFrame (val), actionButton (val)
    local v1, v2, v3, v4
    local scope = p1.scope
    local v5 = scope:usePx()
    local u8 = scope:Value(false)
    local u11 = v5(4)
    local u15 = scope:Computed(function(p1) -- Line: 122 -- upvalues: u11 (val)
        return UDim.new(0, p1(u11))
    end)
    local u18 = v5(6)
    local u22 = scope:Computed(function(p1) -- Line: 126 -- upvalues: u18 (val)
        return UDim.new(0, p1(u18))
    end)
    local v6 = v5(16)
    local v7 = v5(26)
    local u31 = v5(20)
    local u34 = v5(12)
    local u37 = v5(80)
    local u41 = scope:Computed(function(p1) -- Line: 135 -- upvalues: u37 (val)
        return UDim2.new(1, 0, 0, p1(u37))
    end)
    local u45 = scope:Value("")
    v1 = scope:ForPairs(p1.ServerData, function(p1, p2, p3, p4) -- Line: 140 -- upvalues: UIKit (upval), u41 (val), u45 (val), Theme (upval), peek (upval), u15 (val), u22 (val), Children (upval), infoFrame (upval), u34 (val), u31 (val)
        local v1 = {
            HoverScale = 1.01,
            scope = p2,
            Size = u41,
            StrokeColor3 = p2:Computed(function(p1) -- Line: 145 -- upvalues: u45 (upval), p4 (val), Theme (upval)
                local v1 = p1(u45)
                if v1 == p4.Id then
                    return Theme.Menu.Accent
                end
                return Theme.Menu.Border
            end),
            StrokeHoverColor3 = Theme.Menu.AccentCyan,
            OnClick = function() -- Line: 150 -- upvalues: peek (upval), u45 (upval), p4 (val)
                local v1 = peek(u45)
                if v1 == p4.Id then
                    u45:set("")
                    return
                end
                u45:set(p4.Id)
            end,
        }
        local v2 = {}
        local v3 = p2:New("UIPadding")
        v3 = v3({PaddingTop = u15, PaddingBottom = u15, PaddingLeft = u22, PaddingRight = u15})
        local v4 = p2:New("Frame")
        local v5 = {Size = UDim2.new(1, 0, 0.7, 0), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.4, 0)}
        local v6 = {}
        local v7 = p2:New("UIListLayout")
        v7 = v7({
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = u22,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
        })
        local MapName = p4.MapName
        local v8 = UDim2.new(0.3, 0, 0.5, 0)
        local v9 = infoFrame(p2, "Map:", MapName, 0, v8, u34)
        local Gamemode = p4.Gamemode
        local v10 = UDim2.new(0.3, 0, 0.5, 0)
        local v11 = infoFrame(p2, "Mode:", Gamemode, 1, v10, u34)
        v8 = p4.Players .. "/" .. p4.MaxPlayers
        local v12 = UDim2.new(0.16, 0, 0.5, 0)
        local v13 = infoFrame(p2, "Players:", v8, 2, v12, u34)
        local Location = p4.Location
        local v14 = UDim2.new(0.16, 0, 0.5, 0)
        v6[1] = v7
        v6[2] = v9
        v6[3] = v11
        v6[4] = v13
        v6[5] = infoFrame(p2, "Location:", Location, 3, v14, u34)
        v5[Children] = v6
        v4 = v4(v5)
        v5 = p2:New("TextLabel")
        local v15 = {
            TextScaled = false,
            BackgroundTransparency = 1,
            TextSize = u31,
            Font = Theme.Menu.Fonts.Title,
            TextColor3 = Theme.Menu.Text,
            Size = UDim2.new(1, 0, 0.4, 0),
            Text = p4.Name,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextTruncate = Enum.TextTruncate.AtEnd,
        }
        v2[1] = v3
        v2[2] = v4
        v2[3] = v5(v15)
        v1.Children = v2
        return p3, UIKit.Card(v1)
    end)
    local u54 = scope:Value("Joining Server")
    local u57 = task.spawn(function() -- Line: 229 -- upvalues: peek (upval), p1 (val), u54 (val)
        local v1, v2, v3
        while true do
            if peek(p1.Joining) then
                v1 = {"Joining Server", "Joining Server.", "Joining Server..", "Joining Server..."}
                v2 = nil
                v3 = nil
                for i, j in v1, v2, v3 do
                    if not (peek(p1.Joining)) then
                        break
                    end
                    u54:set(j)
                    task.wait(0.25)
                end
            else
                u54:set("Joining Server")
                task.wait(0.25)
            end
        end
    end)
    local u61 = scope:Value(false)
    table.insert(scope, function() -- Line: 247 -- upvalues: u57 (val)
        task.cancel(u57)
    end)
    v2 = scope:New("Frame")
    v3 = {
        Size = UDim2.new(0.65, 0, 0.65, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = p1.target,
        BackgroundTransparency = 1,
    }
    v4 = {}
    local v8 = scope:New("TextLabel")
    v8 = v8({
        TextScaled = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Text = u54,
        TextSize = v7,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Menu.Text,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = p1.Joining,
    })
    local v9 = {
        scope = scope,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.Menu.PanelDeep,
        GradientColor = Theme.Menu.Shade,
        GradientRotation = Theme.Menu.ShadeRotation,
        StrokeColor3 = Theme.Menu.Border,
        StrokeThickness = Theme.Menu.StrokeThickness,
        CornerRadius = UDim.new(0, Theme.Menu.CornerRadius),
        Visible = scope:Computed(function(a1) -- Line: 281 -- upvalues: p1 (val)
            return not a1(p1.Joining)
        end),
    }
    local v10 = {}
    local v11 = scope:New("Frame")
    local v12 = {Name = "PrivateServerFrame", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = u8}
    local v13 = {}
    local v14 = scope:New("UIListLayout")
    v14 = v14({SortOrder = Enum.SortOrder.LayoutOrder, Padding = u22, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center})
    local v15 = scope:New("TextBox")
    local v16 = {Size = UDim2.new(0.65, 0, 0.2, 0), BackgroundColor3 = Theme.Menu.PanelInset, PlaceholderText = "", Text = p1.PrivateServerId}
    local Text = scope.Out("Text")
    v16[Text] = p1.PrivateServerId
    v16.TextTransparency = 1
    v16.TextStrokeTransparency = 1
    v16.Font = Theme.Menu.Fonts.Header
    v16.TextScaled = false
    v16.TextSize = v6
    local v17 = {}
    local v18 = scope:New("UIPadding")
    v18 = v18({PaddingTop = u22, PaddingBottom = u22, PaddingLeft = u22, PaddingRight = u22})
    local v19 = scope:New("UICorner")
    v19 = v19({CornerRadius = u15})
    local v20 = scope:New("TextLabel")
    local v21 = {
        Name = "CodeDisplay",
        BackgroundTransparency = 1,
        TextStrokeTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = scope:Computed(function(a1) -- Line: 325 -- upvalues: p1 (val)
            local v1 = a1(p1.PrivateServerId)
            if v1 == "" then
                return "Enter Server Code"
            end
            return v1
        end),
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = scope:Computed(function(a1) -- Line: 330 -- upvalues: p1 (val), Theme (upval)
            if a1(p1.PrivateServerId) == "" then
                return Theme.Menu.TextMuted
            end
            return Theme.Menu.Text
        end),
        TextSize = v6,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
    }
    v17[1] = v18
    v17[2] = v19
    v17[3] = v20(v21)
    v16[Children] = v17
    v15 = v15(v16)
    v16 = scope:New("Frame")
    local v22 = {Size = UDim2.new(0.65, 0, 0.2, 0), BackgroundTransparency = 1, LayoutOrder = 2}
    v18 = {}
    v19 = scope:New("UIListLayout")
    v19 = v19({FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween})
    v20 = actionButton(scope, {
        Text = "GENERATE CODE",
        Size = UDim2.new(0.49, 0, 1, 0),
        Colors = Theme.Menu.NavigationColors.Map,
        TextSize = v6,
        Disabled = u61,
        OnClick = function() -- Line: 358 -- upvalues: u61 (val), p1 (val)
            u61:set(true)
            p1.OnStartPrivateServer()
        end,
    })
    local v23 = {
        LayoutOrder = 2,
        Text = "JOIN PRIVATE SERVER",
        Size = UDim2.new(0.49, 0, 1, 0),
        Colors = Theme.Menu.NavigationColors.Play,
        TextSize = v6,
        OnClick = p1.OnJoinPrivateServer,
    }
    v18[1] = v19
    v18[2] = v20
    v18[3] = actionButton(scope, v23)
    v22[Children] = v18
    v13[1] = v14
    v13[2] = v15
    v13[3] = v16(v22)
    v12[Children] = v13
    v11 = v11(v12)
    v12 = scope:New("Frame")
    local v24 = {Size = UDim2.new(1, 0, 0.125, 0), AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1.14, 0), BackgroundTransparency = 1}
    v14 = {}
    v15 = scope:New("UIListLayout")
    v15 = v15({FillDirection = Enum.FillDirection.Horizontal, Padding = u22, HorizontalAlignment = Enum.HorizontalAlignment.Left, VerticalAlignment = Enum.VerticalAlignment.Center})
    v22 = {
        TextMaxSize = 16,
        scope = scope,
        Size = UDim2.new(0.2, 0, 1, 0),
        Text = scope:Computed(function(p1) -- Line: 391 -- upvalues: u8 (val)
            if p1(u8) then
                return "SERVER BROWSER"
            end
            return "PRIVATE SERVERS"
        end),
        Selected = u8,
        AccentColor3 = Theme.Menu.Accent,
        OnClick = function() -- Line: 397 -- upvalues: u8 (val), peek (upval)
            u8:set(not peek(u8))
        end,
    }
    v14[1] = v15
    v14[2] = UIKit.CategoryButton(v22)
    v24[Children] = v14
    v12 = v12(v24)
    v24 = scope:New("Frame")
    v13 = {
        Size = UDim2.new(1, 0, 0.125, 0),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1.14, 0),
        BackgroundTransparency = 1,
        Visible = scope:Computed(function(p1) -- Line: 409 -- upvalues: u8 (val)
            return not p1(u8)
        end),
    }
    v15 = {}
    v16 = scope:New("UIListLayout")
    v16 = v16({FillDirection = Enum.FillDirection.Horizontal, Padding = u22, HorizontalAlignment = Enum.HorizontalAlignment.Right, VerticalAlignment = Enum.VerticalAlignment.Center})
    v22 = actionButton(scope, {
        Text = "REFRESH",
        Size = UDim2.new(0.2, 0, 1, 0),
        Colors = Theme.Menu.NavigationColors.More,
        TextSize = v6,
        Disabled = p1.Refreshing,
        OnClick = p1.OnRefresh,
    })
    v19 = {
        Size = UDim2.new(0.2, 0, 1, 0),
        Text = scope:Computed(function(p1) -- Line: 429 -- upvalues: u45 (val)
            if p1(u45) == "" then
                return "START SERVER"
            end
            return "JOIN"
        end),
        Colors = Theme.Menu.NavigationColors.Play,
        TextSize = v6,
        OnClick = function() -- Line: 434 -- upvalues: p1 (val), peek (upval), u45 (val)
            p1.OnJoin(peek(u45))
        end,
    }
    v15[1] = v16
    v15[2] = v22
    v15[3] = actionButton(scope, v19)
    v13[Children] = v15
    v24 = v24(v13)
    v13 = UIKit.ScrollList({
        scope = scope,
        Size = UDim2.new(1, 0, 0.85, 0),
        Position = UDim2.new(0, 0, 0.15, 0),
        Visible = scope:Computed(function(p1) -- Line: 445 -- upvalues: u8 (val)
            return not p1(u8)
        end),
        Padding = u22,
        ScrollBarImageColor3 = Theme.Menu.Border,
        Children = {v1},
    })
    v15 = {
        Name = "Header",
        scope = scope,
        Size = UDim2.new(1, 0, 0.15, 0),
        Position = UDim2.fromScale(0, 0),
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = Theme.Menu.Panel,
        GradientColor = Theme.Menu.ButtonGradient,
        GradientRotation = Theme.Menu.ShadeRotation,
        StrokeColor3 = Theme.Menu.Border,
        StrokeThickness = Theme.Menu.StrokeThickness,
        CornerRadius = UDim.new(0, Theme.Menu.CornerRadius),
    }
    v16 = {}
    v22 = scope:New("UIPadding")
    v22 = v22({PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)})
    v17 = scope:New("TextLabel")
    v18 = {
        Size = UDim2.new(0.88, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = scope:Computed(function(p1) -- Line: 475 -- upvalues: u8 (val)
            if p1(u8) then
                return "Private Servers"
            end
            return "Server Browser"
        end),
        Font = Theme.Menu.Fonts.Title,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextScaled = false,
        TextSize = v7,
        TextColor3 = Theme.Menu.Text,
    }
    v20 = {}
    v21 = scope:New("UIStroke")
    v20[1] = v21({Thickness = 2, Color = Theme.Menu.HeaderStroke})
    v18[Children] = v20
    v17 = v17(v18)
    v19 = {
        scope = scope,
        Size = UDim2.new(0.1, 0, 1, 0),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        OnClick = p1.OnExit,
    }
    v16[1] = v22
    v16[2] = v17
    v16[3] = UIKit.CloseButton(v19)
    v15.Children = v16
    v10[1] = v11
    v10[2] = v12
    v10[3] = v24
    v10[4] = v13
    v10[5] = UIKit.Panel(v15)
    v9.Children = v10
    v4[1] = v8
    v4[2] = UIKit.Panel(v9)
    v3[Children] = v4
    return v2(v3)
end