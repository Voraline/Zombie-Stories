return {
    CanUseWithCurrentWeapon = function(p1) -- Line: 11
        if not p1 then
            return true, nil
        end
        if p1.Reloading then
            return false, "Reloading"
        end
        return true, nil
    end,
    CanUseItem = function(p1, p2) -- Line: 32
        if not p1 then
            return false, "NoItem"
        end
        if not p1.Config.IsOffHand then
            return false, "NotOffHandItem"
        end
        if p1.Config.IsTwoHandedAbility then
            return false, "TwoHandedAbility"
        end
        if p1 == p2 then
            return false, "SameAsCurrentWeapon"
        end
        if p1.Ammo and not (p1.Ammo <= 0) then
            if p1.Config.IsFullyActivated and p1.Config.IsFullyActivated(p1.Config) then
                return false, "AlreadyActivated"
            end
            return true, nil
        end
        return false, "NoAmmo"
    end,
}