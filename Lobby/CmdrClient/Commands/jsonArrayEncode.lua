local HttpService = game:GetService("HttpService")
return {
    Name = "json-array-encode",
    Description = "Encodes a comma-separated list into a JSON array",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "string", Name = "CSV", Description = "The comma-separated list"},
    },
    Run = function(p1, p2) -- Line: 16 -- upvalues: HttpService (val)
        local v1 = HttpService
        local v2 = p2:split(",")
        return v1:JSONEncode(v2)
    end,
}