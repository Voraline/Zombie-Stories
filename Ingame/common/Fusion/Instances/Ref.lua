local Parent = script.Parent.Parent
require(Parent.PubTypes)
local logError = require(Parent.Logging.logError)
local xtypeof = require(Parent.Utility.xtypeof)
return {
    type = "SpecialKey",
    kind = "Ref",
    stage = "observer",
    apply = function(p1, p2, p3, p4) -- Line: 18 -- upvalues: xtypeof (val), logError (val)
        if xtypeof(p2) ~= "State" or p2.kind ~= "Value" then
            logError("invalidRefType")
            return
        end
        p2:set(p3)
        table.insert(p4, function() -- Line: 23 -- upvalues: p2 (val)
            p2:set(nil)
        end)
    end,
}