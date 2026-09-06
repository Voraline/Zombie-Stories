local Parent = script.Parent.Parent
require(Parent.Types)
local merge = require(Parent.Utility.merge)
local scopePool = require(Parent.Memory.scopePool)
return function(p1, p2, ...) -- Line: 20 -- upvalues: merge (val), scopePool (val)
    local v1 = getmetatable(p1)
    if p2 ~= nil then
        v1 = table.clone(v1)
        v1.__index = merge(true, {}, v1.__index, merge(false, {}, p2, ...))
    end
    local v2 = scopePool.reuseAny()
    if not v2 then
        v2 = {}
    end
    return (setmetatable(v2, v1))
end