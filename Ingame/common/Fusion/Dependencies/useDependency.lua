local Parent = script.Parent.Parent
require(Parent.PubTypes)
local sharedState = require(Parent.Dependencies.sharedState)
local initialisedStack = sharedState.initialisedStack
return function(p1) -- Line: 14 -- upvalues: sharedState (val), initialisedStack (val)
    local dependencySet = sharedState.dependencySet
    if dependencySet == nil then
        return
    end
    local initialisedStackSize = sharedState.initialisedStackSize
    if 0 >= initialisedStackSize then
        dependencySet[p1] = true
        return
    end
    if initialisedStack[initialisedStackSize][p1] ~= nil then
        return
    end
    dependencySet[p1] = true
end