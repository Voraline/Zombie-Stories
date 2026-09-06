local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local evaluate = require(Parent.Graph.evaluate)
local nameOf = require(Parent.Utility.nameOf)
return function(p1, p2) -- Line: 16 -- upvalues: evaluate (val), External (val), nameOf (val)
    local v1
    evaluate(p2, false)
    if table.isfrozen(p1.dependencySet) then
        v1 = nameOf(p1, "Dependent")
        External.logError("cannotDepend", nil, v1, nameOf(p2, "dependency"))
    elseif table.isfrozen(p2.dependentSet) then
        v1 = nameOf(p1, "Dependent")
        External.logError("cannotDepend", nil, v1, nameOf(p2, "dependency"))
    end
    p2.dependentSet[p1] = true
    p1.dependencySet[p2] = true
end