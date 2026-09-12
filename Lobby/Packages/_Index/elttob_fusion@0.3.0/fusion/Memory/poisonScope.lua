local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
return function(p1, p2) -- Line: 14 -- upvalues: External (val)
    local v1 = getmetatable(p1)
    if typeof(v1) == "table" and v1._FUSION_POISONED then
        return
    end
    table.clear(p1)
    local v2 = {
        _FUSION_POISONED = true,
        __index = function() -- Line: 25 -- upvalues: External (upval), p2 (val)
            External.logError("poisonedScope", nil, p2)
        end,
        __newindex = function() -- Line: 28 -- upvalues: External (upval), p2 (val)
            External.logError("poisonedScope", nil, p2)
        end,
    }
    setmetatable(p1, v2)
end