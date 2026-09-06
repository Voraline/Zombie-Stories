local u0 = {}
u0.__index = u0
function u0.OnHit(p1, p2, p3, p4, p5) -- Line: 4
    if p1.onActivate then
        p1.onActivate(p2, p3, p4, p5)
    end
end
function u0.new() -- Line: 10 -- upvalues: u0 (val)
    local v1 = setmetatable({}, u0)
    v1.onActivate = nil
    return v1
end
return u0