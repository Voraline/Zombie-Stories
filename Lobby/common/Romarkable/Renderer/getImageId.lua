local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u10 = {}
local function resolveAssetPath(p1) -- Line: 6 -- upvalues: ReplicatedStorage (val)
    local v1, v2
    local v3 = string.split(p1, "/")
    v1, v2 = pcall(function() -- Line: 9 -- upvalues: ReplicatedStorage (upval)
        local Assets = ReplicatedStorage.common:FindFirstChild("Assets", true)
        return require(Assets:FindFirstChild("assets"))
    end)
    if not v1 or not v2 then
        return nil
    end
    local Images = v2.Images
    local v4 = v3
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
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
return function(p1) -- Line: 23 -- upvalues: u10 (val), resolveAssetPath (val), MarketplaceService (val)
    local v1, v2, v3
    local v4 = string.match(p1, "^asset://(.+)$")
    if v4 then
        v1 = u10[v4]
        if v1 then
            return v1
        end
        local v5 = resolveAssetPath(v4)
        if not v5 then
            return "rbxassetid://6266306999"
        end
        u10[v4] = v5
        return v5
    end
    local u15 = string.match(p1, "%d+")
    local u18 = tonumber(u15)
    local u20 = u10[u15]
    if u20 then
        return u20
    end
    local u21 = nil
    v2, v3 = pcall(function() -- Line: 50 -- upvalues: u21 (ref), MarketplaceService (upval), u15 (val), u20 (ref), u10 (upval), u18 (val)
        local ProductInfo, v1
        u21 = MarketplaceService:GetProductInfo(u15, Enum.InfoType.Asset)
        if u21.AssetTypeId == 1 then
            u20 = "rbxassetid://" .. u15
            u10[u15] = u20
            return u20
        end
        if u21.AssetTypeId ~= 13 then
            return "rbxassetid://6266306999"
        end
        local Id = u21.Creator.Id
        local v2 = 50
        local v3 = 1
        for i = 0, v2, v3 do
            ProductInfo = MarketplaceService:GetProductInfo(u18 - i, Enum.InfoType.Asset)
            if ProductInfo.AssetTypeId == 1 and ProductInfo.Creator.Id == Id then
                u20 = "rbxassetid://" .. u18 - i
                u10[u15] = u20
                return u20
            end
            v1 = u10[u15]
            if v1 then
                return v1
            end
        end
        u20 = "rbxthumb://type=Asset&id=" .. u15 .. "&w=420&h=420"
        u10[u15] = u20
        return u20
    end)
    if not v2 then
        return "rbxthumb://type=Asset&id=" .. u15 .. "&w=420&h=420"
    end
    return v3
end