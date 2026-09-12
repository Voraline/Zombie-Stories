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
    if p1 ~= nil and p1 ~= "" then
        local v1, v2, v3, v4
        local v5 = tonumber(p1)
        if v5 and v5 == 0 then
            return 0, 0, true
        end
        local v6 = (p1:gsub("-?%d+%a+", "")):match("-?%d+")
        if v6 then
            return nil, (tonumber(v6)), true
        end
        local v7 = nil
        local v8 = nil
        for i in p1:gmatch("-?%d+%a+") do
            v1, v2 = i:match("(-?%d+)(%a+)")
            v8 = v1
            v4 = v2
            v1 = u21(v4)
            if #v1 == 0 then
                return nil, (tonumber(v8))
            end
            if v7 == nil then
                v7 = 0
            end
            if v4:lower() ~= "m" then
                v3 = u3[v1[1]]
            else
                v3 = 60
            end
            v7 = v7 + v3 * tonumber(v8)
        end
        if v7 == nil then
            return nil
        end
        return v7, (tonumber(v8))
    end
    return nil
end

local function mapUnits(p1, p2, p3, p4) -- Line: 58
    local v1
    local v2 = p4 or 1
    local v3 = {}
    for k, v in pairs(p1) do
        if p3 ~= 1 then
            v3[k] = p2 .. v:sub(v2)
        else
            v1 = #v - 1
            v3[k] = p2 .. v:sub(v2, v1)
        end
    end
    return v3
end

local u25 = {}

function u25.Transform(p1) -- Line: 72 -- upvalues: stringToSecondDuration (val)
    return p1, stringToSecondDuration(p1)
end

function u25.Validate(p1, p2) -- Line: 76
    local v1 = p2 ~= nil
    return v1
end

function u25.Autocomplete(p1, p2, p3, p4, p5) -- Line: 80 -- upvalues: u21 (val), mapUnits (val)
    local v1, v2
    local v3 = {}
    if not p4 and not p5 then
        if p2 ~= nil then
            v1 = p1:match("^.*-?%d+(%a+)%s?$")
            v2 = u21(v1)
            v3 = mapUnits(v2, p1, p3, #v1 + 1)
            table.sort(v3)
        end
        return v3
    end
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
end

function u25.Parse(p1, p2) -- Line: 104
    return p2
end

return function(p1) -- Line: 109 -- upvalues: u25 (val), u2 (val)
    local v1 = u25
    p1:RegisterType("duration", v1)
    v1 = u2
    local MakeListableType = v1.MakeListableType
    local v2 = u25
    v1 = MakeListableType(v2)
    p1:RegisterType("durations", v1)
end