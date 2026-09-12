local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OnEvent = (require(ReplicatedStorage.Packages.Fusion)).OnEvent
local u12 = require("../Theme")
local UISounds = require(script.Parent.UISounds)

local function defaultFormat(p1) -- Line: 62
    local v1
    local v2 = (math.abs(p1)) + 0.5
    local v3 = math.floor(v2)
    v2 = tostring(v3)
    local v4 = ""
    local v5 = #v2
    local v6 = v5
    for i = 1, v6 do
        if 1 < i and (v5 - i + 1) % 3 == 0 then
            v4 = v4 .. ","
        end
        v4 = v4 .. v2:sub(i, i)
    end
    if v1 < 0 then
        v4 = "-" .. v4
    end
    return v4 .. " Z$"
end

return function(p1) -- Line: 79 -- upvalues: u12 (val), defaultFormat (val), OnEvent (val), UISounds (val)
    local Visible, ZBucksTitle, v1, v2, v3, v4, v5
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u12.ZIndex.Content
    end
    local Format = p1.Format
    if not Format then
        Format = defaultFormat
    end
    local v6 = p1.Icon ~= nil
    local v7 = p1.ShowChrome ~= false
    local PaddingLeft = p1.PaddingLeft
    if not PaddingLeft then
        if not v6 then
            PaddingLeft = 12
        else
            PaddingLeft = 6
        end
    end
    local PaddingRight = p1.PaddingRight
    if not PaddingRight then
        if not p1.ShowPlus then
            PaddingRight = 10
        else
            PaddingRight = 5
        end
    end
    local v8 = scope:Computed(function(p1_2) -- Line: 88 -- upvalues: Format (val), p1 (val)
        return Format(p1_2(p1.Amount))
    end)
    local v9 = {}
    v9.Name = p1.Name or "Currency"
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(0, 30)
    end
    v9.Size = Size
    v9.AutomaticSize = Enum.AutomaticSize.X
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v9.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v9.AnchorPoint = AnchorPoint
    v9.LayoutOrder = p1.LayoutOrder or 0
    v9.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v9.Visible = Visible
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = u12.Menu.PanelInset
    end
    v9.BackgroundColor3 = BackgroundColor3
    v9.BackgroundTransparency = p1.BackgroundTransparency or 0
    v9.BorderSizePixel = 0
    v9.Parent = p1.Parent
    local Children = scope.Children
    local v10 = {}
    if p1.Scale == nil then
        v1 = nil
    else
        v1 = scope:New("UIScale")({Scale = p1.Scale})
    end
    if not v7 then
        v2 = nil
    else
        v2 = scope:New("UICorner")({CornerRadius = UDim.new(1, 0)})
    end
    if not v7 then
        v3 = nil
    else
        v3 = scope:New("UIStroke")
        v4 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border}
        local StrokeColor3 = p1.StrokeColor3
        if not StrokeColor3 then
            StrokeColor3 = u12.Menu.Border
        end
        v4.Color = StrokeColor3
        v4.Thickness = u12.Stroke.Thin
        v3 = v3(v4)
    end
    if not v7 then
        v4 = nil
    else
        v4 = scope:New("UIGradient")
        v5 = {}
        local GradientColor = p1.GradientColor
        if not GradientColor then
            GradientColor = u12.Menu.ButtonGradient
        end
        v5.Color = GradientColor
        v5.Rotation = u12.Menu.ShadeRotation
        v4 = v4(v5)
    end
    v5 = scope:New("UIPadding")({
        PaddingLeft = UDim.new(0, PaddingLeft),
        PaddingRight = UDim.new(0, PaddingRight),
        PaddingTop = UDim.new(0, 4),
        PaddingBottom = UDim.new(0, 4),
    })
    local v11 = scope:New("UIListLayout")
    local v12 = {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 6),
    }
    v11 = v11(v12)
    if not v6 then
        v12 = nil
    else
        v12 = scope:New("ImageLabel")({
            Name = "Icon",
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(20, 20),
            Image = p1.Icon,
            ZIndex = ZIndex + 1,
        })
    end
    local v13 = scope:New("TextLabel")
    local v14 = {
        Name = "Amount",
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        TextSize = 18,
        Size = UDim2.fromOffset(0, 22),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = v8,
        Font = u12.Menu.Fonts.Button,
    }
    if p1.TextColor ~= nil then
        ZBucksTitle = p1.TextColor
    else
        ZBucksTitle = u12.Colors.ZBucksTitle
    end
    v14.TextColor3 = ZBucksTitle
    v14.TextXAlignment = Enum.TextXAlignment.Left
    v14.ZIndex = ZIndex + 1
    v13 = v13(v14)
    if not p1.ShowPlus then
        v14 = nil
    else
        v14 = scope:New("Frame")
        local v15 = {
            Name = "Plus",
            LayoutOrder = 3,
            Size = UDim2.fromOffset(24, 24),
            BackgroundColor3 = u12.Menu.NavigationColors.Play.Fill,
            BorderSizePixel = 0,
            ZIndex = ZIndex + 2,
        }
        local Children_2 = scope.Children
        local v16 = {}
        local v17 = scope:New("UICorner")({CornerRadius = UDim.new(1, 0)})
        local v18 = scope:New("UIStroke")({Color = u12.Menu.NavigationColors.Play.Accent, Thickness = u12.Stroke.Thin})
        local v19 = scope:New("UIGradient")({Color = u12.Menu.NavigationColors.Play.Gradient})
        local v20 = scope:New("TextLabel")
        local v21 = {
            Name = "Label",
            BackgroundTransparency = 1,
            Text = "+",
            TextSize = 19,
            Size = UDim2.fromScale(1, 1),
            Font = u12.Menu.Fonts.Button,
            TextColor3 = u12.Menu.Positive,
            ZIndex = ZIndex + 3,
        }
        v16[1] = v17
        v16[2] = v18
        v16[3] = v19
        v16[4] = v20(v21)
        v15[Children_2] = v16
        v14 = v14(v15)
    end
    v10[1] = v1
    v10[2] = v2
    v10[3] = v3
    v10[4] = v4
    v10[5] = v5
    v10[6] = v11
    v10[7] = v12
    v10[8] = v13
    v10[9] = v14
    v9[Children] = v10
    if not p1.OnClick then
        return scope:New("Frame")(v9)
    end
    v9.Text = ""
    v9.AutoButtonColor = false
    local Activated = OnEvent("Activated")

    v9[Activated] = function() -- Line: 193 -- upvalues: UISounds (upval), p1 (val)
        UISounds.Click()
        p1.OnClick()
    end

    return scope:New("TextButton")(v9)
end