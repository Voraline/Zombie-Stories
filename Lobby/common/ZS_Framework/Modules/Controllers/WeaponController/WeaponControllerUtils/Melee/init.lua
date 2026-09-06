local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Utils = script.Parent.Parent.Parent.Parent:WaitForChild("Utils")
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local MeleeCaster = require(script:WaitForChild("MeleeCaster"))
local Signal = require(ReplicatedStorage.common:WaitForChild("Signal"))
require(Utils.Parent.Controllers.CameraController)
local SoundUtil = require(Utils:WaitForChild("SoundUtil"))
local NPCs_Shared = game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local Utils_2 = NPCs_Shared:WaitForChild("Utils")
local ClassMirror = require(Utils_2:WaitForChild("ClassMirror"))
local HitReg = require(ReplicatedStorage.common.HitReg)
local HUDService = require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local u89 = Signal.new()
local MeleeReg = require(game.ReplicatedStorage.common.RedEvents.Framework.FrameworkEvents).MeleeReg
local u95 = {Hit = Signal.new()}
local function correctedDelta(p1, p2) -- Line: 33
    return 1 - math.exp(-(60 * (p2 or 1)) * p1)
end
function u95.Think(p1, p2, p3) -- Line: 37 -- upvalues: MeleeCaster (val), u89 (val), Fusion (val), SkillTreeData (val), SoundUtil (val), HUDService (val)
    local ParryWindow, Swing1, u536, v1, v2
    local v3 = 1 - math.exp(-60 * p2)
    local v4 = math.min(v3, 1)
    local Config = p1.Config
    local MeleeStart = p1.MeleeStart
    if not p1.Meleeing then
        u536, v2 = p1, p3
    elseif not MeleeStart then
        u536, v2 = p1, p3
    else
        local HeavyDelayPerShot, HeavySwingEnd, HeavySwingRPMScaling, HeavySwingStart, v5
        if not p1.DoingHeavy then
            HeavySwingStart = Config.SwingStart
        else
            HeavySwingStart = Config.HeavySwingStart
        end
        if not p1.DoingHeavy then
            HeavySwingEnd = Config.SwingEnd
        else
            HeavySwingEnd = Config.HeavySwingEnd
        end
        if not p1.DoingHeavy then
            HeavyDelayPerShot = Config.DelayPerShot
        else
            HeavyDelayPerShot = Config.HeavyDelayPerShot
        end
        if HeavyDelayPerShot ~= 0 then
            v5 = HeavyDelayPerShot
        else
            v5 = 1
        end
        v1 = v5 / (HeavySwingStart + HeavySwingEnd)
        p1.MeleeRPMRatio = v1
        if not p1.DoingHeavy then
            HeavySwingRPMScaling = not p1.DoingHeavy
            if HeavySwingRPMScaling then
                HeavySwingRPMScaling = Config.SwingRPMScaling
            end
        else
            HeavySwingRPMScaling = Config.HeavySwingRPMScaling
        end
        ParryWindow = nil
        if Config.SwingData then
            Swing1 = Config.SwingData[p1.PreviouslyPlayed or "Swing1"]
            if not Swing1 then
                Swing1 = Config.SwingData.Swing1
            end
            ParryWindow = Swing1
            if ParryWindow then
                HeavySwingStart = ParryWindow.start
            end
        end
        if HeavySwingRPMScaling then
            HeavySwingStart = HeavySwingStart * v1
            HeavySwingEnd = HeavySwingEnd * v1
        end
        if p1.SwingStarted then
            if not p1.SwingStarted then
                u536, v2 = p1, p3
            elseif MeleeStart + HeavySwingEnd > os.clock() then
                u536, v2 = p1, p3
            else
                task.spawn(function() -- Line: 106 -- upvalues: p1 (val)
                    local SlashTrail = p1.SlashTrail
                    if SlashTrail then
                        SlashTrail.Enabled = false
                    end
                end)
                p1.Meleeing = nil
                p1.SwingStarted = nil
                if p1.DoingHeavy then
                    local Config_3 = p1.Config
                    Config_3.Damage = Config_3.Damage / 2
                end
                p1.DoingHeavy = false
                u536, v2 = p1, p3
            end
        elseif MeleeStart + HeavySwingStart > os.clock() then
            u536, v2 = p1, p3
        else
            task.spawn(function() -- Line: 73 -- upvalues: p1 (val)
                local SlashTrail
                if p1.SlashTrail then
                    p1.SlashTrail.Enabled = true
                    return
                end
                local Model = p1.Viewmodel.Model
                if Model and Model:FindFirstChild("KeyParts") then
                    SlashTrail = Model.KeyParts:FindFirstChild("SlashTrail")
                    if SlashTrail then
                        p1.SlashTrail = SlashTrail
                        p1.SlashTrail.Enabled = true
                    end
                end
            end)
            p1.SwingStarted = true
            p1.TimesHitEnemy = {}
            p1.HitModels = {}
            if ParryWindow then
                task.spawn(function() -- Line: 92 -- upvalues: MeleeCaster (upval), ParryWindow (ref), u89 (upval), p1 (val)
                    MeleeCaster:StartCast(ParryWindow, u89, p1)
                end)
            end
            if not p1.DoingHeavy then
                u536, v2 = p1, p3
            else
                local Config_2 = p1.Config
                Config_2.Damage = Config_2.Damage * 2
                u536, v2 = p1, p3
            end
        end
    end
    if MeleeStart and MeleeStart + (Config.SwingComboEnd or 0) <= os.clock() then
        u536.SwingCombo = 0
    end
    if not u536.Viewmodel.Animations then
        return
    else
        if u536.Viewmodel.Animations.Block then
            local ParryOnly = Config.ParryOnly
            local function stopBlocking() -- Line: 130 -- upvalues: u536 (val), Config (val), ParryOnly (val)
                local v1
                if u536.Blocking then
                    if not u536.Parried then
                        u536.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                    end
                    u536.Parried = false
                    if ParryOnly then
                        u536.ParryDebounce = true
                    end
                end
                u536.Blocking = false
                if not u536.Meleeing then
                    v1 = 0.1
                else
                    v1 = 0
                end
                u536.Viewmodel:StopAnimation("Block", v1)
            end
            if u536.Blocking then
                if u536.SecondaryAttackDown then
                    if u536.Meleeing then
                        if not Config.ParryOnly then
                            if u536.Blocking then
                                if not u536.Parried then
                                    u536.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                u536.Parried = false
                                if ParryOnly then
                                    u536.ParryDebounce = true
                                end
                            end
                            u536.Blocking = false
                            if not u536.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            u536.Viewmodel:StopAnimation("Block", v1)
                        elseif Config.ParryOnly and u536.ParryTime and u536.ParryTime and u536.ParryTime >= os.clock() then
                        end
                    elseif not u536.DoCharging then
                        local Stamina = v2:GetStamina()
                        if 0.01 <= Stamina and not u536.Config.CantBloc then
                            local v6
                            if not u536.BlockDebounce then
                                v6 = not u536.BlockDebounce
                            elseif u536.BlockDebounce < os.clock() then
                                v6 = true
                            end
                            if v6 then
                                if not ParryOnly then
                                    if not u536.Blocking then
                                        local Stamina_2 = v2:GetStamina()
                                        if Config.BlockStaminaRequired or 25 <= Stamina_2 then
                                            v2:DrainStamina(Config.BlockStaminaUse or 0)
                                            u536.ParryTime = os.clock() + (Config.ParryWindow or 0) + (Fusion.peek(SkillTreeData.ParryWindowBonus) or 0)
                                            u536.Blocking = true
                                            SoundUtil:PlaySound(u536.Config.StartBlockSFX)
                                        end
                                    elseif not u536.Blocking then
                                        local Stamina_3 = v2:GetStamina()
                                        if Stamina_3 < Config.BlockStaminaRequired or 25 then
                                            HUDService.Elements.StaminaDisplay:FlashRequired(Config.BlockStaminaRequired or 25)
                                        end
                                    end
                                    if u536.Blocking then
                                        v2:DrainStamina(Config.BlockStaminaDrain * v4)
                                        if u536.Config.UseBlockAnimation then
                                            u536.Viewmodel:PlayAnimation("Block", 0.1, 1, 1)
                                        end
                                        u536.Viewmodel:StopAnimation("HeavySwing")
                                        u536.Viewmodel:StopAnimation("HeavySwing2")
                                        u536.Viewmodel:StopAnimation("Swing1")
                                        u536.Viewmodel:StopAnimation("Swing2")
                                        if ParryOnly and u536.ParryTime and u536.ParryTime < os.clock() then
                                            local v7
                                            if u536.Blocking then
                                                if not u536.Parried then
                                                    u536.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                                end
                                                u536.Parried = false
                                                if ParryOnly then
                                                    u536.ParryDebounce = true
                                                end
                                            end
                                            u536.Blocking = false
                                            ParryWindow = u536.Meleeing
                                            if not ParryWindow then
                                                v7 = 0.1
                                            else
                                                v7 = 0
                                            end
                                            u536.Viewmodel:StopAnimation("Block", v7)
                                        end
                                    end
                                elseif u536.ParryDebounce then
                                end
                            end
                        end
                    end
                elseif not v2.BlockPressed then
                end
            elseif not u536.SecondaryAttackDown and not v2.BlockPressed and Config.ParryOnly then
                if not u536.Blocking then
                    if not v2.BlockPressed then
                        u536.ParryDebounce = nil
                    end
                elseif u536.SecondaryAttackDown then
                end
            end
        end
        if not u536.Viewmodel.Animations.Charge then
            return
        elseif u536.Viewmodel.Animations.Charge.IsPlaying then
            if not u536.Charging then
                if not u536.DoCharging then
                    if u536.DoCharging and u536.Charging then
                        local v8 = if Config.OnlyDrainWhileCharging and u536.PrimaryAttackStart + Config.ChargeTime < os.clock() then 0 else Config.HeavyChargeStaminaDrain * v4
                        v2:DrainStamina(v8, 1)
                    end
                    return
                elseif not u536.Charging then
                    u536.DoCharging = false
                    u536.Viewmodel:StopAnimation("ChargeIdle")
                    u536.Viewmodel:StopAnimation("Charge")
                    u536.Viewmodel:StopAnimation("Charge2")
                    return
                end
            elseif not u536.DoCharging then
                local HeavyStaminaRequired, PreviouslyPlayed
                local Stamina_4 = v2:GetStamina()
                if Config.HeavyStaminaRequired > Stamina_4 then
                    if not u536.DoCharging then
                        if Config.HeavyStaminaRequired >= 100 then
                            return
                        end
                        HUDService.Elements.StaminaDisplay:FlashRequired(Config.HeavyStaminaRequired)
                        return
                    end
                    return
                end
                v2:DrainStamina(Config.HeavyStaminaCost, Config.HeavyDelayPerShot)
                u536.DoCharging = true
                u536.Viewmodel:PlayAnimation("Charge")
                if u536.PreviouslyPlayed then
                    PreviouslyPlayed = u536.PreviouslyPlayed
                    u536.Viewmodel:StopAnimation(PreviouslyPlayed)
                    if u536.PreviouslyPlayed == "Swing1" then
                        u536.Viewmodel:PlayAnimation("Charge2")
                    end
                end
                if not u536.Viewmodel.Animations.ChargeIdle then
                    return
                end
                u536.Viewmodel.Animations.ChargeIdle.Looped = true
                u536.Viewmodel.Animations.ChargeIdle.Priority = Enum.AnimationPriority.Action
                u536.Viewmodel:PlayAnimation("ChargeIdle")
                return
            end
        elseif not u536.Charging then
            if not u536.DoCharging then
                return
            elseif u536.Charging then
                return
            end
        elseif u536.PrimaryAttackStart + 0.3 <= os.clock() then
        end
    end
end
function u95.ProcessHit(p1, p2, p3, p4) -- Line: 228 -- upvalues: u95 (val), HitReg (val), ClassMirror (val), BulletUtil (val), MeleeReg (val)
    local Config = p3.Config
    local v1 = {}
    local v2 = {
        startPos = p1,
        raycastResult = p2,
        weapon = p3,
        prevHit = {},
        ignoreList = {},
        toNetwork = v1,
    }
    local v3 = p2.Instance:FindFirstAncestorWhichIsA("Model")
    if not p3.HitModels then
        p3.HitModels = {}
    end
    if not (p3.HitModels[v3]) then
        p3.HitModels[v3] = true
        u95.Hit:Fire(p2, p3.WeaponId)
    end
    local v4 = HitReg:ProcessHit(p2, v2)
    local v5 = if not v4 and v3 then ClassMirror:GetObjFromModel(v3) else nil
    if v4 then
        local HitTable, TimesHitEnemy, v6
        if p3.TimesHitEnemy.HitTable == nil then
            p3.TimesHitEnemy.HitTable = {}
        end
        local v7 = p3.TimesHitEnemy.HitTable[v3]
        if not p3.TimesHitEnemy.EnemiesHit then
            p3.TimesHitEnemy.EnemiesHit = 0
        end
        if p3.TimesHitEnemy.EnemiesHit >= Config.MaxEnemiesPerSwing then
            if not p3.TimesHitEnemy.IgnoreTable then
                p3.TimesHitEnemy.IgnoreTable = {}
            end
            table.insert(p3.TimesHitEnemy.IgnoreTable, v3)
            if p4 then
                if not v7 then
                    v6 = BrickColor.new("Baby blue")
                elseif v7 >= Config.MaxHitsPerEnemy then
                    v6 = BrickColor.new("Baby blue")
                else
                    v6 = BrickColor.new("Cloudy grey")
                end
                p4.BrickColor = v6
                p4.Transparency = 0.75
            end
            return
        else
            if not v7 then
                v6 = true
            elseif not v7 then
                v6 = false
            elseif v7 < Config.MaxHitsPerEnemy then
                v6 = true
            end
            if v6 then
                if p3.TimesHitEnemy.HitTable[v3] ~= nil then
                    HitTable = p3.TimesHitEnemy.HitTable
                    HitTable[v3] = HitTable[v3] + 1
                else
                    if Config.OnHit then
                        Config.OnHit(p3, v3)
                    end
                    TimesHitEnemy = p3.TimesHitEnemy
                    TimesHitEnemy.EnemiesHit = TimesHitEnemy.EnemiesHit + 1
                    p3.TimesHitEnemy.HitTable[v3] = 1
                end
                v6 = v4
                if not v6 then
                    v6 = v5:ClientShot(v2)
                end
                local v8 = nil
                local v9 = nil
                local v10 = nil
                local v11 = nil
                local v12 = nil
                if v6 then
                    if p4 then
                        p4.BrickColor = BrickColor.new("Bright green")
                    end
                    if v6.BloodNPC and v5 then
                        BulletUtil:BloodNPC(unpack(v6.BloodNPC))
                        v8 = true
                    end
                    if v6.HitFlesh then
                        v8 = true
                    end
                    if v6.HitArmor then
                        v9 = true
                    end
                    if v6.HitHeadshot then
                        v11 = true
                    end
                    if v6.Killed then
                        v12 = true
                    end
                    if v6.BrokeArmor then
                        v10 = true
                    end
                end
                HitReg:ProcessNetworkQueue()
                MeleeReg:FireServer({p3.Slot, v1[1], v1[2]})
                if v12 then
                    p3.HitEntity:Fire("Kill")
                elseif v11 then
                    p3.HitEntity:Fire("Headshot")
                elseif v10 then
                    p3.HitEntity:Fire("ArmorBreak", {dontDoSound = true})
                elseif v9 then
                    p3.HitEntity:Fire("HitArmor", {dontDoSound = true})
                elseif v8 then
                    p3.HitEntity:Fire("Flesh")
                end
                p3.lastZombieHit = nil
                return
            end
        end
    elseif not v5 then
        return
    elseif not v5.ClientShot then
        return
    end
end
u89:Connect(u95.ProcessHit)
return u95