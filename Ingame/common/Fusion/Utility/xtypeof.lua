return function(p1) -- Line: 9
    local v1 = typeof(p1)
    if v1 == "table" then
        local type = p1.type
        if typeof(type) == "string" then
            return p1.type
        end
    end
    return v1
end