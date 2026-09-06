local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local doCleanup = require(Parent.Memory.doCleanup)
return function(p1) -- Line: 11 -- upvalues: External (val), doCleanup (val)
    External.logWarn("cleanupWasRenamed")
    return doCleanup(p1)
end