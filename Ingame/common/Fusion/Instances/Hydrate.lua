local Parent = script.Parent.Parent
require(Parent.PubTypes)
local applyInstanceProps = require(Parent.Instances.applyInstanceProps)
return function(p1) -- Line: 12 -- upvalues: applyInstanceProps (val)
    return function(p1_2) -- Line: 13 -- upvalues: applyInstanceProps (upval), p1 (val)
        applyInstanceProps(p1_2, p1)
        return p1
    end
end