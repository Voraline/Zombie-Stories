local nicknames = require(script.Parent.Parent.Utility.nicknames)
return function(p1, p2) -- Line: 14 -- upvalues: nicknames (val)
    local v1 = nicknames[p1]
    if typeof(v1) == "string" then
        return v1
    end
    if typeof(p1) ~= "table" then
        return p2
    end
    if typeof(p1.name) == "string" then
        return p1.name
    end
    if typeof(p1.kind) == "string" then
        return p1.kind
    end
    if typeof(p1.type) == "string" then
        return p1.type
    end
    return p2
end