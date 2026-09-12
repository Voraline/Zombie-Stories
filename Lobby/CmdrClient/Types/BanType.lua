local u2 = require("../Shared/Util")
local u3 = {"GAME", "MULTI", "TRADE", "MUTE"}
local u8 = {DisplayName = "Item name", Prefixes = ""}

function u8.Transform(p1) -- Line: 13 -- upvalues: u2 (val), u3 (val)
    return u2.MakeFuzzyFinder(u3)(p1)
end

function u8.Validate(p1) -- Line: 18
    local v1 = 0 < #p1
    return v1, "No type with that name exists."
end

function u8.Autocomplete(p1) -- Line: 22
    return p1
end

function u8.Parse(p1) -- Line: 26
    return p1[1]
end

return function(p1) -- Line: 31 -- upvalues: u8 (val)
    local v1 = u8
    p1:RegisterType("banType", v1)
end