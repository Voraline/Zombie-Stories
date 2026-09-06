local v1 = {}
local function Lerp(p1, p2, p3) -- Line: 9
    return p1 * (1 - p3) + p2 * p3
end
function v1.CalculateDamageAtDistance(p1, p2) -- Line: 16
    local Damage_2, v1, v2, v3
    local Damage = p1.Damage
    local DamageDropoff = p1.DamageDropoff
    if not DamageDropoff then
        return Damage
    end
    local v4 = DamageDropoff
    local v5 = nil
    local v6 = nil
    local v7 = p2
    for i, j in v4, v5, v6 do
        if i == 1 and v7 <= j.Distance then
            v1 = v7 / j.Distance
            return Damage * (1 - v1) + j.Damage * v1
        end
        if v7 > j.Distance and i ~= #DamageDropoff then
            continue
        end
        v3 = DamageDropoff[i - 1]
        if i ~= #DamageDropoff then
            v2 = (v7 - v3.Distance) / (j.Distance - v3.Distance)
            Damage_2 = v3.Damage * (1 - v2) + j.Damage * v2
        elseif j.Distance >= v7 then
            v2 = (v7 - v3.Distance) / (j.Distance - v3.Distance)
            Damage_2 = v3.Damage * (1 - v2) + j.Damage * v2
        else
            Damage_2 = j.Damage
            if not Damage_2 then
                v2 = (v7 - v3.Distance) / (j.Distance - v3.Distance)
                Damage_2 = v3.Damage * (1 - v2) + j.Damage * v2
            end
        end
        return Damage_2
    end
    return Damage
end
function v1.RescaleDropoff(p1, p2, p3) -- Line: 50
    if not p1 or not p2 or p2 == 0 then
        return p1
    end
    local v1 = {}
    local v2 = p1
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1[i] = {Distance = j.Distance, Damage = j.Damage * (p3 / p2)}
    end
    return v1
end
return v1