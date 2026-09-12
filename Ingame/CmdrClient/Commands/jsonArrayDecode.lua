return {
    Name = "json-array-decode",
    Description = "Decodes a JSON Array into a comma-separated list",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "json", Name = "JSON", Description = "The JSON array."},
    },
    ClientRun = function(p1, p2) -- Line: 14
        local v1
        if type(p2) == "table" then
            v1 = p2
        else
            v1 = {p2}
        end
        return table.concat(v1, ",")
    end,
}