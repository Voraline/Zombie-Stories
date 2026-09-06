return {
    CustomEquip = function(p1, p2, p3) -- Line: 14
        local v1
        local StoredAmmo = p3.StoredAmmo
        if StoredAmmo >= 7 then
            for k, v in pairs(p2.Weapon.Shells:GetChildren()) do
                v.Transparency = 0
            end
            return
        end
        for k2, i in pairs(p2.Weapon.Shells:GetChildren()) do
            i.Transparency = 1
        end
        local v2 = math.min(StoredAmmo, 7)
        local v3 = 1
        for j = 1, v2, v3 do
            v1 = p2.Weapon.Shells["Shell" .. j]
            v1.Transparency = 0
        end
    end,
    AmmoUpdated = function(p1, p2) -- Line: 30
        local v1
        local StoredAmmo = p1.StoredAmmo
        if StoredAmmo >= 7 then
            for k, v in pairs(p2.Weapon.Shells:GetChildren()) do
                v.Transparency = 0
            end
            return
        end
        for k2, i in pairs(p2.Weapon.Shells:GetChildren()) do
            i.Transparency = 1
        end
        local v2 = math.min(StoredAmmo, 7)
        local v3 = 1
        for j = 1, v2, v3 do
            v1 = p2.Weapon.Shells["Shell" .. j]
            v1.Transparency = 0
        end
    end,
    CustomKF = function(p1, p2, p3) -- Line: 46
        local v1
        local StoredAmmo = p3.StoredAmmo
        if p1 ~= "insert" then
            return
        end
        if StoredAmmo >= 7 then
            for k, v in pairs(p2.Weapon.Shells:GetChildren()) do
                v.Transparency = 0
            end
            return
        end
        for k2, i in pairs(p2.Weapon.Shells:GetChildren()) do
            i.Transparency = 1
        end
        local v2 = math.min(StoredAmmo, 7)
        local v3 = 1
        for j = 1, v2, v3 do
            v1 = p2.Weapon.Shells["Shell" .. j]
            v1.Transparency = 0
        end
    end,
}