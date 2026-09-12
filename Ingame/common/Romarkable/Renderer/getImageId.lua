local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u10 = {}

local function resolveAssetPath(p1) -- Line: 6 -- upvalues: ReplicatedStorage (val)
    local v1 = string.split(p1, "/")
    local success, result = pcall(function() -- Line: 9 -- upvalues: ReplicatedStorage (upval)
        return require((ReplicatedStorage.common:FindFirstChild("Assets", true)):FindFirstChild("assets"))
    end)
    if success and result then
        local Images = result.Images
        local v2 = v1
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            if type(Images) ~= "table" then
                return nil
            end
            Images = Images[j]
        end
        if type(Images) == "string" then
            return Images
        end
        return nil
    end
    return nil
end

return function(p1) -- Line: 23 -- upvalues: u10 (val), resolveAssetPath (val), MarketplaceService (val)
    local v1 = string.match(p1, "^asset://(.+)$")
    if v1 then
        local v2 = u10[v1]
        if v2 then
            return v2
        end
        local v3 = resolveAssetPath(v1)
        if not v3 then
            return "rbxassetid://6266306999"
        end
        u10[v1] = v3
        return v3
    end
    local u15 = string.match(p1, "%d+")
    local u18 = tonumber(u15)
    local u20 = u10[u15]
    if u20 then
        return u20
    end
    local u21 = nil
    local success, result = pcall(function() -- Line: 50 -- upvalues: u21 (ref), MarketplaceService (upval), u15 (val), u20 (ref), u10 (upval), u18 (val)
        local Asset_2, ProductInfo, v1, v2, v3
        local v4 = MarketplaceService
        local v5 = u15
        local Asset = Enum.InfoType.Asset
        u21 = v4:GetProductInfo(v5, Asset)
        if u21.AssetTypeId == 1 then
            u20 = "rbxassetid://" .. u15
            u10[u15] = u20
            return u20
        end
        if u21.AssetTypeId ~= 13 then
            return "rbxassetid://6266306999"
        end
        local Id = u21.Creator.Id
        for i = 0, 50 do
            v1 = MarketplaceService
            v3 = u18 - i
            Asset_2 = Enum.InfoType.Asset
            ProductInfo = v1:GetProductInfo(v3, Asset_2)
            if ProductInfo.AssetTypeId == 1 and ProductInfo.Creator.Id == Id then
                u20 = "rbxassetid://" .. u18 - i
                u10[u15] = u20
                return u20
            end
            v2 = u10[u15]
            if v2 then
                return v2
            end
        end
        u20 = "rbxthumb://type=Asset&id=" .. u15 .. "&w=420&h=420"
        u10[u15] = u20
        return u20
    end)
    if not success then
        return "rbxthumb://type=Asset&id=" .. u15 .. "&w=420&h=420"
    end
    return result
end