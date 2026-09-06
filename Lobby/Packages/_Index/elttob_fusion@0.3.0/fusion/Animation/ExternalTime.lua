local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local change = require(Parent.Graph.change)
local nicknames = require(Parent.Utility.nicknames)
local u17 = {
    type = "State",
    kind = "ExternalTime",
    timeliness = "lazy",
    dependencySet = table.freeze({}),
    _EXTREMELY_DANGEROUS_usedAsValue = External.lastUpdateStep(),
}
local u28 = table.freeze({__index = u17})
local u29 = {}
function u17._evaluate(p1) -- Line: 61
    return true
end
External.bindToUpdateStep(function(p1) -- Line: 72 -- upvalues: u17 (val), External (val), u29 (val), change (val)
    u17._EXTREMELY_DANGEROUS_usedAsValue = External.lastUpdateStep()
    local v1 = u29
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        change(j)
    end
end)
return function(p1) -- Line: 33 -- upvalues: u28 (val), u29 (val), nicknames (val)
    local u7 = setmetatable({validity = "invalid", createdAt = os.clock(), dependentSet = {}, scope = p1}, u28)
    local function v1() -- Line: 47 -- upvalues: u7 (val), u29 (upval)
        u7.scope = nil
        local v1 = table.find(u29, u7)
        if v1 ~= nil then
            table.remove(u29, v1)
        end
    end
    u7.oldestTask = v1
    nicknames[u7.oldestTask] = "ExternalTime"
    table.insert(p1, v1)
    table.insert(u29, u7)
    return u7
end