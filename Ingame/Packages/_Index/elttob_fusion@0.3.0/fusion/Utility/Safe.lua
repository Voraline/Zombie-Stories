local Parent = script.Parent.Parent
return function(p1) -- Line: 13
    local result
    _, result = xpcall(p1.try, p1.fallback)
    return result
end