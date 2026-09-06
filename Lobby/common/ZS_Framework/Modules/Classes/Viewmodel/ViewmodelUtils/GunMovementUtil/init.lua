local v1 = {}
local inertia = require(script:WaitForChild("inertia"))
local directional = require(script:WaitForChild("directional"))
function v1.Update(p1, p2, p3) -- Line: 6 -- upvalues: directional (val), inertia (val)
    local v1, v2
    directional.Update(p2)
    v1, v2 = inertia.Update(p2, p3)
    return v1, v2
end
return v1