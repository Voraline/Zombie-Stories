local u2 = require("../Shared/Util")
return function(p1) -- Line: 3 -- upvalues: u2 (val)
    local v1 = {
        Transform = function(a1) -- Line: 5 -- upvalues: u2 (upval), p1 (val)
            return u2.MakeFuzzyFinder(p1:GetCommandNames())(a1)
        end,
    }
    function v1.Validate(p1) -- Line: 11
        local v1 = 0 < #p1
        return v1, "No command with that name could be found."
    end
    function v1.Autocomplete(p1) -- Line: 15
        return p1
    end
    function v1.Parse(p1) -- Line: 19
        return p1[1]
    end
    p1:RegisterType("command", v1)
    p1:RegisterType("commands", u2.MakeListableType(v1))
end