local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local RedEvents = ReplicatedStorage.common.RedEvents
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local MeleeSwing = (require(RedEvents.Framework.FrameworkEvents)).MeleeSwing

local function round(p1, p2) -- Line: 16
    local v1 = string.format("%." .. (p2 or 0) .. "f", p1)
    return (tonumber(v1))
end

function roundVector(p1, p2) -- Line: 19
    local X = p1.X
    local v1 = string.format("%." .. (p2 or 0) .. "f", X)
    local v2 = tonumber(v1)
    local Y = p1.Y
    local v3 = string.format("%." .. (p2 or 0) .. "f", Y)
    local v4 = tonumber(v3)
    local Z = p1.Z
    local v5 = string.format("%." .. (p2 or 0) .. "f", Z)
    return v2, v4, (tonumber(v5))
end

return {
    Shoot = function(p1) -- Line: 26 -- upvalues: Fusion (val), SkillTreeData (val), MeleeSwing (val)
        local Viewmodel_2, v1, v2
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
        local Config = p1.Config
        local v3 = Config.SwingAnimationTimeScale or 1
        local v4 = Fusion.peek(SkillTreeData.MeleeSwingSpeedMult) or 1
        v3 = v3 * v4
        if not p1.DoCharging then
            if not p1.SwingCombo or not p1.Viewmodel.Animations["Swing" .. p1.SwingCombo] then
                p1.SwingCombo = 1
                p1.Viewmodel:PlayAnimation("Swing1", nil, nil, v3)
                p1.PreviouslyPlayed = "Swing1"
            else
                p1.Viewmodel:StopAnimation("HeavySwing")
                p1.Viewmodel:StopAnimation("HeavySwing2")
                p1.Viewmodel:StopAnimation("Swing1")
                p1.Viewmodel:StopAnimation("Swing2")
                Viewmodel_2 = p1.Viewmodel
                v2 = "Swing" .. p1.SwingCombo
                Viewmodel_2:PlayAnimation(v2, 0.1, 1, v3)
                p1.PreviouslyPlayed = "Swing" .. p1.SwingCombo
            end
        elseif p1.PrimaryAttackStart then
            v1 = os.clock()
            if p1.PrimaryAttackStart + (p1.Config.ChargeTime or 9999) <= v1 then
                v3 = (Config.HeavySwingAnimationTimeScale or 1) * v4
                v1 = "HeavySwing"
                if p1.PreviouslyPlayed == "Swing1" then
                    v1 = "HeavySwing2"
                end
                p1.PreviouslyPlayed = v1
                p1.Viewmodel:PlayAnimation(v1, 0, 1, v3)
                p1.DoingHeavy = true
            elseif not p1.SwingCombo or not p1.Viewmodel.Animations["Swing" .. p1.SwingCombo] then
                p1.SwingCombo = 1
                p1.Viewmodel:PlayAnimation("Swing1", nil, nil, v3)
                p1.PreviouslyPlayed = "Swing1"
            else
                p1.Viewmodel:StopAnimation("HeavySwing")
                p1.Viewmodel:StopAnimation("HeavySwing2")
                p1.Viewmodel:StopAnimation("Swing1")
                p1.Viewmodel:StopAnimation("Swing2")
                Viewmodel_2 = p1.Viewmodel
                v2 = "Swing" .. p1.SwingCombo
                Viewmodel_2:PlayAnimation(v2, 0.1, 1, v3)
                p1.PreviouslyPlayed = "Swing" .. p1.SwingCombo
            end
        elseif not p1.SwingCombo or not p1.Viewmodel.Animations["Swing" .. p1.SwingCombo] then
            p1.SwingCombo = 1
            p1.Viewmodel:PlayAnimation("Swing1", nil, nil, v3)
            p1.PreviouslyPlayed = "Swing1"
        else
            p1.Viewmodel:StopAnimation("HeavySwing")
            p1.Viewmodel:StopAnimation("HeavySwing2")
            p1.Viewmodel:StopAnimation("Swing1")
            p1.Viewmodel:StopAnimation("Swing2")
            Viewmodel_2 = p1.Viewmodel
            v2 = "Swing" .. p1.SwingCombo
            Viewmodel_2:PlayAnimation(v2, 0.1, 1, v3)
            p1.PreviouslyPlayed = "Swing" .. p1.SwingCombo
        end
        v1 = MeleeSwing
        v2 = {
            p1.Slot,
            p1.DoingHeavy,
            game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0),
        }
        v1:FireServer(v2)
    end,
    NewMelee = function(p1) -- Line: 71
        local Config = p1.Config
        Config.FireMode = {"Melee"}
        p1.Config.AmmoPerShot = 0
        p1.Config.Ammo = 0
    end,
}