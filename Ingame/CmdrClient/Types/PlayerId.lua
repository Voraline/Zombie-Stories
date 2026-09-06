local u2 = require("../Shared/Util")
local Players = game:GetService("Players")
local u8 = {}
local function getUserId(p1) -- Line: 5 -- upvalues: u8 (val), Players (val)
    local v1, v2
    if u8[p1] then
        return u8[p1]
    end
    if Players:FindFirstChild(p1) then
        u8[p1] = Players[p1].UserId
        return Players[p1].UserId
    end
    v1, v2 = pcall(Players.GetUserIdFromNameAsync, Players, p1)
    if not v1 then
        return nil
    end
    u8[p1] = v2
    return v2
end
local u10 = {
    DisplayName = "Full Player Name",
    Prefixes = "# integer",
    Transform = function(p1) -- Line: 27 -- upvalues: u2 (val), Players (val)
        local v1 = u2.MakeFuzzyFinder(Players:GetPlayers())
        return p1, v1(p1)
    end,
    ValidateOnce = function(p1) -- Line: 33 -- upvalues: u8 (val), Players (val)
        local UserId
        if u8[p1] then
            UserId = u8[p1]
        elseif not (Players:FindFirstChild(p1)) then
            local v1, v2
            v1, v2 = pcall(Players.GetUserIdFromNameAsync, Players, p1)
            if v1 then
                u8[p1] = v2
                UserId = v2
            else
                UserId = nil
            end
        else
            u8[p1] = Players[p1].UserId
            UserId = Players[p1].UserId
        end
        local v3 = UserId ~= nil
        return v3, "No player with that name could be found."
    end,
    Autocomplete = function(p1, p2) -- Line: 37 -- upvalues: u2 (val)
        return u2.GetNames(p2)
    end,
    Parse = function(p1) -- Line: 41 -- upvalues: u8 (val), Players (val)
        local v1, v2
        if u8[p1] then
            return u8[p1]
        end
        if Players:FindFirstChild(p1) then
            u8[p1] = Players[p1].UserId
            return Players[p1].UserId
        end
        v1, v2 = pcall(Players.GetUserIdFromNameAsync, Players, p1)
        if not v1 then
            return nil
        end
        u8[p1] = v2
        return v2
    end,
    Default = function(p1) -- Line: 45
        return p1.Name
    end,
    ArgumentOperatorAliases = {me = ".", all = "*", others = "**", random = "?"},
}
return function(p1) -- Line: 57 -- upvalues: u10 (val), u2 (val)
    p1:RegisterType("playerId", u10)
    p1:RegisterType("playerIds", u2.MakeListableType(u10, {Prefixes = "# integers"}))
end