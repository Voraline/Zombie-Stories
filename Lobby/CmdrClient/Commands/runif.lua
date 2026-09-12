local u0 = {}

function u0.startsWith(p1, p2) -- Line: 2
    local v1 = #p2
    if p1:sub(1, v1) ~= p2 then
        return
    end
    local v2 = #p2 + 1
    return p1:sub(v2)
end

return {
    Name = "runif",
    Description = "Runs a given command string if a certain condition is met.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "conditionFunction", Name = "Condition", Description = "The condition function"},
        {Type = "string", Name = "Argument", Description = "The argument to the condition function"},
        {Type = "string", Name = "Test against", Description = "The text to test against."},
        {
            Type = "string",
            Name = "Command",
            Description = "The command string to run if requirements are met. If omitted, return value from condition function is used.",
            Optional = true,
        },
    },
    Run = function(p1, p2, p3, p4, p5) -- Line: 38 -- upvalues: u0 (val)
        local v1 = u0[p2]
        if not v1 then
            return ("Condition %q is not valid."):format(p2)
        end
        local v2 = v1(p4, p3)
        if not v2 then
            return ""
        end
        local Dispatcher_2 = p1.Dispatcher
        local v3 = p1.Cmdr.Util.RunEmbeddedCommands(p1.Dispatcher, p5 or v2)
        return Dispatcher_2:EvaluateAndRun(v3)
    end,
}