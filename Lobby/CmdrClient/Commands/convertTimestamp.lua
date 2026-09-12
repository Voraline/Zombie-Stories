return {
    Name = "convertTimestamp",
    Description = "Convert a timestamp to a human-readable format.",
    Group = "DefaultUtil",
    Aliases = {"date"},
    Args = {
        {
            Type = "number",
            Name = "timestamp",
            Description = "A numerical representation of a specific moment in time.",
            Optional = true,
        },
    },
    ClientRun = function(p1, p2) -- Line: 14
        local v1 = p2
        if not v1 then
            v1 = os.time()
        end
        local v2 = v1
        local v3 = os.date("%x", v2)
        local v4 = os.date("%X", v2)
        return (("%* %*"):format(v3, v4))
    end,
}