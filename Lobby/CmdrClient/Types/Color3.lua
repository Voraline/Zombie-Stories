local u2 = require("../Shared/Util")
local u8 = u2.MakeSequenceType({
    Prefixes = "# hexColor3 ! brickColor3",
    Length = 3,
    ValidateEach = function(p1, p2) -- Line: 5
        if p1 == nil then
            return false, ("Invalid or missing number at position %d in Color3 type."):format(p2)
        end
        if p1 < 0 or 255 < p1 then
            return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(p2)
        end
        if p1 % 1 ~= 0 then
            return false, ("Number is not an integer at position %d in Color3 type."):format(p2)
        end
        return true
    end,
    TransformEach = tonumber,
    Constructor = Color3.fromRGB,
})
local function parseHexDigit(p1) -- Line: 21
    local v1
    if #p1 ~= 1 then
        v1 = p1
    else
        v1 = p1 .. p1
    end
    return (tonumber(v1, 16))
end
local u10 = {
    Transform = function(p1) -- Line: 30 -- upvalues: u2 (val), parseHexDigit (val)
        local v1, v2, v3
        v1, v2, v3 = p1:match("^#?(%x%x?)(%x%x?)(%x%x?)$")
        return u2.Each(parseHexDigit, v1, v2, v3)
    end,
    Validate = function(p1, p2, p3) -- Line: 35
        local v1 = if p1 ~= nil then if p2 ~= nil then p3 ~= nil else false else false
        return v1, "Invalid hex color"
    end,
    Parse = function(...) -- Line: 39
        return Color3.fromRGB(...)
    end,
}
return function(p1) -- Line: 44 -- upvalues: u8 (val), u2 (val), u10 (val)
    p1:RegisterType("color3", u8)
    p1:RegisterType("color3s", u2.MakeListableType(u8, {Prefixes = "# hexColor3s ! brickColor3s"}))
    p1:RegisterType("hexColor3", u10)
    p1:RegisterType("hexColor3s", u2.MakeListableType(u10))
end