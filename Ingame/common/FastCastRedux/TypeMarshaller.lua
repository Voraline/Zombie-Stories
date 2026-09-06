local u0 = typeof
return function(p1) -- Line: 5 -- upvalues: u0 (val)
    local v1 = u0(p1)
    if v1 ~= "table" then
        return v1
    end
    local v2 = getmetatable(p1)
    if u0(v2) ~= "table" then
        return v1
    end
    local __type = v2.__type
    if __type == nil then
        return v1
    end
    return __type
end