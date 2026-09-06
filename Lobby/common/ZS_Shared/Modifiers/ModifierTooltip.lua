local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Fusion = require(game.ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local scoped = Fusion.scoped
local peek = Fusion.peek
if not peek then
    function peek(p1) -- Line: 7
        return p1:get()
    end
end
local u20 = {}
local u21 = false
local u22 = nil
local u23 = nil
local u24 = nil
local u25 = nil
local u26 = nil
local u27 = nil
local u28 = nil
local u29 = nil
local u30 = nil
local function ensureGui() -- Line: 31 -- upvalues: u21 (ref), u22 (ref), scoped (val), Fusion (val), u23 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u28 (ref), u29 (ref), u30 (ref), Players (val), Children (val)
    if u21 then
        return
    end
    u21 = true
    u22 = scoped(Fusion)
    u23 = u22:Value(false)
    u24 = u22:Value("")
    u25 = u22:Value(Color3.fromRGB(255, 255, 255))
    u26 = u22:Value("")
    u27 = u22:Value("")
    u28 = u22:Value("")
    u29 = u22:Value("")
    u30 = u22:Value(Vector2.new(0, 0))
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v1 = u22:New("ScreenGui")
    local v2 = {
        Name = "ModifierTooltipGui",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        Parent = PlayerGui,
        DisplayOrder = 50,
    }
    local v3 = {}
    local v4 = u22:New("Frame")
    local v5 = {
        Name = "Tooltip",
        Visible = u23,
        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ZIndex = 1000,
        Position = u22:Computed(function(p1) -- Line: 63 -- upvalues: u30 (upval)
            local v1 = p1(u30)
            local ViewportSize = workspace.CurrentCamera.ViewportSize
            local v2 = v1.X + 16
            local v3 = v1.Y + 16
            if ViewportSize.X < v2 + 260 then
                v2 = v1.X - 260 - 16
            end
            if ViewportSize.Y < v3 + 100 then
                v3 = v1.Y - 100 - 8
            end
            v2 = math.max(8, v2)
            v3 = math.max(8, v3)
            return UDim2.fromOffset(v2, v3)
        end),
        Size = UDim2.fromOffset(260, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ClipsDescendants = true,
    }
    local v6 = {}
    local v7 = u22:New("UICorner")
    v7 = v7({CornerRadius = UDim.new(0, 6)})
    local v8 = u22:New("UIStroke")
    v8 = v8({Thickness = 1, Color = Color3.fromRGB(60, 60, 60)})
    local v9 = u22:New("UIPadding")
    v9 = v9({PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})
    local v10 = u22:New("UIListLayout")
    v10 = v10({SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})
    local v11 = u22:New("TextLabel")
    v11 = v11({
        Name = "Name",
        LayoutOrder = 1,
        BackgroundTransparency = 1,
        TextSize = 16,
        TextWrapped = true,
        RichText = true,
        ZIndex = 1001,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Text = u22:Computed(function(p1) -- Line: 126 -- upvalues: u24 (upval)
            return p1(u24)
        end),
        TextColor3 = u22:Computed(function(p1) -- Line: 127 -- upvalues: u25 (upval)
            return p1(u25)
        end),
    })
    local v12 = u22:New("TextLabel")
    v12 = v12({
        Name = "Desc",
        LayoutOrder = 2,
        BackgroundTransparency = 1,
        TextSize = 14,
        TextWrapped = true,
        ZIndex = 1001,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Text = u22:Computed(function(p1) -- Line: 141 -- upvalues: u26 (upval)
            return p1(u26)
        end),
        TextColor3 = Color3.fromRGB(210, 210, 210),
    })
    local v13 = u22:New("TextLabel")
    local v14 = {
        Name = "Stats",
        LayoutOrder = 3,
        BackgroundTransparency = 1,
        TextSize = 13,
        TextWrapped = true,
        RichText = true,
        ZIndex = 1001,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        Text = u22:Computed(function(p1) -- Line: 156 -- upvalues: u29 (upval), u27 (upval), u28 (upval)
            local v1 = p1(u29)
            local v2 = p1(u27)
            local v3 = p1(u28)
            if not v1 or v1 == "" then
                if v2 == "+0%" then
                    if v3 ~= "+0%" then
                        return string.format("<b>Stats:</b> %s Z$  %s XP", v2, v3)
                    end
                    return ""
                end
                return string.format("<b>Stats:</b> %s Z$  %s XP", v2, v3)
            end
            if v1 ~= "+0%" then
                return string.format("<b>Stats:</b> %s  %s Z$  %s XP", v1, v2, v3)
            end
            if v2 ~= "+0%" or v3 ~= "+0%" then
                return string.format("<b>Stats:</b> %s Z$  %s XP", v2, v3)
            end
            return ""
        end),
        TextColor3 = Color3.fromRGB(170, 200, 255),
    }
    v6[1] = v7
    v6[2] = v8
    v6[3] = v9
    v6[4] = v10
    v6[5] = v11
    v6[6] = v12
    v6[7] = v13(v14)
    v5[Children] = v6
    v3[1] = v4(v5)
    v2[Children] = v3
    v1(v2)
end
function u20.init() -- Line: 180 -- upvalues: ensureGui (val)
    ensureGui()
end
function u20.show(p1, p2) -- Line: 184 -- upvalues: ensureGui (val), u24 (ref), u25 (ref), u26 (ref), u29 (ref), u27 (ref), u28 (ref), u30 (ref), u23 (ref)
    local Description, Name, NameColor, v1, v2, v3
    ensureGui()
    local StatText = ""
    if p1 and type(p1) == "table" then
        if p1.StatText then
            StatText = p1.StatText
        elseif p1.GetModifierStatText then
            StatText = p1.GetModifierStatText()
        end
    end
    if p1 then
        Name = p1.Name
    elseif not p1 then
        Name = "Modifier"
    else
        Name = p1.id
    end
    u24:set(Name)
    if not p1 then
        NameColor = Color3.fromRGB(255, 255, 255)
    else
        NameColor = p1.NameColor
    end
    u25:set(NameColor)
    if not p1 then
        Description = ""
    else
        Description = p1.Description
    end
    u26:set(Description)
    u29:set(StatText)
    local v4 = "+0%"
    if p1 and p1.ZBucksMultiplier then
        v1 = math.floor(p1.ZBucksMultiplier * 100)
        if 0 > v1 then
            v2 = tostring(v1)
            v4 = v2 .. "%"
        else
            v3 = tostring(v1)
            v4 = "+" .. v3 .. "%"
        end
    end
    v1 = "+0%"
    if p1 and p1.XPMultiplier then
        v2 = math.floor(p1.XPMultiplier * 100)
        if 0 > v2 then
            v3 = tostring(v2)
            v1 = v3 .. "%"
        else
            local v5 = tostring(v2)
            v1 = "+" .. v5 .. "%"
        end
    end
    u27:set(v4)
    u28:set(v1)
    u30:set(p2)
    u23:set(true)
end
function u20.hide() -- Line: 227 -- upvalues: u21 (ref), u23 (ref)
    if not u21 then
        return
    end
    u23:set(false)
end
function u20.bindHover(p1, p2) -- Line: 232 -- upvalues: UserInputService (val), u20 (val), u23 (ref), peek (val), u30 (ref)
    local u2 = false
    local u3 = nil
    p1.MouseEnter:Connect(function() -- Line: 236 -- upvalues: u2 (ref), u3 (ref), p2 (val), UserInputService (upval), u20 (upval)
        u2 = true
        if u3 then
            task.cancel(u3)
            u3 = nil
        end
        local v1 = p2()
        if not v1 then
            return
        end
        local MouseLocation = UserInputService:GetMouseLocation()
        u20.show(v1, MouseLocation)
    end)
    p1.MouseLeave:Connect(function() -- Line: 250 -- upvalues: u2 (ref), u3 (ref), u20 (upval)
        u2 = false
        u3 = task.spawn(function() -- Line: 253 -- upvalues: u2 (upval), u20 (upval), u3 (upval)
            task.wait(0.1)
            if not u2 then
                u20.hide()
            end
            u3 = nil
        end)
    end)
    p1.MouseMoved:Connect(function() -- Line: 262 -- upvalues: u2 (ref), u23 (upval), peek (upval), u30 (upval), UserInputService (upval)
        if u2 and u23 and peek(u23) then
            u30:set(UserInputService:GetMouseLocation())
        end
    end)
end
return u20