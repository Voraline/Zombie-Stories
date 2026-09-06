local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local peek = Fusion.peek
require("@game/ReplicatedStorage/common/HUDService")
local LocalPlayerController = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
local u48 = require("@game/ReplicatedStorage/common/BindUtil")
local u51 = require("@game/ReplicatedStorage/common/Settings")
local v1 = require("./Objectives")
local v2 = require("./StaminaDisplay")
local v3 = require("@self/Components/AbilityUI")
local u61 = {}
local v4 = {}
v4[Enum.KeyCode.ButtonR1] = "RB"
v4[Enum.KeyCode.ButtonL1] = "LB"
v4[Enum.KeyCode.ButtonR2] = "RT"
v4[Enum.KeyCode.ButtonL2] = "LT"
v4[Enum.KeyCode.ButtonA] = "A"
v4[Enum.KeyCode.ButtonB] = "B"
v4[Enum.KeyCode.ButtonX] = "X"
v4[Enum.KeyCode.ButtonY] = "Y"
u61.xbox = v4
v4 = {}
v4[Enum.KeyCode.ButtonR1] = "R1"
v4[Enum.KeyCode.ButtonL1] = "L1"
v4[Enum.KeyCode.ButtonR2] = "R2"
v4[Enum.KeyCode.ButtonL2] = "L2"
v4[Enum.KeyCode.ButtonA] = "X"
v4[Enum.KeyCode.ButtonB] = "O"
v4[Enum.KeyCode.ButtonX] = "□"
v4[Enum.KeyCode.ButtonY] = "△"
u61.ps = v4
local function getGamepadType() -- Line: 47 -- upvalues: UserInputService (val)
    if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) == "ButtonCross" then
        return "ps"
    end
    return "xbox"
end
local function getOffHandKeyLabel() -- Line: 56 -- upvalues: u48 (val), u51 (val), UserInputService (val), u61 (val)
    local Gamepad, v1
    local v2 = u48.getInputMethod()
    if v2 == "Touch" then
        return "[TAP]"
    end
    local Controls = u51.Controls
    if Controls then
        Controls = u51.Controls.Binds
    end
    local OffHandUse = Controls
    if OffHandUse then
        OffHandUse = Controls.OffHandUse
    end
    if not OffHandUse then
        if v2 == "Gamepad" then
            return "[RB]"
        end
        return "[F]"
    end
    if v2 ~= "Gamepad" then
        local Keyboard = OffHandUse.Keyboard
        if Keyboard then
            return "[" .. Keyboard.Name .. "]"
        end
        return "[F]"
    end
    if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonA) ~= "ButtonCross" then
        v1 = "xbox"
    else
        v1 = "ps"
    end
    local v3 = u61[v1]
    Gamepad = OffHandUse.Gamepad
    if not Gamepad or not v3 then
        if v1 == "ps" then
            return "[R1]"
        end
        return "[RB]"
    end
    local Name = v3[Gamepad]
    if not Name then
        Name = Gamepad.Name
    end
    return "[" .. Name .. "]"
end
local v5 = Fusion.scoped(Fusion)
local u104 = v5:Value(1)
local u108 = v5:Value(false)
local u112 = v5:Value(false)
local u116 = v5:Value(0)
local u120 = v5:Value(false)
local u124 = v5:Value(1)
local u128 = v5:Value("side")
local u132 = v5:Value(false)
local u136 = v5:Value(false)
local u140 = v5:Value(false)
local u144 = v5:Value(0)
local u148 = v5:Value(0)
local u152 = v5:Value(true)
local u156 = v5:Value(nil)
local u163 = v5:Value(Vector2.new(0, 0))
local u170 = v5:Value(Vector2.new(0, 0))
local u174 = v5:Value("rbxassetid://18494319766")
local u178 = v5:Value(0)
local u182 = v5:Value(0)
local u186 = v5:Value(1)
local u191 = v5:Value((getOffHandKeyLabel()))
local u192 = {Focus = "rbxassetid://18494319766", AmmoBox = "rbxassetid://18494323513", Medkit = "rbxassetid://18494325361"}
local LocalPlayer = Players.LocalPlayer
local u194 = nil
local u195 = nil
local u196 = nil
local u197 = nil
local u198 = nil
local u199 = "none"
local u200 = 0
local u201 = 0
local u202 = 0
local u203 = false
local u204 = 0
local u205 = nil
local u206 = nil
local v6 = v3({
    scope = v5,
    percentage = u104,
    isReady = u108,
    isActivating = u112,
    activationProgress = u116,
    isActive = u120,
    durationRemaining = u124,
    staminaPlacement = u128,
    isMobile = u132,
    isGamepad = u136,
    visible = u140,
    abilityImage = u174,
    objectiveListSizeY = u144,
    ammoHudWidth = u148,
    staminaFramePosition = u163,
    staminaFrameSize = u170,
    ammoCount = u178,
    customPosition = u156,
    uiScale = u186,
    readyLabelText = u191,
    onActivatePressed = function() -- Line: 162 -- upvalues: u206 (ref)
        if u206 then
            u206:UseOffHand()
        end
    end,
})
local screenGui = v6.screenGui
local blueGlowImage = v6.blueGlowImage
local mainFrame = v6.mainFrame
local v7 = v5:Observer(u152)
v7:onChange(function() -- Line: 175 -- upvalues: peek (val), u152 (val), u140 (val), screenGui (val)
    local v1 = peek(u152)
    local v2 = peek(u140)
    screenGui.Enabled = v1 and v2
end)
v7 = v5:Observer(u140)
v7:onChange(function() -- Line: 182 -- upvalues: peek (val), u152 (val), u140 (val), screenGui (val)
    local v1 = peek(u152)
    local v2 = peek(u140)
    screenGui.Enabled = v1 and v2
end)
v7 = peek(u152)
if v7 then
    v7 = peek(u140)
end
screenGui.Enabled = v7
local Sound = Instance.new("Sound")
Sound.Name = "AbilityReady"
Sound.SoundId = "rbxassetid://9039999622"
Sound.Parent = screenGui
local v8 = TweenInfo.new(0.01, Enum.EasingStyle.Linear)
local v9 = TweenInfo.new(0.4, Enum.EasingStyle.Linear)
local u258 = TweenService:Create(blueGlowImage, v8, {ImageTransparency = 0})
local u264 = TweenService:Create(blueGlowImage, v9, {ImageTransparency = 1})
u258.Completed:Connect(function() -- Line: 203 -- upvalues: u264 (val)
    u264:Play()
end)
local function flashWheel() -- Line: 207 -- upvalues: u258 (val)
    u258:Play()
end
local function switchToFocusDisplay() -- Line: 214 -- upvalues: u194 (ref), u140 (val), u199 (ref), u174 (val), u203 (ref), u195 (ref), u120 (val), u112 (val), u124 (val), u178 (val)
    if not u194 then
        u140:set(false)
        u199 = "none"
        return
    end
    u199 = "focus"
    u174:set("rbxassetid://18494319766")
    u140:set(true)
    if u203 then
        if u195 and u195:IsFullyActivated() then
            u120:set(true)
            u112:set(false)
            local v1 = u195:GetRemainingTime() or 0
            local v2 = math.clamp(v1 / (u195:GetDuration() or 19), 0, 1)
            u124:set(v2)
        end
        u203 = false
    end
    u178:set(0)
end
local function switchToTwoHandedDisplay(p1) -- Line: 246 -- upvalues: u194 (ref), switchToFocusDisplay (val), u140 (val), u199 (ref), peek (val), u120 (val), u203 (ref), u196 (ref), u197 (ref), u112 (val), u174 (val), u192 (val), u104 (val), u178 (val), u124 (val)
    if not p1 then
        if u194 then
            switchToFocusDisplay()
            return
        end
        u140:set(false)
        u199 = "none"
        return
    end
    if u199 == "focus" and peek(u120) then
        u203 = true
    end
    u196 = p1
    u197 = p1.Config
    u199 = "twohanded"
    u120:set(false)
    u112:set(false)
    u174:set(u192[p1.Name or "AmmoBox"] or "rbxassetid://18494323513")
    u140:set(true)
    local v1 = p1.Ammo or 0
    u104:set(v1 / (p1.Config.Ammo or 3))
    u178:set(v1)
    u124:set(1)
end
local function updateAbilityState() -- Line: 286 -- upvalues: u199 (ref), u196 (ref), u194 (ref), u140 (val), u104 (val), u178 (val), peek (val), u182 (val), u108 (val), u112 (val), u120 (val), u258 (val), Sound (val)
    local v1
    if u199 ~= "twohanded" then
        v1 = u194
    else
        v1 = u196
    end
    if not v1 then
        u140:set(false)
        return
    end
    local v2 = v1.Ammo or 0
    local v3 = 0 < v2
    if u199 ~= "twohanded" then
        if not v3 then
            u104:set(peek(u182))
        else
            u104:set(1)
        end
        u178:set(0)
    else
        u104:set(v2 / (v1.Config.Ammo or 3))
        u178:set(v2)
    end
    local v4 = peek(u108)
    local v5 = v3
    if v5 then
        v5 = not peek(u112)
        if v5 then
            v5 = not peek(u120)
        end
    end
    u108:set(v5)
    if v5 and not v4 and v3 then
        u258:Play()
        Sound:Play()
    end
end
local function updateFocusState() -- Line: 327 -- upvalues: u199 (ref), updateAbilityState (val)
    if u199 ~= "focus" then
        return
    end
    updateAbilityState()
end
local function updateTwoHandedState() -- Line: 332 -- upvalues: u199 (ref), updateAbilityState (val)
    if u199 ~= "twohanded" then
        return
    end
    updateAbilityState()
end
local function updateMobilePlacement() -- Line: 337 -- upvalues: u48 (val), u132 (val), u136 (val), u205 (ref), LocalPlayer (val), u148 (val), u191 (val), getOffHandKeyLabel (val)
    local v1 = u48.getInputMethod()
    if v1 == "Touch" then
        u132:set(true)
        u136:set(false)
        if not u205 then
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if PlayerGui then
                u205 = PlayerGui:FindFirstChild("AmmoUI")
            end
        end
        if u205 then
            local Ammo = u205:FindFirstChild("Ammo")
            if Ammo then
                u148:set(Ammo.AbsoluteSize.X)
            end
        end
    elseif v1 ~= "Gamepad" then
        u132:set(false)
        u136:set(false)
    else
        u132:set(false)
        u136:set(true)
    end
    u191:set((getOffHandKeyLabel()))
end
local u302 = {
    IsShowing = true,
    GetMainFrame = function(p1) -- Line: 369 -- upvalues: mainFrame (val)
        return mainFrame
    end,
    SetCustomPosition = function(p1, p2) -- Line: 373 -- upvalues: u156 (val)
        u156:set(p2)
    end,
    SetUIScale = function(p1, p2) -- Line: 377 -- upvalues: u186 (val)
        u186:set(p2)
    end,
}
function u302.Show(p1) -- Line: 381 -- upvalues: u152 (val), u302 (val)
    u152:set(true)
    u302.IsShowing = true
end
function u302.Hide(p1) -- Line: 386 -- upvalues: u152 (val), u302 (val)
    u152:set(false)
    u302.IsShowing = false
end
function u302.SetStaminaPlacement(p1, p2) -- Line: 391 -- upvalues: u128 (val)
    u128:set(p2)
end
function u302.SetFocusAbility(p1, p2) -- Line: 396 -- upvalues: u194 (ref), u195 (ref), u199 (ref), switchToFocusDisplay (val), updateAbilityState (val), u140 (val), u112 (val), u120 (val)
    u194 = p2
    if p2 then
        u195 = p2.Config
        if u199 == "twohanded" then
            return
        end
        switchToFocusDisplay()
        updateAbilityState()
        return
    end
    u195 = nil
    if u199 == "focus" then
        u140:set(false)
        u199 = "none"
        u112:set(false)
        u120:set(false)
    end
end
function u302.SetTwoHandedAbility(p1, p2) -- Line: 418 -- upvalues: switchToTwoHandedDisplay (val), updateAbilityState (val), u196 (ref), u197 (ref), u194 (ref), switchToFocusDisplay (val), u198 (ref), u140 (val), u199 (ref), u112 (val), u120 (val)
    if not p2 or not p2.Config then
        u196 = nil
        u197 = nil
        if u194 then
            switchToFocusDisplay()
            updateAbilityState()
            return
        end
        if u198 then
            if not u198.Ammo then
                u140:set(false)
                u199 = "none"
                u112:set(false)
                u120:set(false)
                return
            end
            if 0 < u198.Ammo then
                switchToTwoHandedDisplay(u198)
                updateAbilityState()
                return
            end
            u140:set(false)
            u199 = "none"
            u112:set(false)
            u120:set(false)
            return
        end
        u140:set(false)
        u199 = "none"
        u112:set(false)
        u120:set(false)
        return
    end
    if p2.Config.IsTwoHandedAbility then
        switchToTwoHandedDisplay(p2)
        updateAbilityState()
        return
    end
    u196 = nil
    u197 = nil
    if u194 then
        switchToFocusDisplay()
        updateAbilityState()
        return
    end
    if not u198 or not u198.Ammo then
        u140:set(false)
        u199 = "none"
        u112:set(false)
        u120:set(false)
        return
    end
    if 0 < u198.Ammo then
        switchToTwoHandedDisplay(u198)
        updateAbilityState()
        return
    end
    u140:set(false)
    u199 = "none"
    u112:set(false)
    u120:set(false)
end
function u302.UpdateAmmo(p1) -- Line: 445 -- upvalues: updateAbilityState (val)
    updateAbilityState()
end
function u302.StartActivating(p1) -- Line: 450 -- upvalues: u112 (val), u116 (val), u199 (ref), u202 (ref), u200 (ref)
    u112:set(true)
    u116:set(0)
    if u199 == "twohanded" then
        u202 = os.clock()
        return
    end
    u200 = os.clock()
end
function u302.CancelActivating(p1) -- Line: 461 -- upvalues: u112 (val), u116 (val), updateAbilityState (val)
    u112:set(false)
    u116:set(0)
    updateAbilityState()
end
function u302.SetActive(p1, p2) -- Line: 468 -- upvalues: u112 (val), u120 (val), u124 (val), u201 (ref), u203 (ref), u204 (ref), u206 (ref), u199 (ref), updateAbilityState (val)
    if not p2 then
        u120:set(false)
        u124:set(0)
        u203 = false
        u204 = 0
        updateAbilityState()
        if u206 and u199 == "focus" then
            u206:OffHandItemComplete()
        end
        return
    end
    u112:set(false)
    u120:set(true)
    u124:set(1)
    u201 = os.clock()
    u203 = false
    u204 = 0
    if not u206 or u199 ~= "focus" then
        return
    end
    u206:OffHandItemComplete()
end
local u328 = nil
local function startRenderLoop() -- Line: 499 -- upvalues: u328 (ref), RunService (val), peek (val), u112 (val), u199 (ref), u202 (ref), u200 (ref), u116 (val), u120 (val), u195 (ref), u124 (val), u302 (val)
    if u328 then
        return
    end
    u328 = RunService.RenderStepped:Connect(function() -- Line: 502 -- upvalues: peek (upval), u112 (upval), u199 (upval), u202 (upval), u200 (upval), u116 (upval), u120 (upval), u195 (upval), u124 (upval), u302 (upval)
        local v1, v2
        if peek(u112) then
            local v3
            if u199 ~= "twohanded" then
                v1 = os.clock() - u200
                v3 = 1
            else
                v1 = os.clock() - u202
                v3 = 1.5
            end
            v2 = math.clamp(v1 / v3, 0, 1)
            u116:set(v2)
        end
        if peek(u120) and u199 == "focus" and u195 then
            v1 = u195:GetRemainingTime() or 0
            v2 = math.clamp(v1 / (u195:GetDuration() or 19), 0, 1)
            u124:set(v2)
            if v2 <= 0 then
                u302:SetActive(false)
            end
        end
    end)
end
local function stopRenderLoop() -- Line: 533 -- upvalues: u328 (ref)
    if u328 then
        u328:Disconnect()
        u328 = nil
    end
end
local v10 = v5:Observer(u112)
v10:onChange(function() -- Line: 541 -- upvalues: peek (val), u112 (val), u120 (val), u328 (ref), RunService (val), u199 (ref), u202 (ref), u200 (ref), u116 (val), u195 (ref), u124 (val), u302 (val)
    if peek(u112) or peek(u120) then
        if u328 then
            return
        end
        u328 = RunService.RenderStepped:Connect(function() -- Line: 502 -- upvalues: peek (upval), u112 (upval), u199 (upval), u202 (upval), u200 (upval), u116 (upval), u120 (upval), u195 (upval), u124 (upval), u302 (upval)
            local v1, v2
            if peek(u112) then
                local v3
                if u199 ~= "twohanded" then
                    v1 = os.clock() - u200
                    v3 = 1
                else
                    v1 = os.clock() - u202
                    v3 = 1.5
                end
                v2 = math.clamp(v1 / v3, 0, 1)
                u116:set(v2)
            end
            if peek(u120) and u199 == "focus" and u195 then
                v1 = u195:GetRemainingTime() or 0
                v2 = math.clamp(v1 / (u195:GetDuration() or 19), 0, 1)
                u124:set(v2)
                if v2 <= 0 then
                    u302:SetActive(false)
                end
            end
        end)
        return
    end
    if not (peek(u112)) and not (peek(u120)) and u328 then
        u328:Disconnect()
        u328 = nil
    end
end)
v10 = v5:Observer(u120)
v10:onChange(function() -- Line: 549 -- upvalues: peek (val), u112 (val), u120 (val), u328 (ref), RunService (val), u199 (ref), u202 (ref), u200 (ref), u116 (val), u195 (ref), u124 (val), u302 (val)
    if peek(u112) or peek(u120) then
        if u328 then
            return
        end
        u328 = RunService.RenderStepped:Connect(function() -- Line: 502 -- upvalues: peek (upval), u112 (upval), u199 (upval), u202 (upval), u200 (upval), u116 (upval), u120 (upval), u195 (upval), u124 (upval), u302 (upval)
            local v1, v2
            if peek(u112) then
                local v3
                if u199 ~= "twohanded" then
                    v1 = os.clock() - u200
                    v3 = 1
                else
                    v1 = os.clock() - u202
                    v3 = 1.5
                end
                v2 = math.clamp(v1 / v3, 0, 1)
                u116:set(v2)
            end
            if peek(u120) and u199 == "focus" and u195 then
                v1 = u195:GetRemainingTime() or 0
                v2 = math.clamp(v1 / (u195:GetDuration() or 19), 0, 1)
                u124:set(v2)
                if v2 <= 0 then
                    u302:SetActive(false)
                end
            end
        end)
        return
    end
    if not (peek(u112)) and not (peek(u120)) and u328 then
        u328:Disconnect()
        u328 = nil
    end
end)
u48.InputMethodChanged:Connect(function(p1) -- Line: 558 -- upvalues: updateMobilePlacement (val)
    updateMobilePlacement()
end)
u51.SettingsChanged:Connect(function(p1) -- Line: 563 -- upvalues: u191 (val), getOffHandKeyLabel (val)
    if p1 and p1[1] == "Controls" and p1[2] == "Binds" and p1[3] == "OffHandUse" then
        u191:set((getOffHandKeyLabel()))
    end
end)
v2.PlacementChanged:Connect(function(p1) -- Line: 570 -- upvalues: u128 (val)
    u128:set(p1)
end)
u128:set(v2:GetPlacement())
local MainFrame = v2:GetMainFrame()
local function updateStaminaFrameState() -- Line: 579 -- upvalues: u163 (val), MainFrame (val), u170 (val)
    u163:set(MainFrame.AbsolutePosition)
    u170:set(MainFrame.AbsoluteSize)
end
local PropertyChangedSignal = MainFrame:GetPropertyChangedSignal("AbsolutePosition")
PropertyChangedSignal:Connect(updateStaminaFrameState)
local PropertyChangedSignal_2 = MainFrame:GetPropertyChangedSignal("AbsoluteSize")
PropertyChangedSignal_2:Connect(updateStaminaFrameState)
u163:set(MainFrame.AbsolutePosition)
u170:set(MainFrame.AbsoluteSize)
local GuiList = v1:GetGuiList()
local PropertyChangedSignal_3 = GuiList:GetPropertyChangedSignal("AbsoluteSize")
PropertyChangedSignal_3:Connect(function() -- Line: 590 -- upvalues: peek (val), u132 (val), u144 (val), GuiList (val)
    if peek(u132) then
        u144:set(GuiList.AbsoluteSize.Y)
    end
end)
task.spawn(function() -- Line: 598 -- upvalues: u206 (ref), u198 (ref), u302 (val), u199 (ref), switchToTwoHandedDisplay (val), updateAbilityState (val), u140 (val), ReplicatedStorage (val), u182 (val)
    u206 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.WeaponController)
    u206.InventoryChanged:Connect(function(p1) -- Line: 603 -- upvalues: u198 (upval), u302 (upval), u199 (upval), switchToTwoHandedDisplay (upval), updateAbilityState (upval), u140 (upval)
        local v1 = nil
        local v2 = nil
        local v3 = p1
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            if j.Config then
                if j.Name == "Focus" then
                    v1 = j
                elseif j.Config.IsTwoHandedAbility and j.Ammo and 0 < j.Ammo and not v2 then
                    v2 = j
                end
            end
        end
        u198 = v2
        u302:SetFocusAbility(v1)
        if v1 or not v2 then
            if not v1 and not v2 and u199 ~= "twohanded" then
                u140:set(false)
                u199 = "none"
            end
            return
        end
        if u199 ~= "twohanded" then
            switchToTwoHandedDisplay(v2)
            updateAbilityState()
            return
        end
        if not v1 and not v2 and u199 ~= "twohanded" then
            u140:set(false)
            u199 = "none"
        end
    end)
    u206.WeaponEquipped:Connect(function(p1) -- Line: 636 -- upvalues: u302 (upval), u199 (upval)
        if not p1 or not p1.Config then
            if u199 == "twohanded" then
                u302:SetTwoHandedAbility(nil)
            end
            return
        end
        if p1.Config.IsTwoHandedAbility then
            u302:SetTwoHandedAbility(p1)
            return
        end
        if u199 == "twohanded" then
            u302:SetTwoHandedAbility(nil)
        end
    end)
    u206.WeaponUnequipped:Connect(function() -- Line: 647 -- upvalues: u199 (upval), u302 (upval)
        if u199 == "twohanded" then
            u302:SetTwoHandedAbility(nil)
        end
    end)
    u206.AmmoChanged:Connect(function() -- Line: 654 -- upvalues: updateAbilityState (upval)
        updateAbilityState()
    end)
    local Remotes = ReplicatedStorage.common:WaitForChild("Remotes")
    Remotes:WaitForChild("Net").OnClientEvent:Connect(function(p1, p2) -- Line: 660 -- upvalues: u182 (upval), u199 (upval), updateAbilityState (upval)
        if p1 == "FocusMeter" then
            u182:set(p2)
            if u199 == "focus" then
                updateAbilityState()
            end
        end
    end)
end)
task.spawn(function() -- Line: 671 -- upvalues: LocalPlayerController (val), RunService (val), u199 (ref), u302 (val), u203 (ref), u204 (ref), u195 (ref), peek (val), u120 (val), u197 (ref), updateAbilityState (val)
    local FocusEnabled = LocalPlayerController.FocusEnabled
    local u2 = false
    local u3 = false
    RunService.Heartbeat:Connect(function() -- Line: 676 -- upvalues: LocalPlayerController (upval), FocusEnabled (ref), u199 (upval), u302 (upval), u203 (upval), u204 (upval), u195 (upval), u2 (ref), peek (upval), u120 (upval), u197 (upval), u3 (ref), updateAbilityState (upval)
        local v1
        local FocusEnabled_2 = LocalPlayerController.FocusEnabled
        if FocusEnabled_2 ~= FocusEnabled then
            FocusEnabled = FocusEnabled_2
            if u199 ~= "focus" then
                if u199 == "twohanded" and not FocusEnabled_2 then
                    u203 = false
                    u204 = 0
                end
            elseif not FocusEnabled_2 then
                u302:SetActive(false)
            else
                u302:SetActive(true)
            end
        end
        if u195 and u199 == "focus" then
            v1 = u195:IsActivating()
            if v1 ~= u2 then
                u2 = v1
                if v1 then
                    u302:StartActivating()
                elseif not (peek(u120)) then
                    u302:CancelActivating()
                end
            end
        end
        if not u197 or u199 ~= "twohanded" then
            return
        end
        v1 = u197:IsActivating() or false
        if v1 == u3 then
            return
        end
        u3 = v1
        if v1 then
            u302:StartActivating()
            return
        end
        u302:CancelActivating()
        updateAbilityState()
    end)
end)
updateMobilePlacement()
task.spawn(function() -- Line: 747 -- upvalues: LocalPlayer (val), u205 (ref), peek (val), u132 (val), u148 (val)
    local AmmoUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("AmmoUI", 10)
    if AmmoUI then
        u205 = AmmoUI
        local Ammo = AmmoUI:FindFirstChild("Ammo")
        if Ammo then
            if peek(u132) then
                u148:set(Ammo.AbsoluteSize.X)
            end
            local PropertyChangedSignal = Ammo:GetPropertyChangedSignal("AbsoluteSize")
            PropertyChangedSignal:Connect(function() -- Line: 759 -- upvalues: peek (upval), u132 (upval), u148 (upval), Ammo (val)
                if peek(u132) then
                    u148:set(Ammo.AbsoluteSize.X)
                end
            end)
        end
    end
end)
return u302