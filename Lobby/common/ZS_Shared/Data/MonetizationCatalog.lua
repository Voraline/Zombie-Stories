local u0 = {}
local RunService = game:GetService("RunService")
u0.UniverseIds = {Live = 653118530, Testing = 1970013852}
local u7 = {}
local Live = u0.UniverseIds.Live
u7[Live] = {
    Name = "Live",
    Passes = {
        Axiom = 1337735330,
        ArcadeFounders = 1338148424,
        DarkOps = 10505027,
        FadeSet = 923697735,
        GhilliePack = 12064516,
        LMaD = 1477676640,
        NightVision = 10504943,
        PinkPack = 12075296,
        RevivePlus = 10504574,
        Wasteland = 10767569,
    },
    LegacyPasses = {
        NightVision = {6885070},
        RevivePlus = {6934680},
    },
    Products = {
        CyberpunkCrate = 3711039941,
        CyberpunkCrate5 = 3711040090,
        MinigunAllPlayers = 2368201611,
        Revive1 = 972288148,
        Revive3 = 1186217412,
        StarterPack = 1006869536,
        Unban = 1273018317,
        ZBucks1000 = 976830607,
        ZBucks3300 = 976830756,
        ZBucks9200 = 976830945,
        ZBucks24000 = 976831019,
        ZBucks58500 = 976831165,
    },
    GiftProducts = {
        Axiom = 3711505124,
        DarkOps = 3711505292,
        FadeSet = 3711505092,
        GhilliePack = 3711505194,
        NightVision = 3711505341,
        PinkPack = 3711505159,
        RevivePlus = 3711505381,
        Wasteland = 3711505249,
    },
    LimitedBundleProducts = {
        ColonialWinchester = 3462043569,
        DesolateGaze = 3491113031,
        FrontierMinuteman = 3462423506,
        Liberator = 3610114698,
        Umbra = 3711459053,
    },
}
local Testing = u0.UniverseIds.Testing
u7[Testing] = {
    Name = "Testing",
    Passes = {
        Axiom = 1966213229,
        DarkOps = 1966195241,
        FadeSet = 927035837,
        GhilliePack = 1965799254,
        NightVision = 1963285585,
        PinkPack = 1961821585,
        RevivePlus = 1965967284,
        Wasteland = 1962289539,
    },
    LegacyPasses = {},
    Products = {
        CyberpunkCrate = 3711039893,
        CyberpunkCrate5 = 3711040146,
        MinigunAllPlayers = 2320543108,
        Revive1 = 3710670561,
        Revive3 = 3710670454,
        StarterPack = 3710670469,
        ZBucks1000 = 3710670538,
        ZBucks3300 = 3710670526,
        ZBucks9200 = 3710670515,
        ZBucks24000 = 3710670503,
        ZBucks58500 = 3710670491,
    },
    GiftProducts = {
        Axiom = 3710670818,
        DarkOps = 3710670909,
        FadeSet = 3710670793,
        GhilliePack = 3710670873,
        NightVision = 3710670921,
        PinkPack = 3710670849,
        RevivePlus = 3710670932,
        Wasteland = 3710670890,
    },
    LimitedBundleProducts = {Umbra = 3711363599},
}
local u30 = u7[game.GameId]

local function get(p1, p2) -- Line: 109 -- upvalues: u30 (val)
    local v1
    local v2 = u30
    if v2 then
        v2 = u30[p1]
    end
    if not v2 then
        v1 = nil
    else
        v1 = v2[p2]
        if not v1 then
            v1 = nil
        end
    end
    return v1
end

function u0.GetEnvironmentName() -- Line: 114 -- upvalues: u30 (val)
    local Name
    if not u30 then
        Name = "Unsupported"
    else
        Name = u30.Name
        if not Name then
            Name = "Unsupported"
        end
    end
    return Name
end

function u0.IsSupportedUniverse() -- Line: 118 -- upvalues: u30 (val)
    local v1 = u30 ~= nil
    return v1
end

function u0.GetPass(p1) -- Line: 122 -- upvalues: u30 (val)
    local v1
    local Passes = u30
    if Passes then
        Passes = u30.Passes
    end
    if not Passes then
        v1 = nil
    else
        v1 = Passes[p1]
        if not v1 then
            v1 = nil
        end
    end
    return v1
end

function u0.GetPassIds(p1) -- Line: 126 -- upvalues: u0 (val), u30 (val)
    local v1
    local v2 = {}
    local v3 = u0.GetPass(p1)
    if v3 then
        table.insert(v2, v3)
    end
    local v4 = ipairs
    local LegacyPasses = u30
    if LegacyPasses then
        LegacyPasses = u30.LegacyPasses
    end
    if not LegacyPasses then
        v1 = nil
    else
        v1 = LegacyPasses[p1]
        if not v1 then
            v1 = nil
        end
    end
    if not v1 then
        v1 = {}
    end
    for i, v in v4(v1) do
        table.insert(v2, v)
    end
    return v2
end

function u0.GetProduct(p1) -- Line: 138 -- upvalues: u30 (val)
    local v1
    local Products = u30
    if Products then
        Products = u30.Products
    end
    if not Products then
        v1 = nil
    else
        v1 = Products[p1]
        if not v1 then
            v1 = nil
        end
    end
    return v1
end

function u0.GetStudioTestProduct(p1) -- Line: 145 -- upvalues: RunService (val), u7 (val), u0 (val)
    local v1
    if not RunService:IsStudio() then
        return nil
    end
    local v2 = u7[u0.UniverseIds.Testing]
    if not v2 then
        v1 = nil
    else
        v1 = v2.Products[p1]
        if not v1 then
            v1 = nil
        end
    end
    return v1
end

function u0.GetPassForPreview(p1) -- Line: 155 -- upvalues: u0 (val), RunService (val), u7 (val)
    local v1 = u0.GetPass(p1)
    if not v1 and RunService:IsStudio() then
        local v2
        local v3 = u7[u0.UniverseIds.Testing]
        if not v3 then
            v2 = nil
        else
            v2 = v3.Passes[p1]
            if not v2 then
                v2 = nil
            end
        end
        return v2
    end
    return v1
end

function u0.GetProductForPreview(p1) -- Line: 164 -- upvalues: u0 (val)
    local v1 = u0.GetProduct(p1)
    if not v1 then
        v1 = u0.GetStudioTestProduct(p1)
    end
    return v1
end

function u0.GetProductForStudioReceipt(p1) -- Line: 171 -- upvalues: u0 (val)
    local v1 = u0.GetProduct(p1)
    if v1 then
        return v1
    end
    return u0.GetStudioTestProduct(p1)
end

function u0.GetGiftProduct(p1) -- Line: 179 -- upvalues: u30 (val)
    local v1
    local GiftProducts = u30
    if GiftProducts then
        GiftProducts = u30.GiftProducts
    end
    if not GiftProducts then
        v1 = nil
    else
        v1 = GiftProducts[p1]
        if not v1 then
            v1 = nil
        end
    end
    return v1
end

function u0.GetLimitedBundleProduct(p1) -- Line: 183 -- upvalues: u30 (val)
    local v1
    local LimitedBundleProducts = u30
    if LimitedBundleProducts then
        LimitedBundleProducts = u30.LimitedBundleProducts
    end
    if not LimitedBundleProducts then
        v1 = nil
    else
        v1 = LimitedBundleProducts[p1]
        if not v1 then
            v1 = nil
        end
    end
    return v1
end

return u0