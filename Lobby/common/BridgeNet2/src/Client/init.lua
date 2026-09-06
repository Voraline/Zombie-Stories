local u2 = require("@self/ClientBridge")
local u5 = require("@self/ClientIdentifiers")
local u8 = require("@self/ClientProcess")
require("./Types")
return {
    start = function() -- Line: 9 -- upvalues: u8 (val), u5 (val)
        u8.start()
        u5.start()
    end,
    ser = function(p1) -- Line: 14 -- upvalues: u5 (val)
        return u5.ser(p1)
    end,
    deser = function(p1) -- Line: 18 -- upvalues: u5 (val)
        return u5.deser(p1)
    end,
    makeIdentifier = function(p1, p2) -- Line: 22 -- upvalues: u5 (val)
        return u5.ref(p1, p2)
    end,
    makeBridge = function(p1) -- Line: 26 -- upvalues: u2 (val)
        return u2(p1)
    end,
}