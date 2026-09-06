local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local u15 = require("../GenericButton")
return function(p1) -- Line: 22 -- upvalues: fusion_utils (val), u15 (val)
    local v1 = p1.scope:innerScope(fusion_utils)
    local Visible = p1.Visible
    if not Visible then
        Visible = v1:Value(true)
    end
    local u17 = v1:usePx()(1)
    local v2 = v1:Computed(function(p1) -- Line: 30 -- upvalues: u17 (val)
        local v1 = p1(u17)
        return UDim.new(0, v1 * 6)
    end)
    local v3 = v1:Computed(function(p1) -- Line: 35 -- upvalues: u17 (val)
        local v1 = p1(u17)
        return UDim.new(0, v1 * 24)
    end)
    local v4 = v1:Computed(function(p1) -- Line: 40 -- upvalues: u17 (val)
        local v1 = p1(u17)
        return UDim.new(0, v1 * 8)
    end)
    local v5 = v1:New("Frame")
    local v6 = {Parent = p1.target, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = Visible}
    local Children = v1.Children
    local v7 = {}
    local v8 = v1:New("Frame")
    local v9 = {Size = UDim2.new(0.15, 0, 0.4, 0), Position = UDim2.new(0.985, 0, 0.925, 0), AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1}
    local Children_2 = v1.Children
    local v10 = {}
    local v11 = v1:New("UIListLayout")
    v11 = v11({
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = v3,
    })
    local v12 = {
        TextScaled = true,
        Text = "SERVER BROWSER",
        BackgroundTransparency = 0,
        LayoutOrder = 1,
        scope = v1,
        Size = UDim2.new(1, 0, 0.25, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        OnClick = p1.OnClickServerBrowser,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
        Font = Enum.Font.GothamBold,
    }
    local v13 = {}
    local v14 = v1:New("UICorner")
    v14 = v14({CornerRadius = v2})
    local v15 = v1:New("UIPadding")
    v13[1] = v14
    v13[2] = v15({PaddingTop = v4, PaddingBottom = v4, PaddingLeft = v4, PaddingRight = v4})
    v12.Children = v13
    local v16 = u15(v12)
    v13 = {
        TextScaled = true,
        BackgroundTransparency = 0,
        LayoutOrder = 2,
        scope = v1,
        Size = UDim2.new(1, 0, 0.25, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Text = p1.LobbyButtonText,
        OnClick = p1.OnClickLobby,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
        Font = Enum.Font.GothamBold,
    }
    v14 = {}
    v15 = v1:New("UICorner")
    v15 = v15({CornerRadius = v2})
    local v17 = v1:New("UIPadding")
    v14[1] = v15
    v14[2] = v17({PaddingTop = v4, PaddingBottom = v4, PaddingLeft = v4, PaddingRight = v4})
    v13.Children = v14
    v10[1] = v11
    v10[2] = v16
    v10[3] = u15(v13)
    v9[Children_2] = v10
    v8 = v8(v9)
    v9 = v1:New("Frame")
    local v18 = {
        Size = UDim2.new(0.35, 0, 0.1, 0),
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 0.925, 0),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
    }
    local Children_3 = v1.Children
    v11 = {}
    v16 = v1:New("TextLabel")
    v16 = v16({
        Text = "SPECTATING",
        TextScaled = true,
        BackgroundTransparency = 1,
        TextColor3 = Color3.new(1, 1, 1),
        Position = UDim2.new(0, 0, -0.31, 0),
        Size = UDim2.new(1, 0, 0.3, 0),
        Font = Enum.Font.GothamBold,
    })
    v12 = v1:New("TextLabel")
    v13 = {
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
    local Children_4 = v1.Children
    v15 = {}
    v17 = v1:New("UIPadding")
    v17 = v17({PaddingLeft = UDim.new(0.05, 0), PaddingRight = UDim.new(0.05, 0)})
    local v19 = v1:New("UICorner")
    v15[1] = v17
    v15[2] = v19({CornerRadius = v2})
    v13[Children_4] = v15
    v12 = v12(v13)
    v14 = {
        TextScaled = true,
        Text = "<",
        BackgroundTransparency = 0,
        scope = v1,
        Size = UDim2.new(0.2, 0, 1, 0),
        Position = UDim2.new(0, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Font = Enum.Font.GothamBold,
        OnClick = p1.OnClickLeft,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
    }
    v15 = {}
    v17 = v1:New("UICorner")
    v15[1] = v17({CornerRadius = v2})
    v14.Children = v15
    v13 = u15(v14)
    v15 = {
        TextScaled = true,
        Text = ">",
        BackgroundTransparency = 0,
        scope = v1,
        Size = UDim2.new(0.2, 0, 1, 0),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Font = Enum.Font.GothamBold,
        OnClick = p1.OnClickRight,
        BackgroundColor3 = Color3.new(0.133333, 0.215686, 0.454902),
    }
    v17 = {}
    v19 = v1:New("UICorner")
    v17[1] = v19({CornerRadius = v2})
    v15.Children = v17
    v11[1] = v16
    v11[2] = v12
    v11[3] = v13
    v11[4] = u15(v15)
    v18[Children_3] = v11
    v7[1] = v8
    v7[2] = v9(v18)
    v6[Children] = v7
    return v5(v6)
end