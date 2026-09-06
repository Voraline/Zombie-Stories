local u2 = require("../Shared/Util")
local u3 = {"Primary", "Secondary"}
local u6 = {
    DisplayName = "Gun slot",
    Prefixes = "",
    Transform = function(p1) -- Line: 11 -- upvalues: u2 (val), u3 (val)
        return u2.MakeFuzzyFinder(u3)(p1)
    end,
    Validate = function(p1) -- Line: 16
        local v1 = 0 < #p1
        return v1, "No slot with that name exists."
    end,
    Autocomplete = function(p1) -- Line: 20
        return p1
    end,
    Parse = function(p1) -- Line: 24
        return p1[1]
    end,
}
return function(p1) -- Line: 29 -- upvalues: u6 (val)
    p1:RegisterType("gunSlot", u6)
end