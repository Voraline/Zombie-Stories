local HttpService = game:GetService("HttpService")
local Future = require(script.Parent.Future)
local function Json(p1) -- Line: 22 -- upvalues: HttpService (val)
    return pcall(HttpService.JSONDecode, HttpService, p1.Body)
end
return function(p1, p2) -- Line: 26 -- upvalues: HttpService (val), Future (val), Json (val)
    local Body
    local v1 = p2
    if not v1 then
        v1 = {}
    end
    if type(v1.Body) ~= "table" then
        Body = v1.Body
    else
        Body = HttpService:JSONEncode(v1.Body)
    end
    return Future.Try(function(a1, p2) -- Line: 32 -- upvalues: HttpService (upval), p1 (val), Json (upval)
        local v1 = {Url = p1, Method = a1.Method or "GET"}
        local Headers = a1.Headers
        if not Headers then
            Headers = {}
        end
        v1.Headers = Headers
        v1.Body = p2
        local v2 = HttpService:RequestAsync(v1)
        return {
            Body = v2.Body,
            Headers = v2.Headers,
            Status = v2.StatusCode,
            StatusText = v2.StatusMessage,
            Ok = v2.Success,
            Url = p1,
            Json = Json,
        }
    end, v1, Body)
end