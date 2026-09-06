local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local Shared = script.Parent.Parent:WaitForChild("Shared")
local Utils = script.Parent.Parent.Utils
local WeaponUtils = script:WaitForChild("WeaponUtils")
local ItemData = require(common:WaitForChild("ItemData"))
local Viewmodel = require(script.Parent:WaitForChild("Viewmodel"))
local WepConfig = require(common:WaitForChild("WepConfig"))
local RaycastUtil = require(Utils:WaitForChild("RaycastUtil"))
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local SharedSprings = require(Shared:WaitForChild("SharedSprings"))
local CameraController = require(script.Parent.Parent.Controllers:WaitForChild("CameraController"))
local MeleeUtil = require(WeaponUtils:WaitForChild("MeleeUtil"))
local NPCs_Shared = game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local Utils_2 = NPCs_Shared:WaitForChild("Utils")
local ClassMirror = require(Utils_2:WaitForChild("ClassMirror"))
local u99 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/Encoder_Util")
require(common.Settings)
local u105 = require("@game/ReplicatedStorage/common/Signal")
local u108 = require("../Controllers/LocalPlayerController")
local AttachmentsRoot = require(ReplicatedStorage.common.SharedResources.Attachments.AttachmentSystem.AttachmentsRoot)
local u114 = nil
local CursorRecoilUtil = require(Utils:WaitForChild("CursorRecoilUtil"))
local u123 = require("@game/ReplicatedStorage/common/zap")
local HitReg = require(ReplicatedStorage.common.HitReg)
local FrameworkEvents = require(ReplicatedStorage.common.RedEvents.Framework.FrameworkEvents)
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
function u149.new(p1, p2) -- Line: 63 -- upvalues: ItemData (val), WepConfig (val), CameraController (val), AttachmentsRoot (val), Viewmodel (val), MeleeUtil (val), u105 (val), u149 (val)
    local FireMode
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
    v3.Viewmodel:ApplyOffset("Offset", WeaponConfig.Offset)
    v3.Primed = true
    if typeof(v3.Config.FireMode) == "string" then
        v3.Config.FireMode = {v3.Config.FireMode}
    end
    if v3.Config.IsMelee then
        MeleeUtil.NewMelee(v3)
    end
    v3.SelFireMode = 1
    FireMode = v3.Config.FireMode
    if FireMode then
        FireMode = v3.Config.FireMode[v3.SelFireMode]
    end
    v3.FireMode = FireMode
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
    return (setmetatable(v3, u149))
end
function u149.Equip(p1) -- Line: 131 -- upvalues: u108 (val), SharedSprings (val)
    local v1 = if u108.FocusEnabled then 1.5 else 1
    p1.QuickSwapBonus = nil
    p1.IsEquipped = true
    SharedSprings.EquipSpring.Target = 0
    if not p1.QuickEquip then
        SharedSprings.EquipSpring.Position = 1.5
    else
        p1.QuickEquip = nil
        SharedSprings.EquipSpring.Position = 0.5
    end
    SharedSprings.EquipSpring.Speed = 12 * (p1.Config.DrawSpeed or 1) * v1 * (p1.QuickSwapBonus or 1)
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
    local v1 = if u108.FocusEnabled then 1.5 else 1
    p1.QuickEquip = nil
    p1.IsEquipped = false
    SharedSprings.EquipSpring.Target = 1.5
    SharedSprings.EquipSpring.Speed = 12 * (p1.Config.HolsterSpeed or 1) * v1
    p1.CancelUnequip = nil
    while true do
        task.wait()
        if 1.3 <= SharedSprings.EquipSpring.Position or p1.CancelUnequip then
            break
        end
    end
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
function u149.Reload(p1) -- Line: 252 -- upvalues: u108 (val), u145 (ref), Fusion (val), u123 (val), ReloadingFunction (val)
    local ReloadingTime
    if p1.Reloading then
        return
    end
    local v1 = 1
    local v2 = 1
    if u108.FocusEnabled then
        v1 = 2
        v2 = 0.5
    end
    if not p1.ReloadingTime then
        local Ammo, v3
        if p1.StoredAmmo <= 0 then
            if p1.Reloaded == nil then
                v3 = 0 < p1.Ammo
                p1.Reloaded = v3
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
            elseif p1.Config.IsMelee and p1.Meleeing then
            end
            return
        elseif p1.Config.Ammo > p1.Ammo and not p1.Config.IsMelee then
            if not p1.Config.ReloadConditional then
                p1.Viewmodel:StopAnimation("Inspect")
                p1.Viewmodel:StopAnimation("Shoot", 1e-06)
                p1.Viewmodel:StopAnimation("Pump")
                Ammo = p1.Ammo
                local v4 = if u145 and u145.ReloadSpeedMult then Fusion.peek(u145.ReloadSpeedMult) else 1
                local v5 = (game.Players.LocalPlayer:GetAttribute("Skill_ReloadSpeedMult") or 1) * v4
                if p1.Config.OnWeaponReload then
                    p1.Config.OnWeaponReload(p1)
                end
                p1.ServerFinishedReload = false
                if not p1.Reloading then
                    p1.Viewmodel:StopAnimation(p1.Config.FirstDrawAnimation or "")
                    p1.Viewmodel:StopAnimation(p1.Config.DrawAnimation or "")
                end
                p1.Reloading = true
                p1.Reloaded = false
                local v6 = not (not u108.FocusEnabled)
                p1.ReloadFocusActive = v6
                if p1.Config.UsesLoadLoop then
                    local LoadStartEmpty
                    u123.Reloading.Fire({Slot = p1.Slot})
                    p1.LoopStage = 1
                    p1.ReloadingTime = p1.Config.LoadStartTime * v2 * v5
                    local LoadStart = p1.Viewmodel.Animations.LoadStart
                    if not p1.Viewmodel.Animations.LoadStartEmpty then
                        if LoadStart then
                            local LoadStartAnimationTime = p1.Config.LoadStartAnimationTime
                            if not LoadStartAnimationTime then
                                LoadStartAnimationTime = p1.Config.LoadStartTime
                            end
                            local v7 = LoadStart.Length / LoadStartAnimationTime
                            LoadStart.Priority = Enum.AnimationPriority.Action
                            print("Reload Start SPeed:", v7)
                            p1.Viewmodel:PlayAnimation("LoadStart", 0, 1, v7 * v1 / v5)
                        end
                    elseif p1.Ammo <= 0 then
                        LoadStartEmpty = p1.Viewmodel.Animations.LoadStartEmpty
                        local LoadStartEmptyAnimationTime = p1.Config.LoadStartEmptyAnimationTime
                        if not LoadStartEmptyAnimationTime then
                            LoadStartEmptyAnimationTime = p1.Config.LoadStartEmptyTime
                        end
                        LoadStartEmpty.Priority = Enum.AnimationPriority.Action
                        p1.Viewmodel:PlayAnimation("LoadStartEmpty", 0, 1, LoadStartEmpty.Length / LoadStartEmptyAnimationTime * v1 / v5)
                        p1.ReloadingTime = p1.Config.LoadStartEmptyTime * v2 * v5
                        p1.Primed = true
                        p1.loadingEmpty = true
                        local u173 = os.clock()
                        p1.emptyLoadTick = u173
                        task.delay((p1.Config.LoadStartEmptyInsertTime or LoadStartEmptyAnimationTime) * v2 * v5, function() -- Line: 341 -- upvalues: p1 (val), u173 (val)
                            if p1.Reloading and p1.emptyLoadTick == u173 then
                                local v1 = p1
                                v1.Ammo = v1.Ammo + 1
                                v1 = p1
                                v1.StoredAmmo = v1.StoredAmmo - 1
                                p1:UpdateAmmo()
                            end
                        end)
                    end
                    p1.Viewmodel.Animations.LoadIdle.Priority = Enum.AnimationPriority.Movement
                    p1.Viewmodel.Animations.LoadIdle.Looped = true
                    p1.Viewmodel:PlayAnimation("LoadIdle", 0, 1, 1)
                    return
                end
                v6 = ReloadingFunction:Call({p1.Slot})
                v6:After(function(a1, p2) -- Line: 367 -- upvalues: p1 (val), Ammo (val)
                    local v1 = p2[1]
                    if p1.Config.OnReloadComplete then
                        p1.Config.OnReloadComplete(p1, Ammo)
                    end
                    if v1 then
                        p1.newAmmo = v1
                        p1.ServerFinishedReload = true
                    end
                end)
                local v8 = p1.Config.ReloadTime * v5
                local EmptyReloadTime = p1.Config.EmptyReloadTime
                if not EmptyReloadTime then
                    EmptyReloadTime = p1.Config.ReloadTime
                end
                local v9 = EmptyReloadTime * v5
                local ReloadTimeUntilMagInserted = p1.Config.ReloadTimeUntilMagInserted
                local EmptyReloadTimeUntilBoltPulled = p1.Config.EmptyReloadTimeUntilBoltPulled
                local v10 = 1 / v5
                v6 = (p1.Config.ReloadTimeScale or 1) * v10
                local v11 = (p1.Config.EmptyReloadTimeScale or 1) * v10
                if u108.FocusEnabled then
                    v6 = v6 * 2
                    v11 = v11 * 2
                    v8 = v8 / 2
                    v9 = v9 / 2
                    if ReloadTimeUntilMagInserted ~= nil then
                        ReloadTimeUntilMagInserted = ReloadTimeUntilMagInserted / 2
                    end
                    if EmptyReloadTimeUntilBoltPulled ~= nil then
                        EmptyReloadTimeUntilBoltPulled = EmptyReloadTimeUntilBoltPulled / 2
                    end
                end
                if 0 >= p1.Ammo then
                    p1.Viewmodel:PlayAnimation("ReloadEmpty", 0, 1, v11)
                    p1.ReloadingTimeStart = v8
                    p1.ReloadingTime = v9 or v8
                    local ReloadingTime_2 = EmptyReloadTimeUntilBoltPulled
                    if not ReloadingTime_2 then
                        ReloadingTime_2 = p1.ReloadingTime
                    end
                    p1.ReloadCancelTime = p1.ReloadingTime - ReloadingTime_2
                else
                    p1.Viewmodel:PlayAnimation("Reload", 0, 1, v6)
                    p1.ReloadingTimeStart = v8
                    p1.ReloadingTime = v8
                    ReloadingTime = ReloadTimeUntilMagInserted
                    if not ReloadingTime then
                        ReloadingTime = p1.ReloadingTime
                    end
                    p1.ReloadCancelTime = p1.ReloadingTime - ReloadingTime
                end
                p1.MagInUpdate = false
                return
            else
                local v12
                v3, v12 = p1.Config.ReloadConditional(p1)
                if v3 then
                    v12(p1)
                    return
                end
            end
        end
    elseif 0 < p1.ReloadingTime then
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
function u149:Shoot() -- Line: 440 -- upvalues: MeleeUtil (val), CursorRecoilUtil (val), CameraController (val), RaycastUtil (val), u149 (val), HitReg (val), ClassMirror (val), u99 (val), BulletUtil (val), Shoot (val)
    self.Viewmodel:StopAnimation(self.Config.FirstDrawAnimation or "")
    self.Viewmodel:StopAnimation(self.Config.DrawAnimation or "")
    if self.Config.IsMelee then
        self.Viewmodel:StopAnimation("Inspect")
        MeleeUtil.Shoot(self)
        return
    end
    local Ammo = self.Ammo
    local Slot = self.Slot
    task.spawn(function() -- Line: 451 -- upvalues: self (val), CursorRecoilUtil (upval), CameraController (upval), Slot (val), Ammo (val), RaycastUtil (upval), u149 (upval), HitReg (upval), ClassMirror (upval), u99 (upval), BulletUtil (upval), Shoot (upval)
        local Instance, Position, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
        self.Viewmodel:StopAnimation("ReloadEmpty")
        self.Viewmodel:StopAnimation("Reload")
        self.Viewmodel:StopAnimation("Pump")
        self.Viewmodel:StopAnimation("Inspect")
        self.Viewmodel:StopAnimation("LoadStop")
        self.RecoilUtil:Impulse()
        CursorRecoilUtil:OnShoot(self)
        self.Viewmodel:Shoot()
        if self.Config.CustomShootAnimation then
            self.Config.CustomShootAnimation(self)
        else
            self.Viewmodel:PlayAnimation("Shoot", 0, 1, 1)
        end
        if not self.Config.CameraShake then
            CameraController.CameraShakerAlt:ShakeOnce(4, 15, 0, 0.1, Vector3.new(), (Vector3.new(1, 1, 1)))
        else
            CameraController.CameraShakerAlt:ShakeOnce(unpack(self.Config.CameraShake))
        end
        if self.Config.ShellOn then
            self.NeedShell = true
        end
        local v13 = nil
        local v14 = nil
        local v15 = nil
        local v16 = nil
        local v17 = nil
        local v18 = game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)
        local v19 = {Slot, Ammo, v18}
        local v20 = {}
        local v21 = self.Config.BulletsPerShot or 1
        local v22 = 1
        for i = 1, v21, v22 do
            v1 = deepCopy(v20)
            v2 = {}
            v3 = false
            while true do
                v5 = if 1 <= #v1 then v1 else false
                v4 = RaycastUtil.CastRay(self, v5, CursorRecoilUtil.crosshairRecoil)
                Position = v4.Position
                v12 = Position
                if not v3 then
                    v3 = true
                    table.insert(v19, "b" .. i)
                    table.insert(v19, Position)
                end
                Instance = v4.Instance
                if Instance then
                    v6 = string.format("%.2f", (v18 - Instance.Position).Magnitude)
                    table.insert(v19, "r" .. v6)
                    v7 = {
                        startPos = v18,
                        roundedDistance = v6,
                        raycastResult = v4,
                        weapon = self,
                        prevHit = v2,
                        ignoreList = v1,
                        toNetwork = v19,
                    }
                    v8 = nil
                    u149.Hit:Fire(v4, self.WeaponId)
                    v9 = HitReg:ProcessHit(v4, v7)
                    v10 = nil
                    if not v9 then
                        v11 = Instance:FindFirstAncestorWhichIsA("Model")
                        if v11 then
                            v10 = ClassMirror:GetObjFromModel(v11)
                            if v10 and v10.ClientShot then
                                v8 = v10:ClientShot(v7)
                            end
                        end
                    else
                        v8 = v9
                        v11 = Instance:FindFirstAncestorWhichIsA("Model")
                        if not v11 then
                            table.insert(v2, Instance)
                            table.insert(v1, Instance)
                        else
                            table.insert(v2, v11)
                            table.insert(v1, v11)
                        end
                    end
                    if v8 then
                        if v8.BloodNPC and v10 then
                            v8.BloodNPC[4] = u99.EncodePositioningData(v10.UIDTable[v8.BloodNPC[3]].CFrame:ToObjectSpace(CFrame.new(Position, Position)).p)
                            BulletUtil:BloodNPC(unpack(v8.BloodNPC))
                            v13 = true
                        end
                        if v8.HitFlesh then
                            v13 = true
                        end
                        if v8.HitArmor then
                            v14 = true
                        end
                        if v8.HitHeadshot then
                            v16 = true
                        end
                        if v8.Killed then
                            v17 = true
                        end
                        if v8.BrokeArmor then
                            v15 = true
                        end
                    end
                    if self.Config.OnShot then
                        self.Config.OnShot(self, v4.Position, v8)
                    end
                    if not v8 then
                        BulletUtil:MakeImpact(self.Config, v4, nil, true)
                        table.insert(v19, Instance)
                    elseif self.Config.Penetration or 0 >= #v2 then
                        continue
                    end
                end
                break
            end
            BulletUtil:BulletTrail(self.Viewmodel.BarrelAttachment, v12, self.Config.BulletTrailSettings)
        end
        self.lastZombieHit = nil
        Shoot:FireServer(v19)
        HitReg:ProcessNetworkQueue()
        if v17 then
            u149.HitEntity:Fire("Kill")
            return
        end
        if v16 then
            u149.HitEntity:Fire("Headshot")
            return
        end
        if v15 then
            u149.HitEntity:Fire("ArmorBreak", {dontDoSound = true})
            return
        end
        if v14 then
            u149.HitEntity:Fire("HitArmor", {dontDoSound = true})
            return
        end
        if v13 then
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