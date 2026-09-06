return function(p1, p2) -- Line: 7
    if typeof(p1) == "table" then
        return false
    end
    local v1 = p1 == p2
    return v1
end