local Parent = script.Parent.Parent
require(Parent.Types)
local castToState = require(Parent.State.castToState)
local evaluate = require(Parent.Graph.evaluate)
return function(p1) -- Line: 19 -- upvalues: castToState (val), evaluate (val)
    local v1 = castToState(p1)
    if v1 == nil then
        return p1
    end
    evaluate(v1, false)
    return v1._EXTREMELY_DANGEROUS_usedAsValue
end