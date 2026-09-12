local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Net = (ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("Net")
local u24 = {SfxEventName = "PlayPurchasePromptSfx"}
local u25 = nil

local function playPurchasePromptSfx(p1) -- Line: 13
    -- upvalues: RunService (val), u25 (ref), ReplicatedStorage (val), Net (val), u24 (val)
    if not RunService:IsClient() then
        pcall(function() -- Line: 27 -- upvalues: Net (upval), p1 (val), u24 (upval)
            local v1 = Net
            local v2 = p1
            local v3 = u24
            local SfxEventName = v3.SfxEventName
            v1:FireClient(v2, SfxEventName)
        end)
        return
    end
    if not u25 then
        local success, result = pcall(function() -- Line: 16 -- upvalues: ReplicatedStorage (upval)
            return require(ReplicatedStorage.common.ZS_Framework.UI.UIKit.UISounds)
        end)
        if not success then
            warn("PurchasePrompt: Failed to load UISounds:", result)
            return
        end
        u25 = result
    end
    u25.Purchase()
end

function u24.Product(p1, p2, p3) -- Line: 33
    -- upvalues: RunService (val), ReplicatedStorage (val), MarketplaceService (val), playPurchasePromptSfx (val)
    if p1 ~= nil and p2 ~= nil then
        local result_2, success_2, v1
        if not RunService:IsClient() then
            success_2, result_2 = pcall(function() -- Line: 53 -- upvalues: MarketplaceService (upval), p1 (val), p2 (val)
                local v1 = MarketplaceService
                local v2 = p1
                local v3 = p2
                v1:PromptProductPurchase(v2, v3)
            end)
            if not success_2 then
                v1 = tostring(result_2)
                warn("PurchasePrompt.Product failed:", v1)
                return false, v1
            end
            playPurchasePromptSfx(p1)
            return true
        end
        local success, result, v2 = pcall(function() -- Line: 41 -- upvalues: ReplicatedStorage (upval), p2 (val), p3 (val)
            local v1 = ReplicatedStorage
            local DataRemote = v1.common.Remotes.DataRemote
            local v2 = p2
            local v3 = p3
            return DataRemote:InvokeServer("PrepareProductPrompt", v2, v3)
        end)
        if success and result then
            success_2, result_2 = pcall(function() -- Line: 53 -- upvalues: MarketplaceService (upval), p1 (val), p2 (val)
                local v1 = MarketplaceService
                local v2 = p1
                local v3 = p2
                v1:PromptProductPurchase(v2, v3)
            end)
            if success_2 then
                playPurchasePromptSfx(p1)
                return true
            end
            v1 = tostring(result_2)
            warn("PurchasePrompt.Product failed:", v1)
            return false, v1
        end
        return false, v2 or "This product has a pending purchase. Please try again later."
    end
    warn("PurchasePrompt.Product:", "Player and product id are required")
    return false, "Player and product id are required"
end

function u24.GamePass(p1, p2) -- Line: 66 -- upvalues: MarketplaceService (val), playPurchasePromptSfx (val)
    if p1 ~= nil and p2 ~= nil then
        local success, result = pcall(function() -- Line: 73 -- upvalues: MarketplaceService (upval), p1 (val), p2 (val)
            local v1 = MarketplaceService
            local v2 = p1
            local v3 = p2
            v1:PromptGamePassPurchase(v2, v3)
        end)
        if success then
            playPurchasePromptSfx(p1)
            return true
        end
        local v1 = tostring(result)
        warn("PurchasePrompt.GamePass failed:", v1)
        return false, v1
    end
    warn("PurchasePrompt.GamePass:", "Player and game pass id are required")
    return false, "Player and game pass id are required"
end

return u24