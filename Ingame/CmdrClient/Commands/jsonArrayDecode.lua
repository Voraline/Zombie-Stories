local v1 = {Name = "json-array-decode", Description = "Decodes a JSON Array into a comma-separated list", Group = "DefaultUtil", Aliases = {}}
local v2 = {
    {Type = "json", Name = "JSON", Description = "The JSON array."},
}
v1.Args = v2
function v1.ClientRun(p1, p2) -- Line: 14
    local v1
    if type(p2) == "table" then
        v1 = p2
    else
        v1 = {p2}
    end
    return table.concat(v1, ",")
end
return v1