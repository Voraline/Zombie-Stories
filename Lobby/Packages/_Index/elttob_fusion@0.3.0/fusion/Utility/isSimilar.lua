return function(p1, p2) -- Line: 13
    local v1
    local v2 = typeof(p1)
    local v3 = v2 == "table"
    local v4 = v2 == "userdata"
    if not v3 and not v4 then
        v1 = true
        if p1 ~= p2 then
            v1 = false
            if p1 ~= p1 then
                v1 = p2 ~= p2
                return v1
            end
        end
        return v1
    end
    if v2 ~= typeof(p2) then
        v1 = false
        return v1
    end
    if not v4 and not table.isfrozen(p1) and getmetatable(p1) == nil then
        v1 = false
        return v1
    end
    v1 = p1 == p2
    return v1
end