local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local common = ReplicatedStorage.common
local SharedResources = ReplicatedStorage.common.SharedResources
local RedEvents = ReplicatedStorage.common.RedEvents
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
workspace:WaitForChild("Ignore")
local Parent = script.Parent
local Classes = Parent.Parent:WaitForChild("Classes")
local Utils = Parent.Parent:WaitForChild("Utils")
local Shared = Parent.Parent:WaitForChild("Shared")
local Resources = script:WaitForChild("Resources")
local Dry = Resources:FindFirstChild("Dry")
local WeaponControllerUtils = script:WaitForChild("WeaponControllerUtils")
;(ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("Net")
local LocalPlayerController = require(Parent:WaitForChild("LocalPlayerController"))
local CameraController = require(Parent:WaitForChild("CameraController"))
local v1 = require("@game/ReplicatedStorage/common/Signal")
local HUDService = require(common:WaitForChild("HUDService"))
local Weapon = require(Classes:WaitForChild("Weapon"))
local BindUtil = require(common:WaitForChild("BindUtil"))
local SoundUtil = require(Utils:WaitForChild("SoundUtil"))
local SharedSprings = require(Shared:WaitForChild("SharedSprings"))
local Melee = require(WeaponControllerUtils:WaitForChild("Melee"))
local AutoShoot = require(WeaponControllerUtils.AutoShoot)
local Settings = require(common.Settings)
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local LoopSFX = require(WeaponControllerUtils.LoopSFX)
require(SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local ShellSystem = require(Classes.Viewmodel.ViewmodelUtils.ShellSystem)
local ViewmodelManager = require(Parent.ViewmodelManager)
local QuickSwap = require(WeaponControllerUtils.QuickSwap)
local DualWield = require(WeaponControllerUtils.DualWield)
local OffHand = require(WeaponControllerUtils.OffHand)
local OffHandChecks = require(WeaponControllerUtils.OffHandChecks)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local FrameworkEvents = require(RedEvents.Framework.FrameworkEvents)
local humanoid = LocalPlayerController.humanoid
local u185 = nil
local u186 = nil
local u187 = nil
local u188 = nil
local u189 = nil
local u190 = nil
local u191 = nil
local u192 = nil
local u193 = nil
local u194 = nil
local u195 = {}
local u196 = {}
local u197 = {X = 0, Y = 0}
local CancelReload = FrameworkEvents.CancelReload
local Equipped = FrameworkEvents.Equipped
local WeaponUse = FrameworkEvents.WeaponUse
local u201 = {}
local u202 = nil
local u203 = nil
local u204 = nil
local u205 = nil
local u206 = nil
local u207 = nil
local u208 = nil
local u209 = false
local u210 = nil
local v2 = Enum.RenderPriority.Input.Value + 1
local u214 = {}
u214.EquippedSlot = v1.new()
u214.FireModeChanged = v1.new()
u214.WeaponEquipped = v1.new()
u214.WeaponUnequipped = v1.new()
u214.XPChanged = v1.new()
u214.AmmoChanged = v1.new()
u214.InventoryChanged = v1.new()
u214.Reloaded = v1.new()
u214.TargetChanged = v1.new()
u214.InaccuracyUpdated = v1.new()
u214.GunFired = v1.new()

local function initializeModules() -- Line: 101
    -- upvalues: LocalPlayerController (val), u195 (val), u185 (ref), Equipped (val), u214 (val), u188 (ref)
    -- upvalues: OffHand (val), QuickSwap (val), DualWield (val)
    local v1 = {
        LPC = LocalPlayerController,
        Inventory = u195,
        CurrentWeaponGetter = function() -- Line: 105 -- upvalues: u185 (upval)
            return u185
        end,
        CurrentWeaponSetter = function(p1) -- Line: 106 -- upvalues: u185 (upval)
            u185 = p1
        end,
        EquippedEvent = Equipped,
        WeaponEquippedSignal = u214.WeaponEquipped,
        AmmoChangedSignal = u214.AmmoChanged,
        SetSwappingDisabled = function(p1) -- Line: 110 -- upvalues: u188 (upval)
            u188 = p1
        end,
        OffHand = OffHand,
    }
    QuickSwap:Init(v1)
    v1.QuickSwapModule = QuickSwap
    DualWield:Init(v1)
    v1.DualWieldModule = DualWield
    OffHand:Init(v1)
end

local function GetActiveWeapons() -- Line: 124 -- upvalues: DualWield (val)
    return DualWield:GetActiveWeapons()
end

function u214.Parried(p1) -- Line: 128
    -- upvalues: u185 (ref), Fusion (val), SkillTreeData (val), CameraController (val)
    if u185 then
        u185.Parried = true
        local v1 = Fusion.peek(SkillTreeData.ParryWindowBonus) or 0
        u185.ParryTime = os.clock() + (u185.Config.ParryWindow * 2 or 0) + v1
        if u185.Config.Parried then
            u185.Config.Parried(u185)
        end
        local v2 = CameraController
        local CameraShaker = v2.CameraShaker
        local v3 = Vector3.new()
        CameraShaker:ShakeOnce(7, 7, 0, 1, v3, (Vector3.new(1, 1, 1)))
    end
end

function u214.Blocked(p1) -- Line: 141 -- upvalues: u185 (ref), SoundUtil (val), CameraController (val)
    if u185 then
        if u185.Config.Blocked then
            u185.Config.Blocked(u185)
        end
        local v1 = SoundUtil
        local BlockSFX = u185.Config.BlockSFX
        if not BlockSFX then
            BlockSFX = {SoundId = "7058511525"}
        end
        v1:PlaySound(BlockSFX)
        v1 = CameraController
        local CameraShaker = v1.CameraShaker
        local v2 = Vector3.new()
        CameraShaker:ShakeOnce(7, 7, 0, 1, v2, (Vector3.new(1, 1, 1)))
    end
end

function u214.GetTotalHotbarSlots(p1) -- Line: 151 -- upvalues: u196 (val)
    if u196 then
        return #u196
    end
    return 0
end

function u214.GetEquippedSlot(p1) -- Line: 158 -- upvalues: u197 (val)
    if u197 then
        return u197.X
    end
    return 0
end

function u214.SwapWeaponXbox(p1, p2) -- Line: 165
    -- upvalues: LocalPlayerController (val), Fusion (val), SkillTreeData (val), u196 (val), u187 (ref), u214 (val)
    -- upvalues: u197 (val)
    local CannotSwapTo, CannotSwapTo_2, v1, v2, v3
    if LocalPlayerController.States.IsDead then
        return
    end
    local IsDowned = LocalPlayerController.States.IsDowned
    if IsDowned then
        IsDowned = Fusion.peek(SkillTreeData.HasLastStand)
    end
    if LocalPlayerController.States.IsDowned and not IsDowned then
        return
    end
    local v4 = {}
    if not IsDowned then
        v2 = 5
    else
        v2 = 2
    end
    local v5 = v2
    local v6 = p2
    for i = 1, v5 do
        if u196[i] and 0 < #u196[i] then
            for i2, v in ipairs(u196[i]) do
                CannotSwapTo_2 = false
                if v.Config and v.Config.CannotSwapTo then
                    CannotSwapTo = v.Config.CannotSwapTo
                    if type(CannotSwapTo) ~= "function" then
                        CannotSwapTo_2 = v.Config.CannotSwapTo
                    else
                        CannotSwapTo_2 = v.Config:CannotSwapTo(v)
                    end
                end
                if not CannotSwapTo_2 then
                    v1 = {weapon = v, slotX = i, slotY = i2}
                    table.insert(v4, v1)
                end
            end
        end
    end
    if #v4 == 0 then
        u187 = nil
        u214.EquippedSlot:Fire(nil)
        u197.X = 0
        u197.Y = 0
        LocalPlayerController.BlockPressed = false
        return
    end
    v5 = nil
    for i3, j in ipairs(v4) do
        if j.slotX == u197.X and j.slotY == u197.Y then
            v5 = i3
            break
        end
    end
    if v5 then
        v3 = v5 + v6
        if #v4 < v3 then
            v3 = 1
        elseif v3 < 1 then
            v3 = #v4
        end
    else
        v3 = 1
    end
    local v7 = v4[v3]
    u197.X = v7.slotX
    u197.Y = v7.slotY
    u187 = v7.weapon.Slot
    local v8 = u214
    local EquippedSlot = v8.EquippedSlot
    local v9 = u187
    EquippedSlot:Fire(v9)
    LocalPlayerController.BlockPressed = false
end

function u214.SwapWeapon(p1, p2) -- Line: 244
    -- upvalues: LocalPlayerController (val), Fusion (val), SkillTreeData (val), u196 (val), u187 (ref), u214 (val)
    -- upvalues: u197 (val)
    local v1
    if LocalPlayerController.States.IsDead then
        return
    end
    if LocalPlayerController.States.IsDowned then
        if not Fusion.peek(SkillTreeData.HasLastStand) then
            return
        end
        v1 = tostring(p2)
        if v1 ~= "1" and v1 ~= "2" then
            return
        end
    end
    v1 = u196[p2]
    if v1 and #v1 ~= 0 then
        local CannotSwapTo, CannotSwapTo_2, EquippedSlot, v2, v3, v4, v5, v6, v7
        local v8 = #v1
        local v9 = u197.X == p2
        if not v9 then
            v6 = 1
        else
            v6 = u197.Y + 1
        end
        local v10 = v8 - 1
        for i = 0, v10 do
            v7 = v6 + i
            if v8 < v7 then
                if v9 then
                    u187 = nil
                    u214.EquippedSlot:Fire(nil)
                    u197.X = 0
                    u197.Y = 0
                    LocalPlayerController.BlockPressed = false
                    return
                end
                v7 = (v7 - 1) % v8 + 1
            end
            v3 = v1[v7]
            if v3 then
                CannotSwapTo_2 = false
                if v3.Config and v3.Config.CannotSwapTo then
                    CannotSwapTo = v3.Config.CannotSwapTo
                    if type(CannotSwapTo) ~= "function" then
                        CannotSwapTo_2 = v3.Config.CannotSwapTo
                    else
                        CannotSwapTo_2 = v3.Config:CannotSwapTo(v3)
                    end
                end
                if not CannotSwapTo_2 then
                    u197.X = v2
                    u197.Y = v7
                    u187 = v3.Slot
                    v4 = u214
                    EquippedSlot = v4.EquippedSlot
                    v5 = u187
                    EquippedSlot:Fire(v5)
                    LocalPlayerController.BlockPressed = false
                    return
                end
            end
        end
        LocalPlayerController.BlockPressed = false
        return
    end
    u187 = nil
    u214.EquippedSlot:Fire(nil)
    u197.X = 0
    u197.Y = 0
    LocalPlayerController.BlockPressed = false
end

function u214.ClassicWeaponSwap(p1, p2) -- Line: 324 -- upvalues: u193 (ref), u187 (ref), u195 (val), u214 (val)
    local CannotSwapTo, CannotSwapTo_2, HotbarSlot, v1, v2, v3, v4
    if not u193 then
        u193 = 1
    end
    if u187 then
        u193 = u193 + 1 * (p2 or 1)
    end
    local v5 = 0
    local v6 = #u195 + 1
    while v5 < v6 do
        if not u195[u193] then
            u193 = 1
        end
        if not u195[u193] then
            v2 = u214
            v3 = u193
            v2:SwapWeapon(v3)
            return
        else
            v2 = u195[u193]
            CannotSwapTo_2 = false
            if v2.Config and v2.Config.CannotSwapTo then
                CannotSwapTo = v2.Config.CannotSwapTo
                if type(CannotSwapTo) ~= "function" then
                    CannotSwapTo_2 = v2.Config.CannotSwapTo
                else
                    CannotSwapTo_2 = v2.Config:CannotSwapTo(v2)
                end
            end
            if not CannotSwapTo_2 then
                v3 = u214
                v4 = u195
                v1 = u193
                HotbarSlot = v4[v1].HotbarSlot
                v3:SwapWeapon(HotbarSlot)
                return
            else
                u193 = u193 + 1 * (v7 or 1)
                if u193 < 1 then
                    u193 = #u195
                end
                v5 = v5 + 1
            end
        end
    end
end

function u214.Reload(p1) -- Line: 368
    -- upvalues: QuickSwap (val), OffHand (val), DualWield (val), u185 (ref), LocalPlayerController (val)
    if QuickSwap:IsActive() then
        QuickSwap:Complete()
    end
    if OffHand:IsActive() then
        return
    end
    if DualWield:IsActive() then
        local v1 = DualWield:Reload()
        if v1 then
            u185 = DualWield:GetRightWeapon()
            LocalPlayerController.CurrentWeapon = u185
            LocalPlayerController:UpdateCurrentWeapon()
        end
        return
    end
    if u185 then
        local DelayPerShot = u185.Config.DelayPerShot
        if LocalPlayerController.FocusEnabled then
            DelayPerShot = DelayPerShot / 2
        end
        if u185.Config.PrimeAction then
            local v2 = os.clock() - DelayPerShot
            if not ((u185.LastShot or 0) <= v2) then
                return
            end
        end
        u185.Bursting = false
        u185.CurrentShot = 1
        u185:Reload()
    end
end

function u214.CycleFiremode(p1) -- Line: 404 -- upvalues: u185 (ref), u214 (val), SoundService (val), Resources (val)
    if u185 then
        local v1 = #u185.Config.FireMode
        if 1 < v1 and not u185.Bursting then
            v1 = u185
            v1.SelFireMode = v1.SelFireMode + 1
            if not u185.Config.FireMode[u185.SelFireMode] then
                u185.SelFireMode = 1
            end
            u185.FireMode = u185.Config.FireMode[u185.SelFireMode]
            v1 = u214
            local FireModeChanged = v1.FireModeChanged
            local v2 = u185
            local FireMode = v2.FireMode
            FireModeChanged:Fire(FireMode)
            u185.Viewmodel:ChangedFiremode()
            v1 = SoundService
            v2 = Resources
            local FireSelector = v2.FireSelector
            v1:PlayLocalSound(FireSelector)
        end
    end
end

function u214.ForceUnequip(p1) -- Line: 417
    -- upvalues: u185 (ref), DualWield (val), QuickSwap (val), u187 (ref), u214 (val)
    if u185 then
        local v1 = u185
        local v2 = DualWield:IsActive()
        local v3 = QuickSwap:IsActive()
        UnequipWeapon()
        if not v2 and not v3 and v1.IsEquipped ~= false then
            v1:ForceUnequip()
        end
        u187 = nil
        u214.EquippedSlot:Fire(nil)
    end
end

function u214.DisableSwapping(p1, p2) -- Line: 431 -- upvalues: u188 (ref)
    local v1
    if p2 == nil then
        v1 = true
    else
        v1 = not not p2
    end
    u188 = v1
end

function u214.SetWeaponsEnabled(p1, p2) -- Line: 435 -- upvalues: u214 (val)
    if p2 then
        u214:DisableSwapping(false)
        u214:SwapWeapon(1)
        return
    end
    u214:DisableSwapping(true)
    u214:ForceUnequip()
end

function u214.SetInputMethod(p1, p2) -- Line: 445 -- upvalues: u206 (ref)
    local v1 = p2 == "Touch"
    u206 = v1
end

local function findTwoHandedAbility() -- Line: 450 -- upvalues: u195 (val)
    local CannotSwapTo, CannotSwapTo_2
    local v1 = u195
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j.Config and j.Config.IsTwoHandedAbility then
            CannotSwapTo_2 = false
            if j.Config.CannotSwapTo then
                CannotSwapTo = j.Config.CannotSwapTo
                if type(CannotSwapTo) ~= "function" then
                    CannotSwapTo_2 = j.Config.CannotSwapTo
                else
                    CannotSwapTo_2 = j.Config:CannotSwapTo(j)
                end
            end
            if not CannotSwapTo_2 then
                return i
            end
        end
    end
    return nil
end

function u214.UseOffHand(p1) -- Line: 471
    -- upvalues: u185 (ref), u187 (ref), u186 (ref), WeaponUse (val), OffHand (val), OffHandChecks (val), u195 (val)
    -- upvalues: findTwoHandedAbility (val), u208 (ref), u210 (ref), u197 (val), u209 (ref), u196 (val), u214 (val)
    local v1, v2, v3, v4
    if u185 and u185.Config and u185.Config.IsTwoHandedAbility then
        if u187 and u187 ~= u185.Slot then
            return false
        end
        if u186 then
            return false
        end
        if u185.Config.Use then
            v1 = u185

            function v1.FireServerDeployEvent() -- Line: 485 -- upvalues: WeaponUse (upval)
                WeaponUse:FireServer()
            end

            v1 = u185
            local Config = v1.Config
            v3 = u185
            Config:Use(v3)
        end
        return true
    end
    if not OffHand:IsActive() and OffHandChecks.CanUseWithCurrentWeapon(u185) then
        v2 = u195
        v3 = nil
        v4 = nil
        for i, j in v2, v3, v4 do
            if OffHandChecks.CanUseItem(j, u185) and OffHand:UseItem(i) then
                return true
            end
        end
    end
    v1 = findTwoHandedAbility()
    if not v1 then
        return false
    end
    v2 = u195[v1]
    u208 = u187
    v3 = {X = u197.X, Y = u197.Y}
    u210 = v3
    u209 = true
    u187 = v1
    if v2 and v2.HotbarSlot then
        u197.X = v2.HotbarSlot
        u197.Y = 1
        if u196[v2.HotbarSlot] then
            v3 = u196[v2.HotbarSlot]
            v4 = nil
            local v5 = nil
            for k, n in v3, v4, v5 do
                if n == v2 then
                    u197.Y = k
                    break
                end
            end
        end
    end
    u214.EquippedSlot:Fire(v1)
    return true
end

function u214.CancelOffHand(p1) -- Line: 543
    -- upvalues: u209 (ref), u185 (ref), u187 (ref), u208 (ref), u214 (val), u210 (ref), u197 (val), OffHand (val)
    local v1, v2
    if not u209 then
        if OffHand:IsActive() then
            OffHand:Cancel()
            return true
        end
        return false
    end
    if u185 and u185.Config and u185.Config.CancelPreActivation then
        v1 = u185
        local Config = v1.Config
        v2 = u185
        Config:CancelPreActivation(v2)
    end
    u187 = u208
    v1 = u214
    local EquippedSlot = v1.EquippedSlot
    v2 = u208
    EquippedSlot:Fire(v2)
    if u210 then
        u197.X = u210.X
        u197.Y = u210.Y
    end
    u209 = false
    u208 = nil
    u210 = nil
    return true
end

function u214.GetCurrentWeapon(p1) -- Line: 573 -- upvalues: u185 (ref)
    return u185
end

function u214.StartQuickSwap(p1, p2) -- Line: 578 -- upvalues: QuickSwap (val)
    return QuickSwap:Start(p2)
end

function u214.CompleteQuickSwap(p1) -- Line: 582 -- upvalues: QuickSwap (val)
    return QuickSwap:Complete()
end

function u214.CancelQuickSwap(p1, p2) -- Line: 586 -- upvalues: QuickSwap (val)
    return QuickSwap:Cancel(p2)
end

function u214.IsQuickSwapActive(p1) -- Line: 590 -- upvalues: QuickSwap (val)
    return QuickSwap:IsActive()
end

function u214.StartDualWield(p1, p2) -- Line: 595 -- upvalues: DualWield (val)
    return DualWield:Start(p2)
end

function u214.StartDualWieldWithWeapons(p1, p2, p3) -- Line: 599 -- upvalues: DualWield (val)
    return DualWield:StartWithWeapons(p2, p3)
end

function u214.StopDualWield(p1) -- Line: 603 -- upvalues: DualWield (val)
    return DualWield:Stop()
end

function u214.IsDualWieldActive(p1) -- Line: 607 -- upvalues: DualWield (val)
    return DualWield:IsActive()
end

function u214.GetDualWieldWeapons(p1) -- Line: 611 -- upvalues: DualWield (val)
    return DualWield:GetWeapons()
end

function u214.DualWieldFire(p1) -- Line: 615 -- upvalues: DualWield (val)
    return DualWield:Fire()
end

function u214.DualWieldAlternate(p1) -- Line: 619 -- upvalues: DualWield (val)
    return DualWield:Alternate()
end

function u214.IsDualWieldAutoMode(p1) -- Line: 623 -- upvalues: DualWield (val)
    return DualWield:IsAutoMode()
end

function u214.DualWieldFireBoth(p1, p2, p3) -- Line: 627 -- upvalues: DualWield (val)
    return DualWield:FireBoth(p2, p3)
end

function u214.DualWieldReload(p1, p2) -- Line: 631 -- upvalues: DualWield (val)
    return DualWield:Reload(p2)
end

function u214.DualWieldAutoReload(p1, p2) -- Line: 635 -- upvalues: DualWield (val)
    return DualWield:AutoReload(p2)
end

function u214.DualWieldReloadComplete(p1, p2) -- Line: 639 -- upvalues: DualWield (val), u214 (val)
    DualWield:ReloadComplete(p2)
    u214.AmmoChanged:Fire(true)
end

function u214.UseOffHandItem(p1, p2) -- Line: 645 -- upvalues: OffHand (val)
    return OffHand:UseItem(p2)
end

function u214.CancelOffHandItem(p1) -- Line: 649 -- upvalues: OffHand (val)
    return OffHand:Cancel()
end

function u214.OffHandItemComplete(p1) -- Line: 653 -- upvalues: OffHand (val)
    return OffHand:Complete()
end

function u214.IsOffHandActive(p1) -- Line: 657 -- upvalues: OffHand (val)
    return OffHand:IsActive()
end

function u214.GetOffHandItem(p1) -- Line: 661 -- upvalues: OffHand (val)
    return OffHand:GetItem()
end

function UnequipWeapon() -- Line: 666
    -- upvalues: QuickSwap (val), DualWield (val), OffHand (val), u185 (ref), ViewmodelManager (val), u186 (ref)
    -- upvalues: LocalPlayerController (val), u214 (val), HUDService (val), Dry (val)
    QuickSwap:Cleanup()
    DualWield:Cleanup()
    OffHand:Cleanup()
    if u185 then
        local v1 = ViewmodelManager
        local v2 = u185
        v1:Unequip(v2)
        if u185.Viewmodel then
            u185.Viewmodel:SetEnabled(false)
        end
    end
    addToLast2Weapons(false)
    u185 = nil
    u186 = false
    LocalPlayerController.CurrentWeapon = nil
    LocalPlayerController:UpdateCurrentWeapon()
    u214.WeaponUnequipped:Fire()
    local StaminaDisplay = HUDService.Elements.StaminaDisplay
    if StaminaDisplay then
        StaminaDisplay:SetPlacement(false)
    end
    if Dry then
        Dry:Stop()
    end
end

function addToLast2Weapons(p1) -- Line: 697 -- upvalues: u201 (val)
    local v1 = u201
    table.insert(v1, p1)
    if 2 < #u201 then
        table.remove(u201, 1)
    end
end

function getLastWeapon() -- Line: 704 -- upvalues: u201 (val)
    if u201[1] then
        return u201[1]
    end
    return nil
end

function SwapWeapon(p1, p2) -- Line: 711
    -- upvalues: Dry (val), u185 (ref), LocalPlayerController (val), u186 (ref), u188 (ref), u195 (val), QuickSwap (val)
    -- upvalues: DualWield (val), u187 (ref), u214 (val), OffHand (val), u209 (ref), u208 (ref), u210 (ref)
    -- upvalues: OffHandChecks (val), ViewmodelManager (val), SoundUtil (val), Equipped (val), u189 (ref), u194 (ref)
    -- upvalues: u190 (ref), WeaponUse (val), u197 (val)
    if Dry then
        Dry:Stop()
    end
    if u185 then
        u185.Bursting = false
        u185.CurrentShot = 1
    end
    if not LocalPlayerController.States.IsDead and not u186 and not u188 then
        local CanUseWithCurrentWeapon, Config, DeploySFX, Item, PrimaryWeapon_2, UnequipSFX, WeaponEquipped, Weapons, Weapons_2, v1, v2, v3, v4, v5, v6, v7, v8
        if not p2 and p1 and u195[p1] then
            v3 = u195[p1]
            if QuickSwap:IsActive() then
                local PrimaryWeapon = QuickSwap:GetPrimaryWeapon()
                if PrimaryWeapon and v3 == PrimaryWeapon then
                    QuickSwap:Cancel()
                    return
                end
                if v3 == u185 then
                    QuickSwap:Complete()
                    return
                end
                QuickSwap:Cancel()
                v2, v1 = p2, p1
                if not v2 and v1 and u195[v1] and u185 then
                    v3 = u195[v1]
                    if u185.Config.CanDualWield
                        and v3.Config.CanDualWield
                        and u185.WeaponId == v3.WeaponId
                        and v3 ~= u185
                        and not DualWield:IsActive() then
                        print(string.format(
                            "[WeaponController-DEBUG] Auto-dual-wield triggered: %s + %s",
                            u185.Name or "Unknown",
                            v3.Name or "Unknown"
                        ))
                        v4 = DualWield
                        v6 = u185
                        if v4:StartWithWeapons(v6, v3) then
                            return
                        end
                    end
                end
                if DualWield:IsActive() then
                    v3 = v1
                    if v3 then
                        v3 = u195[v1]
                    end
                    Weapons, Weapons_2 = DualWield:GetWeapons()
                    v6 = v3
                    if v6 then
                        v6 = true
                        if v3 ~= Weapons then
                            v6 = v3 == Weapons_2
                        end
                    end
                    if not v1 then
                        DualWield:Stop()
                        UnequipWeapon()
                        u187 = nil
                        u214.EquippedSlot:Fire(nil)
                        return
                    end
                    if v6 then
                        return
                    end
                    DualWield:Stop()
                end
                if OffHand:IsActive() then
                    v3 = v1
                    if v3 then
                        v3 = u195[v1]
                    end
                    Item = OffHand:GetItem()
                    PrimaryWeapon_2 = OffHand:GetPrimaryWeapon()
                    if not v1 or v3 == Item or v3 == PrimaryWeapon_2 then
                        OffHand:Cancel()
                        return
                    end
                    OffHand:Cancel()
                end
                if u185 and u185.Config and u185.Config.IsTwoHandedAbility then
                    v3 = v1
                    if v3 then
                        v3 = u195[v1]
                    end
                    if not v3 or v3 ~= u185 then
                        if u185.Config.CancelPreActivation then
                            v4 = u185
                            Config = v4.Config
                            v6 = u185
                            Config:CancelPreActivation(v6)
                        end
                        u209 = false
                        u208 = nil
                        u210 = nil
                    end
                end
                if not v2 and v1 and u195[v1] then
                    v3 = u195[v1]
                    v4 = OffHandChecks.CanUseItem(v3, u185)
                    v5 = OffHandChecks
                    CanUseWithCurrentWeapon = v5.CanUseWithCurrentWeapon
                    v6 = u185
                    v5 = CanUseWithCurrentWeapon(v6)
                    if v4 and v5 and OffHand:UseItem(v1) then
                        if u185 then
                            v6 = u195
                            v7 = nil
                            v8 = nil
                            for k, n in v6, v7, v8 do
                                if n == u185 then
                                    u187 = k
                                    return
                                end
                            end
                        end
                        return
                    end
                end
                if u185 then
                    u186 = v1 or true
                    if u185.AutoLoop and u185.AutoLoop.Playing then
                        u185.AutoLoop:Stop()
                        u185.AutoLoopEnd:Play()
                    end
                    v3 = u185
                    ViewmodelManager:Unequip(v3)
                    if not v2 then
                        v4 = SoundUtil
                        v6 = u185
                        UnequipSFX = v6.Config.UnequipSFX
                        v4:PlaySound(UnequipSFX)
                        if u185:Unequip() then
                            v5 = v3.Config.ViewmodelPriority or 10
                            ViewmodelManager:Equip(v3, "Both", v5)
                            u186 = false
                            return
                        end
                        Equipped:FireServer(nil)
                        u186 = false
                        if not v2 then
                            if v1 and u195[v1] then
                                if u195[v1] and u185 and u195[v1].Slot == u185.Slot then
                                    UnequipWeapon()
                                    return
                                end
                                if v2 then
                                    u214.EquippedSlot:Fire(v1)
                                    u187 = v1
                                end
                                if u187 and u195[u187] then
                                    u185 = u195[u187]
                                    v3 = Equipped
                                    v5 = u187
                                    v3:FireServer(v5)
                                    u185:Equip()
                                    v3 = u185.Config.ViewmodelPriority or 10
                                    v4 = ViewmodelManager
                                    v6 = u185
                                    v4:Equip(v6, "Both", v3)
                                    v4 = SoundUtil
                                    v6 = u185
                                    DeploySFX = v6.Config.DeploySFX
                                    v4:PlaySound(DeploySFX)
                                    if u195[v1].Config.IsMelee then
                                        u189 = v1
                                    elseif u195[v1].Config.IsAPistol then
                                        u194 = v1
                                    end
                                    addToLast2Weapons(u187)
                                    u190 = getLastWeapon()
                                    setupConfigurationChanges(u195[u187])
                                    v4 = QuickSwap
                                    v6 = u185
                                    v4:ResumePausedReload(v6)
                                    v4 = u214
                                    WeaponEquipped = v4.WeaponEquipped
                                    v6 = u185
                                    WeaponEquipped:Fire(v6)
                                    u214.AmmoChanged:Fire(true)
                                    LocalPlayerController.CurrentWeapon = u185
                                    LocalPlayerController:UpdateCurrentWeapon()
                                    if u195[v1].Config.IsTwoHandedAbility
                                        and u209
                                        and LocalPlayerController.OffHandPressed then
                                        v4 = u185

                                        function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                                            WeaponUse:FireServer()
                                        end

                                        v4 = u185

                                        function v4.OnDeploymentComplete() -- Line: 931
                                            -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval)
                                            -- upvalues: u210 (upval), u197 (upval)
                                            if u209 and u208 then
                                                task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                                    u187 = u208
                                                    local v1 = u214
                                                    local EquippedSlot = v1.EquippedSlot
                                                    local v2 = u208
                                                    EquippedSlot:Fire(v2)
                                                    if u210 then
                                                        u197.X = u210.X
                                                        u197.Y = u210.Y
                                                    end
                                                    u209 = false
                                                    u208 = nil
                                                    u210 = nil
                                                end)
                                            end
                                        end

                                        task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                                            if u185 and u185.Config.Use then
                                                local v1 = u185
                                                local Config = v1.Config
                                                local v2 = u185
                                                Config:Use(v2)
                                            end
                                        end)
                                    end
                                end
                                return
                            end
                            UnequipWeapon()
                            return
                        end
                    else
                        u185:ForceUnequip()
                        Equipped:FireServer(nil)
                        u186 = false
                        if not v2 then
                            if v1 and u195[v1] then
                                if u195[v1] and u185 and u195[v1].Slot == u185.Slot then
                                    UnequipWeapon()
                                    return
                                end
                                if v2 then
                                    u214.EquippedSlot:Fire(v1)
                                    u187 = v1
                                end
                                if u187 and u195[u187] then
                                    u185 = u195[u187]
                                    v3 = Equipped
                                    v5 = u187
                                    v3:FireServer(v5)
                                    u185:Equip()
                                    v3 = u185.Config.ViewmodelPriority or 10
                                    v4 = ViewmodelManager
                                    v6 = u185
                                    v4:Equip(v6, "Both", v3)
                                    v4 = SoundUtil
                                    v6 = u185
                                    DeploySFX = v6.Config.DeploySFX
                                    v4:PlaySound(DeploySFX)
                                    if u195[v1].Config.IsMelee then
                                        u189 = v1
                                    elseif u195[v1].Config.IsAPistol then
                                        u194 = v1
                                    end
                                    addToLast2Weapons(u187)
                                    u190 = getLastWeapon()
                                    setupConfigurationChanges(u195[u187])
                                    v4 = QuickSwap
                                    v6 = u185
                                    v4:ResumePausedReload(v6)
                                    v4 = u214
                                    WeaponEquipped = v4.WeaponEquipped
                                    v6 = u185
                                    WeaponEquipped:Fire(v6)
                                    u214.AmmoChanged:Fire(true)
                                    LocalPlayerController.CurrentWeapon = u185
                                    LocalPlayerController:UpdateCurrentWeapon()
                                    if u195[v1].Config.IsTwoHandedAbility
                                        and u209
                                        and LocalPlayerController.OffHandPressed then
                                        v4 = u185

                                        function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                                            WeaponUse:FireServer()
                                        end

                                        v4 = u185

                                        function v4.OnDeploymentComplete() -- Line: 931
                                            -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval)
                                            -- upvalues: u210 (upval), u197 (upval)
                                            if u209 and u208 then
                                                task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                                    u187 = u208
                                                    local v1 = u214
                                                    local EquippedSlot = v1.EquippedSlot
                                                    local v2 = u208
                                                    EquippedSlot:Fire(v2)
                                                    if u210 then
                                                        u197.X = u210.X
                                                        u197.Y = u210.Y
                                                    end
                                                    u209 = false
                                                    u208 = nil
                                                    u210 = nil
                                                end)
                                            end
                                        end

                                        task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                                            if u185 and u185.Config.Use then
                                                local v1 = u185
                                                local Config = v1.Config
                                                local v2 = u185
                                                Config:Use(v2)
                                            end
                                        end)
                                    end
                                end
                                return
                            end
                            UnequipWeapon()
                            return
                        end
                    end
                end
                if v2 then
                    u214.EquippedSlot:Fire(v1)
                    u187 = v1
                end
                if u187 and u195[u187] then
                    u185 = u195[u187]
                    v3 = Equipped
                    v5 = u187
                    v3:FireServer(v5)
                    u185:Equip()
                    v3 = u185.Config.ViewmodelPriority or 10
                    v4 = ViewmodelManager
                    v6 = u185
                    v4:Equip(v6, "Both", v3)
                    v4 = SoundUtil
                    v6 = u185
                    DeploySFX = v6.Config.DeploySFX
                    v4:PlaySound(DeploySFX)
                    if u195[v1].Config.IsMelee then
                        u189 = v1
                    elseif u195[v1].Config.IsAPistol then
                        u194 = v1
                    end
                    addToLast2Weapons(u187)
                    u190 = getLastWeapon()
                    setupConfigurationChanges(u195[u187])
                    v4 = QuickSwap
                    v6 = u185
                    v4:ResumePausedReload(v6)
                    v4 = u214
                    WeaponEquipped = v4.WeaponEquipped
                    v6 = u185
                    WeaponEquipped:Fire(v6)
                    u214.AmmoChanged:Fire(true)
                    LocalPlayerController.CurrentWeapon = u185
                    LocalPlayerController:UpdateCurrentWeapon()
                    if u195[v1].Config.IsTwoHandedAbility and u209 and LocalPlayerController.OffHandPressed then
                        v4 = u185

                        function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                            WeaponUse:FireServer()
                        end

                        v4 = u185

                        function v4.OnDeploymentComplete() -- Line: 931
                            -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval), u210 (upval)
                            -- upvalues: u197 (upval)
                            if u209 and u208 then
                                task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                    u187 = u208
                                    local v1 = u214
                                    local EquippedSlot = v1.EquippedSlot
                                    local v2 = u208
                                    EquippedSlot:Fire(v2)
                                    if u210 then
                                        u197.X = u210.X
                                        u197.Y = u210.Y
                                    end
                                    u209 = false
                                    u208 = nil
                                    u210 = nil
                                end)
                            end
                        end

                        task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                            if u185 and u185.Config.Use then
                                local v1 = u185
                                local Config = v1.Config
                                local v2 = u185
                                Config:Use(v2)
                            end
                        end)
                    end
                end
                return
            end
            if not u185 or not v3.Config.IsAPistol or u185.Config.IsMelee or u185.Config.IsAPistol then
                v2, v1 = p2, p1
            else
                if QuickSwap:Start(p1) then
                    return
                end
                v2, v1 = p2, p1
            end
            if not v2 and v1 and u195[v1] and u185 then
                v3 = u195[v1]
                if u185.Config.CanDualWield
                    and v3.Config.CanDualWield
                    and u185.WeaponId == v3.WeaponId
                    and v3 ~= u185
                    and not DualWield:IsActive() then
                    print(string.format(
                        "[WeaponController-DEBUG] Auto-dual-wield triggered: %s + %s",
                        u185.Name or "Unknown",
                        v3.Name or "Unknown"
                    ))
                    v4 = DualWield
                    v6 = u185
                    if v4:StartWithWeapons(v6, v3) then
                        return
                    end
                end
            end
            if DualWield:IsActive() then
                v3 = v1
                if v3 then
                    v3 = u195[v1]
                end
                Weapons, Weapons_2 = DualWield:GetWeapons()
                v6 = v3
                if v6 then
                    v6 = true
                    if v3 ~= Weapons then
                        v6 = v3 == Weapons_2
                    end
                end
                if not v1 then
                    DualWield:Stop()
                    UnequipWeapon()
                    u187 = nil
                    u214.EquippedSlot:Fire(nil)
                    return
                end
                if v6 then
                    return
                end
                DualWield:Stop()
            end
            if OffHand:IsActive() then
                v3 = v1
                if v3 then
                    v3 = u195[v1]
                end
                Item = OffHand:GetItem()
                PrimaryWeapon_2 = OffHand:GetPrimaryWeapon()
                if not v1 or v3 == Item or v3 == PrimaryWeapon_2 then
                    OffHand:Cancel()
                    return
                end
                OffHand:Cancel()
            end
            if u185 and u185.Config and u185.Config.IsTwoHandedAbility then
                v3 = v1
                if v3 then
                    v3 = u195[v1]
                end
                if not v3 or v3 ~= u185 then
                    if u185.Config.CancelPreActivation then
                        v4 = u185
                        Config = v4.Config
                        v6 = u185
                        Config:CancelPreActivation(v6)
                    end
                    u209 = false
                    u208 = nil
                    u210 = nil
                end
            end
            if not v2 and v1 and u195[v1] then
                v3 = u195[v1]
                v4 = OffHandChecks.CanUseItem(v3, u185)
                v5 = OffHandChecks
                CanUseWithCurrentWeapon = v5.CanUseWithCurrentWeapon
                v6 = u185
                v5 = CanUseWithCurrentWeapon(v6)
                if v4 and v5 and OffHand:UseItem(v1) then
                    if u185 then
                        v6 = u195
                        v7 = nil
                        v8 = nil
                        for i, j in v6, v7, v8 do
                            if j == u185 then
                                u187 = i
                                return
                            end
                        end
                    end
                    return
                end
            end
            if u185 then
                u186 = v1 or true
                if u185.AutoLoop and u185.AutoLoop.Playing then
                    u185.AutoLoop:Stop()
                    u185.AutoLoopEnd:Play()
                end
                v3 = u185
                ViewmodelManager:Unequip(v3)
                if not v2 then
                    v4 = SoundUtil
                    v6 = u185
                    UnequipSFX = v6.Config.UnequipSFX
                    v4:PlaySound(UnequipSFX)
                    if u185:Unequip() then
                        v5 = v3.Config.ViewmodelPriority or 10
                        ViewmodelManager:Equip(v3, "Both", v5)
                        u186 = false
                        return
                    end
                    Equipped:FireServer(nil)
                    u186 = false
                    if not v2 then
                        if v1 and u195[v1] then
                            if u195[v1] and u185 and u195[v1].Slot == u185.Slot then
                                UnequipWeapon()
                                return
                            end
                            if v2 then
                                u214.EquippedSlot:Fire(v1)
                                u187 = v1
                            end
                            if u187 and u195[u187] then
                                u185 = u195[u187]
                                v3 = Equipped
                                v5 = u187
                                v3:FireServer(v5)
                                u185:Equip()
                                v3 = u185.Config.ViewmodelPriority or 10
                                v4 = ViewmodelManager
                                v6 = u185
                                v4:Equip(v6, "Both", v3)
                                v4 = SoundUtil
                                v6 = u185
                                DeploySFX = v6.Config.DeploySFX
                                v4:PlaySound(DeploySFX)
                                if u195[v1].Config.IsMelee then
                                    u189 = v1
                                elseif u195[v1].Config.IsAPistol then
                                    u194 = v1
                                end
                                addToLast2Weapons(u187)
                                u190 = getLastWeapon()
                                setupConfigurationChanges(u195[u187])
                                v4 = QuickSwap
                                v6 = u185
                                v4:ResumePausedReload(v6)
                                v4 = u214
                                WeaponEquipped = v4.WeaponEquipped
                                v6 = u185
                                WeaponEquipped:Fire(v6)
                                u214.AmmoChanged:Fire(true)
                                LocalPlayerController.CurrentWeapon = u185
                                LocalPlayerController:UpdateCurrentWeapon()
                                if u195[v1].Config.IsTwoHandedAbility
                                    and u209
                                    and LocalPlayerController.OffHandPressed then
                                    v4 = u185

                                    function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                                        WeaponUse:FireServer()
                                    end

                                    v4 = u185

                                    function v4.OnDeploymentComplete() -- Line: 931
                                        -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval)
                                        -- upvalues: u210 (upval), u197 (upval)
                                        if u209 and u208 then
                                            task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                                u187 = u208
                                                local v1 = u214
                                                local EquippedSlot = v1.EquippedSlot
                                                local v2 = u208
                                                EquippedSlot:Fire(v2)
                                                if u210 then
                                                    u197.X = u210.X
                                                    u197.Y = u210.Y
                                                end
                                                u209 = false
                                                u208 = nil
                                                u210 = nil
                                            end)
                                        end
                                    end

                                    task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                                        if u185 and u185.Config.Use then
                                            local v1 = u185
                                            local Config = v1.Config
                                            local v2 = u185
                                            Config:Use(v2)
                                        end
                                    end)
                                end
                            end
                            return
                        end
                        UnequipWeapon()
                        return
                    end
                else
                    u185:ForceUnequip()
                    Equipped:FireServer(nil)
                    u186 = false
                    if not v2 then
                        if v1 and u195[v1] then
                            if u195[v1] and u185 and u195[v1].Slot == u185.Slot then
                                UnequipWeapon()
                                return
                            end
                            if v2 then
                                u214.EquippedSlot:Fire(v1)
                                u187 = v1
                            end
                            if u187 and u195[u187] then
                                u185 = u195[u187]
                                v3 = Equipped
                                v5 = u187
                                v3:FireServer(v5)
                                u185:Equip()
                                v3 = u185.Config.ViewmodelPriority or 10
                                v4 = ViewmodelManager
                                v6 = u185
                                v4:Equip(v6, "Both", v3)
                                v4 = SoundUtil
                                v6 = u185
                                DeploySFX = v6.Config.DeploySFX
                                v4:PlaySound(DeploySFX)
                                if u195[v1].Config.IsMelee then
                                    u189 = v1
                                elseif u195[v1].Config.IsAPistol then
                                    u194 = v1
                                end
                                addToLast2Weapons(u187)
                                u190 = getLastWeapon()
                                setupConfigurationChanges(u195[u187])
                                v4 = QuickSwap
                                v6 = u185
                                v4:ResumePausedReload(v6)
                                v4 = u214
                                WeaponEquipped = v4.WeaponEquipped
                                v6 = u185
                                WeaponEquipped:Fire(v6)
                                u214.AmmoChanged:Fire(true)
                                LocalPlayerController.CurrentWeapon = u185
                                LocalPlayerController:UpdateCurrentWeapon()
                                if u195[v1].Config.IsTwoHandedAbility
                                    and u209
                                    and LocalPlayerController.OffHandPressed then
                                    v4 = u185

                                    function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                                        WeaponUse:FireServer()
                                    end

                                    v4 = u185

                                    function v4.OnDeploymentComplete() -- Line: 931
                                        -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval)
                                        -- upvalues: u210 (upval), u197 (upval)
                                        if u209 and u208 then
                                            task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                                u187 = u208
                                                local v1 = u214
                                                local EquippedSlot = v1.EquippedSlot
                                                local v2 = u208
                                                EquippedSlot:Fire(v2)
                                                if u210 then
                                                    u197.X = u210.X
                                                    u197.Y = u210.Y
                                                end
                                                u209 = false
                                                u208 = nil
                                                u210 = nil
                                            end)
                                        end
                                    end

                                    task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                                        if u185 and u185.Config.Use then
                                            local v1 = u185
                                            local Config = v1.Config
                                            local v2 = u185
                                            Config:Use(v2)
                                        end
                                    end)
                                end
                            end
                            return
                        end
                        UnequipWeapon()
                        return
                    end
                end
            end
            if v2 then
                u214.EquippedSlot:Fire(v1)
                u187 = v1
            end
            if u187 and u195[u187] then
                u185 = u195[u187]
                v3 = Equipped
                v5 = u187
                v3:FireServer(v5)
                u185:Equip()
                v3 = u185.Config.ViewmodelPriority or 10
                v4 = ViewmodelManager
                v6 = u185
                v4:Equip(v6, "Both", v3)
                v4 = SoundUtil
                v6 = u185
                DeploySFX = v6.Config.DeploySFX
                v4:PlaySound(DeploySFX)
                if u195[v1].Config.IsMelee then
                    u189 = v1
                elseif u195[v1].Config.IsAPistol then
                    u194 = v1
                end
                addToLast2Weapons(u187)
                u190 = getLastWeapon()
                setupConfigurationChanges(u195[u187])
                v4 = QuickSwap
                v6 = u185
                v4:ResumePausedReload(v6)
                v4 = u214
                WeaponEquipped = v4.WeaponEquipped
                v6 = u185
                WeaponEquipped:Fire(v6)
                u214.AmmoChanged:Fire(true)
                LocalPlayerController.CurrentWeapon = u185
                LocalPlayerController:UpdateCurrentWeapon()
                if u195[v1].Config.IsTwoHandedAbility and u209 and LocalPlayerController.OffHandPressed then
                    v4 = u185

                    function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                        WeaponUse:FireServer()
                    end

                    v4 = u185

                    function v4.OnDeploymentComplete() -- Line: 931
                        -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval), u210 (upval), u197 (upval)
                        if u209 and u208 then
                            task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                u187 = u208
                                local v1 = u214
                                local EquippedSlot = v1.EquippedSlot
                                local v2 = u208
                                EquippedSlot:Fire(v2)
                                if u210 then
                                    u197.X = u210.X
                                    u197.Y = u210.Y
                                end
                                u209 = false
                                u208 = nil
                                u210 = nil
                            end)
                        end
                    end

                    task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                        if u185 and u185.Config.Use then
                            local v1 = u185
                            local Config = v1.Config
                            local v2 = u185
                            Config:Use(v2)
                        end
                    end)
                end
            end
            return
        end
        if not QuickSwap:IsActive() then
            v2, v1 = p2, p1
        else
            QuickSwap:Cancel()
            v2, v1 = p2, p1
        end
        if not v2 and v1 and u195[v1] and u185 then
            v3 = u195[v1]
            if u185.Config.CanDualWield
                and v3.Config.CanDualWield
                and u185.WeaponId == v3.WeaponId
                and v3 ~= u185
                and not DualWield:IsActive() then
                print(string.format(
                    "[WeaponController-DEBUG] Auto-dual-wield triggered: %s + %s",
                    u185.Name or "Unknown",
                    v3.Name or "Unknown"
                ))
                v4 = DualWield
                v6 = u185
                if v4:StartWithWeapons(v6, v3) then
                    return
                end
            end
        end
        if DualWield:IsActive() then
            v3 = v1
            if v3 then
                v3 = u195[v1]
            end
            Weapons, Weapons_2 = DualWield:GetWeapons()
            v6 = v3
            if v6 then
                v6 = true
                if v3 ~= Weapons then
                    v6 = v3 == Weapons_2
                end
            end
            if not v1 then
                DualWield:Stop()
                UnequipWeapon()
                u187 = nil
                u214.EquippedSlot:Fire(nil)
                return
            end
            if v6 then
                return
            end
            DualWield:Stop()
        end
        if OffHand:IsActive() then
            v3 = v1
            if v3 then
                v3 = u195[v1]
            end
            Item = OffHand:GetItem()
            PrimaryWeapon_2 = OffHand:GetPrimaryWeapon()
            if not v1 or v3 == Item or v3 == PrimaryWeapon_2 then
                OffHand:Cancel()
                return
            end
            OffHand:Cancel()
        end
        if u185 and u185.Config and u185.Config.IsTwoHandedAbility then
            v3 = v1
            if v3 then
                v3 = u195[v1]
            end
            if not v3 or v3 ~= u185 then
                if u185.Config.CancelPreActivation then
                    v4 = u185
                    Config = v4.Config
                    v6 = u185
                    Config:CancelPreActivation(v6)
                end
                u209 = false
                u208 = nil
                u210 = nil
            end
        end
        if not v2 and v1 and u195[v1] then
            v3 = u195[v1]
            v4 = OffHandChecks.CanUseItem(v3, u185)
            v5 = OffHandChecks
            CanUseWithCurrentWeapon = v5.CanUseWithCurrentWeapon
            v6 = u185
            v5 = CanUseWithCurrentWeapon(v6)
            if v4 and v5 and OffHand:UseItem(v1) then
                if u185 then
                    v6 = u195
                    v7 = nil
                    v8 = nil
                    for m, i5 in v6, v7, v8 do
                        if i5 == u185 then
                            u187 = m
                            return
                        end
                    end
                end
                return
            end
        end
        if u185 then
            u186 = v1 or true
            if u185.AutoLoop and u185.AutoLoop.Playing then
                u185.AutoLoop:Stop()
                u185.AutoLoopEnd:Play()
            end
            v3 = u185
            ViewmodelManager:Unequip(v3)
            if not v2 then
                v4 = SoundUtil
                v6 = u185
                UnequipSFX = v6.Config.UnequipSFX
                v4:PlaySound(UnequipSFX)
                if u185:Unequip() then
                    v5 = v3.Config.ViewmodelPriority or 10
                    ViewmodelManager:Equip(v3, "Both", v5)
                    u186 = false
                    return
                end
                Equipped:FireServer(nil)
                u186 = false
                if not v2 then
                    if v1 and u195[v1] then
                        if u195[v1] and u185 and u195[v1].Slot == u185.Slot then
                            UnequipWeapon()
                            return
                        end
                        if v2 then
                            u214.EquippedSlot:Fire(v1)
                            u187 = v1
                        end
                        if u187 and u195[u187] then
                            u185 = u195[u187]
                            v3 = Equipped
                            v5 = u187
                            v3:FireServer(v5)
                            u185:Equip()
                            v3 = u185.Config.ViewmodelPriority or 10
                            v4 = ViewmodelManager
                            v6 = u185
                            v4:Equip(v6, "Both", v3)
                            v4 = SoundUtil
                            v6 = u185
                            DeploySFX = v6.Config.DeploySFX
                            v4:PlaySound(DeploySFX)
                            if u195[v1].Config.IsMelee then
                                u189 = v1
                            elseif u195[v1].Config.IsAPistol then
                                u194 = v1
                            end
                            addToLast2Weapons(u187)
                            u190 = getLastWeapon()
                            setupConfigurationChanges(u195[u187])
                            v4 = QuickSwap
                            v6 = u185
                            v4:ResumePausedReload(v6)
                            v4 = u214
                            WeaponEquipped = v4.WeaponEquipped
                            v6 = u185
                            WeaponEquipped:Fire(v6)
                            u214.AmmoChanged:Fire(true)
                            LocalPlayerController.CurrentWeapon = u185
                            LocalPlayerController:UpdateCurrentWeapon()
                            if u195[v1].Config.IsTwoHandedAbility
                                and u209
                                and LocalPlayerController.OffHandPressed then
                                v4 = u185

                                function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                                    WeaponUse:FireServer()
                                end

                                v4 = u185

                                function v4.OnDeploymentComplete() -- Line: 931
                                    -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval), u210 (upval)
                                    -- upvalues: u197 (upval)
                                    if u209 and u208 then
                                        task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                            u187 = u208
                                            local v1 = u214
                                            local EquippedSlot = v1.EquippedSlot
                                            local v2 = u208
                                            EquippedSlot:Fire(v2)
                                            if u210 then
                                                u197.X = u210.X
                                                u197.Y = u210.Y
                                            end
                                            u209 = false
                                            u208 = nil
                                            u210 = nil
                                        end)
                                    end
                                end

                                task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                                    if u185 and u185.Config.Use then
                                        local v1 = u185
                                        local Config = v1.Config
                                        local v2 = u185
                                        Config:Use(v2)
                                    end
                                end)
                            end
                        end
                        return
                    end
                    UnequipWeapon()
                    return
                end
            else
                u185:ForceUnequip()
                Equipped:FireServer(nil)
                u186 = false
                if not v2 then
                    if v1 and u195[v1] then
                        if u195[v1] and u185 and u195[v1].Slot == u185.Slot then
                            UnequipWeapon()
                            return
                        end
                        if v2 then
                            u214.EquippedSlot:Fire(v1)
                            u187 = v1
                        end
                        if u187 and u195[u187] then
                            u185 = u195[u187]
                            v3 = Equipped
                            v5 = u187
                            v3:FireServer(v5)
                            u185:Equip()
                            v3 = u185.Config.ViewmodelPriority or 10
                            v4 = ViewmodelManager
                            v6 = u185
                            v4:Equip(v6, "Both", v3)
                            v4 = SoundUtil
                            v6 = u185
                            DeploySFX = v6.Config.DeploySFX
                            v4:PlaySound(DeploySFX)
                            if u195[v1].Config.IsMelee then
                                u189 = v1
                            elseif u195[v1].Config.IsAPistol then
                                u194 = v1
                            end
                            addToLast2Weapons(u187)
                            u190 = getLastWeapon()
                            setupConfigurationChanges(u195[u187])
                            v4 = QuickSwap
                            v6 = u185
                            v4:ResumePausedReload(v6)
                            v4 = u214
                            WeaponEquipped = v4.WeaponEquipped
                            v6 = u185
                            WeaponEquipped:Fire(v6)
                            u214.AmmoChanged:Fire(true)
                            LocalPlayerController.CurrentWeapon = u185
                            LocalPlayerController:UpdateCurrentWeapon()
                            if u195[v1].Config.IsTwoHandedAbility
                                and u209
                                and LocalPlayerController.OffHandPressed then
                                v4 = u185

                                function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                                    WeaponUse:FireServer()
                                end

                                v4 = u185

                                function v4.OnDeploymentComplete() -- Line: 931
                                    -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval), u210 (upval)
                                    -- upvalues: u197 (upval)
                                    if u209 and u208 then
                                        task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                            u187 = u208
                                            local v1 = u214
                                            local EquippedSlot = v1.EquippedSlot
                                            local v2 = u208
                                            EquippedSlot:Fire(v2)
                                            if u210 then
                                                u197.X = u210.X
                                                u197.Y = u210.Y
                                            end
                                            u209 = false
                                            u208 = nil
                                            u210 = nil
                                        end)
                                    end
                                end

                                task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                                    if u185 and u185.Config.Use then
                                        local v1 = u185
                                        local Config = v1.Config
                                        local v2 = u185
                                        Config:Use(v2)
                                    end
                                end)
                            end
                        end
                        return
                    end
                    UnequipWeapon()
                    return
                end
            end
        end
        if v2 then
            u214.EquippedSlot:Fire(v1)
            u187 = v1
        end
        if u187 and u195[u187] then
            u185 = u195[u187]
            v3 = Equipped
            v5 = u187
            v3:FireServer(v5)
            u185:Equip()
            v3 = u185.Config.ViewmodelPriority or 10
            v4 = ViewmodelManager
            v6 = u185
            v4:Equip(v6, "Both", v3)
            v4 = SoundUtil
            v6 = u185
            DeploySFX = v6.Config.DeploySFX
            v4:PlaySound(DeploySFX)
            if u195[v1].Config.IsMelee then
                u189 = v1
            elseif u195[v1].Config.IsAPistol then
                u194 = v1
            end
            addToLast2Weapons(u187)
            u190 = getLastWeapon()
            setupConfigurationChanges(u195[u187])
            v4 = QuickSwap
            v6 = u185
            v4:ResumePausedReload(v6)
            v4 = u214
            WeaponEquipped = v4.WeaponEquipped
            v6 = u185
            WeaponEquipped:Fire(v6)
            u214.AmmoChanged:Fire(true)
            LocalPlayerController.CurrentWeapon = u185
            LocalPlayerController:UpdateCurrentWeapon()
            if u195[v1].Config.IsTwoHandedAbility and u209 and LocalPlayerController.OffHandPressed then
                v4 = u185

                function v4.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                    WeaponUse:FireServer()
                end

                v4 = u185

                function v4.OnDeploymentComplete() -- Line: 931
                    -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval), u210 (upval), u197 (upval)
                    if u209 and u208 then
                        task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                            u187 = u208
                            local v1 = u214
                            local EquippedSlot = v1.EquippedSlot
                            local v2 = u208
                            EquippedSlot:Fire(v2)
                            if u210 then
                                u197.X = u210.X
                                u197.Y = u210.Y
                            end
                            u209 = false
                            u208 = nil
                            u210 = nil
                        end)
                    end
                end

                task.defer(function() -- Line: 948 -- upvalues: u185 (upval)
                    if u185 and u185.Config.Use then
                        local v1 = u185
                        local Config = v1.Config
                        local v2 = u185
                        Config:Use(v2)
                    end
                end)
            end
        end
        return
    end
end

function u214.CaptureEquippedState(p1) -- Line: 957 -- upvalues: u185 (ref), u197 (val)
    if not u185 then
        return nil
    end
    return {inventorySlot = u185.Slot, hotbarSlot = u197.X, hotbarSubSlot = u197.Y}
end

function u214.RestoreEquippedState(p1, p2) -- Line: 968 -- upvalues: u195 (val), u197 (val), u185 (ref)
    if type(p2) == "table" and p2.inventorySlot and u195[p2.inventorySlot] then
        u197.X = p2.hotbarSlot or 0
        u197.Y = p2.hotbarSubSlot or 0
        SwapWeapon(p2.inventorySlot, true)
        local v1 = u185 == u195[p2.inventorySlot]
        return v1
    end
    return false
end

local u283 = nil

function setupConfigurationChanges(p1) -- Line: 979 -- upvalues: u283 (ref), HUDService (val), CameraController (val)
    if u283 then
        u283:Disconnect()
    end
    u283 = p1.Viewmodel.ConfigLoaded:Connect(function() -- Line: 984 -- upvalues: HUDService (upval), p1 (val), CameraController (upval)
        local StaminaDisplay = HUDService.Elements.StaminaDisplay
        if StaminaDisplay then
            local v1 = p1
            local IsMelee = v1.Config.IsMelee
            StaminaDisplay:SetPlacement(IsMelee)
        end
        local AimFOVMultiplier = p1.Config.AimFOVMultiplier
        if AimFOVMultiplier then
            CameraController:SetMagnificationSensitivity(AimFOVMultiplier)
            return
        end
        CameraController:SetMagnificationSensitivity(1)
    end)
    local StaminaDisplay = HUDService.Elements.StaminaDisplay
    if StaminaDisplay then
        local IsMelee = p1.Config.IsMelee
        StaminaDisplay:SetPlacement(IsMelee)
    end
    local AimFOVMultiplier = p1.Config.AimFOVMultiplier
    if AimFOVMultiplier then
        CameraController:SetMagnificationSensitivity(AimFOVMultiplier)
        return
    end
    CameraController:SetMagnificationSensitivity(1)
end

function WeaponStepped(p1) -- Line: 1002
    -- upvalues: u185 (ref), LocalPlayerController (val), u187 (ref), u214 (val), ShellSystem (val), Melee (val)
    -- upvalues: HUDService (val), DualWield (val), GameState (val), u189 (ref), u195 (val), Fusion (val)
    -- upvalues: SkillTreeData (val), u205 (ref), u204 (ref), u191 (ref), u192 (ref), u203 (ref), u190 (ref), u194 (ref)
    -- upvalues: u186 (ref), u188 (ref), u206 (ref), AutoShoot (val), u207 (ref), peek (val), Settings (val)
    -- upvalues: SharedSprings (val), CancelReload (val), Dry (val), WeaponUse (val), u202 (ref), LoopSFX (val)
    -- upvalues: SoundUtil (val), QuickSwap (val)
    local ADSFireMode, ADSFireRate, ActiveWeapons, ActiveWeapons_2, ActiveWeapons_3, ActiveWeapons_4, Ammo, Ammo_2, Ammo_3, Animations, Attribute, Attribute_2, BaseSpread, BaseSpread_2, CancelReload_2, Config_2, Config_4, Config_8, CurrentShot, FireRate, FireWhileSprinting, GunFired, HeavyDelayPerShot, Inaccuracy, Inaccuracy_2, InsertAnimationTime, InsertAnimationTime_2, LayeredSFXs, Length, Length_2, Length_3, Length_4, Length_5, LoadLoop, LoadLoop_2, LoadStop, LoadStopAnimationTime, LoadStopAnimationTime_2, LoadStop_2, MouseReleased, Pump, QuickDrawActive, ShootSingle, ShootingInaccuracy, Slot, Slot_2, StaminaCooldown, StaminaDisplay, StaminaDisplay_2, StaminaDisplay_3, StaminaRequired, StaminaUsed, Stamina_2, Stamina_3, Stamina_6, StoredAmmo, StoredAmmo_2, Viewmodel, Viewmodel_2, Viewmodel_3, Viewmodel_4, Viewmodel_5, Viewmodel_6, Viewmodel_7, Viewmodel_8, Viewmodel_9, Weapons, Weapons_2, peek_2, u867, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25
    if not u185 then
        v2 = 1
        v13 = 1
        if LocalPlayerController.FocusEnabled then
            v2 = 2
            v13 = 0.5
        end
        if not ShellSystem.UsingViewmodelStep then
            ShellSystem:Update(p1)
        end
        if not u185 or not u185.Config or not u185.Config.IsMelee then
            u214.Blocking = false
            u214.Parrying = false
        else
            Melee.Think(u185, p1, LocalPlayerController)
            u214.Blocking = u185.Blocking
            if not u185.Blocking then
                if not u185.Blocking then
                    u185.ParryTime = nil
                    u214.Parrying = false
                end
            elseif u185.ParryTime then
                v20 = u214
                v21 = os.clock() <= u185.ParryTime
                v20.Parrying = v21
            elseif not u185.Blocking then
                u185.ParryTime = nil
                u214.Parrying = false
            end
        end
        if not u185 or not u185.Charging then
            if HUDService.Elements.StaminaDisplay and HUDService.Elements.StaminaDisplay.ChargeDisplay then
                StaminaDisplay = HUDService.Elements.StaminaDisplay
                StaminaDisplay.ChargeDisplay = false
                HUDService.Elements.StaminaDisplay:ChargeNotReady()
            end
        elseif u185
            and u185.Charging
            and (LocalPlayerController:GetStamina()) < (u185.Config.HeavyStaminaRequired or 9999999)
            and HUDService.Elements.StaminaDisplay
            and HUDService.Elements.StaminaDisplay.ChargeDisplay then
            StaminaDisplay = HUDService.Elements.StaminaDisplay
            StaminaDisplay.ChargeDisplay = false
            HUDService.Elements.StaminaDisplay:ChargeNotReady()
        end
        ActiveWeapons = DualWield:GetActiveWeapons()
        v21 = ActiveWeapons
        v22 = nil
        v23 = nil
        for i114, i115 in v21, v22, v23 do
            Config_8 = i115.Config
            if not i115.ShootingInaccuracy then
                i115.ShootingInaccuracy = 0
            end
            BaseSpread_2 = Config_8.BaseSpread
            if not BaseSpread_2 then
                BaseSpread_2 = Config_8.Spread
            end
            if BaseSpread_2 then
                Attribute_2 = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                BaseSpread_2 = BaseSpread_2 * (GameState.Data.Variables.WeaponSpread * (Attribute_2 or 1))
            end
            v4 = Lerp
            ShootingInaccuracy = i115.ShootingInaccuracy
            v8 = v1 / (Config_8.ShootingSpreadDecay or 0.3)
            i115.ShootingInaccuracy = v4(ShootingInaccuracy, 0, (math.min(v8, 1)))
            v4 = 1
            v5 = false
            if LocalPlayerController.States.Crouching or LocalPlayerController.States.Sliding then
                v4 = v4 * (Config_8.CrouchSpreadReduction or 0.5)
                v5 = true
            elseif LocalPlayerController.States.Proning then
                v4 = v4 * (Config_8.ProneSpreadReduction or 0.25)
                v5 = true
            end
            if not i115.Aiming or not i115.ADSStrength or not (0.9 < i115.ADSStrength) then
                if not BaseSpread_2 then
                    v7 = 0
                else
                    v9 = BaseSpread_2
                    v7 = math.deg(v9) * 2
                    if not v7 then
                        v7 = 0
                    end
                end
                i115.Inaccuracy = v7 * v4
                v7 = i115.Inaccuracy + i115.ShootingInaccuracy
                if LocalPlayerController.humanoid.HasLanded then
                    v8 = 0
                else
                    v8 = Config_8.AirSpread or 25
                end
                i115.Inaccuracy = v7 + v8
                Inaccuracy_2 = i115.Inaccuracy
                i115.Inaccuracy = math.max(0, Inaccuracy_2)
            else
                if v5 then
                    v4 = v4 * 1.65
                end
                v4 = v4 * (Config_8.ADSSpreadReduction or 0.75)
                if not BaseSpread_2 then
                    v7 = 0
                else
                    v9 = BaseSpread_2
                    v7 = math.deg(v9) * 2
                    if not v7 then
                        v7 = 0
                    end
                end
                i115.Inaccuracy = v7 * v4
                Inaccuracy = i115.Inaccuracy
                i115.Inaccuracy = math.max(0, Inaccuracy)
            end
        end
        if 0 < #ActiveWeapons then
            u214.InaccuracyUpdated:Fire()
        end
        if u189 then
            v20 = u195[u189]
            v22 = Fusion
            peek_2 = v22.peek
            v23 = SkillTreeData
            v22 = peek_2(v23.MeleeSwingSpeedMult)
            v22 = v20.Config.DelayPerShot / (v22 or 1)
            v24 = os.clock() - v22
            v23 = (v20.LastShot or 0) <= v24
            if not v23 or not LocalPlayerController.BlockPressed then
                if LocalPlayerController.BlockPressed or not u191 or not u185 then
                    if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u185.Slot == u189 then
                    u191 = false
                    if u192 < 0.25 then
                        u203 = true
                    elseif not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif u195[u189] then
                Stamina_2 = LocalPlayerController:GetStamina()
                if not (u195[u189].Config.StaminaRequired <= Stamina_2) then
                    if LocalPlayerController.BlockPressed or not u191 or not u185 then
                        if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                            u187 = u190
                            u205 = false
                        end
                    elseif u185.Slot == u189 then
                        u191 = false
                        if u192 < 0.25 then
                            u203 = true
                        elseif not u204 then
                            u187 = u190
                            u205 = false
                        end
                    elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif not LocalPlayerController.States.IsDowned then
                    if not u185 or u185.Slot ~= u189 or u205 then
                        u205 = true
                        u204 = false
                        u187 = u189
                        if v20 then
                            v20.QuickEquip = true
                        end
                    else
                        u204 = true
                    end
                    u191 = true
                elseif LocalPlayerController.BlockPressed or not u191 or not u185 then
                    if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u185.Slot == u189 then
                    u191 = false
                    if u192 < 0.25 then
                        u203 = true
                    elseif not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif LocalPlayerController.BlockPressed or not u191 or not u185 then
                if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif u185.Slot == u189 then
                u191 = false
                if u192 < 0.25 then
                    u203 = true
                elseif not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                u187 = u190
                u205 = false
            end
            if not LocalPlayerController.BlockPressed then
                u192 = 0
            else
                u192 = u192 + v1
            end
        end
        if u203 then
            if not u203 or not u185 then
                if not u203 or not u185 or u185.Slot ~= u189 then
                    if u203 and not u185 then
                        if u203 then
                            u187 = u189
                        end
                        if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                            if not Fusion.peek(SkillTreeData.HasLastStand) then
                                u187 = u194
                            else
                                v21 = u187
                                v20 = tostring(v21)
                                if v20 ~= "1" and v20 ~= "2" then
                                    if not u185 then
                                        Slot_2 = u194
                                    elseif u185.Slot == "1" then
                                        Slot_2 = u185.Slot
                                    elseif u185.Slot ~= "2" then
                                        Slot_2 = u194
                                    else
                                        Slot_2 = u185.Slot
                                    end
                                    u187 = Slot_2
                                end
                            end
                        end
                        if not u187 or not u195[u187] then
                            if not u187 and u185 and not u186 and not u188 then
                                SwapWeapon()
                            end
                        elseif not u185 then
                            if u185 then
                                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                    u185.CancelUnequip = true
                                end
                            elseif not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 ~= u195[u187] then
                            if not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    end
                elseif not u185.IsEquipped or u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif u185.Slot ~= u189 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif not u203 or not u185 or u185.Slot ~= u189 then
                if u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif not u185.IsEquipped or u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif not u185 then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        elseif not u185 then
            if not u203 or not u185 then
                if not u203 or not u185 or u185.Slot ~= u189 then
                    if u203 and not u185 then
                        if u203 then
                            u187 = u189
                        end
                        if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                            if not Fusion.peek(SkillTreeData.HasLastStand) then
                                u187 = u194
                            else
                                v21 = u187
                                v20 = tostring(v21)
                                if v20 ~= "1" and v20 ~= "2" then
                                    if not u185 then
                                        Slot_2 = u194
                                    elseif u185.Slot == "1" then
                                        Slot_2 = u185.Slot
                                    elseif u185.Slot ~= "2" then
                                        Slot_2 = u194
                                    else
                                        Slot_2 = u185.Slot
                                    end
                                    u187 = Slot_2
                                end
                            end
                        end
                        if not u187 or not u195[u187] then
                            if not u187 and u185 and not u186 and not u188 then
                                SwapWeapon()
                            end
                        elseif not u185 then
                            if u185 then
                                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                    u185.CancelUnequip = true
                                end
                            elseif not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 ~= u195[u187] then
                            if not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    end
                elseif not u185.IsEquipped or u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif u185.Slot ~= u189 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif not u203 or not u185 or u185.Slot ~= u189 then
                if u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif not u185.IsEquipped or u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif not u185.Meleeing then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        elseif not u203 or not u185 then
            if not u203 or not u185 or u185.Slot ~= u189 then
                if u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif not u185.IsEquipped or u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif u185.Slot ~= u189 then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        elseif not u203 or not u185 or u185.Slot ~= u189 then
            if u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif not u185.IsEquipped or u203 and not u185 then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        end
        if u214.MobileShootDown then
            u214.PrimaryAttackDown = true
        elseif u206 then
            u214.PrimaryAttackDown = false
        end
        v20 = AutoShoot:CheckTarget()
        if u207 ~= v20 then
            u214.TargetChanged:Fire(v20)
            u207 = v20
        end
        if not u206
            or not peek(Settings.Controls.AutoShoot)
            or not u185
            or u185.Config.IsMelee
            or u185.Config.Deployable
            or not (0 < u185.Ammo)
            or u185.Primed == false then
            if u214.PrimaryAttackDown
                and u206
                and peek(Settings.Controls.AutoShoot)
                and not u214.MobileShootDown
                and u185
                and not u185.Config.IsMelee then
                u214.PrimaryAttackDown = false
            end
        elseif v20 then
            u214.PrimaryAttackDown = true
            u185.MouseReleased = true
        elseif u214.PrimaryAttackDown
            and u206
            and peek(Settings.Controls.AutoShoot)
            and not u214.MobileShootDown
            and u185
            and not u185.Config.IsMelee then
            u214.PrimaryAttackDown = false
        end
        if u185 then
            FireWhileSprinting = u185.Config.FireWhileSprinting
        end
        QuickDrawActive = u185
        if QuickDrawActive then
            QuickDrawActive = u185.QuickDrawActive
        end
        if not u185 then
            v23 = not LocalPlayerController.States.Sprinting
            if v23 then
                v23 = QuickDrawActive
                if not v23 then
                    v24 = 0.1 < SharedSprings.EquipSpring.Position
                    v23 = not v24
                end
            end
        elseif u185.Config.IsMelee then
            v23 = QuickDrawActive
            if not v23 then
                v24 = 0.1 < SharedSprings.EquipSpring.Position
                v23 = not v24
            end
        else
            v23 = not LocalPlayerController.States.Sprinting
            if v23 then
                v23 = QuickDrawActive
                if not v23 then
                    v24 = 0.1 < SharedSprings.EquipSpring.Position
                    v23 = not v24
                end
            end
        end
        if u185 then
            v25 = (game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1) * Fusion.peek(SkillTreeData.ReloadSpeedMult)
            if u185.Reloading
                and u214.PrimaryAttackDown
                and u185.Config.UsesLoadLoop
                and 0 < u185.Ammo
                and u185.MouseReleased then
                if not u185.Config.UsesLoadLoop or not u185.Config.LoadStopOnReload then
                    u185.CancelReload = true
                else
                    u185.ReloadingTime = u185.Config.LoadStopTime * v25
                    u185.LoopStage = 3
                end
            end
            if u185.ReloadingTime then
                if u185.ReloadingTime <= 0 then
                    u185.ReloadingTime = 0
                    if u185.Config.UsesLoadLoop then
                        if u185.LoopStage == 1 then
                            if not u185.Config.ShouldNotCycleAfterReload
                                and u185.Config.PrimeAction
                                and u185.Ammo <= 0 then
                                u185.Priming = false
                                u185.Primed = false
                            end
                            u185.CancelReload = false
                            u185.LoopStage = 2
                            u185.IncreasedAmmo = true
                        end
                        if u185.LoopStage == 2 then
                            if u185.StoredAmmo <= 0 then
                                u185.LoopStage = 3
                            else
                                v3 = u185
                                Ammo_2 = v3.Ammo
                                if u185.Config.Ammo <= Ammo_2 or u185.CancelReload then
                                    u185.LoopStage = 3
                                end
                            end
                            if not u185.IncreasedAmmo then
                                if u185.LoopStage == 2 then
                                    StoredAmmo = u185.Config.AmmoPerLoad or 1
                                    if u185.StoredAmmo < StoredAmmo then
                                        StoredAmmo = u185.StoredAmmo
                                    end
                                    v4 = StoredAmmo + u185.Ammo
                                    if not (u185.Config.Ammo < v4) then
                                        v4 = u185
                                        v4.Ammo = v4.Ammo + StoredAmmo
                                    else
                                        u185.Ammo = u185.Config.Ammo
                                    end
                                    v4 = u185
                                    v4.StoredAmmo = v4.StoredAmmo - StoredAmmo
                                    if u185.Config.AmmoUpdated then
                                        task.defer(function() -- Line: 1324 -- upvalues: u185 (upval), StoredAmmo (ref)
                                            local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                            local v2 = u185
                                            local AmmoUpdated = v2.Config.AmmoUpdated
                                            local v3 = u185
                                            AmmoUpdated(v1, v3.Viewmodel.Model, {
                                                Ammo = u185.Ammo - StoredAmmo,
                                                StoredAmmo = u185.StoredAmmo - StoredAmmo,
                                            })
                                        end)
                                    end
                                    u214.AmmoChanged:Fire()
                                    u214.Reloaded:Fire()
                                    u185.ReloadingTime = (u185.Config.InsertTime - u185.Config.IncrAmmoCountTime) * v13 * v25
                                    u185.IncreasedAmmo = true
                                end
                            elseif u185.LoopStage == 2 then
                                LoadLoop = u185.Viewmodel.Animations.LoadLoop
                                if LoadLoop then
                                    LoadLoop.Priority = Enum.AnimationPriority.Action4
                                    Length = LoadLoop.Length
                                    InsertAnimationTime = u185.Config.InsertAnimationTime
                                    if not InsertAnimationTime then
                                        InsertAnimationTime = u185.Config.InsertTime
                                    end
                                    v6 = Length / InsertAnimationTime
                                    v7 = u185
                                    Viewmodel = v7.Viewmodel
                                    v12 = v6 * v2 / v25
                                    Viewmodel:PlayAnimation("LoadLoop", 0, 1, v12)
                                end
                                u185.ReloadingTime = u185.Config.IncrAmmoCountTime * v13 * v25
                                u185.IncreasedAmmo = false
                            end
                        end
                        if u185.LoopStage == 3 then
                            if not u185.CancelReload then
                                v3 = nil
                            else
                                v3 = 0
                            end
                            v4 = u185
                            Viewmodel_2 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_2:StopAnimation("LoadLoop", v7)
                            v4 = u185
                            Viewmodel_3 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_3:StopAnimation("LoadIdle", v7)
                            v4 = u185
                            Viewmodel_4 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_4:StopAnimation("LoadStart", v7)
                            v4 = u185
                            Viewmodel_5 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_5:StopAnimation("LoadStartEmpty", v7)
                            LoadStop = u185.Viewmodel.Animations.LoadStop
                            if LoadStop and not u185.CancelReload then
                                Length_2 = LoadStop.Length
                                LoadStopAnimationTime = u185.Config.LoadStopAnimationTime
                                if not LoadStopAnimationTime then
                                    LoadStopAnimationTime = u185.Config.LoadStartTime
                                end
                                v7 = Length_2 / LoadStopAnimationTime
                                v8 = u185
                                Viewmodel_6 = v8.Viewmodel
                                v14 = v7 * v2 / v25
                                Viewmodel_6:PlayAnimation("LoadStop", 0, 1, v14)
                            end
                            CancelReload_2 = u185.CancelReload
                            u185.CancelReload = false
                            u185.LoopStage = 4
                            u867 = u185
                            Slot = u867.Slot
                            Ammo = u867.Ammo
                            task.defer(function() -- Line: 1362 -- upvalues: u867 (val), CancelReload (upval), Slot (val), Ammo (val), u214 (upval)
                                if u867.IsDestroyed then
                                    return
                                end
                                local v1 = CancelReload
                                local v2 = {Slot, Ammo}
                                v1 = v1:Call(v2)
                                v1:After(function(p1, p2) -- Line: 1366 -- upvalues: u867 (upval), Ammo (upval), u214 (upval)
                                    if p1 and p2 and u867 and not u867.IsDestroyed then
                                        local v1 = Ammo - u867.Ammo
                                        p2[1] = p2[1] - v1
                                        u867.newAmmo = p2
                                        u867.ServerFinishedReload = true
                                        u867.Ammo = u867.newAmmo[1]
                                        u867.StoredAmmo = u867.newAmmo[2]
                                        if u867.Config.AmmoUpdated then
                                            task.defer(function() -- Line: 1376 -- upvalues: u867 (upval)
                                                local v1 = {Ammo = u867.Ammo, StoredAmmo = u867.StoredAmmo}
                                                u867.Config.AmmoUpdated(v1, u867.Viewmodel.Model, v1)
                                            end)
                                        end
                                        u214.AmmoChanged:Fire()
                                        u214.Reloaded:Fire()
                                        u867.newAmmo = nil
                                        return
                                    end
                                    warn(p2)
                                end)
                            end)
                        elseif not u185.Reloaded and u185.LoopStage == 4 then
                            u185.Reloading = false
                            u185.Reloaded = true
                            u185.CancelReload = false
                            if DualWield:IsActive() then
                                v3 = u214
                                v5 = u185
                                v3:DualWieldReloadComplete(v5)
                            end
                        end
                    elseif not u185.Reloaded then
                        u185.Reloading = false
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1408 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                u185.Config.AmmoUpdated(v1, u185.Viewmodel.Model, v1)
                            end)
                        end
                        if u185.newAmmo then
                            print("Updated Client ammo: NewAmmo Object", u185.newAmmo)
                            u185.Ammo = u185.newAmmo[1]
                            u185.StoredAmmo = u185.newAmmo[2]
                            u214.AmmoChanged:Fire()
                            u214.Reloaded:Fire()
                            u185.newAmmo = nil
                        end
                        u185.Reloaded = true
                        u185:ReloadFinished()
                        if DualWield:IsActive() then
                            v3 = u214
                            v5 = u185
                            v3:DualWieldReloadComplete(v5)
                        end
                    end
                elseif not u185.CancelReload then
                    if not u185.Config.UsesLoadLoop then
                        v3 = not not LocalPlayerController.FocusEnabled
                        if v3 ~= (u185.ReloadFocusActive or false) then
                            if not v3 then
                                v4 = 2
                            else
                                v4 = 0.5
                            end
                            u185.ReloadingTime = u185.ReloadingTime * v4
                            if u185.ReloadCancelTime then
                                u185.ReloadCancelTime = u185.ReloadCancelTime * v4
                            end
                            u185.ReloadFocusActive = v3
                            if u185.Viewmodel and u185.Viewmodel.Animations then
                                Animations = u185.Viewmodel.Animations
                                v6 = 1 / v4
                                v7 = {"Reload", "ReloadEmpty", "LoadStart", "LoadStartEmpty"}
                                v8 = nil
                                v9 = nil
                                for i116, i117 in v7, v8, v9 do
                                    v12 = Animations[i117]
                                    if v12 and v12.IsPlaying then
                                        v16 = v12.Speed * v6
                                        v12:AdjustSpeed(v16)
                                        break
                                    end
                                end
                            end
                        end
                    end
                    u185.ReloadingTime = u185.ReloadingTime - v1
                    if u185.ReloadingTime < (u185.ReloadCancelTime or 0) then
                        if not u185.IsEquipped then
                            u185.ReloadingTime = 0
                        end
                        if u185.newAmmo and not u185.MagInUpdate then
                            u185.MagInUpdate = true
                            u185.Ammo = u185.newAmmo[1]
                            u185.StoredAmmo = u185.newAmmo[2]
                            u214.AmmoChanged:Fire()
                            u214.Reloaded:Fire()
                            u185.newAmmo = nil
                        end
                    end
                else
                    u185.ReloadingTime = 0
                    if u185.Config.UsesLoadLoop then
                        if u185.LoopStage == 1 then
                            if not u185.Config.ShouldNotCycleAfterReload
                                and u185.Config.PrimeAction
                                and u185.Ammo <= 0 then
                                u185.Priming = false
                                u185.Primed = false
                            end
                            u185.CancelReload = false
                            u185.LoopStage = 2
                            u185.IncreasedAmmo = true
                        end
                        if u185.LoopStage == 2 then
                            if u185.StoredAmmo <= 0 then
                                u185.LoopStage = 3
                            else
                                v3 = u185
                                Ammo_2 = v3.Ammo
                                if u185.Config.Ammo <= Ammo_2 or u185.CancelReload then
                                    u185.LoopStage = 3
                                end
                            end
                            if not u185.IncreasedAmmo then
                                if u185.LoopStage == 2 then
                                    StoredAmmo = u185.Config.AmmoPerLoad or 1
                                    if u185.StoredAmmo < StoredAmmo then
                                        StoredAmmo = u185.StoredAmmo
                                    end
                                    v4 = StoredAmmo + u185.Ammo
                                    if not (u185.Config.Ammo < v4) then
                                        v4 = u185
                                        v4.Ammo = v4.Ammo + StoredAmmo
                                    else
                                        u185.Ammo = u185.Config.Ammo
                                    end
                                    v4 = u185
                                    v4.StoredAmmo = v4.StoredAmmo - StoredAmmo
                                    if u185.Config.AmmoUpdated then
                                        task.defer(function() -- Line: 1324 -- upvalues: u185 (upval), StoredAmmo (ref)
                                            local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                            local v2 = u185
                                            local AmmoUpdated = v2.Config.AmmoUpdated
                                            local v3 = u185
                                            AmmoUpdated(v1, v3.Viewmodel.Model, {
                                                Ammo = u185.Ammo - StoredAmmo,
                                                StoredAmmo = u185.StoredAmmo - StoredAmmo,
                                            })
                                        end)
                                    end
                                    u214.AmmoChanged:Fire()
                                    u214.Reloaded:Fire()
                                    u185.ReloadingTime = (u185.Config.InsertTime - u185.Config.IncrAmmoCountTime) * v13 * v25
                                    u185.IncreasedAmmo = true
                                end
                            elseif u185.LoopStage == 2 then
                                LoadLoop = u185.Viewmodel.Animations.LoadLoop
                                if LoadLoop then
                                    LoadLoop.Priority = Enum.AnimationPriority.Action4
                                    Length = LoadLoop.Length
                                    InsertAnimationTime = u185.Config.InsertAnimationTime
                                    if not InsertAnimationTime then
                                        InsertAnimationTime = u185.Config.InsertTime
                                    end
                                    v6 = Length / InsertAnimationTime
                                    v7 = u185
                                    Viewmodel = v7.Viewmodel
                                    v12 = v6 * v2 / v25
                                    Viewmodel:PlayAnimation("LoadLoop", 0, 1, v12)
                                end
                                u185.ReloadingTime = u185.Config.IncrAmmoCountTime * v13 * v25
                                u185.IncreasedAmmo = false
                            end
                        end
                        if u185.LoopStage == 3 then
                            if not u185.CancelReload then
                                v3 = nil
                            else
                                v3 = 0
                            end
                            v4 = u185
                            Viewmodel_2 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_2:StopAnimation("LoadLoop", v7)
                            v4 = u185
                            Viewmodel_3 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_3:StopAnimation("LoadIdle", v7)
                            v4 = u185
                            Viewmodel_4 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_4:StopAnimation("LoadStart", v7)
                            v4 = u185
                            Viewmodel_5 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_5:StopAnimation("LoadStartEmpty", v7)
                            LoadStop = u185.Viewmodel.Animations.LoadStop
                            if LoadStop and not u185.CancelReload then
                                Length_2 = LoadStop.Length
                                LoadStopAnimationTime = u185.Config.LoadStopAnimationTime
                                if not LoadStopAnimationTime then
                                    LoadStopAnimationTime = u185.Config.LoadStartTime
                                end
                                v7 = Length_2 / LoadStopAnimationTime
                                v8 = u185
                                Viewmodel_6 = v8.Viewmodel
                                v14 = v7 * v2 / v25
                                Viewmodel_6:PlayAnimation("LoadStop", 0, 1, v14)
                            end
                            CancelReload_2 = u185.CancelReload
                            u185.CancelReload = false
                            u185.LoopStage = 4
                            u867 = u185
                            Slot = u867.Slot
                            Ammo = u867.Ammo
                            task.defer(function() -- Line: 1362 -- upvalues: u867 (val), CancelReload (upval), Slot (val), Ammo (val), u214 (upval)
                                if u867.IsDestroyed then
                                    return
                                end
                                local v1 = CancelReload
                                local v2 = {Slot, Ammo}
                                v1 = v1:Call(v2)
                                v1:After(function(p1, p2) -- Line: 1366 -- upvalues: u867 (upval), Ammo (upval), u214 (upval)
                                    if p1 and p2 and u867 and not u867.IsDestroyed then
                                        local v1 = Ammo - u867.Ammo
                                        p2[1] = p2[1] - v1
                                        u867.newAmmo = p2
                                        u867.ServerFinishedReload = true
                                        u867.Ammo = u867.newAmmo[1]
                                        u867.StoredAmmo = u867.newAmmo[2]
                                        if u867.Config.AmmoUpdated then
                                            task.defer(function() -- Line: 1376 -- upvalues: u867 (upval)
                                                local v1 = {Ammo = u867.Ammo, StoredAmmo = u867.StoredAmmo}
                                                u867.Config.AmmoUpdated(v1, u867.Viewmodel.Model, v1)
                                            end)
                                        end
                                        u214.AmmoChanged:Fire()
                                        u214.Reloaded:Fire()
                                        u867.newAmmo = nil
                                        return
                                    end
                                    warn(p2)
                                end)
                            end)
                        elseif not u185.Reloaded and u185.LoopStage == 4 then
                            u185.Reloading = false
                            u185.Reloaded = true
                            u185.CancelReload = false
                            if DualWield:IsActive() then
                                v3 = u214
                                v5 = u185
                                v3:DualWieldReloadComplete(v5)
                            end
                        end
                    elseif not u185.Reloaded then
                        u185.Reloading = false
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1408 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                u185.Config.AmmoUpdated(v1, u185.Viewmodel.Model, v1)
                            end)
                        end
                        if u185.newAmmo then
                            print("Updated Client ammo: NewAmmo Object", u185.newAmmo)
                            u185.Ammo = u185.newAmmo[1]
                            u185.StoredAmmo = u185.newAmmo[2]
                            u214.AmmoChanged:Fire()
                            u214.Reloaded:Fire()
                            u185.newAmmo = nil
                        end
                        u185.Reloaded = true
                        u185:ReloadFinished()
                        if DualWield:IsActive() then
                            v3 = u214
                            v5 = u185
                            v3:DualWieldReloadComplete(v5)
                        end
                    end
                end
            end
            if u185.Ammo <= 0 then
                if u185.Bursting then
                    u185.Bursting = false
                    u185.CurrentShot = 1
                end
            elseif not v23 and u185.Bursting then
                u185.Bursting = false
                u185.CurrentShot = 1
            end
            if not (u185.Ammo <= 0) or u185.Reloading then
                if Dry and Dry.IsPlaying then
                    Dry:Stop()
                end
            elseif not u185.Config.IsMelee then
                if u214.PrimaryAttackDown then
                    if Dry and not Dry.IsPlaying then
                        Dry:Play()
                    end
                elseif Dry then
                    Dry:Stop()
                end
                if 0 < u185.StoredAmmo then
                    if Dry then
                        Dry:Stop()
                    end
                    if not DualWield:IsActive() then
                        u214:Reload()
                    else
                        v3 = u214
                        v5 = u185
                        v3:DualWieldAutoReload(v5)
                    end
                end
            elseif Dry and Dry.IsPlaying then
                Dry:Stop()
            end
            v3 = u185.Config.DelayPerShot / GameState.Data.Variables.FireRate
            if u185.FireMode ~= "Auto" and u185.FireMode ~= "Burst" and not u185.Config.IsMelee then
                v3 = v3 * v13
            end
            if u185.Config.IsMelee then
                v3 = v3 / (Fusion.peek(SkillTreeData.MeleeSwingSpeedMult) or 1)
            end
            Config_2 = u185.Config
            ADSFireMode = nil
            ADSFireRate = nil
            if not u185.Aiming or not Config_2.ADSFireMode then
                if Config_2.HipFireMode then
                    ADSFireMode = Config_2.HipFireMode
                    ADSFireRate = Config_2.HipFireRate
                    if Config_2.VariableShotgun then
                        Config_2.Damage = Config_2.HipDmg
                        Config_2.BulletsPerShot = Config_2.HipFirePellets
                    end
                end
            elseif Config_2.ADSFireRate then
                ADSFireMode = Config_2.ADSFireMode
                ADSFireRate = Config_2.ADSFireRate
                if Config_2.VariableShotgun then
                    Config_2.Damage = Config_2.AimDmg
                    Config_2.BulletsPerShot = Config_2.ADSPellets
                end
            elseif Config_2.HipFireMode then
                ADSFireMode = Config_2.HipFireMode
                ADSFireRate = Config_2.HipFireRate
                if Config_2.VariableShotgun then
                    Config_2.Damage = Config_2.HipDmg
                    Config_2.BulletsPerShot = Config_2.HipFirePellets
                end
            end
            if ADSFireMode then
                u185.FireMode = ADSFireMode
                Config_2.DelayPerShot = ADSFireRate
                u214.FireModeChanged:Fire(ADSFireMode)
            end
            HeavyDelayPerShot = u185.Config.HeavyDelayPerShot
            if not HeavyDelayPerShot then
                HeavyDelayPerShot = u185.Config.FireRate
            end
            if HeavyDelayPerShot then
                HeavyDelayPerShot = HeavyDelayPerShot / GameState.Data.Variables.FireRate * 0.5 * v13
            end
            if not v23 then
                v9 = os.clock()
                if u185.FireMode ~= "Burst" then
                    v10 = v3
                else
                    v10 = 0
                end
                v8 = v9 - v10
                if (u185.LastShot or 0) <= v8 then
                    u185.MouseReleased = true
                end
            elseif u214.PrimaryAttackDown then
                if u185.Busy then
                    v9 = os.clock()
                    if u185.FireMode ~= "Burst" then
                        v10 = v3
                    else
                        v10 = 0
                    end
                    v8 = v9 - v10
                    if (u185.LastShot or 0) <= v8 then
                        u185.MouseReleased = true
                    end
                else
                    if DualWield:IsActive() and u214.PrimaryAttackDown then
                        v8, v9 = u214:DualWieldFire()
                        if v8 and v9 then
                            Config_2 = u185.Config
                            FireRate = Config_2.FireRate
                            if not FireRate then
                                FireRate = Config_2.DelayPerShot
                                if not FireRate then
                                    FireRate = 0.15
                                end
                            end
                            v3 = FireRate / GameState.Data.Variables.FireRate * v13
                        end
                    end
                    v9 = os.clock() - v3
                    v8 = (u185.LastShot or 0) <= v9
                    MouseReleased = v8
                    if MouseReleased then
                        MouseReleased = u185.MouseReleased
                        if MouseReleased then
                            if not u185.Config.IsMelee then
                                MouseReleased = false
                                if 0 < u185.Ammo then
                                    if u185.ReloadingTime then
                                        MouseReleased = u185.ReloadingTime
                                        if MouseReleased then
                                            MouseReleased = false
                                            if u185.ReloadingTime <= 0 then
                                                MouseReleased = u185.Reloaded
                                                if MouseReleased then
                                                    if u185.Config.PrimeAction then
                                                        MouseReleased = u185.Primed
                                                        if MouseReleased then
                                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                                MouseReleased = not u185.Busy
                                                            else
                                                                MouseReleased = false
                                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                                    MouseReleased = not u185.Busy
                                                                end
                                                            end
                                                        end
                                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    elseif u185.Config.PrimeAction then
                                        MouseReleased = u185.Primed
                                        if MouseReleased then
                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.ReloadingTime then
                                MouseReleased = u185.ReloadingTime
                                if MouseReleased then
                                    MouseReleased = false
                                    if u185.ReloadingTime <= 0 then
                                        MouseReleased = u185.Reloaded
                                        if MouseReleased then
                                            if u185.Config.PrimeAction then
                                                MouseReleased = u185.Primed
                                                if MouseReleased then
                                                    if u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    end
                                end
                            elseif u185.Config.PrimeAction then
                                MouseReleased = u185.Primed
                                if MouseReleased then
                                    if u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                MouseReleased = not u185.Busy
                            else
                                MouseReleased = false
                                Stamina_3 = LocalPlayerController:GetStamina()
                                if u185.Config.StaminaRequired <= Stamina_3 then
                                    MouseReleased = not u185.Busy
                                end
                            end
                        end
                    end
                    if u203 then
                        if (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                            or not u185.Config.StaminaRequired
                            or not v8 then
                            u185.QuickEquip = nil
                            u203 = false
                        end
                    end
                    if u185.Config.CustomShouldFire and not u185.Config.CustomShouldFire(u185) then
                        MouseReleased = false
                    end
                    if u185.Config.StaminaRequired
                        and (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                        and u214.PrimaryAttackDown then
                        v11 = HUDService
                        StaminaDisplay_2 = v11.Elements.StaminaDisplay
                        v12 = u185
                        StaminaRequired = v12.Config.StaminaRequired
                        StaminaDisplay_2:FlashRequired(StaminaRequired)
                    end
                    if not MouseReleased then
                        if MouseReleased then
                            if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                                if u214.PrimaryAttackDown then
                                    if u203 then
                                        u202 = true
                                    end
                                elseif u185.PrimaryAttackStart or u203 then
                                    u202 = true
                                end
                            elseif v23 then
                                u185.PrimaryAttackStart = os.clock()
                                u185.Charging = true
                            elseif u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                            if u185.Charging then
                                v10 = os.clock()
                                if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                    Stamina_6 = LocalPlayerController:GetStamina()
                                    if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                        and HUDService.Elements.StaminaDisplay
                                        and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                        StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                        StaminaDisplay_3.ChargeDisplay = true
                                        HUDService.Elements.StaminaDisplay:ChargeReady()
                                    end
                                end
                            end
                            if not u185.Config.IsMelee then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i118, i119 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i118)
                                        if not (0 < v16) then
                                            v16 = i119
                                            v17 = nil
                                            v18 = nil
                                            for i120, i121 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i121)
                                            end
                                        else
                                            v16 = i119
                                            v17 = nil
                                            v18 = nil
                                            for i122, i123 in v16, v17, v18 do
                                                task.delay(i118, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i123 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i123
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u202 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i124, i125 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i124)
                                        if not (0 < v16) then
                                            v16 = i125
                                            v17 = nil
                                            v18 = nil
                                            for i126, i127 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i127)
                                            end
                                        else
                                            v16 = i125
                                            v17 = nil
                                            v18 = nil
                                            for i128, i129 in v16, v17, v18 do
                                                task.delay(i124, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i129 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i129
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i130, i131 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i130)
                                        if not (0 < v16) then
                                            v16 = i131
                                            v17 = nil
                                            v18 = nil
                                            for i132, i133 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i133)
                                            end
                                        else
                                            v16 = i131
                                            v17 = nil
                                            v18 = nil
                                            for i134, i135 in v16, v17, v18 do
                                                task.delay(i130, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i135 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i135
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            end
                        end
                    elseif u185.Config.Use then
                        if not u185.Config.IsTwoHandedAbility then
                            WeaponUse:FireServer()
                        else
                            v10 = u185

                            function v10.FireServerDeployEvent() -- Line: 1587 -- upvalues: WeaponUse (upval)
                                WeaponUse:FireServer()
                            end
                        end
                        v10 = u185
                        Config_4 = v10.Config
                        v12 = u185
                        Config_4:Use(v12)
                    elseif MouseReleased then
                        if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                            if u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                        elseif v23 then
                            u185.PrimaryAttackStart = os.clock()
                            u185.Charging = true
                        elseif u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                        if u185.Charging then
                            v10 = os.clock()
                            if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                Stamina_6 = LocalPlayerController:GetStamina()
                                if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                    and HUDService.Elements.StaminaDisplay
                                    and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                    StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                    StaminaDisplay_3.ChargeDisplay = true
                                    HUDService.Elements.StaminaDisplay:ChargeReady()
                                end
                            end
                        end
                        if not u185.Config.IsMelee then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i136, i137 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i136)
                                    if not (0 < v16) then
                                        v16 = i137
                                        v17 = nil
                                        v18 = nil
                                        for i138, i139 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i139)
                                        end
                                    else
                                        v16 = i137
                                        v17 = nil
                                        v18 = nil
                                        for i140, i141 in v16, v17, v18 do
                                            task.delay(i136, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i141 (val)
                                                local v1 = SoundUtil
                                                local v2 = i141
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u202 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i142, i143 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i142)
                                    if not (0 < v16) then
                                        v16 = i143
                                        v17 = nil
                                        v18 = nil
                                        for i144, i145 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i145)
                                        end
                                    else
                                        v16 = i143
                                        v17 = nil
                                        v18 = nil
                                        for i146, i147 in v16, v17, v18 do
                                            task.delay(i142, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i147 (val)
                                                local v1 = SoundUtil
                                                local v2 = i147
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i148, i149 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i148)
                                    if not (0 < v16) then
                                        v16 = i149
                                        v17 = nil
                                        v18 = nil
                                        for i150, i151 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i151)
                                        end
                                    else
                                        v16 = i149
                                        v17 = nil
                                        v18 = nil
                                        for i152, i153 in v16, v17, v18 do
                                            task.delay(i148, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i153 (val)
                                                local v1 = SoundUtil
                                                local v2 = i153
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        end
                    end
                end
            elseif u185.Config.IsMelee then
                if u185.Busy then
                    v9 = os.clock()
                    if u185.FireMode ~= "Burst" then
                        v10 = v3
                    else
                        v10 = 0
                    end
                    v8 = v9 - v10
                    if (u185.LastShot or 0) <= v8 then
                        u185.MouseReleased = true
                    end
                else
                    if DualWield:IsActive() and u214.PrimaryAttackDown then
                        v8, v9 = u214:DualWieldFire()
                        if v8 and v9 then
                            Config_2 = u185.Config
                            FireRate = Config_2.FireRate
                            if not FireRate then
                                FireRate = Config_2.DelayPerShot
                                if not FireRate then
                                    FireRate = 0.15
                                end
                            end
                            v3 = FireRate / GameState.Data.Variables.FireRate * v13
                        end
                    end
                    v9 = os.clock() - v3
                    v8 = (u185.LastShot or 0) <= v9
                    MouseReleased = v8
                    if MouseReleased then
                        MouseReleased = u185.MouseReleased
                        if MouseReleased then
                            if not u185.Config.IsMelee then
                                MouseReleased = false
                                if 0 < u185.Ammo then
                                    if u185.ReloadingTime then
                                        MouseReleased = u185.ReloadingTime
                                        if MouseReleased then
                                            MouseReleased = false
                                            if u185.ReloadingTime <= 0 then
                                                MouseReleased = u185.Reloaded
                                                if MouseReleased then
                                                    if u185.Config.PrimeAction then
                                                        MouseReleased = u185.Primed
                                                        if MouseReleased then
                                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                                MouseReleased = not u185.Busy
                                                            else
                                                                MouseReleased = false
                                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                                    MouseReleased = not u185.Busy
                                                                end
                                                            end
                                                        end
                                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    elseif u185.Config.PrimeAction then
                                        MouseReleased = u185.Primed
                                        if MouseReleased then
                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.ReloadingTime then
                                MouseReleased = u185.ReloadingTime
                                if MouseReleased then
                                    MouseReleased = false
                                    if u185.ReloadingTime <= 0 then
                                        MouseReleased = u185.Reloaded
                                        if MouseReleased then
                                            if u185.Config.PrimeAction then
                                                MouseReleased = u185.Primed
                                                if MouseReleased then
                                                    if u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    end
                                end
                            elseif u185.Config.PrimeAction then
                                MouseReleased = u185.Primed
                                if MouseReleased then
                                    if u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                MouseReleased = not u185.Busy
                            else
                                MouseReleased = false
                                Stamina_3 = LocalPlayerController:GetStamina()
                                if u185.Config.StaminaRequired <= Stamina_3 then
                                    MouseReleased = not u185.Busy
                                end
                            end
                        end
                    end
                    if u203 then
                        if (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                            or not u185.Config.StaminaRequired
                            or not v8 then
                            u185.QuickEquip = nil
                            u203 = false
                        end
                    end
                    if u185.Config.CustomShouldFire and not u185.Config.CustomShouldFire(u185) then
                        MouseReleased = false
                    end
                    if u185.Config.StaminaRequired
                        and (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                        and u214.PrimaryAttackDown then
                        v11 = HUDService
                        StaminaDisplay_2 = v11.Elements.StaminaDisplay
                        v12 = u185
                        StaminaRequired = v12.Config.StaminaRequired
                        StaminaDisplay_2:FlashRequired(StaminaRequired)
                    end
                    if not MouseReleased then
                        if MouseReleased then
                            if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                                if u214.PrimaryAttackDown then
                                    if u203 then
                                        u202 = true
                                    end
                                elseif u185.PrimaryAttackStart or u203 then
                                    u202 = true
                                end
                            elseif v23 then
                                u185.PrimaryAttackStart = os.clock()
                                u185.Charging = true
                            elseif u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                            if u185.Charging then
                                v10 = os.clock()
                                if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                    Stamina_6 = LocalPlayerController:GetStamina()
                                    if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                        and HUDService.Elements.StaminaDisplay
                                        and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                        StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                        StaminaDisplay_3.ChargeDisplay = true
                                        HUDService.Elements.StaminaDisplay:ChargeReady()
                                    end
                                end
                            end
                            if not u185.Config.IsMelee then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i154, i155 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i154)
                                        if not (0 < v16) then
                                            v16 = i155
                                            v17 = nil
                                            v18 = nil
                                            for i156, i157 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i157)
                                            end
                                        else
                                            v16 = i155
                                            v17 = nil
                                            v18 = nil
                                            for i158, i159 in v16, v17, v18 do
                                                task.delay(i154, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i159 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i159
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u202 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i160, i161 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i160)
                                        if not (0 < v16) then
                                            v16 = i161
                                            v17 = nil
                                            v18 = nil
                                            for i162, i163 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i163)
                                            end
                                        else
                                            v16 = i161
                                            v17 = nil
                                            v18 = nil
                                            for i164, i165 in v16, v17, v18 do
                                                task.delay(i160, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i165 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i165
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i166, i167 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i166)
                                        if not (0 < v16) then
                                            v16 = i167
                                            v17 = nil
                                            v18 = nil
                                            for i168, i169 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i169)
                                            end
                                        else
                                            v16 = i167
                                            v17 = nil
                                            v18 = nil
                                            for i170, i171 in v16, v17, v18 do
                                                task.delay(i166, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i171 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i171
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            end
                        end
                    elseif u185.Config.Use then
                        if not u185.Config.IsTwoHandedAbility then
                            WeaponUse:FireServer()
                        else
                            v10 = u185

                            function v10.FireServerDeployEvent() -- Line: 1587 -- upvalues: WeaponUse (upval)
                                WeaponUse:FireServer()
                            end
                        end
                        v10 = u185
                        Config_4 = v10.Config
                        v12 = u185
                        Config_4:Use(v12)
                    elseif MouseReleased then
                        if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                            if u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                        elseif v23 then
                            u185.PrimaryAttackStart = os.clock()
                            u185.Charging = true
                        elseif u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                        if u185.Charging then
                            v10 = os.clock()
                            if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                Stamina_6 = LocalPlayerController:GetStamina()
                                if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                    and HUDService.Elements.StaminaDisplay
                                    and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                    StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                    StaminaDisplay_3.ChargeDisplay = true
                                    HUDService.Elements.StaminaDisplay:ChargeReady()
                                end
                            end
                        end
                        if not u185.Config.IsMelee then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i172, i173 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i172)
                                    if not (0 < v16) then
                                        v16 = i173
                                        v17 = nil
                                        v18 = nil
                                        for i174, i175 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i175)
                                        end
                                    else
                                        v16 = i173
                                        v17 = nil
                                        v18 = nil
                                        for i176, i177 in v16, v17, v18 do
                                            task.delay(i172, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i177 (val)
                                                local v1 = SoundUtil
                                                local v2 = i177
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u202 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i178, i179 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i178)
                                    if not (0 < v16) then
                                        v16 = i179
                                        v17 = nil
                                        v18 = nil
                                        for i180, i181 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i181)
                                        end
                                    else
                                        v16 = i179
                                        v17 = nil
                                        v18 = nil
                                        for i182, i183 in v16, v17, v18 do
                                            task.delay(i178, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i183 (val)
                                                local v1 = SoundUtil
                                                local v2 = i183
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i184, i185 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i184)
                                    if not (0 < v16) then
                                        v16 = i185
                                        v17 = nil
                                        v18 = nil
                                        for i186, i187 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i187)
                                        end
                                    else
                                        v16 = i185
                                        v17 = nil
                                        v18 = nil
                                        for i188, i189 in v16, v17, v18 do
                                            task.delay(i184, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i189 (val)
                                                local v1 = SoundUtil
                                                local v2 = i189
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        end
                    end
                end
            elseif not u185.Bursting or u185.Busy then
                v9 = os.clock()
                if u185.FireMode ~= "Burst" then
                    v10 = v3
                else
                    v10 = 0
                end
                v8 = v9 - v10
                if (u185.LastShot or 0) <= v8 then
                    u185.MouseReleased = true
                end
            else
                if DualWield:IsActive() and u214.PrimaryAttackDown then
                    v8, v9 = u214:DualWieldFire()
                    if v8 and v9 then
                        Config_2 = u185.Config
                        FireRate = Config_2.FireRate
                        if not FireRate then
                            FireRate = Config_2.DelayPerShot
                            if not FireRate then
                                FireRate = 0.15
                            end
                        end
                        v3 = FireRate / GameState.Data.Variables.FireRate * v13
                    end
                end
                v9 = os.clock() - v3
                v8 = (u185.LastShot or 0) <= v9
                MouseReleased = v8
                if MouseReleased then
                    MouseReleased = u185.MouseReleased
                    if MouseReleased then
                        if not u185.Config.IsMelee then
                            MouseReleased = false
                            if 0 < u185.Ammo then
                                if u185.ReloadingTime then
                                    MouseReleased = u185.ReloadingTime
                                    if MouseReleased then
                                        MouseReleased = false
                                        if u185.ReloadingTime <= 0 then
                                            MouseReleased = u185.Reloaded
                                            if MouseReleased then
                                                if u185.Config.PrimeAction then
                                                    MouseReleased = u185.Primed
                                                    if MouseReleased then
                                                        if u185.Charging or not u185.Config.StaminaRequired then
                                                            MouseReleased = not u185.Busy
                                                        else
                                                            MouseReleased = false
                                                            Stamina_3 = LocalPlayerController:GetStamina()
                                                            if u185.Config.StaminaRequired <= Stamina_3 then
                                                                MouseReleased = not u185.Busy
                                                            end
                                                        end
                                                    end
                                                elseif u185.Charging or not u185.Config.StaminaRequired then
                                                    MouseReleased = not u185.Busy
                                                else
                                                    MouseReleased = false
                                                    Stamina_3 = LocalPlayerController:GetStamina()
                                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                                        MouseReleased = not u185.Busy
                                                    end
                                                end
                                            end
                                        end
                                    end
                                elseif u185.Config.PrimeAction then
                                    MouseReleased = u185.Primed
                                    if MouseReleased then
                                        if u185.Charging or not u185.Config.StaminaRequired then
                                            MouseReleased = not u185.Busy
                                        else
                                            MouseReleased = false
                                            Stamina_3 = LocalPlayerController:GetStamina()
                                            if u185.Config.StaminaRequired <= Stamina_3 then
                                                MouseReleased = not u185.Busy
                                            end
                                        end
                                    end
                                elseif u185.Charging or not u185.Config.StaminaRequired then
                                    MouseReleased = not u185.Busy
                                else
                                    MouseReleased = false
                                    Stamina_3 = LocalPlayerController:GetStamina()
                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                        MouseReleased = not u185.Busy
                                    end
                                end
                            end
                        elseif u185.ReloadingTime then
                            MouseReleased = u185.ReloadingTime
                            if MouseReleased then
                                MouseReleased = false
                                if u185.ReloadingTime <= 0 then
                                    MouseReleased = u185.Reloaded
                                    if MouseReleased then
                                        if u185.Config.PrimeAction then
                                            MouseReleased = u185.Primed
                                            if MouseReleased then
                                                if u185.Charging or not u185.Config.StaminaRequired then
                                                    MouseReleased = not u185.Busy
                                                else
                                                    MouseReleased = false
                                                    Stamina_3 = LocalPlayerController:GetStamina()
                                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                                        MouseReleased = not u185.Busy
                                                    end
                                                end
                                            end
                                        elseif u185.Charging or not u185.Config.StaminaRequired then
                                            MouseReleased = not u185.Busy
                                        else
                                            MouseReleased = false
                                            Stamina_3 = LocalPlayerController:GetStamina()
                                            if u185.Config.StaminaRequired <= Stamina_3 then
                                                MouseReleased = not u185.Busy
                                            end
                                        end
                                    end
                                end
                            end
                        elseif u185.Config.PrimeAction then
                            MouseReleased = u185.Primed
                            if MouseReleased then
                                if u185.Charging or not u185.Config.StaminaRequired then
                                    MouseReleased = not u185.Busy
                                else
                                    MouseReleased = false
                                    Stamina_3 = LocalPlayerController:GetStamina()
                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                        MouseReleased = not u185.Busy
                                    end
                                end
                            end
                        elseif u185.Charging or not u185.Config.StaminaRequired then
                            MouseReleased = not u185.Busy
                        else
                            MouseReleased = false
                            Stamina_3 = LocalPlayerController:GetStamina()
                            if u185.Config.StaminaRequired <= Stamina_3 then
                                MouseReleased = not u185.Busy
                            end
                        end
                    end
                end
                if u203 then
                    if (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                        or not u185.Config.StaminaRequired
                        or not v8 then
                        u185.QuickEquip = nil
                        u203 = false
                    end
                end
                if u185.Config.CustomShouldFire and not u185.Config.CustomShouldFire(u185) then
                    MouseReleased = false
                end
                if u185.Config.StaminaRequired
                    and (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                    and u214.PrimaryAttackDown then
                    v11 = HUDService
                    StaminaDisplay_2 = v11.Elements.StaminaDisplay
                    v12 = u185
                    StaminaRequired = v12.Config.StaminaRequired
                    StaminaDisplay_2:FlashRequired(StaminaRequired)
                end
                if not MouseReleased then
                    if MouseReleased then
                        if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                            if u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                        elseif v23 then
                            u185.PrimaryAttackStart = os.clock()
                            u185.Charging = true
                        elseif u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                        if u185.Charging then
                            v10 = os.clock()
                            if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                Stamina_6 = LocalPlayerController:GetStamina()
                                if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                    and HUDService.Elements.StaminaDisplay
                                    and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                    StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                    StaminaDisplay_3.ChargeDisplay = true
                                    HUDService.Elements.StaminaDisplay:ChargeReady()
                                end
                            end
                        end
                        if not u185.Config.IsMelee then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i190, i191 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i190)
                                    if not (0 < v16) then
                                        v16 = i191
                                        v17 = nil
                                        v18 = nil
                                        for i192, i193 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i193)
                                        end
                                    else
                                        v16 = i191
                                        v17 = nil
                                        v18 = nil
                                        for i194, i195 in v16, v17, v18 do
                                            task.delay(i190, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i195 (val)
                                                local v1 = SoundUtil
                                                local v2 = i195
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u202 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i196, i197 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i196)
                                    if not (0 < v16) then
                                        v16 = i197
                                        v17 = nil
                                        v18 = nil
                                        for i198, i199 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i199)
                                        end
                                    else
                                        v16 = i197
                                        v17 = nil
                                        v18 = nil
                                        for i200, i201 in v16, v17, v18 do
                                            task.delay(i196, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i201 (val)
                                                local v1 = SoundUtil
                                                local v2 = i201
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i202, i203 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i202)
                                    if not (0 < v16) then
                                        v16 = i203
                                        v17 = nil
                                        v18 = nil
                                        for i204, i205 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i205)
                                        end
                                    else
                                        v16 = i203
                                        v17 = nil
                                        v18 = nil
                                        for i206, i207 in v16, v17, v18 do
                                            task.delay(i202, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i207 (val)
                                                local v1 = SoundUtil
                                                local v2 = i207
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        end
                    end
                elseif u185.Config.Use then
                    if not u185.Config.IsTwoHandedAbility then
                        WeaponUse:FireServer()
                    else
                        v10 = u185

                        function v10.FireServerDeployEvent() -- Line: 1587 -- upvalues: WeaponUse (upval)
                            WeaponUse:FireServer()
                        end
                    end
                    v10 = u185
                    Config_4 = v10.Config
                    v12 = u185
                    Config_4:Use(v12)
                elseif MouseReleased then
                    if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                        if u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                    elseif v23 then
                        u185.PrimaryAttackStart = os.clock()
                        u185.Charging = true
                    elseif u214.PrimaryAttackDown then
                        if u203 then
                            u202 = true
                        end
                    elseif u185.PrimaryAttackStart or u203 then
                        u202 = true
                    end
                    if u185.Charging then
                        v10 = os.clock()
                        if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                            Stamina_6 = LocalPlayerController:GetStamina()
                            if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                and HUDService.Elements.StaminaDisplay
                                and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                StaminaDisplay_3.ChargeDisplay = true
                                HUDService.Elements.StaminaDisplay:ChargeReady()
                            end
                        end
                    end
                    if not u185.Config.IsMelee then
                        u202 = false
                        if not u185.StartSFX then
                            if u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                        elseif not u185.Config.HasSuppressor then
                            v10 = LoopSFX
                            v12 = u185
                            v10:Start(v12)
                        elseif u185.Config.ShootSingle then
                            ShootSingle = u185.Config.ShootSingle
                            if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                ShootSingle = u185.Config.SuppressorShootSingle
                            end
                            SoundUtil:PlaySound(ShootSingle)
                        end
                        if u185.Config.LayeredSFXs then
                            LayeredSFXs = u185.Config.LayeredSFXs
                            v11 = nil
                            v12 = nil
                            for i208, i209 in LayeredSFXs, v11, v12 do
                                v16 = tonumber(i208)
                                if not (0 < v16) then
                                    v16 = i209
                                    v17 = nil
                                    v18 = nil
                                    for i210, i211 in v16, v17, v18 do
                                        SoundUtil:PlaySound(i211)
                                    end
                                else
                                    v16 = i209
                                    v17 = nil
                                    v18 = nil
                                    for i212, i213 in v16, v17, v18 do
                                        task.delay(i208, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i213 (val)
                                            local v1 = SoundUtil
                                            local v2 = i213
                                            v1:PlaySound(v2)
                                        end)
                                    end
                                end
                            end
                        end
                        if u185.AutoLoop and not u185.AutoLoop.Playing then
                            u185.AutoLoop:Play()
                        end
                        v10 = 100
                        v11 = false
                        if LocalPlayerController.States.Crouching then
                            if not Config_2.CrouchSpreadReduction then
                                v10 = 50
                            else
                                v10 = Config_2.CrouchSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if LocalPlayerController.States.Proning then
                            if not Config_2.ProneSpreadReduction then
                                v10 = 25
                            else
                                v10 = Config_2.ProneSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                            if v11 then
                                v10 = v10 * 1.65
                            end
                            v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                        end
                        if Config_2.Spread or Config_2.BaseSpread then
                            Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                            BaseSpread = Config_2.BaseSpread
                            if not BaseSpread then
                                BaseSpread = Config_2.Spread
                            end
                            v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                            u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                        end
                        v12 = u214
                        GunFired = v12.GunFired
                        v15 = u185
                        GunFired:Fire(v15)
                        u185:Shoot()
                        u185.PrimaryAttackStart = nil
                        u185.Charging = false
                        if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                            u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                        end
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                local v2 = u185
                                local AmmoUpdated = v2.Config.AmmoUpdated
                                local v3 = u185
                                AmmoUpdated(v1, v3.Viewmodel.Model, {
                                    Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                    StoredAmmo = u185.StoredAmmo,
                                })
                            end)
                        end
                        if u185.Config.StaminaUsed then
                            v12 = LocalPlayerController
                            v15 = u185
                            StaminaUsed = v15.Config.StaminaUsed
                            v16 = u185
                            StaminaCooldown = v16.Config.StaminaCooldown
                            v12:DrainStamina(StaminaUsed, StaminaCooldown)
                        end
                        if not u185.Config.IsMelee then
                            u214.AmmoChanged:Fire()
                        else
                            LocalPlayerController.BlockPressed = false
                            u214.SecondaryAttackDown = false
                            u185.MeleeStart = os.clock()
                            u185.Meleeing = true
                            u203 = false
                        end
                        v12 = os.clock()
                        if not u185.LastShot then
                            v14 = v12
                        else
                            v15 = u185.LastShot + v3
                            if not (v12 - v15 < v3 * 0.5) then
                                v14 = v12
                            else
                                v14 = v15
                            end
                        end
                        v15 = u185
                        if not u185.DoingHeavy then
                            v17 = 0
                        else
                            v17 = HeavyDelayPerShot - v3
                            if not v17 then
                                v17 = 0
                            end
                        end
                        v15.LastShot = v14 + v17
                        if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                            u214:DualWieldAlternate()
                        end
                        if u185.FireMode == "Burst" and not u185.Bursting then
                            u185.Bursting = true
                        end
                        if u185.Bursting then
                            if not u185.CurrentShot then
                                u185.CurrentShot = 1
                            end
                            v15 = u185
                            v15.CurrentShot = v15.CurrentShot + 1
                            v15 = u185
                            CurrentShot = v15.CurrentShot
                            if u185.Config.BurstAmt < CurrentShot then
                                v15 = (u185.Config.BurstDelay or 0) * v13
                                u185.CurrentShot = 1
                                u185.Bursting = false
                                u185.LastShot = os.clock() + v15
                                u185.MouseReleased = false
                            end
                        end
                        if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                            u185.MouseReleased = false
                        end
                        if u185.Config.PrimeAction then
                            u185.Priming = false
                            if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                u185.Primed = false
                            end
                        end
                    elseif u202 then
                        u202 = false
                        if not u185.StartSFX then
                            if u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                        elseif not u185.Config.HasSuppressor then
                            v10 = LoopSFX
                            v12 = u185
                            v10:Start(v12)
                        elseif u185.Config.ShootSingle then
                            ShootSingle = u185.Config.ShootSingle
                            if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                ShootSingle = u185.Config.SuppressorShootSingle
                            end
                            SoundUtil:PlaySound(ShootSingle)
                        end
                        if u185.Config.LayeredSFXs then
                            LayeredSFXs = u185.Config.LayeredSFXs
                            v11 = nil
                            v12 = nil
                            for i214, i215 in LayeredSFXs, v11, v12 do
                                v16 = tonumber(i214)
                                if not (0 < v16) then
                                    v16 = i215
                                    v17 = nil
                                    v18 = nil
                                    for i216, i217 in v16, v17, v18 do
                                        SoundUtil:PlaySound(i217)
                                    end
                                else
                                    v16 = i215
                                    v17 = nil
                                    v18 = nil
                                    for i218, i219 in v16, v17, v18 do
                                        task.delay(i214, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i219 (val)
                                            local v1 = SoundUtil
                                            local v2 = i219
                                            v1:PlaySound(v2)
                                        end)
                                    end
                                end
                            end
                        end
                        if u185.AutoLoop and not u185.AutoLoop.Playing then
                            u185.AutoLoop:Play()
                        end
                        v10 = 100
                        v11 = false
                        if LocalPlayerController.States.Crouching then
                            if not Config_2.CrouchSpreadReduction then
                                v10 = 50
                            else
                                v10 = Config_2.CrouchSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if LocalPlayerController.States.Proning then
                            if not Config_2.ProneSpreadReduction then
                                v10 = 25
                            else
                                v10 = Config_2.ProneSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                            if v11 then
                                v10 = v10 * 1.65
                            end
                            v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                        end
                        if Config_2.Spread or Config_2.BaseSpread then
                            Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                            BaseSpread = Config_2.BaseSpread
                            if not BaseSpread then
                                BaseSpread = Config_2.Spread
                            end
                            v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                            u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                        end
                        v12 = u214
                        GunFired = v12.GunFired
                        v15 = u185
                        GunFired:Fire(v15)
                        u185:Shoot()
                        u185.PrimaryAttackStart = nil
                        u185.Charging = false
                        if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                            u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                        end
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                local v2 = u185
                                local AmmoUpdated = v2.Config.AmmoUpdated
                                local v3 = u185
                                AmmoUpdated(v1, v3.Viewmodel.Model, {
                                    Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                    StoredAmmo = u185.StoredAmmo,
                                })
                            end)
                        end
                        if u185.Config.StaminaUsed then
                            v12 = LocalPlayerController
                            v15 = u185
                            StaminaUsed = v15.Config.StaminaUsed
                            v16 = u185
                            StaminaCooldown = v16.Config.StaminaCooldown
                            v12:DrainStamina(StaminaUsed, StaminaCooldown)
                        end
                        if not u185.Config.IsMelee then
                            u214.AmmoChanged:Fire()
                        else
                            LocalPlayerController.BlockPressed = false
                            u214.SecondaryAttackDown = false
                            u185.MeleeStart = os.clock()
                            u185.Meleeing = true
                            u203 = false
                        end
                        v12 = os.clock()
                        if not u185.LastShot then
                            v14 = v12
                        else
                            v15 = u185.LastShot + v3
                            if not (v12 - v15 < v3 * 0.5) then
                                v14 = v12
                            else
                                v14 = v15
                            end
                        end
                        v15 = u185
                        if not u185.DoingHeavy then
                            v17 = 0
                        else
                            v17 = HeavyDelayPerShot - v3
                            if not v17 then
                                v17 = 0
                            end
                        end
                        v15.LastShot = v14 + v17
                        if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                            u214:DualWieldAlternate()
                        end
                        if u185.FireMode == "Burst" and not u185.Bursting then
                            u185.Bursting = true
                        end
                        if u185.Bursting then
                            if not u185.CurrentShot then
                                u185.CurrentShot = 1
                            end
                            v15 = u185
                            v15.CurrentShot = v15.CurrentShot + 1
                            v15 = u185
                            CurrentShot = v15.CurrentShot
                            if u185.Config.BurstAmt < CurrentShot then
                                v15 = (u185.Config.BurstDelay or 0) * v13
                                u185.CurrentShot = 1
                                u185.Bursting = false
                                u185.LastShot = os.clock() + v15
                                u185.MouseReleased = false
                            end
                        end
                        if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                            u185.MouseReleased = false
                        end
                        if u185.Config.PrimeAction then
                            u185.Priming = false
                            if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                u185.Primed = false
                            end
                        end
                    elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                        u202 = false
                        if not u185.StartSFX then
                            if u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                        elseif not u185.Config.HasSuppressor then
                            v10 = LoopSFX
                            v12 = u185
                            v10:Start(v12)
                        elseif u185.Config.ShootSingle then
                            ShootSingle = u185.Config.ShootSingle
                            if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                ShootSingle = u185.Config.SuppressorShootSingle
                            end
                            SoundUtil:PlaySound(ShootSingle)
                        end
                        if u185.Config.LayeredSFXs then
                            LayeredSFXs = u185.Config.LayeredSFXs
                            v11 = nil
                            v12 = nil
                            for i220, i221 in LayeredSFXs, v11, v12 do
                                v16 = tonumber(i220)
                                if not (0 < v16) then
                                    v16 = i221
                                    v17 = nil
                                    v18 = nil
                                    for i222, i223 in v16, v17, v18 do
                                        SoundUtil:PlaySound(i223)
                                    end
                                else
                                    v16 = i221
                                    v17 = nil
                                    v18 = nil
                                    for i224, i225 in v16, v17, v18 do
                                        task.delay(i220, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i225 (val)
                                            local v1 = SoundUtil
                                            local v2 = i225
                                            v1:PlaySound(v2)
                                        end)
                                    end
                                end
                            end
                        end
                        if u185.AutoLoop and not u185.AutoLoop.Playing then
                            u185.AutoLoop:Play()
                        end
                        v10 = 100
                        v11 = false
                        if LocalPlayerController.States.Crouching then
                            if not Config_2.CrouchSpreadReduction then
                                v10 = 50
                            else
                                v10 = Config_2.CrouchSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if LocalPlayerController.States.Proning then
                            if not Config_2.ProneSpreadReduction then
                                v10 = 25
                            else
                                v10 = Config_2.ProneSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                            if v11 then
                                v10 = v10 * 1.65
                            end
                            v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                        end
                        if Config_2.Spread or Config_2.BaseSpread then
                            Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                            BaseSpread = Config_2.BaseSpread
                            if not BaseSpread then
                                BaseSpread = Config_2.Spread
                            end
                            v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                            u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                        end
                        v12 = u214
                        GunFired = v12.GunFired
                        v15 = u185
                        GunFired:Fire(v15)
                        u185:Shoot()
                        u185.PrimaryAttackStart = nil
                        u185.Charging = false
                        if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                            u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                        end
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                local v2 = u185
                                local AmmoUpdated = v2.Config.AmmoUpdated
                                local v3 = u185
                                AmmoUpdated(v1, v3.Viewmodel.Model, {
                                    Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                    StoredAmmo = u185.StoredAmmo,
                                })
                            end)
                        end
                        if u185.Config.StaminaUsed then
                            v12 = LocalPlayerController
                            v15 = u185
                            StaminaUsed = v15.Config.StaminaUsed
                            v16 = u185
                            StaminaCooldown = v16.Config.StaminaCooldown
                            v12:DrainStamina(StaminaUsed, StaminaCooldown)
                        end
                        if not u185.Config.IsMelee then
                            u214.AmmoChanged:Fire()
                        else
                            LocalPlayerController.BlockPressed = false
                            u214.SecondaryAttackDown = false
                            u185.MeleeStart = os.clock()
                            u185.Meleeing = true
                            u203 = false
                        end
                        v12 = os.clock()
                        if not u185.LastShot then
                            v14 = v12
                        else
                            v15 = u185.LastShot + v3
                            if not (v12 - v15 < v3 * 0.5) then
                                v14 = v12
                            else
                                v14 = v15
                            end
                        end
                        v15 = u185
                        if not u185.DoingHeavy then
                            v17 = 0
                        else
                            v17 = HeavyDelayPerShot - v3
                            if not v17 then
                                v17 = 0
                            end
                        end
                        v15.LastShot = v14 + v17
                        if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                            u214:DualWieldAlternate()
                        end
                        if u185.FireMode == "Burst" and not u185.Bursting then
                            u185.Bursting = true
                        end
                        if u185.Bursting then
                            if not u185.CurrentShot then
                                u185.CurrentShot = 1
                            end
                            v15 = u185
                            v15.CurrentShot = v15.CurrentShot + 1
                            v15 = u185
                            CurrentShot = v15.CurrentShot
                            if u185.Config.BurstAmt < CurrentShot then
                                v15 = (u185.Config.BurstDelay or 0) * v13
                                u185.CurrentShot = 1
                                u185.Bursting = false
                                u185.LastShot = os.clock() + v15
                                u185.MouseReleased = false
                            end
                        end
                        if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                            u185.MouseReleased = false
                        end
                        if u185.Config.PrimeAction then
                            u185.Priming = false
                            if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                u185.Primed = false
                            end
                        end
                    end
                end
            end
            if not u185.Primed and not u185.Reloading then
                Pump = u185.Viewmodel.Animations.Pump
                if Pump then
                    Pump.Priority = Enum.AnimationPriority.Action3
                    Length_3 = Pump.Length
                    v10 = u185
                    v12 = Length_3 / (v10.Config.BoltAnimationTime or v3)
                    v14 = u185
                    Viewmodel_7 = v14.Viewmodel
                    v19 = v12 * v2
                    Viewmodel_7:PlayAnimation("Pump", 0, 1, v19)
                end
                u185.Primed = true
                u185.LastShot = os.clock()
            end
            ActiveWeapons_2, ActiveWeapons_3, ActiveWeapons_4 = DualWield:GetActiveWeapons()
            v8 = ActiveWeapons_2
            v9 = ActiveWeapons_3
            v10 = ActiveWeapons_4
            for i226, i227 in v8, v9, v10 do
                i227.SecondaryAttackDown = u214.SecondaryAttackDown
            end
            if u185.LoopSFX_Playing then
                if not u214.PrimaryAttackDown
                    or not v23
                    or u185.Ammo <= 0
                    or u185.Reloading
                    or QuickSwap:IsActive() then
                    v8 = LoopSFX
                    v10 = u185
                    v8:Stop(v10)
                end
            end
        end
        if DualWield:IsActive() then
            Weapons, Weapons_2 = DualWield:GetWeapons()
            v25 = nil
            if u185 ~= Weapons then
                if u185 == Weapons_2 and Weapons then
                    v25 = Weapons
                end
            elseif Weapons_2 then
                v25 = Weapons_2
            elseif u185 == Weapons_2 and Weapons then
                v25 = Weapons
            end
            if v25 and v25.Reloading then
                v3 = game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1
                v4 = 1
                if SkillTreeData and SkillTreeData.ReloadSpeedMult then
                    v4 = Fusion.peek(SkillTreeData.ReloadSpeedMult)
                end
                v5 = v3 * v4
                if v25.ReloadingTime then
                    v25.ReloadingTime = v25.ReloadingTime - v1
                    if v25.ReloadingTime <= 0 then
                        v25.ReloadingTime = 0
                        if v25.Config.UsesLoadLoop then
                            if v25.LoopStage == 1 then
                                v25.LoopStage = 2
                                v25.IncreasedAmmo = true
                            end
                            if v25.LoopStage == 2 then
                                if v25.StoredAmmo <= 0 then
                                    v25.LoopStage = 3
                                else
                                    Ammo_3 = v25.Ammo
                                    if v25.Config.Ammo <= Ammo_3 then
                                        v25.LoopStage = 3
                                    end
                                end
                                if not v25.IncreasedAmmo then
                                    if v25.LoopStage == 2 then
                                        StoredAmmo_2 = v25.Config.AmmoPerLoad or 1
                                        if v25.StoredAmmo < StoredAmmo_2 then
                                            StoredAmmo_2 = v25.StoredAmmo
                                        end
                                        v7 = StoredAmmo_2 + v25.Ammo
                                        if not (v25.Config.Ammo < v7) then
                                            v25.Ammo = v25.Ammo + StoredAmmo_2
                                        else
                                            v25.Ammo = v25.Config.Ammo
                                        end
                                        v25.StoredAmmo = v25.StoredAmmo - StoredAmmo_2
                                        u214.AmmoChanged:Fire()
                                        v25.ReloadingTime = (v25.Config.InsertTime - v25.Config.IncrAmmoCountTime) * v13 * v5
                                        v25.IncreasedAmmo = true
                                    end
                                elseif v25.LoopStage == 2 then
                                    LoadLoop_2 = v25.Viewmodel.Animations.LoadLoop
                                    if LoadLoop_2 then
                                        LoadLoop_2.Priority = Enum.AnimationPriority.Action4
                                        Length_4 = LoadLoop_2.Length
                                        InsertAnimationTime_2 = v25.Config.InsertAnimationTime
                                        if not InsertAnimationTime_2 then
                                            InsertAnimationTime_2 = v25.Config.InsertTime
                                        end
                                        v9 = Length_4 / InsertAnimationTime_2
                                        Viewmodel_8 = v25.Viewmodel
                                        v16 = v9 * v2 / v5
                                        Viewmodel_8:PlayAnimation("LoadLoop", 0, 1, v16)
                                    end
                                    v25.ReloadingTime = v25.Config.IncrAmmoCountTime * v13 * v5
                                    v25.IncreasedAmmo = false
                                end
                            end
                            if v25.LoopStage == 3 then
                                v25.Viewmodel:StopAnimation("LoadLoop")
                                v25.Viewmodel:StopAnimation("LoadIdle")
                                v25.Viewmodel:StopAnimation("LoadStart")
                                v25.Viewmodel:StopAnimation("LoadStartEmpty")
                                LoadStop_2 = v25.Viewmodel.Animations.LoadStop
                                if LoadStop_2 then
                                    Length_5 = LoadStop_2.Length
                                    LoadStopAnimationTime_2 = v25.Config.LoadStopAnimationTime
                                    if not LoadStopAnimationTime_2 then
                                        LoadStopAnimationTime_2 = v25.Config.LoadStartTime
                                    end
                                    v9 = Length_5 / LoadStopAnimationTime_2
                                    Viewmodel_9 = v25.Viewmodel
                                    v16 = v9 * v2 / v5
                                    Viewmodel_9:PlayAnimation("LoadStop", 0, 1, v16)
                                end
                                v25.LoopStage = 4
                            end
                            if not v25.Reloaded and v25.LoopStage == 4 then
                                v25.Reloading = false
                                v25.Reloaded = true
                                v25.CancelReload = false
                                u214:DualWieldReloadComplete(v25)
                            end
                        elseif not v25.Reloaded then
                            v25.Reloading = false
                            if v25.newAmmo then
                                v25.Ammo = v25.newAmmo[1]
                                v25.StoredAmmo = v25.newAmmo[2]
                                u214.AmmoChanged:Fire()
                                v25.newAmmo = nil
                            end
                            v25.Reloaded = true
                            v25:ReloadFinished()
                            u214:DualWieldReloadComplete(v25)
                        end
                    end
                end
                if v25.Ammo <= 0 and not v25.Reloading and 0 < v25.StoredAmmo then
                    u214:DualWieldAutoReload(v25)
                end
            end
        end
        return
    end
    if LocalPlayerController.hrp
        and LocalPlayerController.hrp.Parent
        and LocalPlayerController.humanoid.Humanoid
        and not (LocalPlayerController.humanoid.Humanoid.Health <= 0) then
        v2 = 1
        v13 = 1
        if LocalPlayerController.FocusEnabled then
            v2 = 2
            v13 = 0.5
        end
        if not ShellSystem.UsingViewmodelStep then
            ShellSystem:Update(p1)
        end
        if not u185 or not u185.Config or not u185.Config.IsMelee then
            u214.Blocking = false
            u214.Parrying = false
        else
            Melee.Think(u185, p1, LocalPlayerController)
            u214.Blocking = u185.Blocking
            if not u185.Blocking then
                if not u185.Blocking then
                    u185.ParryTime = nil
                    u214.Parrying = false
                end
            elseif u185.ParryTime then
                v20 = u214
                v21 = os.clock() <= u185.ParryTime
                v20.Parrying = v21
            elseif not u185.Blocking then
                u185.ParryTime = nil
                u214.Parrying = false
            end
        end
        if not u185 or not u185.Charging then
            if HUDService.Elements.StaminaDisplay and HUDService.Elements.StaminaDisplay.ChargeDisplay then
                StaminaDisplay = HUDService.Elements.StaminaDisplay
                StaminaDisplay.ChargeDisplay = false
                HUDService.Elements.StaminaDisplay:ChargeNotReady()
            end
        elseif u185
            and u185.Charging
            and (LocalPlayerController:GetStamina()) < (u185.Config.HeavyStaminaRequired or 9999999)
            and HUDService.Elements.StaminaDisplay
            and HUDService.Elements.StaminaDisplay.ChargeDisplay then
            StaminaDisplay = HUDService.Elements.StaminaDisplay
            StaminaDisplay.ChargeDisplay = false
            HUDService.Elements.StaminaDisplay:ChargeNotReady()
        end
        ActiveWeapons = DualWield:GetActiveWeapons()
        v21 = ActiveWeapons
        v22 = nil
        v23 = nil
        for i, j in v21, v22, v23 do
            Config_8 = j.Config
            if not j.ShootingInaccuracy then
                j.ShootingInaccuracy = 0
            end
            BaseSpread_2 = Config_8.BaseSpread
            if not BaseSpread_2 then
                BaseSpread_2 = Config_8.Spread
            end
            if BaseSpread_2 then
                Attribute_2 = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                BaseSpread_2 = BaseSpread_2 * (GameState.Data.Variables.WeaponSpread * (Attribute_2 or 1))
            end
            v4 = Lerp
            ShootingInaccuracy = j.ShootingInaccuracy
            v8 = v1 / (Config_8.ShootingSpreadDecay or 0.3)
            j.ShootingInaccuracy = v4(ShootingInaccuracy, 0, (math.min(v8, 1)))
            v4 = 1
            v5 = false
            if LocalPlayerController.States.Crouching or LocalPlayerController.States.Sliding then
                v4 = v4 * (Config_8.CrouchSpreadReduction or 0.5)
                v5 = true
            elseif LocalPlayerController.States.Proning then
                v4 = v4 * (Config_8.ProneSpreadReduction or 0.25)
                v5 = true
            end
            if not j.Aiming or not j.ADSStrength or not (0.9 < j.ADSStrength) then
                if not BaseSpread_2 then
                    v7 = 0
                else
                    v9 = BaseSpread_2
                    v7 = math.deg(v9) * 2
                    if not v7 then
                        v7 = 0
                    end
                end
                j.Inaccuracy = v7 * v4
                v7 = j.Inaccuracy + j.ShootingInaccuracy
                if LocalPlayerController.humanoid.HasLanded then
                    v8 = 0
                else
                    v8 = Config_8.AirSpread or 25
                end
                j.Inaccuracy = v7 + v8
                Inaccuracy_2 = j.Inaccuracy
                j.Inaccuracy = math.max(0, Inaccuracy_2)
            else
                if v5 then
                    v4 = v4 * 1.65
                end
                v4 = v4 * (Config_8.ADSSpreadReduction or 0.75)
                if not BaseSpread_2 then
                    v7 = 0
                else
                    v9 = BaseSpread_2
                    v7 = math.deg(v9) * 2
                    if not v7 then
                        v7 = 0
                    end
                end
                j.Inaccuracy = v7 * v4
                Inaccuracy = j.Inaccuracy
                j.Inaccuracy = math.max(0, Inaccuracy)
            end
        end
        if 0 < #ActiveWeapons then
            u214.InaccuracyUpdated:Fire()
        end
        if u189 then
            v20 = u195[u189]
            v22 = Fusion
            peek_2 = v22.peek
            v23 = SkillTreeData
            v22 = peek_2(v23.MeleeSwingSpeedMult)
            v22 = v20.Config.DelayPerShot / (v22 or 1)
            v24 = os.clock() - v22
            v23 = (v20.LastShot or 0) <= v24
            if not v23 or not LocalPlayerController.BlockPressed then
                if LocalPlayerController.BlockPressed or not u191 or not u185 then
                    if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u185.Slot == u189 then
                    u191 = false
                    if u192 < 0.25 then
                        u203 = true
                    elseif not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif u195[u189] then
                Stamina_2 = LocalPlayerController:GetStamina()
                if not (u195[u189].Config.StaminaRequired <= Stamina_2) then
                    if LocalPlayerController.BlockPressed or not u191 or not u185 then
                        if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                            u187 = u190
                            u205 = false
                        end
                    elseif u185.Slot == u189 then
                        u191 = false
                        if u192 < 0.25 then
                            u203 = true
                        elseif not u204 then
                            u187 = u190
                            u205 = false
                        end
                    elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif not LocalPlayerController.States.IsDowned then
                    if not u185 or u185.Slot ~= u189 or u205 then
                        u205 = true
                        u204 = false
                        u187 = u189
                        if v20 then
                            v20.QuickEquip = true
                        end
                    else
                        u204 = true
                    end
                    u191 = true
                elseif LocalPlayerController.BlockPressed or not u191 or not u185 then
                    if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u185.Slot == u189 then
                    u191 = false
                    if u192 < 0.25 then
                        u203 = true
                    elseif not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif LocalPlayerController.BlockPressed or not u191 or not u185 then
                if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif u185.Slot == u189 then
                u191 = false
                if u192 < 0.25 then
                    u203 = true
                elseif not u204 then
                    u187 = u190
                    u205 = false
                end
            elseif u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                u187 = u190
                u205 = false
            end
            if not LocalPlayerController.BlockPressed then
                u192 = 0
            else
                u192 = u192 + v1
            end
        end
        if u203 then
            if not u203 or not u185 then
                if not u203 or not u185 or u185.Slot ~= u189 then
                    if u203 and not u185 then
                        if u203 then
                            u187 = u189
                        end
                        if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                            if not Fusion.peek(SkillTreeData.HasLastStand) then
                                u187 = u194
                            else
                                v21 = u187
                                v20 = tostring(v21)
                                if v20 ~= "1" and v20 ~= "2" then
                                    if not u185 then
                                        Slot_2 = u194
                                    elseif u185.Slot == "1" then
                                        Slot_2 = u185.Slot
                                    elseif u185.Slot ~= "2" then
                                        Slot_2 = u194
                                    else
                                        Slot_2 = u185.Slot
                                    end
                                    u187 = Slot_2
                                end
                            end
                        end
                        if not u187 or not u195[u187] then
                            if not u187 and u185 and not u186 and not u188 then
                                SwapWeapon()
                            end
                        elseif not u185 then
                            if u185 then
                                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                    u185.CancelUnequip = true
                                end
                            elseif not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 ~= u195[u187] then
                            if not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    end
                elseif not u185.IsEquipped or u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif u185.Slot ~= u189 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif not u203 or not u185 or u185.Slot ~= u189 then
                if u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif not u185.IsEquipped or u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif not u185 then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        elseif not u185 then
            if not u203 or not u185 then
                if not u203 or not u185 or u185.Slot ~= u189 then
                    if u203 and not u185 then
                        if u203 then
                            u187 = u189
                        end
                        if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                            if not Fusion.peek(SkillTreeData.HasLastStand) then
                                u187 = u194
                            else
                                v21 = u187
                                v20 = tostring(v21)
                                if v20 ~= "1" and v20 ~= "2" then
                                    if not u185 then
                                        Slot_2 = u194
                                    elseif u185.Slot == "1" then
                                        Slot_2 = u185.Slot
                                    elseif u185.Slot ~= "2" then
                                        Slot_2 = u194
                                    else
                                        Slot_2 = u185.Slot
                                    end
                                    u187 = Slot_2
                                end
                            end
                        end
                        if not u187 or not u195[u187] then
                            if not u187 and u185 and not u186 and not u188 then
                                SwapWeapon()
                            end
                        elseif not u185 then
                            if u185 then
                                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                    u185.CancelUnequip = true
                                end
                            elseif not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 ~= u195[u187] then
                            if not u186 and not u188 then
                                SwapWeapon(u187)
                            end
                        elseif u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    end
                elseif not u185.IsEquipped or u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif u185.Slot ~= u189 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif not u203 or not u185 or u185.Slot ~= u189 then
                if u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif not u185.IsEquipped or u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif not u185.Meleeing then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        elseif not u203 or not u185 then
            if not u203 or not u185 or u185.Slot ~= u189 then
                if u203 and not u185 then
                    if u203 then
                        u187 = u189
                    end
                    if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                        if not Fusion.peek(SkillTreeData.HasLastStand) then
                            u187 = u194
                        else
                            v21 = u187
                            v20 = tostring(v21)
                            if v20 ~= "1" and v20 ~= "2" then
                                if not u185 then
                                    Slot_2 = u194
                                elseif u185.Slot == "1" then
                                    Slot_2 = u185.Slot
                                elseif u185.Slot ~= "2" then
                                    Slot_2 = u194
                                else
                                    Slot_2 = u185.Slot
                                end
                                u187 = Slot_2
                            end
                        end
                    end
                    if not u187 or not u195[u187] then
                        if not u187 and u185 and not u186 and not u188 then
                            SwapWeapon()
                        end
                    elseif not u185 then
                        if u185 then
                            if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                u185.CancelUnequip = true
                            end
                        elseif not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 ~= u195[u187] then
                        if not u186 and not u188 then
                            SwapWeapon(u187)
                        end
                    elseif u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                end
            elseif not u185.IsEquipped or u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif u185.Slot ~= u189 then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        elseif not u203 or not u185 or u185.Slot ~= u189 then
            if u203 and not u185 then
                if u203 then
                    u187 = u189
                end
                if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                    if not Fusion.peek(SkillTreeData.HasLastStand) then
                        u187 = u194
                    else
                        v21 = u187
                        v20 = tostring(v21)
                        if v20 ~= "1" and v20 ~= "2" then
                            if not u185 then
                                Slot_2 = u194
                            elseif u185.Slot == "1" then
                                Slot_2 = u185.Slot
                            elseif u185.Slot ~= "2" then
                                Slot_2 = u194
                            else
                                Slot_2 = u185.Slot
                            end
                            u187 = Slot_2
                        end
                    end
                end
                if not u187 or not u195[u187] then
                    if not u187 and u185 and not u186 and not u188 then
                        SwapWeapon()
                    end
                elseif not u185 then
                    if u185 then
                        if u185 and u185 == u195[u187] and not u185.IsEquipped then
                            u185.CancelUnequip = true
                        end
                    elseif not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 ~= u195[u187] then
                    if not u186 and not u188 then
                        SwapWeapon(u187)
                    end
                elseif u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            end
        elseif not u185.IsEquipped or u203 and not u185 then
            if u203 then
                u187 = u189
            end
            if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                if not Fusion.peek(SkillTreeData.HasLastStand) then
                    u187 = u194
                else
                    v21 = u187
                    v20 = tostring(v21)
                    if v20 ~= "1" and v20 ~= "2" then
                        if not u185 then
                            Slot_2 = u194
                        elseif u185.Slot == "1" then
                            Slot_2 = u185.Slot
                        elseif u185.Slot ~= "2" then
                            Slot_2 = u194
                        else
                            Slot_2 = u185.Slot
                        end
                        u187 = Slot_2
                    end
                end
            end
            if not u187 or not u195[u187] then
                if not u187 and u185 and not u186 and not u188 then
                    SwapWeapon()
                end
            elseif not u185 then
                if u185 then
                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                        u185.CancelUnequip = true
                    end
                elseif not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 ~= u195[u187] then
                if not u186 and not u188 then
                    SwapWeapon(u187)
                end
            elseif u185 then
                if u185 and u185 == u195[u187] and not u185.IsEquipped then
                    u185.CancelUnequip = true
                end
            elseif not u186 and not u188 then
                SwapWeapon(u187)
            end
        end
        if u214.MobileShootDown then
            u214.PrimaryAttackDown = true
        elseif u206 then
            u214.PrimaryAttackDown = false
        end
        v20 = AutoShoot:CheckTarget()
        if u207 ~= v20 then
            u214.TargetChanged:Fire(v20)
            u207 = v20
        end
        if not u206
            or not peek(Settings.Controls.AutoShoot)
            or not u185
            or u185.Config.IsMelee
            or u185.Config.Deployable
            or not (0 < u185.Ammo)
            or u185.Primed == false then
            if u214.PrimaryAttackDown
                and u206
                and peek(Settings.Controls.AutoShoot)
                and not u214.MobileShootDown
                and u185
                and not u185.Config.IsMelee then
                u214.PrimaryAttackDown = false
            end
        elseif v20 then
            u214.PrimaryAttackDown = true
            u185.MouseReleased = true
        elseif u214.PrimaryAttackDown
            and u206
            and peek(Settings.Controls.AutoShoot)
            and not u214.MobileShootDown
            and u185
            and not u185.Config.IsMelee then
            u214.PrimaryAttackDown = false
        end
        if u185 then
            FireWhileSprinting = u185.Config.FireWhileSprinting
        end
        QuickDrawActive = u185
        if QuickDrawActive then
            QuickDrawActive = u185.QuickDrawActive
        end
        if not u185 then
            v23 = not LocalPlayerController.States.Sprinting
            if v23 then
                v23 = QuickDrawActive
                if not v23 then
                    v24 = 0.1 < SharedSprings.EquipSpring.Position
                    v23 = not v24
                end
            end
        elseif u185.Config.IsMelee then
            v23 = QuickDrawActive
            if not v23 then
                v24 = 0.1 < SharedSprings.EquipSpring.Position
                v23 = not v24
            end
        else
            v23 = not LocalPlayerController.States.Sprinting
            if v23 then
                v23 = QuickDrawActive
                if not v23 then
                    v24 = 0.1 < SharedSprings.EquipSpring.Position
                    v23 = not v24
                end
            end
        end
        if u185 then
            v25 = (game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1) * Fusion.peek(SkillTreeData.ReloadSpeedMult)
            if u185.Reloading
                and u214.PrimaryAttackDown
                and u185.Config.UsesLoadLoop
                and 0 < u185.Ammo
                and u185.MouseReleased then
                if not u185.Config.UsesLoadLoop or not u185.Config.LoadStopOnReload then
                    u185.CancelReload = true
                else
                    u185.ReloadingTime = u185.Config.LoadStopTime * v25
                    u185.LoopStage = 3
                end
            end
            if u185.ReloadingTime then
                if u185.ReloadingTime <= 0 then
                    u185.ReloadingTime = 0
                    if u185.Config.UsesLoadLoop then
                        if u185.LoopStage == 1 then
                            if not u185.Config.ShouldNotCycleAfterReload
                                and u185.Config.PrimeAction
                                and u185.Ammo <= 0 then
                                u185.Priming = false
                                u185.Primed = false
                            end
                            u185.CancelReload = false
                            u185.LoopStage = 2
                            u185.IncreasedAmmo = true
                        end
                        if u185.LoopStage == 2 then
                            if u185.StoredAmmo <= 0 then
                                u185.LoopStage = 3
                            else
                                v3 = u185
                                Ammo_2 = v3.Ammo
                                if u185.Config.Ammo <= Ammo_2 or u185.CancelReload then
                                    u185.LoopStage = 3
                                end
                            end
                            if not u185.IncreasedAmmo then
                                if u185.LoopStage == 2 then
                                    StoredAmmo = u185.Config.AmmoPerLoad or 1
                                    if u185.StoredAmmo < StoredAmmo then
                                        StoredAmmo = u185.StoredAmmo
                                    end
                                    v4 = StoredAmmo + u185.Ammo
                                    if not (u185.Config.Ammo < v4) then
                                        v4 = u185
                                        v4.Ammo = v4.Ammo + StoredAmmo
                                    else
                                        u185.Ammo = u185.Config.Ammo
                                    end
                                    v4 = u185
                                    v4.StoredAmmo = v4.StoredAmmo - StoredAmmo
                                    if u185.Config.AmmoUpdated then
                                        task.defer(function() -- Line: 1324 -- upvalues: u185 (upval), StoredAmmo (ref)
                                            local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                            local v2 = u185
                                            local AmmoUpdated = v2.Config.AmmoUpdated
                                            local v3 = u185
                                            AmmoUpdated(v1, v3.Viewmodel.Model, {
                                                Ammo = u185.Ammo - StoredAmmo,
                                                StoredAmmo = u185.StoredAmmo - StoredAmmo,
                                            })
                                        end)
                                    end
                                    u214.AmmoChanged:Fire()
                                    u214.Reloaded:Fire()
                                    u185.ReloadingTime = (u185.Config.InsertTime - u185.Config.IncrAmmoCountTime) * v13 * v25
                                    u185.IncreasedAmmo = true
                                end
                            elseif u185.LoopStage == 2 then
                                LoadLoop = u185.Viewmodel.Animations.LoadLoop
                                if LoadLoop then
                                    LoadLoop.Priority = Enum.AnimationPriority.Action4
                                    Length = LoadLoop.Length
                                    InsertAnimationTime = u185.Config.InsertAnimationTime
                                    if not InsertAnimationTime then
                                        InsertAnimationTime = u185.Config.InsertTime
                                    end
                                    v6 = Length / InsertAnimationTime
                                    v7 = u185
                                    Viewmodel = v7.Viewmodel
                                    v12 = v6 * v2 / v25
                                    Viewmodel:PlayAnimation("LoadLoop", 0, 1, v12)
                                end
                                u185.ReloadingTime = u185.Config.IncrAmmoCountTime * v13 * v25
                                u185.IncreasedAmmo = false
                            end
                        end
                        if u185.LoopStage == 3 then
                            if not u185.CancelReload then
                                v3 = nil
                            else
                                v3 = 0
                            end
                            v4 = u185
                            Viewmodel_2 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_2:StopAnimation("LoadLoop", v7)
                            v4 = u185
                            Viewmodel_3 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_3:StopAnimation("LoadIdle", v7)
                            v4 = u185
                            Viewmodel_4 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_4:StopAnimation("LoadStart", v7)
                            v4 = u185
                            Viewmodel_5 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_5:StopAnimation("LoadStartEmpty", v7)
                            LoadStop = u185.Viewmodel.Animations.LoadStop
                            if LoadStop and not u185.CancelReload then
                                Length_2 = LoadStop.Length
                                LoadStopAnimationTime = u185.Config.LoadStopAnimationTime
                                if not LoadStopAnimationTime then
                                    LoadStopAnimationTime = u185.Config.LoadStartTime
                                end
                                v7 = Length_2 / LoadStopAnimationTime
                                v8 = u185
                                Viewmodel_6 = v8.Viewmodel
                                v14 = v7 * v2 / v25
                                Viewmodel_6:PlayAnimation("LoadStop", 0, 1, v14)
                            end
                            CancelReload_2 = u185.CancelReload
                            u185.CancelReload = false
                            u185.LoopStage = 4
                            u867 = u185
                            Slot = u867.Slot
                            Ammo = u867.Ammo
                            task.defer(function() -- Line: 1362 -- upvalues: u867 (val), CancelReload (upval), Slot (val), Ammo (val), u214 (upval)
                                if u867.IsDestroyed then
                                    return
                                end
                                local v1 = CancelReload
                                local v2 = {Slot, Ammo}
                                v1 = v1:Call(v2)
                                v1:After(function(p1, p2) -- Line: 1366 -- upvalues: u867 (upval), Ammo (upval), u214 (upval)
                                    if p1 and p2 and u867 and not u867.IsDestroyed then
                                        local v1 = Ammo - u867.Ammo
                                        p2[1] = p2[1] - v1
                                        u867.newAmmo = p2
                                        u867.ServerFinishedReload = true
                                        u867.Ammo = u867.newAmmo[1]
                                        u867.StoredAmmo = u867.newAmmo[2]
                                        if u867.Config.AmmoUpdated then
                                            task.defer(function() -- Line: 1376 -- upvalues: u867 (upval)
                                                local v1 = {Ammo = u867.Ammo, StoredAmmo = u867.StoredAmmo}
                                                u867.Config.AmmoUpdated(v1, u867.Viewmodel.Model, v1)
                                            end)
                                        end
                                        u214.AmmoChanged:Fire()
                                        u214.Reloaded:Fire()
                                        u867.newAmmo = nil
                                        return
                                    end
                                    warn(p2)
                                end)
                            end)
                        elseif not u185.Reloaded and u185.LoopStage == 4 then
                            u185.Reloading = false
                            u185.Reloaded = true
                            u185.CancelReload = false
                            if DualWield:IsActive() then
                                v3 = u214
                                v5 = u185
                                v3:DualWieldReloadComplete(v5)
                            end
                        end
                    elseif not u185.Reloaded then
                        u185.Reloading = false
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1408 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                u185.Config.AmmoUpdated(v1, u185.Viewmodel.Model, v1)
                            end)
                        end
                        if u185.newAmmo then
                            print("Updated Client ammo: NewAmmo Object", u185.newAmmo)
                            u185.Ammo = u185.newAmmo[1]
                            u185.StoredAmmo = u185.newAmmo[2]
                            u214.AmmoChanged:Fire()
                            u214.Reloaded:Fire()
                            u185.newAmmo = nil
                        end
                        u185.Reloaded = true
                        u185:ReloadFinished()
                        if DualWield:IsActive() then
                            v3 = u214
                            v5 = u185
                            v3:DualWieldReloadComplete(v5)
                        end
                    end
                elseif not u185.CancelReload then
                    if not u185.Config.UsesLoadLoop then
                        v3 = not not LocalPlayerController.FocusEnabled
                        if v3 ~= (u185.ReloadFocusActive or false) then
                            if not v3 then
                                v4 = 2
                            else
                                v4 = 0.5
                            end
                            u185.ReloadingTime = u185.ReloadingTime * v4
                            if u185.ReloadCancelTime then
                                u185.ReloadCancelTime = u185.ReloadCancelTime * v4
                            end
                            u185.ReloadFocusActive = v3
                            if u185.Viewmodel and u185.Viewmodel.Animations then
                                Animations = u185.Viewmodel.Animations
                                v6 = 1 / v4
                                v7 = {"Reload", "ReloadEmpty", "LoadStart", "LoadStartEmpty"}
                                v8 = nil
                                v9 = nil
                                for k, n in v7, v8, v9 do
                                    v12 = Animations[n]
                                    if v12 and v12.IsPlaying then
                                        v16 = v12.Speed * v6
                                        v12:AdjustSpeed(v16)
                                        break
                                    end
                                end
                            end
                        end
                    end
                    u185.ReloadingTime = u185.ReloadingTime - v1
                    if u185.ReloadingTime < (u185.ReloadCancelTime or 0) then
                        if not u185.IsEquipped then
                            u185.ReloadingTime = 0
                        end
                        if u185.newAmmo and not u185.MagInUpdate then
                            u185.MagInUpdate = true
                            u185.Ammo = u185.newAmmo[1]
                            u185.StoredAmmo = u185.newAmmo[2]
                            u214.AmmoChanged:Fire()
                            u214.Reloaded:Fire()
                            u185.newAmmo = nil
                        end
                    end
                else
                    u185.ReloadingTime = 0
                    if u185.Config.UsesLoadLoop then
                        if u185.LoopStage == 1 then
                            if not u185.Config.ShouldNotCycleAfterReload
                                and u185.Config.PrimeAction
                                and u185.Ammo <= 0 then
                                u185.Priming = false
                                u185.Primed = false
                            end
                            u185.CancelReload = false
                            u185.LoopStage = 2
                            u185.IncreasedAmmo = true
                        end
                        if u185.LoopStage == 2 then
                            if u185.StoredAmmo <= 0 then
                                u185.LoopStage = 3
                            else
                                v3 = u185
                                Ammo_2 = v3.Ammo
                                if u185.Config.Ammo <= Ammo_2 or u185.CancelReload then
                                    u185.LoopStage = 3
                                end
                            end
                            if not u185.IncreasedAmmo then
                                if u185.LoopStage == 2 then
                                    StoredAmmo = u185.Config.AmmoPerLoad or 1
                                    if u185.StoredAmmo < StoredAmmo then
                                        StoredAmmo = u185.StoredAmmo
                                    end
                                    v4 = StoredAmmo + u185.Ammo
                                    if not (u185.Config.Ammo < v4) then
                                        v4 = u185
                                        v4.Ammo = v4.Ammo + StoredAmmo
                                    else
                                        u185.Ammo = u185.Config.Ammo
                                    end
                                    v4 = u185
                                    v4.StoredAmmo = v4.StoredAmmo - StoredAmmo
                                    if u185.Config.AmmoUpdated then
                                        task.defer(function() -- Line: 1324 -- upvalues: u185 (upval), StoredAmmo (ref)
                                            local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                            local v2 = u185
                                            local AmmoUpdated = v2.Config.AmmoUpdated
                                            local v3 = u185
                                            AmmoUpdated(v1, v3.Viewmodel.Model, {
                                                Ammo = u185.Ammo - StoredAmmo,
                                                StoredAmmo = u185.StoredAmmo - StoredAmmo,
                                            })
                                        end)
                                    end
                                    u214.AmmoChanged:Fire()
                                    u214.Reloaded:Fire()
                                    u185.ReloadingTime = (u185.Config.InsertTime - u185.Config.IncrAmmoCountTime) * v13 * v25
                                    u185.IncreasedAmmo = true
                                end
                            elseif u185.LoopStage == 2 then
                                LoadLoop = u185.Viewmodel.Animations.LoadLoop
                                if LoadLoop then
                                    LoadLoop.Priority = Enum.AnimationPriority.Action4
                                    Length = LoadLoop.Length
                                    InsertAnimationTime = u185.Config.InsertAnimationTime
                                    if not InsertAnimationTime then
                                        InsertAnimationTime = u185.Config.InsertTime
                                    end
                                    v6 = Length / InsertAnimationTime
                                    v7 = u185
                                    Viewmodel = v7.Viewmodel
                                    v12 = v6 * v2 / v25
                                    Viewmodel:PlayAnimation("LoadLoop", 0, 1, v12)
                                end
                                u185.ReloadingTime = u185.Config.IncrAmmoCountTime * v13 * v25
                                u185.IncreasedAmmo = false
                            end
                        end
                        if u185.LoopStage == 3 then
                            if not u185.CancelReload then
                                v3 = nil
                            else
                                v3 = 0
                            end
                            v4 = u185
                            Viewmodel_2 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_2:StopAnimation("LoadLoop", v7)
                            v4 = u185
                            Viewmodel_3 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_3:StopAnimation("LoadIdle", v7)
                            v4 = u185
                            Viewmodel_4 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_4:StopAnimation("LoadStart", v7)
                            v4 = u185
                            Viewmodel_5 = v4.Viewmodel
                            v7 = v3
                            Viewmodel_5:StopAnimation("LoadStartEmpty", v7)
                            LoadStop = u185.Viewmodel.Animations.LoadStop
                            if LoadStop and not u185.CancelReload then
                                Length_2 = LoadStop.Length
                                LoadStopAnimationTime = u185.Config.LoadStopAnimationTime
                                if not LoadStopAnimationTime then
                                    LoadStopAnimationTime = u185.Config.LoadStartTime
                                end
                                v7 = Length_2 / LoadStopAnimationTime
                                v8 = u185
                                Viewmodel_6 = v8.Viewmodel
                                v14 = v7 * v2 / v25
                                Viewmodel_6:PlayAnimation("LoadStop", 0, 1, v14)
                            end
                            CancelReload_2 = u185.CancelReload
                            u185.CancelReload = false
                            u185.LoopStage = 4
                            u867 = u185
                            Slot = u867.Slot
                            Ammo = u867.Ammo
                            task.defer(function() -- Line: 1362 -- upvalues: u867 (val), CancelReload (upval), Slot (val), Ammo (val), u214 (upval)
                                if u867.IsDestroyed then
                                    return
                                end
                                local v1 = CancelReload
                                local v2 = {Slot, Ammo}
                                v1 = v1:Call(v2)
                                v1:After(function(p1, p2) -- Line: 1366 -- upvalues: u867 (upval), Ammo (upval), u214 (upval)
                                    if p1 and p2 and u867 and not u867.IsDestroyed then
                                        local v1 = Ammo - u867.Ammo
                                        p2[1] = p2[1] - v1
                                        u867.newAmmo = p2
                                        u867.ServerFinishedReload = true
                                        u867.Ammo = u867.newAmmo[1]
                                        u867.StoredAmmo = u867.newAmmo[2]
                                        if u867.Config.AmmoUpdated then
                                            task.defer(function() -- Line: 1376 -- upvalues: u867 (upval)
                                                local v1 = {Ammo = u867.Ammo, StoredAmmo = u867.StoredAmmo}
                                                u867.Config.AmmoUpdated(v1, u867.Viewmodel.Model, v1)
                                            end)
                                        end
                                        u214.AmmoChanged:Fire()
                                        u214.Reloaded:Fire()
                                        u867.newAmmo = nil
                                        return
                                    end
                                    warn(p2)
                                end)
                            end)
                        elseif not u185.Reloaded and u185.LoopStage == 4 then
                            u185.Reloading = false
                            u185.Reloaded = true
                            u185.CancelReload = false
                            if DualWield:IsActive() then
                                v3 = u214
                                v5 = u185
                                v3:DualWieldReloadComplete(v5)
                            end
                        end
                    elseif not u185.Reloaded then
                        u185.Reloading = false
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1408 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                u185.Config.AmmoUpdated(v1, u185.Viewmodel.Model, v1)
                            end)
                        end
                        if u185.newAmmo then
                            print("Updated Client ammo: NewAmmo Object", u185.newAmmo)
                            u185.Ammo = u185.newAmmo[1]
                            u185.StoredAmmo = u185.newAmmo[2]
                            u214.AmmoChanged:Fire()
                            u214.Reloaded:Fire()
                            u185.newAmmo = nil
                        end
                        u185.Reloaded = true
                        u185:ReloadFinished()
                        if DualWield:IsActive() then
                            v3 = u214
                            v5 = u185
                            v3:DualWieldReloadComplete(v5)
                        end
                    end
                end
            end
            if u185.Ammo <= 0 then
                if u185.Bursting then
                    u185.Bursting = false
                    u185.CurrentShot = 1
                end
            elseif not v23 and u185.Bursting then
                u185.Bursting = false
                u185.CurrentShot = 1
            end
            if not (u185.Ammo <= 0) or u185.Reloading then
                if Dry and Dry.IsPlaying then
                    Dry:Stop()
                end
            elseif not u185.Config.IsMelee then
                if u214.PrimaryAttackDown then
                    if Dry and not Dry.IsPlaying then
                        Dry:Play()
                    end
                elseif Dry then
                    Dry:Stop()
                end
                if 0 < u185.StoredAmmo then
                    if Dry then
                        Dry:Stop()
                    end
                    if not DualWield:IsActive() then
                        u214:Reload()
                    else
                        v3 = u214
                        v5 = u185
                        v3:DualWieldAutoReload(v5)
                    end
                end
            elseif Dry and Dry.IsPlaying then
                Dry:Stop()
            end
            v3 = u185.Config.DelayPerShot / GameState.Data.Variables.FireRate
            if u185.FireMode ~= "Auto" and u185.FireMode ~= "Burst" and not u185.Config.IsMelee then
                v3 = v3 * v13
            end
            if u185.Config.IsMelee then
                v3 = v3 / (Fusion.peek(SkillTreeData.MeleeSwingSpeedMult) or 1)
            end
            Config_2 = u185.Config
            ADSFireMode = nil
            ADSFireRate = nil
            if not u185.Aiming or not Config_2.ADSFireMode then
                if Config_2.HipFireMode then
                    ADSFireMode = Config_2.HipFireMode
                    ADSFireRate = Config_2.HipFireRate
                    if Config_2.VariableShotgun then
                        Config_2.Damage = Config_2.HipDmg
                        Config_2.BulletsPerShot = Config_2.HipFirePellets
                    end
                end
            elseif Config_2.ADSFireRate then
                ADSFireMode = Config_2.ADSFireMode
                ADSFireRate = Config_2.ADSFireRate
                if Config_2.VariableShotgun then
                    Config_2.Damage = Config_2.AimDmg
                    Config_2.BulletsPerShot = Config_2.ADSPellets
                end
            elseif Config_2.HipFireMode then
                ADSFireMode = Config_2.HipFireMode
                ADSFireRate = Config_2.HipFireRate
                if Config_2.VariableShotgun then
                    Config_2.Damage = Config_2.HipDmg
                    Config_2.BulletsPerShot = Config_2.HipFirePellets
                end
            end
            if ADSFireMode then
                u185.FireMode = ADSFireMode
                Config_2.DelayPerShot = ADSFireRate
                u214.FireModeChanged:Fire(ADSFireMode)
            end
            HeavyDelayPerShot = u185.Config.HeavyDelayPerShot
            if not HeavyDelayPerShot then
                HeavyDelayPerShot = u185.Config.FireRate
            end
            if HeavyDelayPerShot then
                HeavyDelayPerShot = HeavyDelayPerShot / GameState.Data.Variables.FireRate * 0.5 * v13
            end
            if not v23 then
                v9 = os.clock()
                if u185.FireMode ~= "Burst" then
                    v10 = v3
                else
                    v10 = 0
                end
                v8 = v9 - v10
                if (u185.LastShot or 0) <= v8 then
                    u185.MouseReleased = true
                end
            elseif u214.PrimaryAttackDown then
                if u185.Busy then
                    v9 = os.clock()
                    if u185.FireMode ~= "Burst" then
                        v10 = v3
                    else
                        v10 = 0
                    end
                    v8 = v9 - v10
                    if (u185.LastShot or 0) <= v8 then
                        u185.MouseReleased = true
                    end
                else
                    if DualWield:IsActive() and u214.PrimaryAttackDown then
                        v8, v9 = u214:DualWieldFire()
                        if v8 and v9 then
                            Config_2 = u185.Config
                            FireRate = Config_2.FireRate
                            if not FireRate then
                                FireRate = Config_2.DelayPerShot
                                if not FireRate then
                                    FireRate = 0.15
                                end
                            end
                            v3 = FireRate / GameState.Data.Variables.FireRate * v13
                        end
                    end
                    v9 = os.clock() - v3
                    v8 = (u185.LastShot or 0) <= v9
                    MouseReleased = v8
                    if MouseReleased then
                        MouseReleased = u185.MouseReleased
                        if MouseReleased then
                            if not u185.Config.IsMelee then
                                MouseReleased = false
                                if 0 < u185.Ammo then
                                    if u185.ReloadingTime then
                                        MouseReleased = u185.ReloadingTime
                                        if MouseReleased then
                                            MouseReleased = false
                                            if u185.ReloadingTime <= 0 then
                                                MouseReleased = u185.Reloaded
                                                if MouseReleased then
                                                    if u185.Config.PrimeAction then
                                                        MouseReleased = u185.Primed
                                                        if MouseReleased then
                                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                                MouseReleased = not u185.Busy
                                                            else
                                                                MouseReleased = false
                                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                                    MouseReleased = not u185.Busy
                                                                end
                                                            end
                                                        end
                                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    elseif u185.Config.PrimeAction then
                                        MouseReleased = u185.Primed
                                        if MouseReleased then
                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.ReloadingTime then
                                MouseReleased = u185.ReloadingTime
                                if MouseReleased then
                                    MouseReleased = false
                                    if u185.ReloadingTime <= 0 then
                                        MouseReleased = u185.Reloaded
                                        if MouseReleased then
                                            if u185.Config.PrimeAction then
                                                MouseReleased = u185.Primed
                                                if MouseReleased then
                                                    if u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    end
                                end
                            elseif u185.Config.PrimeAction then
                                MouseReleased = u185.Primed
                                if MouseReleased then
                                    if u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                MouseReleased = not u185.Busy
                            else
                                MouseReleased = false
                                Stamina_3 = LocalPlayerController:GetStamina()
                                if u185.Config.StaminaRequired <= Stamina_3 then
                                    MouseReleased = not u185.Busy
                                end
                            end
                        end
                    end
                    if u203 then
                        if (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                            or not u185.Config.StaminaRequired
                            or not v8 then
                            u185.QuickEquip = nil
                            u203 = false
                        end
                    end
                    if u185.Config.CustomShouldFire and not u185.Config.CustomShouldFire(u185) then
                        MouseReleased = false
                    end
                    if u185.Config.StaminaRequired
                        and (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                        and u214.PrimaryAttackDown then
                        v11 = HUDService
                        StaminaDisplay_2 = v11.Elements.StaminaDisplay
                        v12 = u185
                        StaminaRequired = v12.Config.StaminaRequired
                        StaminaDisplay_2:FlashRequired(StaminaRequired)
                    end
                    if not MouseReleased then
                        if MouseReleased then
                            if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                                if u214.PrimaryAttackDown then
                                    if u203 then
                                        u202 = true
                                    end
                                elseif u185.PrimaryAttackStart or u203 then
                                    u202 = true
                                end
                            elseif v23 then
                                u185.PrimaryAttackStart = os.clock()
                                u185.Charging = true
                            elseif u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                            if u185.Charging then
                                v10 = os.clock()
                                if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                    Stamina_6 = LocalPlayerController:GetStamina()
                                    if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                        and HUDService.Elements.StaminaDisplay
                                        and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                        StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                        StaminaDisplay_3.ChargeDisplay = true
                                        HUDService.Elements.StaminaDisplay:ChargeReady()
                                    end
                                end
                            end
                            if not u185.Config.IsMelee then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for m, i5 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(m)
                                        if not (0 < v16) then
                                            v16 = i5
                                            v17 = nil
                                            v18 = nil
                                            for i6, i7 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i7)
                                            end
                                        else
                                            v16 = i5
                                            v17 = nil
                                            v18 = nil
                                            for i8, i9 in v16, v17, v18 do
                                                task.delay(m, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i9 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i9
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u202 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i10, i11 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i10)
                                        if not (0 < v16) then
                                            v16 = i11
                                            v17 = nil
                                            v18 = nil
                                            for i12, i13 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i13)
                                            end
                                        else
                                            v16 = i11
                                            v17 = nil
                                            v18 = nil
                                            for i14, i15 in v16, v17, v18 do
                                                task.delay(i10, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i15 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i15
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i16, i17 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i16)
                                        if not (0 < v16) then
                                            v16 = i17
                                            v17 = nil
                                            v18 = nil
                                            for i18, i19 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i19)
                                            end
                                        else
                                            v16 = i17
                                            v17 = nil
                                            v18 = nil
                                            for i20, i21 in v16, v17, v18 do
                                                task.delay(i16, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i21 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i21
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            end
                        end
                    elseif u185.Config.Use then
                        if not u185.Config.IsTwoHandedAbility then
                            WeaponUse:FireServer()
                        else
                            v10 = u185

                            function v10.FireServerDeployEvent() -- Line: 1587 -- upvalues: WeaponUse (upval)
                                WeaponUse:FireServer()
                            end
                        end
                        v10 = u185
                        Config_4 = v10.Config
                        v12 = u185
                        Config_4:Use(v12)
                    elseif MouseReleased then
                        if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                            if u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                        elseif v23 then
                            u185.PrimaryAttackStart = os.clock()
                            u185.Charging = true
                        elseif u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                        if u185.Charging then
                            v10 = os.clock()
                            if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                Stamina_6 = LocalPlayerController:GetStamina()
                                if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                    and HUDService.Elements.StaminaDisplay
                                    and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                    StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                    StaminaDisplay_3.ChargeDisplay = true
                                    HUDService.Elements.StaminaDisplay:ChargeReady()
                                end
                            end
                        end
                        if not u185.Config.IsMelee then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i22, i23 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i22)
                                    if not (0 < v16) then
                                        v16 = i23
                                        v17 = nil
                                        v18 = nil
                                        for i24, i25 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i25)
                                        end
                                    else
                                        v16 = i23
                                        v17 = nil
                                        v18 = nil
                                        for i26, i27 in v16, v17, v18 do
                                            task.delay(i22, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i27 (val)
                                                local v1 = SoundUtil
                                                local v2 = i27
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u202 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i28, i29 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i28)
                                    if not (0 < v16) then
                                        v16 = i29
                                        v17 = nil
                                        v18 = nil
                                        for i30, i31 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i31)
                                        end
                                    else
                                        v16 = i29
                                        v17 = nil
                                        v18 = nil
                                        for i32, i33 in v16, v17, v18 do
                                            task.delay(i28, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i33 (val)
                                                local v1 = SoundUtil
                                                local v2 = i33
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i34, i35 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i34)
                                    if not (0 < v16) then
                                        v16 = i35
                                        v17 = nil
                                        v18 = nil
                                        for i36, i37 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i37)
                                        end
                                    else
                                        v16 = i35
                                        v17 = nil
                                        v18 = nil
                                        for i38, i39 in v16, v17, v18 do
                                            task.delay(i34, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i39 (val)
                                                local v1 = SoundUtil
                                                local v2 = i39
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        end
                    end
                end
            elseif u185.Config.IsMelee then
                if u185.Busy then
                    v9 = os.clock()
                    if u185.FireMode ~= "Burst" then
                        v10 = v3
                    else
                        v10 = 0
                    end
                    v8 = v9 - v10
                    if (u185.LastShot or 0) <= v8 then
                        u185.MouseReleased = true
                    end
                else
                    if DualWield:IsActive() and u214.PrimaryAttackDown then
                        v8, v9 = u214:DualWieldFire()
                        if v8 and v9 then
                            Config_2 = u185.Config
                            FireRate = Config_2.FireRate
                            if not FireRate then
                                FireRate = Config_2.DelayPerShot
                                if not FireRate then
                                    FireRate = 0.15
                                end
                            end
                            v3 = FireRate / GameState.Data.Variables.FireRate * v13
                        end
                    end
                    v9 = os.clock() - v3
                    v8 = (u185.LastShot or 0) <= v9
                    MouseReleased = v8
                    if MouseReleased then
                        MouseReleased = u185.MouseReleased
                        if MouseReleased then
                            if not u185.Config.IsMelee then
                                MouseReleased = false
                                if 0 < u185.Ammo then
                                    if u185.ReloadingTime then
                                        MouseReleased = u185.ReloadingTime
                                        if MouseReleased then
                                            MouseReleased = false
                                            if u185.ReloadingTime <= 0 then
                                                MouseReleased = u185.Reloaded
                                                if MouseReleased then
                                                    if u185.Config.PrimeAction then
                                                        MouseReleased = u185.Primed
                                                        if MouseReleased then
                                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                                MouseReleased = not u185.Busy
                                                            else
                                                                MouseReleased = false
                                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                                    MouseReleased = not u185.Busy
                                                                end
                                                            end
                                                        end
                                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    elseif u185.Config.PrimeAction then
                                        MouseReleased = u185.Primed
                                        if MouseReleased then
                                            if u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    elseif u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.ReloadingTime then
                                MouseReleased = u185.ReloadingTime
                                if MouseReleased then
                                    MouseReleased = false
                                    if u185.ReloadingTime <= 0 then
                                        MouseReleased = u185.Reloaded
                                        if MouseReleased then
                                            if u185.Config.PrimeAction then
                                                MouseReleased = u185.Primed
                                                if MouseReleased then
                                                    if u185.Charging or not u185.Config.StaminaRequired then
                                                        MouseReleased = not u185.Busy
                                                    else
                                                        MouseReleased = false
                                                        Stamina_3 = LocalPlayerController:GetStamina()
                                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                                            MouseReleased = not u185.Busy
                                                        end
                                                    end
                                                end
                                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                                MouseReleased = not u185.Busy
                                            else
                                                MouseReleased = false
                                                Stamina_3 = LocalPlayerController:GetStamina()
                                                if u185.Config.StaminaRequired <= Stamina_3 then
                                                    MouseReleased = not u185.Busy
                                                end
                                            end
                                        end
                                    end
                                end
                            elseif u185.Config.PrimeAction then
                                MouseReleased = u185.Primed
                                if MouseReleased then
                                    if u185.Charging or not u185.Config.StaminaRequired then
                                        MouseReleased = not u185.Busy
                                    else
                                        MouseReleased = false
                                        Stamina_3 = LocalPlayerController:GetStamina()
                                        if u185.Config.StaminaRequired <= Stamina_3 then
                                            MouseReleased = not u185.Busy
                                        end
                                    end
                                end
                            elseif u185.Charging or not u185.Config.StaminaRequired then
                                MouseReleased = not u185.Busy
                            else
                                MouseReleased = false
                                Stamina_3 = LocalPlayerController:GetStamina()
                                if u185.Config.StaminaRequired <= Stamina_3 then
                                    MouseReleased = not u185.Busy
                                end
                            end
                        end
                    end
                    if u203 then
                        if (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                            or not u185.Config.StaminaRequired
                            or not v8 then
                            u185.QuickEquip = nil
                            u203 = false
                        end
                    end
                    if u185.Config.CustomShouldFire and not u185.Config.CustomShouldFire(u185) then
                        MouseReleased = false
                    end
                    if u185.Config.StaminaRequired
                        and (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                        and u214.PrimaryAttackDown then
                        v11 = HUDService
                        StaminaDisplay_2 = v11.Elements.StaminaDisplay
                        v12 = u185
                        StaminaRequired = v12.Config.StaminaRequired
                        StaminaDisplay_2:FlashRequired(StaminaRequired)
                    end
                    if not MouseReleased then
                        if MouseReleased then
                            if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                                if u214.PrimaryAttackDown then
                                    if u203 then
                                        u202 = true
                                    end
                                elseif u185.PrimaryAttackStart or u203 then
                                    u202 = true
                                end
                            elseif v23 then
                                u185.PrimaryAttackStart = os.clock()
                                u185.Charging = true
                            elseif u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                            if u185.Charging then
                                v10 = os.clock()
                                if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                    Stamina_6 = LocalPlayerController:GetStamina()
                                    if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                        and HUDService.Elements.StaminaDisplay
                                        and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                        StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                        StaminaDisplay_3.ChargeDisplay = true
                                        HUDService.Elements.StaminaDisplay:ChargeReady()
                                    end
                                end
                            end
                            if not u185.Config.IsMelee then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i40, i41 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i40)
                                        if not (0 < v16) then
                                            v16 = i41
                                            v17 = nil
                                            v18 = nil
                                            for i42, i43 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i43)
                                            end
                                        else
                                            v16 = i41
                                            v17 = nil
                                            v18 = nil
                                            for i44, i45 in v16, v17, v18 do
                                                task.delay(i40, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i45 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i45
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u202 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i46, i47 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i46)
                                        if not (0 < v16) then
                                            v16 = i47
                                            v17 = nil
                                            v18 = nil
                                            for i48, i49 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i49)
                                            end
                                        else
                                            v16 = i47
                                            v17 = nil
                                            v18 = nil
                                            for i50, i51 in v16, v17, v18 do
                                                task.delay(i46, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i51 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i51
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                                u202 = false
                                if not u185.StartSFX then
                                    if u185.Config.ShootSingle then
                                        ShootSingle = u185.Config.ShootSingle
                                        if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                            ShootSingle = u185.Config.SuppressorShootSingle
                                        end
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    v10 = LoopSFX
                                    v12 = u185
                                    v10:Start(v12)
                                elseif u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                                if u185.Config.LayeredSFXs then
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v11 = nil
                                    v12 = nil
                                    for i52, i53 in LayeredSFXs, v11, v12 do
                                        v16 = tonumber(i52)
                                        if not (0 < v16) then
                                            v16 = i53
                                            v17 = nil
                                            v18 = nil
                                            for i54, i55 in v16, v17, v18 do
                                                SoundUtil:PlaySound(i55)
                                            end
                                        else
                                            v16 = i53
                                            v17 = nil
                                            v18 = nil
                                            for i56, i57 in v16, v17, v18 do
                                                task.delay(i52, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i57 (val)
                                                    local v1 = SoundUtil
                                                    local v2 = i57
                                                    v1:PlaySound(v2)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v10 = 100
                                v11 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v10 = 50
                                    else
                                        v10 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v10 = 25
                                    else
                                        v10 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v11 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v11 then
                                        v10 = v10 * 1.65
                                    end
                                    v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread or Config_2.BaseSpread then
                                    Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                                end
                                v12 = u214
                                GunFired = v12.GunFired
                                v15 = u185
                                GunFired:Fire(v15)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States
                                    or not LocalPlayerController.States.InSwanSong then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                        local v2 = u185
                                        local AmmoUpdated = v2.Config.AmmoUpdated
                                        local v3 = u185
                                        AmmoUpdated(v1, v3.Viewmodel.Model, {
                                            Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                            StoredAmmo = u185.StoredAmmo,
                                        })
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    v12 = LocalPlayerController
                                    v15 = u185
                                    StaminaUsed = v15.Config.StaminaUsed
                                    v16 = u185
                                    StaminaCooldown = v16.Config.StaminaCooldown
                                    v12:DrainStamina(StaminaUsed, StaminaCooldown)
                                end
                                if not u185.Config.IsMelee then
                                    u214.AmmoChanged:Fire()
                                else
                                    LocalPlayerController.BlockPressed = false
                                    u214.SecondaryAttackDown = false
                                    u185.MeleeStart = os.clock()
                                    u185.Meleeing = true
                                    u203 = false
                                end
                                v12 = os.clock()
                                if not u185.LastShot then
                                    v14 = v12
                                else
                                    v15 = u185.LastShot + v3
                                    if not (v12 - v15 < v3 * 0.5) then
                                        v14 = v12
                                    else
                                        v14 = v15
                                    end
                                end
                                v15 = u185
                                if not u185.DoingHeavy then
                                    v17 = 0
                                else
                                    v17 = HeavyDelayPerShot - v3
                                    if not v17 then
                                        v17 = 0
                                    end
                                end
                                v15.LastShot = v14 + v17
                                if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v15 = u185
                                    v15.CurrentShot = v15.CurrentShot + 1
                                    v15 = u185
                                    CurrentShot = v15.CurrentShot
                                    if u185.Config.BurstAmt < CurrentShot then
                                        v15 = (u185.Config.BurstDelay or 0) * v13
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v15
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                    u185.MouseReleased = false
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                        u185.Primed = false
                                    end
                                end
                            end
                        end
                    elseif u185.Config.Use then
                        if not u185.Config.IsTwoHandedAbility then
                            WeaponUse:FireServer()
                        else
                            v10 = u185

                            function v10.FireServerDeployEvent() -- Line: 1587 -- upvalues: WeaponUse (upval)
                                WeaponUse:FireServer()
                            end
                        end
                        v10 = u185
                        Config_4 = v10.Config
                        v12 = u185
                        Config_4:Use(v12)
                    elseif MouseReleased then
                        if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                            if u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                        elseif v23 then
                            u185.PrimaryAttackStart = os.clock()
                            u185.Charging = true
                        elseif u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                        if u185.Charging then
                            v10 = os.clock()
                            if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                Stamina_6 = LocalPlayerController:GetStamina()
                                if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                    and HUDService.Elements.StaminaDisplay
                                    and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                    StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                    StaminaDisplay_3.ChargeDisplay = true
                                    HUDService.Elements.StaminaDisplay:ChargeReady()
                                end
                            end
                        end
                        if not u185.Config.IsMelee then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i58, i59 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i58)
                                    if not (0 < v16) then
                                        v16 = i59
                                        v17 = nil
                                        v18 = nil
                                        for i60, i61 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i61)
                                        end
                                    else
                                        v16 = i59
                                        v17 = nil
                                        v18 = nil
                                        for i62, i63 in v16, v17, v18 do
                                            task.delay(i58, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i63 (val)
                                                local v1 = SoundUtil
                                                local v2 = i63
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u202 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i64, i65 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i64)
                                    if not (0 < v16) then
                                        v16 = i65
                                        v17 = nil
                                        v18 = nil
                                        for i66, i67 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i67)
                                        end
                                    else
                                        v16 = i65
                                        v17 = nil
                                        v18 = nil
                                        for i68, i69 in v16, v17, v18 do
                                            task.delay(i64, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i69 (val)
                                                local v1 = SoundUtil
                                                local v2 = i69
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i70, i71 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i70)
                                    if not (0 < v16) then
                                        v16 = i71
                                        v17 = nil
                                        v18 = nil
                                        for i72, i73 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i73)
                                        end
                                    else
                                        v16 = i71
                                        v17 = nil
                                        v18 = nil
                                        for i74, i75 in v16, v17, v18 do
                                            task.delay(i70, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i75 (val)
                                                local v1 = SoundUtil
                                                local v2 = i75
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        end
                    end
                end
            elseif not u185.Bursting or u185.Busy then
                v9 = os.clock()
                if u185.FireMode ~= "Burst" then
                    v10 = v3
                else
                    v10 = 0
                end
                v8 = v9 - v10
                if (u185.LastShot or 0) <= v8 then
                    u185.MouseReleased = true
                end
            else
                if DualWield:IsActive() and u214.PrimaryAttackDown then
                    v8, v9 = u214:DualWieldFire()
                    if v8 and v9 then
                        Config_2 = u185.Config
                        FireRate = Config_2.FireRate
                        if not FireRate then
                            FireRate = Config_2.DelayPerShot
                            if not FireRate then
                                FireRate = 0.15
                            end
                        end
                        v3 = FireRate / GameState.Data.Variables.FireRate * v13
                    end
                end
                v9 = os.clock() - v3
                v8 = (u185.LastShot or 0) <= v9
                MouseReleased = v8
                if MouseReleased then
                    MouseReleased = u185.MouseReleased
                    if MouseReleased then
                        if not u185.Config.IsMelee then
                            MouseReleased = false
                            if 0 < u185.Ammo then
                                if u185.ReloadingTime then
                                    MouseReleased = u185.ReloadingTime
                                    if MouseReleased then
                                        MouseReleased = false
                                        if u185.ReloadingTime <= 0 then
                                            MouseReleased = u185.Reloaded
                                            if MouseReleased then
                                                if u185.Config.PrimeAction then
                                                    MouseReleased = u185.Primed
                                                    if MouseReleased then
                                                        if u185.Charging or not u185.Config.StaminaRequired then
                                                            MouseReleased = not u185.Busy
                                                        else
                                                            MouseReleased = false
                                                            Stamina_3 = LocalPlayerController:GetStamina()
                                                            if u185.Config.StaminaRequired <= Stamina_3 then
                                                                MouseReleased = not u185.Busy
                                                            end
                                                        end
                                                    end
                                                elseif u185.Charging or not u185.Config.StaminaRequired then
                                                    MouseReleased = not u185.Busy
                                                else
                                                    MouseReleased = false
                                                    Stamina_3 = LocalPlayerController:GetStamina()
                                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                                        MouseReleased = not u185.Busy
                                                    end
                                                end
                                            end
                                        end
                                    end
                                elseif u185.Config.PrimeAction then
                                    MouseReleased = u185.Primed
                                    if MouseReleased then
                                        if u185.Charging or not u185.Config.StaminaRequired then
                                            MouseReleased = not u185.Busy
                                        else
                                            MouseReleased = false
                                            Stamina_3 = LocalPlayerController:GetStamina()
                                            if u185.Config.StaminaRequired <= Stamina_3 then
                                                MouseReleased = not u185.Busy
                                            end
                                        end
                                    end
                                elseif u185.Charging or not u185.Config.StaminaRequired then
                                    MouseReleased = not u185.Busy
                                else
                                    MouseReleased = false
                                    Stamina_3 = LocalPlayerController:GetStamina()
                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                        MouseReleased = not u185.Busy
                                    end
                                end
                            end
                        elseif u185.ReloadingTime then
                            MouseReleased = u185.ReloadingTime
                            if MouseReleased then
                                MouseReleased = false
                                if u185.ReloadingTime <= 0 then
                                    MouseReleased = u185.Reloaded
                                    if MouseReleased then
                                        if u185.Config.PrimeAction then
                                            MouseReleased = u185.Primed
                                            if MouseReleased then
                                                if u185.Charging or not u185.Config.StaminaRequired then
                                                    MouseReleased = not u185.Busy
                                                else
                                                    MouseReleased = false
                                                    Stamina_3 = LocalPlayerController:GetStamina()
                                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                                        MouseReleased = not u185.Busy
                                                    end
                                                end
                                            end
                                        elseif u185.Charging or not u185.Config.StaminaRequired then
                                            MouseReleased = not u185.Busy
                                        else
                                            MouseReleased = false
                                            Stamina_3 = LocalPlayerController:GetStamina()
                                            if u185.Config.StaminaRequired <= Stamina_3 then
                                                MouseReleased = not u185.Busy
                                            end
                                        end
                                    end
                                end
                            end
                        elseif u185.Config.PrimeAction then
                            MouseReleased = u185.Primed
                            if MouseReleased then
                                if u185.Charging or not u185.Config.StaminaRequired then
                                    MouseReleased = not u185.Busy
                                else
                                    MouseReleased = false
                                    Stamina_3 = LocalPlayerController:GetStamina()
                                    if u185.Config.StaminaRequired <= Stamina_3 then
                                        MouseReleased = not u185.Busy
                                    end
                                end
                            end
                        elseif u185.Charging or not u185.Config.StaminaRequired then
                            MouseReleased = not u185.Busy
                        else
                            MouseReleased = false
                            Stamina_3 = LocalPlayerController:GetStamina()
                            if u185.Config.StaminaRequired <= Stamina_3 then
                                MouseReleased = not u185.Busy
                            end
                        end
                    end
                end
                if u203 then
                    if (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                        or not u185.Config.StaminaRequired
                        or not v8 then
                        u185.QuickEquip = nil
                        u203 = false
                    end
                end
                if u185.Config.CustomShouldFire and not u185.Config.CustomShouldFire(u185) then
                    MouseReleased = false
                end
                if u185.Config.StaminaRequired
                    and (LocalPlayerController:GetStamina()) < u185.Config.StaminaRequired
                    and u214.PrimaryAttackDown then
                    v11 = HUDService
                    StaminaDisplay_2 = v11.Elements.StaminaDisplay
                    v12 = u185
                    StaminaRequired = v12.Config.StaminaRequired
                    StaminaDisplay_2:FlashRequired(StaminaRequired)
                end
                if not MouseReleased then
                    if MouseReleased then
                        if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                            if u214.PrimaryAttackDown then
                                if u203 then
                                    u202 = true
                                end
                            elseif u185.PrimaryAttackStart or u203 then
                                u202 = true
                            end
                        elseif v23 then
                            u185.PrimaryAttackStart = os.clock()
                            u185.Charging = true
                        elseif u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                        if u185.Charging then
                            v10 = os.clock()
                            if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                                Stamina_6 = LocalPlayerController:GetStamina()
                                if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                    and HUDService.Elements.StaminaDisplay
                                    and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                    StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                    StaminaDisplay_3.ChargeDisplay = true
                                    HUDService.Elements.StaminaDisplay:ChargeReady()
                                end
                            end
                        end
                        if not u185.Config.IsMelee then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i76, i77 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i76)
                                    if not (0 < v16) then
                                        v16 = i77
                                        v17 = nil
                                        v18 = nil
                                        for i78, i79 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i79)
                                        end
                                    else
                                        v16 = i77
                                        v17 = nil
                                        v18 = nil
                                        for i80, i81 in v16, v17, v18 do
                                            task.delay(i76, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i81 (val)
                                                local v1 = SoundUtil
                                                local v2 = i81
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u202 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i82, i83 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i82)
                                    if not (0 < v16) then
                                        v16 = i83
                                        v17 = nil
                                        v18 = nil
                                        for i84, i85 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i85)
                                        end
                                    else
                                        v16 = i83
                                        v17 = nil
                                        v18 = nil
                                        for i86, i87 in v16, v17, v18 do
                                            task.delay(i82, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i87 (val)
                                                local v1 = SoundUtil
                                                local v2 = i87
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                            u202 = false
                            if not u185.StartSFX then
                                if u185.Config.ShootSingle then
                                    ShootSingle = u185.Config.ShootSingle
                                    if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                        ShootSingle = u185.Config.SuppressorShootSingle
                                    end
                                    SoundUtil:PlaySound(ShootSingle)
                                end
                            elseif not u185.Config.HasSuppressor then
                                v10 = LoopSFX
                                v12 = u185
                                v10:Start(v12)
                            elseif u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                            if u185.Config.LayeredSFXs then
                                LayeredSFXs = u185.Config.LayeredSFXs
                                v11 = nil
                                v12 = nil
                                for i88, i89 in LayeredSFXs, v11, v12 do
                                    v16 = tonumber(i88)
                                    if not (0 < v16) then
                                        v16 = i89
                                        v17 = nil
                                        v18 = nil
                                        for i90, i91 in v16, v17, v18 do
                                            SoundUtil:PlaySound(i91)
                                        end
                                    else
                                        v16 = i89
                                        v17 = nil
                                        v18 = nil
                                        for i92, i93 in v16, v17, v18 do
                                            task.delay(i88, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i93 (val)
                                                local v1 = SoundUtil
                                                local v2 = i93
                                                v1:PlaySound(v2)
                                            end)
                                        end
                                    end
                                end
                            end
                            if u185.AutoLoop and not u185.AutoLoop.Playing then
                                u185.AutoLoop:Play()
                            end
                            v10 = 100
                            v11 = false
                            if LocalPlayerController.States.Crouching then
                                if not Config_2.CrouchSpreadReduction then
                                    v10 = 50
                                else
                                    v10 = Config_2.CrouchSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if LocalPlayerController.States.Proning then
                                if not Config_2.ProneSpreadReduction then
                                    v10 = 25
                                else
                                    v10 = Config_2.ProneSpreadReduction * 10
                                end
                                v11 = true
                            end
                            if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                if v11 then
                                    v10 = v10 * 1.65
                                end
                                v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                            end
                            if Config_2.Spread or Config_2.BaseSpread then
                                Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                                BaseSpread = Config_2.BaseSpread
                                if not BaseSpread then
                                    BaseSpread = Config_2.Spread
                                end
                                v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                                u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                            end
                            v12 = u214
                            GunFired = v12.GunFired
                            v15 = u185
                            GunFired:Fire(v15)
                            u185:Shoot()
                            u185.PrimaryAttackStart = nil
                            u185.Charging = false
                            if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                                u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                            end
                            if u185.Config.AmmoUpdated then
                                task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    local v2 = u185
                                    local AmmoUpdated = v2.Config.AmmoUpdated
                                    local v3 = u185
                                    AmmoUpdated(v1, v3.Viewmodel.Model, {
                                        Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                        StoredAmmo = u185.StoredAmmo,
                                    })
                                end)
                            end
                            if u185.Config.StaminaUsed then
                                v12 = LocalPlayerController
                                v15 = u185
                                StaminaUsed = v15.Config.StaminaUsed
                                v16 = u185
                                StaminaCooldown = v16.Config.StaminaCooldown
                                v12:DrainStamina(StaminaUsed, StaminaCooldown)
                            end
                            if not u185.Config.IsMelee then
                                u214.AmmoChanged:Fire()
                            else
                                LocalPlayerController.BlockPressed = false
                                u214.SecondaryAttackDown = false
                                u185.MeleeStart = os.clock()
                                u185.Meleeing = true
                                u203 = false
                            end
                            v12 = os.clock()
                            if not u185.LastShot then
                                v14 = v12
                            else
                                v15 = u185.LastShot + v3
                                if not (v12 - v15 < v3 * 0.5) then
                                    v14 = v12
                                else
                                    v14 = v15
                                end
                            end
                            v15 = u185
                            if not u185.DoingHeavy then
                                v17 = 0
                            else
                                v17 = HeavyDelayPerShot - v3
                                if not v17 then
                                    v17 = 0
                                end
                            end
                            v15.LastShot = v14 + v17
                            if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                                u214:DualWieldAlternate()
                            end
                            if u185.FireMode == "Burst" and not u185.Bursting then
                                u185.Bursting = true
                            end
                            if u185.Bursting then
                                if not u185.CurrentShot then
                                    u185.CurrentShot = 1
                                end
                                v15 = u185
                                v15.CurrentShot = v15.CurrentShot + 1
                                v15 = u185
                                CurrentShot = v15.CurrentShot
                                if u185.Config.BurstAmt < CurrentShot then
                                    v15 = (u185.Config.BurstDelay or 0) * v13
                                    u185.CurrentShot = 1
                                    u185.Bursting = false
                                    u185.LastShot = os.clock() + v15
                                    u185.MouseReleased = false
                                end
                            end
                            if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                                u185.MouseReleased = false
                            end
                            if u185.Config.PrimeAction then
                                u185.Priming = false
                                if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                    u185.Primed = false
                                end
                            end
                        end
                    end
                elseif u185.Config.Use then
                    if not u185.Config.IsTwoHandedAbility then
                        WeaponUse:FireServer()
                    else
                        v10 = u185

                        function v10.FireServerDeployEvent() -- Line: 1587 -- upvalues: WeaponUse (upval)
                            WeaponUse:FireServer()
                        end
                    end
                    v10 = u185
                    Config_4 = v10.Config
                    v12 = u185
                    Config_4:Use(v12)
                elseif MouseReleased then
                    if not u214.PrimaryAttackDown or u185.PrimaryAttackStart then
                        if u214.PrimaryAttackDown then
                            if u203 then
                                u202 = true
                            end
                        elseif u185.PrimaryAttackStart or u203 then
                            u202 = true
                        end
                    elseif v23 then
                        u185.PrimaryAttackStart = os.clock()
                        u185.Charging = true
                    elseif u214.PrimaryAttackDown then
                        if u203 then
                            u202 = true
                        end
                    elseif u185.PrimaryAttackStart or u203 then
                        u202 = true
                    end
                    if u185.Charging then
                        v10 = os.clock()
                        if u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= v10 then
                            Stamina_6 = LocalPlayerController:GetStamina()
                            if (u185.Config.HeavyStaminaRequired or 9999999) <= Stamina_6
                                and HUDService.Elements.StaminaDisplay
                                and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                StaminaDisplay_3 = HUDService.Elements.StaminaDisplay
                                StaminaDisplay_3.ChargeDisplay = true
                                HUDService.Elements.StaminaDisplay:ChargeReady()
                            end
                        end
                    end
                    if not u185.Config.IsMelee then
                        u202 = false
                        if not u185.StartSFX then
                            if u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                        elseif not u185.Config.HasSuppressor then
                            v10 = LoopSFX
                            v12 = u185
                            v10:Start(v12)
                        elseif u185.Config.ShootSingle then
                            ShootSingle = u185.Config.ShootSingle
                            if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                ShootSingle = u185.Config.SuppressorShootSingle
                            end
                            SoundUtil:PlaySound(ShootSingle)
                        end
                        if u185.Config.LayeredSFXs then
                            LayeredSFXs = u185.Config.LayeredSFXs
                            v11 = nil
                            v12 = nil
                            for i94, i95 in LayeredSFXs, v11, v12 do
                                v16 = tonumber(i94)
                                if not (0 < v16) then
                                    v16 = i95
                                    v17 = nil
                                    v18 = nil
                                    for i96, i97 in v16, v17, v18 do
                                        SoundUtil:PlaySound(i97)
                                    end
                                else
                                    v16 = i95
                                    v17 = nil
                                    v18 = nil
                                    for i98, i99 in v16, v17, v18 do
                                        task.delay(i94, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i99 (val)
                                            local v1 = SoundUtil
                                            local v2 = i99
                                            v1:PlaySound(v2)
                                        end)
                                    end
                                end
                            end
                        end
                        if u185.AutoLoop and not u185.AutoLoop.Playing then
                            u185.AutoLoop:Play()
                        end
                        v10 = 100
                        v11 = false
                        if LocalPlayerController.States.Crouching then
                            if not Config_2.CrouchSpreadReduction then
                                v10 = 50
                            else
                                v10 = Config_2.CrouchSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if LocalPlayerController.States.Proning then
                            if not Config_2.ProneSpreadReduction then
                                v10 = 25
                            else
                                v10 = Config_2.ProneSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                            if v11 then
                                v10 = v10 * 1.65
                            end
                            v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                        end
                        if Config_2.Spread or Config_2.BaseSpread then
                            Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                            BaseSpread = Config_2.BaseSpread
                            if not BaseSpread then
                                BaseSpread = Config_2.Spread
                            end
                            v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                            u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                        end
                        v12 = u214
                        GunFired = v12.GunFired
                        v15 = u185
                        GunFired:Fire(v15)
                        u185:Shoot()
                        u185.PrimaryAttackStart = nil
                        u185.Charging = false
                        if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                            u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                        end
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                local v2 = u185
                                local AmmoUpdated = v2.Config.AmmoUpdated
                                local v3 = u185
                                AmmoUpdated(v1, v3.Viewmodel.Model, {
                                    Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                    StoredAmmo = u185.StoredAmmo,
                                })
                            end)
                        end
                        if u185.Config.StaminaUsed then
                            v12 = LocalPlayerController
                            v15 = u185
                            StaminaUsed = v15.Config.StaminaUsed
                            v16 = u185
                            StaminaCooldown = v16.Config.StaminaCooldown
                            v12:DrainStamina(StaminaUsed, StaminaCooldown)
                        end
                        if not u185.Config.IsMelee then
                            u214.AmmoChanged:Fire()
                        else
                            LocalPlayerController.BlockPressed = false
                            u214.SecondaryAttackDown = false
                            u185.MeleeStart = os.clock()
                            u185.Meleeing = true
                            u203 = false
                        end
                        v12 = os.clock()
                        if not u185.LastShot then
                            v14 = v12
                        else
                            v15 = u185.LastShot + v3
                            if not (v12 - v15 < v3 * 0.5) then
                                v14 = v12
                            else
                                v14 = v15
                            end
                        end
                        v15 = u185
                        if not u185.DoingHeavy then
                            v17 = 0
                        else
                            v17 = HeavyDelayPerShot - v3
                            if not v17 then
                                v17 = 0
                            end
                        end
                        v15.LastShot = v14 + v17
                        if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                            u214:DualWieldAlternate()
                        end
                        if u185.FireMode == "Burst" and not u185.Bursting then
                            u185.Bursting = true
                        end
                        if u185.Bursting then
                            if not u185.CurrentShot then
                                u185.CurrentShot = 1
                            end
                            v15 = u185
                            v15.CurrentShot = v15.CurrentShot + 1
                            v15 = u185
                            CurrentShot = v15.CurrentShot
                            if u185.Config.BurstAmt < CurrentShot then
                                v15 = (u185.Config.BurstDelay or 0) * v13
                                u185.CurrentShot = 1
                                u185.Bursting = false
                                u185.LastShot = os.clock() + v15
                                u185.MouseReleased = false
                            end
                        end
                        if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                            u185.MouseReleased = false
                        end
                        if u185.Config.PrimeAction then
                            u185.Priming = false
                            if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                u185.Primed = false
                            end
                        end
                    elseif u202 then
                        u202 = false
                        if not u185.StartSFX then
                            if u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                        elseif not u185.Config.HasSuppressor then
                            v10 = LoopSFX
                            v12 = u185
                            v10:Start(v12)
                        elseif u185.Config.ShootSingle then
                            ShootSingle = u185.Config.ShootSingle
                            if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                ShootSingle = u185.Config.SuppressorShootSingle
                            end
                            SoundUtil:PlaySound(ShootSingle)
                        end
                        if u185.Config.LayeredSFXs then
                            LayeredSFXs = u185.Config.LayeredSFXs
                            v11 = nil
                            v12 = nil
                            for i100, i101 in LayeredSFXs, v11, v12 do
                                v16 = tonumber(i100)
                                if not (0 < v16) then
                                    v16 = i101
                                    v17 = nil
                                    v18 = nil
                                    for i102, i103 in v16, v17, v18 do
                                        SoundUtil:PlaySound(i103)
                                    end
                                else
                                    v16 = i101
                                    v17 = nil
                                    v18 = nil
                                    for i104, i105 in v16, v17, v18 do
                                        task.delay(i100, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i105 (val)
                                            local v1 = SoundUtil
                                            local v2 = i105
                                            v1:PlaySound(v2)
                                        end)
                                    end
                                end
                            end
                        end
                        if u185.AutoLoop and not u185.AutoLoop.Playing then
                            u185.AutoLoop:Play()
                        end
                        v10 = 100
                        v11 = false
                        if LocalPlayerController.States.Crouching then
                            if not Config_2.CrouchSpreadReduction then
                                v10 = 50
                            else
                                v10 = Config_2.CrouchSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if LocalPlayerController.States.Proning then
                            if not Config_2.ProneSpreadReduction then
                                v10 = 25
                            else
                                v10 = Config_2.ProneSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                            if v11 then
                                v10 = v10 * 1.65
                            end
                            v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                        end
                        if Config_2.Spread or Config_2.BaseSpread then
                            Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                            BaseSpread = Config_2.BaseSpread
                            if not BaseSpread then
                                BaseSpread = Config_2.Spread
                            end
                            v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                            u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                        end
                        v12 = u214
                        GunFired = v12.GunFired
                        v15 = u185
                        GunFired:Fire(v15)
                        u185:Shoot()
                        u185.PrimaryAttackStart = nil
                        u185.Charging = false
                        if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                            u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                        end
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                local v2 = u185
                                local AmmoUpdated = v2.Config.AmmoUpdated
                                local v3 = u185
                                AmmoUpdated(v1, v3.Viewmodel.Model, {
                                    Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                    StoredAmmo = u185.StoredAmmo,
                                })
                            end)
                        end
                        if u185.Config.StaminaUsed then
                            v12 = LocalPlayerController
                            v15 = u185
                            StaminaUsed = v15.Config.StaminaUsed
                            v16 = u185
                            StaminaCooldown = v16.Config.StaminaCooldown
                            v12:DrainStamina(StaminaUsed, StaminaCooldown)
                        end
                        if not u185.Config.IsMelee then
                            u214.AmmoChanged:Fire()
                        else
                            LocalPlayerController.BlockPressed = false
                            u214.SecondaryAttackDown = false
                            u185.MeleeStart = os.clock()
                            u185.Meleeing = true
                            u203 = false
                        end
                        v12 = os.clock()
                        if not u185.LastShot then
                            v14 = v12
                        else
                            v15 = u185.LastShot + v3
                            if not (v12 - v15 < v3 * 0.5) then
                                v14 = v12
                            else
                                v14 = v15
                            end
                        end
                        v15 = u185
                        if not u185.DoingHeavy then
                            v17 = 0
                        else
                            v17 = HeavyDelayPerShot - v3
                            if not v17 then
                                v17 = 0
                            end
                        end
                        v15.LastShot = v14 + v17
                        if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                            u214:DualWieldAlternate()
                        end
                        if u185.FireMode == "Burst" and not u185.Bursting then
                            u185.Bursting = true
                        end
                        if u185.Bursting then
                            if not u185.CurrentShot then
                                u185.CurrentShot = 1
                            end
                            v15 = u185
                            v15.CurrentShot = v15.CurrentShot + 1
                            v15 = u185
                            CurrentShot = v15.CurrentShot
                            if u185.Config.BurstAmt < CurrentShot then
                                v15 = (u185.Config.BurstDelay or 0) * v13
                                u185.CurrentShot = 1
                                u185.Bursting = false
                                u185.LastShot = os.clock() + v15
                                u185.MouseReleased = false
                            end
                        end
                        if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                            u185.MouseReleased = false
                        end
                        if u185.Config.PrimeAction then
                            u185.Priming = false
                            if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                u185.Primed = false
                            end
                        end
                    elseif u185.Charging and (LocalPlayerController:GetStamina()) <= 0 then
                        u202 = false
                        if not u185.StartSFX then
                            if u185.Config.ShootSingle then
                                ShootSingle = u185.Config.ShootSingle
                                if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                    ShootSingle = u185.Config.SuppressorShootSingle
                                end
                                SoundUtil:PlaySound(ShootSingle)
                            end
                        elseif not u185.Config.HasSuppressor then
                            v10 = LoopSFX
                            v12 = u185
                            v10:Start(v12)
                        elseif u185.Config.ShootSingle then
                            ShootSingle = u185.Config.ShootSingle
                            if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then
                                ShootSingle = u185.Config.SuppressorShootSingle
                            end
                            SoundUtil:PlaySound(ShootSingle)
                        end
                        if u185.Config.LayeredSFXs then
                            LayeredSFXs = u185.Config.LayeredSFXs
                            v11 = nil
                            v12 = nil
                            for i106, i107 in LayeredSFXs, v11, v12 do
                                v16 = tonumber(i106)
                                if not (0 < v16) then
                                    v16 = i107
                                    v17 = nil
                                    v18 = nil
                                    for i108, i109 in v16, v17, v18 do
                                        SoundUtil:PlaySound(i109)
                                    end
                                else
                                    v16 = i107
                                    v17 = nil
                                    v18 = nil
                                    for i110, i111 in v16, v17, v18 do
                                        task.delay(i106, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i111 (val)
                                            local v1 = SoundUtil
                                            local v2 = i111
                                            v1:PlaySound(v2)
                                        end)
                                    end
                                end
                            end
                        end
                        if u185.AutoLoop and not u185.AutoLoop.Playing then
                            u185.AutoLoop:Play()
                        end
                        v10 = 100
                        v11 = false
                        if LocalPlayerController.States.Crouching then
                            if not Config_2.CrouchSpreadReduction then
                                v10 = 50
                            else
                                v10 = Config_2.CrouchSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if LocalPlayerController.States.Proning then
                            if not Config_2.ProneSpreadReduction then
                                v10 = 25
                            else
                                v10 = Config_2.ProneSpreadReduction * 10
                            end
                            v11 = true
                        end
                        if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                            if v11 then
                                v10 = v10 * 1.65
                            end
                            v10 = v10 * (Config_2.ADSSpreadReduction or 0.75)
                        end
                        if Config_2.Spread or Config_2.BaseSpread then
                            Attribute = game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult")
                            BaseSpread = Config_2.BaseSpread
                            if not BaseSpread then
                                BaseSpread = Config_2.Spread
                            end
                            v14 = BaseSpread * GameState.Data.Variables.WeaponSpread * (Attribute or 1)
                            u185.ShootingInaccuracy = u185.ShootingInaccuracy + v14 * v10
                        end
                        v12 = u214
                        GunFired = v12.GunFired
                        v15 = u185
                        GunFired:Fire(v15)
                        u185:Shoot()
                        u185.PrimaryAttackStart = nil
                        u185.Charging = false
                        if not LocalPlayerController.States or not LocalPlayerController.States.InSwanSong then
                            u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                        end
                        if u185.Config.AmmoUpdated then
                            task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                local v2 = u185
                                local AmmoUpdated = v2.Config.AmmoUpdated
                                local v3 = u185
                                AmmoUpdated(v1, v3.Viewmodel.Model, {
                                    Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1),
                                    StoredAmmo = u185.StoredAmmo,
                                })
                            end)
                        end
                        if u185.Config.StaminaUsed then
                            v12 = LocalPlayerController
                            v15 = u185
                            StaminaUsed = v15.Config.StaminaUsed
                            v16 = u185
                            StaminaCooldown = v16.Config.StaminaCooldown
                            v12:DrainStamina(StaminaUsed, StaminaCooldown)
                        end
                        if not u185.Config.IsMelee then
                            u214.AmmoChanged:Fire()
                        else
                            LocalPlayerController.BlockPressed = false
                            u214.SecondaryAttackDown = false
                            u185.MeleeStart = os.clock()
                            u185.Meleeing = true
                            u203 = false
                        end
                        v12 = os.clock()
                        if not u185.LastShot then
                            v14 = v12
                        else
                            v15 = u185.LastShot + v3
                            if not (v12 - v15 < v3 * 0.5) then
                                v14 = v12
                            else
                                v14 = v15
                            end
                        end
                        v15 = u185
                        if not u185.DoingHeavy then
                            v17 = 0
                        else
                            v17 = HeavyDelayPerShot - v3
                            if not v17 then
                                v17 = 0
                            end
                        end
                        v15.LastShot = v14 + v17
                        if DualWield:IsActive() and not u214:IsDualWieldAutoMode() then
                            u214:DualWieldAlternate()
                        end
                        if u185.FireMode == "Burst" and not u185.Bursting then
                            u185.Bursting = true
                        end
                        if u185.Bursting then
                            if not u185.CurrentShot then
                                u185.CurrentShot = 1
                            end
                            v15 = u185
                            v15.CurrentShot = v15.CurrentShot + 1
                            v15 = u185
                            CurrentShot = v15.CurrentShot
                            if u185.Config.BurstAmt < CurrentShot then
                                v15 = (u185.Config.BurstDelay or 0) * v13
                                u185.CurrentShot = 1
                                u185.Bursting = false
                                u185.LastShot = os.clock() + v15
                                u185.MouseReleased = false
                            end
                        end
                        if u185.FireMode == "Semi-Auto" or u185.Config.PrimeAction then
                            u185.MouseReleased = false
                        end
                        if u185.Config.PrimeAction then
                            u185.Priming = false
                            if 0 < u185.Ammo or u185.Config.PrimeOnLastShot then
                                u185.Primed = false
                            end
                        end
                    end
                end
            end
            if not u185.Primed and not u185.Reloading then
                Pump = u185.Viewmodel.Animations.Pump
                if Pump then
                    Pump.Priority = Enum.AnimationPriority.Action3
                    Length_3 = Pump.Length
                    v10 = u185
                    v12 = Length_3 / (v10.Config.BoltAnimationTime or v3)
                    v14 = u185
                    Viewmodel_7 = v14.Viewmodel
                    v19 = v12 * v2
                    Viewmodel_7:PlayAnimation("Pump", 0, 1, v19)
                end
                u185.Primed = true
                u185.LastShot = os.clock()
            end
            ActiveWeapons_2, ActiveWeapons_3, ActiveWeapons_4 = DualWield:GetActiveWeapons()
            v8 = ActiveWeapons_2
            v9 = ActiveWeapons_3
            v10 = ActiveWeapons_4
            for i112, i113 in v8, v9, v10 do
                i113.SecondaryAttackDown = u214.SecondaryAttackDown
            end
            if u185.LoopSFX_Playing then
                if not u214.PrimaryAttackDown
                    or not v23
                    or u185.Ammo <= 0
                    or u185.Reloading
                    or QuickSwap:IsActive() then
                    v8 = LoopSFX
                    v10 = u185
                    v8:Stop(v10)
                end
            end
        end
        if DualWield:IsActive() then
            Weapons, Weapons_2 = DualWield:GetWeapons()
            v25 = nil
            if u185 ~= Weapons then
                if u185 == Weapons_2 and Weapons then
                    v25 = Weapons
                end
            elseif Weapons_2 then
                v25 = Weapons_2
            elseif u185 == Weapons_2 and Weapons then
                v25 = Weapons
            end
            if v25 and v25.Reloading then
                v3 = game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1
                v4 = 1
                if SkillTreeData and SkillTreeData.ReloadSpeedMult then
                    v4 = Fusion.peek(SkillTreeData.ReloadSpeedMult)
                end
                v5 = v3 * v4
                if v25.ReloadingTime then
                    v25.ReloadingTime = v25.ReloadingTime - v1
                    if v25.ReloadingTime <= 0 then
                        v25.ReloadingTime = 0
                        if v25.Config.UsesLoadLoop then
                            if v25.LoopStage == 1 then
                                v25.LoopStage = 2
                                v25.IncreasedAmmo = true
                            end
                            if v25.LoopStage == 2 then
                                if v25.StoredAmmo <= 0 then
                                    v25.LoopStage = 3
                                else
                                    Ammo_3 = v25.Ammo
                                    if v25.Config.Ammo <= Ammo_3 then
                                        v25.LoopStage = 3
                                    end
                                end
                                if not v25.IncreasedAmmo then
                                    if v25.LoopStage == 2 then
                                        StoredAmmo_2 = v25.Config.AmmoPerLoad or 1
                                        if v25.StoredAmmo < StoredAmmo_2 then
                                            StoredAmmo_2 = v25.StoredAmmo
                                        end
                                        v7 = StoredAmmo_2 + v25.Ammo
                                        if not (v25.Config.Ammo < v7) then
                                            v25.Ammo = v25.Ammo + StoredAmmo_2
                                        else
                                            v25.Ammo = v25.Config.Ammo
                                        end
                                        v25.StoredAmmo = v25.StoredAmmo - StoredAmmo_2
                                        u214.AmmoChanged:Fire()
                                        v25.ReloadingTime = (v25.Config.InsertTime - v25.Config.IncrAmmoCountTime) * v13 * v5
                                        v25.IncreasedAmmo = true
                                    end
                                elseif v25.LoopStage == 2 then
                                    LoadLoop_2 = v25.Viewmodel.Animations.LoadLoop
                                    if LoadLoop_2 then
                                        LoadLoop_2.Priority = Enum.AnimationPriority.Action4
                                        Length_4 = LoadLoop_2.Length
                                        InsertAnimationTime_2 = v25.Config.InsertAnimationTime
                                        if not InsertAnimationTime_2 then
                                            InsertAnimationTime_2 = v25.Config.InsertTime
                                        end
                                        v9 = Length_4 / InsertAnimationTime_2
                                        Viewmodel_8 = v25.Viewmodel
                                        v16 = v9 * v2 / v5
                                        Viewmodel_8:PlayAnimation("LoadLoop", 0, 1, v16)
                                    end
                                    v25.ReloadingTime = v25.Config.IncrAmmoCountTime * v13 * v5
                                    v25.IncreasedAmmo = false
                                end
                            end
                            if v25.LoopStage == 3 then
                                v25.Viewmodel:StopAnimation("LoadLoop")
                                v25.Viewmodel:StopAnimation("LoadIdle")
                                v25.Viewmodel:StopAnimation("LoadStart")
                                v25.Viewmodel:StopAnimation("LoadStartEmpty")
                                LoadStop_2 = v25.Viewmodel.Animations.LoadStop
                                if LoadStop_2 then
                                    Length_5 = LoadStop_2.Length
                                    LoadStopAnimationTime_2 = v25.Config.LoadStopAnimationTime
                                    if not LoadStopAnimationTime_2 then
                                        LoadStopAnimationTime_2 = v25.Config.LoadStartTime
                                    end
                                    v9 = Length_5 / LoadStopAnimationTime_2
                                    Viewmodel_9 = v25.Viewmodel
                                    v16 = v9 * v2 / v5
                                    Viewmodel_9:PlayAnimation("LoadStop", 0, 1, v16)
                                end
                                v25.LoopStage = 4
                            end
                            if not v25.Reloaded and v25.LoopStage == 4 then
                                v25.Reloading = false
                                v25.Reloaded = true
                                v25.CancelReload = false
                                u214:DualWieldReloadComplete(v25)
                            end
                        elseif not v25.Reloaded then
                            v25.Reloading = false
                            if v25.newAmmo then
                                v25.Ammo = v25.newAmmo[1]
                                v25.StoredAmmo = v25.newAmmo[2]
                                u214.AmmoChanged:Fire()
                                v25.newAmmo = nil
                            end
                            v25.Reloaded = true
                            v25:ReloadFinished()
                            u214:DualWieldReloadComplete(v25)
                        end
                    end
                end
                if v25.Ammo <= 0 and not v25.Reloading and 0 < v25.StoredAmmo then
                    u214:DualWieldAutoReload(v25)
                end
            end
        end
        return
    end
    u185:ForceUnequip()
    UnequipWeapon()
    u187 = nil
    u214.EquippedSlot:Fire(nil)
end

function Lerp(p1, p2, p3) -- Line: 1890
    return p1 * (1 - p3) + p2 * p3
end

function removeWeapons() -- Line: 1894
    -- upvalues: u185 (ref), u187 (ref), u214 (val), u195 (val), ViewmodelManager (val), u196 (val), u189 (ref)
    -- upvalues: u194 (ref), u197 (val), u190 (ref), u193 (ref), u186 (ref)
    if u185 then
        u185:ForceUnequip()
        UnequipWeapon()
        u187 = nil
        u214.EquippedSlot:Fire(nil)
    end
    local v1 = u195
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        ViewmodelManager:Unequip(j)
        j:Destroy()
        u195[i] = nil
    end
    table.clear(u196)
    u189 = nil
    u194 = nil
    u197.X = 0
    u197.Y = 0
    u190 = nil
    u193 = nil
    u187 = nil
    u186 = false
end

local u288 = {}

local function addToWeaponEventQueue(p1) -- Line: 1923 -- upvalues: u288 (val)
    local v1 = u288
    table.insert(v1, p1)
    if #u288 == 1 then
        repeat
            u288[1]()
            table.remove(u288, 1)
        until #u288 == 0
    end
end

FrameworkEvents.UpdateAmmo:SetClientListener(function(p1) -- Line: 1933 -- upvalues: addToWeaponEventQueue (val), u195 (val), u214 (val)
    local v1 = addToWeaponEventQueue
    v1(function() -- Line: 1934 -- upvalues: p1 (val), u195 (upval), u214 (upval)
        local v1, v2, v3, v4
        local v5 = p1
        local v6 = nil
        local v7 = nil
        for i, j in v5, v6, v7 do
            v1 = u195[tonumber(i)]
            if v1 then
                v2 = j
                v3 = nil
                v4 = nil
                for k, n in v2, v3, v4 do
                    v1[k] = n
                end
                v1.newAmmo = nil
                v1.ServerFinishedReload = false
            end
        end
        u214.AmmoChanged:Fire()
    end)
end)
game.Players.LocalPlayer.CharacterRemoving:Connect(function() -- Line: 1950 -- upvalues: LocalPlayerController (val), u214 (val)
    removeWeapons()
    LocalPlayerController:UpdateInventory({})
    u214.InventoryChanged:Fire({})
end)
FrameworkEvents.SetLoadout:SetClientListener(function(p1) -- Line: 1956
    -- upvalues: addToWeaponEventQueue (val), u195 (val), Weapon (val), u214 (val), u196 (val), u189 (ref), u194 (ref)
    -- upvalues: LoopSFX (val), u190 (ref), LocalPlayerController (val), u197 (val), u187 (ref), u193 (ref)
    local v1 = addToWeaponEventQueue
    v1(function() -- Line: 1957
        -- upvalues: u195 (upval), p1 (val), Weapon (upval), u214 (upval), u196 (upval), u189 (upval), u194 (upval)
        -- upvalues: LoopSFX (upval), u190 (upval), LocalPlayerController (upval), u197 (upval), u187 (upval)
        -- upvalues: u193 (upval)
        local ammo, ammo_2, hbslot, v1, v2
        local v3 = u195
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            if j.Config.Reset then
                j.Config:Reset(j)
            end
        end
        v4 = p1
        v3, v4 = unpack(v4)
        removeWeapons()
        v5 = v3
        local v6 = nil
        local v7 = nil
        for k, n in v5, v6, v7 do
            local u85 = Weapon.new(n.id, n.mods)
            u85.Slot = k
            u85.Viewmodel.ConfigLoaded:Once(function() -- Line: 1971 -- upvalues: u85 (val), u214 (upval)
                local v1 = u85
                local FireMode = u85.Config.FireMode
                if FireMode then
                    FireMode = u85.Config.FireMode[u85.SelFireMode]
                end
                v1.FireMode = FireMode
                u214.FireModeChanged:Fire()
            end)
            u195[k] = u85
            u195[k].Slot = k
            v1 = u195[k]
            ammo = n.ammo
            if ammo then
                ammo = n.ammo[1] or 0
            end
            v1.Ammo = ammo
            v1 = u195[k]
            ammo_2 = n.ammo
            if ammo_2 then
                ammo_2 = n.ammo[2] or 0
            end
            v1.StoredAmmo = ammo_2
            v1 = u195[k]
            hbslot = n.hbslot
            v1.HotbarSlot = tonumber(hbslot) or 4
            if not u196[u85.HotbarSlot] then
                u196[u85.HotbarSlot] = {}
            end
            v2 = u196[u85.HotbarSlot]
            table.insert(v2, u85)
            if u85.Config.IsMelee then
                u189 = k
            end
            if u85.Config.IsAPistol then
                u194 = k
            end
            if u85.Config.Shooting_Start then
                LoopSFX:Init(u85)
            end
        end
        u190 = nil
        v5 = LocalPlayerController
        v7 = u195
        v5:UpdateInventory(v7)
        v5 = u214
        local InventoryChanged = v5.InventoryChanged
        v7 = u195
        InventoryChanged:Fire(v7)
        if v4 then
            local v8
            v5 = u196
            v6 = nil
            v7 = nil
            for m, i5 in v5, v6, v7 do
                v8 = i5
                v1 = nil
                v2 = nil
                for i6, i7 in v8, v1, v2 do
                    if i7.Slot == v4 then
                        u197.X = m
                        u197.Y = i6
                    end
                end
            end
            u190 = v4
            u187 = v4
            u193 = tonumber(v4)
            v5 = u214
            local EquippedSlot = v5.EquippedSlot
            v7 = u187
            EquippedSlot:Fire(v7)
            SwapWeapon(v4, true)
        end
    end)
end)
;(LocalPlayerController.States:GetPropertyChangedSignal("IsDead")):Connect(function(p1) -- Line: 2031 -- upvalues: u185 (ref), u187 (ref), u214 (val)
    if not p1 then
        return
    end
    if u185 then
        u185:ForceUnequip()
        UnequipWeapon()
        u187 = nil
        u214.EquippedSlot:Fire(nil)
    end
end)
initializeModules()
local v3 = WeaponStepped
RunService:BindToRenderStep("WeaponController", v2, v3)
local v4 = BindUtil.getInputMethod()
u214:SetInputMethod(v4)
local v5 = workspace
local ShowMeleeHitboxes = Settings.Graphics.ShowMeleeHitboxes
local v6 = peek(ShowMeleeHitboxes)
v5:SetAttribute("DebugMelee", v6)

function u214.RequestLoadout(p1) -- Line: 2053
    -- upvalues: FrameworkEvents (val), addToWeaponEventQueue (val), u195 (val), Weapon (val), u214 (val), u196 (val)
    -- upvalues: u189 (ref), u194 (ref), LoopSFX (val), u190 (ref), LocalPlayerController (val), u197 (val), u187 (ref)
    -- upvalues: u193 (ref)
    (FrameworkEvents.RequestLoadout:Call()):After(function(p1, p2) -- Line: 2055
        -- upvalues: addToWeaponEventQueue (upval), u195 (upval), Weapon (upval), u214 (upval), u196 (upval)
        -- upvalues: u189 (upval), u194 (upval), LoopSFX (upval), u190 (upval), LocalPlayerController (upval)
        -- upvalues: u197 (upval), u187 (upval), u193 (upval)
        if p1 and p2 then
            local v1 = addToWeaponEventQueue
            v1(function() -- Line: 2060
                -- upvalues: u195 (upval), p2 (val), Weapon (upval), u214 (upval), u196 (upval), u189 (upval)
                -- upvalues: u194 (upval), LoopSFX (upval), u190 (upval), LocalPlayerController (upval), u197 (upval)
                -- upvalues: u187 (upval), u193 (upval)
                local ammo, ammo_2, hbslot, v1, v2
                local v3 = u195
                local v4 = nil
                local v5 = nil
                for i, j in v3, v4, v5 do
                    if j.Config.Reset then
                        j.Config:Reset(j)
                    end
                end
                v4 = p2
                v3, v4 = unpack(v4)
                removeWeapons()
                v5 = v3
                local v6 = nil
                local v7 = nil
                for k, n in v5, v6, v7 do
                    local u85 = Weapon.new(n.id, n.mods)
                    u85.Slot = k
                    u85.Viewmodel.ConfigLoaded:Once(function() -- Line: 2073 -- upvalues: u85 (val), u214 (upval)
                        local v1 = u85
                        local FireMode = u85.Config.FireMode
                        if FireMode then
                            FireMode = u85.Config.FireMode[u85.SelFireMode]
                        end
                        v1.FireMode = FireMode
                        u214.FireModeChanged:Fire()
                    end)
                    u195[k] = u85
                    u195[k].Slot = k
                    v1 = u195[k]
                    ammo = n.ammo
                    if ammo then
                        ammo = n.ammo[1] or 0
                    end
                    v1.Ammo = ammo
                    v1 = u195[k]
                    ammo_2 = n.ammo
                    if ammo_2 then
                        ammo_2 = n.ammo[2] or 0
                    end
                    v1.StoredAmmo = ammo_2
                    v1 = u195[k]
                    hbslot = n.hbslot
                    v1.HotbarSlot = tonumber(hbslot) or 4
                    if not u196[u85.HotbarSlot] then
                        u196[u85.HotbarSlot] = {}
                    end
                    v2 = u196[u85.HotbarSlot]
                    table.insert(v2, u85)
                    if u85.Config.IsMelee then
                        u189 = k
                    end
                    if u85.Config.IsAPistol then
                        u194 = k
                    end
                    if u85.Config.Shooting_Start then
                        LoopSFX:Init(u85)
                    end
                end
                u190 = nil
                v5 = LocalPlayerController
                v7 = u195
                v5:UpdateInventory(v7)
                v5 = u214
                local InventoryChanged = v5.InventoryChanged
                v7 = u195
                InventoryChanged:Fire(v7)
                if v4 then
                    local v8
                    v5 = u196
                    v6 = nil
                    v7 = nil
                    for m, i5 in v5, v6, v7 do
                        v8 = i5
                        v1 = nil
                        v2 = nil
                        for i6, i7 in v8, v1, v2 do
                            if i7.Slot == v4 then
                                u197.X = m
                                u197.Y = i6
                            end
                        end
                    end
                    u190 = v4
                    u187 = v4
                    u193 = tonumber(v4)
                    v5 = u214
                    local EquippedSlot = v5.EquippedSlot
                    v7 = u187
                    EquippedSlot:Fire(v7)
                    SwapWeapon(v4, true)
                end
            end)
            return
        end
    end)
end

return u214