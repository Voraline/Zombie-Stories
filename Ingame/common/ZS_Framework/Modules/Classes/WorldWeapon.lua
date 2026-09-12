local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local common = ReplicatedStorage.common
local SharedResources = ReplicatedStorage.common.SharedResources
script.Parent.Parent:WaitForChild("Shared")
local Utils = script.Parent.Parent.Utils
local CurrentCamera = workspace.CurrentCamera
local ItemData = require(common:WaitForChild("ItemData"))
local WorldViewmodel = require(script.Parent:WaitForChild("WorldViewmodel"))
local WepConfig = require(common:WaitForChild("WepConfig"))
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local SoundUtil = require(Utils:WaitForChild("SoundUtil"))
local AttachmentsRoot = require(SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local u75 = require("@game/ReplicatedStorage/common/Settings")
local peek = (require((game:GetService("ReplicatedStorage")).Packages.Fusion)).peek

local function isInView(p1, p2) -- Line: 33 -- upvalues: CurrentCamera (val)
    local v1 = CurrentCamera
    local LookVector = v1.CFrame.LookVector
    local v2 = p1 - CurrentCamera.CFrame.Position
    local v3 = CurrentCamera.FieldOfView + 2
    local v4 = v2.Unit:Angle(LookVector)
    local v5 = math.deg(v4)
    if not (math.floor(v5) <= v3) then
        return false
    end
    if not game.Players.LocalPlayer.Character or not game.Players.LocalPlayer.Character.PrimaryPart then
        v5 = v2
    else
        v5 = p1 - game.Players.LocalPlayer.Character.PrimaryPart.Position
        if not v5 then
            v5 = v2
        end
    end
    v2 = v5
    local X = v2.X
    local Z = v2.Z
    if Vector3.new(X, 0, Z).Magnitude <= p2 then
        return true
    end
    return false
end

local u87 = {}
u87.__index = u87

function u87.new(p1, p2, p3, p4) -- Line: 58
    -- upvalues: ItemData (val), WepConfig (val), AttachmentsRoot (val), WorldViewmodel (val), Players (val)
    -- upvalues: CollectionService (val), u87 (val)
    local v1 = ItemData:GetItemIdFromName(p1) or p1
    local WeaponConfig = WepConfig:GetWeaponConfig(v1)
    if not WeaponConfig then
        warn("[Weapon] Could not get weapon config of " .. p1)
        return nil
    end
    local v2 = ItemData.List[v1]
    if not v2 then
        v2 = {}
        v2.Name = WeaponConfig.WeaponName or "NO NAME"
        v2.Rarity = WeaponConfig.Rarity or "Stock"
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
        local v4 = CollectionService
        local Model = v3.Viewmodel.Model
        v4:AddTag(Model, "WorldWeapon")
    end
    local v5 = u87
    return (setmetatable(v3, v5))
end

function u87.Equip(p1) -- Line: 98
    if not p1.LowPolyMode and p1.Config.CustomEquip then
        task.spawn(function() -- Line: 100 -- upvalues: p1 (val)
            if not p1.Viewmodel.Model then
                repeat
                    task.wait()
                until p1.IsDestroyed or p1.Viewmodel.Model
            end
            if not p1.IsDestroyed then
                local v1 = p1
                local CustomEquip = v1.Config.CustomEquip
                local v2 = p1
                local Ammo = v2.Ammo
                local v3 = p1
                CustomEquip(Ammo, v3.Viewmodel.Model, {Ammo = p1.Ammo, StoredAmmo = p1.StoredAmmo})
            end
        end)
    end
end

function u87.ForceUnequip(p1) end

function u87.Unequip(p1) end

function u87.Reload(p1, p2) -- Line: 120
    local v1
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
    if p2 and p1.Viewmodel.Animations.ReloadEmpty then
        local Viewmodel = p1.Viewmodel
        local EmptyReloadTimeScale = p1.Config.EmptyReloadTimeScale
        Viewmodel:PlayAnimation("ReloadEmpty", 0, 1, EmptyReloadTimeScale or 1)
        return
    end
    if p1.Config.UsesLoadLoop and not p2 then
        local Length = p1.Viewmodel.Animations.LoadStart.Length
        local LoadStopAnimationTime = p1.Config.LoadStopAnimationTime
        if not LoadStopAnimationTime then
            LoadStopAnimationTime = p1.Config.LoadStartTime
        end
        v1 = Length / LoadStopAnimationTime
        p1.Viewmodel:StopAnimation("Pump")
        p1.Viewmodel:PlayAnimation("LoadStart", 0, 1, v1)
        p1.LoadingLoop = true
        task.delay(Length, function() -- Line: 144 -- upvalues: p1 (val)
            if not p1.LoadingLoop then
                return
            end
            p1.Viewmodel.Animations.LoadLoop.Looped = true
            local Length = p1.Viewmodel.Animations.LoadLoop.Length
            local InsertAnimationTime = p1.Config.InsertAnimationTime
            if not InsertAnimationTime then
                InsertAnimationTime = p1.Config.InsertTime
            end
            local v1 = Length / InsertAnimationTime
            p1.Viewmodel:PlayAnimation("LoadLoop", 0, 1, v1)
        end)
        return
    end
    if p1.Config.UsesLoadLoop and p2 then
        local Length_2 = p1.Viewmodel.Animations.LoadStop.Length
        local LoadStopAnimationTime_2 = p1.Config.LoadStopAnimationTime
        if not LoadStopAnimationTime_2 then
            LoadStopAnimationTime_2 = p1.Config.LoadStartTime
        end
        v1 = Length_2 / LoadStopAnimationTime_2
        p1.Viewmodel:StopAnimation("LoadLoop")
        p1.Viewmodel:PlayAnimation("LoadStop", 0, 1, v1)
        return
    end
    local Viewmodel_2 = p1.Viewmodel
    local ReloadTimeScale = p1.Config.ReloadTimeScale
    Viewmodel_2:PlayAnimation("Reload", 0, 1, ReloadTimeScale or 1)
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
        local Viewmodel = p1.Viewmodel
        local PreviouslyPlayed = p1.PreviouslyPlayed
        Viewmodel:StopAnimation(PreviouslyPlayed)
    end
    if p1.SwingCombo and p1.Viewmodel.Animations["Swing" .. p1.SwingCombo] then
        local Viewmodel_2 = p1.Viewmodel
        local v1 = "Swing" .. p1.SwingCombo
        Viewmodel_2:PlayAnimation(v1, 0.1, 1, 1)
        p1.PreviouslyPlayed = "Swing" .. p1.SwingCombo
        return
    end
    p1.SwingCombo = 1
    p1.Viewmodel:PlayAnimation("Swing1")
    p1.PreviouslyPlayed = "Swing1"
end

function u87.Shoot(p1, p2) -- Line: 224
    -- upvalues: BulletUtil (val), SoundUtil (val), isInView (val), peek (val), u75 (val)
    task.spawn(function() -- Line: 225
        -- upvalues: p1 (val), p2 (val), BulletUtil (upval), SoundUtil (upval), isInView (upval), peek (upval)
        -- upvalues: u75 (upval)
        local BarrelAttachment_3, BulletTrailSettings, v1, v2, v3
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
                local Length = p1.Viewmodel.Animations.Pump.Length
                local BoltAnimationTime = p1.Config.BoltAnimationTime
                if not BoltAnimationTime then
                    BoltAnimationTime = p1.Config.DelayPerShot
                end
                v1 = Length / BoltAnimationTime
                p1.Viewmodel:PlayAnimation("Pump", 0, 1, v1)
            end
        elseif not p1.LowPolyMode then
            p1.Config.CustomShootAnimation(p1)
        end
        local v4 = p2
        if not v4 then
            v4 = {}
        end
        local v5 = nil
        v1 = nil
        for i, j in v4, v5, v1 do
            v2 = BulletUtil
            v3 = p1
            BarrelAttachment_3 = v3.Viewmodel.BarrelAttachment
            BulletTrailSettings = p1.Config.BulletTrailSettings
            v2:BulletTrail(BarrelAttachment_3, j, BulletTrailSettings)
        end
        if p1.Config.OnShot then
            p1.Config.OnShot(p1, p2[1])
        end
        p1.RecoilOffset = CFrame.new(0, 0, -(p1.Config.VerticalRecoil or 3) * 0.23)
        if p1.Config.ShootSingle then
            local ShootSingle = p1.Config.ShootSingle
            if p1.Config.HasSuppressor and p1.Config.SuppressorShootSingle then
                ShootSingle = p1.Config.SuppressorShootSingle
            end
            v5 = SoundUtil
            local v6 = p1
            local WorldPosition = v6.Viewmodel.BarrelAttachment.WorldPosition
            v5:PlaySound(ShootSingle, WorldPosition)
        end
        if p1.Config.LayeredSFXs then
            local WorldPosition_2, v7, v8, v9
            local LayeredSFXs = p1.Config.LayeredSFXs
            v5 = nil
            v1 = nil
            for k, n in LayeredSFXs, v5, v1 do
                v2 = tonumber(k)
                if not (0 < v2) then
                    v2 = n
                    v9 = nil
                    v3 = nil
                    for m, i5 in v2, v9, v3 do
                        v7 = SoundUtil
                        v8 = p1
                        WorldPosition_2 = v8.Viewmodel.BarrelAttachment.WorldPosition
                        v7:PlaySound(i5, WorldPosition_2)
                    end
                else
                    v2 = n
                    v9 = nil
                    v3 = nil
                    for i6, i7 in v2, v9, v3 do
                        task.delay(k, function() -- Line: 272 -- upvalues: SoundUtil (upval), i7 (val), p1 (upval)
                            local v1 = SoundUtil
                            local v2 = i7
                            local v3 = p1
                            local WorldPosition = v3.Viewmodel.BarrelAttachment.WorldPosition
                            v1:PlaySound(v2, WorldPosition)
                        end)
                    end
                end
            end
        end
        if isInView(p1.Viewmodel.BarrelAttachment.WorldPosition, 50) and p1.Viewmodel.MuzzleModule then
            v4 = peek(u75.Graphics.ParticleQuality)
            if 1 < v4 then
                v4 = p1
                local MuzzleModule = v4.Viewmodel.MuzzleModule
                v1 = p1
                local Viewmodel_4 = v1.Viewmodel
                MuzzleModule:Emit(Viewmodel_4)
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