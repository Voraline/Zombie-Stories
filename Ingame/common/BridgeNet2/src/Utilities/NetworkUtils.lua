local HttpService = game:GetService("HttpService")
local u7 = require("./Output")
return {
    CreateUUID = function() -- Line: 8 -- upvalues: HttpService (val)
        return (string.gsub(HttpService:GenerateGUID(false), "-", ""))
    end,
    FromHex = function(p1) -- Line: 13
        return (string.gsub(p1, "..", function(p1) -- Line: 15
            local v1 = tonumber(p1, 16)
            return (string.char(v1))
        end))
    end,
    ToHex = function(p1) -- Line: 20 -- upvalues: u7 (val)
        local fatalAssert = u7.fatalAssert
        local v1 = typeof(p1) == "string"
        fatalAssert(v1, (("ToHex takes string, got %*"):format(p1)))
        return (string.gsub(p1, ".", function(p1) -- Line: 23
            return string.format("%02X", string.byte(p1))
        end))
    end,
    ToReadableHex = function(p1) -- Line: 28 -- upvalues: u7 (val)
        local fatalAssert = u7.fatalAssert
        local v1 = typeof(p1) == "string"
        fatalAssert(v1, (("ToReadableHex takes string, got %*"):format(p1)))
        return string.format(string.rep("%02X ", #p1), string.byte(p1, 1, -1))
    end,
    NumberToBestForm = function(p1) -- Line: 34
        local v1 = tostring(p1)
        if #v1 <= 7 then
            return v1
        end
        return p1
    end,
}