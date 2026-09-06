local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Children = require(ReplicatedStorage.Packages.Fusion).Children
local u17 = require("../../../SharedComponents/WheelFrame")
local u20 = require("../../../SharedComponents/CanvasFrame")
local u23 = require("./ChargeAttackIndicator")
return function(p1) -- Line: 40 -- upvalues: Children (val), u17 (val), u20 (val), u23 (val), Players (val)
    local scope = p1.scope
    local u11 = scope:Spring(scope:Computed(function(a1) -- Line: 44 -- upvalues: p1 (val)
        return (1 - a1(p1.percentage)) * 360
    end), 25, 1)
    local v1 = scope:Spring(scope:Computed(function(a1) -- Line: 52 -- upvalues: p1 (val)
        local v1 = a1(p1.placement)
        local v2 = a1(p1.isMobile)
        local v3 = a1(p1.customPosition)
        local v4 = a1(p1.dynamicStaminaEnabled)
        if not v2 then
            if not v2 then
                if v1 == "center" then
                    return UDim2.fromScale(0.1, 0.1)
                end
                return UDim2.fromScale(0.15, 0.15)
            end
            if not v4 then
                return UDim2.fromScale(0.15, 0.15)
            end
            if v1 == "center" then
                return UDim2.fromScale(0.1, 0.1)
            end
            return UDim2.fromScale(0.15, 0.15)
        elseif v3 then
            return UDim2.fromScale(0.15, 0.15)
        end
    end), 10, 1)
    local v2 = scope:Spring(scope:Computed(function(a1) -- Line: 77 -- upvalues: p1 (val)
        local v1 = a1(p1.placement)
        local v2 = a1(p1.isMobile)
        local v3 = a1(p1.customPosition)
        local v4 = a1(p1.dynamicStaminaEnabled)
        if not v2 then
            if not v2 then
                if v1 == "center" then
                    return Vector2.new(0, 0)
                end
                if v2 then
                    return Vector2.new(1, 0)
                end
                return Vector2.new(1, 1)
            end
            if not v4 then
                return Vector2.new(1, 0)
            end
            if v1 == "center" then
                return Vector2.new(0, 0)
            end
            if v2 then
                return Vector2.new(1, 0)
            end
            return Vector2.new(1, 1)
        elseif v3 then
            return Vector2.new(0.5, 0.5)
        end
    end), 8, 1)
    local v3 = scope:Spring(scope:Computed(function(a1) -- Line: 103 -- upvalues: p1 (val)
        local v1 = a1(p1.placement)
        local v2 = a1(p1.isMobile)
        local v3 = a1(p1.customPosition)
        local v4 = a1(p1.dynamicStaminaEnabled)
        if not v2 then
            local v5, v6
            if not v2 then
                if v1 == "center" then
                    return UDim2.new(0.5, 0, 0.5, 0)
                end
                if v2 then
                    v5 = a1(p1.objectiveListSizeY)
                    v6 = a1(p1.ammoHudWidth)
                    return UDim2.new(0.99, -v6, -0.02, 90 + v5)
                end
                return UDim2.new(1, 0, 0.86, 0)
            end
            if not v4 then
                v5 = a1(p1.objectiveListSizeY)
                v6 = a1(p1.ammoHudWidth)
                return UDim2.new(0.99, -v6, -0.02, 90 + v5)
            end
            if v1 == "center" then
                return UDim2.new(0.5, 0, 0.5, 0)
            end
            if not v2 then
                return UDim2.new(1, 0, 0.86, 0)
            end
            v5 = a1(p1.objectiveListSizeY)
            v6 = a1(p1.ammoHudWidth)
            return UDim2.new(0.99, -v6, -0.02, 90 + v5)
        elseif v3 then
            if not v4 then
                return v3
            end
            if v1 == "center" then
                return UDim2.new(0.5, 0, 0.5, 0)
            end
            return v3
        end
    end), 8, 1)
    local v4 = scope:Computed(function(a1) -- Line: 147 -- upvalues: p1 (val)
        local v1 = a1(p1.decreaseStartTheta)
        local v2 = v1 < 180
        return v2
    end)
    local v5 = scope:Computed(function(p1) -- Line: 151 -- upvalues: u11 (val)
        local v1 = p1(u11)
        local v2 = 180 <= v1
        return v2
    end)
    local v6 = scope:Computed(function(a1) -- Line: 155 -- upvalues: p1 (val)
        return (math.min(a1(p1.decreaseStartTheta), 270))
    end)
    local v7 = scope:Computed(function(a1) -- Line: 160 -- upvalues: p1 (val)
        return (math.max(a1(p1.decreaseStartTheta), 179))
    end)
    local v8 = scope:Computed(function(a1) -- Line: 165 -- upvalues: p1 (val), u11 (val)
        local v1
        local v2 = a1(p1.decreaseStartTheta)
        local v3 = a1(u11)
        local v4 = math.min(v3 - v2, 180 - v2)
        if 180 >= v3 then
            v1 = 0
        elseif 170 >= v2 then
            v1 = 0
        else
            v1 = 90
        end
        return (math.max(v4, v1))
    end)
    local v9 = scope:Computed(function(a1) -- Line: 173 -- upvalues: p1 (val), u11 (val)
        local v1
        local v2 = a1(p1.decreaseStartTheta)
        if 340 > v2 then
            v1 = 0
        else
            v1 = 45
        end
        return (math.max(a1(u11) - math.max(v2, 179), v1))
    end)
    local v10 = scope:Computed(function(a1) -- Line: 182 -- upvalues: p1 (val)
        return a1(p1.requiredFlashActive)
    end)
    local u73 = scope:Computed(function(a1) -- Line: 187 -- upvalues: p1 (val)
        return (1 - a1(p1.requiredAmount) / 100) * 360
    end)
    local v11 = scope:Computed(function(p1) -- Line: 192 -- upvalues: u73 (val)
        local v1 = p1(u73)
        local v2 = v1 < 180
        return v2
    end)
    local v12 = scope:Computed(function(p1) -- Line: 196
        return true
    end)
    local v13 = scope:Computed(function(p1) -- Line: 200 -- upvalues: u73 (val)
        return (math.min(p1(u73), 270))
    end)
    local v14 = scope:Computed(function(p1) -- Line: 205 -- upvalues: u73 (val)
        return (math.max(p1(u73), 179))
    end)
    local v15 = scope:Computed(function(p1) -- Line: 210 -- upvalues: u73 (val)
        local v1
        local v2 = p1(u73)
        local v3 = math.min(360 - v2, 180 - v2)
        if 170 >= v2 then
            v1 = 0
        else
            v1 = 90
        end
        return (math.max(v3, v1))
    end)
    local v16 = scope:Computed(function(p1) -- Line: 218 -- upvalues: u73 (val)
        local v1
        local v2 = p1(u73)
        if 340 > v2 then
            v1 = 0
        else
            v1 = 45
        end
        return (math.max(360 - math.max(v2, 179), v1))
    end)
    local u103 = scope:Spring(p1.decreaseLeftTransparency, 12, 1)
    local u109 = scope:Spring(p1.decreaseRightTransparency, 12, 1)
    local v17 = scope:Computed(function(a1) -- Line: 232 -- upvalues: p1 (val), u103 (val), u109 (val)
        local v1 = a1(p1.isDecreasing)
        local v2 = a1(u103)
        local v3 = a1(u109)
        local v4 = v1
        if not v4 then
            v4 = if v2 >= 0.99 then v3 < 0.99 else true
        end
        return v4
    end)
    local v18 = scope:Spring(p1.requiredLeftTransparency, 8, 1)
    local v19 = scope:Spring(p1.requiredRightTransparency, 8, 1)
    local v20 = scope:New("ImageLabel")
    v20 = v20({
        Name = "BlueGlowImage",
        BackgroundTransparency = 1,
        Image = "rbxassetid://12799025064",
        ImageTransparency = 1,
        ZIndex = 2,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
    })
    local v21 = scope:New("Frame")
    local v22 = {
        Name = "MainFrame",
        AnchorPoint = v2,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = v3,
        Size = v1,
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    local v23 = {}
    local v24 = scope:New("UIScale")
    v24 = v24({Name = "UIScale", Scale = p1.uiScale})
    local v25 = scope:New("ImageLabel")
    v25 = v25({
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
    local v26 = scope:New("ImageLabel")
    v26 = v26({
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
    local v27 = u17({isLeft = true, scope = scope, rotation = u11})
    local v28 = u17({isLeft = false, scope = scope, rotation = u11})
    local v29 = scope:New("Frame")
    local v30 = {
        Name = "DecreaseFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
        Visible = v17,
    }
    local v31 = {}
    local v32 = u20({
        isLeft = true,
        scope = scope,
        visible = v5,
        groupTransparency = u103,
        rotation = v7,
        gradientRotation = v9,
    })
    v31[1] = v32
    v31[2] = u20({
        isLeft = false,
        scope = scope,
        visible = v4,
        groupTransparency = u109,
        rotation = v6,
        gradientRotation = v8,
    })
    v30[Children] = v31
    v29 = v29(v30)
    v30 = scope:New("Frame")
    local v33 = {
        Name = "RequiredFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
        Visible = v10,
        ZIndex = 3,
    }
    v32 = {}
    local v34 = u20({
        isLeft = true,
        scope = scope,
        visible = v12,
        groupTransparency = v18,
        groupColor3 = Color3.fromRGB(255, 106, 106),
        rotation = v14,
        gradientRotation = v16,
    })
    local v35 = {
        isLeft = false,
        scope = scope,
        visible = v11,
        groupTransparency = v19,
        groupColor3 = Color3.fromRGB(255, 106, 106),
        rotation = v13,
        gradientRotation = v15,
    }
    v32[1] = v34
    v32[2] = u20(v35)
    v33[Children] = v32
    v30 = v30(v33)
    v33 = scope:New("TextLabel")
    v31 = {
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
    v34 = {}
    local v36 = scope:New("UIStroke")
    v34[1] = v36({Name = "UIStroke", Thickness = 3, Transparency = 0.8})
    v31[Children] = v34
    v33 = v33(v31)
    v32 = {scope = scope, showReady = p1.showChargeReady}
    v23[1] = v24
    v23[2] = v25
    v23[3] = v26
    v23[4] = v27
    v23[5] = v28
    v23[6] = v20
    v23[7] = v29
    v23[8] = v30
    v23[9] = v33
    v23[10] = u23(v32)
    v22[Children] = v23
    v21 = v21(v22)
    v22 = scope:New("ScreenGui")
    local v37 = {
        Name = "StaminaUI",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    v37[Children] = {v21}
    v22 = v22(v37)
    return {screenGui = v22, blueGlowImage = v20, mainFrame = v21}
end