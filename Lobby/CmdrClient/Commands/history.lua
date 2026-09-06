local v1 = {
    Name = "history",
    Description = "Displays previous commands from history.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = {"alias \"!|Displays previous command from history.\" run ${history $1{number|Line Number}}", "alias \"^|Runs the previous command, replacing all occurrences of A with B.\" run ${run replace ${history -1} $1{string|A} $2{string|B}}", "alias \"!!|Reruns the last command.\" ! -1"},
}
local v2 = {
    {Type = "integer", Name = "Line Number", Description = "Command line number (can be negative to go from end)"},
}
v1.Args = v2
function v1.ClientRun(p1, p2) -- Line: 19
    local v1
    local History = p1.Dispatcher:GetHistory()
    if p2 > 0 then
        v1 = p2
    else
        v1 = #History + p2
    end
    return History[v1] or ""
end
return v1