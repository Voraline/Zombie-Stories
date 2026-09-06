local u2 = require("../Shared/Util")
local u3 = {
    Validate = function(p1) -- Line: 4
        if p1:match("^https?://.+$") then
            return true
        end
        return false, "URLs must begin with http:// or https://"
    end,
    Parse = function(p1) -- Line: 12
        return p1
    end,
}
return function(p1) -- Line: 17 -- upvalues: u3 (val), u2 (val)
    p1:RegisterType("url", u3)
    p1:RegisterType("urls", u2.MakeListableType(u3))
end