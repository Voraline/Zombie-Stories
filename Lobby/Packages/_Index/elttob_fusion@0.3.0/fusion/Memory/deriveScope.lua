local Parent = script.Parent.Parent
require(Parent.Types)
local ExternalDebug = require(Parent.ExternalDebug)
local deriveScopeImpl = require(Parent.Memory.deriveScopeImpl)
return function(...) -- Line: 18 -- upvalues: deriveScopeImpl (val), ExternalDebug (val)
    local v1 = deriveScopeImpl(...)
    ExternalDebug.trackScope(v1)
    return v1
end