local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local u16 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
return function(p1) -- Line: 25 -- upvalues: Children (val), OnEvent (val), peek (val), u16 (val)
    local scope = p1.scope
    local u5 = scope:Value(true)
    local v1 = scope:Computed(function(p1) -- Line: 29 -- upvalues: u5 (val)
        if p1(u5) then
            return 0
        end
        return -90
    end)
    local v2 = scope:Spring(v1, 25, 1)
    local v3 = scope:New("Frame")
    v1 = {
        Name = "Header",
        BackgroundTransparency = 1,
        LayoutOrder = p1.LayoutOrder or 1,
        Size = UDim2.fromScale(1, 0.09),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
    }
    local v4 = Children
    local v5 = {}
    local v6 = scope:New("TextButton")
    local v7 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 184, 84),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
        Text = "",
    }
    local MouseButton1Click = OnEvent("MouseButton1Click")

    v7[MouseButton1Click] = function() -- Line: 50 -- upvalues: p1 (val), u5 (val), peek (upval)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        local v1 = u5
        local v2 = peek
        local v3 = u5
        v2 = v2(v3)
        v1:set(not v2)
    end

    local v8 = Children
    local v9 = {}
    local v10 = scope:New("UICorner")({})
    local v11 = scope:New("TextLabel")({
        Name = "Label",
        BackgroundTransparency = 1,
        TextScaled = true,
        AnchorPoint = Vector2.new(0, 0.5),
        FontFace = u16,
        Position = UDim2.fromScale(0.05, 0.5),
        Size = UDim2.fromScale(0.8, 0.9),
        Text = p1.Text,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    local v12 = scope:New("ImageLabel")
    local v13 = {
        Name = "Arrow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://3926305904",
        AnchorPoint = Vector2.new(1, 0.5),
        ImageColor3 = Color3.fromRGB(255, 184, 84),
        ImageRectOffset = Vector2.new(404, 284),
        ImageRectSize = Vector2.new(36, 36),
        Position = UDim2.fromScale(0.97, 0.5),
        Size = UDim2.fromScale(0.06, 0.06),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        Rotation = v2,
    }
    v9[1] = v10
    v9[2] = v11
    v9[3] = v12(v13)
    v7[v8] = v9
    v5[1] = v6(v7)
    v1[v4] = v5
    return v3(v1), u5
end