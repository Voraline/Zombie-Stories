local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local u17 = {}
u17[0] = Theme.Colors.Rarity.Stock
u17[1] = Theme.Colors.Rarity.Typical
u17[2] = Theme.Colors.Rarity.Unique
u17[3] = Theme.Colors.Rarity.Rare
u17[4] = Theme.Colors.Rarity.Mythical
local u34 = {}
u34[0] = (Color3.fromRGB(76, 76, 76))
u34[1] = (Color3.fromRGB(41, 86, 44))
u34[2] = (Color3.fromRGB(23, 59, 102))
u34[3] = (Color3.fromRGB(102, 61, 20))
u34[4] = (Color3.fromRGB(58, 19, 102))
local Text = Theme.Menu.Text
local Border = Theme.Menu.Border

local function maxTextSize(p1, p2, p3) -- Line: 62
    local v1 = p1 * p2 / p3 * 0.97
    return (math.floor(v1))
end

return function(p1) -- Line: 84
    -- upvalues: u17 (val), u34 (val), Text (val), Border (val), Fusion (val), Theme (val), Children (val)
    -- upvalues: OnEvent (val)
    local scope = p1.scope
    local v1 = p1.Adornee.Size.Z * 50
    local v2 = v1 * 0.22 / 2 * 0.97
    local v3 = math.floor(v2)
    local v4 = v3 * 0.75
    v2 = math.floor(v4)
    local v5 = v1 * 0.34 / 4 * 0.97
    v4 = math.floor(v5)
    v5 = scope:Computed(function(p1_2) -- Line: 96 -- upvalues: p1 (val)
        local v1 = p1_2(p1.CurrentRank)
        local v2 = p1_2(p1.MaxRank)
        return (("%*/%*"):format(v1, v2))
    end)
    local u26 = scope:Computed(function(p1_2) -- Line: 103 -- upvalues: p1 (val)
        local ShowDescription = p1.ShowDescription
        if ShowDescription == nil then
            return false
        end
        return p1_2(ShowDescription)
    end)
    local v6 = scope:Computed(function(p1) -- Line: 111 -- upvalues: u26 (val)
        return not p1(u26)
    end)
    local v7 = scope:Computed(function(p1_2) -- Line: 116 -- upvalues: p1 (val)
        local IsPurchasable = p1.IsPurchasable
        if IsPurchasable == nil then
            return false
        end
        return not p1_2(IsPurchasable)
    end)
    local u38 = scope:Computed(function(p1_2) -- Line: 125 -- upvalues: p1 (val)
        local v1 = 1 <= (p1_2(p1.CurrentRank))
        return v1
    end)
    local u42 = scope:Computed(function(p1_2) -- Line: 130 -- upvalues: p1 (val)
        local IsSelected = p1.IsSelected
        if IsSelected == nil then
            return false
        end
        return p1_2(IsSelected)
    end)
    local u46 = scope:Computed(function(p1_2) -- Line: 139 -- upvalues: p1 (val)
        local IsHovered = p1.IsHovered
        if IsHovered == nil then
            return false
        end
        return p1_2(IsHovered)
    end)
    local v8 = scope:Computed(function(p1_2) -- Line: 148 -- upvalues: p1 (val), u38 (val), u17 (upval), u34 (upval)
        local v1, v2
        if not p1.Tier then
            v1 = 0
        else
            v1 = p1_2(p1.Tier)
            if not v1 then
                v1 = 0
            end
        end
        if p1_2(u38) then
            v2 = u17[v1]
            if not v2 then
                v2 = u17[0]
            end
            return v2
        end
        v2 = u34[v1]
        if not v2 then
            v2 = u34[0]
        end
        return v2
    end)
    local v9 = scope:Computed(function(p1_2) -- Line: 158 -- upvalues: u42 (val), Text (upval), u38 (val), p1 (val), u17 (upval), Border (upval)
        local v1
        if p1_2(u42) then
            return Text
        end
        if not p1_2(u38) then
            return Border
        end
        if not p1.Tier then
            v1 = 0
        else
            v1 = p1_2(p1.Tier)
            if not v1 then
                v1 = 0
            end
        end
        local v2 = u17[v1]
        if not v2 then
            v2 = Border
        end
        return v2
    end)
    local v10 = scope:Computed(function(p1) -- Line: 170 -- upvalues: u42 (val), u46 (val), u38 (val)
        if not p1(u42) and not p1(u46) then
            if p1(u38) then
                return 50
            end
            return 0
        end
        return 100
    end)
    local v11 = scope:Spring(v10, 25, 0.8)
    local u68 = scope:Value(1)
    local u72 = Fusion.peek(p1.CurrentRank)
    local CurrentRank = p1.CurrentRank
    ;(scope:Observer(CurrentRank)):onBind(function() -- Line: 188 -- upvalues: Fusion (upval), p1 (val), u72 (ref), u68 (val)
        local v1 = Fusion.peek(p1.CurrentRank)
        if u72 < v1 then
            task.spawn(function() -- Line: 194 -- upvalues: u68 (upval)
                local v1, v2, v3
                local v4 = 0
                while v4 < 0.5 do
                    v4 = v4 + task.wait()
                    v1 = v4 / 0.5
                    v2 = (math.min(v1, 1)) * 3.141592653589793 / 2
                    v1 = math.cos(v2)
                    v2 = u68
                    v3 = v1 * 1 + 1
                    v2:set(v3)
                end
                u68:set(1)
            end)
        end
        u72 = v1
    end)

    local function createUIGradient() -- Line: 212 -- upvalues: scope (val), Theme (upval)
        return scope:New("UIGradient")({Name = "UIGradient", Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    end

    local u87 = scope:New("Sound")({Name = "RBLX UI Swipe (SFX)", SoundId = "rbxassetid://10128766965"})
    local u93 = scope:New("Sound")({Name = "RBLX UI Back (SFX)", SoundId = "rbxassetid://10066914500"})
    local u94 = false
    ;(scope:Observer(u26)):onBind(function() -- Line: 235 -- upvalues: Fusion (upval), u26 (val), u94 (ref), u87 (val), u93 (val)
        local v1 = Fusion.peek(u26)
        if not u94 then
            u94 = true
            return
        end
        if v1 then
            u87:Play()
            return
        end
        u93:Play()
    end)
    local v12 = scope:New("SurfaceGui")
    local v13 = {
        Name = "SkillGui",
        Face = Enum.NormalId.Top,
        ClipsDescendants = false,
        LightInfluence = 0,
        Brightness = u68,
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
        PixelsPerStud = 50,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Adornee = p1.Adornee,
        ResetOnSpawn = false,
    }
    local v14 = Children
    local v15 = {}
    local v16 = scope:New("TextButton")
    local v17 = {
        Name = "ClickDetector",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        ZIndex = 10,
    }
    local Activated = OnEvent("Activated")

    v17[Activated] = function() -- Line: 275 -- upvalues: p1 (val)
        if p1.OnClick then
            p1.OnClick()
        end
    end

    local MouseEnter = OnEvent("MouseEnter")

    v17[MouseEnter] = function() -- Line: 281 -- upvalues: p1 (val)
        if p1.OnHoverEnter then
            p1.OnHoverEnter()
        end
    end

    local MouseLeave = OnEvent("MouseLeave")

    v17[MouseLeave] = function() -- Line: 287 -- upvalues: p1 (val)
        if p1.OnHoverLeave then
            p1.OnHoverLeave()
        end
    end

    v16 = v16(v17)
    v17 = scope:New("Frame")
    local v18 = {
        Name = "Frame",
        BackgroundColor3 = v8,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Visible = v6,
    }
    local v19 = Children
    local v20 = {}
    local v21 = scope:New("UICorner")({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
    local v22 = scope:New("UIGradient")({Name = "UIGradient", Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    local v23 = scope:New("ImageLabel")({
        Name = "ImageLabel",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.31),
        Size = UDim2.fromScale(0.52, 0.52),
        ScaleType = Enum.ScaleType.Fit,
        Image = p1.Icon or "rbxassetid://3187426822",
    })
    local v24 = scope:New("TextLabel")
    local v25 = {
        Name = "SkillName",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.69),
        Size = UDim2.fromScale(0.9, 0.22),
        Font = Theme.Menu.Fonts.Header,
        Text = p1.SkillName,
        TextColor3 = Theme.Menu.Text,
        TextSize = v3,
        TextScaled = true,
        TextWrapped = true,
        RichText = true,
        ZIndex = 2,
    }
    local v26 = Children
    v25[v26] = {scope:New("UITextSizeConstraint")({MaxTextSize = v3})}
    v24 = v24(v25)
    v25 = scope:New("TextLabel")
    v26 = {
        Name = "UpgradeLevel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.9),
        Size = UDim2.fromScale(0.78, 0.12),
        Font = Theme.Menu.Fonts.Header,
        Text = v5,
        TextColor3 = Theme.Menu.Text,
        TextSize = v2,
        TextScaled = true,
        TextWrapped = true,
        RichText = true,
        ZIndex = 2,
    }
    local v27 = Children
    v26[v27] = {scope:New("UITextSizeConstraint")({MaxTextSize = v2})}
    v25 = v25(v26)
    v26 = scope:New("Frame")
    v27 = {
        Name = "Locked",
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 1,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.fromScale(1, 1),
        Visible = v7,
    }
    v20[1] = v21
    v20[2] = v22
    v20[3] = u93
    v20[4] = v23
    v20[5] = v24
    v20[6] = v25
    v20[7] = v26(v27)
    v18[v19] = v20
    v17 = v17(v18)
    v18 = scope:New("Frame")
    v19 = {
        Name = "DescFrame",
        BackgroundColor3 = v8,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Visible = u26,
    }
    v20 = Children
    v21 = {}
    v22 = scope:New("UICorner")({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
    local v28 = scope:New("UIGradient")({Name = "UIGradient", Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    v24 = scope:New("ImageLabel")({
        Name = "ImageLabel",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ImageTransparency = 0.1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = p1.Icon or "rbxassetid://3187426822",
        ImageColor3 = Theme.Menu.Text,
        Position = UDim2.fromScale(0.5, 0.13),
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromScale(0.2, 0.2),
    })
    v25 = scope:New("TextLabel")
    v26 = {
        Name = "SkillName",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Header,
        Position = UDim2.fromScale(0.5, 0.36),
        RichText = true,
        Size = UDim2.fromScale(0.88, 0.22),
        Text = p1.SkillName,
        TextColor3 = Theme.Menu.Text,
        TextSize = v3,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
    }
    v27 = Children
    v26[v27] = {scope:New("UITextSizeConstraint")({MaxTextSize = v3})}
    v25 = v25(v26)
    v26 = scope:New("TextLabel")
    v27 = {
        Name = "UpgradeLevel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Header,
        Position = UDim2.fromScale(0.5, 0.535),
        RichText = true,
        Size = UDim2.fromScale(0.55, 0.11),
        Text = v5,
        TextColor3 = Theme.Menu.Text,
        TextSize = v2,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
    }
    local v29 = Children
    v27[v29] = {scope:New("UITextSizeConstraint")({MaxTextSize = v2})}
    v26 = v26(v27)
    v27 = scope:New("TextLabel")
    v29 = {
        Name = "Description",
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Body,
        Position = UDim2.fromScale(0.5, 0.6),
        RichText = false,
        Size = UDim2.fromScale(1, 0.34),
        Text = p1.Description or "",
        TextColor3 = Theme.Menu.Text,
        TextSize = v4,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
    }
    local v30 = Children
    v29[v30] = {scope:New("UITextSizeConstraint")({MaxTextSize = v4})}
    v27 = v27(v29)
    v29 = scope:New("UIPadding")
    v30 = {Name = "UIPadding", PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0)}
    v21[1] = v22
    v21[2] = v28
    v21[3] = u87
    v21[4] = v24
    v21[5] = v25
    v21[6] = v26
    v21[7] = v27
    v21[8] = v29(v30)
    v19[v20] = v21
    v18 = v18(v19)
    v19 = scope:New("Frame")
    v20 = {
        Name = "Outline",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 6,
    }
    v21 = Children
    v20[v21] = {
        scope:New("UIStroke")({Name = "UIStroke", Color = v9, LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = v11}),
    }
    v15[1] = v16
    v15[2] = v17
    v15[3] = v18
    v15[4] = v19(v20)
    v13[v14] = v15
    v12 = v12(v13)
    return v12
end