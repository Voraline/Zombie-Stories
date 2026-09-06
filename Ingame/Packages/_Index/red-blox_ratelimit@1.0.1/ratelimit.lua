return function(p1, p2) -- Line: 1
    local v1 = 0 < p1
    assert(v1, "Limit must be greater than 0")
    local u9 = {}
    local u10 = 0
    return function(a1) -- Line: 7 -- upvalues: u9 (val), p2 (val), p1 (val), u10 (ref)
        if not a1 then
            if u10 == 0 then
                task.delay(p2, function() -- Line: 26 -- upvalues: u10 (upval)
                    u10 = 0
                end)
            end
            if u10 == p1 then
                return false
            end
            u10 = u10 + 1
            return true
        end
        local v1 = u9[a1]
        if v1 == nil then
            v1 = 0
            task.delay(p2, function() -- Line: 14 -- upvalues: u9 (upval), a1 (val)
                u9[a1] = nil
            end)
        end
        if v1 == p1 then
            return false
        end
        u9[a1] = v1 + 1
        return true
    end
end