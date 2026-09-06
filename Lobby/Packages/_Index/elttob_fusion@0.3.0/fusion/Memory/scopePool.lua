local Parent = script.Parent.Parent
require(Parent.Types)
local poisonScope = require(Parent.Memory.poisonScope)
local ExternalDebug = require(Parent.ExternalDebug)
local u13 = {}
local u14 = 0
return {
    giveIfEmpty = function(p1) -- Line: 18 -- upvalues: ExternalDebug (val), poisonScope (val)
        if next(p1) ~= nil then
            return p1
        end
        ExternalDebug.untrackScope(p1)
        poisonScope(p1, "previously passed to the internal scope pool, which indicates a Fusion bug.")
        return nil
    end,
    clearAndGive = function(p1) -- Line: 34 -- upvalues: ExternalDebug (val), poisonScope (val)
        ExternalDebug.untrackScope(p1)
        table.clear(p1)
        poisonScope(p1, "previously passed to the internal scope pool, which indicates a Fusion bug.")
    end,
    reuseAny = function() -- Line: 46 -- upvalues: u14 (ref), u13 (val)
        if u14 == 0 then
            return nil
        end
        local v1 = u13[u14]
        u14 = u14 - 1
        return v1
    end,
}