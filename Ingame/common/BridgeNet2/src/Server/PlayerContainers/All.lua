require("../../Types")
local u5 = require("../../Utilities/Output")
local u6 = {kind = "all"}
table.freeze(u6)
return function(...) -- Line: 10 -- upvalues: u5 (val), u6 (val)
    local warnAssert = u5.warnAssert
    local v1 = select("#", ...) == 0
    warnAssert(v1, "incorrect number of arguments passed to player container")
    return u6
end