local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
return function(p1) -- Line: 39 -- upvalues: Children (val), Players (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(p1_2) -- Line: 43 -- upvalues: p1 (val)
        local v1 = p1
        local healthPercentage = v1.healthPercentage
        v1 = (1 - (p1_2(healthPercentage))) * 360
        return (math.max(v1, 180))
    end)
    local v2 = scope:Computed(function(p1_2) -- Line: 49 -- upvalues: p1 (val)
        local v1 = p1
        local healthPercentage = v1.healthPercentage
        v1 = (1 - (p1_2(healthPercentage))) * 360
        return (math.min(v1, 180))
    end)
    local v3 = scope:Computed(function(p1_2) -- Line: 56 -- upvalues: p1 (val)
        local v1 = (1 - p1_2(p1.healthPercentage)) * 360 ~= 360
        return v1
    end)
    local v4 = scope:Computed(function(p1_2) -- Line: 62 -- upvalues: p1 (val)
        local v1 = (1 - p1_2(p1.healthPercentage)) * 360 ~= 360
        return v1
    end)
    local v5 = scope:Computed(function(p1_2) -- Line: 69 -- upvalues: p1 (val)
        local v1 = p1
        local shieldPercentage = v1.shieldPercentage
        v1 = (1 - (p1_2(shieldPercentage))) * 360
        return (math.max(v1, 180))
    end)
    local v6 = scope:Computed(function(p1_2) -- Line: 75 -- upvalues: p1 (val)
        local v1 = p1
        local shieldPercentage = v1.shieldPercentage
        v1 = (1 - (p1_2(shieldPercentage))) * 360
        return (math.min(v1, 180))
    end)
    local v7 = scope:Computed(function(p1_2) -- Line: 81 -- upvalues: p1 (val)
        local v1 = (1 - p1_2(p1.shieldPercentage)) * 360
        local v2 = false
        if v1 ~= 360 then
            v2 = p1_2(p1.shieldVisible)
        end
        return v2
    end)
    local v8 = scope:Computed(function(p1_2) -- Line: 87 -- upvalues: p1 (val)
        local v1 = (1 - p1_2(p1.shieldPercentage)) * 360
        local v2 = false
        if v1 ~= 360 then
            v2 = p1_2(p1.shieldVisible)
        end
        return v2
    end)
    local v9 = scope:New("UIGradient")
    local v10 = {Name = "UIGradient", Rotation = v1}
    local new = NumberSequence.new
    local v11 = {}
    local v12 = NumberSequenceKeypoint.new(0, 1)
    local v13 = NumberSequenceKeypoint.new(0.499, 1)
    local v14 = NumberSequenceKeypoint.new(0.5, 0)
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14
    v11[4] = NumberSequenceKeypoint.new(1, 0)
    v10.Transparency = new(v11)
    v9 = v9(v10)
    v10 = scope:New("UIGradient")
    local v15 = {Name = "UIGradient", Rotation = v2}
    local new_2 = NumberSequence.new
    v12 = {}
    v13 = NumberSequenceKeypoint.new(0, 1)
    v14 = NumberSequenceKeypoint.new(0.499, 1)
    local v16 = NumberSequenceKeypoint.new(0.5, 0)
    v12[1] = v13
    v12[2] = v14
    v12[3] = v16
    v12[4] = NumberSequenceKeypoint.new(1, 0)
    v15.Transparency = new_2(v12)
    v10 = v10(v15)
    v15 = scope:New("ImageLabel")
    v11 = {
        Name = "ImageLabel",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665860902",
        ImageColor3 = p1.healthColor,
        Size = UDim2.fromScale(2, 1),
        Visible = v3,
    }
    v12 = Children
    v11[v12] = {v9}
    v15 = v15(v11)
    v11 = scope:New("ImageLabel")
    v12 = {
        Name = "ImageLabel",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665860902",
        ImageColor3 = p1.healthColor,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.fromScale(2, 1),
        Visible = v4,
    }
    v13 = Children
    v12[v13] = {v10}
    v11 = v11(v12)
    v12 = scope:New("UIGradient")
    v13 = {Name = "UIGradient", Rotation = v5}
    local new_3 = NumberSequence.new
    v16 = {}
    local v17 = NumberSequenceKeypoint.new(0, 1)
    local v18 = NumberSequenceKeypoint.new(0.499, 1)
    local v19 = NumberSequenceKeypoint.new(0.5, 0)
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19
    v16[4] = NumberSequenceKeypoint.new(1, 0)
    v13.Transparency = new_3(v16)
    v12 = v12(v13)
    v13 = scope:New("UIGradient")
    v14 = {Name = "UIGradient", Rotation = v6}
    local new_4 = NumberSequence.new
    v17 = {}
    v18 = NumberSequenceKeypoint.new(0, 1)
    v19 = NumberSequenceKeypoint.new(0.499, 1)
    local v20 = NumberSequenceKeypoint.new(0.5, 0)
    v17[1] = v18
    v17[2] = v19
    v17[3] = v20
    v17[4] = NumberSequenceKeypoint.new(1, 0)
    v14.Transparency = new_4(v17)
    v13 = v13(v14)
    v14 = Color3.fromRGB(100, 180, 255)
    v18 = scope:Computed(function(p1_2) -- Line: 177 -- upvalues: p1 (val)
        if p1_2(p1.shieldBroken) then
            return (Color3.fromRGB(255, 0, 0))
        end
        return (Color3.fromRGB(0, 0, 0))
    end)
    v16 = scope:Spring(v18, 8)
    v17 = scope:Computed(function(p1_2) -- Line: 184 -- upvalues: p1 (val)
        return (p1_2(p1.shieldVisible))
    end)
    v18 = scope:New("ImageLabel")({
        Name = "ShieldBackground",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13665860902",
        ZIndex = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = v16,
        ImageTransparency = p1.shieldBgTransparency,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Visible = v17,
    })
    v19 = scope:New("ImageLabel")
    v20 = {
        Name = "ShieldLeft",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665860902",
        ImageColor3 = v14,
        Size = UDim2.fromScale(2, 1),
        Visible = v7,
    }
    local v21 = Children
    v20[v21] = {v12}
    v19 = v19(v20)
    v20 = scope:New("ImageLabel")
    v21 = {
        Name = "ShieldRight",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665860902",
        ImageColor3 = v14,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.fromScale(2, 1),
        Visible = v8,
    }
    local v22 = Children
    v21[v22] = {v13}
    v20 = v20(v21)
    v21 = scope:New("ImageLabel")
    v22 = {
        Name = "OverLine",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665853889",
        Size = UDim2.fromScale(1, 1),
        ZIndex = 5,
    }
    local v23 = Children
    local v24 = {}
    local v25 = scope:New("UIGradient")({Name = "UIGradient", Transparency = p1.overlineTransparency})
    local v26 = scope:New("UICorner")
    local v27 = {Name = "UICorner", CornerRadius = UDim.new(1, 0)}
    v24[1] = v25
    v24[2] = v26(v27)
    v22[v23] = v24
    v21 = v21(v22)
    v22 = scope:New("ImageLabel")
    v23 = {
        Name = "UnderLine",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665853284",
        ImageColor3 = p1.healthColor,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 4,
    }
    v24 = Children
    v25 = {}
    v26 = scope:New("UIGradient")({Name = "UIGradient", Transparency = p1.underlineTransparency})
    v27 = scope:New("UICorner")
    local v28 = {Name = "UICorner", CornerRadius = UDim.new(1, 0)}
    v25[1] = v26
    v25[2] = v27(v28)
    v23[v24] = v25
    v22 = v22(v23)
    v23 = scope:New("TextLabel")
    v24 = {
        Name = "HealthLabel",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
        Position = UDim2.fromScale(0.5, 0.9),
        Size = UDim2.fromScale(0.4, 0.2),
        Text = p1.healthText,
        TextColor3 = p1.healthColor,
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        ZIndex = 4,
    }
    v25 = Children
    v24[v25] = {scope:New("UIStroke")({Name = "UIStroke", Thickness = 3, Transparency = 0.8})}
    v23 = v23(v24)
    v24 = scope:Computed(function(p1_2) -- Line: 311 -- upvalues: p1 (val)
        local v1 = p1_2(p1.shieldPercentage)
        return UDim2.new(v1, 0, 1, 0)
    end)
    v25 = scope:Computed(function(p1) -- Line: 317
        return false
    end)
    v26 = scope:New("Frame")
    v27 = {
        Name = "ShieldBar",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 0.5,
        Position = UDim2.new(0.5, 0, -0.05, 0),
        Size = UDim2.new(0.8, 0, 0.08, 0),
        Visible = v25,
        ZIndex = 10,
    }
    v28 = Children
    local v29 = {}
    local v30 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.5, 0)})
    local v31 = scope:New("Frame")
    local v32 = {Name = "ShieldFill", BackgroundColor3 = Color3.fromRGB(100, 180, 255), Size = v24, ZIndex = 11}
    local v33 = Children
    local v34 = {}
    local v35 = scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.5, 0)})
    local v36 = scope:New("UIGradient")
    local v37 = {
        Name = "UIGradient",
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 160, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 200, 255)),
        }),
    }
    v34[1] = v35
    v34[2] = v36(v37)
    v32[v33] = v34
    v29[1] = v30
    v29[2] = v31(v32)
    v27[v28] = v29
    v26 = v26(v27)
    v27 = scope:New("ViewportFrame")
    v28 = {
        Name = "PlayerFrame",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = p1.playerFrameColor,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.8),
        ZIndex = 3,
        Ambient = Color3.fromRGB(200, 200, 200),
        LightColor = Color3.fromRGB(140, 140, 140),
        LightDirection = Vector3.new(-1, -1, -1),
    }
    v29 = Children
    v28[v29] = {scope:New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(1, 0)})}
    v27 = v27(v28)
    v28 = scope:New("Frame")
    v29 = {
        Name = "Frame",
        AnchorPoint = Vector2.new(0, 1),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.01, 0.99),
        Size = UDim2.fromScale(0.15, 0.15),
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    v30 = Children
    v31 = {}
    v33 = scope:New("Frame")
    v34 = {
        Name = "HealthCircle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
        ZIndex = 2,
    }
    v35 = Children
    v36 = {}
    v37 = scope:New("Frame")
    local v38 = {
        Name = "LeftFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    local v39 = Children
    v38[v39] = {v15}
    v37 = v37(v38)
    v38 = scope:New("Frame")
    v39 = {
        Name = "RightFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    local v40 = Children
    v39[v40] = {v11}
    v36[1] = v37
    v36[2] = v38(v39)
    v34[v35] = v36
    v33 = v33(v34)
    v34 = scope:New("Frame")
    v35 = {
        Name = "ShieldCircle",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.05, 1.05),
        ZIndex = 1,
    }
    v36 = Children
    v37 = {}
    v39 = scope:New("Frame")
    v40 = {
        Name = "ShieldLeftFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 1,
    }
    local v41 = Children
    v40[v41] = {v19}
    v39 = v39(v40)
    v40 = scope:New("Frame")
    v41 = {
        Name = "ShieldRightFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 1,
    }
    local v42 = Children
    v41[v42] = {v20}
    v37[1] = v18
    v37[2] = v39
    v37[3] = v40(v41)
    v35[v36] = v37
    v34 = v34(v35)
    v35 = scope:New("Frame")
    v36 = {
        Name = "ECG",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.8, 0.8),
        ZIndex = 5,
    }
    v37 = Children
    v36[v37] = {v21, v22}
    v35 = v35(v36)
    v31[1] = v27
    v31[2] = v33
    v31[3] = v34
    v31[4] = v35
    v31[5] = v23
    v31[6] = v26
    v29[v30] = v31
    v28 = v28(v29)
    v29 = scope:New("ScreenGui")
    v30 = {
        Name = "HealthUI",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    v31 = Children
    v30[v31] = {v28}
    v29 = v29(v30)
    return {
        screenGui = v29,
        mainFrame = v28,
        playerFrame = v27,
        healthLabel = v23,
        leftCircleGradient = v9,
        rightCircleGradient = v10,
        leftCircleImage = v15,
        rightCircleImage = v11,
        underLine = v22,
        overLine = v21,
        shieldBar = v26,
    }
end