local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local OnEvent = (require(ReplicatedStorage.Packages.Fusion)).OnEvent
local u22 = require("../../Theme")
local ModifierData = require(ReplicatedStorage.common.ZS_Shared.Data.ModifierData)
local ModifierUtil = require(ReplicatedStorage.common.ZS_Shared.Modifiers.ModifierUtil)

local function sortedModifierIds(p1) -- Line: 36 -- upvalues: ModifierData (val)
    local v1 = {}
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if j and ModifierData[i] then
            table.insert(v1, i)
        end
    end
    table.sort(v1, function(p1, p2) -- Line: 43 -- upvalues: ModifierData (upval)
        local v1 = ModifierData[p1].Name < ModifierData[p2].Name
        return v1
    end)
    return v1
end

local function tooltipInfo(p1) -- Line: 49 -- upvalues: ModifierData (val), ModifierUtil (val)
    local v1 = ModifierData[p1]
    local v2 = {
        Name = v1.Name,
        Description = v1.Description,
        ZBucksMultiplier = v1.ZBucksMultiplier,
        XPMultiplier = v1.XPMultiplier,
    }
    local StatText = v1.StatText
    if not StatText then
        StatText = ModifierUtil.GetModifierStatText(p1)
    end
    v2.StatText = StatText
    return v2
end

local function isWithin(p1, p2) -- Line: 62 -- upvalues: GuiService (val)
    local GuiInset = GuiService:GetGuiInset()
    local v1 = p2.X + GuiInset.X
    local v2 = p2.Y + GuiInset.Y
    local AbsolutePosition = p1.AbsolutePosition
    local v3 = AbsolutePosition + p1.AbsoluteSize
    local v4 = false
    if AbsolutePosition.X <= v1 then
        v4 = false
        if v1 <= v3.X then
            v4 = false
            if AbsolutePosition.Y <= v2 then
                v4 = v2 <= v3.Y
            end
        end
    end
    return v4
end

return function(p1) -- Line: 71
    -- upvalues: ReplicatedStorage (val), UserInputService (val), ModifierData (val), ModifierUtil (val)
    -- upvalues: sortedModifierIds (val), u22 (val), OnEvent (val), GuiService (val)
    local Activated, Children_2, bindHover, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = p1.scope:innerScope()
    local ModifierTooltip = require(ReplicatedStorage.common.ZS_Shared.Modifiers.ModifierTooltip)
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = not UserInputService.KeyboardEnabled
    end
    local MouseEnabled = UserInputService.MouseEnabled
    if MouseEnabled then
        MouseEnabled = not TouchEnabled
    end
    local TouchEnabled_2 = UserInputService.TouchEnabled
    if not TouchEnabled then
        v8 = 32
    else
        v8 = 40
    end
    local u224 = nil

    local function unpin() -- Line: 86 -- upvalues: u224 (ref), ModifierTooltip (val)
        if u224 then
            u224 = nil
            ModifierTooltip.hide()
        end
    end

    local function toggle(p1, p2) -- Line: 93
        -- upvalues: u224 (ref), ModifierTooltip (val), ModifierData (upval), ModifierUtil (upval)
        if u224 == p1 then
            if u224 then
                u224 = nil
                ModifierTooltip.hide()
            end
            return
        end
        u224 = p1
        local show = ModifierTooltip.show
        local v1 = ModifierData[p2]
        local v2 = {
            Name = v1.Name,
            Description = v1.Description,
            ZBucksMultiplier = v1.ZBucksMultiplier,
            XPMultiplier = v1.XPMultiplier,
        }
        local StatText = v1.StatText
        if not StatText then
            StatText = ModifierUtil.GetModifierStatText(p2)
        end
        v2.StatText = StatText
        show(v2, Vector2.new(p1.AbsolutePosition.X, p1.AbsolutePosition.Y + p1.AbsoluteSize.Y))
    end

    local v10 = {}
    for i, j in sortedModifierIds(p1.Modifiers) do
        local u113 = nil
        v2 = {
            Name = j,
            Size = UDim2.fromOffset(v8, v8),
            LayoutOrder = i,
            BackgroundColor3 = u22.Menu.PanelInset,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Image = "",
        }
        Children_2 = v9.Children
        v3 = {}
        v4 = v9:New("UICorner")({CornerRadius = UDim.new(0, u22.Radius.Small)})
        v5 = v9:New("UIStroke")({
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = u22.Menu.Border,
            Thickness = u22.Stroke.Thin,
        })
        v6 = v9:New("ImageLabel")
        v7 = {
            Name = "Icon",
            BackgroundTransparency = 1,
            Image = ModifierUtil.GetModifierIcon(j) or "",
            Size = UDim2.new(1, -8, 1, -8),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ScaleType = Enum.ScaleType.Fit,
        }
        v3[1] = v4
        v3[2] = v5
        v3[3] = v6(v7)
        v2[Children_2] = v3
        if TouchEnabled_2 then
            Activated = OnEvent("Activated")

            v2[Activated] = function() -- Line: 141
                -- upvalues: u113 (ref), j (val), u224 (ref), ModifierTooltip (val), ModifierData (upval)
                -- upvalues: ModifierUtil (upval)
                local v1 = u113
                local v2 = j
                if u224 == v1 then
                    if not u224 then
                        return
                    end
                    u224 = nil
                    ModifierTooltip.hide()
                    return
                end
                u224 = v1
                local show = ModifierTooltip.show
                local v3 = ModifierData[v2]
                local v4 = {
                    Name = v3.Name,
                    Description = v3.Description,
                    ZBucksMultiplier = v3.ZBucksMultiplier,
                    XPMultiplier = v3.XPMultiplier,
                }
                local StatText = v3.StatText
                if not StatText then
                    StatText = ModifierUtil.GetModifierStatText(v2)
                end
                v4.StatText = StatText
                show(v4, Vector2.new(v1.AbsolutePosition.X, v1.AbsolutePosition.Y + v1.AbsoluteSize.Y))
            end
        end
        u113 = v9:New("ImageButton")(v2)
        if MouseEnabled then
            bindHover = ModifierTooltip.bindHover
            v3 = u113
            bindHover(v3, function() -- Line: 149 -- upvalues: j (val), ModifierData (upval), ModifierUtil (upval)
                local v1 = j
                local v2 = ModifierData[v1]
                local v3 = {
                    Name = v2.Name,
                    Description = v2.Description,
                    ZBucksMultiplier = v2.ZBucksMultiplier,
                    XPMultiplier = v2.XPMultiplier,
                }
                local StatText = v2.StatText
                if not StatText then
                    StatText = ModifierUtil.GetModifierStatText(v1)
                end
                v3.StatText = StatText
                return v3
            end)
        end
        v4 = u113
        table.insert(v10, v4)
    end
    if TouchEnabled_2 then
        v1 = UserInputService
        v1 = v1.InputBegan:Connect(function(p1) -- Line: 160 -- upvalues: u224 (ref), GuiService (upval), ModifierTooltip (val)
            if not u224 then
                return
            end
            if p1.UserInputType ~= Enum.UserInputType.Touch
                and p1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                return
            end
            local v1 = u224
            local Position = p1.Position
            local GuiInset = GuiService:GetGuiInset()
            local v2 = Position.X + GuiInset.X
            local v3 = Position.Y + GuiInset.Y
            local AbsolutePosition = v1.AbsolutePosition
            local v4 = AbsolutePosition + v1.AbsoluteSize
            local v5 = false
            if AbsolutePosition.X <= v2 then
                v5 = false
                if v2 <= v4.X then
                    v5 = false
                    if AbsolutePosition.Y <= v3 then
                        v5 = v3 <= v4.Y
                    end
                end
            end
            if not v5 and u224 then
                u224 = nil
                ModifierTooltip.hide()
            end
        end)
        table.insert(v9, v1)
    end
    table.insert(v9, function() -- Line: 179 -- upvalues: ModifierTooltip (val)
        ModifierTooltip.hide()
    end)
    v1 = v9:New("Frame")
    local v11 = {Name = "ModifierIcons"}
    local Size = v12.Size
    if not Size then
        Size = UDim2.new(1, 0, 0, 32)
    end
    v11.Size = Size
    v11.AutomaticSize = Enum.AutomaticSize.Y
    v11.LayoutOrder = v12.LayoutOrder or 0
    v11.BackgroundTransparency = 1
    v11.Parent = v12.Parent
    local Children = v9.Children
    v11[Children] = {
        v9:New("UIListLayout")({
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
            VerticalAlignment = Enum.VerticalAlignment.Center,
        }),
        v10,
    }
    v1 = v1(v11)
    return v1
end