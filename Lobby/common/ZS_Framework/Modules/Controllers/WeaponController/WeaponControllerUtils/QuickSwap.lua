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
local u15 = nil
local u16 = nil
local u17 = nil
local u18 = nil
local u19 = nil
local u20 = nil
local u21 = nil
local u22 = nil
local u23 = nil
local u24 = nil
local function lazyLoad() -- Line: 42 -- upvalues: u15 (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref)
    if u15 then
        return
    end
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Parent = script.Parent.Parent.Parent
    local Classes = Parent.Parent:WaitForChild("Classes")
    local Shared = Parent.Parent:WaitForChild("Shared")
    local Utils = Parent.Parent:WaitForChild("Utils")
    u15 = require(Shared:WaitForChild("SharedSprings"))
    u16 = require(Classes.Viewmodel.ViewmodelUtils.FakeArmUtil)
    u17 = require(Parent.ViewmodelManager)
    u18 = require(Classes.Viewmodel.ViewmodelUtils.PointRotationUtil)
    u19 = require(Classes.Viewmodel.ViewmodelUtils.RecoilUtil)
    u20 = require(Utils.BobbingUtil)
    u21 = require(ReplicatedStorage.common:WaitForChild("PlayerHandler"))
    u22 = require(script.Parent:WaitForChild("LoopSFX"))
    u23 = require(ReplicatedStorage.Packages.Fusion)
    u24 = require(ReplicatedStorage.common.skillTree.SkillTreeData)
end
function v1.Init(p1, p2) -- Line: 63 -- upvalues: u7 (ref), u8 (ref), u9 (ref), u10 (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref)
    u7 = p2.LPC
    u8 = p2.Inventory
    u9 = p2.CurrentWeaponGetter
    u10 = p2.CurrentWeaponSetter
    u11 = p2.EquippedEvent
    u12 = p2.WeaponEquippedSignal
    u13 = p2.AmmoChangedSignal
    u14 = p2.OffHand
end
function v1.IsActive(p1) -- Line: 74 -- upvalues: u1 (ref)
    return u1
end
function v1.GetPrimaryWeapon(p1) -- Line: 78 -- upvalues: u2 (ref)
    return u2
end
function v1.GetPrimarySlot(p1) -- Line: 82 -- upvalues: u3 (ref)
    return u3
end
function v1.GetSecondaryWeapon(p1) -- Line: 86 -- upvalues: u5 (ref)
    return u5
end
function v1.Start(p1, p2) -- Line: 92 -- upvalues: lazyLoad (val), u24 (ref), u23 (ref), u14 (ref), u9 (ref), u8 (ref), u22 (ref), u6 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u1 (ref), u17 (ref), u10 (ref), u7 (ref), u11 (ref), u12 (ref), u13 (ref), u21 (ref)
    lazyLoad()
    local v1 = if u24 and u24.HasQuickDraw then u23.peek(u24.HasQuickDraw) else false
    if not v1 then
        return false
    end
    if u14 and u14:IsActive() then
        u14:Cancel()
    end
    local v2 = u9()
    if not v2 or not (u8[p2]) then
        return false
    end
    local v3 = u8[p2]
    if v3.Config.IsMelee or v3 == v2 or v2.Config.IsMelee or v2.Config.IsDualWieldedWeapon or v3.Config.IsDualWieldedWeapon or v2.Config.IsTwoHandedAbility then
        return false
    end
    local v4 = u8
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        if j.Config and j.Config.IsTwoHandedAbility and j.Config.IsActivating and j.Config:IsActivating() then
            return false
        end
    end
    if v3.Reloading then
        return false
    end
    if v2.LoopSFX_Playing then
        u22:Stop(v2)
    end
    if not v2.Reloading then
        u6 = nil
    else
        local Animations
        local TimePosition = nil
        v5 = nil
        local Speed = nil
        if v2.Viewmodel and v2.Viewmodel.Animations then
            Animations = v2.Viewmodel.Animations
            if not Animations.Reload then
                if not Animations.ReloadEmpty then
                    if not Animations.LoadStart then
                        if not Animations.LoadStartEmpty then
                            if not Animations.LoadLoop then
                                if Animations.LoadIdle and Animations.LoadIdle.IsPlaying then
                                    TimePosition = Animations.LoadIdle.TimePosition
                                    Speed = Animations.LoadIdle.Speed
                                    v5 = "LoadIdle"
                                end
                            elseif Animations.LoadLoop.IsPlaying then
                                TimePosition = Animations.LoadLoop.TimePosition
                                Speed = Animations.LoadLoop.Speed
                                v5 = "LoadLoop"
                            end
                        elseif Animations.LoadStartEmpty.IsPlaying then
                            TimePosition = Animations.LoadStartEmpty.TimePosition
                            Speed = Animations.LoadStartEmpty.Speed
                            v5 = "LoadStartEmpty"
                        end
                    elseif Animations.LoadStart.IsPlaying then
                        TimePosition = Animations.LoadStart.TimePosition
                        Speed = Animations.LoadStart.Speed
                        v5 = "LoadStart"
                    end
                elseif Animations.ReloadEmpty.IsPlaying then
                    TimePosition = Animations.ReloadEmpty.TimePosition
                    Speed = Animations.ReloadEmpty.Speed
                    v5 = "ReloadEmpty"
                end
            elseif Animations.Reload.IsPlaying then
                TimePosition = Animations.Reload.TimePosition
                Speed = Animations.Reload.Speed
                v5 = "Reload"
            end
        end
        u6 = {
            ReloadingTime = v2.ReloadingTime,
            LoopStage = v2.LoopStage,
            IncreasedAmmo = v2.IncreasedAmmo,
            Reloaded = v2.Reloaded,
            AnimTimePosition = TimePosition,
            AnimName = v5,
            AnimSpeed = Speed,
        }
        if v2.Viewmodel then
            v2.Viewmodel:StopAnimation("Reload", 0)
            v2.Viewmodel:StopAnimation("ReloadEmpty", 0)
            v2.Viewmodel:StopAnimation("LoadStart", 0)
            v2.Viewmodel:StopAnimation("LoadStartEmpty", 0)
            v2.Viewmodel:StopAnimation("LoadLoop", 0)
            v2.Viewmodel:StopAnimation("LoadIdle", 0)
            v2.Viewmodel:StopAnimation("LoadStop", 0)
        end
        v2.ReloadPaused = true
        v2.PausedReloadingTime = v2.ReloadingTime
        v2.PausedLoopStage = v2.LoopStage
        v2.PausedIncreasedAmmo = v2.IncreasedAmmo
        v2.PausedReloaded = v2.Reloaded
        v2.PausedAnimName = v5
        v2.PausedAnimTimePosition = TimePosition
        v2.PausedAnimSpeed = Speed
        v2.ReloadingTime = nil
    end
    u2 = v2
    u3 = nil
    v4 = u8
    v5 = nil
    v6 = nil
    for k, n in v4, v5, v6 do
        if n == v2 then
            u3 = k
            break
        end
    end
    if not u3 then
        return false
    end
    u4 = v2.WeaponId
    u5 = v3
    u1 = true
    if u2.Viewmodel then
        u2.Viewmodel.ForceLoweredPosition = true
    end
    if u5.Viewmodel then
        u5.Viewmodel.RightArmOnly = true
        u5.Viewmodel.ForceOneHanded = true
    end
    v6 = (u5.Config.QuickSwapDrawBonus or 1.5) * u23.peek(u24.SwapSpeedMult) * 3
    u5.QuickDrawActive = true
    u5.QuickSwapBonus = v6
    u5.QuickEquip = true
    u5:Equip()
    u17:Equip(u5, "Right", 20)
    u10(u5)
    u7.CurrentWeapon = u5
    u7:UpdateCurrentWeapon()
    u11:FireServer(p2)
    u12:Fire(u5)
    u13:Fire(true)
    u7.States.QuickSwapActive = true
    local PlayerState = u21:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.QuickSwapActive = true
        PlayerState.SecondaryEquipped = u2.WeaponId or false
        PlayerState.SecondaryWepId = u2.WepId or false
    end
    return true
end
function v1.Complete(p1) -- Line: 307 -- upvalues: u1 (ref), lazyLoad (val), u6 (ref), u2 (ref), u5 (ref), u16 (ref), u17 (ref), u9 (ref), u3 (ref), u4 (ref), u7 (ref), u21 (ref)
    if not u1 then
        return false
    end
    lazyLoad()
    u6 = nil
    if u2 and u2.Viewmodel then
        u2.Viewmodel.ForceLoweredPosition = false
    end
    if u5 and u5.Viewmodel then
        u16:SetArmOwner("Left", u5.Viewmodel.Model)
    end
    if u2 then
        u17:Unequip(u2)
        u2:ForceUnequip()
    end
    if u5 and u9() == u5 then
        u17:SetArmRequest(u5, "Both")
        u17:SetPriority(u5, 10)
        if u5.Viewmodel then
            u5.Viewmodel.ForceOneHanded = false
            u5.Viewmodel.RightArmOnly = false
        end
        u5.QuickDrawActive = nil
    end
    u1 = false
    u2 = nil
    u3 = nil
    u4 = nil
    u5 = nil
    u7.States.QuickSwapActive = false
    local PlayerState = u21:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.QuickSwapActive = false
        PlayerState.SecondaryEquipped = false
        PlayerState.SecondaryWepId = false
    end
    return true
end
function v1.Cancel(p1, p2) -- Line: 369 -- upvalues: u1 (ref), lazyLoad (val), u5 (ref), u17 (ref), u15 (ref), u2 (ref), u16 (ref), u18 (ref), u19 (ref), u20 (ref), u10 (ref), u7 (ref), u6 (ref), u12 (ref), u13 (ref), u3 (ref), u11 (ref), u4 (ref), u21 (ref)
    if not u1 then
        return false
    end
    lazyLoad()
    local v1 = p2
    if v1 == nil and u5 then
        local QuickSwapHolsterSpeed = u5.Config.QuickSwapHolsterSpeed
        local v2 = QuickSwapHolsterSpeed
        if v2 then
            v2 = 0 < QuickSwapHolsterSpeed
        end
        v1 = v2
    end
    if u5 and u5.Viewmodel then
        u5.Viewmodel.ForceOneHanded = false
        u5.Viewmodel.RightArmOnly = false
    end
    if u5 then
        u5.QuickDrawActive = nil
    end
    if u5 then
        u17:Unequip(u5)
        if not v1 then
            u5:ForceUnequip()
        else
            local u41 = u5.Config.QuickSwapHolsterSpeed or 2
            u5.QuickSwapHolster = u41
            task.spawn(function() -- Line: 400 -- upvalues: u5 (upval), u15 (upval), u41 (val)
                local v1 = u5
                if v1 then
                    u15.EquipSpring.Target = 1.5
                    u15.EquipSpring.Speed = 12 * u41
                    task.wait(0.15 / u41)
                    if v1.Viewmodel then
                        v1:ForceUnequip()
                    end
                end
            end)
        end
    end
    if u2 then
        if u2.Viewmodel then
            u2.Viewmodel.ForceLoweredPosition = false
            u16:Show(u2.Viewmodel.Model)
            u18.NewWeapon(u2.Viewmodel)
            u19.CurrentWeapon = u2
            u20.CurrentWeapon = u2
        end
        u10(u2)
        u7.CurrentWeapon = u2
        u7:UpdateCurrentWeapon()
        if u6 and u2.ReloadPaused then
            u2.ReloadPaused = nil
            local PausedReloadingTime = u2.PausedReloadingTime
            if not PausedReloadingTime then
                PausedReloadingTime = u6.ReloadingTime
            end
            u2.PausedReloadingTime = nil
            u2.LoopStage = u6.LoopStage
            u2.IncreasedAmmo = u6.IncreasedAmmo
            u2.Reloaded = u6.Reloaded
            local v3 = not (not u7.FocusEnabled)
            local v4 = 1
            if u2.ReloadFocusActive or false ~= v3 then
                local v5
                if not v3 then
                    v5 = 2
                else
                    v5 = 0.5
                end
                v4 = v5
                u2.ReloadFocusActive = v3
                if u2.ReloadCancelTime then
                    u2.ReloadCancelTime = u2.ReloadCancelTime * v4
                end
            end
            u2.ReloadingTime = PausedReloadingTime * v4
            if u2.Viewmodel and u6.AnimName then
                u2.Viewmodel:PlayAnimation(u6.AnimName, 0, 1, (u6.AnimSpeed or 1) * (1 / v4))
                local v6 = u2.Viewmodel.Animations[u6.AnimName]
                if v6 and u6.AnimTimePosition then
                    v6.TimePosition = u6.AnimTimePosition
                end
            end
            u6 = nil
        end
        u12:Fire(u2)
        u13:Fire(true)
    end
    if u3 then
        u11:FireServer(u3)
    end
    u1 = false
    u2 = nil
    u3 = nil
    u4 = nil
    u5 = nil
    u6 = nil
    u7.States.QuickSwapActive = false
    local PlayerState = u21:GetPlayerState(game.Players.LocalPlayer)
    if PlayerState then
        PlayerState.QuickSwapActive = false
        PlayerState.SecondaryEquipped = false
        PlayerState.SecondaryWepId = false
    end
    return true
end
function v1.Cleanup(p1) -- Line: 496 -- upvalues: u1 (ref), lazyLoad (val), u2 (ref), u17 (ref), u6 (ref), u5 (ref)
    if not u1 then
        return
    end
    lazyLoad()
    if u2 then
        if u2.Viewmodel then
            u2.Viewmodel.ForceLoweredPosition = false
        end
        u17:Unequip(u2)
    end
    u6 = nil
    if u5 then
        if u5.Viewmodel then
            u5.Viewmodel.ForceOneHanded = false
            u5.Viewmodel.RightArmOnly = false
        end
        u5.QuickDrawActive = nil
        u17:Unequip(u5)
    end
    u1 = false
    u2 = nil
    u5 = nil
end
function v1.ResumePausedReload(p1, p2) -- Line: 525 -- upvalues: u7 (ref)
    if not p2 or not p2.ReloadPaused then
        return false
    end
    p2.ReloadPaused = nil
    p2.Reloading = true
    p2.LoopStage = p2.PausedLoopStage
    p2.IncreasedAmmo = p2.PausedIncreasedAmmo
    p2.Reloaded = p2.PausedReloaded
    local v1 = not (not u7.FocusEnabled)
    local v2 = 1
    if p2.ReloadFocusActive or false ~= v1 then
        local v3
        if not v1 then
            v3 = 2
        else
            v3 = 0.5
        end
        v2 = v3
        p2.ReloadFocusActive = v1
        if p2.ReloadCancelTime then
            p2.ReloadCancelTime = p2.ReloadCancelTime * v2
        end
    end
    p2.ReloadingTime = (p2.PausedReloadingTime or 0) * v2
    p2.PausedReloadingTime = nil
    p2.PausedLoopStage = nil
    p2.PausedIncreasedAmmo = nil
    p2.PausedReloaded = nil
    if p2.Viewmodel and p2.PausedAnimName then
        p2.Viewmodel:PlayAnimation(p2.PausedAnimName, 0, 1, (p2.PausedAnimSpeed or 1) * (1 / v2))
        local v4 = p2.Viewmodel.Animations[p2.PausedAnimName]
        if v4 and p2.PausedAnimTimePosition then
            v4.TimePosition = p2.PausedAnimTimePosition
        end
    end
    p2.PausedAnimName = nil
    p2.PausedAnimTimePosition = nil
    p2.PausedAnimSpeed = nil
    return true
end
return v1