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
local u2 = {__index = v1}
function v1.new(p1, p2, p3, p4, p5, p6) -- Line: 10 -- upvalues: u2 (val)
    local v1 = {
        position = p1,
        velocity = p2,
        target = p3,
        stiffness = p4,
        damping = p5,
        precision = p6,
    }
    return (setmetatable(v1, u2))
end
function v1.update(p1, p2) -- Line: 25
    local magnitude, magnitude_2
    local v1 = p1.velocity + (-p1.stiffness * (p1.position - p1.target) + -p1.damping * p1.velocity) * p2
    local v2 = p1.position + v1
    if type(v1) ~= "number" then
        magnitude = v1.magnitude
    else
        magnitude = math.abs(v1)
    end
    if magnitude >= p1.precision then
        p1.position = v2
        p1.velocity = v1
        return
    end
    local v3 = p1.target - v2
    if type(v3) ~= "number" then
        magnitude_2 = v3.magnitude
    else
        magnitude_2 = math.abs(v3)
        if not magnitude_2 then
            magnitude_2 = v3.magnitude
        end
    end
    if magnitude_2 < p1.precision then
        p1.position = p1.target
        p1.velocity = p1.velocity - p1.velocity
        return
    end
    p1.position = v2
    p1.velocity = v1
end
return v1