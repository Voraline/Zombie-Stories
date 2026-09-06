local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Remotes = ReplicatedStorage.common:WaitForChild("Remotes")
local Net = Remotes:WaitForChild("Net")
local u24 = {SfxEventName = "PlayPurchasePromptSfx"}
local u25 = nil
local function playPurchasePromptSfx(p1) -- Line: 13 -- upvalues: RunService (val), u25 (ref), ReplicatedStorage (val), Net (val), u24 (val)
    local v1, v2
    if not (RunService:IsClient()) then
        pcall(function() -- Line: 27 -- upvalues: Net (upval), p1 (val), u24 (upval)
            Net:FireClient(p1, u24.SfxEventName)
        end)
        return
    end
    if u25 then
        u25.Purchase()
        return
    end
    v1, v2 = pcall(function() -- Line: 16 -- upvalues: ReplicatedStorage (upval)
        return require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.UISounds)
    end)
    if not v1 then
        warn("PurchasePrompt: Failed to load UISounds:", v2)
        return
    end
    u25 = v2
    u25.Purchase()
end
function u24.Product(p1, p2) -- Line: 33 -- upvalues: MarketplaceService (val), playPurchasePromptSfx (val)
    local v1, v2
    if p1 == nil or p2 == nil then
        warn("PurchasePrompt.Product:", "Player and product id are required")
        return false, "Player and product id are required"
    end
    v1, v2 = pcall(function() -- Line: 40 -- upvalues: MarketplaceService (upval), p1 (val), p2 (val)
        MarketplaceService:PromptProductPurchase(p1, p2)
    end)
    if v1 then
        playPurchasePromptSfx(p1)
        return true
    end
    v2 = tostring(v2)
    warn("PurchasePrompt.Product failed:", v2)
    return false, v2
end
function u24.GamePass(p1, p2) -- Line: 53 -- upvalues: MarketplaceService (val), playPurchasePromptSfx (val)
    local v1, v2
    if p1 == nil or p2 == nil then
        warn("PurchasePrompt.GamePass:", "Player and game pass id are required")
        return false, "Player and game pass id are required"
    end
    v1, v2 = pcall(function() -- Line: 60 -- upvalues: MarketplaceService (upval), p1 (val), p2 (val)
        MarketplaceService:PromptGamePassPurchase(p1, p2)
    end)
    if v1 then
        playPurchasePromptSfx(p1)
        return true
    end
    v2 = tostring(v2)
    warn("PurchasePrompt.GamePass failed:", v2)
    return false, v2
end
return u24