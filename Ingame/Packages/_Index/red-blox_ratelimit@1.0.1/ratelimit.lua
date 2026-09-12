return function(p1, p2) -- Line: 1
    local v1 = 0 < p1
    assert(v1, "Limit must be greater than 0")
    local u9 = {}
    local u10 = 0
    return function(p1_2) -- Line: 7 -- upvalues: u9 (val), p2 (val), p1 (val), u10 (ref)
        if not p1_2 then
            if u10 == 0 then
                local delay_2 = task.delay
                local v1 = p2
                delay_2(v1, function() -- Line: 26 -- upvalues: u10 (upval)
                    u10 = 0
                end)
            end
            if u10 == p1 then
                return false
            end
            u10 = u10 + 1
            return true
        end
        local v2 = u9[p1_2]
        if v2 == nil then
            v2 = 0
            local delay = task.delay
            local v3 = p2
            delay(v3, function() -- Line: 14 -- upvalues: u9 (upval), p1_2 (val)
                u9[p1_2] = nil
            end)
        end
        if v2 == p1 then
            return false
        end
        u9[p1_2] = v2 + 1
        return true
    end
end