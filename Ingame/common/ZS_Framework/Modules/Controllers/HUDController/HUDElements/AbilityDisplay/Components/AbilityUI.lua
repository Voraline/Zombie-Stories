local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
game:GetService("TweenService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local u22 = require("../../../SharedComponents/WheelFrame")
require("../../../SharedComponents/CanvasFrame")
return function(p1) -- Line: 42 -- upvalues: Children (val), u22 (val), Fusion (val), Players (val)
    local scope = p1.scope
    local u5 = scope:Computed(function(p1_2) -- Line: 47 -- upvalues: p1 (val)
        if p1_2(p1.isActive) then
            return p1_2(p1.durationRemaining)
        end
        return p1_2(p1.percentage)
    end)
    local v1 = scope:Computed(function(p1) -- Line: 57 -- upvalues: u5 (val)
        return (1 - p1(u5)) * 360
    end)
    local v2 = scope:Spring(v1, 25, 1)
    local v3 = scope:Computed(function(p1_2) -- Line: 66 -- upvalues: p1 (val)
        if p1_2(p1.isActive) then
            return Color3.fromRGB(180, 150, 255)
        end
        return Color3.fromRGB(101, 206, 255)
    end)
    local v4 = scope:Spring(v3, 15, 1)
    local v5 = scope:Computed(function(p1_2) -- Line: 87 -- upvalues: p1 (val)
        local v1
        local v2 = p1_2(p1.staminaPlacement)
        local v3 = p1_2(p1.staminaFrameSize)
        local v4 = p1_2(p1.isMobile)
        local v5 = p1_2(p1.customPosition)
        if v4 and v5 then
            return v5
        end
        if v2 == "center" then
            if not v4 then
                return UDim2.new(1, 0, 0.86, 0)
            end
            local v6 = p1_2(p1.objectiveListSizeY)
            v1 = p1_2(p1.ammoHudWidth)
            return UDim2.new(0.99, -v1, -0.02, 90 + v6)
        end
        v1 = -(v3.X * 0.7 + 10)
        if not v4 then
            return UDim2.new(1, v1, 0.86, 0)
        end
        local v7 = p1_2(p1.objectiveListSizeY)
        local v8 = p1_2(p1.ammoHudWidth)
        return UDim2.new(0.99, -v8 + v1, -0.02, 90 + v7)
    end)
    local v6 = scope:Spring(v5, 25, 1)
    local v7 = scope:Computed(function(p1_2) -- Line: 129 -- upvalues: p1 (val)
        local v1 = p1_2(p1.staminaPlacement)
        local v2 = p1_2(p1.isMobile)
        local v3 = p1
        local customPosition = v3.customPosition
        local v4 = p1_2(customPosition)
        if v2 and v4 then
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
    end)
    local v8 = scope:Spring(v7, 25, 1)
    local v9 = scope:Computed(function(p1_2) -- Line: 157 -- upvalues: p1 (val)
        if p1_2(p1.staminaPlacement) == "center" then
            return UDim2.fromScale(0.15, 0.15)
        end
        return UDim2.fromScale(0.15, 0.15)
    end)
    local v10 = scope:Spring(v9, 10, 1)
    local v11 = scope:Computed(function(p1_2) -- Line: 172 -- upvalues: p1 (val), u5 (val)
        local v1 = p1_2(p1.isReady)
        local v2 = p1_2(p1.isActivating)
        local v3 = p1
        local isActive = v3.isActive
        local v4 = p1_2(isActive)
        if v1 and not v2 and not v4 then
            return ""
        end
        if p1.ammoCount then
            v3 = p1_2(p1.ammoCount)
            if 0 < v3 then
                return string.format("%d", v3)
            end
        end
        local format = string.format
        local v5 = u5
        local v6 = (p1_2(v5)) * 100
        return format("%d", (math.ceil(v6)))
    end)
    local u63 = scope:Computed(function(p1_2) -- Line: 194 -- upvalues: p1 (val)
        local v1 = p1_2(p1.isReady)
        if v1 then
            v1 = not p1_2(p1.isActivating) and not p1_2(p1.isActive)
        end
        return v1
    end)
    local v12 = scope:Computed(function(p1) -- Line: 199 -- upvalues: u63 (val)
        if p1(u63) then
            return 0
        end
        return 1
    end)
    local v13 = scope:Spring(v12, 15, 1)
    local readyLabelText = p1.readyLabelText
    local v14 = scope:Computed(function(p1_2) -- Line: 209 -- upvalues: p1 (val)
        return (1 - p1_2(p1.activationProgress)) * 360
    end)
    local u84 = scope:Spring(v14, 30, 1)
    local v15 = scope:Computed(function(p1_2) -- Line: 215 -- upvalues: p1 (val)
        if p1_2(p1.isActivating) then
            return 0
        end
        return 1
    end)
    local v16 = scope:Spring(v15, 20, 1)
    local v17 = Color3.fromRGB(255, 200, 100)
    local v18 = scope:New("ImageLabel")({
        Name = "BlueGlowImage",
        BackgroundTransparency = 1,
        Image = "rbxassetid://12799025064",
        ImageTransparency = 1,
        ZIndex = 2,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Size = UDim2.fromScale(1, 1),
    })
    local v19 = scope:New("Frame")
    local v20 = {
        Name = "MainFrame",
        AnchorPoint = v8,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Position = v6,
        Size = v10,
        SizeConstraint = Enum.SizeConstraint.RelativeYY,
    }
    local v21 = Children
    local v22 = {}
    local v23 = scope:New("UIScale")({Name = "UIScale", Scale = p1.uiScale})
    local v24 = scope:New("ImageLabel")({
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
    local v25 = scope:New("ImageLabel")({
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
    local v26 = u22
    v26 = v26({isLeft = true, scope = scope, rotation = v2, wheelColor = v4})
    local v27 = u22
    v27 = v27({isLeft = false, scope = scope, rotation = v2, wheelColor = v4})
    local v28 = scope:New("Frame")
    local v29 = {
        Name = "ActivationLeftFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    local v30 = Children
    local v31 = {}
    local v32 = scope:New("ImageLabel")
    local v33 = {
        Name = "ActivationLeftWheel",
        AnchorPoint = Vector2.new(0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13676717187",
        ImageColor3 = v17,
        ImageTransparency = v16,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(2, 1),
        ZIndex = 2,
    }
    local v34 = Children
    local v35 = {}
    local v36 = scope:New("UIGradient")
    local v37 = {
        Name = "UIGradient",
        Rotation = scope:Computed(function(p1) -- Line: 328 -- upvalues: u84 (val)
            local v1 = u84
            local v2 = p1(v1)
            return (math.max(180, v2))
        end),
    }
    local new = NumberSequence.new
    local v38 = {}
    local v39 = NumberSequenceKeypoint.new(0, 1)
    local v40 = NumberSequenceKeypoint.new(0.5, 1)
    local v41 = NumberSequenceKeypoint.new(0.501, 0)
    v38[1] = v39
    v38[2] = v40
    v38[3] = v41
    v38[4] = NumberSequenceKeypoint.new(1, 0)
    v37.Transparency = new(v38)
    v35[1] = v36(v37)
    v33[v34] = v35
    v31[1] = v32(v33)
    v29[v30] = v31
    v28 = v28(v29)
    v29 = scope:New("Frame")
    v30 = {
        Name = "ActivationRightFrame",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        ClipsDescendants = true,
        Position = UDim2.fromScale(0.5, 0),
        Size = UDim2.fromScale(0.5, 1),
        ZIndex = 2,
    }
    v31 = Children
    v32 = {}
    v33 = scope:New("ImageLabel")
    v34 = {
        Name = "ActivationRightWheel",
        AnchorPoint = Vector2.new(1, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(27, 42, 53),
        Image = "rbxassetid://13676717187",
        ImageColor3 = v17,
        ImageTransparency = v16,
        Position = UDim2.fromScale(1, 0),
        Size = UDim2.fromScale(2, 1),
        ZIndex = 2,
    }
    v35 = Children
    v36 = {}
    v37 = scope:New("UIGradient")
    local v42 = {
        Name = "UIGradient",
        Rotation = scope:Computed(function(p1) -- Line: 371 -- upvalues: u84 (val)
            local v1 = u84
            local v2 = p1(v1)
            return (math.min(180, v2))
        end),
    }
    local new_2 = NumberSequence.new
    v39 = {}
    v40 = NumberSequenceKeypoint.new(0, 1)
    v41 = NumberSequenceKeypoint.new(0.5, 1)
    local v43 = NumberSequenceKeypoint.new(0.501, 0)
    v39[1] = v40
    v39[2] = v41
    v39[3] = v43
    v39[4] = NumberSequenceKeypoint.new(1, 0)
    v42.Transparency = new_2(v39)
    v36[1] = v37(v42)
    v34[v35] = v36
    v32[1] = v33(v34)
    v30[v31] = v32
    v29 = v29(v30)
    v30 = scope:New("ImageLabel")({
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
    v31 = scope:New("TextLabel")
    v32 = {
        Name = "PercentageLabel",
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
        Position = UDim2.fromScale(0.5, 0.65),
        Size = UDim2.fromScale(0.4, 0.18),
        Text = v11,
        TextColor3 = Color3.fromRGB(101, 206, 255),
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        ZIndex = 4,
    }
    v33 = Children
    v32[v33] = {scope:New("UIStroke")({Name = "UIStroke", Thickness = 2, Transparency = 0.8})}
    v31 = v31(v32)
    v32 = scope:New("TextLabel")
    v33 = {
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
        TextTransparency = v13,
        TextWrapped = true,
        ZIndex = 4,
    }
    v34 = Children
    v33[v34] = {scope:New("UIStroke")({Name = "UIStroke", Thickness = 2, Transparency = v13})}
    v32 = v32(v33)
    v33 = scope:New("TextButton")
    v34 = {
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

    v34[Activated] = function() -- Line: 470 -- upvalues: p1 (val)
        if p1.onActivatePressed then
            p1.onActivatePressed()
        end
    end

    v22[1] = v23
    v22[2] = v24
    v22[3] = v25
    v22[4] = v26
    v22[5] = v27
    v22[6] = v18
    v22[7] = v28
    v22[8] = v29
    v22[9] = v30
    v22[10] = v31
    v22[11] = v32
    v22[12] = v33(v34)
    v20[v21] = v22
    v19 = v19(v20)
    v20 = scope:New("ScreenGui")
    v21 = {
        Name = "AbilityUI",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Enabled = p1.visible,
    }
    v22 = Children
    v21[v22] = {v19}
    v20 = v20(v21)
    return {screenGui = v20, blueGlowImage = v18, mainFrame = v19}
end