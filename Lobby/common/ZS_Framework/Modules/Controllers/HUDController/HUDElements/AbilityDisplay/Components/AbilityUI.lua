local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
game:GetService("TweenService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local u22 = require("../../../SharedComponents/WheelFrame")
require("../../../SharedComponents/CanvasFrame")
return function(p1) -- Line: 42 -- upvalues: Children (val), u22 (val), Fusion (val), Players (val)
    local v1
    local scope = p1.scope
    local u5 = scope:Computed(function(a1) -- Line: 47 -- upvalues: p1 (val)
        if a1(p1.isActive) then
            return a1(p1.durationRemaining)
        end
        return a1(p1.percentage)
    end)
    local v2 = scope:Spring(scope:Computed(function(p1) -- Line: 57 -- upvalues: u5 (val)
        return (1 - p1(u5)) * 360
    end), 25, 1)
    local v3 = scope:Spring(scope:Computed(function(a1) -- Line: 66 -- upvalues: p1 (val)
        if a1(p1.isActive) then
            return Color3.fromRGB(180, 150, 255)
        end
        return Color3.fromRGB(101, 206, 255)
    end), 15, 1)
    v1 = scope:Spring(scope:Computed(function(a1) -- Line: 87 -- upvalues: p1 (val)
        local v1, v2, v3, v4
        local v5 = a1(p1.staminaPlacement)
        local v6 = a1(p1.staminaFrameSize)
        local v7 = a1(p1.isMobile)
        local v8 = a1(p1.customPosition)
        if not v7 then
            if v5 == "center" then
                if not v7 then
                    return UDim2.new(1, 0, 0.86, 0)
                end
                v1 = a1(p1.objectiveListSizeY)
                v2 = a1(p1.ammoHudWidth)
                return UDim2.new(0.99, -v2, -0.02, 90 + v1)
            end
            v2 = -(v6.X * 0.7 + 10)
            if v7 then
                v3 = a1(p1.objectiveListSizeY)
                v4 = a1(p1.ammoHudWidth)
                return UDim2.new(0.99, -v4 + v2, -0.02, 90 + v3)
            end
            return UDim2.new(1, v2, 0.86, 0)
        end
        if v8 then
            return v8
        end
        if v5 == "center" then
            if not v7 then
                return UDim2.new(1, 0, 0.86, 0)
            end
            v1 = a1(p1.objectiveListSizeY)
            v2 = a1(p1.ammoHudWidth)
            return UDim2.new(0.99, -v2, -0.02, 90 + v1)
        end
        v2 = -(v6.X * 0.7 + 10)
        if not v7 then
            return UDim2.new(1, v2, 0.86, 0)
        end
        v3 = a1(p1.objectiveListSizeY)
        v4 = a1(p1.ammoHudWidth)
        return UDim2.new(0.99, -v4 + v2, -0.02, 90 + v3)
    end), 25, 1)
    local v4 = scope:Spring(scope:Computed(function(a1) -- Line: 129 -- upvalues: p1 (val)
        local v1 = a1(p1.staminaPlacement)
        local v2 = a1(p1.isMobile)
        if not v2 then
            if v1 == "center" then
                if v2 then
                    return Vector2.new(1, 0)
                end
                return Vector2.new(1, 1)
            end
            if v2 then
                return Vector2.new(1, 0)
            end
            return Vector2.new(1, 1)
        end
        if a1(p1.customPosition) then
            return Vector2.new(0.5, 0.5)
        end
        if v1 == "center" then
            if v2 then
                return Vector2.new(1, 0)
            end
            return Vector2.new(1, 1)
        end
        if v2 then
            return Vector2.new(1, 0)
        end
        return Vector2.new(1, 1)
    end), 25, 1)
    local v5 = scope:Spring(scope:Computed(function(a1) -- Line: 157 -- upvalues: p1 (val)
        if a1(p1.staminaPlacement) == "center" then
            return UDim2.fromScale(0.15, 0.15)
        end
        return UDim2.fromScale(0.15, 0.15)
    end), 10, 1)
    local v6 = scope:Computed(function(a1) -- Line: 172 -- upvalues: p1 (val), u5 (val)
        local v1
        local v2 = a1(p1.isReady)
        local v3 = a1(p1.isActivating)
        if not v2 or v3 then
            if p1.ammoCount then
                v1 = a1(p1.ammoCount)
                if 0 < v1 then
                    return string.format("%d", v1)
                end
                return string.format("%d", (math.ceil(a1(u5) * 100)))
            end
            return string.format("%d", (math.ceil(a1(u5) * 100)))
        end
        if not (a1(p1.isActive)) then
            return ""
        end
        if not p1.ammoCount then
            return string.format("%d", (math.ceil(a1(u5) * 100)))
        end
        v1 = a1(p1.ammoCount)
        if 0 < v1 then
            return string.format("%d", v1)
        end
        return string.format("%d", (math.ceil(a1(u5) * 100)))
    end)
    local u63 = scope:Computed(function(a1) -- Line: 194 -- upvalues: p1 (val)
        local v1 = a1(p1.isReady)
        if v1 then
            v1 = not a1(p1.isActivating)
            if v1 then
                v1 = not a1(p1.isActive)
            end
        end
        return v1
    end)
    local v7 = scope:Spring(scope:Computed(function(p1) -- Line: 199 -- upvalues: u63 (val)
        if p1(u63) then
            return 0
        end
        return 1
    end), 15, 1)
    local readyLabelText = p1.readyLabelText
    local u84 = scope:Spring(scope:Computed(function(a1) -- Line: 209 -- upvalues: p1 (val)
        return (1 - a1(p1.activationProgress)) * 360
    end), 30, 1)
    local v8 = scope:Spring(scope:Computed(function(a1) -- Line: 215 -- upvalues: p1 (val)
        if a1(p1.isActivating) then
            return 0
        end
        return 1
    end), 20, 1)
    local v9 = Color3.fromRGB(255, 200, 100)
    local v10 = scope:New("ImageLabel")
    v10 = v10({
        Name = "BlueGlowImage",
        BackgroundTransparency = 1,
        Image = "rbxassetid://12799025064",
        ImageTransparency = 1,
        ZIndex = 2,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
    })
    local v11 = scope:New("Frame")
    local v12 = {
        Name = "MainFrame",
        AnchorPoint = v4,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = v1,
        Size = v5,
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    local v13 = {}
    local v14 = scope:New("UIScale")
    v14 = v14({Name = "UIScale", Scale = p1.uiScale})
    local v15 = scope:New("ImageLabel")
    v15 = v15({
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
    local v16 = scope:New("ImageLabel")
    v16 = v16({
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
    local v17 = u22({isLeft = true, scope = scope, rotation = v2, wheelColor = v3})
    local v18 = u22({isLeft = false, scope = scope, rotation = v2, wheelColor = v3})
    local v19 = scope:New("Frame")
    local v20 = {
        Name = "ActivationLeftFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    local v21 = {}
    local v22 = scope:New("ImageLabel")
    local v23 = {
        Name = "ActivationLeftWheel",
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13676717187",
        ImageColor3 = v9,
        ImageTransparency = v8,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(2, 1),
        ZIndex = 2,
    }
    local v24 = {}
    local v25 = scope:New("UIGradient")
    local v26 = {Name = "UIGradient", Rotation = scope:Computed(function(p1) -- Line: 328 -- upvalues: u84 (val)
        return (math.max(180, p1(u84)))
    end)}
    local v27 = {}
    local v28 = NumberSequenceKeypoint.new(0, 1)
    local v29 = NumberSequenceKeypoint.new(0.5, 1)
    local v30 = NumberSequenceKeypoint.new(0.501, 0)
    v27[1] = v28
    v27[2] = v29
    v27[3] = v30
    v27[4] = NumberSequenceKeypoint.new(1, 0)
    v26.Transparency = NumberSequence.new(v27)
    v24[1] = v25(v26)
    v23[Children] = v24
    v21[1] = v22(v23)
    v20[Children] = v21
    v19 = v19(v20)
    v20 = scope:New("Frame")
    local v31 = {
        Name = "ActivationRightFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    v22 = {}
    v23 = scope:New("ImageLabel")
    local v32 = {
        Name = "ActivationRightWheel",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13676717187",
        ImageColor3 = v9,
        ImageTransparency = v8,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.fromScale(2, 1),
        ZIndex = 2,
    }
    v25 = {}
    v26 = scope:New("UIGradient")
    local v33 = {Name = "UIGradient", Rotation = scope:Computed(function(p1) -- Line: 371 -- upvalues: u84 (val)
        return (math.min(180, p1(u84)))
    end)}
    v28 = {}
    v29 = NumberSequenceKeypoint.new(0, 1)
    v30 = NumberSequenceKeypoint.new(0.5, 1)
    local v34 = NumberSequenceKeypoint.new(0.501, 0)
    v28[1] = v29
    v28[2] = v30
    v28[3] = v34
    v28[4] = NumberSequenceKeypoint.new(1, 0)
    v33.Transparency = NumberSequence.new(v28)
    v25[1] = v26(v33)
    v32[Children] = v25
    v22[1] = v23(v32)
    v31[Children] = v22
    v20 = v20(v31)
    v31 = scope:New("ImageLabel")
    v31 = v31({
        Name = "AbilityIcon",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Image = p1.abilityImage,
        ImageColor3 = Color3.fromRGB(101, 206, 255),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.7, 0.7),
    })
    v21 = scope:New("TextLabel")
    v22 = {
        Name = "PercentageLabel",
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
        Position = UDim2.fromScale(0.5, 0.65),
        Size = UDim2.fromScale(0.4, 0.18),
        Text = v6,
        TextColor3 = Color3.fromRGB(101, 206, 255),
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        ZIndex = 4,
    }
    v32 = {}
    v24 = scope:New("UIStroke")
    v32[1] = v24({Name = "UIStroke", Thickness = 2, Transparency = 0.8})
    v22[Children] = v32
    v21 = v21(v22)
    v22 = scope:New("TextLabel")
    v23 = {
        Name = "ReadyLabel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold),
        Position = UDim2.fromScale(0.5, 0.78),
        Size = UDim2.fromScale(0.8, 0.15),
        Text = readyLabelText,
        TextColor3 = Color3.fromRGB(150, 255, 150),
        TextScaled = true,
        TextSize = 14,
        TextTransparency = v7,
        TextWrapped = true,
        ZIndex = 4,
    }
    v24 = {}
    v25 = scope:New("UIStroke")
    v24[1] = v25({Name = "UIStroke", Thickness = 2, Transparency = v7})
    v23[Children] = v24
    v22 = v22(v23)
    v23 = scope:New("TextButton")
    v32 = {
        Name = "TouchActivateButton",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Text = "",
        ZIndex = 10,
        Visible = p1.isMobile,
        Active = p1.isMobile,
    }
    local Activated = Fusion.OnEvent("Activated")
    v32[Activated] = function() -- Line: 470 -- upvalues: p1 (val)
        if p1.onActivatePressed then
            p1.onActivatePressed()
        end
    end
    v13[1] = v14
    v13[2] = v15
    v13[3] = v16
    v13[4] = v17
    v13[5] = v18
    v13[6] = v10
    v13[7] = v19
    v13[8] = v20
    v13[9] = v31
    v13[10] = v21
    v13[11] = v22
    v13[12] = v23(v32)
    v12[Children] = v13
    v11 = v11(v12)
    v12 = scope:New("ScreenGui")
    local v35 = {
        Name = "AbilityUI",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Enabled = p1.visible,
    }
    v35[Children] = {v11}
    v12 = v12(v35)
    return {screenGui = v12, blueGlowImage = v10, mainFrame = v11}
end