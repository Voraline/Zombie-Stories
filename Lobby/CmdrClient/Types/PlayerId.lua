local u2 = require("../Shared/Util")
local Players = game:GetService("Players")
local u8 = {}

local function getUserId(p1) -- Line: 5 -- upvalues: u8 (val), Players (val)
    if u8[p1] then
        return u8[p1]
    end
    if Players:FindFirstChild(p1) then
        u8[p1] = Players[p1].UserId
        return Players[p1].UserId
    end
    local success, result = pcall(Players.GetUserIdFromNameAsync, Players, p1)
    if not success then
        return nil
    end
    u8[p1] = result
    return result
end

local u10 = {DisplayName = "Full Player Name", Prefixes = "# integer"}

function u10.Transform(p1) -- Line: 27 -- upvalues: u2 (val), Players (val)
    local v1 = u2.MakeFuzzyFinder(Players:GetPlayers())
    return p1, v1(p1)
end

function u10.ValidateOnce(p1) -- Line: 33 -- upvalues: u8 (val), Players (val)
    local UserId
    if u8[p1] then
        UserId = u8[p1]
    elseif not Players:FindFirstChild(p1) then
        local success, result = pcall(Players.GetUserIdFromNameAsync, Players, p1)
        if success then
            u8[p1] = result
            UserId = result
        else
            UserId = nil
        end
    else
        u8[p1] = Players[p1].UserId
        UserId = Players[p1].UserId
    end
    local v1 = UserId ~= nil
    return v1, "No player with that name could be found."
end

function u10.Autocomplete(p1, p2) -- Line: 37 -- upvalues: u2 (val)
    return u2.GetNames(p2)
end

function u10.Parse(p1) -- Line: 41 -- upvalues: u8 (val), Players (val)
    if u8[p1] then
        return u8[p1]
    end
    if Players:FindFirstChild(p1) then
        u8[p1] = Players[p1].UserId
        return Players[p1].UserId
    end
    local success, result = pcall(Players.GetUserIdFromNameAsync, Players, p1)
    if not success then
        return nil
    end
    u8[p1] = result
    return result
end

function u10.Default(p1) -- Line: 45
    return p1.Name
end

u10.ArgumentOperatorAliases = {me = ".", all = "*", others = "**", random = "?"}
return function(p1) -- Line: 57 -- upvalues: u10 (val), u2 (val)
    local v1 = u10
    p1:RegisterType("playerId", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u10
    v1 = MakeListableType(v2, {Prefixes = "# integers"})
    p1:RegisterType("playerIds", v1)
end