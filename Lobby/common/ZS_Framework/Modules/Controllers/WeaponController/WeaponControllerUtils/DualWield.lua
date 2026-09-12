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

function v1.Init(p1, p2) -- Line: 47
    -- upvalues: u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref)
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
    local v1
    local v2 = {}
    if not u1 then
        if u9() then
            v1 = u9
            v1 = v1()
            table.insert(v2, v1)
        end
        return v2
    end
    if u3 then
        v1 = u3
        table.insert(v2, v1)
    end
    if not u2 then
        return v2
    end
    v1 = u2
    table.insert(v2, v1)
    return v2
end

function v1.Start(p1, p2) -- Line: 97
    -- upvalues: u1 (ref), lazyLoad (val), u8 (ref), u13 (ref), u9 (ref), u14 (ref), u18 (ref), u4 (ref), u5 (ref)
    -- upvalues: u6 (ref), u3 (ref), u2 (ref), u10 (ref), u7 (ref), u11 (ref), u12 (ref), u17 (ref)
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
    local new = u18.new
    local WeaponId = v1.WeaponId
    local Mods = v1.Mods
    if Mods then
        Mods = v1.Mods:Serialize()
    end
    local v3 = new(WeaponId, Mods)
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
    local v4 = u14
    local v5 = u3
    v4:Equip(v5, "Right", 10)
    u2.IsDualWieldLeft = true
    if u2.Viewmodel then
        u2.Viewmodel.ForceOneHanded = true
        u2.Viewmodel.LeftArmOnly = true
        u2.Viewmodel.IsMirrored = true
        u2.Viewmodel.UseArmModels = true
    end
    u2:Equip()
    v4 = u14
    v5 = u2
    v4:Equip(v5, "Left", 10)
    u3.MouseReleased = true
    u2.MouseReleased = true
    u3.ShootingInaccuracy = u3.ShootingInaccuracy or 0
    u2.ShootingInaccuracy = u2.ShootingInaccuracy or 0
    u3.Inaccuracy = u3.Inaccuracy or 0
    u2.Inaccuracy = u2.Inaccuracy or 0
    u10(u3)
    u7.CurrentWeapon = u3
    u7:UpdateCurrentWeapon()
    v4 = u11
    v5 = u3
    v4:Fire(v5)
    u12:Fire(true)
    u7.States.DualWieldActive = true
    v4 = u17
    local LocalPlayer = game.Players.LocalPlayer
    local PlayerState = v4:GetPlayerState(LocalPlayer)
    if PlayerState then
        PlayerState.SecondaryEquipped = v3.WeaponId or false
        PlayerState.SecondaryWepId = v3.WepId or false
    end
    return true
end

function v1.StartWithWeapons(p1, p2, p3) -- Line: 201
    -- upvalues: u1 (ref), lazyLoad (val), u13 (ref), u4 (ref), u5 (ref), u6 (ref), u3 (ref), u2 (ref), u15 (ref)
    -- upvalues: u16 (ref), u14 (ref), u10 (ref), u7 (ref), u11 (ref), u12 (ref), u17 (ref)
    if u1 then
        return false
    end
    if p2 and p3 then
        if p2.Config.CanDualWield and p3.Config.CanDualWield then
            if not p2.Config.IsMelee and not p3.Config.IsMelee then
                local v1, v2
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
                    v1 = u15
                    v2 = u3
                    local Model = v2.Viewmodel.Model
                    v1:Hide(Model)
                    v1 = u16
                    v2 = u3
                    local Model_2 = v2.Viewmodel.Model
                    v1:AttachArms(Model_2, true, false, false)
                end
                v1 = u14
                v2 = u3
                v1:SetArmRequest(v2, "Right")
                u2.IsDualWieldLeft = true
                u2.IsDualWieldFromInventory = true
                if u2.Viewmodel then
                    u2.Viewmodel.ForceOneHanded = true
                    u2.Viewmodel.LeftArmOnly = true
                    u2.Viewmodel.IsMirrored = true
                    u2.Viewmodel.UseArmModels = true
                end
                u2:Equip()
                v1 = u14
                v2 = u2
                v1:Equip(v2, "Left", 10)
                u3.MouseReleased = true
                u2.MouseReleased = true
                u3.ShootingInaccuracy = u3.ShootingInaccuracy or 0
                u2.ShootingInaccuracy = u2.ShootingInaccuracy or 0
                u3.Inaccuracy = u3.Inaccuracy or 0
                u2.Inaccuracy = u2.Inaccuracy or 0
                u10(u3)
                u7.CurrentWeapon = u3
                u7:UpdateCurrentWeapon()
                v1 = u11
                v2 = u3
                v1:Fire(v2)
                u12:Fire(true)
                u7.States.DualWieldActive = true
                v1 = u17
                local LocalPlayer = game.Players.LocalPlayer
                local PlayerState = v1:GetPlayerState(LocalPlayer)
                if PlayerState then
                    PlayerState.SecondaryEquipped = p3.WeaponId or false
                    PlayerState.SecondaryWepId = p3.WepId or false
                end
                return true
            end
            return false
        end
        return false
    end
    return false
end

function v1.Stop(p1) -- Line: 287
    -- upvalues: u1 (ref), lazyLoad (val), u2 (ref), u16 (ref), u14 (ref), u3 (ref), u15 (ref), u10 (ref), u7 (ref)
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), u12 (ref), u17 (ref)
    local v1, v2
    if not u1 then
        return false
    end
    lazyLoad()
    if u2 then
        if u2.Viewmodel then
            v1 = u16
            v2 = u2
            local Model = v2.Viewmodel.Model
            v1:DetachArms(Model)
            u2.Viewmodel.ForceOneHanded = false
            u2.Viewmodel.LeftArmOnly = false
            u2.Viewmodel.IsMirrored = false
            u2.Viewmodel.UseArmModels = false
        end
        v1 = u14
        v2 = u2
        v1:Unequip(v2)
        u2:ForceUnequip()
        local IsDualWieldFromInventory = u2.IsDualWieldFromInventory
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
            v1 = u16
            v2 = u3
            local Model_2 = v2.Viewmodel.Model
            v1:DetachArms(Model_2)
        end
        v1 = u14
        v2 = u3
        v1:SetArmRequest(v2, "Both")
        v1 = u15
        v2 = u3
        local Model_3 = v2.Viewmodel.Model
        v1:Show(Model_3)
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
    v1 = u17
    local LocalPlayer = game.Players.LocalPlayer
    local PlayerState = v1:GetPlayerState(LocalPlayer)
    if PlayerState then
        PlayerState.SecondaryEquipped = false
        PlayerState.SecondaryWepId = false
    end
    return true
end

function v1.Fire(p1) -- Line: 351 -- upvalues: u1 (ref), u5 (ref), u6 (ref), u3 (ref), u2 (ref), u4 (ref), u10 (ref)
    local v1
    if not u1 then
        return false
    end
    if u5 and u6 then
        return false
    end
    local v2 = u3
    if v2 then
        v2 = u3.FireMode == "Auto"
    end
    local v3 = u2
    if v3 then
        v3 = u2.FireMode == "Auto"
    end
    local v4 = nil
    if v2 and v3 then
        local IsEquipped = u3
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
                v4 = u3
            elseif IsEquipped_2 then
                v4 = u2
            end
        elseif IsEquipped_2 then
            local v5
            if not ((u3.LastShot or 0) <= (u2.LastShot or 0)) then
                v5 = u2
            else
                v5 = u3
                if not v5 then
                    v5 = u2
                end
            end
            v4 = v5
        elseif IsEquipped then
            v4 = u3
        elseif IsEquipped_2 then
            v4 = u2
        end
        if v4 and v4.IsEquipped then
            u10(v4)
            return true, v4
        end
        return false
    end
    if u4 ~= "Right" then
        v1 = u2
    else
        v1 = u3
        if not v1 then
            v1 = u2
        end
    end
    v4 = v1
    if v4 ~= u3 then
        v1 = false
        if v4 == u2 then
            v1 = u6
        end
    else
        v1 = u5
        if not v1 then
            v1 = false
            if v4 == u2 then
                v1 = u6
            end
        end
    end
    if v1 then
        local v6
        if u4 ~= "Right" then
            v6 = u3
        else
            v6 = u2
            if not v6 then
                v6 = u3
            end
        end
        v4 = v6
        if v4 ~= u3 then
            v6 = false
            if v4 == u2 then
                v6 = u6
            end
        else
            v6 = u5
            if not v6 then
                v6 = false
                if v4 == u2 then
                    v6 = u6
                end
            end
        end
        if v6 then
            return false
        end
    end
    if v4 and v4.IsEquipped then
        u10(v4)
        return true, v4
    end
    return false
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
        v1 = (u3.LastShot or 0) <= v2
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
                        if u3.ReloadingTime <= 0 then
                            MouseReleased = not u3.Busy
                        end
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
        v1 = (u2.LastShot or 0) <= v2
        local MouseReleased_2 = v1
        if MouseReleased_2 then
            MouseReleased_2 = u2.MouseReleased
            if MouseReleased_2 then
                MouseReleased_2 = false
                if 0 < u2.Ammo then
                    if not u2.ReloadingTime then
                        MouseReleased_2 = not u2.Busy
                    else
                        MouseReleased_2 = false
                        if u2.ReloadingTime <= 0 then
                            MouseReleased_2 = not u2.Busy
                        end
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
    local v1
    if not u1 then
        return false
    end
    local v2 = u3
    if v2 then
        v2 = false
        if u3.Ammo < (u3.Config.Ammo or 30) then
            v2 = not u5
        end
    end
    local v3 = u2
    if v3 then
        v3 = false
        if u2.Ammo < (u2.Config.Ammo or 30) then
            v3 = not u6
        end
    end
    if p2 == "Right" and v2 then
        u5 = true
        u3:Reload()
        return true, u3
    end
    if p2 == "Left" and v3 then
        u6 = true
        u2:Reload()
        return true, u2
    end
    local v4 = false
    if v2 then
        u5 = true
        u3:Reload()
        v4 = true
    end
    if v3 then
        u6 = true
        u2:Reload()
        v4 = true
    end
    local v5 = v4
    if v2 and v3 then
        return v5, "Both"
    end
    if not v2 then
        v1 = u2
    else
        v1 = u3
        if not v1 then
            v1 = u2
        end
    end
    return v5, v1
end

function v1.AutoReload(p1, p2) -- Line: 505 -- upvalues: u1 (ref), u3 (ref), u5 (ref), u2 (ref), u6 (ref)
    if not u1 then
        return false
    end
    if p2 == u3 and not u5 then
        if p2.Ammo <= 0 and 0 < p2.StoredAmmo then
            u5 = true
            p2:Reload()
            return true
        end
        return false
    end
    if p2 == u2 and not u6 and p2.Ammo <= 0 and 0 < p2.StoredAmmo then
        u6 = true
        p2:Reload()
        return true
    end
    return false
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

function v1.Cleanup(p1) -- Line: 537
    -- upvalues: u1 (ref), lazyLoad (val), u16 (ref), u2 (ref), u3 (ref), u14 (ref), u5 (ref), u6 (ref)
    local v1, v2
    if not u1 then
        return
    end
    lazyLoad()
    local RunService = game:GetService("RunService")

    local function ForceDisableViewmodel(p1) -- Line: 546 -- upvalues: RunService (val), u16 (upval)
        if p1 and p1.Viewmodel then
            local Viewmodel = p1.Viewmodel
            local v1 = pcall
            v1(function() -- Line: 549 -- upvalues: RunService (upval), Viewmodel (val)
                local v1 = RunService
                local v2 = Viewmodel
                local Name = v2.Name
                v1:UnbindFromRenderStep(Name)
            end)
            if Viewmodel.Model then
                Viewmodel.Model.Parent = nil
            end
            if Viewmodel.UseArmModels then
                v1 = u16
                local Model = Viewmodel.Model
                v1:DetachArms(Model)
            end
            Viewmodel.Enabled = false
            return
        end
    end

    ForceDisableViewmodel(u2)
    ForceDisableViewmodel(u3)
    if u2 then
        v1 = u14
        v2 = u2
        v1:Unequip(v2)
    end
    if u3 then
        v1 = u14
        v2 = u3
        v1:Unequip(v2)
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