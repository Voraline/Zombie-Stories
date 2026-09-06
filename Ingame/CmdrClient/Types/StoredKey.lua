local u2 = require("../Shared/Util")
local u3 = {"^%a[%w_]*$", "^%$%a[%w_]*$", "^%.%a[%w_]*$", "^%$%.%a[%w_]*$"}
return function(p1) -- Line: 10 -- upvalues: u3 (val), u2 (val)
    local v1 = {
        Autocomplete = function(a1) -- Line: 12 -- upvalues: p1 (val)
            local Store = p1:GetStore("vars_used")
            if not Store then
                Store = {}
            end
            return p1.Cmdr.Util.MakeFuzzyFinder(p1.Cmdr.Util.DictionaryKeys(Store))(a1)
        end,
        Validate = function(p1) -- Line: 18 -- upvalues: u3 (upval)
            for i, v in ipairs(u3) do
                if p1:match(v) then
                    return true
                end
            end
            return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter."
        end,
        Parse = function(p1) -- Line: 28
            return p1
        end,
    }
    p1:RegisterType("storedKey", v1)
    p1:RegisterType("storedKeys", u2.MakeListableType(v1))
end