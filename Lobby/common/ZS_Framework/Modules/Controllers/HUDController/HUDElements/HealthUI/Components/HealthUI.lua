local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
return function(p1) -- Line: 39 -- upvalues: Children (val), Players (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(a1) -- Line: 43 -- upvalues: p1 (val)
        return (math.max((1 - a1(p1.healthPercentage)) * 360, 180))
    end)
    local v2 = scope:Computed(function(a1) -- Line: 49 -- upvalues: p1 (val)
        return (math.min((1 - a1(p1.healthPercentage)) * 360, 180))
    end)
    local v3 = scope:Computed(function(a1) -- Line: 56 -- upvalues: p1 (val)
        local v1 = (1 - a1(p1.healthPercentage)) * 360 ~= 360
        return v1
    end)
    local v4 = scope:Computed(function(a1) -- Line: 62 -- upvalues: p1 (val)
        local v1 = (1 - a1(p1.healthPercentage)) * 360 ~= 360
        return v1
    end)
    local v5 = scope:Computed(function(a1) -- Line: 69 -- upvalues: p1 (val)
        return (math.max((1 - a1(p1.shieldPercentage)) * 360, 180))
    end)
    local v6 = scope:Computed(function(a1) -- Line: 75 -- upvalues: p1 (val)
        return (math.min((1 - a1(p1.shieldPercentage)) * 360, 180))
    end)
    local v7 = scope:Computed(function(a1) -- Line: 81 -- upvalues: p1 (val)
        local v1 = (1 - a1(p1.shieldPercentage)) * 360
        local v2 = if v1 ~= 360 then a1(p1.shieldVisible) else false
        return v2
    end)
    local v8 = scope:Computed(function(a1) -- Line: 87 -- upvalues: p1 (val)
        local v1 = (1 - a1(p1.shieldPercentage)) * 360
        local v2 = if v1 ~= 360 then a1(p1.shieldVisible) else false
        return v2
    end)
    local v9 = scope:New("UIGradient")
    local v10 = {Name = "UIGradient", Rotation = v1}
    local v11 = {}
    local v12 = NumberSequenceKeypoint.new(0, 1)
    local v13 = NumberSequenceKeypoint.new(0.499, 1)
    local v14 = NumberSequenceKeypoint.new(0.5, 0)
    v11[1] = v12
    v11[2] = v13
    v11[3] = v14
    v11[4] = NumberSequenceKeypoint.new(1, 0)
    v10.Transparency = NumberSequence.new(v11)
    v9 = v9(v10)
    v10 = scope:New("UIGradient")
    local v15 = {Name = "UIGradient", Rotation = v2}
    v12 = {}
    v13 = NumberSequenceKeypoint.new(0, 1)
    v14 = NumberSequenceKeypoint.new(0.499, 1)
    local v16 = NumberSequenceKeypoint.new(0.5, 0)
    v12[1] = v13
    v12[2] = v14
    v12[3] = v16
    v12[4] = NumberSequenceKeypoint.new(1, 0)
    v15.Transparency = NumberSequence.new(v12)
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
    v11[Children] = {v9}
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
    v12[Children] = {v10}
    v11 = v11(v12)
    v12 = scope:New("UIGradient")
    v13 = {Name = "UIGradient", Rotation = v5}
    v16 = {}
    local v17 = NumberSequenceKeypoint.new(0, 1)
    local v18 = NumberSequenceKeypoint.new(0.499, 1)
    local v19 = NumberSequenceKeypoint.new(0.5, 0)
    v16[1] = v17
    v16[2] = v18
    v16[3] = v19
    v16[4] = NumberSequenceKeypoint.new(1, 0)
    v13.Transparency = NumberSequence.new(v16)
    v12 = v12(v13)
    v13 = scope:New("UIGradient")
    v14 = {Name = "UIGradient", Rotation = v6}
    v17 = {}
    v18 = NumberSequenceKeypoint.new(0, 1)
    v19 = NumberSequenceKeypoint.new(0.499, 1)
    local v20 = NumberSequenceKeypoint.new(0.5, 0)
    v17[1] = v18
    v17[2] = v19
    v17[3] = v20
    v17[4] = NumberSequenceKeypoint.new(1, 0)
    v14.Transparency = NumberSequence.new(v17)
    v13 = v13(v14)
    v14 = Color3.fromRGB(100, 180, 255)
    v18 = scope:Computed(function(a1) -- Line: 177 -- upvalues: p1 (val)
        if a1(p1.shieldBroken) then
            return (Color3.fromRGB(255, 0, 0))
        end
        return (Color3.fromRGB(0, 0, 0))
    end)
    v16 = scope:Spring(v18, 8)
    v17 = scope:Computed(function(a1) -- Line: 184 -- upvalues: p1 (val)
        return (a1(p1.shieldVisible))
    end)
    v18 = scope:New("ImageLabel")
    v18 = v18({
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
    v20[Children] = {v12}
    v19 = v19(v20)
    v20 = scope:New("ImageLabel")
    local v21 = {
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
    v21[Children] = {v13}
    v20 = v20(v21)
    v21 = scope:New("ImageLabel")
    local v22 = {
        Name = "OverLine",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665853889",
        Size = UDim2.fromScale(1, 1),
        ZIndex = 5,
    }
    local v23 = {}
    local v24 = scope:New("UIGradient")
    v24 = v24({Name = "UIGradient", Transparency = p1.overlineTransparency})
    local v25 = scope:New("UICorner")
    local v26 = {Name = "UICorner", CornerRadius = UDim.new(1, 0)}
    v23[1] = v24
    v23[2] = v25(v26)
    v22[Children] = v23
    v21 = v21(v22)
    v22 = scope:New("ImageLabel")
    local v27 = {
        Name = "UnderLine",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13665853284",
        ImageColor3 = p1.healthColor,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 4,
    }
    v24 = {}
    v25 = scope:New("UIGradient")
    v25 = v25({Name = "UIGradient", Transparency = p1.underlineTransparency})
    v26 = scope:New("UICorner")
    local v28 = {Name = "UICorner", CornerRadius = UDim.new(1, 0)}
    v24[1] = v25
    v24[2] = v26(v28)
    v27[Children] = v24
    v22 = v22(v27)
    v27 = scope:New("TextLabel")
    v23 = {
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
    v25 = {}
    v26 = scope:New("UIStroke")
    v25[1] = v26({Name = "UIStroke", Thickness = 3, Transparency = 0.8})
    v23[Children] = v25
    v27 = v27(v23)
    v23 = scope:Computed(function(a1) -- Line: 311 -- upvalues: p1 (val)
        local v1 = a1(p1.shieldPercentage)
        return UDim2.new(v1, 0, 1, 0)
    end)
    v24 = scope:Computed(function(p1) -- Line: 317
        return false
    end)
    v25 = scope:New("Frame")
    v26 = {
        Name = "ShieldBar",
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BackgroundTransparency = 0.5,
        Position = UDim2.new(0.5, 0, -0.05, 0),
        Size = UDim2.new(0.8, 0, 0.08, 0),
        Visible = v24,
        ZIndex = 10,
    }
    local v29 = {}
    local v30 = scope:New("UICorner")
    v30 = v30({Name = "UICorner", CornerRadius = UDim.new(0.5, 0)})
    local v31 = scope:New("Frame")
    local v32 = {Name = "ShieldFill", BackgroundColor3 = Color3.fromRGB(100, 180, 255), Size = v23, ZIndex = 11}
    local v33 = {}
    local v34 = scope:New("UICorner")
    v34 = v34({Name = "UICorner", CornerRadius = UDim.new(0.5, 0)})
    local v35 = scope:New("UIGradient")
    local v36 = {Name = "UIGradient", Rotation = 90}
    local v37 = {}
    local v38 = ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 160, 255))
    v37[1] = v38
    v37[2] = ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 200, 255))
    v36.Color = ColorSequence.new(v37)
    v33[1] = v34
    v33[2] = v35(v36)
    v32[Children] = v33
    v29[1] = v30
    v29[2] = v31(v32)
    v26[Children] = v29
    v25 = v25(v26)
    v26 = scope:New("ViewportFrame")
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
    v30 = {}
    v31 = scope:New("UICorner")
    v30[1] = v31({Name = "UICorner", CornerRadius = UDim.new(1, 0)})
    v28[Children] = v30
    v26 = v26(v28)
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
    v31 = {}
    local v39 = scope:New("Frame")
    v33 = {
        Name = "HealthCircle",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
        ZIndex = 2,
    }
    v35 = {}
    v36 = scope:New("Frame")
    local v40 = {
        Name = "LeftFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    v40[Children] = {v15}
    v36 = v36(v40)
    v40 = scope:New("Frame")
    v37 = {
        Name = "RightFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    v37[Children] = {v11}
    v35[1] = v36
    v35[2] = v40(v37)
    v33[Children] = v35
    v39 = v39(v33)
    v33 = scope:New("Frame")
    v34 = {
        Name = "ShieldCircle",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.05, 1.05),
        ZIndex = 1,
    }
    v36 = {}
    v37 = scope:New("Frame")
    v38 = {
        Name = "ShieldLeftFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 1,
    }
    v38[Children] = {v19}
    v37 = v37(v38)
    v38 = scope:New("Frame")
    local v41 = {
        Name = "ShieldRightFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 1,
    }
    v41[Children] = {v20}
    v36[1] = v18
    v36[2] = v37
    v36[3] = v38(v41)
    v34[Children] = v36
    v33 = v33(v34)
    v34 = scope:New("Frame")
    v35 = {
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
    v35[Children] = {v21, v22}
    v34 = v34(v35)
    v31[1] = v26
    v31[2] = v39
    v31[3] = v33
    v31[4] = v34
    v31[5] = v27
    v31[6] = v25
    v29[Children] = v31
    v28 = v28(v29)
    v29 = scope:New("ScreenGui")
    v30 = {Name = "HealthUI", Parent = Players.LocalPlayer:WaitForChild("PlayerGui"), ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}
    v30[Children] = {v28}
    v29 = v29(v30)
    return {
        screenGui = v29,
        mainFrame = v28,
        playerFrame = v26,
        healthLabel = v27,
        leftCircleGradient = v9,
        rightCircleGradient = v10,
        leftCircleImage = v15,
        rightCircleImage = v11,
        underLine = v22,
        overLine = v21,
        shieldBar = v25,
    }
end