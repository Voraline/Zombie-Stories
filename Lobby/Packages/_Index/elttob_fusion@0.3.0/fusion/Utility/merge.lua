local External = require(script.Parent.Parent.External)
return function(p1, p2, ...) -- Line: 13 -- upvalues: External (val)
    local v1, v2, v3
    local v4 = {...}
    if #v4 < 1 then
        return p2
    end
    local v5 = v4
    local v6 = nil
    local v7 = nil
    local v8 = p2
    for i, j in v5, v6, v7 do
        v2 = j
        v3 = nil
        v1 = nil
        for k, n in v2, v3, v1 do
            if v8[k] == nil then
                v8[k] = n
            elseif not v9 then
                External.logError("mergeConflict", nil, (tostring(k)))
            end
        end
    end
    return v8
end