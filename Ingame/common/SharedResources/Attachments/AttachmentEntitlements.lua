return {
    IsEntitlementGated = function(p1) -- Line: 3
        local v1 = p1.EntitlementKey ~= nil
        return v1
    end,
    HasEntitlement = function(p1, p2) -- Line: 7
        local v1
        local EntitlementKey = p2.EntitlementKey
        if EntitlementKey == nil then
            return false
        end
        local Stats = p1
        if Stats then
            Stats = p1.Stats
        end
        local UniqueAwards = Stats
        if UniqueAwards then
            UniqueAwards = Stats.UniqueAwards
        end
        if not UniqueAwards then
            v1 = false
        else
            v1 = true
            if UniqueAwards[EntitlementKey] == nil then
                v1 = false
            end
        end
        return v1
    end,
}