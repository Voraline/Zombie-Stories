local function absDist(p1) -- Line: 1
    local magnitude
    if type(p1) ~= "number" then
        magnitude = p1.magnitude
    else
        magnitude = math.abs(p1)
        if not magnitude then
            magnitude = p1.magnitude
        end
    end
    return magnitude
end

local v1 = {}
local u2 = {}
u2.__index = v1

function v1.new(p1, p2, p3, p4, p5, p6) -- Line: 10 -- upvalues: u2 (val)
    local v1 = {
        position = p1,
        velocity = p2,
        target = p3,
        stiffness = p4,
        damping = p5,
        precision = p6,
    }
    local v2 = u2
    return (setmetatable(v1, v2))
end

function v1.update(p1, p2) -- Line: 25
    local magnitude
    local v1 = p1.position - p1.target
    local v2 = -p1.stiffness * v1 + -p1.damping * p1.velocity
    local v3 = p1.velocity + v2 * p2
    local v4 = p1.position + v3
    if type(v3) ~= "number" then
        magnitude = v3.magnitude
    else
        magnitude = math.abs(v3)
        if not magnitude then
            magnitude = v3.magnitude
        end
    end
    if magnitude < p1.precision then
        local magnitude_2
        local v5 = p1.target - v4
        if type(v5) ~= "number" then
            magnitude_2 = v5.magnitude
        else
            magnitude_2 = math.abs(v5)
            if not magnitude_2 then
                magnitude_2 = v5.magnitude
            end
        end
        if magnitude_2 < p1.precision then
            p1.position = p1.target
            p1.velocity = p1.velocity - p1.velocity
            return
        end
    end
    p1.position = v4
    p1.velocity = v3
end

return v1