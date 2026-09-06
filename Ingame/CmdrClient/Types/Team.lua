local Teams = game:GetService("Teams")
local u7 = require("../Shared/Util")
local u8 = {
    Transform = function(p1) -- Line: 5 -- upvalues: u7 (val), Teams (val)
        return u7.MakeFuzzyFinder(Teams:GetTeams())(p1)
    end,
    Validate = function(p1) -- Line: 11
        local v1 = 0 < #p1
        return v1, "No team with that name could be found."
    end,
    Autocomplete = function(p1) -- Line: 15 -- upvalues: u7 (val)
        return u7.GetNames(p1)
    end,
    Parse = function(p1) -- Line: 19
        return p1[1]
    end,
}
local u13 = {
    Listable = true,
    Transform = u8.Transform,
    Validate = u8.Validate,
    Autocomplete = u8.Autocomplete,
    Parse = function(p1) -- Line: 30
        return p1[1]:GetPlayers()
    end,
}
local u18 = {
    Transform = u8.Transform,
    Validate = u8.Validate,
    Autocomplete = u8.Autocomplete,
    Parse = function(p1) -- Line: 40
        return p1[1].TeamColor
    end,
}
return function(p1) -- Line: 45 -- upvalues: u8 (val), u7 (val), u13 (val), u18 (val)
    p1:RegisterType("team", u8)
    p1:RegisterType("teams", u7.MakeListableType(u8))
    p1:RegisterType("teamPlayers", u13)
    p1:RegisterType("teamColor", u18)
    p1:RegisterType("teamColors", u7.MakeListableType(u18))
end