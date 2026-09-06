local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
return function(p1) -- Line: 13 -- upvalues: fusion_utils (val)
    local Children_3, Children_4, Children_5, Children_6, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    local v15 = p1.scope:innerScope(fusion_utils)
    local v16 = v15:usePx()
    local u11 = v16(1)
    v16(2)
    local v17 = v15:New("Frame")
    v17 = v17({BackgroundTransparency = 1, Parent = p1.target, Size = UDim2.new(1, 0, 1, 0)})
    local u427 = {}
    local v18 = v15:Value(UDim2.new(0.5, 0, 1, 0))
    u427[1] = v18
    local v19 = v15:New("Frame")
    local v20 = {
        Parent = v17,
        Size = UDim2.new(0.5, 0, 0.1, 0),
        Position = v15:Spring(v18, 30, 1),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    }
    local Children = v15.Children
    local v21 = {}
    local v22 = v15:New("UIStroke")
    v22 = v22({Transparency = 0.75, Color = Color3.fromRGB(0, 0, 0), Thickness = u11, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
    local v23 = v15:New("TextLabel")
    local v24 = {
        Text = "RESULTS",
        TextScaled = true,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
    }
    local Children_2 = v15.Children
    local v25 = {}
    local v26 = v15:New("UIStroke")
    v25[1] = v26({Thickness = u11})
    v24[Children_2] = v25
    v23 = v23(v24)
    v24 = v15:New("UIGradient")
    local v27 = {Rotation = 90}
    v26 = {}
    local v28 = ColorSequenceKeypoint.new(0, Color3.fromHex("#00089c"))
    v26[1] = v28
    v26[2] = ColorSequenceKeypoint.new(1, Color3.fromHex("#00056f"))
    v27.Color = ColorSequence.new(v26)
    v21[1] = v22
    v21[2] = v23
    v21[3] = v24(v27)
    v20[Children] = v21
    v19(v20)
    v19 = v15:Computed(function(p1) -- Line: 72 -- upvalues: u11 (val)
        return UDim.new(0, p1(u11) * 6)
    end)
    local Players = p1.Players
    local v29 = nil
    v21 = nil
    local u426 = p1
    for i, j in Players, v29, v21 do
        v24 = v15:Value(UDim2.new(0.5, 0, 1, 0))
        u427[i + 1] = v24
        if i == 1 then
            v26 = {}
            v28 = ColorSequenceKeypoint.new(0, Color3.fromHex("#fbbc0d"))
            v26[1] = v28
            v26[2] = ColorSequenceKeypoint.new(1, Color3.fromHex("#f9d205"))
            v27 = ColorSequence.new(v26)
        elseif i == 2 then
            v26 = {}
            v28 = ColorSequenceKeypoint.new(0, Color3.fromHex("#d4d4d4"))
            v26[1] = v28
            v26[2] = ColorSequenceKeypoint.new(1, Color3.fromHex("#c3bdbd"))
            v27 = ColorSequence.new(v26)
        elseif i ~= 3 then
            v26 = {}
            v28 = ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50))
            v26[1] = v28
            v26[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))
            v27 = ColorSequence.new(v26)
        else
            v26 = {}
            v28 = ColorSequenceKeypoint.new(0, Color3.fromHex("#de8606"))
            v26[1] = v28
            v26[2] = ColorSequenceKeypoint.new(1, Color3.fromHex("#c97700"))
            v27 = ColorSequence.new(v26)
        end
        v25 = v15:New("Frame")
        v26 = {Parent = v17, Size = UDim2.new(0.5, 0, 0.08, 0), Position = v15:Spring(v24, 30, 1), AnchorPoint = Vector2.new(0.5, 0)}
        Children_3 = v15.Children
        v1 = {}
        v2 = v15:New("UIStroke")
        v2 = v2({Transparency = 0.75, Color = Color3.fromRGB(0, 0, 0), Thickness = u11, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
        v3 = v15:New("UIGradient")
        v3 = v3({Rotation = 90, Color = v27})
        v4 = v15:New("UIPadding")
        v4 = v4({PaddingTop = v19, PaddingBottom = v19, PaddingLeft = v19, PaddingRight = v19})
        v5 = v15:New("ImageLabel")
        v6 = {
            Image = j.Image,
            Size = UDim2.new(1, 0, 1, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            BackgroundTransparency = 0.75,
            ImageColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        }
        Children_4 = v15.Children
        v8 = {}
        v9 = v15:New("UIAspectRatioConstraint")
        v9 = v9({AspectRatio = 1})
        v10 = v15:New("UIStroke")
        v10 = v10({Transparency = 0.5, Color = Color3.fromRGB(0, 0, 0), Thickness = u11, ApplyStrokeMode = Enum.ApplyStrokeMode.Border})
        v11 = v15:New("TextLabel")
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
        Children_5 = v15.Children
        v13 = {}
        v14 = v15:New("UIStroke")
        v13[1] = v14({Transparency = 0.5, Thickness = u11})
        v12[Children_5] = v13
        v8[1] = v9
        v8[2] = v10
        v8[3] = v11(v12)
        v6[Children_4] = v8
        v5 = v5(v6)
        v6 = v15:New("TextLabel")
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
        Children_6 = v15.Children
        v9 = {}
        v10 = v15:New("UIStroke")
        v9[1] = v10({Transparency = 0.5, Thickness = u11})
        v7[Children_6] = v9
        v1[1] = v2
        v1[2] = v3
        v1[3] = v4
        v1[4] = v5
        v1[5] = v6(v7)
        v26[Children_3] = v1
        v25(v26)
    end
    task.delay(0.01, function() -- Line: 190 -- upvalues: u427 (val), u426 (val)
        local v1
        local v2 = u427
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            v1 = if 1 < i then 0.02 else 0
            if u426.PlaySound then
                u426.PlaySound("Enter")
            end
            j:set(UDim2.new(0.5, 0, 0.05 + (i - 1) * 0.1 + v1, 0))
            task.wait(0.15)
        end
    end)
    return v17, function() -- Line: 206 -- upvalues: u427 (val), u426 (val)
        local v1 = u427
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            j:set(UDim2.new(0.5, 0, -0.15, 0))
            if u426.PlaySound then
                u426.PlaySound("Leave")
            end
            task.wait(0.15)
        end
    end
end