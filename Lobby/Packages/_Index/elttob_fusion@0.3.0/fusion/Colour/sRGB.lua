local v1 = {}

local function transform(p1) -- Line: 18
    if 0.04045 <= p1 then
        return ((p1 + 0.055) / 1.055) ^ 2.4
    end
    return p1 / 12.92
end

local function inverse(p1) -- Line: 28
    if 0.0031308 <= p1 then
        return p1 ^ 0.4166666666666667 * 1.055 - 0.055
    end
    return p1 * 12.92
end

function v1.fromLinear(p1) -- Line: 37
    local v1, v2, v3
    local new = Color3.new
    local R = p1.R
    if not (0.04045 <= R) then
        v1 = R / 12.92
    else
        v1 = ((R + 0.055) / 1.055) ^ 2.4
    end
    local G = p1.G
    if not (0.04045 <= G) then
        v2 = G / 12.92
    else
        v2 = ((G + 0.055) / 1.055) ^ 2.4
    end
    local B = p1.B
    if not (0.04045 <= B) then
        v3 = B / 12.92
    else
        v3 = ((B + 0.055) / 1.055) ^ 2.4
    end
    return new(v1, v2, v3)
end

function v1.toLinear(p1) -- Line: 47
    local v1, v2, v3
    local new = Color3.new
    local R = p1.R
    if not (0.0031308 <= R) then
        v1 = R * 12.92
    else
        v1 = R ^ 0.4166666666666667 * 1.055 - 0.055
    end
    local G = p1.G
    if not (0.0031308 <= G) then
        v2 = G * 12.92
    else
        v2 = G ^ 0.4166666666666667 * 1.055 - 0.055
    end
    local B = p1.B
    if not (0.0031308 <= B) then
        v3 = B * 12.92
    else
        v3 = B ^ 0.4166666666666667 * 1.055 - 0.055
    end
    return new(v1, v2, v3)
end

return v1