local RunService = game:GetService("RunService")
game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u18 = RunService:IsClient()
local u21 = RunService:IsServer()
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local DamageFalloffUtil = require(ReplicatedStorage.common.NPCs_Shared.Utils.DamageFalloffUtil)
local u40 = if u21 then require(ReplicatedStorage.common.skillTree.SkillTreeData) else nil
local u41 = {}
local function isPlayerStationary(p1) -- Line: 20 -- upvalues: u41 (val)
    if not p1 or not p1.Character then
        return false
    end
    local HumanoidRootPart = p1.Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        return false
    end
    local Position = HumanoidRootPart.Position
    local v1 = os.clock()
    local v2 = u41[p1]
    if not v2 then
        u41[p1] = {LastPosition = Position, StationaryStartTime = v1}
        return false
    end
    local v3 = 0.5 < (Position - v2.LastPosition).Magnitude
    if v3 then
        v2.LastPosition = Position
        v2.StationaryStartTime = v1
        return false
    end
    local v4 = v1 - v2.StationaryStartTime
    local v5 = 1 <= v4
    return v5
end
local u43 = {}
local function calcDamageDropoff(p1, p2, p3, p4) -- Line: 48 -- upvalues: DamageFalloffUtil (val)
    if not p3.DamageDropoff then
        return p3.Damage
    end
    local Magnitude = p4
    if not Magnitude then
        Magnitude = (p1 - p2.Position).Magnitude
    end
    return DamageFalloffUtil.CalculateDamageAtDistance(p3, Magnitude)
end
local function calcArmorDamage(p1, p2, p3, p4, p5, p6) -- Line: 57 -- upvalues: DamageFalloffUtil (val)
    local ArmorDamageReduction, Damage
    if not p2.UsesHP then
        ArmorDamageReduction = p2.ArmorDamageReduction
        if not ArmorDamageReduction then
            ArmorDamageReduction = 0.5
        end
    else
        ArmorDamageReduction = 0.25
    end
    local v1 = ArmorDamageReduction ^ math.max(p1.Lvl - p3, 1)
    if p2.DamageDropoff then
        local Magnitude = p6
        if not Magnitude then
            Magnitude = (p4 - p5.Position).Magnitude
        end
        Damage = DamageFalloffUtil.CalculateDamageAtDistance(p2, Magnitude)
    else
        Damage = p2.Damage
    end
    return Damage * v1
end
return function(p1, p2, p3, p4) -- Line: 70 -- upvalues: GameState (val), u43 (val), DamageFalloffUtil (val), u18 (val), u21 (val), u40 (ref), isPlayerStationary (val)
    if p1._Destroyed then
        return
    else
        local v1
        if table.isfrozen(p1) then
            return
        end
        local startPos = p2.startPos
        local weapon = p2.weapon
        local prevHit = p2.prevHit
        local ignoreList = p2.ignoreList
        if not ignoreList then
            ignoreList = {}
        end
        local toNetwork = p2.toNetwork
        if not toNetwork then
            toNetwork = {}
        end
        local roundedDistance = p2.roundedDistance
        if roundedDistance then
            roundedDistance = tonumber(p2.roundedDistance)
        end
        local shooter = p2.shooter
        local Instance = nil
        local v2 = nil
        if p3 then
            local Damage, HP, Name, v3, v4, v5
            if not p1.Model or not p1.Model.Parent then
                return
            end
            if not p1.ArmorHPs then
                if not p1.UIDTable then
                    v1 = p3
                elseif not (p1.UIDTable[p3]) then
                    v1 = p3
                else
                    Instance = p1.UIDTable[p3]
                    v1 = p3
                end
            elseif p1.ArmorHPs[p3] then
                Instance = p1.Model[p1.ArmorHPs[p3][2]]
                v2 = true
                v1 = p3
            end
            if not Instance or not v1 then
                return
            end
            local v6 = false
            local Config = weapon.Config
            local v7 = {}
            local v8 = 1
            if GameState.Data.Variables.HeadshotOnly then
                Name = p1.Model.Name
                if not (u43[Name]) then
                    u43[Name] = {HasHead = p1.Model:FindFirstChild("Head")}
                end
                if u43[Name].HasHead then
                    v8 = 0
                end
            end
            local v9 = 1
            local Multipliers = Config.Multipliers
            if Multipliers and not v2 then
                if string.find(Instance.Name, "Arm") then
                    v9 = v8
                elseif string.find(Instance.Name, "Torso") then
                    v9 = v8
                elseif string.find(Instance.Name, "Leg") then
                    v9 = v8
                elseif string.find(Instance.Name, "Head") then
                    v9 = Multipliers.Head or 1
                    v7.HitHeadshot = true
                end
            end
            if Config.DamageDropoff then
                local Magnitude = roundedDistance
                if not Magnitude then
                    Magnitude = (startPos - Instance.Position).Magnitude
                end
                Damage = DamageFalloffUtil.CalculateDamageAtDistance(Config, Magnitude)
            else
                Damage = Config.Damage
            end
            local v10 = Damage * v9
            local Resistances = p1.Resistances
            if Config.DamageCalculation then
                v10 = Config.DamageCalculation(weapon, v10, p1, v9) or v10
            end
            if not Resistances then
                v4 = p4
            elseif not Config.IsMelee then
                if Config.IsMelee then
                    v4 = p4
                elseif not Resistances.Bullet then
                    v4 = p4
                else
                    v10 = v10 * Resistances.Bullet
                    if not p4 then
                        v4 = p4
                    else
                        v4 = p4 * Resistances.Bullet
                    end
                end
            elseif Resistances.Melee then
                v10 = v10 * Resistances.Melee
                if not p4 then
                    v4 = p4
                else
                    v4 = p4 * Resistances.Melee
                end
            end
            local v11 = Config.PenetrationReduction or 0.5
            local v12 = #prevHit
            if 1 <= v12 then
                v10 = v10 * (1 * v11 ^ v12)
            end
            local UID = p1.UID
            if weapon.lastZombieHit ~= UID then
                weapon.lastZombieHit = UID
                table.insert(toNetwork, UID)
            end
            if not p1.ArmorHPs then
                if p1.UIDTable and p1.UIDTable[v1] then
                    if p1.FleshShot then
                        p1:FleshShot(p2, v10)
                    end
                    v6 = true
                    if not u21 then
                        p1:ClientChangeHealth(-v10)
                    else
                        if not v4 then
                            v4 = v10
                        end
                        if v10 < v4 and v10 * 1.25 >= v4 then
                            v10 = v4
                        end
                        if shooter and u40 then
                            local PlayerState = require("@game/ReplicatedStorage/common/PlayerHandler"):GetPlayerState(shooter)
                            if v7.HitHeadshot then
                                v10 = v10 * u40.getHeadshotDamageMult(shooter)
                            end
                            if u40.hasFury(shooter) and PlayerState then
                                v5 = PlayerState.HP / PlayerState.MaxHP
                                if v5 <= 0.25 then
                                    v10 = v10 * 1.25
                                end
                            end
                            if u40.hasDeadEye(shooter) and isPlayerStationary(shooter) then
                                v10 = v10 * 1.1
                            end
                            if PlayerState and PlayerState.IsDowned then
                                PlayerState:AddSecondWindDamage(v10)
                            end
                        end
                        v3 = math.max(0.5, v4 * 0.03)
                        if shooter and p1.ReconcileDamage and v3 < math.abs(v10 - v4) then
                            p1.ReconcileDamage(shooter, v10, v1)
                        end
                        p1:ChangeHealth(-v10)
                    end
                    v3 = v10
                    if u18 then
                        v3 = v3 + 0.01
                    end
                    local v13 = string.format("%.2f", v3)
                    if p1.HP > 0 then
                        table.insert(toNetwork, "h" .. v1 .. "_" .. v13)
                    else
                        table.insert(toNetwork, "k" .. v1 .. "_" .. v13)
                        v7.Killed = true
                    end
                    v7.BloodNPC = {Config, p1.UID, v1}
                end
            elseif p1.ArmorHPs[v1] then
                local ArmorDamageReduction, Damage_2
                v3 = p1.ArmorHPs.HPDir[p1.ArmorHPs[v1][1]]
                HP = v3.HP
                if p1.ArmorShot then
                    p1:ArmorShot(p2)
                end
                v6 = true
                if not Config.UsesHP then
                    ArmorDamageReduction = Config.ArmorDamageReduction
                    if not ArmorDamageReduction then
                        ArmorDamageReduction = 0.5
                    end
                else
                    ArmorDamageReduction = 0.25
                end
                local v14 = ArmorDamageReduction ^ math.max(v3.Lvl - ((Config.Penetration or 0) - v12), 1)
                if Config.DamageDropoff then
                    local Magnitude_2 = roundedDistance
                    if not Magnitude_2 then
                        Magnitude_2 = (startPos - Instance.Position).Magnitude
                    end
                    Damage_2 = DamageFalloffUtil.CalculateDamageAtDistance(Config, Magnitude_2)
                else
                    Damage_2 = Config.Damage
                end
                v5 = Damage_2 * v14
                local ArmorResistances = p1.ArmorResistances
                if ArmorResistances then
                    if not Config.IsMelee then
                        if not Config.IsMelee and ArmorResistances.Bullet then
                            v5 = v5 * ArmorResistances.Bullet
                        end
                    elseif ArmorResistances.Melee then
                        v5 = v5 * ArmorResistances.Melee
                    end
                end
                local v15 = math.max(0, HP - v5)
                v3.HP = v15
                if v15 <= 0 then
                    if p1.ArmorBroken then
                        p1:ArmorBroken(Instance.Parent)
                        v7.BrokeArmor = true
                    end
                    for i, j in Instance.Parent:GetChildren() do
                        if j:IsA("BasePart") then
                            j.CanQuery = false
                        end
                    end
                end
                v7.HitArmor = true
                local v16 = v10
                if u18 then
                    v16 = v16 + 0.01
                end
                local v17 = string.format("%.2f", v16)
                if u18 then
                    table.insert(toNetwork, "h" .. v1 .. "_" .. v17)
                end
            end
            if v6 then
                table.insert(prevHit, Instance.Parent)
                table.insert(ignoreList, Instance.Parent)
                if u18 and not Config.IsMelee and Config.OnHit then
                    Config.OnHit(weapon, p1.Model)
                end
            end
            if p1.Shot then
                p1:Shot(p2)
            end
            p1.Model:SetAttribute("HP", p1.HP)
            return v7
        else
            v1 = p2.raycastResult.Instance:GetAttribute("uid")
        end
    end
end