local u2 = require("../Shared/Util")
local u3 = {}

function u3.Validate(p1) -- Line: 4
    if p1:match("^https?://.+$") then
        return true
    end
    return false, "URLs must begin with http:// or https://"
end

function u3.Parse(p1) -- Line: 12
    return p1
end

return function(p1) -- Line: 17 -- upvalues: u3 (val), u2 (val)
    local v1 = u3
    p1:RegisterType("url", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u3
    v1 = MakeListableType(v2)
    p1:RegisterType("urls", v1)
end