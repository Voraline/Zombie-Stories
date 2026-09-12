require("../../Types")
local u5 = require("../../Utilities/Output")
return function(p1, ...) -- Line: 5 -- upvalues: u5 (val)
    local warnAssert = u5.warnAssert
    local v1 = select("#", ...) == 0
    warnAssert(v1, "incorrect number of arguments passed to player container")
    return {kind = "single", value = p1}
end