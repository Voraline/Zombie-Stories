local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local peek = Fusion.peek
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)

local function infoFrame(p1, p2, p3, p4, p5, p6) -- Line: 26 -- upvalues: Children (val), Theme (val)
    local v1 = p1:New("Frame")
    local v2 = {Size = p5, BackgroundTransparency = 1, LayoutOrder = p4}
    local v3 = Children
    local v4 = {}
    local v5 = p1:New("TextLabel")({
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
    local v6 = p1:New("TextLabel")
    local v7 = {
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
    v4[1] = v5
    v4[2] = v6(v7)
    v2[v3] = v4
    return v1(v2)
end

local function actionButton(p1, p2) -- Line: 61 -- upvalues: UIKit (val), Theme (val), Children (val)
    local Colors = p2.Colors
    local Button = UIKit.Button
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
    local v3 = p1:New("UIGradient")({Color = Colors.Gradient, Rotation = Theme.Menu.ShadeRotation})
    local v4 = p1:New("UICorner")({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
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
    local v7 = Children
    v6[v7] = {p1:New("UIPadding")({PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})}
    v2[1] = v3
    v2[2] = v4
    v2[3] = v5(v6)
    v1.Children = v2
    return Button(v1)
end

return function(p1) -- Line: 116
    -- upvalues: UIKit (val), Theme (val), peek (val), Children (val), infoFrame (val), actionButton (val)
    local scope = p1.scope
    local v1 = scope:usePx()
    local u8 = scope:Value(false)
    local u11 = v1(4)
    local u15 = scope:Computed(function(p1) -- Line: 122 -- upvalues: u11 (val)
        return UDim.new(0, p1(u11))
    end)
    local u18 = v1(6)
    local u22 = scope:Computed(function(p1) -- Line: 126 -- upvalues: u18 (val)
        return UDim.new(0, p1(u18))
    end)
    local v2 = v1(16)
    local v3 = v1(26)
    local u31 = v1(20)
    local u34 = v1(12)
    local u37 = v1(80)
    local u41 = scope:Computed(function(p1) -- Line: 135 -- upvalues: u37 (val)
        return UDim2.new(1, 0, 0, p1(u37))
    end)
    local u45 = scope:Value("")
    local ServerData = p1.ServerData
    local v4 = scope:ForPairs(ServerData, function(p1, p2, p3, p4) -- Line: 140
        -- upvalues: UIKit (upval), u41 (val), u45 (val), Theme (upval), peek (upval), u15 (val), u22 (val)
        -- upvalues: Children (upval), infoFrame (upval), u34 (val), u31 (val)
        local v1 = UIKit
        local Card = v1.Card
        local v2 = {
            HoverScale = 1.01,
            scope = p2,
            Size = u41,
            StrokeColor3 = p2:Computed(function(p1) -- Line: 145 -- upvalues: u45 (upval), p4 (val), Theme (upval)
                if (p1(u45)) == p4.Id then
                    return Theme.Menu.Accent
                end
                return Theme.Menu.Border
            end),
            StrokeHoverColor3 = Theme.Menu.AccentCyan,
            OnClick = function() -- Line: 150 -- upvalues: peek (upval), u45 (upval), p4 (val)
                if (peek(u45)) == p4.Id then
                    u45:set("")
                    return
                end
                local v1 = u45
                local v2 = p4
                local Id = v2.Id
                v1:set(Id)
            end,
        }
        local v3 = {}
        local v4 = p2:New("UIPadding")({PaddingTop = u15, PaddingBottom = u15, PaddingLeft = u22, PaddingRight = u15})
        local v5 = p2:New("Frame")
        local v6 = {Size = UDim2.new(1, 0, 0.7, 0), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.4, 0)}
        local v7 = Children
        local v8 = {}
        local v9 = p2:New("UIListLayout")({
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = u22,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
        })
        local v10 = infoFrame
        local MapName = p4.MapName
        local v11 = UDim2.new(0.3, 0, 0.5, 0)
        v10 = v10(p2, "Map:", MapName, 0, v11, u34)
        local v12 = infoFrame
        local Gamemode = p4.Gamemode
        local v13 = UDim2.new(0.3, 0, 0.5, 0)
        v12 = v12(p2, "Mode:", Gamemode, 1, v13, u34)
        local v14 = infoFrame
        v11 = p4.Players .. "/" .. p4.MaxPlayers
        local v15 = UDim2.new(0.16, 0, 0.5, 0)
        v14 = v14(p2, "Players:", v11, 2, v15, u34)
        local v16 = infoFrame
        local Location = p4.Location
        local v17 = UDim2.new(0.16, 0, 0.5, 0)
        v8[1] = v9
        v8[2] = v10
        v8[3] = v12
        v8[4] = v14
        v8[5] = v16(p2, "Location:", Location, 3, v17, u34)
        v6[v7] = v8
        v5 = v5(v6)
        v6 = p2:New("TextLabel")
        v7 = {
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
        v3[1] = v4
        v3[2] = v5
        v3[3] = v6(v7)
        v2.Children = v3
        return p3, Card(v2)
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
                    if not peek(p1.Joining) then
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
    local v5 = scope:New("Frame")
    local v6 = {
        Size = UDim2.new(0.65, 0, 0.65, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = p1.target,
        BackgroundTransparency = 1,
    }
    local v7 = Children
    local v8 = {}
    local v9 = scope:New("TextLabel")({
        TextScaled = false,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Text = u54,
        TextSize = v3,
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = Theme.Menu.Text,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Visible = p1.Joining,
    })
    local v10 = UIKit
    local Panel = v10.Panel
    local v11 = {
        scope = scope,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.Menu.PanelDeep,
        GradientColor = Theme.Menu.Shade,
        GradientRotation = Theme.Menu.ShadeRotation,
        StrokeColor3 = Theme.Menu.Border,
        StrokeThickness = Theme.Menu.StrokeThickness,
        CornerRadius = UDim.new(0, Theme.Menu.CornerRadius),
        Visible = scope:Computed(function(p1_2) -- Line: 281 -- upvalues: p1 (val)
            return not p1_2(p1.Joining)
        end),
    }
    local v12 = {}
    local v13 = scope:New("Frame")
    local v14 = {
        Name = "PrivateServerFrame",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Visible = u8,
    }
    local v15 = Children
    local v16 = {}
    local v17 = scope:New("UIListLayout")({
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = u22,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    local v18 = scope:New("TextBox")
    local v19 = {
        Size = UDim2.new(0.65, 0, 0.2, 0),
        BackgroundColor3 = Theme.Menu.PanelInset,
        PlaceholderText = "",
        Text = p1.PrivateServerId,
    }
    local Text = scope.Out("Text")
    v19[Text] = p1.PrivateServerId
    v19.TextTransparency = 1
    v19.TextStrokeTransparency = 1
    v19.Font = Theme.Menu.Fonts.Header
    v19.TextScaled = false
    v19.TextSize = v2
    local v20 = Children
    local v21 = {}
    local v22 = scope:New("UIPadding")({PaddingTop = u22, PaddingBottom = u22, PaddingLeft = u22, PaddingRight = u22})
    local v23 = scope:New("UICorner")({CornerRadius = u15})
    local v24 = scope:New("TextLabel")
    local v25 = {
        Name = "CodeDisplay",
        BackgroundTransparency = 1,
        TextStrokeTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = scope:Computed(function(p1_2) -- Line: 325 -- upvalues: p1 (val)
            local v1 = p1_2(p1.PrivateServerId)
            if v1 == "" then
                return "Enter Server Code"
            end
            return v1
        end),
        Font = Theme.Menu.Fonts.Header,
        TextColor3 = scope:Computed(function(p1_2) -- Line: 330 -- upvalues: p1 (val), Theme (upval)
            if p1_2(p1.PrivateServerId) == "" then
                return Theme.Menu.TextMuted
            end
            return Theme.Menu.Text
        end),
        TextSize = v2,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
    }
    v21[1] = v22
    v21[2] = v23
    v21[3] = v24(v25)
    v19[v20] = v21
    v18 = v18(v19)
    v19 = scope:New("Frame")
    v20 = {Size = UDim2.new(0.65, 0, 0.2, 0), BackgroundTransparency = 1, LayoutOrder = 2}
    v21 = Children
    v22 = {}
    v23 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween,
    })
    v24 = actionButton
    v24 = v24(scope, {
        Text = "GENERATE CODE",
        Size = UDim2.new(0.49, 0, 1, 0),
        Colors = Theme.Menu.NavigationColors.Map,
        TextSize = v2,
        Disabled = u61,
        OnClick = function() -- Line: 358 -- upvalues: u61 (val), p1 (val)
            u61:set(true)
            p1.OnStartPrivateServer()
        end,
    })
    v25 = actionButton
    local v26 = {
        LayoutOrder = 2,
        Text = "JOIN PRIVATE SERVER",
        Size = UDim2.new(0.49, 0, 1, 0),
        Colors = Theme.Menu.NavigationColors.Play,
        TextSize = v2,
        OnClick = p1.OnJoinPrivateServer,
    }
    v22[1] = v23
    v22[2] = v24
    v22[3] = v25(scope, v26)
    v20[v21] = v22
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19(v20)
    v14[v15] = v16
    v13 = v13(v14)
    v14 = scope:New("Frame")
    v15 = {
        Size = UDim2.new(1, 0, 0.125, 0),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1.14, 0),
        BackgroundTransparency = 1,
    }
    v16 = Children
    v17 = {}
    v18 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = u22,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    v19 = UIKit
    local CategoryButton = v19.CategoryButton
    v20 = {
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
            local v1 = u8
            local v2 = peek
            local v3 = u8
            v2 = v2(v3)
            v1:set(not v2)
        end,
    }
    v17[1] = v18
    v17[2] = CategoryButton(v20)
    v15[v16] = v17
    v14 = v14(v15)
    v15 = scope:New("Frame")
    v16 = {
        Size = UDim2.new(1, 0, 0.125, 0),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1.14, 0),
        BackgroundTransparency = 1,
        Visible = scope:Computed(function(p1) -- Line: 409 -- upvalues: u8 (val)
            return not p1(u8)
        end),
    }
    v17 = Children
    v18 = {}
    v19 = scope:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = u22,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    })
    v20 = actionButton
    v20 = v20(scope, {
        Text = "REFRESH",
        Size = UDim2.new(0.2, 0, 1, 0),
        Colors = Theme.Menu.NavigationColors.More,
        TextSize = v2,
        Disabled = p1.Refreshing,
        OnClick = p1.OnRefresh,
    })
    v21 = actionButton
    v23 = {
        Size = UDim2.new(0.2, 0, 1, 0),
        Text = scope:Computed(function(p1) -- Line: 429 -- upvalues: u45 (val)
            if p1(u45) == "" then
                return "START SERVER"
            end
            return "JOIN"
        end),
        Colors = Theme.Menu.NavigationColors.Play,
        TextSize = v2,
        OnClick = function() -- Line: 434 -- upvalues: p1 (val), peek (upval), u45 (val)
            p1.OnJoin(peek(u45))
        end,
    }
    v18[1] = v19
    v18[2] = v20
    v18[3] = v21(scope, v23)
    v16[v17] = v18
    v15 = v15(v16)
    v16 = UIKit
    v16 = v16.ScrollList({
        scope = scope,
        Size = UDim2.new(1, 0, 0.85, 0),
        Position = UDim2.new(0, 0, 0.15, 0),
        Visible = scope:Computed(function(p1) -- Line: 445 -- upvalues: u8 (val)
            return not p1(u8)
        end),
        Padding = u22,
        ScrollBarImageColor3 = Theme.Menu.Border,
        Children = {v4},
    })
    v17 = UIKit
    local Panel_2 = v17.Panel
    v18 = {
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
    v19 = {}
    v20 = scope:New("UIPadding")({
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
    })
    v21 = scope:New("TextLabel")
    v22 = {
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
        TextSize = v3,
        TextColor3 = Theme.Menu.Text,
    }
    v23 = Children
    v22[v23] = {scope:New("UIStroke")({Thickness = 2, Color = Theme.Menu.HeaderStroke})}
    v21 = v21(v22)
    v22 = UIKit
    local CloseButton = v22.CloseButton
    v23 = {
        scope = scope,
        Size = UDim2.new(0.1, 0, 1, 0),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        OnClick = p1.OnExit,
    }
    v19[1] = v20
    v19[2] = v21
    v19[3] = CloseButton(v23)
    v18.Children = v19
    v12[1] = v13
    v12[2] = v14
    v12[3] = v15
    v12[4] = v16
    v12[5] = Panel_2(v18)
    v11.Children = v12
    v8[1] = v9
    v8[2] = Panel(v11)
    v6[v7] = v8
    return v5(v6)
end