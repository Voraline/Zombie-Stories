local u0 = {}
u0.RobuxSymbol = utf8.char(57346)
u0.ZBucksSymbol = "Z$"

local function toNumber(p1) -- Line: 6
    if type(p1) ~= "string" then
        return (tonumber(p1))
    end
    local v1 = string.gsub(p1, ",", "")
    return (tonumber(v1))
end

function u0.Commas(p1) -- Line: 14
    local v1, v2
    if type(p1) ~= "string" then
        v1 = tonumber(p1)
    else
        v2 = string.gsub(p1, ",", "")
        v1 = tonumber(v2)
    end
    local v3 = v1 or 0
    v1 = v3 < 0
    local v4 = math.abs(v3)
    local v5 = math.floor(v4)
    v2 = tostring(v5)
    v5 = string.reverse(v2)
    v5 = string.gsub(v5, "(%d%d%d)", "%1,")
    v4 = string.reverse(v5)
    v4 = string.gsub(v4, "^,", "")
    if v1 then
        return "-" .. v4
    end
    return v4
end

function u0.RobuxPending() -- Line: 25 -- upvalues: u0 (val)
    return u0.RobuxSymbol .. " --"
end

function u0.Robux(p1) -- Line: 29 -- upvalues: u0 (val)
    local v1
    if p1 == nil then
        return u0.RobuxPending()
    end
    if type(p1) ~= "string" then
        v1 = tonumber(p1)
    else
        local v2 = string.gsub(p1, ",", "")
        v1 = tonumber(v2)
    end
    if v1 == nil then
        return string.upper((tostring(p1)))
    end
    return u0.RobuxSymbol .. " " .. u0.Commas(p1)
end

function u0.NormalizeRobuxText(p1) -- Line: 41 -- upvalues: u0 (val)
    if type(p1) == "number" then
        return u0.Robux(p1)
    end
    local v1 = tostring(p1)
    local v2 = string.upper(v1)
    local v3 = string.match(v2, "^%s*R%$%s*(-?[%d,]+)%s*$")
    if not v3 then
        v3 = string.match(v2, "^%s*(-?[%d,]+)%s+R%$%s*$")
        if not v3 then
            v3 = string.match(v2, "^%s*(-?[%d,]+)%s+ROBUX%s*$")
        end
    end
    if v3 then
        return u0.Robux(v3)
    end
    return v2
end

return u0