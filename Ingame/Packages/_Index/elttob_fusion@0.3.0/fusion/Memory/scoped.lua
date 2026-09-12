local Parent = script.Parent.Parent
require(Parent.Types)
local ExternalDebug = require(Parent.ExternalDebug)
local merge = require(Parent.Utility.merge)
local scopePool = require(Parent.Memory.scopePool)
return function(...) -- Line: 16 -- upvalues: scopePool (val), merge (val), ExternalDebug (val)
    local v1 = scopePool.reuseAny()
    if not v1 then
        v1 = {}
    end
    local v2 = {__index = merge(false, {}, ...)}
    local v3 = setmetatable(v1, v2)
    ExternalDebug.trackScope(v3)
    return v3
end