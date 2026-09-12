return {
    Name = "run-lines",
    Description = "Splits input by newlines and runs each line as its own command. This is used by the init-run command.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "string", Name = "Script", Description = "The script to parse.", Default = ""},
    },
    ClientRun = function(p1, p2) -- Line: 15
        local v1
        if #p2 == 0 then
            return ""
        end
        local v2 = p1.Dispatcher:Run("var", "INIT_PRINT_OUTPUT") ~= ""
        local v3 = (p2:gsub("\n+", "\n")):split("\n")
        for i, v in ipairs(v3) do
            if v:sub(1, 1) ~= "#" then
                v1 = p1.Dispatcher:EvaluateAndRun(v)
                if v2 then
                    p1:Reply(v1)
                end
            end
        end
        return ""
    end,
}