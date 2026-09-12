local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local Utils = script.Parent.Parent.Parent.Parent:WaitForChild("Utils")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local BulletUtil = require(Utils:WaitForChild("BulletUtil"))
local MeleeCaster = require(script:WaitForChild("MeleeCaster"))
local Signal = require(common:WaitForChild("Signal"))
require(Utils.Parent.Controllers.CameraController)
local SoundUtil = require(Utils:WaitForChild("SoundUtil"))
local ClassMirror = require(((game.ReplicatedStorage.common:WaitForChild("NPCs_Shared")):WaitForChild("Utils")):WaitForChild("ClassMirror"))
local HitReg = require(ReplicatedStorage.common.HitReg)
local HUDService = require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local u89 = Signal.new()
local MeleeReg = require(RedEvents.Framework.FrameworkEvents).MeleeReg
local u95 = {}
u95.Hit = Signal.new()

local function correctedDelta(p1, p2) -- Line: 33
    local v1 = -(60 * (p2 or 1)) * p1
    return 1 - math.exp(v1)
end

function u95.Think(p1, p2, p3) -- Line: 37
    -- upvalues: MeleeCaster (val), u89 (val), Fusion (val), SkillTreeData (val), SoundUtil (val), HUDService (val)
    local v1, v2, v3
    local v4 = -60 * p2
    local v5 = 1 - math.exp(v4)
    local v6 = math.min(v5, 1)
    local Config = p1.Config
    local MeleeStart = p1.MeleeStart
    if not p1.Meleeing or not MeleeStart then
        v2 = p3
    else
        local HeavyDelayPerShot, HeavySwingEnd, HeavySwingRPMScaling, HeavySwingStart, v7
        if not p1.DoingHeavy then
            HeavySwingStart = Config.SwingStart
        else
            HeavySwingStart = Config.HeavySwingStart
            if not HeavySwingStart then
                HeavySwingStart = Config.SwingStart
            end
        end
        if not p1.DoingHeavy then
            HeavySwingEnd = Config.SwingEnd
        else
            HeavySwingEnd = Config.HeavySwingEnd
            if not HeavySwingEnd then
                HeavySwingEnd = Config.SwingEnd
            end
        end
        if not p1.DoingHeavy then
            HeavyDelayPerShot = Config.DelayPerShot
        else
            HeavyDelayPerShot = Config.HeavyDelayPerShot
            if not HeavyDelayPerShot then
                HeavyDelayPerShot = Config.DelayPerShot
            end
        end
        if HeavyDelayPerShot ~= 0 then
            v3 = HeavyDelayPerShot
        else
            v3 = 1
        end
        v1 = v3 / (HeavySwingStart + HeavySwingEnd)
        p1.MeleeRPMRatio = v1
        if not p1.DoingHeavy then
            HeavySwingRPMScaling = not p1.DoingHeavy
            if HeavySwingRPMScaling then
                HeavySwingRPMScaling = Config.SwingRPMScaling
            end
        else
            HeavySwingRPMScaling = Config.HeavySwingRPMScaling
            if not HeavySwingRPMScaling then
                HeavySwingRPMScaling = not p1.DoingHeavy
                if HeavySwingRPMScaling then
                    HeavySwingRPMScaling = Config.SwingRPMScaling
                end
            end
        end
        local u71 = nil
        if Config.SwingData then
            local Swing1 = Config.SwingData[p1.PreviouslyPlayed or "Swing1"]
            if not Swing1 then
                Swing1 = Config.SwingData.Swing1
            end
            u71 = Swing1
            if u71 then
                HeavySwingStart = u71.start
            end
        end
        if HeavySwingRPMScaling then
            HeavySwingStart = HeavySwingStart * v1
            HeavySwingEnd = HeavySwingEnd * v1
        end
        if not p1.SwingStarted then
            v7 = os.clock()
            if not (MeleeStart + HeavySwingStart <= v7) then
                v2 = p3
            else
                task.spawn(function() -- Line: 73 -- upvalues: p1 (val)
                    if p1.SlashTrail then
                        p1.SlashTrail.Enabled = true
                        return
                    end
                    local Model = p1.Viewmodel.Model
                    if Model and Model:FindFirstChild("KeyParts") then
                        local SlashTrail = Model.KeyParts:FindFirstChild("SlashTrail")
                        if SlashTrail then
                            p1.SlashTrail = SlashTrail
                            p1.SlashTrail.Enabled = true
                        end
                    end
                end)
                p1.SwingStarted = true
                p1.TimesHitEnemy = {}
                p1.HitModels = {}
                if u71 then
                    task.spawn(function() -- Line: 92 -- upvalues: MeleeCaster (upval), u71 (ref), u89 (upval), p1 (val)
                        local v1 = MeleeCaster
                        local v2 = u71
                        local v3 = u89
                        local v4 = p1
                        v1:StartCast(v2, v3, v4)
                    end)
                end
                if not p1.DoingHeavy then
                    v2 = p3
                else
                    local Config_2 = p1.Config
                    Config_2.Damage = Config_2.Damage * 2
                    v2 = p3
                end
            end
        elseif not p1.SwingStarted then
            v2 = p3
        else
            v7 = os.clock()
            if not (MeleeStart + HeavySwingEnd <= v7) then
                v2 = p3
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
                v2 = p3
            end
        end
    end
    if MeleeStart then
        v4 = os.clock()
        if MeleeStart + (Config.SwingComboEnd or 0) <= v4 then
            p1.SwingCombo = 0
        end
    end
    if p1.Viewmodel.Animations then
        if p1.Viewmodel.Animations.Block then
            local BlockStaminaRequired, BlockStaminaUse, StaminaDisplay, Stamina_2, StartBlockSFX, Viewmodel, Viewmodel_2, peek, v8, v9, v10
            local ParryOnly = Config.ParryOnly

            local function stopBlocking() -- Line: 130 -- upvalues: p1 (val), Config (val), ParryOnly (val)
                local v1
                if p1.Blocking then
                    if not p1.Parried then
                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                    end
                    p1.Parried = false
                    if ParryOnly then
                        p1.ParryDebounce = true
                    end
                end
                p1.Blocking = false
                local Viewmodel = p1.Viewmodel
                if not p1.Meleeing then
                    v1 = 0.1
                else
                    v1 = 0
                end
                Viewmodel:StopAnimation("Block", v1)
            end

            if p1.Blocking or p1.SecondaryAttackDown then
                if p1.SecondaryAttackDown then
                    if p1.Meleeing or p1.DoCharging or not (0.01 <= (v2:GetStamina())) then
                        if not Config.ParryOnly then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif Config.ParryOnly then
                            if not p1.ParryTime then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            elseif p1.ParryTime then
                                v10 = os.clock()
                                if p1.ParryTime < v10 then
                                    if p1.Blocking then
                                        if not p1.Parried then
                                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                        end
                                        p1.Parried = false
                                        if ParryOnly then
                                            p1.ParryDebounce = true
                                        end
                                    end
                                    p1.Blocking = false
                                    Viewmodel_2 = p1.Viewmodel
                                    if not p1.Meleeing then
                                        v1 = 0.1
                                    else
                                        v1 = 0
                                    end
                                    Viewmodel_2:StopAnimation("Block", v1)
                                end
                            end
                        end
                    elseif not p1.Config.CantBloc then
                        if not p1.BlockDebounce then
                            v10 = not p1.BlockDebounce
                        else
                            v3 = os.clock()
                            if not (p1.BlockDebounce < v3) then
                                v10 = not p1.BlockDebounce
                            else
                                v10 = true
                            end
                        end
                        if not v10 then
                            if not Config.ParryOnly then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            elseif Config.ParryOnly then
                                if not p1.ParryTime then
                                    if p1.Blocking then
                                        if not p1.Parried then
                                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                        end
                                        p1.Parried = false
                                        if ParryOnly then
                                            p1.ParryDebounce = true
                                        end
                                    end
                                    p1.Blocking = false
                                    Viewmodel_2 = p1.Viewmodel
                                    if not p1.Meleeing then
                                        v1 = 0.1
                                    else
                                        v1 = 0
                                    end
                                    Viewmodel_2:StopAnimation("Block", v1)
                                elseif p1.ParryTime then
                                    v10 = os.clock()
                                    if p1.ParryTime < v10 then
                                        if p1.Blocking then
                                            if not p1.Parried then
                                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                            end
                                            p1.Parried = false
                                            if ParryOnly then
                                                p1.ParryDebounce = true
                                            end
                                        end
                                        p1.Blocking = false
                                        Viewmodel_2 = p1.Viewmodel
                                        if not p1.Meleeing then
                                            v1 = 0.1
                                        else
                                            v1 = 0
                                        end
                                        Viewmodel_2:StopAnimation("Block", v1)
                                    end
                                end
                            end
                        elseif not ParryOnly or not p1.ParryDebounce then
                            if not p1.Blocking then
                                Stamina_2 = v2:GetStamina()
                                if (Config.BlockStaminaRequired or 25) <= Stamina_2 then
                                    BlockStaminaUse = Config.BlockStaminaUse
                                    v2:DrainStamina(BlockStaminaUse or 0)
                                    v3 = Fusion
                                    peek = v3.peek
                                    v8 = SkillTreeData
                                    v3 = peek(v8.ParryWindowBonus)
                                    p1.ParryTime = os.clock() + (Config.ParryWindow or 0) + (v3 or 0)
                                    p1.Blocking = true
                                    v3 = SoundUtil
                                    StartBlockSFX = p1.Config.StartBlockSFX
                                    v3:PlaySound(StartBlockSFX)
                                elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                                    v3 = HUDService
                                    StaminaDisplay = v3.Elements.StaminaDisplay
                                    BlockStaminaRequired = Config.BlockStaminaRequired
                                    StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                                end
                            elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                                v3 = HUDService
                                StaminaDisplay = v3.Elements.StaminaDisplay
                                BlockStaminaRequired = Config.BlockStaminaRequired
                                StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                            end
                            if p1.Blocking then
                                v10 = Config.BlockStaminaDrain * v6
                                v2:DrainStamina(v10)
                                if p1.Config.UseBlockAnimation then
                                    p1.Viewmodel:PlayAnimation("Block", 0.1, 1, 1)
                                end
                                p1.Viewmodel:StopAnimation("HeavySwing")
                                p1.Viewmodel:StopAnimation("HeavySwing2")
                                p1.Viewmodel:StopAnimation("Swing1")
                                p1.Viewmodel:StopAnimation("Swing2")
                                if ParryOnly and p1.ParryTime then
                                    v3 = os.clock()
                                    if p1.ParryTime < v3 then
                                        if p1.Blocking then
                                            if not p1.Parried then
                                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                            end
                                            p1.Parried = false
                                            if ParryOnly then
                                                p1.ParryDebounce = true
                                            end
                                        end
                                        p1.Blocking = false
                                        Viewmodel = p1.Viewmodel
                                        if not p1.Meleeing then
                                            v9 = 0.1
                                        else
                                            v9 = 0
                                        end
                                        Viewmodel:StopAnimation("Block", v9)
                                    end
                                end
                            end
                        elseif not Config.ParryOnly then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif Config.ParryOnly then
                            if not p1.ParryTime then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            elseif p1.ParryTime then
                                v10 = os.clock()
                                if p1.ParryTime < v10 then
                                    if p1.Blocking then
                                        if not p1.Parried then
                                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                        end
                                        p1.Parried = false
                                        if ParryOnly then
                                            p1.ParryDebounce = true
                                        end
                                    end
                                    p1.Blocking = false
                                    Viewmodel_2 = p1.Viewmodel
                                    if not p1.Meleeing then
                                        v1 = 0.1
                                    else
                                        v1 = 0
                                    end
                                    Viewmodel_2:StopAnimation("Block", v1)
                                end
                            end
                        end
                    elseif not Config.ParryOnly then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif Config.ParryOnly then
                        if not p1.ParryTime then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif p1.ParryTime then
                            v10 = os.clock()
                            if p1.ParryTime < v10 then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            end
                        end
                    end
                elseif not v2.BlockPressed or p1.Meleeing or p1.DoCharging or not (0.01 <= (v2:GetStamina())) then
                    if not Config.ParryOnly then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif Config.ParryOnly then
                        if not p1.ParryTime then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif p1.ParryTime then
                            v10 = os.clock()
                            if p1.ParryTime < v10 then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            end
                        end
                    end
                elseif not p1.Config.CantBloc then
                    if not p1.BlockDebounce then
                        v10 = not p1.BlockDebounce
                    else
                        v3 = os.clock()
                        if not (p1.BlockDebounce < v3) then
                            v10 = not p1.BlockDebounce
                        else
                            v10 = true
                        end
                    end
                    if not v10 then
                        if not Config.ParryOnly then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif Config.ParryOnly then
                            if not p1.ParryTime then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            elseif p1.ParryTime then
                                v10 = os.clock()
                                if p1.ParryTime < v10 then
                                    if p1.Blocking then
                                        if not p1.Parried then
                                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                        end
                                        p1.Parried = false
                                        if ParryOnly then
                                            p1.ParryDebounce = true
                                        end
                                    end
                                    p1.Blocking = false
                                    Viewmodel_2 = p1.Viewmodel
                                    if not p1.Meleeing then
                                        v1 = 0.1
                                    else
                                        v1 = 0
                                    end
                                    Viewmodel_2:StopAnimation("Block", v1)
                                end
                            end
                        end
                    elseif not ParryOnly or not p1.ParryDebounce then
                        if not p1.Blocking then
                            Stamina_2 = v2:GetStamina()
                            if (Config.BlockStaminaRequired or 25) <= Stamina_2 then
                                BlockStaminaUse = Config.BlockStaminaUse
                                v2:DrainStamina(BlockStaminaUse or 0)
                                v3 = Fusion
                                peek = v3.peek
                                v8 = SkillTreeData
                                v3 = peek(v8.ParryWindowBonus)
                                p1.ParryTime = os.clock() + (Config.ParryWindow or 0) + (v3 or 0)
                                p1.Blocking = true
                                v3 = SoundUtil
                                StartBlockSFX = p1.Config.StartBlockSFX
                                v3:PlaySound(StartBlockSFX)
                            elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                                v3 = HUDService
                                StaminaDisplay = v3.Elements.StaminaDisplay
                                BlockStaminaRequired = Config.BlockStaminaRequired
                                StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                            end
                        elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                            v3 = HUDService
                            StaminaDisplay = v3.Elements.StaminaDisplay
                            BlockStaminaRequired = Config.BlockStaminaRequired
                            StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                        end
                        if p1.Blocking then
                            v10 = Config.BlockStaminaDrain * v6
                            v2:DrainStamina(v10)
                            if p1.Config.UseBlockAnimation then
                                p1.Viewmodel:PlayAnimation("Block", 0.1, 1, 1)
                            end
                            p1.Viewmodel:StopAnimation("HeavySwing")
                            p1.Viewmodel:StopAnimation("HeavySwing2")
                            p1.Viewmodel:StopAnimation("Swing1")
                            p1.Viewmodel:StopAnimation("Swing2")
                            if ParryOnly and p1.ParryTime then
                                v3 = os.clock()
                                if p1.ParryTime < v3 then
                                    if p1.Blocking then
                                        if not p1.Parried then
                                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                        end
                                        p1.Parried = false
                                        if ParryOnly then
                                            p1.ParryDebounce = true
                                        end
                                    end
                                    p1.Blocking = false
                                    Viewmodel = p1.Viewmodel
                                    if not p1.Meleeing then
                                        v9 = 0.1
                                    else
                                        v9 = 0
                                    end
                                    Viewmodel:StopAnimation("Block", v9)
                                end
                            end
                        end
                    elseif not Config.ParryOnly then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif Config.ParryOnly then
                        if not p1.ParryTime then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif p1.ParryTime then
                            v10 = os.clock()
                            if p1.ParryTime < v10 then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            end
                        end
                    end
                elseif not Config.ParryOnly then
                    if p1.Blocking then
                        if not p1.Parried then
                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                        end
                        p1.Parried = false
                        if ParryOnly then
                            p1.ParryDebounce = true
                        end
                    end
                    p1.Blocking = false
                    Viewmodel_2 = p1.Viewmodel
                    if not p1.Meleeing then
                        v1 = 0.1
                    else
                        v1 = 0
                    end
                    Viewmodel_2:StopAnimation("Block", v1)
                elseif Config.ParryOnly then
                    if not p1.ParryTime then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif p1.ParryTime then
                        v10 = os.clock()
                        if p1.ParryTime < v10 then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        end
                    end
                end
            elseif not v2.BlockPressed then
                if Config.ParryOnly then
                    if not p1.Blocking then
                        if not v2.BlockPressed then
                            p1.ParryDebounce = nil
                        end
                    elseif not p1.SecondaryAttackDown and not v2.BlockPressed then
                        p1.ParryDebounce = nil
                    end
                end
            elseif p1.SecondaryAttackDown then
                if p1.Meleeing or p1.DoCharging or not (0.01 <= (v2:GetStamina())) then
                    if not Config.ParryOnly then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif Config.ParryOnly then
                        if not p1.ParryTime then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif p1.ParryTime then
                            v10 = os.clock()
                            if p1.ParryTime < v10 then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            end
                        end
                    end
                elseif not p1.Config.CantBloc then
                    if not p1.BlockDebounce then
                        v10 = not p1.BlockDebounce
                    else
                        v3 = os.clock()
                        if not (p1.BlockDebounce < v3) then
                            v10 = not p1.BlockDebounce
                        else
                            v10 = true
                        end
                    end
                    if not v10 then
                        if not Config.ParryOnly then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif Config.ParryOnly then
                            if not p1.ParryTime then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            elseif p1.ParryTime then
                                v10 = os.clock()
                                if p1.ParryTime < v10 then
                                    if p1.Blocking then
                                        if not p1.Parried then
                                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                        end
                                        p1.Parried = false
                                        if ParryOnly then
                                            p1.ParryDebounce = true
                                        end
                                    end
                                    p1.Blocking = false
                                    Viewmodel_2 = p1.Viewmodel
                                    if not p1.Meleeing then
                                        v1 = 0.1
                                    else
                                        v1 = 0
                                    end
                                    Viewmodel_2:StopAnimation("Block", v1)
                                end
                            end
                        end
                    elseif not ParryOnly or not p1.ParryDebounce then
                        if not p1.Blocking then
                            Stamina_2 = v2:GetStamina()
                            if (Config.BlockStaminaRequired or 25) <= Stamina_2 then
                                BlockStaminaUse = Config.BlockStaminaUse
                                v2:DrainStamina(BlockStaminaUse or 0)
                                v3 = Fusion
                                peek = v3.peek
                                v8 = SkillTreeData
                                v3 = peek(v8.ParryWindowBonus)
                                p1.ParryTime = os.clock() + (Config.ParryWindow or 0) + (v3 or 0)
                                p1.Blocking = true
                                v3 = SoundUtil
                                StartBlockSFX = p1.Config.StartBlockSFX
                                v3:PlaySound(StartBlockSFX)
                            elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                                v3 = HUDService
                                StaminaDisplay = v3.Elements.StaminaDisplay
                                BlockStaminaRequired = Config.BlockStaminaRequired
                                StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                            end
                        elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                            v3 = HUDService
                            StaminaDisplay = v3.Elements.StaminaDisplay
                            BlockStaminaRequired = Config.BlockStaminaRequired
                            StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                        end
                        if p1.Blocking then
                            v10 = Config.BlockStaminaDrain * v6
                            v2:DrainStamina(v10)
                            if p1.Config.UseBlockAnimation then
                                p1.Viewmodel:PlayAnimation("Block", 0.1, 1, 1)
                            end
                            p1.Viewmodel:StopAnimation("HeavySwing")
                            p1.Viewmodel:StopAnimation("HeavySwing2")
                            p1.Viewmodel:StopAnimation("Swing1")
                            p1.Viewmodel:StopAnimation("Swing2")
                            if ParryOnly and p1.ParryTime then
                                v3 = os.clock()
                                if p1.ParryTime < v3 then
                                    if p1.Blocking then
                                        if not p1.Parried then
                                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                        end
                                        p1.Parried = false
                                        if ParryOnly then
                                            p1.ParryDebounce = true
                                        end
                                    end
                                    p1.Blocking = false
                                    Viewmodel = p1.Viewmodel
                                    if not p1.Meleeing then
                                        v9 = 0.1
                                    else
                                        v9 = 0
                                    end
                                    Viewmodel:StopAnimation("Block", v9)
                                end
                            end
                        end
                    elseif not Config.ParryOnly then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif Config.ParryOnly then
                        if not p1.ParryTime then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif p1.ParryTime then
                            v10 = os.clock()
                            if p1.ParryTime < v10 then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            end
                        end
                    end
                elseif not Config.ParryOnly then
                    if p1.Blocking then
                        if not p1.Parried then
                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                        end
                        p1.Parried = false
                        if ParryOnly then
                            p1.ParryDebounce = true
                        end
                    end
                    p1.Blocking = false
                    Viewmodel_2 = p1.Viewmodel
                    if not p1.Meleeing then
                        v1 = 0.1
                    else
                        v1 = 0
                    end
                    Viewmodel_2:StopAnimation("Block", v1)
                elseif Config.ParryOnly then
                    if not p1.ParryTime then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif p1.ParryTime then
                        v10 = os.clock()
                        if p1.ParryTime < v10 then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        end
                    end
                end
            elseif not v2.BlockPressed or p1.Meleeing or p1.DoCharging or not (0.01 <= (v2:GetStamina())) then
                if not Config.ParryOnly then
                    if p1.Blocking then
                        if not p1.Parried then
                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                        end
                        p1.Parried = false
                        if ParryOnly then
                            p1.ParryDebounce = true
                        end
                    end
                    p1.Blocking = false
                    Viewmodel_2 = p1.Viewmodel
                    if not p1.Meleeing then
                        v1 = 0.1
                    else
                        v1 = 0
                    end
                    Viewmodel_2:StopAnimation("Block", v1)
                elseif Config.ParryOnly then
                    if not p1.ParryTime then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif p1.ParryTime then
                        v10 = os.clock()
                        if p1.ParryTime < v10 then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        end
                    end
                end
            elseif not p1.Config.CantBloc then
                if not p1.BlockDebounce then
                    v10 = not p1.BlockDebounce
                else
                    v3 = os.clock()
                    if not (p1.BlockDebounce < v3) then
                        v10 = not p1.BlockDebounce
                    else
                        v10 = true
                    end
                end
                if not v10 then
                    if not Config.ParryOnly then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif Config.ParryOnly then
                        if not p1.ParryTime then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        elseif p1.ParryTime then
                            v10 = os.clock()
                            if p1.ParryTime < v10 then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel_2 = p1.Viewmodel
                                if not p1.Meleeing then
                                    v1 = 0.1
                                else
                                    v1 = 0
                                end
                                Viewmodel_2:StopAnimation("Block", v1)
                            end
                        end
                    end
                elseif not ParryOnly or not p1.ParryDebounce then
                    if not p1.Blocking then
                        Stamina_2 = v2:GetStamina()
                        if (Config.BlockStaminaRequired or 25) <= Stamina_2 then
                            BlockStaminaUse = Config.BlockStaminaUse
                            v2:DrainStamina(BlockStaminaUse or 0)
                            v3 = Fusion
                            peek = v3.peek
                            v8 = SkillTreeData
                            v3 = peek(v8.ParryWindowBonus)
                            p1.ParryTime = os.clock() + (Config.ParryWindow or 0) + (v3 or 0)
                            p1.Blocking = true
                            v3 = SoundUtil
                            StartBlockSFX = p1.Config.StartBlockSFX
                            v3:PlaySound(StartBlockSFX)
                        elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                            v3 = HUDService
                            StaminaDisplay = v3.Elements.StaminaDisplay
                            BlockStaminaRequired = Config.BlockStaminaRequired
                            StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                        end
                    elseif not p1.Blocking and (v2:GetStamina()) < (Config.BlockStaminaRequired or 25) then
                        v3 = HUDService
                        StaminaDisplay = v3.Elements.StaminaDisplay
                        BlockStaminaRequired = Config.BlockStaminaRequired
                        StaminaDisplay:FlashRequired(BlockStaminaRequired or 25)
                    end
                    if p1.Blocking then
                        v10 = Config.BlockStaminaDrain * v6
                        v2:DrainStamina(v10)
                        if p1.Config.UseBlockAnimation then
                            p1.Viewmodel:PlayAnimation("Block", 0.1, 1, 1)
                        end
                        p1.Viewmodel:StopAnimation("HeavySwing")
                        p1.Viewmodel:StopAnimation("HeavySwing2")
                        p1.Viewmodel:StopAnimation("Swing1")
                        p1.Viewmodel:StopAnimation("Swing2")
                        if ParryOnly and p1.ParryTime then
                            v3 = os.clock()
                            if p1.ParryTime < v3 then
                                if p1.Blocking then
                                    if not p1.Parried then
                                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                    end
                                    p1.Parried = false
                                    if ParryOnly then
                                        p1.ParryDebounce = true
                                    end
                                end
                                p1.Blocking = false
                                Viewmodel = p1.Viewmodel
                                if not p1.Meleeing then
                                    v9 = 0.1
                                else
                                    v9 = 0
                                end
                                Viewmodel:StopAnimation("Block", v9)
                            end
                        end
                    end
                elseif not Config.ParryOnly then
                    if p1.Blocking then
                        if not p1.Parried then
                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                        end
                        p1.Parried = false
                        if ParryOnly then
                            p1.ParryDebounce = true
                        end
                    end
                    p1.Blocking = false
                    Viewmodel_2 = p1.Viewmodel
                    if not p1.Meleeing then
                        v1 = 0.1
                    else
                        v1 = 0
                    end
                    Viewmodel_2:StopAnimation("Block", v1)
                elseif Config.ParryOnly then
                    if not p1.ParryTime then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    elseif p1.ParryTime then
                        v10 = os.clock()
                        if p1.ParryTime < v10 then
                            if p1.Blocking then
                                if not p1.Parried then
                                    p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                                end
                                p1.Parried = false
                                if ParryOnly then
                                    p1.ParryDebounce = true
                                end
                            end
                            p1.Blocking = false
                            Viewmodel_2 = p1.Viewmodel
                            if not p1.Meleeing then
                                v1 = 0.1
                            else
                                v1 = 0
                            end
                            Viewmodel_2:StopAnimation("Block", v1)
                        end
                    end
                end
            elseif not Config.ParryOnly then
                if p1.Blocking then
                    if not p1.Parried then
                        p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                    end
                    p1.Parried = false
                    if ParryOnly then
                        p1.ParryDebounce = true
                    end
                end
                p1.Blocking = false
                Viewmodel_2 = p1.Viewmodel
                if not p1.Meleeing then
                    v1 = 0.1
                else
                    v1 = 0
                end
                Viewmodel_2:StopAnimation("Block", v1)
            elseif Config.ParryOnly then
                if not p1.ParryTime then
                    if p1.Blocking then
                        if not p1.Parried then
                            p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                        end
                        p1.Parried = false
                        if ParryOnly then
                            p1.ParryDebounce = true
                        end
                    end
                    p1.Blocking = false
                    Viewmodel_2 = p1.Viewmodel
                    if not p1.Meleeing then
                        v1 = 0.1
                    else
                        v1 = 0
                    end
                    Viewmodel_2:StopAnimation("Block", v1)
                elseif p1.ParryTime then
                    v10 = os.clock()
                    if p1.ParryTime < v10 then
                        if p1.Blocking then
                            if not p1.Parried then
                                p1.BlockDebounce = os.clock() + (Config.BlockCooldown or 0.75)
                            end
                            p1.Parried = false
                            if ParryOnly then
                                p1.ParryDebounce = true
                            end
                        end
                        p1.Blocking = false
                        Viewmodel_2 = p1.Viewmodel
                        if not p1.Meleeing then
                            v1 = 0.1
                        else
                            v1 = 0
                        end
                        Viewmodel_2:StopAnimation("Block", v1)
                    end
                end
            end
        end
        if p1.Viewmodel.Animations.Charge then
            local HeavyDelayPerShot_2, HeavyStaminaCost, HeavyStaminaRequired, PreviouslyPlayed, StaminaDisplay_2, Stamina_4, Viewmodel_3, v11
            if not p1.Viewmodel.Animations.Charge.IsPlaying then
                if p1.Charging then
                    v4 = os.clock()
                    if p1.PrimaryAttackStart + 0.3 <= v4 then
                        if p1.Charging and not p1.DoCharging then
                            Stamina_4 = v2:GetStamina()
                            if not (Config.HeavyStaminaRequired <= Stamina_4) then
                                if not p1.DoCharging and Config.HeavyStaminaRequired < 100 then
                                    v11 = HUDService
                                    StaminaDisplay_2 = v11.Elements.StaminaDisplay
                                    HeavyStaminaRequired = Config.HeavyStaminaRequired
                                    StaminaDisplay_2:FlashRequired(HeavyStaminaRequired)
                                    return
                                end
                                return
                            end
                            HeavyStaminaCost = Config.HeavyStaminaCost
                            HeavyDelayPerShot_2 = Config.HeavyDelayPerShot
                            v2:DrainStamina(HeavyStaminaCost, HeavyDelayPerShot_2)
                            p1.DoCharging = true
                            p1.Viewmodel:PlayAnimation("Charge")
                            if p1.PreviouslyPlayed then
                                Viewmodel_3 = p1.Viewmodel
                                PreviouslyPlayed = p1.PreviouslyPlayed
                                Viewmodel_3:StopAnimation(PreviouslyPlayed)
                                if p1.PreviouslyPlayed == "Swing1" then
                                    p1.Viewmodel:PlayAnimation("Charge2")
                                end
                            end
                            if not p1.Viewmodel.Animations.ChargeIdle then
                                return
                            end
                            p1.Viewmodel.Animations.ChargeIdle.Looped = true
                            p1.Viewmodel.Animations.ChargeIdle.Priority = Enum.AnimationPriority.Action
                            p1.Viewmodel:PlayAnimation("ChargeIdle")
                            return
                        end
                        if p1.DoCharging and not p1.Charging then
                            p1.DoCharging = false
                            p1.Viewmodel:StopAnimation("ChargeIdle")
                            p1.Viewmodel:StopAnimation("Charge")
                            p1.Viewmodel:StopAnimation("Charge2")
                            return
                        end
                        if p1.DoCharging and p1.Charging then
                            v4 = Config.HeavyChargeStaminaDrain * v6
                            if Config.OnlyDrainWhileCharging then
                                v11 = os.clock()
                                if p1.PrimaryAttackStart + Config.ChargeTime < v11 then
                                    v4 = 0
                                end
                            end
                            v2:DrainStamina(v4, 1)
                        end
                        return
                    end
                end
                if p1.DoCharging and not p1.Charging then
                    if p1.Charging and not p1.DoCharging then
                        Stamina_4 = v2:GetStamina()
                        if not (Config.HeavyStaminaRequired <= Stamina_4) then
                            if not p1.DoCharging and Config.HeavyStaminaRequired < 100 then
                                v11 = HUDService
                                StaminaDisplay_2 = v11.Elements.StaminaDisplay
                                HeavyStaminaRequired = Config.HeavyStaminaRequired
                                StaminaDisplay_2:FlashRequired(HeavyStaminaRequired)
                                return
                            end
                            return
                        end
                        HeavyStaminaCost = Config.HeavyStaminaCost
                        HeavyDelayPerShot_2 = Config.HeavyDelayPerShot
                        v2:DrainStamina(HeavyStaminaCost, HeavyDelayPerShot_2)
                        p1.DoCharging = true
                        p1.Viewmodel:PlayAnimation("Charge")
                        if p1.PreviouslyPlayed then
                            Viewmodel_3 = p1.Viewmodel
                            PreviouslyPlayed = p1.PreviouslyPlayed
                            Viewmodel_3:StopAnimation(PreviouslyPlayed)
                            if p1.PreviouslyPlayed == "Swing1" then
                                p1.Viewmodel:PlayAnimation("Charge2")
                            end
                        end
                        if not p1.Viewmodel.Animations.ChargeIdle then
                            return
                        end
                        p1.Viewmodel.Animations.ChargeIdle.Looped = true
                        p1.Viewmodel.Animations.ChargeIdle.Priority = Enum.AnimationPriority.Action
                        p1.Viewmodel:PlayAnimation("ChargeIdle")
                        return
                    end
                    if p1.DoCharging and not p1.Charging then
                        p1.DoCharging = false
                        p1.Viewmodel:StopAnimation("ChargeIdle")
                        p1.Viewmodel:StopAnimation("Charge")
                        p1.Viewmodel:StopAnimation("Charge2")
                        return
                    end
                    if p1.DoCharging and p1.Charging then
                        v4 = Config.HeavyChargeStaminaDrain * v6
                        if Config.OnlyDrainWhileCharging then
                            v11 = os.clock()
                            if p1.PrimaryAttackStart + Config.ChargeTime < v11 then
                                v4 = 0
                            end
                        end
                        v2:DrainStamina(v4, 1)
                    end
                end
                return
            end
            if p1.Charging and not p1.DoCharging then
                Stamina_4 = v2:GetStamina()
                if not (Config.HeavyStaminaRequired <= Stamina_4) then
                    if not p1.DoCharging and Config.HeavyStaminaRequired < 100 then
                        v11 = HUDService
                        StaminaDisplay_2 = v11.Elements.StaminaDisplay
                        HeavyStaminaRequired = Config.HeavyStaminaRequired
                        StaminaDisplay_2:FlashRequired(HeavyStaminaRequired)
                        return
                    end
                    return
                end
                HeavyStaminaCost = Config.HeavyStaminaCost
                HeavyDelayPerShot_2 = Config.HeavyDelayPerShot
                v2:DrainStamina(HeavyStaminaCost, HeavyDelayPerShot_2)
                p1.DoCharging = true
                p1.Viewmodel:PlayAnimation("Charge")
                if p1.PreviouslyPlayed then
                    Viewmodel_3 = p1.Viewmodel
                    PreviouslyPlayed = p1.PreviouslyPlayed
                    Viewmodel_3:StopAnimation(PreviouslyPlayed)
                    if p1.PreviouslyPlayed == "Swing1" then
                        p1.Viewmodel:PlayAnimation("Charge2")
                    end
                end
                if not p1.Viewmodel.Animations.ChargeIdle then
                    return
                end
                p1.Viewmodel.Animations.ChargeIdle.Looped = true
                p1.Viewmodel.Animations.ChargeIdle.Priority = Enum.AnimationPriority.Action
                p1.Viewmodel:PlayAnimation("ChargeIdle")
                return
            end
            if p1.DoCharging and not p1.Charging then
                p1.DoCharging = false
                p1.Viewmodel:StopAnimation("ChargeIdle")
                p1.Viewmodel:StopAnimation("Charge")
                p1.Viewmodel:StopAnimation("Charge2")
                return
            end
            if p1.DoCharging and p1.Charging then
                v4 = Config.HeavyChargeStaminaDrain * v6
                if Config.OnlyDrainWhileCharging then
                    v11 = os.clock()
                    if p1.PrimaryAttackStart + Config.ChargeTime < v11 then
                        v4 = 0
                    end
                end
                v2:DrainStamina(v4, 1)
            end
        end
    end
end

function u95.ProcessHit(p1, p2, p3, p4) -- Line: 228
    -- upvalues: u95 (val), HitReg (val), ClassMirror (val), BulletUtil (val), MeleeReg (val)
    local BloodNPC, HitTable, IgnoreTable, TimesHitEnemy, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local Instance = p2.Instance
    local Config = p3.Config
    local v11 = {}
    local v12 = {}
    v12.startPos = p1
    v12.raycastResult = p2
    v12.weapon = p3
    v12.prevHit = {}
    v12.ignoreList = {}
    v12.toNetwork = v11
    local v13 = Instance:FindFirstAncestorWhichIsA("Model")
    if not p3.HitModels then
        p3.HitModels = {}
    end
    if not p3.HitModels[v13] then
        p3.HitModels[v13] = true
        v1 = u95
        local Hit = v1.Hit
        local WeaponId = p3.WeaponId
        Hit:Fire(p2, WeaponId)
    end
    v1 = HitReg:ProcessHit(p2, v12)
    local v14 = nil
    if not v1 and v13 then
        v14 = ClassMirror:GetObjFromModel(v13)
    end
    if v1 then
        if p3.TimesHitEnemy.HitTable == nil then
            p3.TimesHitEnemy.HitTable = {}
        end
        v2 = p3.TimesHitEnemy.HitTable[v13]
        if not p3.TimesHitEnemy.EnemiesHit then
            p3.TimesHitEnemy.EnemiesHit = 0
        end
        if p3.TimesHitEnemy.EnemiesHit < Config.MaxEnemiesPerSwing then
            if not v2 then
                v3 = true
            elseif not v2 then
                v3 = false
            else
                v3 = not not (v2 < Config.MaxHitsPerEnemy)
            end
            if v3 then
                if p3.TimesHitEnemy.HitTable[v13] ~= nil then
                    HitTable = p3.TimesHitEnemy.HitTable
                    HitTable[v13] = HitTable[v13] + 1
                else
                    if Config.OnHit then
                        Config.OnHit(p3, v13)
                    end
                    TimesHitEnemy = p3.TimesHitEnemy
                    TimesHitEnemy.EnemiesHit = TimesHitEnemy.EnemiesHit + 1
                    p3.TimesHitEnemy.HitTable[v13] = 1
                end
                v3 = v1
                if not v3 then
                    v3 = v14:ClientShot(v12)
                end
                v4 = nil
                v5 = nil
                v6 = nil
                v7 = nil
                v8 = nil
                if v3 then
                    if p4 then
                        p4.BrickColor = BrickColor.new("Bright green")
                    end
                    if v3.BloodNPC and v14 then
                        v9 = BulletUtil
                        BloodNPC = v3.BloodNPC
                        v10 = unpack(BloodNPC)
                        v9:BloodNPC(v10)
                        v4 = true
                    end
                    if v3.HitFlesh then
                        v4 = true
                    end
                    if v3.HitArmor then
                        v5 = true
                    end
                    if v3.HitHeadshot then
                        v7 = true
                    end
                    if v3.Killed then
                        v8 = true
                    end
                    if v3.BrokeArmor then
                        v6 = true
                    end
                end
                HitReg:ProcessNetworkQueue()
                v9 = MeleeReg
                v10 = {p3.Slot, v11[1], v11[2]}
                v9:FireServer(v10)
                if v8 then
                    p3.HitEntity:Fire("Kill")
                elseif v7 then
                    p3.HitEntity:Fire("Headshot")
                elseif v6 then
                    p3.HitEntity:Fire("ArmorBreak", {dontDoSound = true})
                elseif v5 then
                    p3.HitEntity:Fire("HitArmor", {dontDoSound = true})
                elseif v4 then
                    p3.HitEntity:Fire("Flesh")
                end
                p3.lastZombieHit = nil
                return
            end
        end
        if not p3.TimesHitEnemy.IgnoreTable then
            p3.TimesHitEnemy.IgnoreTable = {}
        end
        IgnoreTable = p3.TimesHitEnemy.IgnoreTable
        table.insert(IgnoreTable, v13)
        if p4 then
            if not v2 or not (v2 < Config.MaxHitsPerEnemy) then
                v3 = BrickColor.new("Baby blue")
            else
                v3 = BrickColor.new("Cloudy grey")
            end
            p4.BrickColor = v3
            p4.Transparency = 0.75
        end
        return
    end
    if v14 and v14.ClientShot then
        if p3.TimesHitEnemy.HitTable == nil then
            p3.TimesHitEnemy.HitTable = {}
        end
        v2 = p3.TimesHitEnemy.HitTable[v13]
        if not p3.TimesHitEnemy.EnemiesHit then
            p3.TimesHitEnemy.EnemiesHit = 0
        end
        if p3.TimesHitEnemy.EnemiesHit < Config.MaxEnemiesPerSwing then
            if not v2 then
                v3 = true
            elseif not v2 then
                v3 = false
            else
                v3 = not not (v2 < Config.MaxHitsPerEnemy)
            end
            if v3 then
                if p3.TimesHitEnemy.HitTable[v13] ~= nil then
                    HitTable = p3.TimesHitEnemy.HitTable
                    HitTable[v13] = HitTable[v13] + 1
                else
                    if Config.OnHit then
                        Config.OnHit(p3, v13)
                    end
                    TimesHitEnemy = p3.TimesHitEnemy
                    TimesHitEnemy.EnemiesHit = TimesHitEnemy.EnemiesHit + 1
                    p3.TimesHitEnemy.HitTable[v13] = 1
                end
                v3 = v1
                if not v3 then
                    v3 = v14:ClientShot(v12)
                end
                v4 = nil
                v5 = nil
                v6 = nil
                v7 = nil
                v8 = nil
                if v3 then
                    if p4 then
                        p4.BrickColor = BrickColor.new("Bright green")
                    end
                    if v3.BloodNPC and v14 then
                        v9 = BulletUtil
                        BloodNPC = v3.BloodNPC
                        v10 = unpack(BloodNPC)
                        v9:BloodNPC(v10)
                        v4 = true
                    end
                    if v3.HitFlesh then
                        v4 = true
                    end
                    if v3.HitArmor then
                        v5 = true
                    end
                    if v3.HitHeadshot then
                        v7 = true
                    end
                    if v3.Killed then
                        v8 = true
                    end
                    if v3.BrokeArmor then
                        v6 = true
                    end
                end
                HitReg:ProcessNetworkQueue()
                v9 = MeleeReg
                v10 = {p3.Slot, v11[1], v11[2]}
                v9:FireServer(v10)
                if v8 then
                    p3.HitEntity:Fire("Kill")
                elseif v7 then
                    p3.HitEntity:Fire("Headshot")
                elseif v6 then
                    p3.HitEntity:Fire("ArmorBreak", {dontDoSound = true})
                elseif v5 then
                    p3.HitEntity:Fire("HitArmor", {dontDoSound = true})
                elseif v4 then
                    p3.HitEntity:Fire("Flesh")
                end
                p3.lastZombieHit = nil
                return
            end
        end
        if not p3.TimesHitEnemy.IgnoreTable then
            p3.TimesHitEnemy.IgnoreTable = {}
        end
        IgnoreTable = p3.TimesHitEnemy.IgnoreTable
        table.insert(IgnoreTable, v13)
        if p4 then
            if not v2 or not (v2 < Config.MaxHitsPerEnemy) then
                v3 = BrickColor.new("Baby blue")
            else
                v3 = BrickColor.new("Cloudy grey")
            end
            p4.BrickColor = v3
            p4.Transparency = 0.75
        end
    end
end

local ProcessHit = u95.ProcessHit
u89:Connect(ProcessHit)
return u95