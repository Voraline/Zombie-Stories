local Parent_2 = script.Parent.Parent
local nicknames = require(Parent_2.Utility.nicknames)
return function(p1, p2) -- Line: 14 -- upvalues: nicknames (val)
    local v1 = nicknames[p1]
    if typeof(v1) == "string" then
        return v1
    end
    if typeof(p1) == "table" then
        local name = p1.name
        if typeof(name) == "string" then
            return p1.name
        end
        local kind = p1.kind
        if typeof(kind) == "string" then
            return p1.kind
        end
        local type = p1.type
        if typeof(type) == "string" then
            return p1.type
        end
    end
    return p2
end