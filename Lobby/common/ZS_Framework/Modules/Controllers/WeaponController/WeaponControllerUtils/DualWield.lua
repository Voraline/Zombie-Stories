local v1 = {}
local u1 = false
local u2 = nil
local u3 = nil
local u4 = "Right"
local u5 = false
local u6 = false
local u7 = nil
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = nil
local u12 = nil
local u13 = nil
local u14 = nil
local u15 = nil
local u16 = nil
local u17 = nil
local u18 = nil
local function lazyLoad() -- Line: 33 -- upvalues: u14 (ref), u15 (ref), u16 (ref), u17 (ref), u18 (ref)
    if u14 then
        return
    end
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Parent = script.Parent.Parent.Parent
    local Classes = Parent.Parent:WaitForChild("Classes")
    u14 = require(Parent.ViewmodelManager)
    u15 = require(Classes.Viewmodel.ViewmodelUtils.FakeArmUtil)
    u16 = require(Classes.Viewmodel.ViewmodelUtils.ArmModelUtil)
    u17 = require(ReplicatedStorage.common:WaitForChild("PlayerHandler"))
    u18 = require(Classes.Weapon)
end
function v1.Init(p1, p2) -- Line: 47 -- upvalues: u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref)
    u7 = p2.LPC
    u8 = p2.Inventory
    u9 = p2.CurrentWeaponGetter
    u10 = p2.CurrentWeaponSetter
    u11 = p2.WeaponEquippedSignal
    u12 = p2.AmmoChangedSignal
    u13 = p2.QuickSwapModule
end
function v1.IsActive(p1) -- Line: 57 -- upvalues: u1 (ref)
    return u1
end
function v1.GetWeapons(p1) -- Line: 61 -- upvalues: u1 (ref), u3 (ref), u2 (ref)
    if not u1 then
        return nil, nil
    end
    return u3, u2
end
function v1.GetRightWeapon(p1) -- Line: 68 -- upvalues: u3 (ref)
    return u3
end
function v1.GetLeftWeapon(p1) -- Line: 72 -- upvalues: u2 (ref)
    return u2
end
function v1.IsRightReloading(p1) -- Line: 76 -- upvalues: u5 (ref)
    return u5
end
function v1.IsLeftReloading(p1) -- Line: 80 -- upvalues: u6 (ref)
    return u6
end
function v1.GetActiveWeapons(p1) -- Line: 85 -- upvalues: u1 (ref), u3 (ref), u2 (ref), u9 (ref)
    local v1 = {}
    if not u1 then
        if u9() then
            table.insert(v1, u9())
        end
        return v1
    end
    if u3 then
        table.insert(v1, u3)
    end
    if not u2 then
        return v1
    end
    table.insert(v1, u2)
    return v1
end
function v1.Start(p1, p2) -- Line: 97 -- upvalues: u1 (ref), lazyLoad (val), u8 (ref), u13 (ref), u9 (ref), u14 (ref), u18 (ref), u4 (ref), u5 (ref), u6 (ref), u3 (ref), u2 (ref), u10 (ref), u7 (ref), u11 (ref), u12 (ref), u17 (ref)
    if u1 then
        return false
    end
    lazyLoad()
    local v1 = u8[p2]
    if not v1 or not v1.Config.CanDualWield or v1.Config.IsMelee then
        return false
    end
    if u13 and u13:IsActive() then
        u13:Cancel()
    end
    local v2 = u9()
    if v2 and v2 ~= v1 then
        u14:Unequip(v2)
        v2:ForceUnequip()
    end
    local Mods = v1.Mods
    if Mods then
        Mods = v1.Mods:Serialize()
    end
    local v3 = u18.new(v1.WeaponId, Mods)
    if not v3 then
        warn("[DualWield] Failed to create left weapon for dual wield")
        return false
    end
    v3.Slot = v1.Slot
    v3.Ammo = v1.Ammo
    v3.StoredAmmo = v1.StoredAmmo
    u1 = true
    u4 = "Right"
    u5 = v1.Reloading or false
    u6 = false
    u3 = v1
    u2 = v3
    u3.IsDualWieldRight = true
    if u3.Viewmodel then
        u3.Viewmodel.ForceOneHanded = true
        u3.Viewmodel.RightArmOnly = true
        u3.Viewmodel.UseArmModels = true
        u3.Viewmodel.IsDualWieldRight = true
    end
    u3:Equip()
    u14:Equip(u3, "Right", 10)
    u2.IsDualWieldLeft = true
    if u2.Viewmodel then
        u2.Viewmodel.ForceOneHanded = true
        u2.Viewmodel.LeftArmOnly = true
        u2.Viewmodel.IsMirrored = true
        u2.Viewmodel.UseArmModels = true
    end
    u2:Equip()
    u14:Equip(u2, "Left", 10)
    u3.MouseReleased = true
    u2.MouseReleased = true
    u3.ShootingInaccuracy = u3.ShootingInaccuracy or 0
    u2.ShootingInaccuracy = u2.ShootingInaccuracy or 0
    u3.Inaccuracy = u3.Inaccuracy or 0
    u2.Inaccuracy = u2.Inaccuracy or 0
    u10(u3)
    u7.CurrentWeapon = u3
    u7:UpdateCurrentWeapon()
    u11:Fire(u3)
    u12:Fire(true)
    u7.States.DualWieldActive = true
    local PlayerState = u17:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.SecondaryEquipped = v3.WeaponId or false
        PlayerState.SecondaryWepId = v3.WepId or false
    end
    return true
end
function v1.StartWithWeapons(p1, p2, p3) -- Line: 201 -- upvalues: u1 (ref), lazyLoad (val), u13 (ref), u4 (ref), u5 (ref), u6 (ref), u3 (ref), u2 (ref), u15 (ref), u16 (ref), u14 (ref), u10 (ref), u7 (ref), u11 (ref), u12 (ref), u17 (ref)
    if u1 or not p2 or not p3 or not p2.Config.CanDualWield or not p3.Config.CanDualWield or p2.Config.IsMelee or p3.Config.IsMelee then
        return false
    end
    lazyLoad()
    if u13 and u13:IsActive() then
        u13:Cancel()
    end
    u1 = true
    u4 = "Right"
    u5 = p2.Reloading or false
    u6 = p3.Reloading or false
    u3 = p2
    u2 = p3
    u3.IsDualWieldRight = true
    if u3.Viewmodel then
        u3.Viewmodel.ForceOneHanded = true
        u3.Viewmodel.RightArmOnly = true
        u3.Viewmodel.UseArmModels = true
        u3.Viewmodel.IsDualWieldRight = true
        u15:Hide(u3.Viewmodel.Model)
        u16:AttachArms(u3.Viewmodel.Model, true, false, false)
    end
    u14:SetArmRequest(u3, "Right")
    u2.IsDualWieldLeft = true
    u2.IsDualWieldFromInventory = true
    if u2.Viewmodel then
        u2.Viewmodel.ForceOneHanded = true
        u2.Viewmodel.LeftArmOnly = true
        u2.Viewmodel.IsMirrored = true
        u2.Viewmodel.UseArmModels = true
    end
    u2:Equip()
    u14:Equip(u2, "Left", 10)
    u3.MouseReleased = true
    u2.MouseReleased = true
    u3.ShootingInaccuracy = u3.ShootingInaccuracy or 0
    u2.ShootingInaccuracy = u2.ShootingInaccuracy or 0
    u3.Inaccuracy = u3.Inaccuracy or 0
    u2.Inaccuracy = u2.Inaccuracy or 0
    u10(u3)
    u7.CurrentWeapon = u3
    u7:UpdateCurrentWeapon()
    u11:Fire(u3)
    u12:Fire(true)
    u7.States.DualWieldActive = true
    local PlayerState = u17:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.SecondaryEquipped = p3.WeaponId or false
        PlayerState.SecondaryWepId = p3.WepId or false
    end
    return true
end
function v1.Stop(p1) -- Line: 287 -- upvalues: u1 (ref), lazyLoad (val), u2 (ref), u16 (ref), u14 (ref), u3 (ref), u15 (ref), u10 (ref), u7 (ref), u4 (ref), u5 (ref), u6 (ref), u12 (ref), u17 (ref)
    if not u1 then
        return false
    end
    lazyLoad()
    if u2 then
        if u2.Viewmodel then
            u16:DetachArms(u2.Viewmodel.Model)
            u2.Viewmodel.ForceOneHanded = false
            u2.Viewmodel.LeftArmOnly = false
            u2.Viewmodel.IsMirrored = false
            u2.Viewmodel.UseArmModels = false
        end
        u14:Unequip(u2)
        u2:ForceUnequip()
        u2.IsDualWieldLeft = nil
        u2.IsDualWieldFromInventory = nil
        u2 = nil
    end
    if u3 then
        u3.IsDualWieldRight = nil
        if u3.Viewmodel then
            u3.Viewmodel.ForceOneHanded = false
            u3.Viewmodel.RightArmOnly = false
            u3.Viewmodel.UseArmModels = false
            u3.Viewmodel.IsDualWieldRight = false
            u16:DetachArms(u3.Viewmodel.Model)
        end
        u14:SetArmRequest(u3, "Both")
        u15:Show(u3.Viewmodel.Model)
        u10(u3)
        u7.CurrentWeapon = u3
        u7:UpdateCurrentWeapon()
    end
    u1 = false
    u3 = nil
    u4 = "Right"
    u5 = false
    u6 = false
    u12:Fire(true)
    u7.States.DualWieldActive = false
    local PlayerState = u17:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.SecondaryEquipped = false
        PlayerState.SecondaryWepId = false
    end
    return true
end
function v1.Fire(p1) -- Line: 351 -- upvalues: u1 (ref), u5 (ref), u6 (ref), u3 (ref), u2 (ref), u4 (ref), u10 (ref)
    if not u1 then
        return false
    end
    if not u5 then
        local IsEquipped, v1, v2
        local v3 = u3
        if v3 then
            v3 = u3.FireMode == "Auto"
        end
        local v4 = u2
        if v4 then
            v4 = u2.FireMode == "Auto"
        end
        local v5 = nil
        if v3 and v4 then
            IsEquipped = u3
            if IsEquipped then
                IsEquipped = u3.IsEquipped
                if IsEquipped then
                    IsEquipped = not u5
                end
            end
            local IsEquipped_2 = u2
            if IsEquipped_2 then
                IsEquipped_2 = u2.IsEquipped
                if IsEquipped_2 then
                    IsEquipped_2 = not u6
                end
            end
            if not IsEquipped then
                if IsEquipped then
                    v5 = u3
                elseif IsEquipped_2 then
                    v5 = u2
                end
            elseif IsEquipped_2 then
                local v6
                local v7 = u3.LastShot or 0
                if v7 > u2.LastShot or 0 then
                    v6 = u2
                else
                    v6 = u3
                    if not v6 then
                        v6 = u2
                    end
                end
                v5 = v6
            end
            if not v5 or not v5.IsEquipped then
                return false
            end
            u10(v5)
            return true, v5
        end
        if u4 ~= "Right" then
            v1 = u2
        else
            v1 = u3
        end
        v5 = v1
        if v5 ~= u3 then
            v1 = if v5 == u2 then u6 else false
        else
            v1 = u5
        end
        if not v1 then
            if v5 then
                if not v5.IsEquipped then
                    return false
                end
                u10(v5)
                return true, v5
            end
            return false
        end
        if u4 ~= "Right" then
            v2 = u3
        else
            v2 = u2
        end
        v5 = v2
        if v5 ~= u3 then
            v2 = if v5 == u2 then u6 else false
        else
            v2 = u5
        end
        if v2 or not v5 or not v5.IsEquipped then
            return false
        end
        u10(v5)
        return true, v5
    elseif u6 then
        return false
    end
end
function v1.Alternate(p1) -- Line: 409 -- upvalues: u1 (ref), u4 (ref)
    if not u1 then
        return
    end
    if u4 == "Right" then
        u4 = "Left"
        return
    end
    u4 = "Right"
end
function v1.IsAutoMode(p1) -- Line: 421 -- upvalues: u1 (ref), u3 (ref), u2 (ref)
    if not u1 then
        return false
    end
    local v1 = u3
    if v1 then
        v1 = u3.FireMode == "Auto"
    end
    local v2 = u2
    if v2 then
        v2 = u2.FireMode == "Auto"
    end
    return v1 and v2
end
function v1.FireBoth(p1, p2, p3) -- Line: 431 -- upvalues: u1 (ref), u3 (ref), u5 (ref), u2 (ref), u6 (ref)
    local v1, v2
    if not u1 then
        return false, false
    end
    local v3 = false
    local v4 = false
    if u3 and u3.IsEquipped and not u5 then
        v2 = os.clock() - p2
        if u3.LastShot or 0 <= v2 then
            v1 = true
        else
            v1 = false
        end
        local MouseReleased = v1
        if MouseReleased then
            MouseReleased = u3.MouseReleased
            if MouseReleased then
                MouseReleased = false
                if 0 < u3.Ammo then
                    if not u3.ReloadingTime then
                        MouseReleased = not u3.Busy
                    else
                        MouseReleased = false
                        if u3.ReloadingTime > 0 then end
                    end
                end
            end
        end
        if MouseReleased then
            v3 = true
        end
    end
    if u2 and u2.IsEquipped and not u6 then
        v2 = os.clock() - p3
        if u2.LastShot or 0 <= v2 then
            v1 = true
        else
            v1 = false
        end
        local MouseReleased_2 = v1
        if MouseReleased_2 then
            MouseReleased_2 = u2.MouseReleased
            if MouseReleased_2 then
                MouseReleased_2 = false
                if 0 < u2.Ammo then
                    if not u2.ReloadingTime then
                        MouseReleased_2 = not u2.Busy
                    else
                        MouseReleased_2 = if u2.ReloadingTime <= 0 then not u2.Busy else false
                    end
                end
            end
        end
        if MouseReleased_2 then
            v4 = true
        end
    end
    return v3, v4
end
function v1.Reload(p1, p2) -- Line: 467 -- upvalues: u1 (ref), u3 (ref), u5 (ref), u2 (ref), u6 (ref)
    if not u1 then
        return false
    end
    local v1 = u3
    if v1 then
        v1 = if u3.Ammo < u3.Config.Ammo or 30 then not u5 else false
    end
    local v2 = u2
    if v2 then
        v2 = if u2.Ammo < u2.Config.Ammo or 30 then not u6 else false
    end
    if p2 ~= "Right" then
        if p2 ~= "Left" then
            local v3 = false
            if v1 then
                u5 = true
                u3:Reload()
                v3 = true
            end
            if v2 then
                u6 = true
                u2:Reload()
                v3 = true
            end
            local v4 = v3
            if not v1 then
                local v5
                if not v1 then
                    v5 = u2
                else
                    v5 = u3
                    if not v5 then
                        v5 = u2
                    end
                end
                return v4, v5
            elseif v2 then
                return v4, "Both"
            end
        elseif v2 then
            u6 = true
            u2:Reload()
            return true, u2
        end
    elseif v1 then
        u5 = true
        u3:Reload()
        return true, u3
    end
end
function v1.AutoReload(p1, p2) -- Line: 505 -- upvalues: u1 (ref), u3 (ref), u5 (ref), u2 (ref), u6 (ref)
    if not u1 then
        return false
    end
    if p2 ~= u3 then
        if p2 == u2 then
            if u6 or p2.Ammo > 0 or 0 >= p2.StoredAmmo then
                return false
            end
            u6 = true
            p2:Reload()
            return true
        end
        return false
    end
    if not u5 then
        if p2.Ammo > 0 or 0 >= p2.StoredAmmo then
            return false
        end
        u5 = true
        p2:Reload()
        return true
    end
    if p2 ~= u2 or u6 or p2.Ammo > 0 or 0 >= p2.StoredAmmo then
        return false
    end
    u6 = true
    p2:Reload()
    return true
end
function v1.ReloadComplete(p1, p2) -- Line: 525 -- upvalues: u3 (ref), u5 (ref), u2 (ref), u6 (ref)
    if p2 == u3 then
        u5 = false
        return
    end
    if p2 == u2 then
        u6 = false
        return
    end
    u5 = false
    u6 = false
end
function v1.Cleanup(p1) -- Line: 537 -- upvalues: u1 (ref), lazyLoad (val), u16 (ref), u2 (ref), u3 (ref), u14 (ref), u5 (ref), u6 (ref)
    if not u1 then
        return
    end
    lazyLoad()
    local RunService = game:GetService("RunService")
    local function ForceDisableViewmodel(p1) -- Line: 546 -- upvalues: RunService (val), u16 (upval)
        local Model, Viewmodel
        if not p1 or not p1.Viewmodel then
            return
        end
        Viewmodel = p1.Viewmodel
        pcall(function() -- Line: 549 -- upvalues: RunService (upval), Viewmodel (val)
            RunService:UnbindFromRenderStep(Viewmodel.Name)
        end)
        if Viewmodel.Model then
            Viewmodel.Model.Parent = nil
        end
        if Viewmodel.UseArmModels then
            u16:DetachArms(Viewmodel.Model)
        end
        Viewmodel.Enabled = false
    end
    ForceDisableViewmodel(u2)
    ForceDisableViewmodel(u3)
    if u2 then
        u14:Unequip(u2)
    end
    if u3 then
        u14:Unequip(u3)
    end
    if u2 then
        u2.IsDualWieldLeft = nil
        u2.IsEquipped = false
        if u2.Config.OnUnequipped then
            task.spawn(u2.Config.OnUnequipped, u2)
        end
        if u2.Viewmodel then
            u2.Viewmodel.ForceOneHanded = false
            u2.Viewmodel.LeftArmOnly = false
            u2.Viewmodel.IsMirrored = false
            u2.Viewmodel.UseArmModels = false
        end
    end
    if u3 then
        u3.IsDualWieldRight = nil
        u3.IsEquipped = false
        if u3.Config.OnUnequipped then
            task.spawn(u3.Config.OnUnequipped, u3)
        end
        if u3.Viewmodel then
            u3.Viewmodel.ForceOneHanded = false
            u3.Viewmodel.RightArmOnly = false
            u3.Viewmodel.UseArmModels = false
            u3.Viewmodel.IsDualWieldRight = false
        end
    end
    u1 = false
    u2 = nil
    u3 = nil
    u5 = false
    u6 = false
end
return v1