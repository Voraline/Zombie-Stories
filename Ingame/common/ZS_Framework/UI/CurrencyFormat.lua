local u0 = {RobuxSymbol = utf8.char(57346), ZBucksSymbol = "Z$"}
local function toNumber(p1) -- Line: 6
    if type(p1) == "string" then
        return (tonumber((string.gsub(p1, ",", ""))))
    end
    return (tonumber(p1))
end
function u0.Commas(p1) -- Line: 14
    local v1
    if type(p1) ~= "string" then
        v1 = tonumber(p1)
    else
        v1 = tonumber((string.gsub(p1, ",", "")))
    end
    local v2 = v1 or 0
    v1 = v2 < 0
    local v3 = tostring((math.floor((math.abs(v2)))))
    local v4 = string.reverse(v3)
    v4 = string.gsub(v4, "(%d%d%d)", "%1,")
    local v5 = string.reverse(v4)
    v5 = string.gsub(v5, "^,", "")
    if v1 then
        return "-" .. v5
    end
    return v5
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
        v1 = tonumber((string.gsub(p1, ",", "")))
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