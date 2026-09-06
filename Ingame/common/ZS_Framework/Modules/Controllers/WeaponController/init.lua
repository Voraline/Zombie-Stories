local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local common = ReplicatedStorage.common
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
workspace:WaitForChild("Ignore")
local Parent = script.Parent
local Classes = Parent.Parent:WaitForChild("Classes")
local Utils = Parent.Parent:WaitForChild("Utils")
local Shared = Parent.Parent:WaitForChild("Shared")
local Resources = script:WaitForChild("Resources")
local Dry = Resources:FindFirstChild("Dry")
local WeaponControllerUtils = script:WaitForChild("WeaponControllerUtils")
local Remotes = ReplicatedStorage.common:WaitForChild("Remotes")
Remotes:WaitForChild("Net")
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
require(ReplicatedStorage.common.SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local ShellSystem = require(Classes.Viewmodel.ViewmodelUtils.ShellSystem)
local ViewmodelManager = require(Parent.ViewmodelManager)
local QuickSwap = require(WeaponControllerUtils.QuickSwap)
local DualWield = require(WeaponControllerUtils.DualWield)
local OffHand = require(WeaponControllerUtils.OffHand)
local OffHandChecks = require(WeaponControllerUtils.OffHandChecks)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local FrameworkEvents = require(ReplicatedStorage.common.RedEvents.Framework.FrameworkEvents)
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
local u214 = {
    EquippedSlot = v1.new(),
    FireModeChanged = v1.new(),
    WeaponEquipped = v1.new(),
    WeaponUnequipped = v1.new(),
    XPChanged = v1.new(),
    AmmoChanged = v1.new(),
    InventoryChanged = v1.new(),
    Reloaded = v1.new(),
    TargetChanged = v1.new(),
    InaccuracyUpdated = v1.new(),
    GunFired = v1.new(),
}
local function GetActiveWeapons() -- Line: 124 -- upvalues: DualWield (val)
    return DualWield:GetActiveWeapons()
end
function u214.Parried(p1) -- Line: 128 -- upvalues: u185 (ref), Fusion (val), SkillTreeData (val), CameraController (val)
    if u185 then
        u185.Parried = true
        local v1 = Fusion.peek(SkillTreeData.ParryWindowBonus) or 0
        u185.ParryTime = os.clock() + (u185.Config.ParryWindow * 2 or 0) + v1
        if u185.Config.Parried then
            u185.Config.Parried(u185)
        end
        CameraController.CameraShaker:ShakeOnce(7, 7, 0, 1, Vector3.new(), (Vector3.new(1, 1, 1)))
    end
end
function u214.Blocked(p1) -- Line: 141 -- upvalues: u185 (ref), SoundUtil (val), CameraController (val)
    if u185 then
        if u185.Config.Blocked then
            u185.Config.Blocked(u185)
        end
        local BlockSFX = u185.Config.BlockSFX
        if not BlockSFX then
            BlockSFX = {SoundId = "7058511525"}
        end
        SoundUtil:PlaySound(BlockSFX)
        CameraController.CameraShaker:ShakeOnce(7, 7, 0, 1, Vector3.new(), (Vector3.new(1, 1, 1)))
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
function u214.SwapWeaponXbox(p1, p2) -- Line: 165 -- upvalues: LocalPlayerController (val), Fusion (val), SkillTreeData (val), u196 (val), u187 (ref), u214 (val), u197 (val)
    if LocalPlayerController.States.IsDead then
        return
    end
    local IsDowned = LocalPlayerController.States.IsDowned
    if IsDowned then
        IsDowned = Fusion.peek(SkillTreeData.HasLastStand)
    end
    if not LocalPlayerController.States.IsDowned then
        local CannotSwapTo, v1, v2
        local v3 = {}
        if not IsDowned then
            v1 = 5
        else
            v1 = 2
        end
        local v4 = v1
        local v5 = 1
        local v6 = p2
        for i = 1, v4, v5 do
            if u196[i] then
                v2 = #u196[i]
                if 0 < v2 then
                    for i2, v in ipairs(u196[i]) do
                        CannotSwapTo = false
                        if v.Config and v.Config.CannotSwapTo then
                            if type(v.Config.CannotSwapTo) ~= "function" then
                                CannotSwapTo = v.Config.CannotSwapTo
                            else
                                CannotSwapTo = v.Config:CannotSwapTo(v)
                            end
                        end
                        if not CannotSwapTo then
                            table.insert(v3, {weapon = v, slotX = i, slotY = i2})
                        end
                    end
                end
            end
        end
        if #v3 == 0 then
            u187 = nil
            u214.EquippedSlot:Fire(nil)
            u197.X = 0
            u197.Y = 0
            LocalPlayerController.BlockPressed = false
            return
        end
        v4 = nil
        for i3, j in ipairs(v3) do
            if j.slotX == u197.X and j.slotY == u197.Y then
                v4 = i3
                break
            end
        end
        if v4 then
            v5 = v4 + v6
            if #v3 < v5 then
                v5 = 1
            elseif v5 < 1 then
                v5 = #v3
            end
        else
            v5 = 1
        end
        local v7 = v3[v5]
        u197.X = v7.slotX
        u197.Y = v7.slotY
        u187 = v7.weapon.Slot
        u214.EquippedSlot:Fire(u187)
        LocalPlayerController.BlockPressed = false
        return
    elseif not IsDowned then
        return
    end
end
function u214.SwapWeapon(p1, p2) -- Line: 244 -- upvalues: LocalPlayerController (val), Fusion (val), SkillTreeData (val), u196 (val), u187 (ref), u214 (val), u197 (val)
    local v1
    if LocalPlayerController.States.IsDead then
        return
    end
    if not LocalPlayerController.States.IsDowned then
        local CannotSwapTo, v2, v3, v4, v5
        v1 = u196[p2]
        if not v1 or #v1 == 0 then
            u187 = nil
            u214.EquippedSlot:Fire(nil)
            u197.X = 0
            u197.Y = 0
            LocalPlayerController.BlockPressed = false
            return
        end
        local v6 = #v1
        local v7 = u197.X == p2
        if not v7 then
            v4 = 1
        else
            v4 = u197.Y + 1
        end
        local v8 = v6 - 1
        local v9 = 1
        for i = 0, v8, v9 do
            v5 = v4 + i
            if v6 < v5 then
                if v7 then
                    u187 = nil
                    u214.EquippedSlot:Fire(nil)
                    u197.X = 0
                    u197.Y = 0
                    LocalPlayerController.BlockPressed = false
                    return
                end
                v5 = (v5 - 1) % v6 + 1
            end
            v3 = v1[v5]
            if v3 then
                CannotSwapTo = false
                if v3.Config and v3.Config.CannotSwapTo then
                    if type(v3.Config.CannotSwapTo) ~= "function" then
                        CannotSwapTo = v3.Config.CannotSwapTo
                    else
                        CannotSwapTo = v3.Config:CannotSwapTo(v3)
                    end
                end
                if not CannotSwapTo then
                    u197.X = v2
                    u197.Y = v5
                    u187 = v3.Slot
                    u214.EquippedSlot:Fire(u187)
                    LocalPlayerController.BlockPressed = false
                    return
                end
            end
        end
        LocalPlayerController.BlockPressed = false
        return
    else
        if not (Fusion.peek(SkillTreeData.HasLastStand)) then
            return
        end
        v1 = tostring(p2)
        if v1 ~= "1" and v1 ~= "2" then
            return
        end
    end
end
function u214.ClassicWeaponSwap(p1, p2) -- Line: 324 -- upvalues: u193 (ref), u187 (ref), u195 (val), u214 (val)
    local CannotSwapTo, v1
    if not u193 then
        u193 = 1
    end
    if u187 then
        u193 = u193 + 1 * (p2 or 1)
    end
    local v2 = 0
    local v3 = #u195 + 1
    while v2 < v3 do
        if not (u195[u193]) then
            u193 = 1
        end
        if not (u195[u193]) then
            u214:SwapWeapon(u193)
            return
        else
            v1 = u195[u193]
            CannotSwapTo = false
            if v1.Config and v1.Config.CannotSwapTo then
                if type(v1.Config.CannotSwapTo) ~= "function" then
                    CannotSwapTo = v1.Config.CannotSwapTo
                else
                    CannotSwapTo = v1.Config:CannotSwapTo(v1)
                end
            end
            if not CannotSwapTo then
                u214:SwapWeapon(u195[u193].HotbarSlot)
                return
            else
                u193 = u193 + 1 * (v4 or 1)
                if u193 < 1 then
                    u193 = #u195
                end
                v2 = v2 + 1
            end
        end
    end
end
function u214.Reload(p1) -- Line: 368 -- upvalues: QuickSwap (val), OffHand (val), DualWield (val), u185 (ref), LocalPlayerController (val)
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
    if not u185 then
        return
    end
    local DelayPerShot = u185.Config.DelayPerShot
    if LocalPlayerController.FocusEnabled then
        DelayPerShot = DelayPerShot / 2
    end
    if not u185.Config.PrimeAction then
        u185.Bursting = false
        u185.CurrentShot = 1
        u185:Reload()
        return
    end
    local v2 = os.clock() - DelayPerShot
    if not (u185.LastShot or 0 <= v2) then
        return
    end
    u185.Bursting = false
    u185.CurrentShot = 1
    u185:Reload()
end
function u214.CycleFiremode(p1) -- Line: 404 -- upvalues: u185 (ref), u214 (val), SoundService (val), Resources (val)
    if u185 then
        local v1 = #u185.Config.FireMode
        if 1 < v1 and not u185.Bursting then
            v1 = u185
            v1.SelFireMode = v1.SelFireMode + 1
            if not (u185.Config.FireMode[u185.SelFireMode]) then
                u185.SelFireMode = 1
            end
            u185.FireMode = u185.Config.FireMode[u185.SelFireMode]
            u214.FireModeChanged:Fire(u185.FireMode)
            u185.Viewmodel:ChangedFiremode()
            SoundService:PlayLocalSound(Resources.FireSelector)
        end
    end
end
function u214.ForceUnequip(p1) -- Line: 417 -- upvalues: u185 (ref), DualWield (val), QuickSwap (val), u187 (ref), u214 (val)
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
        v1 = not (not p2)
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
    local CannotSwapTo
    local v1 = u195
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j.Config and j.Config.IsTwoHandedAbility then
            CannotSwapTo = false
            if j.Config.CannotSwapTo then
                if type(j.Config.CannotSwapTo) ~= "function" then
                    CannotSwapTo = j.Config.CannotSwapTo
                else
                    CannotSwapTo = j.Config:CannotSwapTo(j)
                end
            end
            if not CannotSwapTo then
                return i
            end
        end
    end
    return nil
end
function u214.UseOffHand(p1) -- Line: 471 -- upvalues: u185 (ref), u187 (ref), u186 (ref), WeaponUse (val), OffHand (val), OffHandChecks (val), u195 (val), findTwoHandedAbility (val), u208 (ref), u210 (ref), u197 (val), u209 (ref), u196 (val), u214 (val)
    if not u185 then
        local v1, v2, v3
        if OffHand:IsActive() then
            local v4 = findTwoHandedAbility()
            if not v4 then
                return false
            end
            v1 = u195[v4]
            u208 = u187
            v2 = {X = u197.X, Y = u197.Y}
            u210 = v2
            u209 = true
            u187 = v4
            if v1 and v1.HotbarSlot then
                u197.X = v1.HotbarSlot
                u197.Y = 1
                if u196[v1.HotbarSlot] then
                    v2 = u196[v1.HotbarSlot]
                    v3 = nil
                    local v5 = nil
                    for i, j in v2, v3, v5 do
                        if j == v1 then
                            u197.Y = i
                            break
                        end
                    end
                end
            end
            u214.EquippedSlot:Fire(v4)
            return true
        elseif OffHandChecks.CanUseWithCurrentWeapon(u185) then
            v1 = u195
            v2 = nil
            v3 = nil
            for k, n in v1, v2, v3 do
                if OffHandChecks.CanUseItem(n, u185) and OffHand:UseItem(k) then
                    return true
                end
            end
        end
    elseif u185.Config and u185.Config.IsTwoHandedAbility then
        if not u187 then
            if u186 then
                return false
            end
            if u185.Config.Use then
                function u185.FireServerDeployEvent() -- Line: 485 -- upvalues: WeaponUse (upval)
                    WeaponUse:FireServer()
                end
                u185.Config:Use(u185)
            end
            return true
        end
        if u187 ~= u185.Slot or u186 then
            return false
        end
        if u185.Config.Use then
            function u185.FireServerDeployEvent() -- Line: 485 -- upvalues: WeaponUse (upval)
                WeaponUse:FireServer()
            end
            u185.Config:Use(u185)
        end
        return true
    end
end
function u214.CancelOffHand(p1) -- Line: 543 -- upvalues: u209 (ref), u185 (ref), u187 (ref), u208 (ref), u214 (val), u210 (ref), u197 (val), OffHand (val)
    if not u209 then
        if OffHand:IsActive() then
            OffHand:Cancel()
            return true
        end
        return false
    end
    if u185 and u185.Config and u185.Config.CancelPreActivation then
        u185.Config:CancelPreActivation(u185)
    end
    u187 = u208
    u214.EquippedSlot:Fire(u208)
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
function UnequipWeapon() -- Line: 666 -- upvalues: QuickSwap (val), DualWield (val), OffHand (val), u185 (ref), ViewmodelManager (val), u186 (ref), LocalPlayerController (val), u214 (val), HUDService (val), Dry (val)
    QuickSwap:Cleanup()
    DualWield:Cleanup()
    OffHand:Cleanup()
    if u185 then
        ViewmodelManager:Unequip(u185)
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
    table.insert(u201, p1)
    local v1 = #u201
    if 2 < v1 then
        table.remove(u201, 1)
    end
end
function getLastWeapon() -- Line: 704 -- upvalues: u201 (val)
    if u201[1] then
        return u201[1]
    end
    return nil
end
function SwapWeapon(p1, p2) -- Line: 711 -- upvalues: Dry (val), u185 (ref), LocalPlayerController (val), u186 (ref), u188 (ref), u195 (val), QuickSwap (val), DualWield (val), u187 (ref), u214 (val), OffHand (val), u209 (ref), u208 (ref), u210 (ref), OffHandChecks (val), ViewmodelManager (val), SoundUtil (val), Equipped (val), u189 (ref), u194 (ref), u190 (ref), WeaponUse (val), u197 (val)
    if Dry then
        Dry:Stop()
    end
    if u185 then
        u185.Bursting = false
        u185.CurrentShot = 1
    end
    if LocalPlayerController.States.IsDead then
        return
    elseif u186 then
        return
    else
        local v1, v2, v3
        if u188 then
            return
        end
        if p2 then
            if not (QuickSwap:IsActive()) then
                v2, v1 = p2, p1
            else
                QuickSwap:Cancel()
                v2, v1 = p2, p1
            end
            if v2 then
                local v4
                if DualWield:IsActive() then
                    local Weapons, Weapons_2
                    v3 = v1
                    if v3 then
                        v3 = u195[v1]
                    end
                    Weapons, Weapons_2 = DualWield:GetWeapons()
                    v4 = v3
                    if v4 then
                        v4 = if v3 ~= Weapons then v3 == Weapons_2 else true
                    end
                    if not v1 then
                        DualWield:Stop()
                        UnequipWeapon()
                        u187 = nil
                        u214.EquippedSlot:Fire(nil)
                        return
                    end
                    if v4 then
                        return
                    end
                    DualWield:Stop()
                elseif not (OffHand:IsActive()) then
                    if u185 and u185.Config and u185.Config.IsTwoHandedAbility then
                        v3 = v1
                        if v3 then
                            v3 = u195[v1]
                        end
                        if not v3 then
                            if u185.Config.CancelPreActivation then
                                u185.Config:CancelPreActivation(u185)
                            end
                            u209 = false
                            u208 = nil
                            u210 = nil
                        elseif v3 == u185 then
                        end
                    end
                    if v2 then
                        if not u185 then
                            if v2 then
                                u214.EquippedSlot:Fire(v1)
                                u187 = v1
                            end
                            if u187 and u195[u187] then
                                u185 = u195[u187]
                                Equipped:FireServer(u187)
                                u185:Equip()
                                ViewmodelManager:Equip(u185, "Both", u185.Config.ViewmodelPriority or 10)
                                SoundUtil:PlaySound(u185.Config.DeploySFX)
                                if u195[v1].Config.IsMelee then
                                    u189 = v1
                                elseif u195[v1].Config.IsAPistol then
                                    u194 = v1
                                end
                                addToLast2Weapons(u187)
                                u190 = getLastWeapon()
                                setupConfigurationChanges(u195[u187])
                                QuickSwap:ResumePausedReload(u185)
                                u214.WeaponEquipped:Fire(u185)
                                u214.AmmoChanged:Fire(true)
                                LocalPlayerController.CurrentWeapon = u185
                                LocalPlayerController:UpdateCurrentWeapon()
                                if u195[v1].Config.IsTwoHandedAbility and u209 and LocalPlayerController.OffHandPressed then
                                    function u185.FireServerDeployEvent() -- Line: 926 -- upvalues: WeaponUse (upval)
                                        WeaponUse:FireServer()
                                    end
                                    function u185.OnDeploymentComplete() -- Line: 931 -- upvalues: u209 (upval), u208 (upval), u187 (upval), u214 (upval), u210 (upval), u197 (upval)
                                        if u209 and u208 then
                                            task.defer(function() -- Line: 933 -- upvalues: u187 (upval), u208 (upval), u214 (upval), u210 (upval), u197 (upval), u209 (upval)
                                                u187 = u208
                                                u214.EquippedSlot:Fire(u208)
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
                                            u185.Config:Use(u185)
                                        end
                                    end)
                                end
                            end
                            return
                        else
                            u186 = v1 or true
                            if u185.AutoLoop and u185.AutoLoop.Playing then
                                u185.AutoLoop:Stop()
                                u185.AutoLoopEnd:Play()
                            end
                            v3 = u185
                            ViewmodelManager:Unequip(v3)
                            if not v2 then
                                SoundUtil:PlaySound(u185.Config.UnequipSFX)
                                if u185:Unequip() then
                                    ViewmodelManager:Equip(v3, "Both", v3.Config.ViewmodelPriority or 10)
                                    u186 = false
                                    return
                                end
                                Equipped:FireServer(nil)
                                u186 = false
                                if not v2 then
                                    if not v1 then
                                        UnequipWeapon()
                                        return
                                    elseif not (u195[v1]) then
                                        UnequipWeapon()
                                        return
                                    elseif u195[v1] and u185 and u195[v1].Slot == u185.Slot then
                                        UnequipWeapon()
                                        return
                                    end
                                end
                            else
                                u185:ForceUnequip()
                            end
                        end
                    elseif v1 and u195[v1] then
                        local v5 = OffHandChecks.CanUseItem(u195[v1], u185)
                        if v5 and OffHandChecks.CanUseWithCurrentWeapon(u185) and OffHand:UseItem(v1) then
                            if not u185 then
                                return
                            end
                            v4 = u195
                            local v6 = nil
                            local v7 = nil
                            for i, j in v4, v6, v7 do
                                if j == u185 then
                                    u187 = i
                                    return
                                end
                            end
                            return
                        end
                    end
                else
                    v3 = v1
                    if v3 then
                        v3 = u195[v1]
                    end
                    local Item = OffHand:GetItem()
                    local PrimaryWeapon_2 = OffHand:GetPrimaryWeapon()
                    if not v1 or v3 == Item or v3 == PrimaryWeapon_2 then
                        OffHand:Cancel()
                        return
                    end
                    OffHand:Cancel()
                end
            elseif v1 and u195[v1] and u185 then
                v3 = u195[v1]
                if u185.Config.CanDualWield and v3.Config.CanDualWield and u185.WeaponId == v3.WeaponId and v3 ~= u185 and not (DualWield:IsActive()) then
                    print(string.format("[WeaponController-DEBUG] Auto-dual-wield triggered: %s + %s", u185.Name or "Unknown", v3.Name or "Unknown"))
                    if DualWield:StartWithWeapons(u185, v3) then
                        return
                    end
                end
            end
        elseif p1 and u195[p1] then
            v3 = u195[p1]
            if QuickSwap:IsActive() then
                local PrimaryWeapon = QuickSwap:GetPrimaryWeapon()
                if not PrimaryWeapon then
                    if v3 == u185 then
                        QuickSwap:Complete()
                        return
                    end
                    QuickSwap:Cancel()
                    v2, v1 = p2, p1
                elseif v3 == PrimaryWeapon then
                    QuickSwap:Cancel()
                    return
                end
            elseif not u185 then
                v2, v1 = p2, p1
            elseif not v3.Config.IsAPistol then
                v2, v1 = p2, p1
            elseif u185.Config.IsMelee then
                v2, v1 = p2, p1
            elseif u185.Config.IsAPistol then
                v2, v1 = p2, p1
            else
                if QuickSwap:Start(p1) then
                    return
                end
                v2, v1 = p2, p1
            end
        end
    end
end
function u214.CaptureEquippedState(p1) -- Line: 957 -- upvalues: u185 (ref), u197 (val)
    if not u185 then
        return nil
    end
    return {inventorySlot = u185.Slot, hotbarSlot = u197.X, hotbarSubSlot = u197.Y}
end
function u214.RestoreEquippedState(p1, p2) -- Line: 968 -- upvalues: u195 (val), u197 (val), u185 (ref)
    if type(p2) ~= "table" or not p2.inventorySlot or not (u195[p2.inventorySlot]) then
        return false
    end
    u197.X = p2.hotbarSlot or 0
    u197.Y = p2.hotbarSubSlot or 0
    SwapWeapon(p2.inventorySlot, true)
    local v1 = u185 == u195[p2.inventorySlot]
    return v1
end
local u283 = nil
function setupConfigurationChanges(p1) -- Line: 979 -- upvalues: u283 (ref), HUDService (val), CameraController (val)
    local AimFOVMultiplier, StaminaDisplay
    if u283 then
        u283:Disconnect()
    end
    u283 = p1.Viewmodel.ConfigLoaded:Connect(function() -- Line: 984 -- upvalues: HUDService (upval), p1 (val), CameraController (upval)
        local StaminaDisplay = HUDService.Elements.StaminaDisplay
        if StaminaDisplay then
            StaminaDisplay:SetPlacement(p1.Config.IsMelee)
        end
        local AimFOVMultiplier = p1.Config.AimFOVMultiplier
        if AimFOVMultiplier then
            CameraController:SetMagnificationSensitivity(AimFOVMultiplier)
            return
        end
        CameraController:SetMagnificationSensitivity(1)
    end)
    StaminaDisplay = HUDService.Elements.StaminaDisplay
    if StaminaDisplay then
        StaminaDisplay:SetPlacement(p1.Config.IsMelee)
    end
    AimFOVMultiplier = p1.Config.AimFOVMultiplier
    if AimFOVMultiplier then
        CameraController:SetMagnificationSensitivity(AimFOVMultiplier)
        return
    end
    CameraController:SetMagnificationSensitivity(1)
end
function WeaponStepped(p1) -- Line: 1002 -- upvalues: u185 (ref), LocalPlayerController (val), u187 (ref), u214 (val), ShellSystem (val), Melee (val), HUDService (val), DualWield (val), GameState (val), u189 (ref), u195 (val), Fusion (val), SkillTreeData (val), u205 (ref), u204 (ref), u191 (ref), u192 (ref), u203 (ref), u190 (ref), u194 (ref), u186 (ref), u188 (ref), u206 (ref), AutoShoot (val), u207 (ref), peek (val), Settings (val), SharedSprings (val), CancelReload (val), Dry (val), WeaponUse (val), u202 (ref), LoopSFX (val), SoundUtil (val), QuickSwap (val)
    if not u185 then
        local Ammo, BaseSpread_2, Config, Config_3, Slot, StaminaDisplay, StoredAmmo, v1, v2, v3, v4, v5, v6, v7, v8, v9
        local v10 = 1
        local v11 = 1
        if LocalPlayerController.FocusEnabled then
            v10 = 2
            v11 = 0.5
        end
        if not ShellSystem.UsingViewmodelStep then
            ShellSystem:Update(p1)
        end
        if not u185 then
            u214.Blocking = false
            u214.Parrying = false
        elseif u185.Config and u185.Config.IsMelee then
            Melee.Think(u185, p1, LocalPlayerController)
            u214.Blocking = u185.Blocking
            if not u185.Blocking then
                if not u185.Blocking then
                    u185.ParryTime = nil
                    u214.Parrying = false
                end
            elseif u185.ParryTime then
                v7 = os.clock() <= u185.ParryTime
                u214.Parrying = v7
            end
        end
        if not u185 then
            if HUDService.Elements.StaminaDisplay and HUDService.Elements.StaminaDisplay.ChargeDisplay then
                StaminaDisplay = HUDService.Elements.StaminaDisplay
                StaminaDisplay.ChargeDisplay = false
                HUDService.Elements.StaminaDisplay:ChargeNotReady()
            end
        elseif u185.Charging and u185 and u185.Charging then
            local Stamina = LocalPlayerController:GetStamina()
            if Stamina >= u185.Config.HeavyStaminaRequired or 9999999 then end
        end
        local ActiveWeapons = DualWield:GetActiveWeapons()
        v7 = ActiveWeapons
        local v12 = nil
        local v13 = nil
        for i, j in v7, v12, v13 do
            Config_3 = j.Config
            if not j.ShootingInaccuracy then
                j.ShootingInaccuracy = 0
            end
            BaseSpread_2 = Config_3.BaseSpread
            if not BaseSpread_2 then
                BaseSpread_2 = Config_3.Spread
            end
            if BaseSpread_2 then
                BaseSpread_2 = BaseSpread_2 * (GameState.Data.Variables.WeaponSpread * (game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult") or 1))
            end
            v5 = v1 / (Config_3.ShootingSpreadDecay or 0.3)
            j.ShootingInaccuracy = Lerp(j.ShootingInaccuracy, 0, (math.min(v5, 1)))
            v2 = 1
            v3 = false
            if LocalPlayerController.States.Crouching then
                v2 = v2 * (Config_3.CrouchSpreadReduction or 0.5)
                v3 = true
            elseif not LocalPlayerController.States.Sliding and LocalPlayerController.States.Proning then
                v2 = v2 * (Config_3.ProneSpreadReduction or 0.25)
                v3 = true
            end
            if not j.Aiming then
                if not BaseSpread_2 then
                    v4 = 0
                else
                    v4 = math.deg(BaseSpread_2) * 2
                end
                j.Inaccuracy = v4 * v2
                if LocalPlayerController.humanoid.HasLanded then
                    v5 = 0
                else
                    v5 = Config_3.AirSpread or 25
                end
                j.Inaccuracy = j.Inaccuracy + j.ShootingInaccuracy + v5
                j.Inaccuracy = math.max(0, j.Inaccuracy)
            elseif j.ADSStrength and 0.9 < j.ADSStrength then
                if v3 then
                    v2 = v2 * 1.65
                end
                v2 = v2 * (Config_3.ADSSpreadReduction or 0.75)
                if not BaseSpread_2 then
                    v4 = 0
                else
                    v4 = math.deg(BaseSpread_2) * 2
                end
                j.Inaccuracy = v4 * v2
                j.Inaccuracy = math.max(0, j.Inaccuracy)
            end
        end
        if 0 < #ActiveWeapons then
            u214.InaccuracyUpdated:Fire()
        end
        if u189 then
            v6 = u195[u189]
            v8 = os.clock() - v6.Config.DelayPerShot / (Fusion.peek(SkillTreeData.MeleeSwingSpeedMult) or 1)
            if v6.LastShot or 0 <= v8 then
                v13 = true
            else
                v13 = false
            end
            if not v13 then
                if LocalPlayerController.BlockPressed then
                    if u203 and u185 and not u185.Meleeing and u185.Slot == u189 and not u204 then
                        u187 = u190
                        u205 = false
                    end
                elseif u191 and u185 and u185.Slot == u189 then
                    u191 = false
                    if u192 < 0.25 then
                        u203 = true
                    elseif not u204 then
                        u187 = u190
                        u205 = false
                    end
                end
            elseif LocalPlayerController.BlockPressed and u195[u189] then
                local Stamina_2 = LocalPlayerController:GetStamina()
                if u195[u189].Config.StaminaRequired <= Stamina_2 and not LocalPlayerController.States.IsDowned then
                    if not u185 then
                        u205 = true
                        u204 = false
                        u187 = u189
                        if v6 then
                            v6.QuickEquip = true
                        end
                    elseif u185.Slot == u189 and not u205 then
                        u204 = true
                    end
                    u191 = true
                end
            end
            if not LocalPlayerController.BlockPressed then
                u192 = 0
            else
                u192 = u192 + v1
            end
        end
        if u203 then
            if not u203 then
                if not u203 then
                    if u203 and not u185 then
                        if u203 then
                            u187 = u189
                        end
                        if LocalPlayerController.States.IsDowned and not LocalPlayerController.States.IsDead then
                            if not (Fusion.peek(SkillTreeData.HasLastStand)) then
                                u187 = u194
                            else
                                v6 = tostring(u187)
                                if v6 ~= "1" and v6 ~= "2" then
                                    local Slot_2
                                    if not u185 then
                                        Slot_2 = u194
                                    elseif u185.Slot == "1" then
                                        Slot_2 = u185.Slot
                                    elseif u185.Slot ~= "2" then
                                    end
                                    u187 = Slot_2
                                end
                            end
                        end
                        if not u187 then
                            if not u187 and u185 and not u186 and not u188 then
                                SwapWeapon()
                            end
                        elseif u195[u187] then
                            if not u185 then
                                if u185 then
                                    if u185 and u185 == u195[u187] and not u185.IsEquipped then
                                        u185.CancelUnequip = true
                                    end
                                elseif not u186 and not u188 then
                                    SwapWeapon(u187)
                                end
                            elseif u185 ~= u195[u187] then
                            end
                        end
                    end
                elseif u185 and u185.Slot == u189 and not u185.IsEquipped then
                end
            elseif u185 and u185.Slot ~= u189 then
            end
        elseif u185 and u185 and not u185.Meleeing then
        end
        if u214.MobileShootDown then
            u214.PrimaryAttackDown = true
        elseif u206 then
            u214.PrimaryAttackDown = false
        end
        v6 = AutoShoot:CheckTarget()
        if u207 ~= v6 then
            u214.TargetChanged:Fire(v6)
            u207 = v6
        end
        if not u206 then
            if u214.PrimaryAttackDown and u206 and peek(Settings.Controls.AutoShoot) and not u214.MobileShootDown and u185 and not u185.Config.IsMelee then
                u214.PrimaryAttackDown = false
            end
        elseif peek(Settings.Controls.AutoShoot) and u185 and not u185.Config.IsMelee and not u185.Config.Deployable and 0 < u185.Ammo and u185.Primed ~= false and v6 then
            u214.PrimaryAttackDown = true
            u185.MouseReleased = true
        end
        if not u185 then end
        local QuickDrawActive = u185
        if QuickDrawActive then
            QuickDrawActive = u185.QuickDrawActive
        end
        if not u185 then
            v13 = not LocalPlayerController.States.Sprinting
            if v13 then
                v13 = QuickDrawActive
                if not v13 then
                    v8 = 0.1 < SharedSprings.EquipSpring.Position
                    v13 = not v8
                end
            end
        elseif u185.Config.IsMelee then
        end
        if u185 then
            local ActiveWeapons_2, ActiveWeapons_3, ActiveWeapons_4, MouseReleased, v14, v15, v16
            v8 = game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1
            v9 = v8 * Fusion.peek(SkillTreeData.ReloadSpeedMult)
            if u185.Reloading and u214.PrimaryAttackDown and u185.Config.UsesLoadLoop and 0 < u185.Ammo and u185.MouseReleased then
                if not u185.Config.UsesLoadLoop then
                    u185.CancelReload = true
                elseif u185.Config.LoadStopOnReload then
                    u185.ReloadingTime = u185.Config.LoadStopTime * v9
                    u185.LoopStage = 3
                end
            end
            if u185.ReloadingTime then
                if u185.ReloadingTime <= 0 then
                    u185.ReloadingTime = 0
                    if not u185.Config.UsesLoadLoop then
                        Config = u185.Reloaded
                        if not Config then
                            Config = u185
                            Config.Reloading = false
                            Config = u185.Config.AmmoUpdated
                            if Config then
                                task.defer(function() -- Line: 1408 -- upvalues: u185 (upval)
                                    local v1 = {Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}
                                    u185.Config.AmmoUpdated(v1, u185.Viewmodel.Model, v1)
                                end)
                            end
                            Config = u185.newAmmo
                            if Config then
                                print("Updated Client ammo: NewAmmo Object", u185.newAmmo)
                                Config = u185
                                Config.Ammo = u185.newAmmo[1]
                                Config = u185
                                Config.StoredAmmo = u185.newAmmo[2]
                                u214.AmmoChanged:Fire()
                                u214.Reloaded:Fire()
                                Config = u185
                                Config.newAmmo = nil
                            end
                            Config = u185
                            Config.Reloaded = true
                            u185:ReloadFinished()
                            Config = DualWield:IsActive()
                            if Config then
                                u214:DualWieldReloadComplete(u185)
                            end
                        end
                    else
                        if u185.LoopStage == 1 then
                            if not u185.Config.ShouldNotCycleAfterReload and u185.Config.PrimeAction and u185.Ammo <= 0 then
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
                            elseif u185.Config.Ammo > u185.Ammo and not u185.CancelReload then
                            end
                            if not u185.IncreasedAmmo then
                                if u185.LoopStage == 2 then
                                    Config = u185.Config.AmmoPerLoad or 1
                                    if u185.StoredAmmo < Config then
                                        Config = u185.StoredAmmo
                                    end
                                    v2 = Config + u185.Ammo
                                    if u185.Config.Ammo >= v2 then
                                        v2 = u185
                                        v2.Ammo = v2.Ammo + Config
                                    else
                                        u185.Ammo = u185.Config.Ammo
                                    end
                                    v2 = u185
                                    v2.StoredAmmo = v2.StoredAmmo - Config
                                    if u185.Config.AmmoUpdated then
                                        task.defer(function() -- Line: 1324 -- upvalues: u185 (upval), Config (ref)
                                            u185.Config.AmmoUpdated({Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}, u185.Viewmodel.Model, {Ammo = u185.Ammo - Config, StoredAmmo = u185.StoredAmmo - Config})
                                        end)
                                    end
                                    u214.AmmoChanged:Fire()
                                    u214.Reloaded:Fire()
                                    u185.ReloadingTime = (u185.Config.InsertTime - u185.Config.IncrAmmoCountTime) * v11 * v9
                                    u185.IncreasedAmmo = true
                                end
                            elseif u185.LoopStage == 2 then
                                local LoadLoop = u185.Viewmodel.Animations.LoadLoop
                                if LoadLoop then
                                    LoadLoop.Priority = Enum.AnimationPriority.Action4
                                    local InsertAnimationTime = u185.Config.InsertAnimationTime
                                    if not InsertAnimationTime then
                                        InsertAnimationTime = u185.Config.InsertTime
                                    end
                                    u185.Viewmodel:PlayAnimation("LoadLoop", 0, 1, LoadLoop.Length / InsertAnimationTime * v10 / v9)
                                end
                                u185.ReloadingTime = u185.Config.IncrAmmoCountTime * v11 * v9
                                u185.IncreasedAmmo = false
                            end
                        end
                        Config = u185.LoopStage
                        if Config ~= 3 then
                            Config = u185.Reloaded
                            if not Config then
                                Config = u185.LoopStage
                                if Config == 4 then
                                    Config = u185
                                    Config.Reloading = false
                                    Config = u185
                                    Config.Reloaded = true
                                    Config = u185
                                    Config.CancelReload = false
                                    Config = DualWield:IsActive()
                                    if Config then
                                        u214:DualWieldReloadComplete(u185)
                                    end
                                end
                            end
                        else
                            if not u185.CancelReload then
                                Config = nil
                            else
                                Config = 0
                            end
                            u185.Viewmodel:StopAnimation("LoadLoop", Config)
                            u185.Viewmodel:StopAnimation("LoadIdle", Config)
                            u185.Viewmodel:StopAnimation("LoadStart", Config)
                            u185.Viewmodel:StopAnimation("LoadStartEmpty", Config)
                            local LoadStop = u185.Viewmodel.Animations.LoadStop
                            if LoadStop and not u185.CancelReload then
                                local LoadStopAnimationTime = u185.Config.LoadStopAnimationTime
                                if not LoadStopAnimationTime then
                                    LoadStopAnimationTime = u185.Config.LoadStartTime
                                end
                                u185.Viewmodel:PlayAnimation("LoadStop", 0, 1, LoadStop.Length / LoadStopAnimationTime * v10 / v9)
                            end
                            u185.CancelReload = false
                            u185.LoopStage = 4
                            local u867 = u185
                            Slot = u867.Slot
                            Ammo = u867.Ammo
                            task.defer(function() -- Line: 1362 -- upvalues: u867 (val), CancelReload (upval), Slot (val), Ammo (val), u214 (upval)
                                if u867.IsDestroyed then
                                    return
                                end
                                local v1 = CancelReload:Call({Slot, Ammo})
                                v1:After(function(p1, p2) -- Line: 1366 -- upvalues: u867 (upval), Ammo (upval), u214 (upval)
                                    if not p1 or not p2 or not u867 or u867.IsDestroyed then
                                        warn(p2)
                                        return
                                    end
                                    p2[1] = p2[1] - (Ammo - u867.Ammo)
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
                                end)
                            end)
                        end
                    end
                elseif not u185.CancelReload then
                    Config = u185.Config.UsesLoadLoop
                    if not Config then
                        Config = not (not LocalPlayerController.FocusEnabled)
                        if Config ~= u185.ReloadFocusActive or false then
                            if not Config then
                                v2 = 2
                            else
                                v2 = 0.5
                            end
                            u185.ReloadingTime = u185.ReloadingTime * v2
                            if u185.ReloadCancelTime then
                                u185.ReloadCancelTime = u185.ReloadCancelTime * v2
                            end
                            u185.ReloadFocusActive = Config
                            if u185.Viewmodel and u185.Viewmodel.Animations then
                                v4 = {"Reload", "ReloadEmpty", "LoadStart", "LoadStartEmpty"}
                                v5 = nil
                                v14 = nil
                                for k, n in v4, v5, v14 do
                                    v16 = u185.Viewmodel.Animations[n]
                                    if v16 and v16.IsPlaying then
                                        v16:AdjustSpeed(v16.Speed * (1 / v2))
                                        break
                                    end
                                end
                            end
                        end
                    end
                    Config = u185
                    Config.ReloadingTime = u185.ReloadingTime - v1
                    Config = u185.ReloadingTime
                    if Config < u185.ReloadCancelTime or 0 then
                        Config = u185.IsEquipped
                        if not Config then
                            Config = u185
                            Config.ReloadingTime = 0
                        end
                        Config = u185.newAmmo
                        if Config then
                            Config = u185.MagInUpdate
                            if not Config then
                                Config = u185
                                Config.MagInUpdate = true
                                Config = u185
                                Config.Ammo = u185.newAmmo[1]
                                Config = u185
                                Config.StoredAmmo = u185.newAmmo[2]
                                u214.AmmoChanged:Fire()
                                u214.Reloaded:Fire()
                                Config = u185
                                Config.newAmmo = nil
                            end
                        end
                    end
                end
            end
            Config = u185.Ammo
            if Config <= 0 then
                Config = u185.Bursting
                if Config then
                    Config = u185
                    Config.Bursting = false
                    Config = u185
                    Config.CurrentShot = 1
                end
            end
            Config = u185.Ammo
            if Config > 0 then
                Config = Dry
                if Config then
                    Config = Dry.IsPlaying
                    if Config then
                        Dry:Stop()
                    end
                end
            else
                Config = u185.Reloading
                if not Config then
                    Config = u185.Config.IsMelee
                    if not Config then
                        Config = u214.PrimaryAttackDown
                        if Config then
                            Config = Dry
                            if Config then
                                Config = Dry.IsPlaying
                                if not Config then
                                    Dry:Play()
                                end
                            end
                        else
                            Config = Dry
                            if Config then
                                Dry:Stop()
                            end
                        end
                        Config = u185.StoredAmmo
                        if 0 < Config then
                            Config = Dry
                            if Config then
                                Dry:Stop()
                            end
                            Config = DualWield:IsActive()
                            if not Config then
                                u214:Reload()
                            else
                                u214:DualWieldAutoReload(u185)
                            end
                        end
                    end
                end
            end
            Config = u185.Config.DelayPerShot / GameState.Data.Variables.FireRate
            if u185.FireMode ~= "Auto" and u185.FireMode ~= "Burst" and not u185.Config.IsMelee then
                Config = Config * v11
            end
            if u185.Config.IsMelee then
                Config = Config / (Fusion.peek(SkillTreeData.MeleeSwingSpeedMult) or 1)
            end
            local Config_2 = u185.Config
            local ADSFireMode = nil
            local ADSFireRate = nil
            if not u185.Aiming then
                if Config_2.HipFireMode then
                    ADSFireMode = Config_2.HipFireMode
                    ADSFireRate = Config_2.HipFireRate
                    if Config_2.VariableShotgun then
                        Config_2.Damage = Config_2.HipDmg
                        Config_2.BulletsPerShot = Config_2.HipFirePellets
                    end
                end
            elseif Config_2.ADSFireMode and Config_2.ADSFireRate then
                ADSFireMode = Config_2.ADSFireMode
                ADSFireRate = Config_2.ADSFireRate
                if Config_2.VariableShotgun then
                    Config_2.Damage = Config_2.AimDmg
                    Config_2.BulletsPerShot = Config_2.ADSPellets
                end
            end
            if ADSFireMode then
                u185.FireMode = ADSFireMode
                Config_2.DelayPerShot = ADSFireRate
                u214.FireModeChanged:Fire(ADSFireMode)
            end
            local HeavyDelayPerShot = u185.Config.HeavyDelayPerShot
            if not HeavyDelayPerShot then
                HeavyDelayPerShot = u185.Config.FireRate
            end
            if HeavyDelayPerShot then
                HeavyDelayPerShot = HeavyDelayPerShot / GameState.Data.Variables.FireRate * 0.5 * v11
            end
            if not v13 then
                v14 = os.clock()
                if u185.FireMode ~= "Burst" then
                    v15 = Config
                else
                    v15 = 0
                end
                v5 = v14 - v15
                if u185.LastShot or 0 <= v5 then
                    u185.MouseReleased = true
                end
            elseif u214.PrimaryAttackDown then
                if not u185.Busy then
                    if DualWield:IsActive() and u214.PrimaryAttackDown then
                        v5, v14 = u214:DualWieldFire()
                        if v5 and v14 then
                            Config_2 = u185.Config
                            local FireRate = Config_2.FireRate
                            if not FireRate then
                                FireRate = Config_2.DelayPerShot
                                if not FireRate then
                                    FireRate = 0.15
                                end
                            end
                            Config = FireRate / GameState.Data.Variables.FireRate * v11
                        end
                    end
                    v14 = os.clock() - Config
                    if u185.LastShot or 0 <= v14 then
                        v5 = true
                    else
                        v5 = false
                    end
                    MouseReleased = v5
                    if MouseReleased then
                        MouseReleased = u185.MouseReleased
                        if MouseReleased then
                            if not u185.Config.IsMelee then
                                MouseReleased = false
                                if 0 >= u185.Ammo then end
                            elseif u185.ReloadingTime then
                                MouseReleased = u185.ReloadingTime
                                if MouseReleased then
                                    MouseReleased = false
                                    if u185.ReloadingTime <= 0 then
                                        MouseReleased = u185.Reloaded
                                        if not MouseReleased then end
                                    end
                                end
                            elseif u185.Config.PrimeAction then
                                MouseReleased = u185.Primed
                                if not MouseReleased then end
                            elseif u185.Charging then
                                MouseReleased = not u185.Busy
                            elseif u185.Config.StaminaRequired then
                                MouseReleased = false
                                local Stamina_3 = LocalPlayerController:GetStamina()
                                if u185.Config.StaminaRequired > Stamina_3 then end
                            end
                        end
                    end
                    if u203 then
                        local Stamina_4 = LocalPlayerController:GetStamina()
                        if Stamina_4 < u185.Config.StaminaRequired then
                            u185.QuickEquip = nil
                            u203 = false
                        elseif u185.Config.StaminaRequired then
                        end
                    end
                    if u185.Config.CustomShouldFire and not (u185.Config.CustomShouldFire(u185)) then
                        MouseReleased = false
                    end
                    if u185.Config.StaminaRequired then
                        local Stamina_5 = LocalPlayerController:GetStamina()
                        if Stamina_5 < u185.Config.StaminaRequired and u214.PrimaryAttackDown then
                            HUDService.Elements.StaminaDisplay:FlashRequired(u185.Config.StaminaRequired)
                        end
                    end
                    if not MouseReleased then
                        if MouseReleased then
                            if not u214.PrimaryAttackDown then
                                if u214.PrimaryAttackDown then
                                    if u203 then
                                        u202 = true
                                    end
                                elseif u185.PrimaryAttackStart then
                                end
                            elseif not u185.PrimaryAttackStart and v13 then
                                u185.PrimaryAttackStart = os.clock()
                                u185.Charging = true
                            end
                            if u185.Charging and u185.PrimaryAttackStart + (u185.Config.ChargeTime or 9999) <= os.clock() then
                                local Stamina_6 = LocalPlayerController:GetStamina()
                                if (u185.Config.HeavyStaminaRequired or 9999999 <= Stamina_6) and HUDService.Elements.StaminaDisplay and not HUDService.Elements.StaminaDisplay.ChargeDisplay then
                                    local StaminaDisplay_2 = HUDService.Elements.StaminaDisplay
                                    StaminaDisplay_2.ChargeDisplay = true
                                    HUDService.Elements.StaminaDisplay:ChargeReady()
                                end
                            end
                            if not u185.Config.IsMelee then
                                local BaseSpread, LayeredSFXs, v17, v18, v19, v20
                                u202 = false
                                if not u185.StartSFX then
                                    local ShootSingle
                                    if u185.Config.ShootSingle then
                                        ShootSingle = if u185.Config.HasSuppressor and u185.Config.SuppressorShootSingle then u185.Config.SuppressorShootSingle else u185.Config.ShootSingle
                                        SoundUtil:PlaySound(ShootSingle)
                                    end
                                elseif not u185.Config.HasSuppressor then
                                    LoopSFX:Start(u185)
                                end
                                if u185.Config.LayeredSFXs then
                                    local v21, v22
                                    LayeredSFXs = u185.Config.LayeredSFXs
                                    v17 = nil
                                    v16 = nil
                                    for m, i5 in LayeredSFXs, v17, v16 do
                                        v21 = tonumber(m)
                                        if 0 >= v21 then
                                            v21 = i5
                                            v20 = nil
                                            v22 = nil
                                            for i6, i7 in v21, v20, v22 do
                                                SoundUtil:PlaySound(i7)
                                            end
                                        else
                                            v21 = i5
                                            v20 = nil
                                            v22 = nil
                                            for i8, i9 in v21, v20, v22 do
                                                task.delay(m, function() -- Line: 1631 -- upvalues: SoundUtil (upval), i9 (val)
                                                    SoundUtil:PlaySound(i9)
                                                end)
                                            end
                                        end
                                    end
                                end
                                if u185.AutoLoop and not u185.AutoLoop.Playing then
                                    u185.AutoLoop:Play()
                                end
                                v15 = 100
                                v17 = false
                                if LocalPlayerController.States.Crouching then
                                    if not Config_2.CrouchSpreadReduction then
                                        v15 = 50
                                    else
                                        v15 = Config_2.CrouchSpreadReduction * 10
                                    end
                                    v17 = true
                                end
                                if LocalPlayerController.States.Proning then
                                    if not Config_2.ProneSpreadReduction then
                                        v15 = 25
                                    else
                                        v15 = Config_2.ProneSpreadReduction * 10
                                    end
                                    v17 = true
                                end
                                if u185.Aiming and u185.ADSStrength and 0.9 < u185.ADSStrength then
                                    if v17 then
                                        v15 = v15 * 1.65
                                    end
                                    v15 = v15 * (Config_2.ADSSpreadReduction or 0.75)
                                end
                                if Config_2.Spread then
                                    BaseSpread = Config_2.BaseSpread
                                    if not BaseSpread then
                                        BaseSpread = Config_2.Spread
                                    end
                                    v18 = BaseSpread * GameState.Data.Variables.WeaponSpread * (game.Players.LocalPlayer:GetAttribute("Skill_WeaponSpreadMult") or 1)
                                    u185.ShootingInaccuracy = u185.ShootingInaccuracy + v18 * v15
                                elseif not Config_2.BaseSpread then
                                end
                                u214.GunFired:Fire(u185)
                                u185:Shoot()
                                u185.PrimaryAttackStart = nil
                                u185.Charging = false
                                if not LocalPlayerController.States then
                                    u185.Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1)
                                elseif LocalPlayerController.States.InSwanSong then
                                end
                                if u185.Config.AmmoUpdated then
                                    task.defer(function() -- Line: 1679 -- upvalues: u185 (upval)
                                        u185.Config.AmmoUpdated({Ammo = u185.Ammo, StoredAmmo = u185.StoredAmmo}, u185.Viewmodel.Model, {Ammo = u185.Ammo - (u185.Config.AmmoPerShot or 1), StoredAmmo = u185.StoredAmmo})
                                    end)
                                end
                                if u185.Config.StaminaUsed then
                                    LocalPlayerController:DrainStamina(u185.Config.StaminaUsed, u185.Config.StaminaCooldown)
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
                                v16 = os.clock()
                                if not u185.LastShot then
                                    v18 = v16
                                else
                                    v19 = u185.LastShot + Config
                                    if v16 - v19 >= Config * 0.5 then
                                        v18 = v16
                                    else
                                        v18 = v19
                                    end
                                end
                                v19 = u185
                                if not u185.DoingHeavy then
                                    v20 = 0
                                else
                                    v20 = HeavyDelayPerShot - Config
                                end
                                v19.LastShot = v18 + v20
                                if DualWield:IsActive() and not (u214:IsDualWieldAutoMode()) then
                                    u214:DualWieldAlternate()
                                end
                                if u185.FireMode == "Burst" and not u185.Bursting then
                                    u185.Bursting = true
                                end
                                if u185.Bursting then
                                    if not u185.CurrentShot then
                                        u185.CurrentShot = 1
                                    end
                                    v19 = u185
                                    v19.CurrentShot = v19.CurrentShot + 1
                                    if u185.Config.BurstAmt < u185.CurrentShot then
                                        v19 = (u185.Config.BurstDelay or 0) * v11
                                        u185.CurrentShot = 1
                                        u185.Bursting = false
                                        u185.LastShot = os.clock() + v19
                                        u185.MouseReleased = false
                                    end
                                end
                                if u185.FireMode == "Semi-Auto" then
                                    u185.MouseReleased = false
                                elseif not u185.Config.PrimeAction then
                                end
                                if u185.Config.PrimeAction then
                                    u185.Priming = false
                                    if 0 < u185.Ammo then
                                        u185.Primed = false
                                    elseif not u185.Config.PrimeOnLastShot then
                                    end
                                end
                            elseif not u202 and u185.Charging then
                                local Stamina_7 = LocalPlayerController:GetStamina()
                                if Stamina_7 > 0 then end
                            end
                        end
                    elseif u185.Config.Use then
                        if not u185.Config.IsTwoHandedAbility then
                            WeaponUse:FireServer()
                        else
                            function u185.FireServerDeployEvent() -- Line: 1587 -- upvalues: WeaponUse (upval)
                                WeaponUse:FireServer()
                            end
                        end
                        u185.Config:Use(u185)
                    end
                end
            elseif not u185.Config.IsMelee and not u185.Bursting then
            end
            if not u185.Primed and not u185.Reloading then
                local Pump = u185.Viewmodel.Animations.Pump
                if Pump then
                    Pump.Priority = Enum.AnimationPriority.Action3
                    u185.Viewmodel:PlayAnimation("Pump", 0, 1, Pump.Length / (u185.Config.BoltAnimationTime or Config) * v10)
                end
                u185.Primed = true
                u185.LastShot = os.clock()
            end
            ActiveWeapons_2, ActiveWeapons_3, ActiveWeapons_4 = DualWield:GetActiveWeapons()
            v5 = ActiveWeapons_2
            v14 = ActiveWeapons_3
            v15 = ActiveWeapons_4
            for i10, i11 in v5, v14, v15 do
                i11.SecondaryAttackDown = u214.SecondaryAttackDown
            end
            if u185.LoopSFX_Playing then
                if not u214.PrimaryAttackDown then
                    LoopSFX:Stop(u185)
                elseif v13 and u185.Ammo > 0 and not u185.Reloading and not (QuickSwap:IsActive()) then
                end
            end
        end
        if DualWield:IsActive() then
            local Weapons, Weapons_2
            Weapons, Weapons_2 = DualWield:GetWeapons()
            v9 = nil
            Config = u185
            if Config ~= Weapons then
                Config = u185
                if Config == Weapons_2 and Weapons then
                    v9 = Weapons
                end
            elseif Weapons_2 then
                v9 = Weapons_2
            end
            if v9 then
                Config = v9.Reloading
                if Config then
                    Config = game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1
                    v2 = if SkillTreeData and SkillTreeData.ReloadSpeedMult then Fusion.peek(SkillTreeData.ReloadSpeedMult) else 1
                    v3 = Config * v2
                    if v9.ReloadingTime then
                        v9.ReloadingTime = v9.ReloadingTime - v1
                        if v9.ReloadingTime <= 0 then
                            v9.ReloadingTime = 0
                            if v9.Config.UsesLoadLoop then
                                if v9.LoopStage == 1 then
                                    v9.LoopStage = 2
                                    v9.IncreasedAmmo = true
                                end
                                if v9.LoopStage == 2 then
                                    if v9.StoredAmmo <= 0 then
                                        v9.LoopStage = 3
                                    elseif v9.Config.Ammo > v9.Ammo then
                                    end
                                    if not v9.IncreasedAmmo then
                                        if v9.LoopStage == 2 then
                                            StoredAmmo = v9.Config.AmmoPerLoad or 1
                                            if v9.StoredAmmo < StoredAmmo then
                                                StoredAmmo = v9.StoredAmmo
                                            end
                                            v4 = StoredAmmo + v9.Ammo
                                            if v9.Config.Ammo >= v4 then
                                                v9.Ammo = v9.Ammo + StoredAmmo
                                            else
                                                v9.Ammo = v9.Config.Ammo
                                            end
                                            v9.StoredAmmo = v9.StoredAmmo - StoredAmmo
                                            u214.AmmoChanged:Fire()
                                            v9.ReloadingTime = (v9.Config.InsertTime - v9.Config.IncrAmmoCountTime) * v11 * v3
                                            v9.IncreasedAmmo = true
                                        end
                                    elseif v9.LoopStage == 2 then
                                        local LoadLoop_2 = v9.Viewmodel.Animations.LoadLoop
                                        if LoadLoop_2 then
                                            LoadLoop_2.Priority = Enum.AnimationPriority.Action4
                                            local InsertAnimationTime_2 = v9.Config.InsertAnimationTime
                                            if not InsertAnimationTime_2 then
                                                InsertAnimationTime_2 = v9.Config.InsertTime
                                            end
                                            v9.Viewmodel:PlayAnimation("LoadLoop", 0, 1, LoadLoop_2.Length / InsertAnimationTime_2 * v10 / v3)
                                        end
                                        v9.ReloadingTime = v9.Config.IncrAmmoCountTime * v11 * v3
                                        v9.IncreasedAmmo = false
                                    end
                                end
                                if v9.LoopStage == 3 then
                                    v9.Viewmodel:StopAnimation("LoadLoop")
                                    v9.Viewmodel:StopAnimation("LoadIdle")
                                    v9.Viewmodel:StopAnimation("LoadStart")
                                    v9.Viewmodel:StopAnimation("LoadStartEmpty")
                                    local LoadStop_2 = v9.Viewmodel.Animations.LoadStop
                                    if LoadStop_2 then
                                        local LoadStopAnimationTime_2 = v9.Config.LoadStopAnimationTime
                                        if not LoadStopAnimationTime_2 then
                                            LoadStopAnimationTime_2 = v9.Config.LoadStartTime
                                        end
                                        v9.Viewmodel:PlayAnimation("LoadStop", 0, 1, LoadStop_2.Length / LoadStopAnimationTime_2 * v10 / v3)
                                    end
                                    v9.LoopStage = 4
                                end
                                if not v9.Reloaded and v9.LoopStage == 4 then
                                    v9.Reloading = false
                                    v9.Reloaded = true
                                    v9.CancelReload = false
                                    u214:DualWieldReloadComplete(v9)
                                end
                            elseif not v9.Reloaded then
                                v9.Reloading = false
                                if v9.newAmmo then
                                    v9.Ammo = v9.newAmmo[1]
                                    v9.StoredAmmo = v9.newAmmo[2]
                                    u214.AmmoChanged:Fire()
                                    v9.newAmmo = nil
                                end
                                v9.Reloaded = true
                                v9:ReloadFinished()
                                u214:DualWieldReloadComplete(v9)
                            end
                        end
                    end
                    if v9.Ammo <= 0 and not v9.Reloading and 0 < v9.StoredAmmo then
                        u214:DualWieldAutoReload(v9)
                    end
                end
            end
        end
        return
    elseif not LocalPlayerController.hrp then
        u185:ForceUnequip()
        UnequipWeapon()
        u187 = nil
        u214.EquippedSlot:Fire(nil)
        return
    elseif not LocalPlayerController.hrp.Parent then
        u185:ForceUnequip()
        UnequipWeapon()
        u187 = nil
        u214.EquippedSlot:Fire(nil)
        return
    elseif not LocalPlayerController.humanoid.Humanoid then
        u185:ForceUnequip()
        UnequipWeapon()
        u187 = nil
        u214.EquippedSlot:Fire(nil)
        return
    elseif LocalPlayerController.humanoid.Humanoid.Health <= 0 then
        u185:ForceUnequip()
        UnequipWeapon()
        u187 = nil
        u214.EquippedSlot:Fire(nil)
        return
    end
end
function Lerp(p1, p2, p3) -- Line: 1890
    return p1 * (1 - p3) + p2 * p3
end
function removeWeapons() -- Line: 1894 -- upvalues: u185 (ref), u187 (ref), u214 (val), u195 (val), ViewmodelManager (val), u196 (val), u189 (ref), u194 (ref), u197 (val), u190 (ref), u193 (ref), u186 (ref)
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
    table.insert(u288, p1)
    if #u288 == 1 then
        while true do
            u288[1]()
            table.remove(u288, 1)
            if #u288 == 0 then
                break
            end
        end
    end
end
FrameworkEvents.UpdateAmmo:SetClientListener(function(p1) -- Line: 1933 -- upvalues: addToWeaponEventQueue (val), u195 (val), u214 (val)
    addToWeaponEventQueue(function() -- Line: 1934 -- upvalues: p1 (val), u195 (upval), u214 (upval)
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
FrameworkEvents.SetLoadout:SetClientListener(function(p1) -- Line: 1956 -- upvalues: addToWeaponEventQueue (val), u195 (val), Weapon (val), u214 (val), u196 (val), u189 (ref), u194 (ref), LoopSFX (val), u190 (ref), LocalPlayerController (val), u197 (val), u187 (ref), u193 (ref)
    addToWeaponEventQueue(function() -- Line: 1957 -- upvalues: u195 (upval), p1 (val), Weapon (upval), u214 (upval), u196 (upval), u189 (upval), u194 (upval), LoopSFX (upval), u190 (upval), LocalPlayerController (upval), u197 (upval), u187 (upval), u193 (upval)
        local ammo, ammo_2, v1
        local v2 = u195
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            if j.Config.Reset then
                j.Config:Reset(j)
            end
        end
        v2, v3 = unpack(p1)
        removeWeapons()
        v4 = v2
        local v5 = nil
        local v6 = nil
        for k, n in v4, v5, v6 do
            local u85 = Weapon.new(n.id, n.mods)
            u85.Slot = k
            u85.Viewmodel.ConfigLoaded:Once(function() -- Line: 1971 -- upvalues: u85 (val), u214 (upval)
                local FireMode = u85.Config.FireMode
                if FireMode then
                    FireMode = u85.Config.FireMode[u85.SelFireMode]
                end
                u85.FireMode = FireMode
                u214.FireModeChanged:Fire()
            end)
            u195[k] = u85
            u195[k].Slot = k
            ammo = n.ammo
            if ammo then
                ammo = n.ammo[1] or 0
            end
            u195[k].Ammo = ammo
            ammo_2 = n.ammo
            if ammo_2 then
                ammo_2 = n.ammo[2] or 0
            end
            u195[k].StoredAmmo = ammo_2
            v1 = u195[k]
            v1.HotbarSlot = tonumber(n.hbslot) or 4
            if not (u196[u85.HotbarSlot]) then
                u196[u85.HotbarSlot] = {}
            end
            table.insert(u196[u85.HotbarSlot], u85)
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
        LocalPlayerController:UpdateInventory(u195)
        u214.InventoryChanged:Fire(u195)
        if v3 then
            local v7, v8
            v4 = u196
            v5 = nil
            v6 = nil
            for m, i5 in v4, v5, v6 do
                v7 = i5
                v1 = nil
                v8 = nil
                for i6, i7 in v7, v1, v8 do
                    if i7.Slot == v3 then
                        u197.X = m
                        u197.Y = i6
                    end
                end
            end
            u190 = v3
            u187 = v3
            u193 = tonumber(v3)
            u214.EquippedSlot:Fire(u187)
            SwapWeapon(v3, true)
        end
    end)
end)
local PropertyChangedSignal = LocalPlayerController.States:GetPropertyChangedSignal("IsDead")
PropertyChangedSignal:Connect(function(p1) -- Line: 2031 -- upvalues: u185 (ref), u187 (ref), u214 (val)
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
;(function() -- Line: 101 -- upvalues: LocalPlayerController (val), u195 (val), u185 (ref), Equipped (val), u214 (val), u188 (ref), OffHand (val), QuickSwap (val), DualWield (val)
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
end)()
RunService:BindToRenderStep("WeaponController", v2, WeaponStepped)
u214:SetInputMethod(BindUtil.getInputMethod())
workspace:SetAttribute("DebugMelee", peek(Settings.Graphics.ShowMeleeHitboxes))
function u214.RequestLoadout(p1) -- Line: 2053 -- upvalues: FrameworkEvents (val), addToWeaponEventQueue (val), u195 (val), Weapon (val), u214 (val), u196 (val), u189 (ref), u194 (ref), LoopSFX (val), u190 (ref), LocalPlayerController (val), u197 (val), u187 (ref), u193 (ref)
    FrameworkEvents.RequestLoadout:Call():After(function(p1, p2) -- Line: 2055 -- upvalues: addToWeaponEventQueue (upval), u195 (upval), Weapon (upval), u214 (upval), u196 (upval), u189 (upval), u194 (upval), LoopSFX (upval), u190 (upval), LocalPlayerController (upval), u197 (upval), u187 (upval), u193 (upval)
        if not p1 or not p2 then
            return
        end
        addToWeaponEventQueue(function() -- Line: 2060 -- upvalues: u195 (upval), p2 (val), Weapon (upval), u214 (upval), u196 (upval), u189 (upval), u194 (upval), LoopSFX (upval), u190 (upval), LocalPlayerController (upval), u197 (upval), u187 (upval), u193 (upval)
            local ammo, ammo_2, v1
            local v2 = u195
            local v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                if j.Config.Reset then
                    j.Config:Reset(j)
                end
            end
            v2, v3 = unpack(p2)
            removeWeapons()
            v4 = v2
            local v5 = nil
            local v6 = nil
            for k, n in v4, v5, v6 do
                local u85 = Weapon.new(n.id, n.mods)
                u85.Slot = k
                u85.Viewmodel.ConfigLoaded:Once(function() -- Line: 2073 -- upvalues: u85 (val), u214 (upval)
                    local FireMode = u85.Config.FireMode
                    if FireMode then
                        FireMode = u85.Config.FireMode[u85.SelFireMode]
                    end
                    u85.FireMode = FireMode
                    u214.FireModeChanged:Fire()
                end)
                u195[k] = u85
                u195[k].Slot = k
                ammo = n.ammo
                if ammo then
                    ammo = n.ammo[1] or 0
                end
                u195[k].Ammo = ammo
                ammo_2 = n.ammo
                if ammo_2 then
                    ammo_2 = n.ammo[2] or 0
                end
                u195[k].StoredAmmo = ammo_2
                v1 = u195[k]
                v1.HotbarSlot = tonumber(n.hbslot) or 4
                if not (u196[u85.HotbarSlot]) then
                    u196[u85.HotbarSlot] = {}
                end
                table.insert(u196[u85.HotbarSlot], u85)
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
            LocalPlayerController:UpdateInventory(u195)
            u214.InventoryChanged:Fire(u195)
            if v3 then
                local v7, v8
                v4 = u196
                v5 = nil
                v6 = nil
                for m, i5 in v4, v5, v6 do
                    v7 = i5
                    v1 = nil
                    v8 = nil
                    for i6, i7 in v7, v1, v8 do
                        if i7.Slot == v3 then
                            u197.X = m
                            u197.Y = i6
                        end
                    end
                end
                u190 = v3
                u187 = v3
                u193 = tonumber(v3)
                u214.EquippedSlot:Fire(u187)
                SwapWeapon(v3, true)
            end
        end)
    end)
end
return u214