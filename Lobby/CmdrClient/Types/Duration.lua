local u2 = require("../Shared/Util")
local u3 = {
    Years = 31556926,
    Months = 2629744,
    Weeks = 604800,
    Days = 86400,
    Hours = 3600,
    Minutes = 60,
    Seconds = 1,
}
local v1 = {}
for k, v in pairs(u3) do
    table.insert(v1, k)
end
local u21 = u2.MakeFuzzyFinder(v1)
local function stringToSecondDuration(p1) -- Line: 19 -- upvalues: u21 (val), u3 (val)
    if p1 == nil then
        return nil
    else
        if p1 == "" then
            return nil
        end
        local v1 = tonumber(p1)
        if not v1 then
            local v2, v3, v4, v5, v6
            local v7 = p1:gsub("-?%d+%a+", "")
            local v8 = v7:match("-?%d+")
            if v8 then
                v5 = tonumber(v8)
                return nil, v5, true
            end
            local v9 = nil
            v5 = nil
            for i in p1:gmatch("-?%d+%a+") do
                v2, v3 = i:match("(-?%d+)(%a+)")
                v5 = v2
                v6 = v3
                v2 = u21(v6)
                if #v2 == 0 then
                    return nil, (tonumber(v5))
                end
                if v9 == nil then
                    v9 = 0
                end
                if v6:lower() ~= "m" then
                    v4 = u3[v2[1]]
                else
                    v4 = 60
                end
                v9 = v9 + v4 * tonumber(v5)
            end
            if v9 == nil then
                return nil
            end
            return v9, (tonumber(v5))
        elseif v1 == 0 then
            return 0, 0, true
        end
    end
end
local function mapUnits(p1, p2, p3, p4) -- Line: 58
    local v1 = p4 or 1
    local v2 = {}
    for k, v in pairs(p1) do
        if p3 ~= 1 then
            v2[k] = p2 .. v:sub(v1)
        else
            v2[k] = p2 .. v:sub(v1, #v - 1)
        end
    end
    return v2
end
local u25 = {
    Transform = function(p1) -- Line: 72 -- upvalues: stringToSecondDuration (val)
        return p1, stringToSecondDuration(p1)
    end,
    Validate = function(p1, p2) -- Line: 76
        local v1 = p2 ~= nil
        return v1
    end,
    Autocomplete = function(p1, p2, p3, p4, p5) -- Line: 80 -- upvalues: u21 (val), mapUnits (val)
        local v1, v2
        local v3 = {}
        if p4 then
            if p4 ~= true then
                v1 = p5
            else
                v1 = u21("")
                if not v1 then
                    v1 = p5
                end
            end
            if p4 == true then
                return (mapUnits(v1, p1, p3))
            end
            v2 = p1:match("^.*(%a+)$"):len()
            return (mapUnits(v1, p1, v2 + 1))
        elseif not p5 then
            if p2 ~= nil then
                v1 = p1:match("^.*-?%d+(%a+)%s?$")
                v2 = u21(v1)
                v3 = mapUnits(v2, p1, p3, #v1 + 1)
                table.sort(v3)
            end
            return v3
        end
    end,
    Parse = function(p1, p2) -- Line: 104
        return p2
    end,
}
return function(p1) -- Line: 109 -- upvalues: u25 (val), u2 (val)
    p1:RegisterType("duration", u25)
    p1:RegisterType("durations", u2.MakeListableType(u25))
end