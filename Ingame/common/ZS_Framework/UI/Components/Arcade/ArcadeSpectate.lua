local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local u15 = require("../GenericButton")
return function(p1) -- Line: 22 -- upvalues: fusion_utils (val), u15 (val)
    local scope = p1.scope
    local v1 = fusion_utils
    local v2 = scope:innerScope(v1)
    local Visible = p1.Visible
    if not Visible then
        Visible = v2:Value(true)
    end
    local u17 = v2:usePx()(1)
    local v3 = v2:Computed(function(p1) -- Line: 30 -- upvalues: u17 (val)
        local v1 = p1(u17)
        return UDim.new(0, v1 * 6)
    end)
    local v4 = v2:Computed(function(p1) -- Line: 35 -- upvalues: u17 (val)
        local v1 = p1(u17)
        return UDim.new(0, v1 * 24)
    end)
    local v5 = v2:Computed(function(p1) -- Line: 40 -- upvalues: u17 (val)
        local v1 = p1(u17)
        return UDim.new(0, v1 * 8)
    end)
    local v6 = v2:New("Frame")
    local v7 = {Parent = p1.target, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = Visible}
    local Children = v2.Children
    local v8 = {}
    local v9 = v2:New("Frame")
    local v10 = {
        Size = UDim2.new(0.15, 0, 0.4, 0),
        Position = UDim2.new(0.985, 0, 0.925, 0),
        AnchorPoint = Vector2.new(1, 1),
        BackgroundTransparency = 1,
    }
    local Children_2 = v2.Children
    local v11 = {}
    local v12 = v2:New("UIListLayout")({
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = v4,
    })
    local v13 = u15
    local v14 = {
        TextScaled = true,
        Text = "SERVER BROWSER",
        BackgroundTransparency = 0,
        LayoutOrder = 1,
        scope = v2,
        Size = UDim2.new(1, 0, 0.25, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        OnClick = p1.OnClickServerBrowser,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
        Font = Enum.Font.GothamBold,
    }
    local v15 = {}
    local v16 = v2:New("UICorner")({CornerRadius = v3})
    local v17 = v2:New("UIPadding")
    v15[1] = v16
    v15[2] = v17({PaddingTop = v5, PaddingBottom = v5, PaddingLeft = v5, PaddingRight = v5})
    v14.Children = v15
    v13 = v13(v14)
    v14 = u15
    v15 = {
        TextScaled = true,
        BackgroundTransparency = 0,
        LayoutOrder = 2,
        scope = v2,
        Size = UDim2.new(1, 0, 0.25, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Text = p1.LobbyButtonText,
        OnClick = p1.OnClickLobby,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
        Font = Enum.Font.GothamBold,
    }
    v16 = {}
    v17 = v2:New("UICorner")({CornerRadius = v3})
    local v18 = v2:New("UIPadding")
    v16[1] = v17
    v16[2] = v18({PaddingTop = v5, PaddingBottom = v5, PaddingLeft = v5, PaddingRight = v5})
    v15.Children = v16
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14(v15)
    v10[Children_2] = v11
    v9 = v9(v10)
    v10 = v2:New("Frame")
    local v19 = {
        Size = UDim2.new(0.35, 0, 0.1, 0),
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 0.925, 0),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
    }
    local Children_3 = v2.Children
    v12 = {}
    v13 = v2:New("TextLabel")({
        Text = "SPECTATING",
        TextScaled = true,
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1, 1, 1),
        Position = UDim2.new(0, 0, -0.31, 0),
        Size = UDim2.new(1, 0, 0.3, 0),
        Font = Enum.Font.GothamBold,
    })
    v14 = v2:New("TextLabel")
    v15 = {
        Text = p1.Spectating,
        TextScaled = true,
        TextColor3 = Color3.new(1, 1, 1),
        Size = UDim2.new(0.7, 0, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
        BackgroundTransparency = 0,
        Font = Enum.Font.GothamBold,
    }
    local Children_4 = v2.Children
    v17 = {}
    v18 = v2:New("UIPadding")({PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0)})
    local v20 = v2:New("UICorner")
    v17[1] = v18
    v17[2] = v20({CornerRadius = v3})
    v15[Children_4] = v17
    v14 = v14(v15)
    v15 = u15
    v15 = v15({
        TextScaled = true,
        Text = "<",
        BackgroundTransparency = 0,
        scope = v2,
        Size = UDim2.new(0.2, 0, 1, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Font = Enum.Font.GothamBold,
        OnClick = p1.OnClickLeft,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
        Children = {v2:New("UICorner")({CornerRadius = v3})},
    })
    v16 = u15
    v17 = {
        TextScaled = true,
        Text = ">",
        BackgroundTransparency = 0,
        scope = v2,
        Size = UDim2.new(0.2, 0, 1, 0),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Font = Enum.Font.GothamBold,
        OnClick = p1.OnClickRight,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
        Children = {v2:New("UICorner")({CornerRadius = v3})},
    }
    v12[1] = v13
    v12[2] = v14
    v12[3] = v15
    v12[4] = v16(v17)
    v19[Children_3] = v12
    v8[1] = v9
    v8[2] = v10(v19)
    v7[Children] = v8
    return v6(v7)
end