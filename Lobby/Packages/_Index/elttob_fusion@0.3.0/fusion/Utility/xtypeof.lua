return function(p1) -- Line: 12
    local v1 = typeof(p1)
    if v1 ~= "table" then
        return v1
    end
    if typeof(p1.type) == "string" then
        return p1.type
    end
    return v1
end