local u0 = {}
u0.__index = u0
function u0.new() -- Line: 4 -- upvalues: u0 (val)
    local v1 = {SpeedMult = 0, Inactive = true}
    return (setmetatable(v1, u0))
end
function u0.Apply(p1, p2, p3) -- Line: 12
    local v1 = p3 or 0
    p1.SpeedMult = v1
    local v2 = v1 == 0
    p1.Inactive = v2
end
function u0.Destroy(p1) -- Line: 18
    p1.SpeedMult = 0
    p1.Inactive = true
end
return u0