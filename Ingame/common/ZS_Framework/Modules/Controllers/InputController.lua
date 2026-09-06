local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Classes = script.Parent.Parent:WaitForChild("Classes")
script.Parent.Parent:WaitForChild("Utils")
local Controllers = script.Parent.Parent:WaitForChild("Controllers")
local GuiService = game:GetService("GuiService")
local common = ReplicatedStorage.common
local peek = require(ReplicatedStorage.Packages.Fusion).peek
local BindUtil = require(common:WaitForChild("BindUtil"))
local WeaponController = require(Controllers:WaitForChild("WeaponController"))
local LocalPlayerController = require(Controllers:WaitForChild("LocalPlayerController"))
local CameraController = require(Controllers.CameraController)
local HUDService = require(common:WaitForChild("HUDService"))
local Settings = require(common.Settings)
local Binding = require(common.Settings.Binding)
local ProximityPromptZS = require(common.ProximityPromptZS)
local HUDOverlayController = require(Controllers:WaitForChild("HUDOverlayController"))
local NVGs = require(Classes.Viewmodel.ViewmodelUtils:WaitForChild("NVGs"))
local QuickChatController = require(Controllers.QuickChatController)
local GamepadService = game:GetService("GamepadService")
local u96 = false
local u98 = BindUtil.getInputMethod()
local u99 = false
local u100 = nil
local v1 = {}
local u102 = nil
local function getDialogueSystem() -- Line: 41 -- upvalues: u102 (ref), common (val)
    local v1, v2
    if u102 ~= nil then
        return u102
    end
    local DialogueSystem = common:FindFirstChild("DialogueSystem")
    if not DialogueSystem or not (DialogueSystem:IsA("ModuleScript")) then
        return nil
    end
    v1, v2 = pcall(require, DialogueSystem)
    if not v1 then
        return nil
    end
    u102 = v2
    return u102
end
local function isDialogueBlockingGameplayInput() -- Line: 56 -- upvalues: u102 (ref), common (val)
    local v1
    if u102 ~= nil then
        v1 = u102
    else
        local DialogueSystem = common:FindFirstChild("DialogueSystem")
        if not DialogueSystem then
            v1 = nil
        elseif DialogueSystem:IsA("ModuleScript") then
            local v2, v3
            v2, v3 = pcall(require, DialogueSystem)
            if v2 then
                u102 = v3
                v1 = u102
            else
                v1 = nil
            end
        else
            v1 = nil
        end
    end
    if not v1 then
        return false
    end
    if v1.BlocksGameplayInput then
        return v1.BlocksGameplayInput()
    end
    return v1.IsActive()
end
local function isDialogueActive() -- Line: 67 -- upvalues: u102 (ref), common (val)
    local v1
    if u102 ~= nil then
        v1 = u102
    else
        local DialogueSystem = common:FindFirstChild("DialogueSystem")
        if not DialogueSystem then
            v1 = nil
        elseif DialogueSystem:IsA("ModuleScript") then
            local v2, v3
            v2, v3 = pcall(require, DialogueSystem)
            if v2 then
                u102 = v3
                v1 = u102
            else
                v1 = nil
            end
        else
            v1 = nil
        end
    end
    local IsActive = false
    if v1 ~= nil then
        IsActive = v1.IsActive
        if IsActive then
            IsActive = v1.IsActive()
        end
    end
    return IsActive
end
function v1.Init(p1) -- Line: 72 -- upvalues: u102 (ref), common (val), u100 (ref), u99 (ref), GamepadService (val), BindUtil (val), ProximityPromptZS (val), WeaponController (val), peek (val), Settings (val), HUDService (val), LocalPlayerController (val), CameraController (val), HUDOverlayController (val), NVGs (val), QuickChatController (val)
    local DialogueSystem, v1, v2, v3
    if u102 ~= nil then
        v1 = u102
    else
        DialogueSystem = common:FindFirstChild("DialogueSystem")
        if not DialogueSystem then
            v1 = nil
        elseif DialogueSystem:IsA("ModuleScript") then
            v2, v3 = pcall(require, DialogueSystem)
            if v2 then
                u102 = v3
                v1 = u102
            else
                v1 = nil
            end
        else
            v1 = nil
        end
    end
    if v1 and v1.ActiveChanged then
        v1.ActiveChanged:Connect(function() -- Line: 75 -- upvalues: u100 (upval), u99 (upval), u102 (upval), common (upval), GamepadService (upval)
            u100()
            if u99 then
                local v1
                if u102 ~= nil then
                    v1 = u102
                else
                    local DialogueSystem = common:FindFirstChild("DialogueSystem")
                    if not DialogueSystem then
                        v1 = nil
                    elseif DialogueSystem:IsA("ModuleScript") then
                        local v2, v3
                        v2, v3 = pcall(require, DialogueSystem)
                        if v2 then
                            u102 = v3
                        else
                            v1 = nil
                        end
                    end
                end
                local IsActive = false
                if v1 ~= nil then
                    IsActive = v1.IsActive
                    if IsActive then
                        IsActive = v1.IsActive()
                    end
                end
                if not IsActive then
                    GamepadService:EnableGamepadCursor(nil)
                end
            end
        end)
    end
    BindUtil.new("Reload", function(p1, p2) -- Line: 84 -- upvalues: BindUtil (upval), ProximityPromptZS (upval), u102 (upval), common (upval), WeaponController (upval)
        if BindUtil.getInputMethod() ~= "Gamepad" then
            if not p2 then
                local v1, v2
                if u102 ~= nil then
                    v2 = u102
                else
                    local DialogueSystem = common:FindFirstChild("DialogueSystem")
                    if not DialogueSystem then
                        v2 = nil
                    elseif DialogueSystem:IsA("ModuleScript") then
                        local v3, v4
                        v3, v4 = pcall(require, DialogueSystem)
                        if v3 then
                            u102 = v4
                        else
                            v2 = nil
                        end
                    end
                end
                if not v2 then
                    v1 = false
                elseif not v2.BlocksGameplayInput then
                    v1 = v2.IsActive()
                else
                    v1 = v2.BlocksGameplayInput()
                end
                if not v1 then
                    WeaponController:Reload()
                end
            end
            return
        elseif ProximityPromptZS.openedPrompt ~= nil then
            return
        end
    end)
    BindUtil.new("Swap", function(p1, p2, p3) -- Line: 93 -- upvalues: u102 (upval), common (upval), BindUtil (upval), WeaponController (upval)
        local v1, v2
        if p2 then
            return
        end
        if u102 ~= nil then
            v2 = u102
        else
            local DialogueSystem = common:FindFirstChild("DialogueSystem")
            if not DialogueSystem then
                v2 = nil
            elseif DialogueSystem:IsA("ModuleScript") then
                local v3, v4
                v3, v4 = pcall(require, DialogueSystem)
                if v3 then
                    u102 = v4
                else
                    v2 = nil
                end
            end
        end
        if not v2 then
            v1 = false
        elseif not v2.BlocksGameplayInput then
            v1 = v2.IsActive()
        else
            v1 = v2.BlocksGameplayInput()
        end
        if v1 then
            return
        end
        if not p3 then
            WeaponController:SwapWeapon(p1)
            return
        end
        local OffHandUse = BindUtil.getActionBinds("OffHandUse")
        if not OffHandUse then
            WeaponController:SwapWeapon(p1)
            return
        end
        if OffHandUse[p3.KeyCode] then
            return
        end
        WeaponController:SwapWeapon(p1)
    end)
    BindUtil.new("XboxSwap", function(p1, p2) -- Line: 106 -- upvalues: u102 (upval), common (upval), peek (upval), Settings (upval), HUDService (upval), WeaponController (upval)
        local v1, v2
        if p2 then
            return
        end
        if u102 ~= nil then
            v2 = u102
        else
            local DialogueSystem = common:FindFirstChild("DialogueSystem")
            if not DialogueSystem then
                v2 = nil
            elseif DialogueSystem:IsA("ModuleScript") then
                local v3, v4
                v3, v4 = pcall(require, DialogueSystem)
                if v3 then
                    u102 = v4
                else
                    v2 = nil
                end
            end
        end
        if not v2 then
            v1 = false
        elseif not v2.BlocksGameplayInput then
            v1 = v2.IsActive()
        else
            v1 = v2.BlocksGameplayInput()
        end
        if v1 then
            return
        end
        if peek(Settings.Controls.GamepadSelectionMode) ~= 2 then
            if p1 ~= "Left" then
                v1 = 1
            else
                v1 = -1
            end
            WeaponController:SwapWeaponXbox(v1)
            return
        end
        local Element = HUDService:GetElement("DPadSelection")
        if not Element then
            return
        end
        v2 = Element:Interact(p1)
        if not v2 then
            return
        end
        local HotbarSlot = Element:GetHotbarSlot(v2)
        WeaponController:SwapWeapon(HotbarSlot, nil)
    end)
    BindUtil.new("PrimaryAttack", function(p1, p2) -- Line: 123 -- upvalues: WeaponController (upval)
        if not p2 then
            WeaponController.PrimaryAttackDown = true
        end
    end, function(p1, p2) -- Line: 127 -- upvalues: WeaponController (upval)
        WeaponController.PrimaryAttackDown = false
    end)
    BindUtil.new("SecondaryAttack", function(p1, p2) -- Line: 131 -- upvalues: WeaponController (upval)
        if not p2 then
            WeaponController.SecondaryAttackDown = true
        end
    end, function(p1, p2) -- Line: 135 -- upvalues: WeaponController (upval)
        WeaponController.SecondaryAttackDown = false
    end)
    BindUtil.new("ToggleSecondaryAttack", function(p1, p2) -- Line: 139 -- upvalues: WeaponController (upval)
        if not p2 then
            WeaponController.SecondaryAttackDown = not WeaponController.SecondaryAttackDown
        end
    end)
    BindUtil.new("Firemode", function(p1, p2) -- Line: 145 -- upvalues: WeaponController (upval)
        if not p2 then
            WeaponController:CycleFiremode()
        end
    end)
    BindUtil.new("QuickMeleeAndBlock", function(p1, p2) -- Line: 151 -- upvalues: LocalPlayerController (upval)
        if not p2 then
            LocalPlayerController.BlockPressed = true
        end
    end, function(p1, p2) -- Line: 155 -- upvalues: LocalPlayerController (upval)
        LocalPlayerController.BlockPressed = false
    end)
    BindUtil.new("OffHandUse", function(p1, p2) -- Line: 160 -- upvalues: LocalPlayerController (upval), WeaponController (upval)
        if not p2 then
            LocalPlayerController.OffHandPressed = true
            WeaponController:UseOffHand()
        end
    end, function(p1, p2) -- Line: 165 -- upvalues: LocalPlayerController (upval), WeaponController (upval)
        LocalPlayerController.OffHandPressed = false
        WeaponController:CancelOffHand()
    end)
    local function startSprint() -- Line: 170 -- upvalues: WeaponController (upval), LocalPlayerController (upval)
        WeaponController.SecondaryAttackDown = false
        LocalPlayerController.CrouchPressed = false
        LocalPlayerController.PronePressed = false
        if LocalPlayerController.States.Sliding then
            LocalPlayerController.RequestCancel = true
        end
    end
    BindUtil.new("SprintHold", function(p1, p2) -- Line: 179 -- upvalues: LocalPlayerController (upval), WeaponController (upval)
        if not p2 then
            LocalPlayerController.SprintPressed = true
            WeaponController.SecondaryAttackDown = false
            LocalPlayerController.CrouchPressed = false
            LocalPlayerController.PronePressed = false
            if LocalPlayerController.States.Sliding then
                LocalPlayerController.RequestCancel = true
            end
        end
    end, function(p1, p2) -- Line: 184 -- upvalues: LocalPlayerController (upval)
        LocalPlayerController.SprintPressed = false
    end)
    BindUtil.new("SprintToggle", function(p1, p2) -- Line: 188 -- upvalues: LocalPlayerController (upval), WeaponController (upval)
        if not p2 then
            LocalPlayerController.SprintPressed = not LocalPlayerController.SprintPressed
            if LocalPlayerController.SprintPressed then
                WeaponController.SecondaryAttackDown = false
                LocalPlayerController.CrouchPressed = false
                LocalPlayerController.PronePressed = false
                if LocalPlayerController.States.Sliding then
                    LocalPlayerController.RequestCancel = true
                end
            end
        end
    end)
    BindUtil.new("Thirdperson", function(p1, p2) -- Line: 197 -- upvalues: CameraController (upval), BindUtil (upval), LocalPlayerController (upval)
        if not CameraController.Enabled then
            return
        end
        if not p2 then
            LocalPlayerController.TPPressed = true
        elseif BindUtil.getInputMethod() == "Gamepad" then
            LocalPlayerController.TPPressed = true
        end
    end, function(p1, p2) -- Line: 207 -- upvalues: LocalPlayerController (upval)
        LocalPlayerController.TPPressed = false
    end)
    BindUtil.new("CrouchToggle", function(p1, p2) -- Line: 211 -- upvalues: LocalPlayerController (upval)
        if not p2 then
            LocalPlayerController.CrouchPressed = not LocalPlayerController.CrouchPressed
        end
    end)
    local u98 = nil
    BindUtil.new("CrouchProneToggle", function(p1, p2) -- Line: 219 -- upvalues: u98 (ref), LocalPlayerController (upval)
        if not p2 then
            u98 = true
            task.spawn(function() -- Line: 222 -- upvalues: u98 (upval), LocalPlayerController (upval)
                local v1 = 0
                while u98 do
                    if v1 >= 0.25 then
                        break
                    end
                    v1 = v1 + task.wait()
                end
                if v1 < 0.25 then
                    LocalPlayerController.CrouchPressed = not LocalPlayerController.CrouchPressed
                    return
                end
                LocalPlayerController.PronePressed = not LocalPlayerController.PronePressed
            end)
        end
    end, function(p1, p2) -- Line: 234 -- upvalues: u98 (ref)
        u98 = false
    end)
    BindUtil.new("DiveAndProneToggle", function(p1, p2) -- Line: 238 -- upvalues: LocalPlayerController (upval)
        if not p2 and not LocalPlayerController.States.Diving then
            LocalPlayerController.PronePressed = not LocalPlayerController.PronePressed
        end
    end)
    BindUtil.new("CrouchHold", function(p1, p2) -- Line: 244 -- upvalues: LocalPlayerController (upval)
        if not p2 then
            LocalPlayerController.CrouchPressed = true
        end
    end, function(p1, p2) -- Line: 251 -- upvalues: LocalPlayerController (upval)
        LocalPlayerController.CrouchPressed = false
    end)
    BindUtil.new("ProneToggle", function(p1, p2) -- Line: 255 -- upvalues: LocalPlayerController (upval)
        if not p2 and not LocalPlayerController.States.Diving then
            LocalPlayerController.PronePressed = not LocalPlayerController.PronePressed
        end
    end)
    BindUtil.new("LeaderboardToggle", function(p1, p2) -- Line: 261 -- upvalues: HUDOverlayController (upval)
        if not p2 then
            HUDOverlayController:SetVisible(not HUDOverlayController:IsVisible())
        end
    end)
    BindUtil.new("LeaderboardHold", function(p1, p2) -- Line: 267 -- upvalues: HUDOverlayController (upval)
        if not p2 then
            HUDOverlayController:SetVisible(true)
        end
    end, function(p1, p2) -- Line: 271 -- upvalues: HUDOverlayController (upval)
        HUDOverlayController:SetVisible(false)
    end)
    BindUtil.new("ToggleControlHints", function(p1, p2) -- Line: 275 -- upvalues: HUDService (upval)
        if p2 then
            return
        end
        local Element = HUDService:GetElement("ControlHints")
        if Element then
            Element:Toggle()
        end
    end)
    BindUtil.new("VirtualCursor", function(p1, p2) -- Line: 286 -- upvalues: GamepadService (upval)
        if not (workspace:FindFirstChild("Values")) or not (workspace.Values:FindFirstChild("IsLobby")) or not workspace.Values.IsLobby.Value or p2 then
            return
        end
        if not GamepadService.GamepadCursorEnabled then
            game.GamepadService:EnableGamepadCursor(nil)
            return
        end
        game.GamepadService:DisableGamepadCursor()
    end, function() end)
    NVGs.Init()
    BindUtil.new("NVGToggle", function(p1, p2) -- Line: 312 -- upvalues: NVGs (upval)
        if p2 then
            return
        end
        if not (workspace:FindFirstChild("Values")) or not (workspace.Values:FindFirstChild("IsLobby")) then
            NVGs.ToggleActivate()
            return
        end
        if workspace.Values.IsLobby.Value == true then
            return
        end
        NVGs.ToggleActivate()
    end)
    QuickChatController.Init()
    BindUtil.new("QuickChat", function(p1, p2) -- Line: 328 -- upvalues: QuickChatController (upval), BindUtil (upval), LocalPlayerController (upval), CameraController (upval)
        if p2 then
            return
        else
            if QuickChatController.IsDisabled() then
                return
            end
            if not (workspace:FindFirstChild("Values")) then
                if QuickChatController.Cooldown then
                    return
                end
                QuickChatController.Activated = not QuickChatController.Activated
                local v1 = BindUtil.getInputMethod() == "Gamepad"
                QuickChatController.ToggleActivate(QuickChatController.Activated, v1)
                if not v1 then
                    LocalPlayerController:SetMovementEnabled(not QuickChatController.Activated)
                end
                CameraController:SetEnabled(not QuickChatController.Activated)
                return
            elseif workspace.Values:FindFirstChild("IsLobby") and workspace.Values.IsLobby.Value == true then
                return
            end
        end
    end)
    local UserInputService = game:GetService("UserInputService")
    local u166 = os.clock() + 1
    UserInputService.JumpRequest:Connect(function() -- Line: 360 -- upvalues: LocalPlayerController (upval), u166 (ref)
        if LocalPlayerController.States.Sliding then
            LocalPlayerController.RequestSlideJump = true
            return
        end
        local Humanoid = LocalPlayerController.humanoid.Humanoid
        if LocalPlayerController.States.IsDead or LocalPlayerController.States.IsDowned then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            return
        end
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        if Humanoid.Sit or Humanoid.SeatPart ~= nil then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            Humanoid.Jump = true
            return
        end
        if LocalPlayerController.States.Diving then
            return
        end
        if LocalPlayerController.PronePressed then
            LocalPlayerController.PronePressed = false
            LocalPlayerController.CrouchPressed = true
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            return
        end
        if LocalPlayerController.CrouchPressed then
            LocalPlayerController.CrouchPressed = false
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            return
        end
        LocalPlayerController.RequestVault = true
        if Humanoid.FloorMaterial == Enum.Material.Air or os.clock() < u166 then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            return
        end
        u166 = os.clock() + 0.05
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end)
end
task.spawn(function() -- Line: 399 -- upvalues: GuiService (val), u99 (ref), u102 (ref), common (val), GamepadService (val)
    local v1
    if not (workspace:FindFirstChild("Values")) or not (workspace.Values:FindFirstChild("IsLobby")) or not workspace.Values.IsLobby.Value then
        return
    end
    GuiService.GuiNavigationEnabled = false
    GuiService.AutoSelectGuiEnabled = false
    u99 = true
    if u102 ~= nil then
        v1 = u102
    else
        local DialogueSystem = common:FindFirstChild("DialogueSystem")
        if not DialogueSystem then
            v1 = nil
        elseif DialogueSystem:IsA("ModuleScript") then
            local v2, v3
            v2, v3 = pcall(require, DialogueSystem)
            if v2 then
                u102 = v3
            else
                v1 = nil
            end
        end
    end
    local IsActive = false
    if v1 ~= nil then
        IsActive = v1.IsActive
        if IsActive then
            IsActive = v1.IsActive()
        end
    end
    if not IsActive then
        GamepadService:EnableGamepadCursor(nil)
    end
end)
function v1.SetupBinds(p1) -- Line: 421 -- upvalues: BindUtil (val), peek (val), Settings (val)
    local v1, v2, v3
    BindUtil.unbindAllActions()
    BindUtil.bind(Enum.KeyCode.One, "Swap", 1)
    BindUtil.bind(Enum.KeyCode.Two, "Swap", 2)
    BindUtil.bind(Enum.KeyCode.Three, "Swap", 3)
    BindUtil.bind(Enum.KeyCode.Four, "Swap", 4)
    BindUtil.bind(Enum.KeyCode.Five, "Swap", 5)
    BindUtil.bind(Enum.KeyCode.Six, "Swap", 6)
    BindUtil.bind(Enum.KeyCode.Seven, "Swap", 7)
    BindUtil.bind(Enum.KeyCode.Eight, "Swap", 8)
    BindUtil.bind(Enum.KeyCode.Nine, "Swap", 9)
    BindUtil.bind(Enum.KeyCode.Zero, "Swap", 0)
    BindUtil.bind(Enum.KeyCode.DPadLeft, "XboxSwap", "Left")
    BindUtil.bind(Enum.KeyCode.DPadRight, "XboxSwap", "Right")
    if peek(Settings.Controls.GamepadSelectionMode) == 2 then
        BindUtil.bind(Enum.KeyCode.DPadUp, "XboxSwap", "Up")
        BindUtil.bind(Enum.KeyCode.DPadDown, "XboxSwap", "Down")
    end
    BindUtil.bind(Enum.KeyCode.ButtonSelect, "VirtualCursor", "Select")
    local Binds = Settings.Controls.Binds
    local v4 = nil
    local v5 = nil
    for i, j in Binds, v4, v5 do
        v1 = j
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            BindUtil.bind(n, i)
        end
    end
end
function u100() -- Line: 454 -- upvalues: HUDService (val), u96 (ref), u98 (ref), u102 (ref), common (val)
    if not HUDService.Visible then
        local v1
        if u98 ~= "Gamepad" then
            game.GamepadService:DisableGamepadCursor()
            return
        end
        if u102 ~= nil then
            v1 = u102
        else
            local DialogueSystem = common:FindFirstChild("DialogueSystem")
            if not DialogueSystem then
                v1 = nil
            elseif DialogueSystem:IsA("ModuleScript") then
                local v2, v3
                v2, v3 = pcall(require, DialogueSystem)
                if v2 then
                    u102 = v3
                else
                    v1 = nil
                end
            end
        end
        local IsActive = false
        if v1 ~= nil then
            IsActive = v1.IsActive
            if IsActive then
                IsActive = v1.IsActive()
            end
        end
        if not IsActive then
            game.GamepadService:EnableGamepadCursor(nil)
            return
        end
        game.GamepadService:DisableGamepadCursor()
        return
    elseif not u96 then
        game.GamepadService:DisableGamepadCursor()
        return
    end
end
Binding.BindingChanged:Connect(function(p1, p2, p3, p4) -- Line: 462 -- upvalues: BindUtil (val)
    BindUtil.unbindActionInput(p1, p3)
    if p4 then
        BindUtil.bind(p4, p1)
    end
end)
BindUtil.InputMethodChanged:Connect(function(p1) -- Line: 469 -- upvalues: u98 (ref), WeaponController (val), u100 (ref), u99 (ref), u102 (ref), common (val), GamepadService (val)
    u98 = p1
    WeaponController:SetInputMethod(p1)
    u100()
    if u99 then
        local v1
        if u102 ~= nil then
            v1 = u102
        else
            local DialogueSystem = common:FindFirstChild("DialogueSystem")
            if not DialogueSystem then
                v1 = nil
            elseif DialogueSystem:IsA("ModuleScript") then
                local v2, v3
                v2, v3 = pcall(require, DialogueSystem)
                if v2 then
                    u102 = v3
                else
                    v1 = nil
                end
            end
        end
        local IsActive = false
        if v1 ~= nil then
            IsActive = v1.IsActive
            if IsActive then
                IsActive = v1.IsActive()
            end
        end
        if not IsActive then
            GamepadService:EnableGamepadCursor(nil)
        end
    end
end)
Settings.OpenChanged:Connect(function(p1) -- Line: 479 -- upvalues: u96 (ref), u100 (ref)
    u96 = p1
    u100()
end)
HUDService.VisibilityChanged:Connect(u100)
Settings.SettingsChanged:Connect(function(p1) -- Line: 486 -- upvalues: peek (val), Settings (val), BindUtil (val)
    if not p1 or p1[1] ~= "Controls" or p1[2] ~= "GamepadSelectionMode" then
        return
    end
    if peek(Settings.Controls.GamepadSelectionMode) == 2 then
        BindUtil.bind(Enum.KeyCode.DPadUp, "XboxSwap", "Up")
        BindUtil.bind(Enum.KeyCode.DPadDown, "XboxSwap", "Down")
        return
    end
    BindUtil.unbindActionInput("XboxSwap", Enum.KeyCode.DPadUp)
    BindUtil.unbindActionInput("XboxSwap", Enum.KeyCode.DPadDown)
end)
return v1