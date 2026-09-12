local u2 = require("../Shared/Util")
return function(p1) -- Line: 3 -- upvalues: u2 (val)
    local v1 = {
        Transform = function(p1_2) -- Line: 5 -- upvalues: u2 (upval), p1 (val)
            return u2.MakeFuzzyFinder(p1:GetTypeNames())(p1_2)
        end,
        Validate = function(p1) -- Line: 11
            local v1 = 0 < #p1
            return v1, "No type with that name could be found."
        end,
        Autocomplete = function(p1) -- Line: 15
            return p1
        end,
        Parse = function(p1) -- Line: 19
            return p1[1]
        end,
    }
    p1:RegisterType("type", v1)
    local v2 = u2
    v2 = v2.MakeListableType(v1)
    p1:RegisterType("types", v2)
end