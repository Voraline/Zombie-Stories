local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local u12 = RunService:IsClient()
local u13 = {}
u13.__index = u13
function u13.new(p1, p2, p3) -- Line: 12 -- upvalues: u13 (val), u12 (val)
    local v1 = {}
    setmetatable(v1, u13)
    local v2 = {
        Damage = 215,
        ADSSpreadReduction = 0.05,
        AimFOVMultiplier = 0.4,
        RecoilPitchSpeed = 0.2,
        RecoilPitchDamper = 5,
        DelayPerShot = 0.5,
        MuzzleModule = "ForbiddenMatter",
        Penetration = 7,
        PenetrationReduction = 1,
        ADSSpeed = p2.ADSSpeed * 0.7,
        DrawSpeed = p2.DrawSpeed * 0.7,
        VerticalRecoil = p2.VerticalRecoil * 4.5,
        HorizontalRecoil = p2.HorizontalRecoil * 6,
        Multipliers = {Arms = 1, Torso = 1, Legs = 1, Head = 4.7},
        ShootSingle = {SoundId = "7432098206", Volume = 0.5},
        EquippedWalkspeedMultiplier = p2.EquippedWalkspeedMultiplier - 0.1,
        HolsteredWalkspeedMultiplier = p2.HolsteredWalkspeedMultiplier - 0.1,
        BaseSpread = p2.BaseSpread * 2.5,
    }
    local v3 = {}
    local v4 = {
        {SoundId = "9098122922", Volume = 0.5},
        {SoundId = "8060258451", Volume = 0.5},
        {SoundId = "82898678070294", Volume = 0.5},
    }
    v3["0"] = v4
    v2.LayeredSFXs = v3
    v1.SettingChanges = v2
    function v1.SettingChanges.VMImpulse(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10) -- Line: 65
        local v1 = math.random() - 0.5
        local v2 = p3 + math.random() * 0.02 * p10
        local v3 = p5 + 1 + math.random() * 0.25
        local v4 = p6 + 0.35 - math.random() * 0.2
        local v5 = p7 + math.rad(v1 * 0.1 * p10)
        return v2, p4 + 0.075, v3, v4, v5, p8 + 0.01 * v1 * (p10 * 0.5)
    end
    if u12 then
        local LocalPlayer = game:GetService("Players").LocalPlayer
        local StaminaDisplay = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.HUDController.HUDElements.StaminaDisplay)
        local LocalPlayerController = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
        local u67 = require("@game/ReplicatedStorage/common/zap")
        local function impulsePlayer(p1, p2) -- Line: 84 -- upvalues: LocalPlayer (val), LocalPlayerController (val)
            local Character = LocalPlayer.Character
            local PhysBall = LocalPlayerController.PhysBall
            if PhysBall.isActive then
                PhysBall.chasis:ApplyImpulse(p1 * PhysBall.chasis.Mass * p2)
                return false
            end
            Character.HumanoidRootPart:ApplyImpulse(p1 * (function(p1) -- Line: 90
                local v1 = 0
                for i, j in p1:GetDescendants() do
                    if j:IsA("BasePart") and not j.Massless then
                        v1 = v1 + j:GetMass()
                    end
                end
                return v1
            end)(Character) * p2)
            return true
        end
        local function decreaseStamina() -- Line: 109 -- upvalues: LocalPlayerController (val)
            LocalPlayerController:DrainStamina(20, 7.5)
        end
        local function createExplosion() -- Line: 117 -- upvalues: u67 (val)
            u67.TriggerSelfExplosionEvent.Fire({ExplosionType = "XenoDMG"})
        end
        function v1.SettingChanges.CustomShouldFire(p1) -- Line: 113 -- upvalues: LocalPlayerController (val)
            local Stamina = LocalPlayerController:GetStamina()
            local v1 = 0 < Stamina
            return v1
        end
        function v1.SettingChanges.CustomShootAnimation(p1) -- Line: 124 -- upvalues: StaminaDisplay (val), u67 (val), impulsePlayer (val), LocalPlayerController (val)
            if p1.Slot then
                local LocalPlayerController_2 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
                if not p1.lastExplosion then
                    p1.lastExplosion = os.clock()
                end
                local v1 = os.clock() - p1.lastExplosion
                if 0.5 < v1 then
                    local Stamina = LocalPlayerController_2:GetStamina()
                    if Stamina <= 20 then
                        StaminaDisplay:FlashRequired(20)
                        p1.lastExplosion = os.clock()
                        u67.TriggerSelfExplosionEvent.Fire({ExplosionType = "XenoDMG"})
                        local v2 = -(workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1))
                        impulsePlayer(v2, 80)
                    end
                end
                LocalPlayerController:DrainStamina(20, 7.5)
            end
        end
    end
    return v1
end
return u13