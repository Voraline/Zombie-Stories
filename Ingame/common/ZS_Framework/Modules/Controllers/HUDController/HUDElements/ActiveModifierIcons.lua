local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local ModifierData = require(ReplicatedStorage.common.ZS_Shared.Data.ModifierData)
local ModifierUtil = require(ReplicatedStorage.common.ZS_Shared.Modifiers.ModifierUtil)
local ModifierTooltip = require(ReplicatedStorage.common.ZS_Shared.Modifiers.ModifierTooltip)
require("@game/ReplicatedStorage/common/HUDService")
local scoped = Fusion.scoped
local u52 = {IsShowing = false}
local u54 = nil
local u55 = nil
local u56 = nil
local u57 = nil
local u58 = nil
local u59 = true
local function isMobile() -- Line: 43 -- upvalues: UserInputService (val)
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = not UserInputService.KeyboardEnabled
    end
    return TouchEnabled
end
local function getIconSize() -- Line: 48 -- upvalues: UserInputService (val)
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = not UserInputService.KeyboardEnabled
    end
    if TouchEnabled then
        return 16
    end
    return 32
end
local function getMaxIconsPerRow() -- Line: 53
    return 8
end
local function isInGameplayPlace() -- Line: 58 -- upvalues: GameState (val)
    return not GameState.Data.IsLobby
end
local function createModifierIcon(p1) -- Line: 63 -- upvalues: ModifierData (val), ModifierUtil (val), UserInputService (val), u54 (ref)
    local v1
    if not (ModifierData[p1]) then
        return nil
    end
    local v2 = ModifierUtil.GetModifierIcon(p1)
    if not v2 then
        return nil
    end
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = not UserInputService.KeyboardEnabled
    end
    if not TouchEnabled then
        v1 = 32
    else
        v1 = 16
    end
    local v3 = u54:New("ImageButton")
    return v3({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ImageTransparency = 0,
        Name = p1,
        Size = UDim2.fromOffset(v1, v1),
        Image = v2,
        ScaleType = Enum.ScaleType.Fit,
    })
end
local function updatePosition() -- Line: 88 -- upvalues: u56 (ref), Players (val)
    if not u56 then
        return
    end
    local HealthUI = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("HealthUI")
    local v1 = u56.AbsoluteSize.Y + 16
    if not HealthUI or not HealthUI.Enabled then
        local v2 = UDim2.new(0, 20, 1, -v1)
        u56.Position = v2
        return
    end
    local Frame = HealthUI:FindFirstChild("Frame")
    if not Frame then
        return
    end
    local v3 = UDim2.new(0, Frame.AbsolutePosition.X + Frame.AbsoluteSize.X + 8, 1, -v1)
    u56.Position = v3
end
local function updateIcons() -- Line: 123 -- upvalues: u56 (ref), UserInputService (val), GameState (val), u57 (ref), u59 (ref), createModifierIcon (val), ModifierTooltip (val), ModifierData (val), updatePosition (val)
    local v1
    if not u56 then
        return
    end
    local UIGridLayout = u56:FindFirstChild("UIGridLayout")
    if UIGridLayout then
        local v2
        local TouchEnabled = UserInputService.TouchEnabled
        if TouchEnabled then
            TouchEnabled = not UserInputService.KeyboardEnabled
        end
        if not TouchEnabled then
            v2 = 32
        else
            v2 = 16
        end
        UIGridLayout.CellSize = UDim2.fromOffset(v2, v2)
        UIGridLayout.FillDirectionMaxCells = 8
    end
    for k, v in pairs(u56:GetChildren()) do
        if v:IsA("GuiObject") and v.Name ~= "UIGridLayout" then
            v:Destroy()
        end
    end
    if GameState.Data.IsLobby or not u59 then
        u57:set(false)
        return
    end
    local ActiveModifiers = GameState.Data.ActiveModifiers
    if not ActiveModifiers then
        ActiveModifiers = {}
    end
    if not ActiveModifiers or next(ActiveModifiers) == nil then
        u57:set(false)
        return
    end
    local v3 = false
    for k2, i in pairs(ActiveModifiers) do
        if i then
            v1 = createModifierIcon(k2)
            if v1 then
                v1.Parent = u56
                v3 = true
                ModifierTooltip.bindHover(v1, function() -- Line: 172 -- upvalues: ModifierData (upval), k2 (val)
                    return ModifierData[k2]
                end)
            end
        end
    end
    u57:set(v3)
    updatePosition()
end
local function initialize() -- Line: 187 -- upvalues: GameState (val), u54 (ref), scoped (val), Fusion (val), ModifierTooltip (val), u57 (ref), u58 (ref), Players (val), u55 (ref), UserInputService (val), u56 (ref), updateIcons (val), RunService (val), updatePosition (val)
    if GameState.Data.IsLobby then
        return
    end
    u54 = scoped(Fusion)
    ModifierTooltip.init()
    u57 = u54:Value(false)
    local ActiveModifiers = GameState.Data.ActiveModifiers
    if not ActiveModifiers then
        ActiveModifiers = {}
    end
    u58 = u54:Value(ActiveModifiers)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v1 = u54:New("ScreenGui")
    u55 = v1({
        Name = "ActiveModifierIconsGui",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        Parent = PlayerGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = not UserInputService.KeyboardEnabled
    end
    if not TouchEnabled then
        v1 = 32
    else
        v1 = 16
    end
    local v2 = u54:New("Frame")
    local v3 = {
        Name = "ActiveModifierIcons",
        Parent = u55,
        Visible = u57,
        Size = UDim2.fromOffset(200, v1),
        Position = UDim2.new(0, 20, 1, -(v1 + 16)),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
    }
    local v4 = {}
    local v5 = u54:New("UIGridLayout")
    v4[1] = v5({
        Name = "UIGridLayout",
        CellSize = UDim2.fromOffset(v1, v1),
        CellPadding = UDim2.fromOffset(4, 4),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        SortOrder = Enum.SortOrder.LayoutOrder,
        StartCorner = Enum.StartCorner.BottomLeft,
        FillDirectionMaxCells = 8,
    })
    v3[Fusion.Children] = v4
    u56 = v2(v3)
    if not GameState.Signals.ActiveModifiers then
        warn("ActiveModifierIcons: GameState.Signals.ActiveModifiers not found")
    else
        GameState.Signals.ActiveModifiers:Connect(function(p1) -- Line: 241 -- upvalues: u58 (upval), updateIcons (upval)
            u58:set(p1)
            updateIcons()
        end)
    end
    RunService.Heartbeat:Connect(updatePosition)
    updateIcons()
    updatePosition()
end
local u68 = false
function u52.Show(p1) -- Line: 260 -- upvalues: u68 (ref), GameState (val), initialize (val), u54 (ref), u59 (ref), u52 (val), updateIcons (val)
    if not u68 and not GameState.Data.IsLobby then
        initialize()
        u68 = true
    end
    if not u54 then
        return
    end
    u59 = true
    u52.IsShowing = true
    updateIcons()
end
function u52.Hide(p1) -- Line: 274 -- upvalues: u59 (ref), u57 (ref), u52 (val)
    u59 = false
    if u57 then
        u57:set(false)
    end
    u52.IsShowing = false
end
return u52