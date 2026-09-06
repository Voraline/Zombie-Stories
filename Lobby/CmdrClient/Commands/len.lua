return {
    Name = "len",
    Description = "Returns the length of a comma-separated list",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "string", Name = "CSV", Description = "The comma-separated list"},
    },
    Run = function(p1, p2) -- Line: 14
        return #p2:split(",")
    end,
}