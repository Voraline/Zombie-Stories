local DataStoreService = game:GetService("DataStoreService")
local Parent = script.Parent
local Config = require(Parent.Config)
local u10 = {
    ["\\n"] = "\n",
    ["&nbsp;"] = "",
    ["&amp;"] = "&",
    ["&lt;"] = "<",
    ["&gt;"] = ">",
    ["&quot;"] = "\"",
    ["&apos;"] = "'",
}

u10["&#(%d+);"] = function(p1) -- Line: 14
    return (string.char(p1))
end

local u22 = {}
local u24 = nil

local function getDataStore() -- Line: 86 -- upvalues: Config (val), u24 (ref), DataStoreService (val)
    local v1 = Config.AllowMultipleResponses == false
    assert(v1)
    if u24 == nil then
        local v2 = DataStoreService
        local v3 = Config
        local DataStoreName = v3.DataStoreName
        u24 = v2:GetDataStore(DataStoreName)
    end
    return u24
end

local u26 = {}
return {
    SanitizeEncodedHtml = function(p1, p2) -- Line: 19 -- upvalues: u10 (val)
        local v1 = p1
        local v2 = p2
        for k, v in pairs(u10) do
            if v2 then
                v1 = string.gsub(v1, v2 .. k, v)
            end
            v1 = string.gsub(v1, k, v)
        end
        v1 = string.gsub(v1, "\\u%x%x%x%x", function(p1) -- Line: 31
            local v1 = string.sub(p1, 3)
            return utf8.char("0x" .. v1)
        end)
        v1 = string.gsub(v1, " ", "")
        return (string.gsub(v1, "Â", " "))
    end,
    IsValidFormId = function(p1) -- Line: 43
        if p1 ~= nil and typeof(p1) == "string" then
            local v1 = string.len(p1)
            if v1 ~= 0 and not (128 < v1) then
                return true
            end
            return false
        end
        return false
    end,
    IsRenderedContentEqual = function(p1, p2) -- Line: 57
        local v1 = (string.gsub(p1, "</?[biu]>", "") or "") == (p2 or "")
        return v1
    end,
    ThrottleRequest = function(p1, p2) -- Line: 64 -- upvalues: u22 (val), Config (val)
        local v1
        local v2 = u22[p1]
        local v3 = time()
        if not v2 then
            v2 = {}
            u22[p1] = v2
            v1 = p2
            v2[v1] = v3
            return false
        end
        local v4 = v2[p2]
        local v5 = Config.RateLimits[p2]
        if not v4 then
            v1 = p2
        else
            if v3 - v4 < v5 then
                return true
            end
            v1 = p2
        end
        v2[v1] = v3
        return false
    end,
    HasPlayerResponded = function(p1, p2) -- Line: 97 -- upvalues: Config (val), u26 (val), u24 (ref), DataStoreService (val)
        local v1 = Config.AllowMultipleResponses == false
        assert(v1)
        local UserId = p1.UserId
        v1 = u26[UserId]
        if v1 == nil then
            local v2 = Config.AllowMultipleResponses == false
            assert(v2)
            if u24 == nil then
                local v3 = DataStoreService
                local v4 = Config
                local DataStoreName = v4.DataStoreName
                u24 = v3:GetDataStore(DataStoreName)
            end
            v1 = u24:GetAsync(UserId)
            u26[UserId] = v1
        end
        local v5 = false
        if v1 ~= nil then
            v5 = v1[p2] ~= nil
        end
        return v5
    end,
    SetPlayerFormResponse = function(p1, p2, p3) -- Line: 112 -- upvalues: Config (val), u26 (val)
        local v1 = Config.AllowMultipleResponses == false
        assert(v1)
        local UserId = p1.UserId
        v1 = u26[UserId]
        if v1 == nil then
            v1 = {}
            u26[UserId] = v1
        end
        v1[p2] = p3
    end,
    SavePlayerFormResponses = function(p1) -- Line: 126 -- upvalues: Config (val), u26 (val), u24 (ref), DataStoreService (val)
        local v1 = Config.AllowMultipleResponses == false
        assert(v1)
        local UserId = p1.UserId
        v1 = u26[UserId]
        if v1 ~= nil then
            local v2 = Config.AllowMultipleResponses == false
            assert(v2)
            if u24 == nil then
                local v3 = DataStoreService
                local v4 = Config
                local DataStoreName = v4.DataStoreName
                u24 = v3:GetDataStore(DataStoreName)
            end
            local v5 = u24
            local v6 = {UserId}
            v5:SetAsync(UserId, v1, v6)
        end
    end,
}