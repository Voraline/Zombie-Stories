local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
return function(p1, p2) -- Line: 16 -- upvalues: External (val), applyInstanceProps (val)
    if p2 == nil then
        External.logError("scopeMissing", nil, "instances using Hydrate", "myScope:Hydrate (instance) { ... }")
    end
    return function(p1_2) -- Line: 23 -- upvalues: p1 (val), p2 (val), applyInstanceProps (upval)
        local v1 = p1
        local v2 = p2
        table.insert(v1, v2)
        applyInstanceProps(p1, p1_2, p2)
        return p2
    end
end