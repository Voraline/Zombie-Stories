return {
    Name = "resolve",
    Description = "Resolves Argument Value Operators into lists. E.g., resolve players * gives you a list of all players.",
    Group = "DefaultUtil",
    Aliases = {},
    AutoExec = {"alias \"me|Displays your username\" resolve players ."},
    Args = {
        {Type = "type", Name = "Type", Description = "The type for which to resolve"},
        function(p1) -- Line: 15
            if p1:GetArgument(1):Validate() == false then
                return
            end
            return {
                Name = "Argument Value Operator",
                Description = "The value operator to resolve. One of: * ** . ? ?N",
                Optional = true,
                Type = p1:GetArgument(1):GetValue(),
            }
        end,
    },
    Run = function(p1) -- Line: 29
        return table.concat(p1:GetArgument(2).RawSegments, ",")
    end,
}