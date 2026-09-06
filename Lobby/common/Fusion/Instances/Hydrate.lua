local Parent = script.Parent.Parent
require(Parent.PubTypes)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
return function(p1) -- Line: 12 -- upvalues: applyInstanceProps (val)
    return function(a1) -- Line: 13 -- upvalues: applyInstanceProps (upval), p1 (val)
        applyInstanceProps(a1, p1)
        return p1
    end
end