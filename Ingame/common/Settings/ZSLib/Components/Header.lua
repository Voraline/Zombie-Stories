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
    local v4 = {}
    local v5 = scope:New("TextButton")
    local v6 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 184, 84),
        BackgroundTransparency = 0.8,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.99, 0.85),
        Text = "",
    }
    local MouseButton1Click = OnEvent("MouseButton1Click")
    v6[MouseButton1Click] = function() -- Line: 50 -- upvalues: p1 (val), u5 (val), peek (upval)
        if p1.ButtonSound then
            p1.ButtonSound:Play()
        end
        u5:set(not peek(u5))
    end
    local v7 = {}
    local v8 = scope:New("UICorner")
    v8 = v8({})
    local v9 = scope:New("TextLabel")
    v9 = v9({
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
    local v10 = scope:New("ImageLabel")
    local v11 = {
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
    v7[1] = v8
    v7[2] = v9
    v7[3] = v10(v11)
    v6[Children] = v7
    v4[1] = v5(v6)
    v1[Children] = v4
    return v3(v1), u5
end