local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u13 = require("../Theme")
return function(p1) -- Line: 27 -- upvalues: u13 (val), OnEvent (val), peek (val)
    local Visible
    local scope = p1.scope
    local ZIndex = p1.ZIndex
    if not ZIndex then
        ZIndex = u13.ZIndex.Content
    end
    local u10 = scope:Value(true)
    local v1 = scope:Computed(function(p1) -- Line: 33 -- upvalues: u10 (val)
        if p1(u10) then
            return 0
        end
        return -90
    end)
    local v2 = scope:Spring(v1, 25, 1)
    local v3 = scope:New("Frame")
    v1 = {Name = p1.Name or "SectionHeader"}
    local Size = p1.Size
    if not Size then
        Size = UDim2.new(1, 0, 0, 30)
    end
    v1.Size = Size
    v1.LayoutOrder = p1.LayoutOrder or 0
    if p1.Visible ~= nil then
        Visible = p1.Visible
    else
        Visible = true
    end
    v1.Visible = Visible
    v1.BackgroundTransparency = 1
    v1.ZIndex = ZIndex
    local Children = scope.Children
    local v4 = {}
    local v5 = scope:New("TextButton")
    local v6 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.88),
        BackgroundColor3 = u13.Menu.Accent,
        BackgroundTransparency = u13.Menu.SectionHeaderTransparency,
        Text = "",
        AutoButtonColor = false,
        ZIndex = ZIndex,
    }
    local Activated = OnEvent("Activated")
    v6[Activated] = function() -- Line: 60 -- upvalues: p1 (val), u10 (val), peek (upval)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        u10:set(not peek(u10))
    end
    local Children_2 = scope.Children
    local v7 = {}
    local v8 = scope:New("UICorner")
    v8 = v8({CornerRadius = u13.Menu.CornerScale})
    local v9 = scope:New("TextLabel")
    v9 = v9({
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0.05, 0.5),
        Size = UDim2.fromScale(0.78, 0.75),
        Text = p1.Text,
        Font = u13.Menu.Fonts.Header,
        TextColor3 = u13.Menu.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = ZIndex + 1,
    })
    local v10 = scope:New("ImageLabel")
    local v11 = {
        Name = "Chevron",
        BackgroundTransparency = 1,
        Image = "rbxassetid://3926305904",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.fromScale(0.96, 0.5),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        ImageColor3 = u13.Menu.Accent,
        ImageRectOffset = Vector2.new(404, 284),
        ImageRectSize = Vector2.new(36, 36),
        Rotation = v2,
        ZIndex = ZIndex + 1,
    }
    v7[1] = v8
    v7[2] = v9
    v7[3] = v10(v11)
    v6[Children_2] = v7
    v4[1] = v5(v6)
    v1[Children] = v4
    return v3(v1), u10
end