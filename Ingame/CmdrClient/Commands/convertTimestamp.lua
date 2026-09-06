local v1 = {
    Name = "convertTimestamp",
    Description = "Convert a timestamp to a human-readable format.",
    Group = "DefaultUtil",
    Aliases = {"date"},
}
local v2 = {}
local v3 = {Type = "number", Name = "timestamp", Description = "A numerical representation of a specific moment in time.", Optional = true}
v2[1] = v3
v1.Args = v2
function v1.ClientRun(p1, p2) -- Line: 14
    local v1 = p2
    if not v1 then
        v1 = os.time()
    end
    local v2 = v1
    local v3 = os.date("%x", v2)
    return (("%* %*"):format(v3, (os.date("%X", v2))))
end
return v1