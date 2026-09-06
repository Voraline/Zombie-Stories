local Parent = script.Parent.Parent
require(Parent.Types)
local ExternalDebug = require(Parent.ExternalDebug)
local deriveScopeImpl = require(Parent.Memory.deriveScopeImpl)
return function(p1, ...) -- Line: 15 -- upvalues: deriveScopeImpl (val), ExternalDebug (val)
    local u4 = deriveScopeImpl(p1, ...)
    table.insert(p1, u4)
    table.insert(u4, function() -- Line: 23 -- upvalues: p1 (val), u4 (val)
        local v1 = table.find(p1, u4)
        if v1 ~= nil then
            table.remove(p1, v1)
        end
    end)
    ExternalDebug.trackScope(u4)
    return u4
end