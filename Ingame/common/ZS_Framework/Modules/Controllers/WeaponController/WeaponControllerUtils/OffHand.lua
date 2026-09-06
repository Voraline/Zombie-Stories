local v1 = {}
local u1 = false
local u2 = nil
local u3 = nil
local u4 = nil
local u5 = nil
local u6 = nil
local u7 = nil
local u8 = nil
local u9 = nil
local u10 = nil
local u11 = nil
local u12 = nil
local u13 = nil
local u14 = nil
local u17 = require("./OffHandChecks")
local function lazyLoad() -- Line: 32 -- upvalues: u14 (ref), u11 (ref), u12 (ref), u13 (ref)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    if not u14 then
        u14 = require(ReplicatedStorage.common.RedEvents.Framework.FrameworkEvents).OffHandUse
    end
    if u11 then
        return
    end
    local Parent = script.Parent.Parent.Parent
    local Classes = Parent.Parent:WaitForChild("Classes")
    u11 = require(Parent.ViewmodelManager)
    u12 = require(Classes.Viewmodel.ViewmodelUtils.FakeArmUtil)
    u13 = require(ReplicatedStorage.common:WaitForChild("PlayerHandler"))
end
function v1.Init(p1, p2) -- Line: 51 -- upvalues: u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref)
    u4 = p2.Inventory
    u5 = p2.CurrentWeaponGetter
    u6 = p2.AmmoChangedSignal
    u7 = p2.QuickSwapModule
    u8 = p2.DualWieldModule
    u9 = p2.SetSwappingDisabled
    u10 = p2.LPC
end
function v1.IsActive(p1) -- Line: 61 -- upvalues: u1 (ref)
    return u1
end
function v1.GetItem(p1) -- Line: 65 -- upvalues: u2 (ref)
    return u2
end
function v1.GetPrimaryWeapon(p1) -- Line: 69 -- upvalues: u3 (ref)
    return u3
end
function v1.UseItem(p1, p2) -- Line: 74 -- upvalues: u1 (ref), u8 (ref), u4 (ref), u5 (ref), u17 (val), lazyLoad (val), u7 (ref), u3 (ref), u2 (ref), u9 (ref), u11 (ref), u12 (ref), u6 (ref), u10 (ref), u13 (ref), u14 (ref)
    if u1 then
        return false
    end
    if not u8 then
        local v1 = u4[p2]
        local v2 = u5()
        if not (u17.CanUseItem(v1, v2)) or not (u17.CanUseWithCurrentWeapon(v2)) then
            return false
        end
        lazyLoad()
        if u7 and u7:IsActive() then
            u7:Complete()
            v2 = u5()
        end
        u3 = v2
        u2 = v1
        u1 = true
        if u9 then
            u9(true)
        end
        if u3 then
            if u3.Viewmodel then
                u3.Viewmodel.ForceOneHanded = true
                u3.Viewmodel.RightArmOnly = true
            end
            u11:SetArmRequest(u3, "Right")
        end
        u2.IsDualWieldLeft = true
        u2.IsEquipped = true
        if u2.Viewmodel then
            u2.Viewmodel.LeftArmOnly = true
            u2.Viewmodel:SetEnabled(true)
        end
        u11:Equip(u2, "Left", 20)
        if u2.Viewmodel and u2.Viewmodel.Model then
            u12:SetArmOwner("Left", u2.Viewmodel.Model)
        end
        task.delay(0.1, function() -- Line: 152 -- upvalues: u9 (upval), u1 (upval)
            if u9 and u1 then
                u9(false)
            end
        end)
        u6:Fire(true)
        if u10 then
            u10.States.OffHandActive = true
        end
        local PlayerState = u13:GetPlayerState(game.Players.LocalPlayer)
        if PlayerState then
            PlayerState.OffHandActive = true
            local WeaponId = u2.Config.WeaponId
            if not WeaponId then
                WeaponId = u2.Name
                if not WeaponId then
                    WeaponId = false
                end
            end
            PlayerState.OffHandEquipped = WeaponId
            PlayerState.OffHandWepId = u2.WepId or false
        end
        if u2.Config.Use then
            if u14 and u2.WepId then
                u14:FireServer({WepId = u2.WepId})
            end
            task.defer(function() -- Line: 180 -- upvalues: u2 (upval)
                u2.Config.Use(u2.Config, u2)
            end)
        end
        return true
    elseif u8:IsActive() then
        return false
    end
end
function v1.Cancel(p1) -- Line: 189 -- upvalues: u1 (ref), lazyLoad (val), u9 (ref), u2 (ref), u11 (ref), u3 (ref), u12 (ref), u10 (ref), u13 (ref), u6 (ref)
    if not u1 then
        return false
    end
    lazyLoad()
    if u9 then
        u9(false)
    end
    if u2 then
        local v1 = if u2.Config.CancelPreActivation then u2.Config.CancelPreActivation(u2.Config, u2) else false
        u2.IsDualWieldLeft = false
        u2.IsEquipped = false
        if u2.Viewmodel then
            u2.Viewmodel.LeftArmOnly = false
            u2.Viewmodel.ForceOneHanded = false
            u2.Viewmodel:SetEnabled(false)
        end
        u11:Unequip(u2)
        u2 = nil
    end
    if u3 then
        if u3.Viewmodel then
            u3.Viewmodel.ForceOneHanded = false
            u3.Viewmodel.RightArmOnly = false
            u12:SetArmOwner("Left", u3.Viewmodel.Model)
        end
        u11:SetArmRequest(u3, "Both")
    end
    u1 = false
    u3 = nil
    if u10 then
        u10.States.OffHandActive = false
    end
    local PlayerState = u13:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.OffHandActive = false
        PlayerState.OffHandEquipped = false
        PlayerState.OffHandWepId = false
    end
    u6:Fire(true)
    return true
end
function v1:Complete() -- Line: 261
    return self:Cancel()
end
function v1.Cleanup(p1) -- Line: 266 -- upvalues: u1 (ref), lazyLoad (val), u9 (ref), u2 (ref), u11 (ref), u3 (ref), u10 (ref), u13 (ref)
    if not u1 then
        return
    end
    lazyLoad()
    if u9 then
        u9(false)
    end
    if u2 then
        u2.IsDualWieldLeft = false
        u2.IsEquipped = false
        if u2.Viewmodel then
            u2.Viewmodel.LeftArmOnly = false
            u2.Viewmodel.ForceOneHanded = false
            u2.Viewmodel:SetEnabled(false)
        end
        u11:Unequip(u2)
    end
    if u3 and u3.Viewmodel then
        u3.Viewmodel.ForceOneHanded = false
        u3.Viewmodel.RightArmOnly = false
    end
    u1 = false
    u2 = nil
    u3 = nil
    if u10 then
        u10.States.OffHandActive = false
    end
    local PlayerState = u13:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.OffHandActive = false
        PlayerState.OffHandEquipped = false
        PlayerState.OffHandWepId = false
    end
end
return v1