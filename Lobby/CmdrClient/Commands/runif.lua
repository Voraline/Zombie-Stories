local u0 = {
    startsWith = function(p1, p2) -- Line: 2
        if p1:sub(1, #p2) == p2 then
            return p1:sub(#p2 + 1)
        end
    end,
}
local v1 = {Name = "runif", Description = "Runs a given command string if a certain condition is met.", Group = "DefaultUtil", Aliases = {}}
local v2 = {}
local v3 = {Type = "string", Name = "Test against", Description = "The text to test against."}
local v4 = {Type = "string", Name = "Command", Description = "The command string to run if requirements are met. If omitted, return value from condition function is used.", Optional = true}
v2[1] = {Type = "conditionFunction", Name = "Condition", Description = "The condition function"}
v2[2] = {Type = "string", Name = "Argument", Description = "The argument to the condition function"}
v2[3] = v3
v2[4] = v4
v1.Args = v2
function v1.Run(p1, p2, p3, p4, p5) -- Line: 38 -- upvalues: u0 (val)
    local v1 = u0[p2]
    if not v1 then
        return ("Condition %q is not valid."):format(p2)
    end
    local v2 = v1(p4, p3)
    if v2 then
        return p1.Dispatcher:EvaluateAndRun(p1.Cmdr.Util.RunEmbeddedCommands(p1.Dispatcher, p5 or v2))
    end
    return ""
end
return v1