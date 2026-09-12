local Teams = game:GetService("Teams")
local u7 = require("../Shared/Util")
local u8 = {}

function u8.Transform(p1) -- Line: 5 -- upvalues: u7 (val), Teams (val)
    return u7.MakeFuzzyFinder(Teams:GetTeams())(p1)
end

function u8.Validate(p1) -- Line: 11
    local v1 = 0 < #p1
    return v1, "No team with that name could be found."
end

function u8.Autocomplete(p1) -- Line: 15 -- upvalues: u7 (val)
    return u7.GetNames(p1)
end

function u8.Parse(p1) -- Line: 19
    return p1[1]
end

local u13 = {Listable = true}
u13.Transform = u8.Transform
u13.Validate = u8.Validate
u13.Autocomplete = u8.Autocomplete

function u13.Parse(p1) -- Line: 30
    return p1[1]:GetPlayers()
end

local u18 = {}
u18.Transform = u8.Transform
u18.Validate = u8.Validate
u18.Autocomplete = u8.Autocomplete

function u18.Parse(p1) -- Line: 40
    return p1[1].TeamColor
end

return function(p1) -- Line: 45 -- upvalues: u8 (val), u7 (val), u13 (val), u18 (val)
    local v1 = u8
    p1:RegisterType("team", v1)
    v1 = u7
    local MakeListableType = v1.MakeListableType
    local v2 = u8
    v1 = MakeListableType(v2)
    p1:RegisterType("teams", v1)
    v1 = u13
    p1:RegisterType("teamPlayers", v1)
    v1 = u18
    p1:RegisterType("teamColor", v1)
    v1 = u7
    local MakeListableType_2 = v1.MakeListableType
    v2 = u18
    v1 = MakeListableType_2(v2)
    p1:RegisterType("teamColors", v1)
end