local UserInputService = game:GetService("UserInputService")
return {
    Name = "bind",
    Description = "Binds a command string to a key or mouse input.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {
            Type = "userInput ! bindableResource @ player",
            Name = "Input",
            Description = "The key or input type you'd like to bind the command to.",
        },
        {Type = "command", Name = "Command", Description = "The command you want to run on this input"},
        {
            Type = "string",
            Name = "Arguments",
            Description = "The arguments for the command",
            Default = "",
        },
    },
    ClientRun = function(p1, p2, p3, p4) -- Line: 27 -- upvalues: UserInputService (val)
        local Store = p1:GetStore("CMDR_Binds")
        local u11 = p3 .. " " .. p4
        if Store[p2] then
            Store[p2]:Disconnect()
        end
        local Name = p1:GetArgument(1).Type.Name
        if Name == "userInput" then
            local v1 = UserInputService
            local InputBegan = v1.InputBegan
            Store[p2] = (InputBegan:Connect(function(p1_2, p2_2) -- Line: 39 -- upvalues: p2 (val), p1 (val), u11 (ref)
                if p2_2 then
                    return
                end
                if p1_2.UserInputType == p2 or p1_2.KeyCode == p2 then
                    local v1 = p1
                    local v2 = p1
                    local Dispatcher = v2.Dispatcher
                    local v3 = p1
                    local RunEmbeddedCommands = v3.Cmdr.Util.RunEmbeddedCommands
                    local v4 = p1
                    local Dispatcher_2 = v4.Dispatcher
                    local v5 = u11
                    v3 = RunEmbeddedCommands(Dispatcher_2, v5)
                    v2 = Dispatcher:EvaluateAndRun(v3)
                    v1:Reply(v2)
                end
            end))
            return "Bound command to input."
        end
        if Name == "bindableResource" then
            return "Unimplemented..."
        end
        if Name == "player" then
            local Chatted = p2.Chatted
            Store[p2] = (Chatted:Connect(function(p1_2) -- Line: 51 -- upvalues: p1 (val), u11 (ref), p2 (val)
                local v1 = {p1_2}
                local v2 = p1.Cmdr.Util.RunEmbeddedCommands(p1.Dispatcher, p1.Cmdr.Util.SubstituteArgs(u11, v1))
                local v3 = p1
                local v4 = p2
                local Name = v4.Name
                local v5 = p1.Dispatcher:EvaluateAndRun(v2)
                local v6 = ("%s $ %s : %s"):format(Name, v2, v5)
                local v7 = Color3.fromRGB(244, 92, 66)
                v3:Reply(v6, v7)
            end))
        end
        return "Bound command to input."
    end,
}