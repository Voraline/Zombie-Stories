return function(p1) -- Line: 2
    local v1 = newproxy(true)
    local v2 = getmetatable(v1)

    function v2.__tostring() -- Line: 5 -- upvalues: p1 (val)
        return p1
    end

    return v1
end