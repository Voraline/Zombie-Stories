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

local function createModifierIcon(p1) -- Line: 63
    -- upvalues: ModifierData (val), ModifierUtil (val), UserInputService (val), u54 (ref)
    local v1
    if not ModifierData[p1] then
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
    return u54:New("ImageButton")({
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
    if HealthUI and HealthUI.Enabled then
        local Frame = HealthUI:FindFirstChild("Frame")
        if not Frame then
            return
        end
        local AbsolutePosition = Frame.AbsolutePosition
        local AbsoluteSize = Frame.AbsoluteSize
        local v2 = UDim2.new(0, AbsolutePosition.X + AbsoluteSize.X + 8, 1, -v1)
        u56.Position = v2
        return
    end
    local v3 = UDim2.new(0, 20, 1, -v1)
    u56.Position = v3
end

local function updateIcons() -- Line: 123
    -- upvalues: u56 (ref), UserInputService (val), GameState (val), u57 (ref), u59 (ref), createModifierIcon (val)
    -- upvalues: ModifierTooltip (val), ModifierData (val), updatePosition (val)
    if not u56 then
        return
    end
    local UIGridLayout = u56:FindFirstChild("UIGridLayout")
    if UIGridLayout then
        local v1
        local TouchEnabled = UserInputService.TouchEnabled
        if TouchEnabled then
            TouchEnabled = not UserInputService.KeyboardEnabled
        end
        if not TouchEnabled then
            v1 = 32
        else
            v1 = 16
        end
        UIGridLayout.CellSize = UDim2.fromOffset(v1, v1)
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
    if ActiveModifiers and next(ActiveModifiers) ~= nil then
        local v2, v3
        local v4 = false
        for k2, i in pairs(ActiveModifiers) do
            if i then
                v2 = createModifierIcon(k2)
                if v2 then
                    v2.Parent = u56
                    v4 = true
                    v3 = ModifierTooltip
                    v3.bindHover(v2, function() -- Line: 172 -- upvalues: ModifierData (upval), k2 (val)
                        return ModifierData[k2]
                    end)
                end
            end
        end
        u57:set(v4)
        updatePosition()
        return
    end
    u57:set(false)
end

local function initialize() -- Line: 187
    -- upvalues: GameState (val), u54 (ref), scoped (val), Fusion (val), ModifierTooltip (val), u57 (ref), u58 (ref)
    -- upvalues: Players (val), u55 (ref), UserInputService (val), u56 (ref), updateIcons (val), RunService (val)
    -- upvalues: updatePosition (val)
    if GameState.Data.IsLobby then
        return
    end
    u54 = scoped(Fusion)
    ModifierTooltip.init()
    u57 = u54:Value(false)
    local v1 = u54
    local ActiveModifiers = GameState.Data.ActiveModifiers
    if not ActiveModifiers then
        ActiveModifiers = {}
    end
    u58 = v1:Value(ActiveModifiers)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    local v2 = u54:New("ScreenGui")
    u55 = v2({
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
        v2 = 32
    else
        v2 = 16
    end
    local v3 = u54:New("Frame")
    local v4 = {
        Name = "ActiveModifierIcons",
        Parent = u55,
        Visible = u57,
        Size = UDim2.fromOffset(200, v2),
        Position = UDim2.new(0, 20, 1, -(v2 + 16)),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
    }
    local v5 = Fusion
    local Children = v5.Children
    v4[Children] = {
        u54:New("UIGridLayout")({
            Name = "UIGridLayout",
            CellSize = UDim2.fromOffset(v2, v2),
            CellPadding = UDim2.fromOffset(4, 4),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            SortOrder = Enum.SortOrder.LayoutOrder,
            StartCorner = Enum.StartCorner.BottomLeft,
            FillDirectionMaxCells = 8,
        }),
    }
    u56 = v3(v4)
    if not GameState.Signals.ActiveModifiers then
        warn("ActiveModifierIcons: GameState.Signals.ActiveModifiers not found")
    else
        v3 = GameState
        v3.Signals.ActiveModifiers:Connect(function(p1) -- Line: 241 -- upvalues: u58 (upval), updateIcons (upval)
            u58:set(p1)
            updateIcons()
        end)
    end
    v3 = RunService
    local Heartbeat = v3.Heartbeat
    v5 = updatePosition
    Heartbeat:Connect(v5)
    updateIcons()
    updatePosition()
end

local u68 = false

function u52.Show(p1) -- Line: 260
    -- upvalues: u68 (ref), GameState (val), initialize (val), u54 (ref), u59 (ref), u52 (val), updateIcons (val)
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