local DisplayName, Key, v1, v2
local u65 = {}
local MonetizationCatalog = require(script.Parent.MonetizationCatalog)
local GiftCatalog = require(script.Parent.GiftCatalog)
local u63 = {}
local u66 = {}
local u67 = {}
local u64 = {}

local function registerRepeatable(p1, p2) -- Line: 15 -- upvalues: MonetizationCatalog (val), u63 (val), u64 (val)
    local v1 = MonetizationCatalog.GetProduct(p1)
    if v1 then
        u63[v1] = true
        u64[v1] = p2
    end
end

local function registerPermanent(p1) -- Line: 23
    -- upvalues: MonetizationCatalog (val), u67 (val), u63 (val), u66 (val), u64 (val)
    local v1 = {
        PassKey = p1.PassKey,
        PassId = MonetizationCatalog.GetPass(p1.PassKey),
        EntitlementKey = p1.EntitlementKey,
    }
    local v2 = p1.Repeatable == true
    v1.Repeatable = v2
    u67[p1.PassKey] = v1
    v2 = MonetizationCatalog.GetGiftProduct(p1.PassKey)
    if v2 then
        u63[v2] = true
        u66[v2] = v1
        u64[v2] = p1.DisplayName
    end
end

for i, v in ipairs(GiftCatalog.Entries) do
    if v.Kind == "ZBucks" or v.Kind == "Revive" or v.Kind == "Crate" then
        Key = v.Key
        DisplayName = v.DisplayName
        v2 = MonetizationCatalog.GetProduct(Key)
        if v2 then
            u63[v2] = true
            u64[v2] = DisplayName
        end
    elseif v.Kind == "Permanent" then
        registerPermanent(v)
    elseif v.Kind == "LimitedBundle" then
        v1 = MonetizationCatalog.GetLimitedBundleProduct(v.ProductKey)
        if v1 then
            u63[v1] = true
            u64[v1] = v.DisplayName
        end
    end
end

function u65.IsGiftableProduct(p1) -- Line: 56 -- upvalues: u63 (val)
    local v1 = false
    if typeof(p1) == "number" then
        v1 = u63[p1] == true
    end
    return v1
end

function u65.ResolvePromptProduct(p1, p2) -- Line: 60 -- upvalues: u65 (val)
    if u65.IsGiftableProduct(p2) then
        return p2
    end
    if u65.IsGiftableProduct(p1) then
        return p1
    end
    return nil
end

function u65.GetPermanentGiftDefinition(p1) -- Line: 70 -- upvalues: u66 (val)
    return u66[p1]
end

function u65.GetPermanentGiftDefinitionByPassKey(p1) -- Line: 74 -- upvalues: u67 (val)
    return u67[p1]
end

function u65.GetPermanentGiftDefinitions() -- Line: 78 -- upvalues: u66 (val)
    return u66
end

function u65.GetDisplayName(p1) -- Line: 82 -- upvalues: u64 (val)
    return u64[p1]
end

return u65