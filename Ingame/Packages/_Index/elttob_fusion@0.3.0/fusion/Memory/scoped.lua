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
    local v2 = setmetatable(v1, {__index = merge(false, {}, ...)})
    ExternalDebug.trackScope(v2)
    return v2
end