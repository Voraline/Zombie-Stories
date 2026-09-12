local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local evaluate = require(Parent.Graph.evaluate)
local nameOf = require(Parent.Utility.nameOf)
return function(p1, p2) -- Line: 16 -- upvalues: evaluate (val), External (val), nameOf (val)
    evaluate(p2, false)
    if table.isfrozen(p1.dependencySet) or table.isfrozen(p2.dependentSet) then
        local v1 = External
        v1.logError("cannotDepend", nil, nameOf(p1, "Dependent"), nameOf(p2, "dependency"))
    end
    p2.dependentSet[p1] = true
    p1.dependencySet[p2] = true
end