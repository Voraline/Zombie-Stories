local u2 = require("../Shared/Util")
local GiftCatalog = require(game.ReplicatedStorage.common.ZS_Shared.Data.GiftCatalog)
return function(p1) -- Line: 4 -- upvalues: u2 (val), GiftCatalog (val)
    local v1 = u2
    local MakeEnumType = v1.MakeEnumType
    local v2 = GiftCatalog
    v1 = MakeEnumType("GiftKey", v2.Keys)
    p1:RegisterType("giftKey", v1)
end