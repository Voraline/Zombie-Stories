local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
return function(p1) -- Line: 13 -- upvalues: fusion_utils (val)
    local Children_3, Children_4, Children_5, Children_6, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local scope = p1.scope
    local v13 = fusion_utils
    local v14 = scope:innerScope(v13)
    local v15 = v14:usePx()
    local u11 = v15(1)
    v15(2)
    local v16 = v14:New("Frame")({BackgroundTransparency = 1, Parent = p1.target, Size = UDim2.new(1, 0, 1, 0)})
    local u427 = {}
    local v17 = UDim2.new(0.5, 0, 1, 0)
    local v18 = v14:Value(v17)
    u427[1] = v18
    local v19 = v14:New("Frame")
    v17 = {
        Parent = v16,
        Size = UDim2.new(0.5, 0, 0.1, 0),
        Position = v14:Spring(v18, 30, 1),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    }
    local Children = v14.Children
    local v20 = {}
    local v21 = v14:New("UIStroke")({
        Transparency = 0.75,
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = u11,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })
    local v22 = v14:New("TextLabel")
    local v23 = {
        Text = "RESULTS",
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
    }
    local Children_2 = v14.Children
    local v24 = {v14:New("UIStroke")({Thickness = u11})}
    v23[Children_2] = v24
    v22 = v22(v23)
    v23 = v14:New("UIGradient")
    local v25 = {Rotation = 90}
    local new_2 = ColorSequence.new
    local v26 = {
        ColorSequenceKeypoint.new(0, Color3.fromHex("#00089c")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("#00056f")),
    }
    v25.Color = new_2(v26)
    v20[1] = v21
    v20[2] = v22
    v20[3] = v23(v25)
    v17[Children] = v20
    v19(v17)
    v19 = v14:Computed(function(p1) -- Line: 72 -- upvalues: u11 (val)
        return UDim.new(0, p1(u11) * 6)
    end)
    local Players = p1.Players
    local v27 = nil
    v20 = nil
    for i, j in Players, v27, v20 do
        v24 = UDim2.new(0.5, 0, 1, 0)
        v23 = v14:Value(v24)
        u427[i + 1] = v23
        if i == 1 then
            v25 = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex("#fbbc0d")),
                ColorSequenceKeypoint.new(1, Color3.fromHex("#f9d205")),
            })
        elseif i == 2 then
            v25 = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex("#d4d4d4")),
                ColorSequenceKeypoint.new(1, Color3.fromHex("#c3bdbd")),
            })
        elseif i ~= 3 then
            v25 = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)),
            })
        else
            v25 = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromHex("#de8606")),
                ColorSequenceKeypoint.new(1, Color3.fromHex("#c97700")),
            })
        end
        v24 = v14:New("Frame")
        v26 = {
            Parent = v16,
            Size = UDim2.new(0.5, 0, 0.08, 0),
            Position = v14:Spring(v23, 30, 1),
            AnchorPoint = Vector2.new(0.5, 0),
        }
        Children_3 = v14.Children
        v1 = {}
        v2 = v14:New("UIStroke")({
            Transparency = 0.75,
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = u11,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        })
        v3 = v14:New("UIGradient")({Rotation = 90, Color = v25})
        v4 = v14:New("UIPadding")({PaddingTop = v19, PaddingBottom = v19, PaddingLeft = v19, PaddingRight = v19})
        v5 = v14:New("ImageLabel")
        v6 = {
            Image = j.Image,
            Size = UDim2.new(1, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            BackgroundTransparency = 0.75,
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        }
        Children_4 = v14.Children
        v8 = {}
        v9 = v14:New("UIAspectRatioConstraint")({AspectRatio = 1})
        v10 = v14:New("UIStroke")({
            Transparency = 0.5,
            Color = Color3.fromRGB(0, 0, 0),
            Thickness = u11,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        })
        v11 = v14:New("TextLabel")
        v12 = {
            Text = string.upper(j.Name),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Position = UDim2.new(1.2, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Size = UDim2.new(5, 0, 3, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
        }
        Children_5 = v14.Children
        v12[Children_5] = {v14:New("UIStroke")({Transparency = 0.5, Thickness = u11})}
        v8[1] = v9
        v8[2] = v10
        v8[3] = v11(v12)
        v6[Children_4] = v8
        v5 = v5(v6)
        v6 = v14:New("TextLabel")
        v7 = {
            Text = j.Score,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Position = UDim2.new(1, 0, 0.5, 0),
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.1, 0, 1, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
        }
        Children_6 = v14.Children
        v7[Children_6] = {v14:New("UIStroke")({Transparency = 0.5, Thickness = u11})}
        v1[1] = v2
        v1[2] = v3
        v1[3] = v4
        v1[4] = v5
        v1[5] = v6(v7)
        v26[Children_3] = v1
        v24(v26)
    end
    task.delay(0.01, function() -- Line: 190 -- upvalues: u427 (val), p1 (val)
        local v1, v2
        local v3 = u427
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v1 = 0
            if 1 < i then
                v1 = 0.02
            end
            if p1.PlaySound then
                p1.PlaySound("Enter")
            end
            v2 = UDim2.new(0.5, 0, 0.05 + (i - 1) * 0.1 + v1, 0)
            j:set(v2)
            task.wait(0.15)
        end
    end)
    return v16, function() -- Line: 206 -- upvalues: u427 (val), p1 (val)
        local v1
        local v2 = u427
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            v1 = UDim2.new(0.5, 0, -0.15, 0)
            j:set(v1)
            if p1.PlaySound then
                p1.PlaySound("Leave")
            end
            task.wait(0.15)
        end
    end
end