return function(p1) -- Line: 13
    local v1
    _, v1 = xpcall(p1.try, p1.fallback)
    return v1
end