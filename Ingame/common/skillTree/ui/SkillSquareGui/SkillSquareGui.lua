local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
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
u34[0] = Color3.fromRGB(76, 76, 76)
u34[1] = Color3.fromRGB(41, 86, 44)
u34[2] = Color3.fromRGB(23, 59, 102)
u34[3] = Color3.fromRGB(102, 61, 20)
u34[4] = Color3.fromRGB(58, 19, 102)
local Text = Theme.Menu.Text
local Border = Theme.Menu.Border
return function(p1) -- Line: 65 -- upvalues: u17 (val), u34 (val), Text (val), Border (val), Fusion (val), Theme (val), Children (val), OnEvent (val)
    local v1
    local scope = p1.scope
    v1 = scope:Computed(function(a1) -- Line: 68 -- upvalues: p1 (val)
        local v1 = a1(p1.CurrentRank)
        local v2 = a1(p1.MaxRank)
        return (("%*/%*"):format(v1, v2))
    end)
    local u9 = scope:Computed(function(a1) -- Line: 75 -- upvalues: p1 (val)
        local ShowDescription = p1.ShowDescription
        if ShowDescription == nil then
            return false
        end
        return a1(ShowDescription)
    end)
    local v2 = scope:Computed(function(p1) -- Line: 83 -- upvalues: u9 (val)
        return not p1(u9)
    end)
    local v3 = scope:Computed(function(a1) -- Line: 88 -- upvalues: p1 (val)
        local IsPurchasable = p1.IsPurchasable
        if IsPurchasable == nil then
            return false
        end
        return not a1(IsPurchasable)
    end)
    local u21 = scope:Computed(function(a1) -- Line: 97 -- upvalues: p1 (val)
        local v1 = a1(p1.CurrentRank)
        local v2 = 1 <= v1
        return v2
    end)
    local u25 = scope:Computed(function(a1) -- Line: 102 -- upvalues: p1 (val)
        local IsSelected = p1.IsSelected
        if IsSelected == nil then
            return false
        end
        return a1(IsSelected)
    end)
    local u29 = scope:Computed(function(a1) -- Line: 111 -- upvalues: p1 (val)
        local IsHovered = p1.IsHovered
        if IsHovered == nil then
            return false
        end
        return a1(IsHovered)
    end)
    local v4 = scope:Computed(function(a1) -- Line: 120 -- upvalues: p1 (val), u21 (val), u17 (upval), u34 (upval)
        local v1, v2
        if not p1.Tier then
            v1 = 0
        else
            v1 = a1(p1.Tier)
            if not v1 then
                v1 = 0
            end
        end
        if a1(u21) then
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
    local v5 = scope:Computed(function(a1) -- Line: 130 -- upvalues: u25 (val), Text (upval), u21 (val), p1 (val), u17 (upval), Border (upval)
        local v1
        if a1(u25) then
            return Text
        end
        if not (a1(u21)) then
            return Border
        end
        if not p1.Tier then
            v1 = 0
        else
            v1 = a1(p1.Tier)
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
    local v6 = scope:Spring(scope:Computed(function(p1) -- Line: 142 -- upvalues: u25 (val), u29 (val), u21 (val)
        if p1(u25) or p1(u29) then
            return 100
        end
        if p1(u21) then
            return 50
        end
        return 0
    end), 25, 0.8)
    local u51 = scope:Value(1)
    local u55 = Fusion.peek(p1.CurrentRank)
    local v7 = scope:Observer(p1.CurrentRank)
    v7:onBind(function() -- Line: 160 -- upvalues: Fusion (upval), p1 (val), u55 (ref), u51 (val)
        local v1 = Fusion.peek(p1.CurrentRank)
        if u55 < v1 then
            task.spawn(function() -- Line: 166 -- upvalues: u51 (upval)
                local v1
                local v2 = 0
                while v2 < 0.5 do
                    v2 = v2 + task.wait()
                    v1 = math.cos(math.min(v2 / 0.5, 1) * 3.141592653589793 / 2)
                    u51:set(v1 * 1 + 1)
                end
                u51:set(1)
            end)
        end
        u55 = v1
    end)
    local function createUIGradient() -- Line: 184 -- upvalues: scope (val), Theme (upval)
        local v1 = scope:New("UIGradient")
        return v1({Name = "UIGradient", Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    end
    local v8 = scope:New("Sound")
    local u70 = v8({Name = "RBLX UI Swipe (SFX)", SoundId = "rbxassetid://10128766965"})
    local v9 = scope:New("Sound")
    local u76 = v9({Name = "RBLX UI Back (SFX)", SoundId = "rbxassetid://10066914500"})
    local u77 = false
    local v10 = scope:Observer(u9)
    v10:onBind(function() -- Line: 207 -- upvalues: Fusion (upval), u9 (val), u77 (ref), u70 (val), u76 (val)
        local v1 = Fusion.peek(u9)
        if not u77 then
            u77 = true
            return
        end
        if v1 then
            u70:Play()
            return
        end
        u76:Play()
    end)
    v10 = scope:New("SurfaceGui")
    local v11 = {
        Name = "SkillGui",
        Face = Enum.NormalId.Top,
        ClipsDescendants = false,
        LightInfluence = 0,
        Brightness = u51,
        SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Adornee = p1.Adornee,
        ResetOnSpawn = false,
    }
    local v12 = {}
    local v13 = scope:New("TextButton")
    local v14 = {
        Name = "ClickDetector",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Text = "",
        ZIndex = 10,
    }
    local Activated = OnEvent("Activated")
    v14[Activated] = function() -- Line: 246 -- upvalues: p1 (val)
        if p1.OnClick then
            p1.OnClick()
        end
    end
    local MouseEnter = OnEvent("MouseEnter")
    v14[MouseEnter] = function() -- Line: 252 -- upvalues: p1 (val)
        if p1.OnHoverEnter then
            p1.OnHoverEnter()
        end
    end
    local MouseLeave = OnEvent("MouseLeave")
    v14[MouseLeave] = function() -- Line: 258 -- upvalues: p1 (val)
        if p1.OnHoverLeave then
            p1.OnHoverLeave()
        end
    end
    v13 = v13(v14)
    v14 = scope:New("Frame")
    local v15 = {
        Name = "Frame",
        BackgroundColor3 = v4,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Visible = v2,
    }
    local v16 = {}
    local v17 = scope:New("UICorner")
    v17 = v17({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
    local v18 = scope:New("UIGradient")
    v18 = v18({Name = "UIGradient", Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    local v19 = scope:New("ImageLabel")
    v19 = v19({
        Name = "ImageLabel",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.31),
        Size = UDim2.fromScale(0.52, 0.52),
        ScaleType = Enum.ScaleType.Fit,
        Image = p1.Icon or "rbxassetid://3187426822",
    })
    local v20 = scope:New("TextLabel")
    local v21 = {
        Name = "SkillName",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.69),
        Size = UDim2.fromScale(0.9, 0.22),
        Font = Theme.Menu.Fonts.Header,
        Text = p1.SkillName,
        TextColor3 = Theme.Menu.Text,
        TextSize = 112,
        TextScaled = true,
        TextWrapped = true,
        RichText = true,
        ZIndex = 2,
    }
    local v22 = {}
    local v23 = scope:New("UITextSizeConstraint")
    v22[1] = v23({MaxTextSize = 112})
    v21[Children] = v22
    v20 = v20(v21)
    v21 = scope:New("TextLabel")
    local v24 = {
        Name = "UpgradeLevel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0.5, 0.9),
        Size = UDim2.fromScale(0.78, 0.12),
        Font = Theme.Menu.Fonts.Header,
        Text = v1,
        TextColor3 = Theme.Menu.Text,
        TextSize = 84,
        TextScaled = true,
        TextWrapped = true,
        RichText = true,
        ZIndex = 2,
    }
    v23 = {}
    local v25 = scope:New("UITextSizeConstraint")
    v23[1] = v25({MaxTextSize = 84})
    v24[Children] = v23
    v21 = v21(v24)
    v24 = scope:New("Frame")
    v22 = {
        Name = "Locked",
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 1,
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        Size = UDim2.fromScale(1, 1),
        Visible = v3,
    }
    v16[1] = v17
    v16[2] = v18
    v16[3] = u76
    v16[4] = v19
    v16[5] = v20
    v16[6] = v21
    v16[7] = v24(v22)
    v15[Children] = v16
    v14 = v14(v15)
    v15 = scope:New("Frame")
    local v26 = {
        Name = "DescFrame",
        BackgroundColor3 = v4,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        Visible = u9,
    }
    v17 = {}
    v18 = scope:New("UICorner")
    v18 = v18({CornerRadius = UDim.new(0, Theme.Menu.CornerRadius)})
    local v27 = scope:New("UIGradient")
    v27 = v27({Name = "UIGradient", Color = Theme.Menu.Shade, Rotation = Theme.Menu.ShadeRotation})
    v20 = scope:New("ImageLabel")
    v20 = v20({
        Name = "ImageLabel",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ImageTransparency = 0.1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = p1.Icon or "rbxassetid://3187426822",
        ImageColor3 = Theme.Menu.Text,
        Position = UDim2.fromScale(0.5, 0.16),
        ScaleType = Enum.ScaleType.Fit,
        Size = UDim2.fromScale(0.26, 0.26),
    })
    v21 = scope:New("TextLabel")
    v24 = {
        Name = "SkillName",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Header,
        Position = UDim2.fromScale(0.5, 0.35),
        RichText = true,
        Size = UDim2.fromScale(0.88, 0.16),
        Text = p1.SkillName,
        TextColor3 = Theme.Menu.Text,
        TextSize = 120,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
    }
    v23 = {}
    v25 = scope:New("UITextSizeConstraint")
    v23[1] = v25({MaxTextSize = 120})
    v24[Children] = v23
    v21 = v21(v24)
    v24 = scope:New("TextLabel")
    v22 = {
        Name = "UpgradeLevel",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Header,
        Position = UDim2.fromScale(0.5, 0.51),
        RichText = true,
        Size = UDim2.fromScale(0.55, 0.13),
        Text = v1,
        TextColor3 = Theme.Menu.Text,
        TextSize = 92,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
    }
    v25 = {}
    local v28 = scope:New("UITextSizeConstraint")
    v25[1] = v28({MaxTextSize = 92})
    v22[Children] = v25
    v24 = v24(v22)
    v22 = scope:New("TextLabel")
    v23 = {
        Name = "Description",
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Font = Theme.Menu.Fonts.Body,
        Position = UDim2.fromScale(0.5, 0.6),
        RichText = false,
        Size = UDim2.fromScale(0.9, 0.34),
        Text = p1.Description or "",
        TextColor3 = Theme.Menu.Text,
        TextSize = 76,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
    }
    v28 = {}
    local v29 = scope:New("UITextSizeConstraint")
    v28[1] = v29({MaxTextSize = 76})
    v23[Children] = v28
    v22 = v22(v23)
    v23 = scope:New("UIPadding")
    v25 = {Name = "UIPadding", PaddingLeft = UDim.new(0.03, 0), PaddingRight = UDim.new(0.03, 0)}
    v17[1] = v18
    v17[2] = v27
    v17[3] = u70
    v17[4] = v20
    v17[5] = v21
    v17[6] = v24
    v17[7] = v22
    v17[8] = v23(v25)
    v26[Children] = v17
    v15 = v15(v26)
    v26 = scope:New("Frame")
    v16 = {
        Name = "Outline",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 6,
    }
    v18 = {}
    v27 = scope:New("UIStroke")
    v18[1] = v27({Name = "UIStroke", Color = v5, LineJoinMode = Enum.LineJoinMode.Bevel, Thickness = v6})
    v16[Children] = v18
    v12[1] = v13
    v12[2] = v14
    v12[3] = v15
    v12[4] = v26(v16)
    v11[Children] = v12
    return v10(v11)
end