local deepCopy
local v1 = {}
local MonetizationCatalog = require(script.Parent.MonetizationCatalog)
local ColonialWinchester = MonetizationCatalog.GetLimitedBundleProduct("ColonialWinchester")
local FrontierMinuteman = MonetizationCatalog.GetLimitedBundleProduct("FrontierMinuteman")
local DesolateGaze = MonetizationCatalog.GetLimitedBundleProduct("DesolateGaze")
local Liberator = MonetizationCatalog.GetLimitedBundleProduct("Liberator")
local Umbra = MonetizationCatalog.GetLimitedBundleProduct("Umbra")
local u21 = {
    {
        BundleId = "UMBRA_PREMIUM_BUNDLE",
        Name = "UMBRA Premium Bundle",
        Description = "Includes:\n- UMBRA RSH-12 [TRADEABLE]\n- UMBRA Pride Hatchet [TRADEABLE]\n- 10,000 Z$",
        Currency = "Robux",
        ImageId = 81042123085414,
        Special = "PurpleGradient",
        IsDeveloperProduct = true,
        ProductType = "DeveloperProduct",
        PrimaryItemId = "2160",
        ProductId = Umbra,
        Rewards = {
            ZBucks = 10000,
            Items = {
                {ItemId = "2160", Tradable = true},
                {ItemId = "3118", Tradable = true},
            },
        },
    },
    {
        BundleId = "LIBERATOR_NIGHTHAVEN_AR45",
        Name = "Liberator Nighthaven AR-45 Premium Skin [LIMITED]",
        Description = "Includes:\n- Liberator Nighthaven AR-45 [TRADEABLE]\n- 2,000 Z$",
        Currency = "Robux",
        ImageId = 137600960893968,
        Special = "PurpleGradient",
        EndTimestamp = 1785556800,
        IsDeveloperProduct = true,
        ProductType = "DeveloperProduct",
        PrimaryItemId = "1344",
        ProductId = Liberator,
        Rewards = {
            ZBucks = 2000,
            Items = {
                {ItemId = "1344", Tradable = true},
            },
        },
    },
    {
        BundleId = "COLONIAL_WINCHESTER_1873",
        Name = "Colonial Winchester 1873 Premium Skin [LIMITED]",
        Description = "Includes:\n- Colonial Winchester 1873 [TRADEABLE]\n- 2,000 Z$",
        Currency = "Robux",
        ImageId = 131493567678988,
        Special = "PurpleGradient",
        EndTimestamp = 1765645200,
        IsDeveloperProduct = true,
        ProductType = "DeveloperProduct",
        Hidden = true,
        PrimaryItemId = "1325",
        ProductId = ColonialWinchester,
        Events = {"THANKSGIVING2025"},
        Rewards = {
            ZBucks = 2000,
            Items = {
                {ItemId = "1325", Tradable = true},
            },
        },
    },
    {
        BundleId = "FRONTIER_MINUTEMAN",
        Name = "Frontier Minuteman Premium Outfit [LIMITED]",
        Description = "Includes:\n- Frontier Minuteman Outfit [TRADEABLE]\n- 3,000 Z$",
        Currency = "Robux",
        ImageId = 138237913361324,
        Special = "PurpleGradient",
        EndTimestamp = 1765645200,
        IsDeveloperProduct = true,
        ProductType = "DeveloperProduct",
        Hidden = true,
        PrimaryItemId = "4039",
        ProductId = FrontierMinuteman,
        Events = {"THANKSGIVING2025"},
        Rewards = {
            ZBucks = 3000,
            Items = {
                {ItemId = "4039", Tradable = true},
            },
        },
    },
    {
        BundleId = "DESOLATE_GAZE_BUNDLE",
        Name = "Desolate Gaze Bundle",
        Description = "Includes:\n- Desolate Gaze M200 Intervention [TRADEABLE]\n- Desolate Gaze Serbu Super Shorty [TRADEABLE]\n- Celyn [TRADEABLE]\n- 3,000 Z$",
        Currency = "Robux",
        Price = 699,
        ImageId = 80390619281513,
        Special = "PurpleGradient",
        EndTimestamp = 1769896800,
        IsDeveloperProduct = true,
        ProductType = "DeveloperProduct",
        Hidden = true,
        PrimaryItemId = "1332",
        ProductId = DesolateGaze,
        Events = {"CHRISTMAS2025"},
        Rewards = {
            ZBucks = 3000,
            Items = {
                {ItemId = "1332", Tradable = true},
                {ItemId = "2156", Tradable = true},
                {ItemId = "3114", Tradable = true},
            },
        },
    },
}
function deepCopy(p1) -- Line: 143 -- upvalues: deepCopy (val)
    if typeof(p1) ~= "table" then
        return p1
    end
    local v1 = {}
    for k, v in pairs(p1) do
        v1[k] = deepCopy(v)
    end
    return v1
end
local function isEventMatch(p1, p2) -- Line: 155
    if not p2 or not p1.Events then
        return true
    end
    for i, v in ipairs(p1.Events) do
        if v == p2 then
            return true
        end
    end
    return false
end
function v1.GetAll() -- Line: 169 -- upvalues: u21 (val), deepCopy (val)
    local v1 = {}
    for i, v in ipairs(u21) do
        if not v.Hidden and typeof(v.ProductId) == "number" then
            table.insert(v1, (deepCopy(v)))
        end
    end
    return v1
end
function v1.GetShopEntries() -- Line: 179 -- upvalues: u21 (val), deepCopy (val)
    local v1
    local v2 = {}
    for i, v in ipairs(u21) do
        if not v.Hidden and typeof(v.ProductId) == "number" then
            v1 = deepCopy(v)
            v1.Type = "Bundle"
            table.insert(v2, v1)
        end
    end
    return v2
end
function v1.GetEventEntries(p1) -- Line: 191 -- upvalues: u21 (val), deepCopy (val)
    local v1
    local v2 = {}
    local v3 = p1
    for i, v in ipairs(u21) do
        if not v.Hidden and typeof(v.ProductId) == "number" then
            if not v3 then
                v1 = true
            elseif v.Events then
                for i2, i3 in ipairs(v.Events) do
                    if i3 == v3 then
                        v1 = true
                        if v1 then
                            v1 = deepCopy(v)
                            v1.Type = "LimitedBundle"
                            table.insert(v2, v1)
                        end
                        break
                    end
                end
                v1 = false
            end
        end
    end
    return v2
end
function v1.GetByProductId(p1) -- Line: 207 -- upvalues: u21 (val), deepCopy (val)
    if typeof(p1) ~= "number" then
        return nil
    end
    for i, v in ipairs(u21) do
        if v.ProductId == p1 then
            return (deepCopy(v))
        end
    end
    return nil
end
function v1.GetByBundleId(p1) -- Line: 219 -- upvalues: u21 (val), deepCopy (val)
    for i, v in ipairs(u21) do
        if v.BundleId == p1 then
            return (deepCopy(v))
        end
    end
    return nil
end
return v1