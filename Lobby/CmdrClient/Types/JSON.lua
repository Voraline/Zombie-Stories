local HttpService = game:GetService("HttpService")
return function(p1) -- Line: 3 -- upvalues: HttpService (val)
    p1:RegisterType("json", {
        Validate = function(p1) -- Line: 5 -- upvalues: HttpService (upval)
            return pcall(HttpService.JSONDecode, HttpService, p1)
        end,
        Parse = function(p1) -- Line: 9 -- upvalues: HttpService (upval)
            return HttpService:JSONDecode(p1)
        end,
    })
end