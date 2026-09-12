local HttpService = game:GetService("HttpService")
local Future = require(script.Parent.Future)

local function Json(p1) -- Line: 22 -- upvalues: HttpService (val)
    return pcall(HttpService.JSONDecode, HttpService, p1.Body)
end

return function(p1, p2) -- Line: 26 -- upvalues: HttpService (val), Future (val), Json (val)
    local Body_3
    local v1 = p2 or {}
    local Body = v1.Body
    if type(Body) ~= "table" then
        Body_3 = v1.Body
    else
        local v2 = HttpService
        local Body_2 = v1.Body
        Body_3 = v2:JSONEncode(Body_2)
    end
    local v3 = Future
    return v3.Try(function(p1_2, p2) -- Line: 32 -- upvalues: HttpService (upval), p1 (val), Json (upval)
        local v1 = HttpService
        local v2 = {Url = p1, Method = p1_2.Method or "GET"}
        local Headers = p1_2.Headers
        if not Headers then
            Headers = {}
        end
        v2.Headers = Headers
        v2.Body = p2
        v1 = v1:RequestAsync(v2)
        return {
            Body = v1.Body,
            Headers = v1.Headers,
            Status = v1.StatusCode,
            StatusText = v1.StatusMessage,
            Ok = v1.Success,
            Url = p1,
            Json = Json,
        }
    end, v1, Body_3)
end