local MonetizationCatalog = require(script.Parent.MonetizationCatalog)
local RunService = game:GetService("RunService")

local function formatNumber(p1) -- Line: 7
    local v1
    local v2 = tonumber(p1)
    local v3 = math.floor(v2 or 0)
    local v4 = math.max(0, v3)
    local v5 = tostring(v4)
    repeat
        v4, v1 = string.gsub(v5, "^(%-?%d+)(%d%d%d)", "%1,%2")
        v5 = v4
    until v1 == 0
    return v5
end

local u11 = {
    OfferVersion = 3,
    DurationSeconds = 86400,
    ZBucks = 1000,
    ImageId = 74853068251432,
    Name = "Starter Pack",
    FreeCrates = {Primary = 1, Secondary = 1, Melee = 1},
    CrateRewards = {
        {Name = "PRIMARY", ImageId = "rbxassetid://72839976474351"},
        {Name = "SECONDARY", ImageId = "rbxassetid://80110776180934"},
        {Name = "MELEE", ImageId = "rbxassetid://112880363964063"},
    },
}

function u11.GetFormattedZBucks() -- Line: 36 -- upvalues: formatNumber (val), u11 (val)
    return formatNumber(u11.ZBucks)
end

u11.Description = u11.GetFormattedZBucks() .. " Z$ + a free Primary, Secondary and Melee crate"

function u11.GetProductId() -- Line: 43 -- upvalues: MonetizationCatalog (val)
    local StarterPack = MonetizationCatalog.GetProduct("StarterPack")
    if not StarterPack then
        StarterPack = MonetizationCatalog.GetStudioTestProduct("StarterPack")
    end
    return StarterPack
end

function u11.IsStudioPreview() -- Line: 47 -- upvalues: RunService (val)
    return RunService:IsStudio()
end

function u11.GetRemainingSeconds(p1, p2) -- Line: 51 -- upvalues: u11 (val)
    if not u11.GetProductId() then
        return 0
    end
    local v1 = u11.IsStudioPreview()
    if not p1 then
        if v1 then
            return u11.DurationSeconds
        end
        return 0
    end
    if p1.StarterPackPurchased and not v1 then
        if v1 then
            return u11.DurationSeconds
        end
        return 0
    end
    local StarterPack = p1.StarterPack
    local v2 = tonumber(StarterPack) or 0
    if v2 <= 0 then
        if v1 then
            return u11.DurationSeconds
        end
        return 0
    end
    local v3 = v2 + u11.DurationSeconds
    local v4 = p2
    if not v4 then
        v4 = os.time()
    end
    local v5 = v3 - v4
    local v6 = math.floor(v5)
    local v7 = math.max(0, v6)
    if v1 and v7 <= 0 then
        return u11.DurationSeconds
    end
    return v7
end

function u11.IsActive(p1, p2) -- Line: 69 -- upvalues: u11 (val)
    local v1 = 0 < (u11.GetRemainingSeconds(p1, p2))
    return v1
end

function u11.ShouldRefresh(p1, p2) -- Line: 73 -- upvalues: u11 (val)
    if p1 and not p1.StarterPackPurchased then
        local v1 = p2
        if not v1 then
            v1 = os.time()
        end
        local StarterPack = p1.StarterPack
        local v2 = tonumber(StarterPack) or 0
        local v3 = true
        if not (v2 <= 0) then
            v3 = false
            local StarterPackOffer = p1.StarterPackOffer
            local v4 = tonumber(StarterPackOffer) or 1
            if v4 < u11.OfferVersion then
                v4 = v1 - v2
                v3 = u11.DurationSeconds <= v4
            end
        end
        return v3
    end
    return false
end

return u11