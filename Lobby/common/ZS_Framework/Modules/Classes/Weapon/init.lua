local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local SharedResources = ReplicatedStorage.common.SharedResources
local Shared = script.Parent.Parent:WaitForChild("Shared")
local Utils = script.Parent.Parent.Utils
local WeaponUtils = script:WaitForChild("WeaponUtils")
local RedEvents = ReplicatedStorage.common.RedEvents
local ItemData = require(common:WaitForChild("ItemData"))
local Viewmodel = require(script.Parent:WaitForChild("Viewmodel"))
local WepConfig = require(common:WaitForChild("WepConfig"))
local RaycastUtil = require(Utils:WaitForChild("RaycastUtil"))
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local SharedSprings = require(Shared:WaitForChild("SharedSprings"))
local CameraController = require(script.Parent.Parent.Controllers:WaitForChild("CameraController"))
local MeleeUtil = require(WeaponUtils:WaitForChild("MeleeUtil"))
local ClassMirror = require(((game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")):WaitForChild("Utils")):WaitForChild("ClassMirror"))
local u99 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Encoder_Util")
require(common.Settings)
local u105 = require("@game/ReplicatedStorage/common/Signal")
local u108 = require("../Controllers/LocalPlayerController")
local AttachmentsRoot = require(SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local u114 = nil
local CursorRecoilUtil = require(Utils:WaitForChild("CursorRecoilUtil"))
local u123 = require("@game/ReplicatedStorage/common/zap")
local HitReg = require(ReplicatedStorage.common.HitReg)
local FrameworkEvents = require(RedEvents.Framework.FrameworkEvents)
local Reloading = FrameworkEvents.Reloading
local ReloadingFunction = FrameworkEvents.ReloadingFunction
local Shoot = FrameworkEvents.Shoot
require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u145 = nil
pcall(function() -- Line: 52 -- upvalues: u145 (ref), ReplicatedStorage (val)
    u145 = require(ReplicatedStorage.common.skillTree.SkillTreeData)
end)
local u149 = {}
u149.__index = u149
u149.Hit = u105.new()
u149.HitEntity = u105.new()

function u149.new(p1, p2) -- Line: 63
    -- upvalues: ItemData (val), WepConfig (val), CameraController (val), AttachmentsRoot (val), Viewmodel (val)
    -- upvalues: MeleeUtil (val), u105 (val), u149 (val)
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
    local v3 = {}
    local WeaponId = v1
    if not WeaponId then
        WeaponId = WeaponConfig.WeaponId
    end
    v3.WeaponId = WeaponId
    v3.Name = v2.Name
    v3.Rarity = v2.Rarity
    v3.BaseConfig = WeaponConfig
    v3.Config = deepCopy(WeaponConfig)
    v3.RecoilUtil = CameraController:NewRecoil(v3)
    v3.Mods = AttachmentsRoot.new(v3.Config, p2)
    v3.Viewmodel = Viewmodel.new(v3)
    local Viewmodel_2 = v3.Viewmodel
    local Offset = WeaponConfig.Offset
    Viewmodel_2:ApplyOffset("Offset", Offset)
    v3.Primed = true
    local FireMode = v3.Config.FireMode
    if typeof(FireMode) == "string" then
        local Config_2 = v3.Config
        Config_2.FireMode = {v3.Config.FireMode}
    end
    if v3.Config.IsMelee then
        MeleeUtil.NewMelee(v3)
    end
    v3.SelFireMode = 1
    local FireMode_2 = v3.Config.FireMode
    if FireMode_2 then
        FireMode_2 = v3.Config.FireMode[v3.SelFireMode]
    end
    v3.FireMode = FireMode_2
    if v3.Config.AutoLoop then
        v3.AutoLoop = Instance.new("Sound")
        v3.AutoLoop.Looped = true
        v3.AutoLoop.SoundId = "rbxassetid://" .. v3.Config.AutoLoop.SoundId
        v3.AutoLoop.Parent = workspace
        v3.AutoLoopEnd = Instance.new("Sound")
        v3.AutoLoopEnd.SoundId = "rbxassetid://" .. v3.Config.AutoLoopEnd.SoundId
        v3.AutoLoopEnd.Parent = workspace
    end
    v3.Equipped = u105.new()
    v3.Destroyed = u105.new()
    local v4 = u149
    return (setmetatable(v3, v4))
end

function u149.Equip(p1) -- Line: 131 -- upvalues: u108 (val), SharedSprings (val)
    local v1 = 1
    if u108.FocusEnabled then
        v1 = 1.5
    end
    local v2 = p1.QuickSwapBonus or 1
    p1.QuickSwapBonus = nil
    p1.IsEquipped = true
    SharedSprings.EquipSpring.Target = 0
    if not p1.QuickEquip then
        SharedSprings.EquipSpring.Position = 1.5
    else
        p1.QuickEquip = nil
        SharedSprings.EquipSpring.Position = 0.5
    end
    SharedSprings.EquipSpring.Speed = 12 * (p1.Config.DrawSpeed or 1) * v1 * v2
    p1.SwingCombo = nil
    p1.Viewmodel:StopAnimation("HeavySwing")
    p1.Viewmodel:StopAnimation("HeavySwing2")
    p1.Viewmodel:StopAnimation("Swing1")
    p1.Viewmodel:StopAnimation("Swing2")
    p1.Viewmodel:StopAnimation("Inspect")
    if p1.Viewmodel.Animations.Block then
        p1.Viewmodel:StopAnimation("Block")
    end
    p1.Viewmodel:SetEnabled(true)
    p1.Equipped:Fire()
    if p1.Config.CustomEquip then
        task.spawn(function() -- Line: 169 -- upvalues: p1 (val)
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
    if p1.Config.OnEquipped then
        task.spawn(function() -- Line: 180 -- upvalues: p1 (val)
            p1.Config.OnEquipped(p1)
        end)
    end
end

function u149.ForceUnequip(p1) -- Line: 186
    p1.IsEquipped = false
    if p1.Config.OnUnequipped then
        task.spawn(p1.Config.OnUnequipped, p1)
    end
    p1.Viewmodel:SetEnabled(false)
end

function u149.Unequip(p1) -- Line: 194 -- upvalues: u108 (val), SharedSprings (val)
    p1.Bursting = nil
    p1.CurrentShot = 1
    local v1 = 1
    if u108.FocusEnabled then
        v1 = 1.5
    end
    p1.QuickEquip = nil
    p1.IsEquipped = false
    SharedSprings.EquipSpring.Target = 1.5
    SharedSprings.EquipSpring.Speed = 12 * (p1.Config.HolsterSpeed or 1) * v1
    p1.CancelUnequip = nil
    repeat
        task.wait()
    until 1.3 <= SharedSprings.EquipSpring.Position or p1.CancelUnequip
    if p1.Config.IsMelee then
        if p1.Blocking then
            p1.Blocking = nil
            p1.BlockDebounce = p1.BlockCooldown or 0.75
        end
        p1.SwingCombo = 1
        p1.Charging = nil
        p1.MeleeStart = nil
        p1.Meleeing = nil
        p1.SwingStarted = nil
        p1.DoingHeavy = false
        if p1.SlashTrail then
            task.spawn(function() -- Line: 226 -- upvalues: p1 (val)
                p1.SlashTrail.Enabled = false
            end)
        end
    end
    if p1.CancelUnequip then
        p1.IsEquipped = true
        SharedSprings.EquipSpring.Target = 0
        SharedSprings.EquipSpring.Speed = 12 * (p1.Config.DrawSpeed or 1)
        return true
    end
    if p1.Config.OnUnequipped then
        task.spawn(p1.Config.OnUnequipped, p1)
    end
    p1.Viewmodel:SetEnabled(false)
end

function u149.UpdateAmmo(p1) -- Line: 245 -- upvalues: u114 (ref)
    if not u114 then
        u114 = require("../Controllers/HUDController/HUDElements/AmmoDisplay")
    end
    u114:UpdateAmmo(true)
end

function u149.Reload(p1) -- Line: 252
    -- upvalues: u108 (val), u145 (ref), Fusion (val), u123 (val), ReloadingFunction (val)
    local v1
    if p1.Reloading then
        return
    end
    local v2 = 1
    local v3 = 1
    if u108.FocusEnabled then
        v2 = 2
        v3 = 0.5
    end
    if p1.ReloadingTime and 0 < p1.ReloadingTime then
        if p1.Reloaded == nil then
            v1 = 0 < p1.Ammo
            p1.Reloaded = v1
            p1.Viewmodel:StopAnimation("ReloadEmpty")
        end
        if p1.Reloaded then
            if not p1.Aiming then
                if p1.Viewmodel.Animations.Inspect and not p1.Viewmodel.Animations.Inspect.IsPlaying then
                    p1.Viewmodel:PlayAnimation("Inspect", 0, 1, 1)
                    p1.Viewmodel:StopAnimation("HeavySwing")
                    p1.Viewmodel:StopAnimation("HeavySwing2")
                    p1.Viewmodel:StopAnimation("Swing1")
                    p1.Viewmodel:StopAnimation("Swing2")
                end
                if p1.Config.InspectStart then
                    p1.Config.InspectStart(p1.Viewmodel.Model)
                end
            end
        elseif p1.Config.IsMelee and not p1.Meleeing and not p1.Aiming then
            if p1.Viewmodel.Animations.Inspect and not p1.Viewmodel.Animations.Inspect.IsPlaying then
                p1.Viewmodel:PlayAnimation("Inspect", 0, 1, 1)
                p1.Viewmodel:StopAnimation("HeavySwing")
                p1.Viewmodel:StopAnimation("HeavySwing2")
                p1.Viewmodel:StopAnimation("Swing1")
                p1.Viewmodel:StopAnimation("Swing2")
            end
            if p1.Config.InspectStart then
                p1.Config.InspectStart(p1.Viewmodel.Model)
            end
        end
        return
    end
    if not (p1.StoredAmmo <= 0) then
        local Ammo_2 = p1.Ammo
        if not (p1.Config.Ammo <= Ammo_2) and not p1.Config.IsMelee then
            local Length_2, LoadStartAnimationTime, Viewmodel_4, v4, v5, v6
            if p1.Config.ReloadConditional then
                v1, v6 = p1.Config.ReloadConditional(p1)
                if v1 then
                    v6(p1)
                    return
                end
            end
            p1.Viewmodel:StopAnimation("Inspect")
            p1.Viewmodel:StopAnimation("Shoot", 1e-06)
            p1.Viewmodel:StopAnimation("Pump")
            local Ammo = p1.Ammo
            v6 = game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1
            local v7 = 1
            if u145 and u145.ReloadSpeedMult then
                v7 = Fusion.peek(u145.ReloadSpeedMult)
            end
            local v8 = v6 * v7
            if p1.Config.OnWeaponReload then
                p1.Config.OnWeaponReload(p1)
            end
            p1.ServerFinishedReload = false
            if not p1.Reloading then
                local Viewmodel = p1.Viewmodel
                local FirstDrawAnimation = p1.Config.FirstDrawAnimation
                Viewmodel:StopAnimation(FirstDrawAnimation or "")
                local Viewmodel_2 = p1.Viewmodel
                local DrawAnimation = p1.Config.DrawAnimation
                Viewmodel_2:StopAnimation(DrawAnimation or "")
            end
            p1.Reloading = true
            p1.Reloaded = false
            local v9 = not not u108.FocusEnabled
            p1.ReloadFocusActive = v9
            if not p1.Config.UsesLoadLoop then
                v9 = ReloadingFunction
                local v10 = {p1.Slot}
                v9 = v9:Call(v10)
                v9:After(function(p1_2, p2) -- Line: 367 -- upvalues: p1 (val), Ammo (val)
                    local v1 = p2[1]
                    if p1.Config.OnReloadComplete then
                        p1.Config.OnReloadComplete(p1, Ammo)
                    end
                    if v1 then
                        p1.newAmmo = v1
                        p1.ServerFinishedReload = true
                    end
                end)
                local ReloadTimeScale = p1.Config.ReloadTimeScale
                local EmptyReloadTimeScale = p1.Config.EmptyReloadTimeScale
                v10 = p1.Config.ReloadTime * v8
                local EmptyReloadTime = p1.Config.EmptyReloadTime
                if not EmptyReloadTime then
                    EmptyReloadTime = p1.Config.ReloadTime
                end
                local v11 = EmptyReloadTime * v8
                local ReloadTimeUntilMagInserted = p1.Config.ReloadTimeUntilMagInserted
                local EmptyReloadTimeUntilBoltPulled = p1.Config.EmptyReloadTimeUntilBoltPulled
                local v12 = 1 / v8
                v9 = (ReloadTimeScale or 1) * v12
                local v13 = (EmptyReloadTimeScale or 1) * v12
                if u108.FocusEnabled then
                    v9 = v9 * 2
                    v13 = v13 * 2
                    v10 = v10 / 2
                    v11 = v11 / 2
                    if ReloadTimeUntilMagInserted ~= nil then
                        ReloadTimeUntilMagInserted = ReloadTimeUntilMagInserted / 2
                    end
                    if EmptyReloadTimeUntilBoltPulled ~= nil then
                        EmptyReloadTimeUntilBoltPulled = EmptyReloadTimeUntilBoltPulled / 2
                    end
                end
                if not (0 < p1.Ammo) then
                    p1.Viewmodel:PlayAnimation("ReloadEmpty", 0, 1, v13)
                    p1.ReloadingTimeStart = v10
                    p1.ReloadingTime = v11 or v10
                    local ReloadingTime_3 = p1.ReloadingTime
                    local ReloadingTime_4 = EmptyReloadTimeUntilBoltPulled
                    if not ReloadingTime_4 then
                        ReloadingTime_4 = p1.ReloadingTime
                    end
                    p1.ReloadCancelTime = ReloadingTime_3 - ReloadingTime_4
                else
                    p1.Viewmodel:PlayAnimation("Reload", 0, 1, v9)
                    p1.ReloadingTimeStart = v10
                    p1.ReloadingTime = v10
                    local ReloadingTime = p1.ReloadingTime
                    local ReloadingTime_2 = ReloadTimeUntilMagInserted
                    if not ReloadingTime_2 then
                        ReloadingTime_2 = p1.ReloadingTime
                    end
                    p1.ReloadCancelTime = ReloadingTime - ReloadingTime_2
                end
                p1.MagInUpdate = false
                return
            end
            v9 = u123
            v9.Reloading.Fire({Slot = p1.Slot})
            p1.LoopStage = 1
            p1.ReloadingTime = p1.Config.LoadStartTime * v3 * v8
            local LoadStart = p1.Viewmodel.Animations.LoadStart
            if not p1.Viewmodel.Animations.LoadStartEmpty then
                if LoadStart then
                    Length_2 = LoadStart.Length
                    LoadStartAnimationTime = p1.Config.LoadStartAnimationTime
                    if not LoadStartAnimationTime then
                        LoadStartAnimationTime = p1.Config.LoadStartTime
                    end
                    v4 = Length_2 / LoadStartAnimationTime
                    LoadStart.Priority = Enum.AnimationPriority.Action
                    print("Reload Start SPeed:", v4)
                    Viewmodel_4 = p1.Viewmodel
                    v5 = v4 * v2 / v8
                    Viewmodel_4:PlayAnimation("LoadStart", 0, 1, v5)
                end
            elseif p1.Ammo <= 0 then
                local LoadStartEmpty = p1.Viewmodel.Animations.LoadStartEmpty
                local Length = LoadStartEmpty.Length
                local LoadStartEmptyAnimationTime = p1.Config.LoadStartEmptyAnimationTime
                if not LoadStartEmptyAnimationTime then
                    LoadStartEmptyAnimationTime = p1.Config.LoadStartEmptyTime
                end
                v4 = Length / LoadStartEmptyAnimationTime
                LoadStartEmpty.Priority = Enum.AnimationPriority.Action
                local Viewmodel_3 = p1.Viewmodel
                v5 = v4 * v2 / v8
                Viewmodel_3:PlayAnimation("LoadStartEmpty", 0, 1, v5)
                p1.ReloadingTime = p1.Config.LoadStartEmptyTime * v3 * v8
                p1.Primed = true
                p1.loadingEmpty = true
                local u173 = os.clock()
                p1.emptyLoadTick = u173
                task.delay((p1.Config.LoadStartEmptyInsertTime or LoadStartEmptyAnimationTime) * v3 * v8, function() -- Line: 341 -- upvalues: p1 (val), u173 (val)
                    if p1.Reloading and p1.emptyLoadTick == u173 then
                        local v1 = p1
                        v1.Ammo = v1.Ammo + 1
                        v1 = p1
                        v1.StoredAmmo = v1.StoredAmmo - 1
                        p1:UpdateAmmo()
                    end
                end)
            elseif LoadStart then
                Length_2 = LoadStart.Length
                LoadStartAnimationTime = p1.Config.LoadStartAnimationTime
                if not LoadStartAnimationTime then
                    LoadStartAnimationTime = p1.Config.LoadStartTime
                end
                v4 = Length_2 / LoadStartAnimationTime
                LoadStart.Priority = Enum.AnimationPriority.Action
                print("Reload Start SPeed:", v4)
                Viewmodel_4 = p1.Viewmodel
                v5 = v4 * v2 / v8
                Viewmodel_4:PlayAnimation("LoadStart", 0, 1, v5)
            end
            p1.Viewmodel.Animations.LoadIdle.Priority = Enum.AnimationPriority.Movement
            p1.Viewmodel.Animations.LoadIdle.Looped = true
            p1.Viewmodel:PlayAnimation("LoadIdle", 0, 1, 1)
            return
        end
    end
    if p1.Reloaded == nil then
        v1 = 0 < p1.Ammo
        p1.Reloaded = v1
        p1.Viewmodel:StopAnimation("ReloadEmpty")
    end
    if p1.Reloaded then
        if not p1.Aiming then
            if p1.Viewmodel.Animations.Inspect and not p1.Viewmodel.Animations.Inspect.IsPlaying then
                p1.Viewmodel:PlayAnimation("Inspect", 0, 1, 1)
                p1.Viewmodel:StopAnimation("HeavySwing")
                p1.Viewmodel:StopAnimation("HeavySwing2")
                p1.Viewmodel:StopAnimation("Swing1")
                p1.Viewmodel:StopAnimation("Swing2")
            end
            if p1.Config.InspectStart then
                p1.Config.InspectStart(p1.Viewmodel.Model)
            end
        end
    elseif p1.Config.IsMelee and not p1.Meleeing and not p1.Aiming then
        if p1.Viewmodel.Animations.Inspect and not p1.Viewmodel.Animations.Inspect.IsPlaying then
            p1.Viewmodel:PlayAnimation("Inspect", 0, 1, 1)
            p1.Viewmodel:StopAnimation("HeavySwing")
            p1.Viewmodel:StopAnimation("HeavySwing2")
            p1.Viewmodel:StopAnimation("Swing1")
            p1.Viewmodel:StopAnimation("Swing2")
        end
        if p1.Config.InspectStart then
            p1.Config.InspectStart(p1.Viewmodel.Model)
        end
    end
end

function u149.ReloadFinished(p1) -- Line: 421
    local v1 = p1.Config.Ammo - p1.Ammo
    if p1.newAmmo then
        p1.Ammo = p1.newAmmo[1]
        p1.StoredAmmo = p1.newAmmo[2]
        return
    end
    if v1 <= p1.StoredAmmo then
        p1.Ammo = p1.Ammo + v1
        p1.StoredAmmo = p1.StoredAmmo - v1
        return
    end
    if 0 < p1.StoredAmmo then
        p1.Ammo = p1.Ammo + p1.StoredAmmo
        p1.StoredAmmo = 0
    end
end

function u149:Shoot() -- Line: 440
    -- upvalues: MeleeUtil (val), CursorRecoilUtil (val), CameraController (val), RaycastUtil (val), u149 (val)
    -- upvalues: HitReg (val), ClassMirror (val), u99 (val), BulletUtil (val), Shoot (val)
    local Viewmodel = self.Viewmodel
    local FirstDrawAnimation = self.Config.FirstDrawAnimation
    Viewmodel:StopAnimation(FirstDrawAnimation or "")
    local Viewmodel_2 = self.Viewmodel
    local DrawAnimation = self.Config.DrawAnimation
    Viewmodel_2:StopAnimation(DrawAnimation or "")
    if self.Config.IsMelee then
        self.Viewmodel:StopAnimation("Inspect")
        MeleeUtil.Shoot(self)
        return
    end
    local Ammo = self.Ammo
    local Slot = self.Slot
    task.spawn(function() -- Line: 451
        -- upvalues: self (val), CursorRecoilUtil (upval), CameraController (upval), Slot (val), Ammo (val)
        -- upvalues: RaycastUtil (upval), u149 (upval), HitReg (upval), ClassMirror (upval), u99 (upval)
        -- upvalues: BulletUtil (upval), Shoot (upval)
        local BarrelAttachment, BloodNPC_2, BulletTrailSettings, CFrame_2, CastRay, Config_2, Hit, Instance, Magnitude, Penetration, Position, WeaponId, p, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20
        self.Viewmodel:StopAnimation("ReloadEmpty")
        self.Viewmodel:StopAnimation("Reload")
        self.Viewmodel:StopAnimation("Pump")
        self.Viewmodel:StopAnimation("Inspect")
        self.Viewmodel:StopAnimation("LoadStop")
        self.RecoilUtil:Impulse()
        local v21 = CursorRecoilUtil
        local v22 = self
        v21:OnShoot(v22)
        self.Viewmodel:Shoot()
        if self.Config.CustomShootAnimation then
            self.Config.CustomShootAnimation(self)
        else
            self.Viewmodel:PlayAnimation("Shoot", 0, 1, 1)
        end
        if not self.Config.CameraShake then
            v21 = CameraController
            local CameraShakerAlt_2 = v21.CameraShakerAlt
            v19 = Vector3.new()
            CameraShakerAlt_2:ShakeOnce(4, 15, 0, 0.1, v19, (Vector3.new(1, 1, 1)))
        else
            v21 = CameraController
            local CameraShakerAlt = v21.CameraShakerAlt
            v17 = self
            local CameraShake = v17.Config.CameraShake
            v22 = unpack(CameraShake)
            CameraShakerAlt:ShakeOnce(v22)
        end
        if self.Config.ShellOn then
            self.NeedShell = true
        end
        v21 = nil
        local v23 = nil
        v22 = nil
        v17 = nil
        local v24 = nil
        local v25 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
        v19 = {}
        v19[1] = Slot
        v19[2] = Ammo
        v19[3] = v25
        local v26 = {}
        local v27 = self.Config.BulletsPerShot or 1
        for i = 1, v27 do
            v1 = deepCopy(v26)
            v2 = {}
            Penetration = self.Config.Penetration
            v3 = false
            while true do
                CastRay = RaycastUtil.CastRay
                v5 = self
                v6 = false
                if 1 <= #v1 then
                    v6 = v1
                end
                v4 = CastRay(v5, v6, CursorRecoilUtil.crosshairRecoil)
                Position = v4.Position
                v20 = Position
                if not v3 then
                    v3 = true
                    v8 = "b" .. i
                    table.insert(v19, v8)
                    table.insert(v19, Position)
                end
                Instance = v4.Instance
                if Instance then
                    v7 = v25 - Instance.Position
                    Magnitude = v7.Magnitude
                    v8 = string.format("%.2f", Magnitude)
                    v11 = "r" .. v8
                    table.insert(v19, v11)
                    v9 = {
                        startPos = v25,
                        roundedDistance = v8,
                        raycastResult = v4,
                        weapon = self,
                        prevHit = v2,
                        ignoreList = v1,
                        toNetwork = v19,
                    }
                    v10 = nil
                    v11 = u149
                    Hit = v11.Hit
                    v14 = self
                    WeaponId = v14.WeaponId
                    Hit:Fire(v4, WeaponId)
                    v11 = HitReg:ProcessHit(v4, v9)
                    v12 = nil
                    if not v11 then
                        v13 = Instance:FindFirstAncestorWhichIsA("Model")
                        if v13 then
                            v12 = ClassMirror:GetObjFromModel(v13)
                            if v12 and v12.ClientShot then
                                v10 = v12:ClientShot(v9)
                            end
                        end
                    else
                        v10 = v11
                        v13 = Instance:FindFirstAncestorWhichIsA("Model")
                        if not v13 then
                            table.insert(v2, Instance)
                            table.insert(v1, Instance)
                        else
                            table.insert(v2, v13)
                            table.insert(v1, v13)
                        end
                    end
                    if v10 then
                        if v10.BloodNPC and v12 then
                            CFrame_2 = v12.UIDTable[v10.BloodNPC[3]].CFrame
                            v16 = CFrame.new(Position, Position)
                            p = (CFrame_2:ToObjectSpace(v16)).p
                            v10.BloodNPC[4] = (u99.EncodePositioningData(p))
                            v15 = BulletUtil
                            BloodNPC_2 = v10.BloodNPC
                            v18 = unpack(BloodNPC_2)
                            v15:BloodNPC(v18)
                            v21 = true
                        end
                        if v10.HitFlesh then
                            v21 = true
                        end
                        if v10.HitArmor then
                            v23 = true
                        end
                        if v10.HitHeadshot then
                            v17 = true
                        end
                        if v10.Killed then
                            v24 = true
                        end
                        if v10.BrokeArmor then
                            v22 = true
                        end
                    end
                    if self.Config.OnShot then
                        self.Config.OnShot(self, v4.Position, v10)
                    end
                    if v10 then
                        v7 = #v2
                        if not ((self.Config.Penetration or 0) < v7) then
                            continue
                        end
                    else
                        v13 = BulletUtil
                        v15 = self
                        Config_2 = v15.Config
                        v13:MakeImpact(Config_2, v4, nil, true)
                        table.insert(v19, Instance)
                    end
                end
                break
            end
            v4 = BulletUtil
            v6 = self
            BarrelAttachment = v6.Viewmodel.BarrelAttachment
            v8 = self
            BulletTrailSettings = v8.Config.BulletTrailSettings
            v4:BulletTrail(BarrelAttachment, v20, BulletTrailSettings)
        end
        self.lastZombieHit = nil
        Shoot:FireServer(v19)
        HitReg:ProcessNetworkQueue()
        if v24 then
            u149.HitEntity:Fire("Kill")
            return
        end
        if v17 then
            u149.HitEntity:Fire("Headshot")
            return
        end
        if v22 then
            u149.HitEntity:Fire("ArmorBreak", {dontDoSound = true})
            return
        end
        if v23 then
            u149.HitEntity:Fire("HitArmor", {dontDoSound = true})
            return
        end
        if v21 then
            u149.HitEntity:Fire("Flesh")
        end
    end)
end

function u149:Destroy() -- Line: 633
    self.Viewmodel:Destroy()
    self.IsDestroyed = true
    self.Destroyed:Fire()
    self.Equipped:DisconnectAll()
    self.Destroyed:DisconnectAll()
end

function deepCopy(p1) -- Line: 658
    local v1 = {}
    for k, v in pairs(p1) do
        if type(v) == "table" then
            v = deepCopy(v)
        end
        v1[k] = v
    end
    return v1
end

return u149