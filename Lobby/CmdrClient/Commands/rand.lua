return {
    Name = "rand",
    Description = "Returns a random number between min and max",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "integer", Name = "First number", Description = "If second number is nil, random number is between 1 and this value. If second number is provided, number is between this number and the second number."},
        {Type = "integer", Name = "Second number", Description = "The upper bound.", Optional = true},
    },
    Run = function(p1, p2, p3) -- Line: 20
        local v1
        if not p3 then
            v1 = math.random(p2)
        else
            v1 = math.random(p2, p3)
            if not v1 then
                v1 = math.random(p2)
            end
        end
        return (tostring(v1))
    end,
}