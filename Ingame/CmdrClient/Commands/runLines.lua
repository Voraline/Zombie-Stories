local v1 = {Name = "run-lines", Description = "Splits input by newlines and runs each line as its own command. This is used by the init-run command.", Group = "DefaultUtil", Aliases = {}}
local v2 = {}
local v3 = {Type = "string", Name = "Script", Description = "The script to parse.", Default = ""}
v2[1] = v3
v1.Args = v2
function v1.ClientRun(p1, p2) -- Line: 15
    if #p2 == 0 then
        return ""
    end
    local v1 = p1.Dispatcher:Run("var", "INIT_PRINT_OUTPUT") ~= ""
    local v2 = p2:gsub("\n+", "\n")
    v2 = v2:split("\n")
    for i, v in ipairs(v2) do
        if v:sub(1, 1) ~= "#" and v1 then
            p1:Reply((p1.Dispatcher:EvaluateAndRun(v)))
        end
    end
    return ""
end
return v1