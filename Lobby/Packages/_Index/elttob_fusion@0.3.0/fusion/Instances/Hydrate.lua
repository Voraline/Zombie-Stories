local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
return function(p1, p2) -- Line: 16 -- upvalues: External (val), applyInstanceProps (val)
    if p2 == nil then
        External.logError("scopeMissing", nil, "instances using Hydrate", "myScope:Hydrate (instance) { ... }")
    end
    return function(a1) -- Line: 23 -- upvalues: p1 (val), p2 (val), applyInstanceProps (upval)
        table.insert(p1, p2)
        applyInstanceProps(p1, a1, p2)
        return p2
    end
end