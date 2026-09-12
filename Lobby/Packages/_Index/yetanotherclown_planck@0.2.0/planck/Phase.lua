local u0 = {}
u0.__index = u0

function u0.__tostring(p1) -- Line: 8
    return p1._name
end

function u0.new(p1) -- Line: 16 -- upvalues: u0 (val)
    local v1 = p1
    if not v1 then
        v1 = debug.info(2, "sl")
    end
    local v2 = {_type = "phase", _name = v1}
    local v3 = u0
    return (setmetatable(v2, v3))
end

u0.PreStartup = u0.new("PreStartup")
u0.Startup = u0.new("Startup")
u0.PostStartup = u0.new("PostStartup")
return u0