local Key, Keys
local v1 = {
    Entries = {
        {
            Key = "ZBucks1000",
            DisplayName = "1,000 ZBucks",
            Kind = "ZBucks",
            Repeatable = true,
            Amount = 1000,
            AnalyticsId = "1000ZBucksDevProd",
        },
        {
            Key = "ZBucks3300",
            DisplayName = "3,300 ZBucks",
            Kind = "ZBucks",
            Repeatable = true,
            Amount = 3300,
            AnalyticsId = "3300ZBucksDevProd",
        },
        {
            Key = "ZBucks9200",
            DisplayName = "9,200 ZBucks",
            Kind = "ZBucks",
            Repeatable = true,
            Amount = 9200,
            AnalyticsId = "92000ZBucksDevProd",
        },
        {
            Key = "ZBucks24000",
            DisplayName = "24,000 ZBucks",
            Kind = "ZBucks",
            Repeatable = true,
            Amount = 24000,
            AnalyticsId = "24000ZBucksDevProd",
        },
        {
            Key = "ZBucks58500",
            DisplayName = "58,500 ZBucks",
            Kind = "ZBucks",
            Repeatable = true,
            Amount = 58500,
            AnalyticsId = "58500ZBucksDevProd",
        },
        {
            Key = "Revive1",
            DisplayName = "1 Revive",
            Kind = "Revive",
            Repeatable = true,
            Amount = 1,
            AnalyticsId = "1Revive",
        },
        {
            Key = "Revive3",
            DisplayName = "3 Revives",
            Kind = "Revive",
            Repeatable = true,
            Amount = 3,
            AnalyticsId = "3Revives",
        },
        {
            Key = "CyberpunkCrate",
            DisplayName = "Cyberpunk Crate",
            Kind = "Crate",
            Repeatable = true,
            CrateId = "Cyberpunk",
            CrateCount = 1,
        },
        {
            Key = "CyberpunkCrate5",
            DisplayName = "5 Cyberpunk Crates",
            Kind = "Crate",
            Repeatable = true,
            CrateId = "Cyberpunk",
            CrateCount = 5,
        },
        {
            Key = "ColonialWinchester",
            DisplayName = "Colonial Winchester 1873",
            Kind = "LimitedBundle",
            Repeatable = false,
            ProductKey = "ColonialWinchester",
        },
        {
            Key = "FrontierMinuteman",
            DisplayName = "Frontier Minuteman",
            Kind = "LimitedBundle",
            Repeatable = false,
            ProductKey = "FrontierMinuteman",
        },
        {
            Key = "DesolateGaze",
            DisplayName = "Desolate Gaze Bundle",
            Kind = "LimitedBundle",
            Repeatable = false,
            ProductKey = "DesolateGaze",
        },
        {
            Key = "Liberator",
            DisplayName = "Liberator Nighthaven AR-45",
            Kind = "LimitedBundle",
            Repeatable = false,
            ProductKey = "Liberator",
        },
        {
            Key = "Umbra",
            DisplayName = "UMBRA Premium Bundle",
            Kind = "LimitedBundle",
            Repeatable = true,
            ProductKey = "Umbra",
        },
        {
            Key = "Axiom",
            DisplayName = "Axiom",
            Kind = "Permanent",
            Repeatable = true,
            PassKey = "Axiom",
            EntitlementKey = "Axiom",
        },
        {
            Key = "DarkOps",
            DisplayName = "Dark Ops",
            Kind = "Permanent",
            Repeatable = true,
            PassKey = "DarkOps",
            EntitlementKey = "DarkOps",
        },
        {
            Key = "FadeSet",
            DisplayName = "Fade Set",
            Kind = "Permanent",
            Repeatable = true,
            PassKey = "FadeSet",
            EntitlementKey = "FadeSet",
        },
        {
            Key = "GhilliePack",
            DisplayName = "Ghillie Pack",
            Kind = "Permanent",
            Repeatable = true,
            PassKey = "GhilliePack",
            EntitlementKey = "GhilliePack",
        },
        {
            Key = "NightVision",
            DisplayName = "Night Vision",
            Kind = "Permanent",
            Repeatable = false,
            PassKey = "NightVision",
            EntitlementKey = "NightVision",
        },
        {
            Key = "PinkPack",
            DisplayName = "Pink Pack",
            Kind = "Permanent",
            Repeatable = true,
            PassKey = "PinkPack",
            EntitlementKey = "PinkPack",
        },
        {
            Key = "RevivePlus",
            DisplayName = "Revive Plus",
            Kind = "Permanent",
            Repeatable = false,
            PassKey = "RevivePlus",
            EntitlementKey = "RevivePlus",
        },
        {
            Key = "Wasteland",
            DisplayName = "Wasteland",
            Kind = "Permanent",
            Repeatable = true,
            PassKey = "Wasteland",
            EntitlementKey = "Wasteland",
        },
    },
    Keys = {},
}
local u25 = {}
for i, v in ipairs(v1.Entries) do
    Keys = v1.Keys
    Key = v.Key
    table.insert(Keys, Key)
    u25[v.Key] = v
end

function v1.GetByKey(p1) -- Line: 192 -- upvalues: u25 (val)
    return u25[p1]
end

return v1