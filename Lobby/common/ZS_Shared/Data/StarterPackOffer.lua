local MonetizationCatalog = require(script.Parent.MonetizationCatalog)
local RunService = game:GetService("RunService")
local function formatNumber(p1) -- Line: 7
    local v1, v2
    local v3 = tostring((math.max(0, (math.floor(tonumber(p1) or 0)))))
    while true do
        v1, v2 = string.gsub(v3, "^(%-?%d+)(%d%d%d)", "%1,%2")
        v3 = v1
        if v2 == 0 then
            break
        end
    end
    return v3
end
local u11 = {
    OfferVersion = 3,
    DurationSeconds = 86400,
    ZBucks = 1000,
    ImageId = 74853068251432,
    Name = "Starter Pack",
    FreeCrates = {Primary = 1, Secondary = 1, Melee = 1},
}
local v1 = {}
local v2 = {Name = "PRIMARY", ImageId = "rbxassetid://72839976474351"}
v1[1] = v2
v1[2] = {Name = "SECONDARY", ImageId = "rbxassetid://80110776180934"}
v1[3] = {Name = "MELEE", ImageId = "rbxassetid://112880363964063"}
u11.CrateRewards = v1
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
    if not (u11.GetProductId()) then
        return 0
    end
    local v1 = u11.IsStudioPreview()
    if not p1 then
        if v1 then
            return u11.DurationSeconds
        end
        return 0
    elseif not p1.StarterPackPurchased then
        local v2 = tonumber(p1.StarterPack) or 0
        if v2 <= 0 then
            if v1 then
                return u11.DurationSeconds
            end
            return 0
        end
        local v3 = p2
        if not v3 then
            v3 = os.time()
        end
        local v4 = math.max(0, (math.floor(v2 + u11.DurationSeconds - v3)))
        if not v1 then
            return v4
        end
        if v4 <= 0 then
            return u11.DurationSeconds
        end
        return v4
    elseif not v1 then
        if v1 then
            return u11.DurationSeconds
        end
        return 0
    end
end
function u11.IsActive(p1, p2) -- Line: 69 -- upvalues: u11 (val)
    local v1 = u11.GetRemainingSeconds(p1, p2)
    local v2 = 0 < v1
    return v2
end
function u11.ShouldRefresh(p1, p2) -- Line: 73 -- upvalues: u11 (val)
    if not p1 or p1.StarterPackPurchased then
        return false
    end
    local v1 = p2
    if not v1 then
        v1 = os.time()
    end
    local v2 = tonumber(p1.StarterPack) or 0
    local v3 = true
    if v2 > 0 then
        v3 = false
        local v4 = tonumber(p1.StarterPackOffer) or 1
        if v4 < u11.OfferVersion then
            v3 = u11.DurationSeconds <= v1 - v2
        end
    end
    return v3
end
return u11