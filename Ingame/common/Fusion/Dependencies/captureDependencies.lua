local Parent = script.Parent.Parent
require(Parent.PubTypes)
local parseError = require(Parent.Logging.parseError)
local sharedState = require(Parent.Dependencies.sharedState)
local initialisedStack = sharedState.initialisedStack
local u15 = 0
return function(p1, p2, ...) -- Line: 25 -- upvalues: sharedState (val), u15 (ref), initialisedStack (val), parseError (val)
    local dependencySet = sharedState.dependencySet
    sharedState.dependencySet = p1
    local v1 = sharedState
    v1.initialisedStackSize = v1.initialisedStackSize + 1
    local initialisedStackSize = sharedState.initialisedStackSize
    if not (u15 < initialisedStackSize) then
        local v2 = initialisedStack[initialisedStackSize]
        table.clear(v2)
    else
        initialisedStack[initialisedStackSize] = {}
        u15 = initialisedStackSize
    end
    local v3 = table.pack(xpcall(p2, parseError, ...))
    sharedState.dependencySet = dependencySet
    local v4 = sharedState
    v4.initialisedStackSize = v4.initialisedStackSize - 1
    local n = v3.n
    return table.unpack(v3, 1, n)
end