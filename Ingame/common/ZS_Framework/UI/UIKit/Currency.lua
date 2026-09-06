local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OnEvent = require(ReplicatedStorage.Packages.Fusion).OnEvent
local u12 = require("../Theme")
local UISounds = require(script.Parent.UISounds)
local function defaultFormat(p1) -- Line: 62
    local v1
    local v2 = tostring((math.floor(math.abs(p1) + 0.5)))
    local v3 = ""
    local v4 = #v2
    local v5 = v4
    local v6 = 1
    for i = 1, v5, v6 do
        if 1 < i and (v4 - i + 1) % 3 == 0 then
            v3 = v3 .. ","
        end
        v3 = v3 .. v2:sub(i, i)
    end
    if v1 < 0 then
        v3 = "-" .. v3
    end
    return v3 .. " Z$"
end
return function(p1) -- Line: 79 -- upvalues: u12 (val), defaultFormat (val), OnEvent (val), UISounds (val)
    local Visible, ZBucksTitle, v1, v2, v3, v4, v5, v6
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u12.ZIndex.Content
    end
    local Format = p1.Format
    if not Format then
        Format = defaultFormat
    end
    local v7 = p1.Icon ~= nil
    local v8 = p1.ShowChrome ~= false
    local PaddingLeft = p1.PaddingLeft
    if not PaddingLeft then
        if not v7 then
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
    local v9 = scope:Computed(function(a1) -- Line: 88 -- upvalues: Format (val), p1 (val)
        return Format(a1(p1.Amount))
    end)
    local v10 = {Name = p1.Name or "Currency"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.fromOffset(0, 30)
    end
    v10.Size = Size
    v10.AutomaticSize = Enum.AutomaticSize.X
    local Position = p1.Position
    if not Position then
        Position = UDim2.fromScale(0, 0)
    end
    v10.Position = Position
    local AnchorPoint = p1.AnchorPoint
    if not AnchorPoint then
        AnchorPoint = Vector2.new(0, 0)
    end
    v10.AnchorPoint = AnchorPoint
    v10.LayoutOrder = p1.LayoutOrder or 0
    v10.ZIndex = ZIndex
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v10.Visible = Visible
    local BackgroundColor3 = p1.BackgroundColor3
    if not BackgroundColor3 then
        BackgroundColor3 = u12.Menu.PanelInset
    end
    v10.BackgroundColor3 = BackgroundColor3
    v10.BackgroundTransparency = p1.BackgroundTransparency or 0
    v10.BorderSizePixel = 0
    v10.Parent = p1.Parent
    local Children = scope.Children
    local v11 = {}
    if p1.Scale == nil then
        v2 = nil
    else
        v2 = scope:New("UIScale")
        v2 = v2({Scale = p1.Scale})
    end
    if not v8 then
        v3 = nil
    else
        v3 = scope:New("UICorner")
        v3 = v3({CornerRadius = UDim.new(1, 0)})
    end
    if not v8 then
        v4 = nil
    else
        v4 = scope:New("UIStroke")
        v5 = {ApplyStrokeMode = Enum.ApplyStrokeMode.Border}
        local StrokeColor3 = p1.StrokeColor3
        if not StrokeColor3 then
            StrokeColor3 = u12.Menu.Border
        end
        v5.Color = StrokeColor3
        v5.Thickness = u12.Stroke.Thin
        v4 = v4(v5)
    end
    if not v8 then
        v5 = nil
    else
        v5 = scope:New("UIGradient")
        v6 = {}
        local GradientColor = p1.GradientColor
        if not GradientColor then
            GradientColor = u12.Menu.ButtonGradient
        end
        v6.Color = GradientColor
        v6.Rotation = u12.Menu.ShadeRotation
        v5 = v5(v6)
    end
    v6 = scope:New("UIPadding")
    v6 = v6({PaddingLeft = UDim.new(0, PaddingLeft), PaddingRight = UDim.new(0, PaddingRight), PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4)})
    local v12 = scope:New("UIListLayout")
    local v13 = {FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6)}
    v12 = v12(v13)
    if not v7 then
        v13 = nil
    else
        v13 = scope:New("ImageLabel")
        v13 = v13({
            Name = "Icon",
            LayoutOrder = 1,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(20, 20),
            Image = p1.Icon,
            ZIndex = ZIndex + 1,
        })
    end
    local v14 = scope:New("TextLabel")
    local v15 = {
        Name = "Amount",
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        TextSize = 18,
        Size = UDim2.fromOffset(0, 22),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = v9,
        Font = u12.Menu.Fonts.Button,
    }
    if p1.TextColor ~= nil then
        ZBucksTitle = p1.TextColor
    else
        ZBucksTitle = u12.Colors.ZBucksTitle
    end
    v15.TextColor3 = ZBucksTitle
    v15.TextXAlignment = Enum.TextXAlignment.Left
    v15.ZIndex = ZIndex + 1
    v14 = v14(v15)
    if not p1.ShowPlus then
        v15 = nil
    else
        v15 = scope:New("Frame")
        local v16 = {
            Name = "Plus",
            LayoutOrder = 3,
            Size = UDim2.fromOffset(24, 24),
            BackgroundColor3 = u12.Menu.NavigationColors.Play.Fill,
            BorderSizePixel = 0,
            ZIndex = ZIndex + 2,
        }
        local Children_2 = scope.Children
        local v17 = {}
        local v18 = scope:New("UICorner")
        v18 = v18({CornerRadius = UDim.new(1, 0)})
        local v19 = scope:New("UIStroke")
        v19 = v19({Color = u12.Menu.NavigationColors.Play.Accent, Thickness = u12.Stroke.Thin})
        local v20 = scope:New("UIGradient")
        v20 = v20({Color = u12.Menu.NavigationColors.Play.Gradient})
        local v21 = scope:New("TextLabel")
        local v22 = {
            Name = "Label",
            BackgroundTransparency = 1,
            Text = "+",
            TextSize = 19,
            Size = UDim2.fromScale(1, 1),
            Font = u12.Menu.Fonts.Button,
            TextColor3 = u12.Menu.Positive,
            ZIndex = ZIndex + 3,
        }
        v17[1] = v18
        v17[2] = v19
        v17[3] = v20
        v17[4] = v21(v22)
        v16[Children_2] = v17
        v15 = v15(v16)
    end
    v11[1] = v2
    v11[2] = v3
    v11[3] = v4
    v11[4] = v5
    v11[5] = v6
    v11[6] = v12
    v11[7] = v13
    v11[8] = v14
    v11[9] = v15
    v10[Children] = v11
    if not p1.OnClick then
        v1 = scope:New("Frame")
        return v1(v10)
    end
    v10.Text = ""
    v10.AutoButtonColor = false
    local Activated = OnEvent("Activated")
    v10[Activated] = function() -- Line: 193 -- upvalues: UISounds (upval), p1 (val)
        UISounds.Click()
        p1.OnClick()
    end
    v1 = scope:New("TextButton")
    return v1(v10)
end