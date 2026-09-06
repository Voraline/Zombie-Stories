local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local change = require(Parent.Graph.change)
local isSimilar = require(Parent.Utility.isSimilar)
local never = require(Parent.Utility.never)
local nicknames = require(Parent.Utility.nicknames)
local v1 = {type = "State", kind = "Value", timeliness = "lazy", dependencySet = table.freeze({})}
local u34 = table.freeze({__index = v1})
function v1.get(p1, p2) -- Line: 60 -- upvalues: External (val), never (val)
    External.logError("stateGetWasRemoved")
    return never()
end
function v1.set(p1, p2) -- Line: 67 -- upvalues: isSimilar (val), change (val)
    if not (isSimilar(p1._EXTREMELY_DANGEROUS_usedAsValue, p2)) then
        p1._EXTREMELY_DANGEROUS_usedAsValue = p2
        change(p1)
    end
    return p2
end
function v1._evaluate(p1) -- Line: 79
    return true
end
table.freeze(v1)
return function(p1, p2) -- Line: 32 -- upvalues: External (val), u34 (val), nicknames (val)
    local v1 = os.clock()
    if p2 == nil then
        if typeof(p1) ~= "table" then
            External.logError("scopeMissing", nil, "Value", "myScope:Value(initialValue)")
        elseif p1[1] == nil and next(p1) ~= nil then
            External.logError("scopeMissing", nil, "Value", "myScope:Value(initialValue)")
        end
    end
    local u30 = setmetatable({
        validity = "valid",
        createdAt = v1,
        dependentSet = {},
        lastChange = os.clock(),
        scope = p1,
        _EXTREMELY_DANGEROUS_usedAsValue = p2,
    }, u34)
    local function v2() -- Line: 51 -- upvalues: u30 (val)
        u30.scope = nil
    end
    u30.oldestTask = v2
    nicknames[u30.oldestTask] = "Value"
    table.insert(p1, v2)
    return u30
end