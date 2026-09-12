local u2 = require("../Utilities/Output")
return function(p1) -- Line: 8 -- upvalues: u2 (val)
    u2.warn(string.format(
        "Player %*:%* sent an invalid packet. Likely exploiter- or something interacted with the internal BridgeNet API.",
        p1.Name,
        p1.UserId
    ))
end