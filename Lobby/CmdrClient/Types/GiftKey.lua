local u2 = require("../Shared/Util")
local GiftCatalog = require(game.ReplicatedStorage.common.ZS_Shared.Data.GiftCatalog)
return function(p1) -- Line: 4 -- upvalues: u2 (val), GiftCatalog (val)
    p1:RegisterType("giftKey", u2.MakeEnumType("GiftKey", GiftCatalog.Keys))
end