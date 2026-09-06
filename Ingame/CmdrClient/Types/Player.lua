local u2 = require("../Shared/Util")
local Players = game:GetService("Players")
local u8 = {
    Transform = function(p1) -- Line: 5 -- upvalues: u2 (val), Players (val)
        return u2.MakeFuzzyFinder(Players:GetPlayers())(p1)
    end,
    Validate = function(p1) -- Line: 11
        local v1 = 0 < #p1
        return v1, "No player with that name could be found."
    end,
    Autocomplete = function(p1) -- Line: 15 -- upvalues: u2 (val)
        return u2.GetNames(p1)
    end,
    Parse = function(p1) -- Line: 19
        return p1[1]
    end,
    Default = function(p1) -- Line: 23
        return p1.Name
    end,
    ArgumentOperatorAliases = {me = ".", all = "*", others = "**", random = "?"},
}
return function(p1) -- Line: 35 -- upvalues: u8 (val), u2 (val)
    p1:RegisterType("player", u8)
    p1:RegisterType("players", u2.MakeListableType(u8, {Prefixes = "% teamPlayers"}))
end