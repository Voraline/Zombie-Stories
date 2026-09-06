return function(p1, p2) -- Line: 13
    local v1
    local v2 = typeof(p1)
    local v3 = v2 == "table"
    local v4 = v2 == "userdata"
    if v3 then
        if v2 ~= typeof(p2) then
            return false
        end
        if v4 or table.isfrozen(p1) then
            v1 = p1 == p2
            return v1
        end
        if getmetatable(p1) == nil then
            return false
        end
        v1 = p1 == p2
        return v1
    elseif not v4 then
        v1 = true
        if p1 == p2 then
            return v1
        end
        v1 = false
        if p1 == p1 then
            return v1
        end
        v1 = p2 ~= p2
        return v1
    end
end