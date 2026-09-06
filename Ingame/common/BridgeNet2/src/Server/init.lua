require("./Types")
local u5 = require("@self/PlayerContainers")
local u8 = require("@self/ServerBridge")
local u11 = require("@self/ServerIdentifiers")
local u14 = require("@self/ServerProcess")
return {
    start = function() -- Line: 10 -- upvalues: u14 (val), u11 (val)
        u14.start()
        u11.start()
    end,
    makeBridge = function(p1) -- Line: 15 -- upvalues: u8 (val)
        return u8(p1)
    end,
    ser = function(p1) -- Line: 19 -- upvalues: u11 (val)
        return u11.ser(p1)
    end,
    deser = function(p1) -- Line: 23 -- upvalues: u11 (val)
        return u11.deser(p1)
    end,
    makeIdentifier = function(p1) -- Line: 27 -- upvalues: u11 (val)
        return u11.ref(p1)
    end,
    playerContainers = function() -- Line: 31 -- upvalues: u5 (val)
        return u5
    end,
    invalidPlayerhandler = function(p1) -- Line: 35 -- upvalues: u14 (val)
        u14.setInvalidPlayerFunction(p1)
    end,
}