return {
    Name = "unbind",
    Description = "Unbinds an input previously bound with Bind",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "userInput ! bindableResource @ player", Name = "Input/Key", Description = "The key or input type you'd like to unbind."},
    },
    ClientRun = function(p1, p2) -- Line: 14
        local Store = p1:GetStore("CMDR_Binds")
        if not (Store[p2]) then
            return "That input wasn't bound."
        end
        Store[p2]:Disconnect()
        Store[p2] = nil
        return "Unbound command from input."
    end,
}