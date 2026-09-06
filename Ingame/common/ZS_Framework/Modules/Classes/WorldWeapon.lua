local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local common = ReplicatedStorage.common
script.Parent.Parent:WaitForChild("Shared")
local Utils = script.Parent.Parent.Utils
local CurrentCamera = workspace.CurrentCamera
local ItemData = require(common:WaitForChild("ItemData"))
local WorldViewmodel = require(script.Parent:WaitForChild("WorldViewmodel"))
local WepConfig = require(common:WaitForChild("WepConfig"))
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local SoundUtil = require(Utils:WaitForChild("SoundUtil"))
local AttachmentsRoot = require(ReplicatedStorage.common.SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local u75 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local function isInView(p1, p2) -- Line: 33 -- upvalues: CurrentCamera (val)
    local v1
    local v2 = p1 - CurrentCamera.CFrame.Position
    local v3 = CurrentCamera.FieldOfView + 2
    if math.floor((math.deg((v2.Unit:Angle(CurrentCamera.CFrame.LookVector))))) > v3 then
        return false
    end
    if not game.Players.LocalPlayer.Character then
        v1 = v2
    elseif not game.Players.LocalPlayer.Character.PrimaryPart then
        v1 = v2
    else
        v1 = p1 - game.Players.LocalPlayer.Character.PrimaryPart.Position
        if not v1 then
            v1 = v2
        end
    end
    v2 = v1
    if Vector3.new(v2.X, 0, v2.Z).Magnitude <= p2 then
        return true
    end
    return false
end
local u87 = {}
u87.__index = u87
function u87.new(p1, p2, p3, p4) -- Line: 58 -- upvalues: ItemData (val), WepConfig (val), AttachmentsRoot (val), WorldViewmodel (val), Players (val), CollectionService (val), u87 (val)
    local v1 = ItemData:GetItemIdFromName(p1) or p1
    local WeaponConfig = WepConfig:GetWeaponConfig(v1)
    if not WeaponConfig then
        warn("[Weapon] Could not get weapon config of " .. p1)
        return nil
    end
    local v2 = ItemData.List[v1]
    if not v2 then
        v2 = {Name = WeaponConfig.WeaponName or "NO NAME", Rarity = WeaponConfig.Rarity or "Stock"}
    end
    local v3 = {Owner = p4}
    local WeaponId = v1
    if not WeaponId then
        WeaponId = WeaponConfig.WeaponId
    end
    v3.WeaponId = WeaponId
    v3.Config = deepCopy(WeaponConfig)
    v3.WeaponData = v2
    v3.Mods = AttachmentsRoot.new(v3.Config, p3)
    v3.Ammo = 1
    v3.StoredAmmo = 1
    v3.Viewmodel = WorldViewmodel.new(p2, v3)
    if v3.Owner ~= Players.LocalPlayer then
        CollectionService:AddTag(v3.Viewmodel.Model, "WorldWeapon")
    end
    return (setmetatable(v3, u87))
end
function u87.Equip(p1) -- Line: 98
    if not p1.LowPolyMode and p1.Config.CustomEquip then
        task.spawn(function() -- Line: 100 -- upvalues: p1 (val)
            if not p1.Viewmodel.Model then
                while true do
                    task.wait()
                    if p1.IsDestroyed or p1.Viewmodel.Model then
                        break
                    end
                end
            end
            if not p1.IsDestroyed then
                p1.Config.CustomEquip(p1.Ammo, p1.Viewmodel.Model, {Ammo = p1.Ammo, StoredAmmo = p1.StoredAmmo})
            end
        end)
    end
end
function u87.ForceUnequip(p1) end
function u87.Unequip(p1) end
function u87.Reload(p1, p2) -- Line: 120
    if not p2 then
        p1.Ammo = 1
    else
        p1.Ammo = 0
    end
    if p1.Viewmodel.Animations.Inspect then
        p1.Viewmodel.Animations.Inspect:Stop()
    end
    if p1.Viewmodel.Animations.Shoot then
        p1.Viewmodel.Animations.Shoot:Stop()
    end
    if not p1.LowPolyMode and p1.Config.OnWeaponReload then
        p1.Config.OnWeaponReload(p1)
    end
    if not p2 then
        local LoadStopAnimationTime_2
        if not p1.Config.UsesLoadLoop then
            if p1.Config.UsesLoadLoop then
                if not p2 then
                    p1.Viewmodel:PlayAnimation("Reload", 0, 1, p1.Config.ReloadTimeScale or 1)
                    return
                end
                LoadStopAnimationTime_2 = p1.Config.LoadStopAnimationTime
                if not LoadStopAnimationTime_2 then
                    LoadStopAnimationTime_2 = p1.Config.LoadStartTime
                end
                p1.Viewmodel:StopAnimation("LoadLoop")
                p1.Viewmodel:PlayAnimation("LoadStop", 0, 1, p1.Viewmodel.Animations.LoadStop.Length / LoadStopAnimationTime_2)
                return
            end
            p1.Viewmodel:PlayAnimation("Reload", 0, 1, p1.Config.ReloadTimeScale or 1)
            return
        end
        if not p2 then
            local Length = p1.Viewmodel.Animations.LoadStart.Length
            local LoadStopAnimationTime = p1.Config.LoadStopAnimationTime
            if not LoadStopAnimationTime then
                LoadStopAnimationTime = p1.Config.LoadStartTime
            end
            p1.Viewmodel:StopAnimation("Pump")
            p1.Viewmodel:PlayAnimation("LoadStart", 0, 1, Length / LoadStopAnimationTime)
            p1.LoadingLoop = true
            task.delay(Length, function() -- Line: 144 -- upvalues: p1 (val)
                if not p1.LoadingLoop then
                    return
                end
                p1.Viewmodel.Animations.LoadLoop.Looped = true
                local InsertAnimationTime = p1.Config.InsertAnimationTime
                if not InsertAnimationTime then
                    InsertAnimationTime = p1.Config.InsertTime
                end
                p1.Viewmodel:PlayAnimation("LoadLoop", 0, 1, p1.Viewmodel.Animations.LoadLoop.Length / InsertAnimationTime)
            end)
            return
        end
        if not p1.Config.UsesLoadLoop or not p2 then
            p1.Viewmodel:PlayAnimation("Reload", 0, 1, p1.Config.ReloadTimeScale or 1)
            return
        end
        LoadStopAnimationTime_2 = p1.Config.LoadStopAnimationTime
        if not LoadStopAnimationTime_2 then
            LoadStopAnimationTime_2 = p1.Config.LoadStartTime
        end
        p1.Viewmodel:StopAnimation("LoadLoop")
        p1.Viewmodel:PlayAnimation("LoadStop", 0, 1, p1.Viewmodel.Animations.LoadStop.Length / LoadStopAnimationTime_2)
        return
    elseif p1.Viewmodel.Animations.ReloadEmpty then
        p1.Viewmodel:PlayAnimation("ReloadEmpty", 0, 1, p1.Config.EmptyReloadTimeScale or 1)
        return
    end
end
function u87.Charging(p1) -- Line: 163
    if not p1.ChargeAttack then
        p1.ChargeAttack = true
        p1.Viewmodel:PlayAnimation("Charge")
        p1.Viewmodel:PlayAnimation("ChargeIdle")
    end
end
function u87.Blocking(p1) -- Line: 171
    if not p1.Block then
        p1.Block = true
        p1.Viewmodel:StopAnimation("Charge")
        p1.Viewmodel:StopAnimation("ChargeIdle")
        p1.Viewmodel:StopAnimation("HeavySwing")
        p1.Viewmodel:StopAnimation("HeavySwing2")
        p1.Viewmodel:StopAnimation("Swing1")
        p1.Viewmodel:StopAnimation("Swing2")
        p1.Viewmodel:PlayAnimation("Block")
    end
end
function u87:StopBlocking() -- Line: 185
    if self.Block then
        self.Block = false
        self.Viewmodel:StopAnimation("Block")
    end
end
function u87.Melee(p1, p2) -- Line: 192
    p1.ChargeAttack = false
    p1.Viewmodel:StopAnimation("Charge")
    p1.Viewmodel:StopAnimation("ChargeIdle")
    p1.Viewmodel:StopAnimation("HeavySwing")
    p1.Viewmodel:StopAnimation("HeavySwing2")
    p1.Viewmodel:StopAnimation("Swing1")
    p1.Viewmodel:StopAnimation("Swing2")
    p1:StopBlocking()
    if p2 then
        p1.Viewmodel:PlayAnimation("HeavySwing")
        return
    end
    if p1.SwingCombo then
        p1.SwingCombo = p1.SwingCombo + 1
    else
        p1.SwingCombo = 1
    end
    if p1.PreviouslyPlayed then
        p1.Viewmodel:StopAnimation(p1.PreviouslyPlayed)
    end
    if not p1.SwingCombo then
        p1.SwingCombo = 1
        p1.Viewmodel:PlayAnimation("Swing1")
        p1.PreviouslyPlayed = "Swing1"
        return
    end
    if p1.Viewmodel.Animations["Swing" .. p1.SwingCombo] then
        p1.Viewmodel:PlayAnimation("Swing" .. p1.SwingCombo, 0.1, 1, 1)
        p1.PreviouslyPlayed = "Swing" .. p1.SwingCombo
        return
    end
    p1.SwingCombo = 1
    p1.Viewmodel:PlayAnimation("Swing1")
    p1.PreviouslyPlayed = "Swing1"
end
function u87.Shoot(p1, p2) -- Line: 224 -- upvalues: BulletUtil (val), SoundUtil (val), isInView (val), peek (val), u75 (val)
    task.spawn(function() -- Line: 225 -- upvalues: p1 (val), p2 (val), BulletUtil (upval), SoundUtil (upval), isInView (upval), peek (upval), u75 (upval)
        local LayeredSFXs, ShootSingle
        p1.Viewmodel:StopAnimation("ReloadEmpty")
        p1.Viewmodel:StopAnimation("Reload")
        p1.Viewmodel:StopAnimation("Inspect")
        p1.Viewmodel:StopAnimation("LoadLoop")
        p1._IsWorldWeapon = true
        p1.LoadingLoop = false
        if not p1.Config.CustomShootAnimation then
            if p1.Viewmodel.Animations.Shoot then
                p1.Viewmodel:PlayAnimation("Shoot", 0, 1, 1)
            end
            if p1.Viewmodel.Animations.Pump then
                local BoltAnimationTime = p1.Config.BoltAnimationTime
                if not BoltAnimationTime then
                    BoltAnimationTime = p1.Config.DelayPerShot
                end
                p1.Viewmodel:PlayAnimation("Pump", 0, 1, p1.Viewmodel.Animations.Pump.Length / BoltAnimationTime)
            end
        elseif not p1.LowPolyMode then
            p1.Config.CustomShootAnimation(p1)
        end
        local v1 = p2
        if not v1 then
            v1 = {}
        end
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            BulletUtil:BulletTrail(p1.Viewmodel.BarrelAttachment, j, p1.Config.BulletTrailSettings)
        end
        if p1.Config.OnShot then
            p1.Config.OnShot(p1, p2[1])
        end
        p1.RecoilOffset = CFrame.new(0, 0, -(p1.Config.VerticalRecoil or 3) * 0.23)
        if p1.Config.ShootSingle then
            ShootSingle = if p1.Config.HasSuppressor and p1.Config.SuppressorShootSingle then p1.Config.SuppressorShootSingle else p1.Config.ShootSingle
            SoundUtil:PlaySound(ShootSingle, p1.Viewmodel.BarrelAttachment.WorldPosition)
        end
        if p1.Config.LayeredSFXs then
            local v4, v5, v6
            LayeredSFXs = p1.Config.LayeredSFXs
            v2 = nil
            v3 = nil
            for k, n in LayeredSFXs, v2, v3 do
                v4 = tonumber(k)
                if 0 >= v4 then
                    v4 = n
                    v5 = nil
                    v6 = nil
                    for m, i5 in v4, v5, v6 do
                        SoundUtil:PlaySound(i5, p1.Viewmodel.BarrelAttachment.WorldPosition)
                    end
                else
                    v4 = n
                    v5 = nil
                    v6 = nil
                    for i6, i7 in v4, v5, v6 do
                        task.delay(k, function() -- Line: 272 -- upvalues: SoundUtil (upval), i7 (val), p1 (upval)
                            SoundUtil:PlaySound(i7, p1.Viewmodel.BarrelAttachment.WorldPosition)
                        end)
                    end
                end
            end
        end
        if isInView(p1.Viewmodel.BarrelAttachment.WorldPosition, 50) and p1.Viewmodel.MuzzleModule then
            v1 = peek(u75.Graphics.ParticleQuality)
            if 1 < v1 then
                p1.Viewmodel.MuzzleModule:Emit(p1.Viewmodel)
            end
        end
    end)
end
function u87:Destroy() -- Line: 292
    self.Viewmodel:Destroy()
    self.IsDestroyed = true
end
function deepCopy(p1) -- Line: 299
    local v1 = {}
    for k, v in pairs(p1) do
        if type(v) == "table" then
            v = deepCopy(v)
        end
        v1[k] = v
    end
    return v1
end
return u87