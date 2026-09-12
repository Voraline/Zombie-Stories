local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Children = (require(ReplicatedStorage.Packages.Fusion)).Children
local u17 = require("../../../SharedComponents/WheelFrame")
local u20 = require("../../../SharedComponents/CanvasFrame")
local u23 = require("./ChargeAttackIndicator")
return function(p1) -- Line: 40 -- upvalues: Children (val), u17 (val), u20 (val), u23 (val), Players (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(p1_2) -- Line: 44 -- upvalues: p1 (val)
        return (1 - p1_2(p1.percentage)) * 360
    end)
    local u11 = scope:Spring(v1, 25, 1)
    local v2 = scope:Computed(function(p1_2) -- Line: 52 -- upvalues: p1 (val)
        local v1 = p1_2(p1.placement)
        local v2 = p1_2(p1.isMobile)
        local v3 = p1_2(p1.customPosition)
        local v4 = p1_2(p1.dynamicStaminaEnabled)
        if v2 and v3 then
            return UDim2.fromScale(0.15, 0.15)
        end
        if v2 and not v4 then
            return UDim2.fromScale(0.15, 0.15)
        end
        if v1 == "center" then
            return UDim2.fromScale(0.1, 0.1)
        end
        return UDim2.fromScale(0.15, 0.15)
    end)
    local v3 = scope:Spring(v2, 10, 1)
    local v4 = scope:Computed(function(p1_2) -- Line: 77 -- upvalues: p1 (val)
        local v1 = p1_2(p1.placement)
        local v2 = p1_2(p1.isMobile)
        local v3 = p1_2(p1.customPosition)
        local v4 = p1_2(p1.dynamicStaminaEnabled)
        if v2 and v3 then
            return Vector2.new(0.5, 0.5)
        end
        if v2 and not v4 then
            return Vector2.new(1, 0)
        end
        if v1 == "center" then
            return Vector2.new(0, 0)
        end
        if v2 then
            return Vector2.new(1, 0)
        end
        return Vector2.new(1, 1)
    end)
    local v5 = scope:Spring(v4, 8, 1)
    local v6 = scope:Computed(function(p1_2) -- Line: 103 -- upvalues: p1 (val)
        local v1, v2
        local v3 = p1_2(p1.placement)
        local v4 = p1_2(p1.isMobile)
        local v5 = p1_2(p1.customPosition)
        local v6 = p1_2(p1.dynamicStaminaEnabled)
        if v4 and v5 then
            if not v6 then
                return v5
            end
            if v3 == "center" then
                return UDim2.new(0.5, 0, 0.5, 0)
            end
            return v5
        end
        if v4 and not v6 then
            v1 = p1_2(p1.objectiveListSizeY)
            v2 = p1_2(p1.ammoHudWidth)
            return UDim2.new(0.99, -v2, -0.02, 90 + v1)
        end
        if v3 == "center" then
            return UDim2.new(0.5, 0, 0.5, 0)
        end
        if not v4 then
            return UDim2.new(1, 0, 0.86, 0)
        end
        v1 = p1_2(p1.objectiveListSizeY)
        v2 = p1_2(p1.ammoHudWidth)
        return UDim2.new(0.99, -v2, -0.02, 90 + v1)
    end)
    local v7 = scope:Spring(v6, 8, 1)
    local v8 = scope:Computed(function(p1_2) -- Line: 147 -- upvalues: p1 (val)
        local v1 = (p1_2(p1.decreaseStartTheta)) < 180
        return v1
    end)
    local v9 = scope:Computed(function(p1) -- Line: 151 -- upvalues: u11 (val)
        local v1 = 180 <= (p1(u11))
        return v1
    end)
    local v10 = scope:Computed(function(p1_2) -- Line: 155 -- upvalues: p1 (val)
        local v1 = p1
        local decreaseStartTheta = v1.decreaseStartTheta
        local v2 = p1_2(decreaseStartTheta)
        return (math.min(v2, 270))
    end)
    local v11 = scope:Computed(function(p1_2) -- Line: 160 -- upvalues: p1 (val)
        local v1 = p1
        local decreaseStartTheta = v1.decreaseStartTheta
        local v2 = p1_2(decreaseStartTheta)
        return (math.max(v2, 179))
    end)
    local v12 = scope:Computed(function(p1_2) -- Line: 165 -- upvalues: p1 (val), u11 (val)
        local v1 = p1_2(p1.decreaseStartTheta)
        local v2 = p1_2(u11)
        local v3 = v2 - v1
        local v4 = 180 - v1
        local v5 = math.min(v3, v4)
        if not (180 < v2) or not (170 < v1) then
            v3 = 0
        else
            v3 = 90
        end
        return (math.max(v5, v3))
    end)
    local v13 = scope:Computed(function(p1_2) -- Line: 173 -- upvalues: p1 (val), u11 (val)
        local v1
        local v2 = p1_2(p1.decreaseStartTheta)
        local v3 = p1_2(u11) - math.max(v2, 179)
        if not (340 <= v2) then
            v1 = 0
        else
            v1 = 45
        end
        return (math.max(v3, v1))
    end)
    local v14 = scope:Computed(function(p1_2) -- Line: 182 -- upvalues: p1 (val)
        return p1_2(p1.requiredFlashActive)
    end)
    local u73 = scope:Computed(function(p1_2) -- Line: 187 -- upvalues: p1 (val)
        return (1 - p1_2(p1.requiredAmount) / 100) * 360
    end)
    local v15 = scope:Computed(function(p1) -- Line: 192 -- upvalues: u73 (val)
        local v1 = (p1(u73)) < 180
        return v1
    end)
    local v16 = scope:Computed(function(p1) -- Line: 196
        return true
    end)
    local v17 = scope:Computed(function(p1) -- Line: 200 -- upvalues: u73 (val)
        local v1 = u73
        local v2 = p1(v1)
        return (math.min(v2, 270))
    end)
    local v18 = scope:Computed(function(p1) -- Line: 205 -- upvalues: u73 (val)
        local v1 = u73
        local v2 = p1(v1)
        return (math.max(v2, 179))
    end)
    local v19 = scope:Computed(function(p1) -- Line: 210 -- upvalues: u73 (val)
        local v1 = p1(u73)
        local v2 = 360 - v1
        local v3 = 180 - v1
        local v4 = math.min(v2, v3)
        if not (170 < v1) then
            v2 = 0
        else
            v2 = 90
        end
        return (math.max(v4, v2))
    end)
    local v20 = scope:Computed(function(p1) -- Line: 218 -- upvalues: u73 (val)
        local v1
        local v2 = p1(u73)
        local v3 = 360 - math.max(v2, 179)
        if not (340 <= v2) then
            v1 = 0
        else
            v1 = 45
        end
        return (math.max(v3, v1))
    end)
    local decreaseLeftTransparency = p1.decreaseLeftTransparency
    local u103 = scope:Spring(decreaseLeftTransparency, 12, 1)
    local decreaseRightTransparency = p1.decreaseRightTransparency
    local u109 = scope:Spring(decreaseRightTransparency, 12, 1)
    local v21 = scope:Computed(function(p1_2) -- Line: 232 -- upvalues: p1 (val), u103 (val), u109 (val)
        local v1 = p1_2(p1.isDecreasing)
        local v2 = p1_2(u103)
        local v3 = p1_2(u109)
        local v4 = v1
        if not v4 then
            v4 = true
            if not (v2 < 0.99) then
                v4 = v3 < 0.99
            end
        end
        return v4
    end)
    local requiredLeftTransparency = p1.requiredLeftTransparency
    local v22 = scope:Spring(requiredLeftTransparency, 8, 1)
    local requiredRightTransparency = p1.requiredRightTransparency
    local v23 = scope:Spring(requiredRightTransparency, 8, 1)
    local v24 = scope:New("ImageLabel")({
        Name = "BlueGlowImage",
        BackgroundTransparency = 1,
        Image = "rbxassetid://12799025064",
        ImageTransparency = 1,
        ZIndex = 2,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
    })
    local v25 = scope:New("Frame")
    local v26 = {
        Name = "MainFrame",
        AnchorPoint = v5,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = v7,
        Size = v3,
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    local v27 = Children
    local v28 = {}
    local v29 = scope:New("UIScale")({Name = "UIScale", Scale = p1.uiScale})
    local v30 = scope:New("ImageLabel")({
        Name = "MarkerImage",
        BackgroundTransparency = 1,
        Image = "rbxassetid://12799024330",
        ImageTransparency = 0.5,
        ZIndex = 3,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ImageColor3 = Color3.fromRGB(9, 39, 65),
        Size = UDim2.fromScale(1, 1),
    })
    local v31 = scope:New("ImageLabel")({
        Name = "WheelBackImage",
        BackgroundTransparency = 1,
        Image = "rbxassetid://13676717187",
        ImageTransparency = 0.7,
        ZIndex = 0,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ImageColor3 = Color3.fromRGB(9, 39, 65),
        Position = UDim2.fromOffset(1, 0),
        Size = UDim2.new(1, -1, 1, 0),
    })
    local v32 = u17
    v32 = v32({isLeft = true, scope = scope, rotation = u11})
    local v33 = u17
    v33 = v33({isLeft = false, scope = scope, rotation = u11})
    local v34 = scope:New("Frame")
    local v35 = {
        Name = "DecreaseFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
        Visible = v21,
    }
    local v36 = Children
    local v37 = {}
    local v38 = u20
    v38 = v38({
        isLeft = true,
        scope = scope,
        visible = v9,
        groupTransparency = u103,
        rotation = v11,
        gradientRotation = v13,
    })
    local v39 = u20
    v37[1] = v38
    v37[2] = v39({
        isLeft = false,
        scope = scope,
        visible = v8,
        groupTransparency = u109,
        rotation = v10,
        gradientRotation = v12,
    })
    v35[v36] = v37
    v34 = v34(v35)
    v35 = scope:New("Frame")
    v36 = {
        Name = "RequiredFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
        Visible = v14,
        ZIndex = 3,
    }
    v37 = Children
    v38 = {}
    v39 = u20
    v39 = v39({
        isLeft = true,
        scope = scope,
        visible = v16,
        groupTransparency = v22,
        groupColor3 = Color3.fromRGB(255, 106, 106),
        rotation = v18,
        gradientRotation = v20,
    })
    local v40 = u20
    local v41 = {
        isLeft = false,
        scope = scope,
        visible = v15,
        groupTransparency = v23,
        groupColor3 = Color3.fromRGB(255, 106, 106),
        rotation = v17,
        gradientRotation = v19,
    }
    v38[1] = v39
    v38[2] = v40(v41)
    v36[v37] = v38
    v35 = v35(v36)
    v36 = scope:New("TextLabel")
    v37 = {
        Name = "StaminaLabel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.4, 0.23),
        Text = p1.staminaText,
        TextColor3 = Color3.fromRGB(101, 206, 255),
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
    }
    v38 = Children
    v37[v38] = {scope:New("UIStroke")({Name = "UIStroke", Thickness = 3, Transparency = 0.8})}
    v36 = v36(v37)
    v37 = u23
    v38 = {scope = scope, showReady = p1.showChargeReady}
    v28[1] = v29
    v28[2] = v30
    v28[3] = v31
    v28[4] = v32
    v28[5] = v33
    v28[6] = v24
    v28[7] = v34
    v28[8] = v35
    v28[9] = v36
    v28[10] = v37(v38)
    v26[v27] = v28
    v25 = v25(v26)
    v26 = scope:New("ScreenGui")
    v27 = {
        Name = "StaminaUI",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    v28 = Children
    v27[v28] = {v25}
    v26 = v26(v27)
    return {screenGui = v26, blueGlowImage = v24, mainFrame = v25}
end