local RunService = game:GetService("RunService")
game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u18 = RunService:IsClient()
local u21 = RunService:IsServer()
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local DamageFalloffUtil = require(ReplicatedStorage.common.NPCs_Shared.Utils.DamageFalloffUtil)
local u40 = nil
if u21 then
    u40 = require(ReplicatedStorage.common.skillTree.SkillTreeData)
end
local u41 = {}

local function isPlayerStationary(p1) -- Line: 20 -- upvalues: u41 (val)
    if p1 and p1.Character then
        local v1
        local HumanoidRootPart = p1.Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart then
            return false
        end
        local Position = HumanoidRootPart.Position
        local v2 = os.clock()
        local v3 = u41[p1]
        if not v3 then
            v1 = u41
            v1[p1] = {LastPosition = Position, StationaryStartTime = v2}
            return false
        end
        v1 = 0.5 < (Position - v3.LastPosition).Magnitude
        if not v1 then
            local v4 = 1 <= v2 - v3.StationaryStartTime
            return v4
        end
        v3.LastPosition = Position
        v3.StationaryStartTime = v2
        return false
    end
    return false
end

local u43 = {}

local function calcDamageDropoff(p1, p2, p3, p4) -- Line: 48 -- upvalues: DamageFalloffUtil (val)
    if not p3.DamageDropoff then
        return p3.Damage
    end
    local Position = p2.Position
    local Magnitude = p4
    if not Magnitude then
        Magnitude = (p1 - Position).Magnitude
    end
    return DamageFalloffUtil.CalculateDamageAtDistance(p3, Magnitude)
end

local function calcArmorDamage(p1, p2, p3, p4, p5, p6) -- Line: 57 -- upvalues: DamageFalloffUtil (val)
    local ArmorDamageReduction, Damage
    local Lvl = p1.Lvl
    local HP = p1.HP
    if not p2.UsesHP then
        ArmorDamageReduction = p2.ArmorDamageReduction
        if not ArmorDamageReduction then
            ArmorDamageReduction = 0.5
        end
    else
        ArmorDamageReduction = 0.25
    end
    local v1 = Lvl - p3
    v1 = ArmorDamageReduction ^ math.max(v1, 1)
    if p2.DamageDropoff then
        local Position = p5.Position
        local Magnitude = p6
        if not Magnitude then
            Magnitude = (p4 - Position).Magnitude
        end
        Damage = DamageFalloffUtil.CalculateDamageAtDistance(p2, Magnitude)
    else
        Damage = p2.Damage
    end
    return Damage * v1
end

return function(p1, p2, p3, p4) -- Line: 70
    -- upvalues: GameState (val), u43 (val), DamageFalloffUtil (val), u18 (val), u21 (val), u40 (ref)
    -- upvalues: isPlayerStationary (val)
    if not p1._Destroyed and not table.isfrozen(p1) then
        local ArmorDamageReduction, ArmorResistances, Config, Damage, Damage_2, HP, HP_2, HP_3, Lvl, Lvl_2, Magnitude, Magnitude_2, Model, Multipliers, Name, Parent, Parent_2, Parent_3, PlayerState, Position, Position_2, Resistances, UID, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22
        local startPos = p2.startPos
        local raycastResult = p2.raycastResult
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
            local roundedDistance_2 = p2.roundedDistance
            roundedDistance = tonumber(roundedDistance_2)
        end
        local shooter = p2.shooter
        local Instance = nil
        local v23 = nil
        if not p3 then
            Instance = raycastResult.Instance
            v6 = Instance:GetAttribute("uid")
            if Instance and v6 then
                v1 = false
                Config = weapon.Config
                v2 = {}
                v3 = 1
                if GameState.Data.Variables.HeadshotOnly then
                    Name = p1.Model.Name
                    if not u43[Name] then
                        v5 = u43
                        v5[Name] = {HasHead = p1.Model:FindFirstChild("Head")}
                    end
                    if u43[Name].HasHead then
                        v3 = 0
                    end
                end
                v4 = 1
                Multipliers = Config.Multipliers
                if Multipliers and not v23 then
                    if string.find(Instance.Name, "Arm")
                        or string.find(Instance.Name, "Torso")
                        or string.find(Instance.Name, "Leg") then
                        v4 = v3
                    elseif string.find(Instance.Name, "Head") then
                        v4 = Multipliers.Head or 1
                        v2.HitHeadshot = true
                    end
                end
                if Config.DamageDropoff then
                    Position = Instance.Position
                    Magnitude = roundedDistance
                    if not Magnitude then
                        Magnitude = (startPos - Position).Magnitude
                    end
                    Damage = DamageFalloffUtil.CalculateDamageAtDistance(Config, Magnitude)
                else
                    Damage = Config.Damage
                end
                v7 = Damage * v4
                Resistances = p1.Resistances
                if Config.DamageCalculation then
                    v7 = Config.DamageCalculation(weapon, v7, p1, v4) or v7
                end
                if not Resistances then
                    v14 = p4
                elseif not Config.IsMelee then
                    if Config.IsMelee or not Resistances.Bullet then
                        v14 = p4
                    else
                        v7 = v7 * Resistances.Bullet
                        if not p4 then
                            v14 = p4
                        else
                            v14 = p4 * Resistances.Bullet
                        end
                    end
                elseif Resistances.Melee then
                    v7 = v7 * Resistances.Melee
                    if not p4 then
                        v14 = p4
                    else
                        v14 = p4 * Resistances.Melee
                    end
                elseif Config.IsMelee or not Resistances.Bullet then
                    v14 = p4
                else
                    v7 = v7 * Resistances.Bullet
                    if not p4 then
                        v14 = p4
                    else
                        v14 = p4 * Resistances.Bullet
                    end
                end
                v8 = Config.PenetrationReduction or 0.5
                v9 = #prevHit
                if 1 <= v9 then
                    v7 = v7 * (1 * v8 ^ v9)
                end
                v10 = (Config.Penetration or 0) - v9
                UID = p1.UID
                if weapon.lastZombieHit ~= UID then
                    weapon.lastZombieHit = UID
                    table.insert(toNetwork, UID)
                end
                if not p1.ArmorHPs then
                    if p1.UIDTable and p1.UIDTable[v6] then
                        if p1.FleshShot then
                            p1:FleshShot(p2, v7)
                        end
                        v1 = true
                        if not u21 then
                            v13 = -v7
                            p1:ClientChangeHealth(v13)
                        else
                            if not v14 then
                                v14 = v7
                            end
                            if v7 < v14 and not (v7 * 1.25 < v14) then
                                v7 = v14
                            end
                            if shooter and u40 then
                                PlayerState = require("@game/ReplicatedStorage/common/PlayerHandler"):GetPlayerState(shooter)
                                if v2.HitHeadshot then
                                    v7 = v7 * u40.getHeadshotDamageMult(shooter)
                                end
                                if u40.hasFury(shooter)
                                    and PlayerState
                                    and PlayerState.HP / PlayerState.MaxHP <= 0.25 then
                                    v7 = v7 * 1.25
                                end
                                if u40.hasDeadEye(shooter) and isPlayerStationary(shooter) then
                                    v7 = v7 * 1.1
                                end
                                if PlayerState and PlayerState.IsDowned then
                                    PlayerState:AddSecondWindDamage(v7)
                                end
                            end
                            v13 = v14 * 0.03
                            v11 = math.max(0.5, v13)
                            if shooter and p1.ReconcileDamage then
                                v13 = v7 - v14
                                if v11 < math.abs(v13) then
                                    p1.ReconcileDamage(shooter, v7, v6)
                                end
                            end
                            v15 = -v7
                            p1:ChangeHealth(v15)
                        end
                        v11 = v7
                        if u18 then
                            v11 = v11 + 0.01
                        end
                        v12 = string.format("%.2f", v11)
                        if not (p1.HP <= 0) then
                            v16 = "h" .. v6 .. "_" .. v12
                            table.insert(toNetwork, v16)
                        else
                            v16 = "k" .. v6 .. "_" .. v12
                            table.insert(toNetwork, v16)
                            v2.Killed = true
                        end
                        v2.BloodNPC = {Config, p1.UID, v6}
                    end
                elseif p1.ArmorHPs[v6] then
                    v11 = p1.ArmorHPs.HPDir[p1.ArmorHPs[v6][1]]
                    Lvl = v11.Lvl
                    HP = v11.HP
                    if p1.ArmorShot then
                        p1:ArmorShot(p2)
                    end
                    v1 = true
                    Lvl_2 = v11.Lvl
                    HP_2 = v11.HP
                    if not Config.UsesHP then
                        ArmorDamageReduction = Config.ArmorDamageReduction
                        if not ArmorDamageReduction then
                            ArmorDamageReduction = 0.5
                        end
                    else
                        ArmorDamageReduction = 0.25
                    end
                    v21 = Lvl_2 - v10
                    v21 = ArmorDamageReduction ^ math.max(v21, 1)
                    if Config.DamageDropoff then
                        Position_2 = Instance.Position
                        Magnitude_2 = roundedDistance
                        if not Magnitude_2 then
                            Magnitude_2 = (startPos - Position_2).Magnitude
                        end
                        Damage_2 = DamageFalloffUtil.CalculateDamageAtDistance(Config, Magnitude_2)
                    else
                        Damage_2 = Config.Damage
                    end
                    v15 = Damage_2 * v21
                    ArmorResistances = p1.ArmorResistances
                    if ArmorResistances then
                        if not Config.IsMelee then
                            if not Config.IsMelee and ArmorResistances.Bullet then
                                v15 = v15 * ArmorResistances.Bullet
                            end
                        elseif ArmorResistances.Melee then
                            v15 = v15 * ArmorResistances.Melee
                        elseif not Config.IsMelee and ArmorResistances.Bullet then
                            v15 = v15 * ArmorResistances.Bullet
                        end
                    end
                    v17 = v7 - v15
                    v20 = HP - v15
                    v18 = math.max(0, v20)
                    v11.HP = v18
                    if v18 <= 0 then
                        if p1.ArmorBroken then
                            Parent = Instance.Parent
                            p1:ArmorBroken(Parent)
                            v2.BrokeArmor = true
                        end
                        for k, n in Instance.Parent:GetChildren() do
                            if n:IsA("BasePart") then
                                n.CanQuery = false
                            end
                        end
                    end
                    v2.HitArmor = true
                    v19 = v7
                    if u18 then
                        v19 = v19 + 0.01
                    end
                    v20 = string.format("%.2f", v19)
                    if u18 then
                        v22 = "h" .. v6 .. "_" .. v20
                        table.insert(toNetwork, v22)
                    end
                elseif p1.UIDTable and p1.UIDTable[v6] then
                    if p1.FleshShot then
                        p1:FleshShot(p2, v7)
                    end
                    v1 = true
                    if not u21 then
                        v13 = -v7
                        p1:ClientChangeHealth(v13)
                    else
                        if not v14 then
                            v14 = v7
                        end
                        if v7 < v14 and not (v7 * 1.25 < v14) then
                            v7 = v14
                        end
                        if shooter and u40 then
                            PlayerState = require("@game/ReplicatedStorage/common/PlayerHandler"):GetPlayerState(shooter)
                            if v2.HitHeadshot then
                                v7 = v7 * u40.getHeadshotDamageMult(shooter)
                            end
                            if u40.hasFury(shooter)
                                and PlayerState
                                and PlayerState.HP / PlayerState.MaxHP <= 0.25 then
                                v7 = v7 * 1.25
                            end
                            if u40.hasDeadEye(shooter) and isPlayerStationary(shooter) then
                                v7 = v7 * 1.1
                            end
                            if PlayerState and PlayerState.IsDowned then
                                PlayerState:AddSecondWindDamage(v7)
                            end
                        end
                        v13 = v14 * 0.03
                        v11 = math.max(0.5, v13)
                        if shooter and p1.ReconcileDamage then
                            v13 = v7 - v14
                            if v11 < math.abs(v13) then
                                p1.ReconcileDamage(shooter, v7, v6)
                            end
                        end
                        v15 = -v7
                        p1:ChangeHealth(v15)
                    end
                    v11 = v7
                    if u18 then
                        v11 = v11 + 0.01
                    end
                    v12 = string.format("%.2f", v11)
                    if not (p1.HP <= 0) then
                        v16 = "h" .. v6 .. "_" .. v12
                        table.insert(toNetwork, v16)
                    else
                        v16 = "k" .. v6 .. "_" .. v12
                        table.insert(toNetwork, v16)
                        v2.Killed = true
                    end
                    v2.BloodNPC = {Config, p1.UID, v6}
                end
                if v1 then
                    Parent_2 = Instance.Parent
                    table.insert(prevHit, Parent_2)
                    Parent_3 = Instance.Parent
                    table.insert(ignoreList, Parent_3)
                    if u18 and not Config.IsMelee and Config.OnHit then
                        Config.OnHit(weapon, p1.Model)
                    end
                end
                if p1.Shot then
                    p1:Shot(p2)
                end
                Model = p1.Model
                HP_3 = p1.HP
                Model:SetAttribute("HP", HP_3)
                return v2
            end
            return
        end
        if p1.Model and p1.Model.Parent then
            if not p1.ArmorHPs then
                if not p1.UIDTable or not p1.UIDTable[p3] then
                    v6 = p3
                else
                    Instance = p1.UIDTable[p3]
                    v6 = p3
                end
            elseif p1.ArmorHPs[p3] then
                Instance = p1.Model[p1.ArmorHPs[p3][2]]
                v23 = true
                v6 = p3
            elseif not p1.UIDTable or not p1.UIDTable[p3] then
                v6 = p3
            else
                Instance = p1.UIDTable[p3]
                v6 = p3
            end
            if Instance and v6 then
                v1 = false
                Config = weapon.Config
                v2 = {}
                v3 = 1
                if GameState.Data.Variables.HeadshotOnly then
                    Name = p1.Model.Name
                    if not u43[Name] then
                        v5 = u43
                        v5[Name] = {HasHead = p1.Model:FindFirstChild("Head")}
                    end
                    if u43[Name].HasHead then
                        v3 = 0
                    end
                end
                v4 = 1
                Multipliers = Config.Multipliers
                if Multipliers and not v23 then
                    if string.find(Instance.Name, "Arm")
                        or string.find(Instance.Name, "Torso")
                        or string.find(Instance.Name, "Leg") then
                        v4 = v3
                    elseif string.find(Instance.Name, "Head") then
                        v4 = Multipliers.Head or 1
                        v2.HitHeadshot = true
                    end
                end
                if Config.DamageDropoff then
                    Position = Instance.Position
                    Magnitude = roundedDistance
                    if not Magnitude then
                        Magnitude = (startPos - Position).Magnitude
                    end
                    Damage = DamageFalloffUtil.CalculateDamageAtDistance(Config, Magnitude)
                else
                    Damage = Config.Damage
                end
                v7 = Damage * v4
                Resistances = p1.Resistances
                if Config.DamageCalculation then
                    v7 = Config.DamageCalculation(weapon, v7, p1, v4) or v7
                end
                if not Resistances then
                    v14 = p4
                elseif not Config.IsMelee then
                    if Config.IsMelee or not Resistances.Bullet then
                        v14 = p4
                    else
                        v7 = v7 * Resistances.Bullet
                        if not p4 then
                            v14 = p4
                        else
                            v14 = p4 * Resistances.Bullet
                        end
                    end
                elseif Resistances.Melee then
                    v7 = v7 * Resistances.Melee
                    if not p4 then
                        v14 = p4
                    else
                        v14 = p4 * Resistances.Melee
                    end
                elseif Config.IsMelee or not Resistances.Bullet then
                    v14 = p4
                else
                    v7 = v7 * Resistances.Bullet
                    if not p4 then
                        v14 = p4
                    else
                        v14 = p4 * Resistances.Bullet
                    end
                end
                v8 = Config.PenetrationReduction or 0.5
                v9 = #prevHit
                if 1 <= v9 then
                    v7 = v7 * (1 * v8 ^ v9)
                end
                v10 = (Config.Penetration or 0) - v9
                UID = p1.UID
                if weapon.lastZombieHit ~= UID then
                    weapon.lastZombieHit = UID
                    table.insert(toNetwork, UID)
                end
                if not p1.ArmorHPs then
                    if p1.UIDTable and p1.UIDTable[v6] then
                        if p1.FleshShot then
                            p1:FleshShot(p2, v7)
                        end
                        v1 = true
                        if not u21 then
                            v13 = -v7
                            p1:ClientChangeHealth(v13)
                        else
                            if not v14 then
                                v14 = v7
                            end
                            if v7 < v14 and not (v7 * 1.25 < v14) then
                                v7 = v14
                            end
                            if shooter and u40 then
                                PlayerState = require("@game/ReplicatedStorage/common/PlayerHandler"):GetPlayerState(shooter)
                                if v2.HitHeadshot then
                                    v7 = v7 * u40.getHeadshotDamageMult(shooter)
                                end
                                if u40.hasFury(shooter)
                                    and PlayerState
                                    and PlayerState.HP / PlayerState.MaxHP <= 0.25 then
                                    v7 = v7 * 1.25
                                end
                                if u40.hasDeadEye(shooter) and isPlayerStationary(shooter) then
                                    v7 = v7 * 1.1
                                end
                                if PlayerState and PlayerState.IsDowned then
                                    PlayerState:AddSecondWindDamage(v7)
                                end
                            end
                            v13 = v14 * 0.03
                            v11 = math.max(0.5, v13)
                            if shooter and p1.ReconcileDamage then
                                v13 = v7 - v14
                                if v11 < math.abs(v13) then
                                    p1.ReconcileDamage(shooter, v7, v6)
                                end
                            end
                            v15 = -v7
                            p1:ChangeHealth(v15)
                        end
                        v11 = v7
                        if u18 then
                            v11 = v11 + 0.01
                        end
                        v12 = string.format("%.2f", v11)
                        if not (p1.HP <= 0) then
                            v16 = "h" .. v6 .. "_" .. v12
                            table.insert(toNetwork, v16)
                        else
                            v16 = "k" .. v6 .. "_" .. v12
                            table.insert(toNetwork, v16)
                            v2.Killed = true
                        end
                        v2.BloodNPC = {Config, p1.UID, v6}
                    end
                elseif p1.ArmorHPs[v6] then
                    v11 = p1.ArmorHPs.HPDir[p1.ArmorHPs[v6][1]]
                    Lvl = v11.Lvl
                    HP = v11.HP
                    if p1.ArmorShot then
                        p1:ArmorShot(p2)
                    end
                    v1 = true
                    Lvl_2 = v11.Lvl
                    HP_2 = v11.HP
                    if not Config.UsesHP then
                        ArmorDamageReduction = Config.ArmorDamageReduction
                        if not ArmorDamageReduction then
                            ArmorDamageReduction = 0.5
                        end
                    else
                        ArmorDamageReduction = 0.25
                    end
                    v21 = Lvl_2 - v10
                    v21 = ArmorDamageReduction ^ math.max(v21, 1)
                    if Config.DamageDropoff then
                        Position_2 = Instance.Position
                        Magnitude_2 = roundedDistance
                        if not Magnitude_2 then
                            Magnitude_2 = (startPos - Position_2).Magnitude
                        end
                        Damage_2 = DamageFalloffUtil.CalculateDamageAtDistance(Config, Magnitude_2)
                    else
                        Damage_2 = Config.Damage
                    end
                    v15 = Damage_2 * v21
                    ArmorResistances = p1.ArmorResistances
                    if ArmorResistances then
                        if not Config.IsMelee then
                            if not Config.IsMelee and ArmorResistances.Bullet then
                                v15 = v15 * ArmorResistances.Bullet
                            end
                        elseif ArmorResistances.Melee then
                            v15 = v15 * ArmorResistances.Melee
                        elseif not Config.IsMelee and ArmorResistances.Bullet then
                            v15 = v15 * ArmorResistances.Bullet
                        end
                    end
                    v17 = v7 - v15
                    v20 = HP - v15
                    v18 = math.max(0, v20)
                    v11.HP = v18
                    if v18 <= 0 then
                        if p1.ArmorBroken then
                            Parent = Instance.Parent
                            p1:ArmorBroken(Parent)
                            v2.BrokeArmor = true
                        end
                        for i, j in Instance.Parent:GetChildren() do
                            if j:IsA("BasePart") then
                                j.CanQuery = false
                            end
                        end
                    end
                    v2.HitArmor = true
                    v19 = v7
                    if u18 then
                        v19 = v19 + 0.01
                    end
                    v20 = string.format("%.2f", v19)
                    if u18 then
                        v22 = "h" .. v6 .. "_" .. v20
                        table.insert(toNetwork, v22)
                    end
                elseif p1.UIDTable and p1.UIDTable[v6] then
                    if p1.FleshShot then
                        p1:FleshShot(p2, v7)
                    end
                    v1 = true
                    if not u21 then
                        v13 = -v7
                        p1:ClientChangeHealth(v13)
                    else
                        if not v14 then
                            v14 = v7
                        end
                        if v7 < v14 and not (v7 * 1.25 < v14) then
                            v7 = v14
                        end
                        if shooter and u40 then
                            PlayerState = require("@game/ReplicatedStorage/common/PlayerHandler"):GetPlayerState(shooter)
                            if v2.HitHeadshot then
                                v7 = v7 * u40.getHeadshotDamageMult(shooter)
                            end
                            if u40.hasFury(shooter)
                                and PlayerState
                                and PlayerState.HP / PlayerState.MaxHP <= 0.25 then
                                v7 = v7 * 1.25
                            end
                            if u40.hasDeadEye(shooter) and isPlayerStationary(shooter) then
                                v7 = v7 * 1.1
                            end
                            if PlayerState and PlayerState.IsDowned then
                                PlayerState:AddSecondWindDamage(v7)
                            end
                        end
                        v13 = v14 * 0.03
                        v11 = math.max(0.5, v13)
                        if shooter and p1.ReconcileDamage then
                            v13 = v7 - v14
                            if v11 < math.abs(v13) then
                                p1.ReconcileDamage(shooter, v7, v6)
                            end
                        end
                        v15 = -v7
                        p1:ChangeHealth(v15)
                    end
                    v11 = v7
                    if u18 then
                        v11 = v11 + 0.01
                    end
                    v12 = string.format("%.2f", v11)
                    if not (p1.HP <= 0) then
                        v16 = "h" .. v6 .. "_" .. v12
                        table.insert(toNetwork, v16)
                    else
                        v16 = "k" .. v6 .. "_" .. v12
                        table.insert(toNetwork, v16)
                        v2.Killed = true
                    end
                    v2.BloodNPC = {Config, p1.UID, v6}
                end
                if v1 then
                    Parent_2 = Instance.Parent
                    table.insert(prevHit, Parent_2)
                    Parent_3 = Instance.Parent
                    table.insert(ignoreList, Parent_3)
                    if u18 and not Config.IsMelee and Config.OnHit then
                        Config.OnHit(weapon, p1.Model)
                    end
                end
                if p1.Shot then
                    p1:Shot(p2)
                end
                Model = p1.Model
                HP_3 = p1.HP
                Model:SetAttribute("HP", HP_3)
                return v2
            end
            return
        end
        return
    end
end