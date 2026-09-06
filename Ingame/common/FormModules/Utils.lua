local DataStoreService = game:GetService("DataStoreService")
local Config = require(script.Parent.Config)
local u10 = {}
u10["\\n"] = "\n"
u10["&nbsp;"] = ""
u10["&amp;"] = "&"
u10["&lt;"] = "<"
u10["&gt;"] = ">"
u10["&quot;"] = "\""
u10["&apos;"] = "'"
u10["&#(%d+);"] = function(p1) -- Line: 14
    return (string.char(p1))
end
local u22 = {}
local u24 = nil
local function getDataStore() -- Line: 86 -- upvalues: Config (val), u24 (ref), DataStoreService (val)
    local v1 = Config.AllowMultipleResponses == false
    assert(v1)
    if u24 == nil then
        u24 = DataStoreService:GetDataStore(Config.DataStoreName)
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
        if p1 == nil or typeof(p1) ~= "string" then
            return false
        end
        local v1 = string.len(p1)
        if v1 == 0 or 128 < v1 then
            return false
        end
        return true
    end,
    IsRenderedContentEqual = function(p1, p2) -- Line: 57
        local v1
        if string.gsub(p1, "</?[biu]>", "") or "" == p2 or "" then
            v1 = true
        else
            v1 = false
        end
        return v1
    end,
    ThrottleRequest = function(p1, p2) -- Line: 64 -- upvalues: u22 (val), Config (val)
        local v1 = u22[p1]
        local v2 = time()
        if not v1 then
            v1 = {}
            u22[p1] = v1
            v1[p2] = v2
            return false
        end
        local v3 = v1[p2]
        local v4 = Config.RateLimits[p2]
        if not v3 then
            v1[p2] = v2
            return false
        end
        if v2 - v3 < v4 then
            return true
        end
        v1[p2] = v2
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
                u24 = DataStoreService:GetDataStore(Config.DataStoreName)
            end
            v1 = u24:GetAsync(UserId)
            u26[UserId] = v1
        end
        local v3 = if v1 ~= nil then v1[p2] ~= nil else false
        return v3
    end,
    SetPlayerFormResponse = function(p1, p2, p3) -- Line: 112 -- upvalues: Config (val), u26 (val)
        local v1 = Config.AllowMultipleResponses == false
        assert(v1)
        local UserId = p1.UserId
        v1 = u26[UserId]
        if v1 == nil then
            u26[UserId] = {}
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
                u24 = DataStoreService:GetDataStore(Config.DataStoreName)
            end
            u24:SetAsync(UserId, v1, {UserId})
        end
    end,
}