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

local function ensureGui() -- Line: 31
    -- upvalues: u21 (ref), u22 (ref), scoped (val), Fusion (val), u23 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref)
    -- upvalues: u28 (ref), u29 (ref), u30 (ref), Players (val), Children (val)
    if u21 then
        return
    end
    u21 = true
    u22 = scoped(Fusion)
    u23 = u22:Value(false)
    u24 = u22:Value("")
    local v1 = u22
    local v2 = Color3.fromRGB(255, 255, 255)
    u25 = v1:Value(v2)
    u26 = u22:Value("")
    u27 = u22:Value("")
    u28 = u22:Value("")
    u29 = u22:Value("")
    v1 = u22
    v2 = Vector2.new(0, 0)
    u30 = v1:Value(v2)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v3 = u22:New("ScreenGui")
    v2 = {
        Name = "ModifierTooltipGui",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        Parent = PlayerGui,
        DisplayOrder = 50,
    }
    local v4 = Children
    local v5 = {}
    local v6 = u22:New("Frame")
    local v7 = {
        Name = "Tooltip",
        Visible = u23,
        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ZIndex = 1000,
    }
    local v8 = u22
    v7.Position = v8:Computed(function(p1) -- Line: 63 -- upvalues: u30 (upval)
        local v1 = p1(u30)
        local ViewportSize = workspace.CurrentCamera.ViewportSize
        local v2 = v1.X + 16
        local v3 = v1.Y + 16
        local v4 = v2 + 260
        if ViewportSize.X < v4 then
            v2 = v1.X - 260 - 16
        end
        v4 = v3 + 100
        if ViewportSize.Y < v4 then
            v3 = v1.Y - 100 - 8
        end
        v2 = math.max(8, v2)
        v3 = math.max(8, v3)
        return UDim2.fromOffset(v2, v3)
    end)
    v7.Size = UDim2.fromOffset(260, 0)
    v7.AutomaticSize = Enum.AutomaticSize.Y
    v7.ClipsDescendants = true
    v8 = Children
    local v9 = {}
    local v10 = u22:New("UICorner")({CornerRadius = UDim.new(0, 6)})
    local v11 = u22:New("UIStroke")({Thickness = 1, Color = Color3.fromRGB(60, 60, 60)})
    local v12 = u22:New("UIPadding")({
        PaddingTop = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
    })
    local v13 = u22:New("UIListLayout")({SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})
    local v14 = u22:New("TextLabel")
    local v15 = {
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
    }
    local v16 = u22
    v15.Text = v16:Computed(function(p1) -- Line: 126 -- upvalues: u24 (upval)
        return p1(u24)
    end)
    v16 = u22
    v15.TextColor3 = v16:Computed(function(p1) -- Line: 127 -- upvalues: u25 (upval)
        return p1(u25)
    end)
    v14 = v14(v15)
    v15 = u22:New("TextLabel")
    v16 = {
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
    }
    local v17 = u22
    v16.Text = v17:Computed(function(p1) -- Line: 141 -- upvalues: u26 (upval)
        return p1(u26)
    end)
    v16.TextColor3 = Color3.fromRGB(210, 210, 210)
    v15 = v15(v16)
    v16 = u22:New("TextLabel")
    v17 = {
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
    }
    local v18 = u22
    v17.Text = v18:Computed(function(p1) -- Line: 156 -- upvalues: u29 (upval), u27 (upval), u28 (upval)
        local v1 = p1(u29)
        local v2 = p1(u27)
        local v3 = p1(u28)
        if v1 and v1 ~= "" and v1 ~= "+0%" then
            return string.format("<b>Stats:</b> %s  %s Z$  %s XP", v1, v2, v3)
        end
        if v2 == "+0%" and v3 == "+0%" then
            return ""
        end
        return string.format("<b>Stats:</b> %s Z$  %s XP", v2, v3)
    end)
    v17.TextColor3 = Color3.fromRGB(170, 200, 255)
    v9[1] = v10
    v9[2] = v11
    v9[3] = v12
    v9[4] = v13
    v9[5] = v14
    v9[6] = v15
    v9[7] = v16(v17)
    v7[v8] = v9
    v5[1] = v6(v7)
    v2[v4] = v5
    v3(v2)
end

function u20.init() -- Line: 180 -- upvalues: ensureGui (val)
    ensureGui()
end

function u20.show(p1, p2) -- Line: 184
    -- upvalues: ensureGui (val), u24 (ref), u25 (ref), u26 (ref), u29 (ref), u27 (ref), u28 (ref), u30 (ref), u23 (ref)
    local Description, Name, NameColor, v1, v2
    ensureGui()
    local StatText = ""
    if p1 and type(p1) == "table" then
        if p1.StatText then
            StatText = p1.StatText
        elseif p1.GetModifierStatText then
            StatText = p1.GetModifierStatText()
        end
    end
    local v3 = u24
    if p1 then
        Name = p1.Name
        if not Name then
            if not p1 then
                Name = "Modifier"
            else
                Name = p1.id
                if not Name then
                    Name = "Modifier"
                end
            end
        end
    elseif not p1 then
        Name = "Modifier"
    else
        Name = p1.id
        if not Name then
            Name = "Modifier"
        end
    end
    v3:set(Name)
    v3 = u25
    if not p1 then
        NameColor = Color3.fromRGB(255, 255, 255)
    else
        NameColor = p1.NameColor
        if not NameColor then
            NameColor = Color3.fromRGB(255, 255, 255)
        end
    end
    v3:set(NameColor)
    v3 = u26
    if not p1 then
        Description = ""
    else
        Description = p1.Description
        if not Description then
            Description = ""
        end
    end
    v3:set(Description)
    u29:set(StatText)
    v3 = "+0%"
    if p1 and p1.ZBucksMultiplier then
        v2 = p1.ZBucksMultiplier * 100
        v1 = math.floor(v2)
        if not (0 <= v1) then
            v3 = (tostring(v1)) .. "%"
        else
            v3 = "+" .. (tostring(v1)) .. "%"
        end
    end
    v1 = "+0%"
    if p1 and p1.XPMultiplier then
        local v4 = p1.XPMultiplier * 100
        v2 = math.floor(v4)
        if not (0 <= v2) then
            v1 = (tostring(v2)) .. "%"
        else
            v1 = "+" .. (tostring(v2)) .. "%"
        end
    end
    u27:set(v3)
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

function u20.bindHover(p1, p2) -- Line: 232
    -- upvalues: UserInputService (val), u20 (val), u23 (ref), peek (val), u30 (ref)
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
            local v1 = u30
            local MouseLocation = UserInputService:GetMouseLocation()
            v1:set(MouseLocation)
        end
    end)
end

return u20