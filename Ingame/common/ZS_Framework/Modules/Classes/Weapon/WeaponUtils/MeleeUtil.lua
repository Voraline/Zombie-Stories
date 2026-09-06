local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SkillTreeData = require(ReplicatedStorage.common.skillTree.SkillTreeData)
local MeleeSwing = require(ReplicatedStorage.common.RedEvents.Framework.FrameworkEvents).MeleeSwing
local function round(p1, p2) -- Line: 16
    local v1 = "%." .. (p2 or 0) .. "f"
    return (tonumber(string.format(v1, p1)))
end
function roundVector(p1, p2) -- Line: 19
    local v1 = tonumber(string.format("%." .. (p2 or 0) .. "f", p1.X))
    local v2 = tonumber(string.format("%." .. (p2 or 0) .. "f", p1.Y))
    local v3 = "%." .. (p2 or 0) .. "f"
    return v1, v2, (tonumber(string.format(v3, p1.Z)))
end
return {
    Shoot = function(p1) -- Line: 26 -- upvalues: Fusion (val), SkillTreeData (val), MeleeSwing (val)
        if p1.SwingCombo then
            p1.SwingCombo = p1.SwingCombo + 1
        else
            p1.SwingCombo = 1
        end
        if p1.PreviouslyPlayed then
            p1.Viewmodel:StopAnimation(p1.PreviouslyPlayed)
        end
        local Config = p1.Config
        local v1 = Config.SwingAnimationTimeScale or 1
        local v2 = Fusion.peek(SkillTreeData.MeleeSwingSpeedMult) or 1
        v1 = v1 * v2
        if not p1.DoCharging then
            if not p1.SwingCombo then
                p1.SwingCombo = 1
                p1.Viewmodel:PlayAnimation("Swing1", nil, nil, v1)
                p1.PreviouslyPlayed = "Swing1"
            elseif not (p1.Viewmodel.Animations["Swing" .. p1.SwingCombo]) then
                p1.SwingCombo = 1
                p1.Viewmodel:PlayAnimation("Swing1", nil, nil, v1)
                p1.PreviouslyPlayed = "Swing1"
            else
                p1.Viewmodel:StopAnimation("HeavySwing")
                p1.Viewmodel:StopAnimation("HeavySwing2")
                p1.Viewmodel:StopAnimation("Swing1")
                p1.Viewmodel:StopAnimation("Swing2")
                p1.Viewmodel:PlayAnimation("Swing" .. p1.SwingCombo, 0.1, 1, v1)
                p1.PreviouslyPlayed = "Swing" .. p1.SwingCombo
            end
        elseif p1.PrimaryAttackStart and p1.PrimaryAttackStart + (p1.Config.ChargeTime or 9999) <= os.clock() then
            local v3 = if p1.PreviouslyPlayed == "Swing1" then "HeavySwing2" else "HeavySwing"
            p1.PreviouslyPlayed = v3
            p1.Viewmodel:PlayAnimation(v3, 0, 1, (Config.HeavySwingAnimationTimeScale or 1) * v2)
            p1.DoingHeavy = true
        end
        MeleeSwing:FireServer({p1.Slot, p1.DoingHeavy, game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 1.5, 0)})
    end,
    NewMelee = function(p1) -- Line: 71
        p1.Config.FireMode = {"Melee"}
        p1.Config.AmmoPerShot = 0
        p1.Config.Ammo = 0
    end,
}