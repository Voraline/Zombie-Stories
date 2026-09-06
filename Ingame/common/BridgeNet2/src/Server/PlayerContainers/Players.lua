require("../../Types")
local u5 = require("../../Utilities/Output")
return function(p1, ...) -- Line: 5 -- upvalues: u5 (val)
    local v1 = select("#", ...) == 0
    u5.warnAssert(v1, "incorrect number of arguments passed to player container")
    return {kind = "set", value = p1}
end