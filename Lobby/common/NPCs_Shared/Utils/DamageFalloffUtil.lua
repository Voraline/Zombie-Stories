local v1 = {}

local function Lerp(p1, p2, p3) -- Line: 9
    return p1 * (1 - p3) + p2 * p3
end

function v1.CalculateDamageAtDistance(p1, p2) -- Line: 16
    local Damage_2, Damage_3, Damage_4, Damage_5, v1, v2, v3
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
            Damage_2 = j.Damage
            v1 = v7 / j.Distance
            return Damage * (1 - v1) + Damage_2 * v1
        end
        if not (v7 <= j.Distance) and i ~= #DamageDropoff then
            continue
        end
        v3 = DamageDropoff[i - 1]
        if i ~= #DamageDropoff or not (j.Distance < v7) then
            Damage_4 = v3.Damage
            Damage_5 = j.Damage
            v2 = (v7 - v3.Distance) / (j.Distance - v3.Distance)
            Damage_3 = Damage_4 * (1 - v2) + Damage_5 * v2
        else
            Damage_3 = j.Damage
            if not Damage_3 then
                Damage_4 = v3.Damage
                Damage_5 = j.Damage
                v2 = (v7 - v3.Distance) / (j.Distance - v3.Distance)
                Damage_3 = Damage_4 * (1 - v2) + Damage_5 * v2
            end
        end
        return Damage_3
    end
    return Damage
end

function v1.RescaleDropoff(p1, p2, p3) -- Line: 50
    if p1 and p2 and p2 ~= 0 then
        local v1
        local v2 = p3 / p2
        local v3 = {}
        local v4 = p1
        local v5 = nil
        local v6 = nil
        for i, j in v4, v5, v6 do
            v1 = {Distance = j.Distance, Damage = j.Damage * v2}
            v3[i] = v1
        end
        return v3
    end
    return p1
end

return v1