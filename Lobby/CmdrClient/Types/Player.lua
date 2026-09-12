local u2 = require("../Shared/Util")
local Players = game:GetService("Players")
local u8 = {}

function u8.Transform(p1) -- Line: 5 -- upvalues: u2 (val), Players (val)
    return u2.MakeFuzzyFinder(Players:GetPlayers())(p1)
end

function u8.Validate(p1) -- Line: 11
    local v1 = 0 < #p1
    return v1, "No player with that name could be found."
end

function u8.Autocomplete(p1) -- Line: 15 -- upvalues: u2 (val)
    return u2.GetNames(p1)
end

function u8.Parse(p1) -- Line: 19
    return p1[1]
end

function u8.Default(p1) -- Line: 23
    return p1.Name
end

u8.ArgumentOperatorAliases = {me = ".", all = "*", others = "**", random = "?"}
return function(p1) -- Line: 35 -- upvalues: u8 (val), u2 (val)
    local v1 = u8
    p1:RegisterType("player", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u8
    v1 = MakeListableType(v2, {Prefixes = "% teamPlayers"})
    p1:RegisterType("players", v1)
end