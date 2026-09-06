local deepCopy
local LimitedBundles = require(script.Parent.LimitedBundles)
local MonetizationCatalog = require(script.Parent.MonetizationCatalog)
local u10 = {}
local u11 = {
    DarkOps = {
        Kind = "GamePass",
        GrantKey = "DarkOps",
        Rewards = {
            ZBucks = 1500,
            Items = {
                {ItemId = "4014"},
                {ItemId = "4015"},
                {ItemId = "4016"},
                {ItemId = "1112"},
                {ItemId = "2043"},
                {ItemId = "3022"},
            },
        },
    },
    Wasteland = {
        Kind = "GamePass",
        GrantKey = "Wasteland",
        Rewards = {
            ZBucks = 2000,
            Items = {
                {ItemId = "1115"},
                {ItemId = "1116"},
                {ItemId = "4017"},
            },
        },
    },
    PinkPack = {
        Kind = "GamePass",
        GrantKey = "PinkPack",
        Rewards = {
            ZBucks = 1500,
            Items = {
                {ItemId = "1129"},
                {ItemId = "1128"},
                {ItemId = "1127"},
                {ItemId = "4019"},
                {ItemId = "4020"},
                {ItemId = "4021"},
                {ItemId = "4018"},
                {ItemId = "2053"},
                {ItemId = "3032"},
            },
        },
    },
    GhilliePack = {
        Kind = "GamePass",
        GrantKey = "GhilliePack",
        Rewards = {
            ZBucks = 2000,
            Items = {
                {ItemId = "1131"},
                {ItemId = "4023"},
            },
        },
    },
    FadeSet = {
        Kind = "GamePass",
        GrantKey = "FadeSet",
        Rewards = {
            ZBucks = 2000,
            Items = {
                {ItemId = "1235"},
                {ItemId = "1236"},
                {ItemId = "2096"},
                {ItemId = "3080"},
                {ItemId = "3081"},
            },
        },
    },
    Axiom = {
        Kind = "GamePass",
        GrantKey = "Axiom",
        Rewards = {
            ZBucks = 2000,
            Items = {
                {ItemId = "2129"},
                {ItemId = "3099"},
                {ItemId = "1295"},
            },
        },
    },
    ArcadeFounders = {
        Kind = "GamePass",
        GrantKey = "ArcadeFounders",
        Rewards = {
            ZBucks = 2000,
            Items = {
                {ItemId = "4037"},
                {ItemId = "1294"},
                {ItemId = "2128"},
                {ItemId = "3098"},
            },
        },
    },
}
local v1 = {Kind = "GamePass", GrantKey = "LMaD"}
local v2 = {ZBucks = 5000}
local v3 = {
    {ItemId = "1307", Tradable = true},
    {ItemId = "2140", Tradable = true},
    {ItemId = "3102", Tradable = true},
}
v2.Items = v3
v1.Rewards = v2
u11.LMaD = v1
function deepCopy(p1) -- Line: 116 -- upvalues: deepCopy (val)
    if typeof(p1) ~= "table" then
        return p1
    end
    local v1 = {}
    for k, v in pairs(p1) do
        v1[k] = deepCopy(v)
    end
    return v1
end
function u10.GetByKey(p1) -- Line: 128 -- upvalues: u11 (val), deepCopy (val), MonetizationCatalog (val)
    local v1 = u11[p1]
    if not v1 then
        return nil
    end
    local v2 = deepCopy(v1)
    v2.BundleKey = p1
    v2.ProductId = MonetizationCatalog.GetPass(p1)
    v2.GiftProductId = MonetizationCatalog.GetGiftProduct(p1)
    return v2
end
function u10.Get(p1) -- Line: 141 -- upvalues: u11 (val), MonetizationCatalog (val), u10 (val), LimitedBundles (val)
    local v1
    if not p1 then
        v1 = LimitedBundles.GetByProductId(p1)
        if v1 then
            v1.Kind = "DeveloperProduct"
            v1.GiftProductId = p1
            return v1
        end
        return nil
    end
    for k in pairs(u11) do
        if MonetizationCatalog.GetPass(k) == p1 then
            return u10.GetByKey(k)
        end
    end
    v1 = LimitedBundles.GetByProductId(p1)
    if not v1 then
        return nil
    end
    v1.Kind = "DeveloperProduct"
    v1.GiftProductId = p1
    return v1
end
function u10.GetAll() -- Line: 160 -- upvalues: u11 (val), u10 (val)
    local v1
    local v2 = {}
    for k in pairs(u11) do
        v1 = u10.GetByKey(k)
        if v1.ProductId then
            v2[v1.ProductId] = v1
        end
    end
    return v2
end
return u10