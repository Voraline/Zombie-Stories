local CmdrShared = game.ReplicatedStorage.common:WaitForChild("CmdrShared")
local PermissionsHandler = require(CmdrShared:WaitForChild("PermissionsHandler"))
return {
    Name = "help",
    Description = "Displays a list of all commands, or inspects one command.",
    Group = "Help",
    Args = {
        {
            Type = "command",
            Name = "Command",
            Description = "The command to view information on",
            Optional = true,
        },
    },
    ClientRun = function(p1, p2) -- Line: 17 -- upvalues: PermissionsHandler (val)
        local v1
        if not p2 then
            local Description_3, Executor_2, Group_3, Name_4, v2
            local Commands = p1.Cmdr.Registry:GetCommands()
            p1:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n\nCommand List\n-------------------")
            for k, v in pairs(Commands) do
                v2 = PermissionsHandler
                Executor_2 = p1.Executor
                Group_3 = v.Group
                if v2:HasCommand(Executor_2, Group_3) then
                    Name_4 = v.Name
                    Description_3 = v.Description
                    v1 = ("%s - %s"):format(Name_4, Description_3)
                    p1:Reply(v1)
                end
            end
        else
            local v3, v4
            local Command = p1.Cmdr.Registry:GetCommand(p2)
            local v5 = PermissionsHandler
            local Executor = p1.Executor
            local Group = Command.Group
            if not v5:HasCommand(Executor, Group) then
                v5 = PermissionsHandler
                local Group_2 = Command.Group
                local RequiredRank = v5:GetRequiredRank(Group_2)
                local Name_3 = Command.Name
                v3 = ("You don't have permission to run command '%s'. Min rank: $i"):format(Name_3, RequiredRank)
                v4 = Color3.fromRGB(230, 34, 34)
                p1:Reply(v3, v4)
            else
                local Description, Name_2, Type, v6
                local Name = Command.Name
                local v7 = ("Command: %s"):format(Name)
                v3 = Color3.fromRGB(230, 126, 34)
                p1:Reply(v7, v3)
                if Command.Aliases and 0 < #Command.Aliases then
                    v4 = table.concat(Command.Aliases, ", ")
                    v7 = ("Aliases: %s"):format(v4)
                    v3 = Color3.fromRGB(230, 230, 230)
                    p1:Reply(v7, v3)
                end
                local Description_2 = Command.Description
                v3 = Color3.fromRGB(230, 230, 230)
                p1:Reply(Description_2, v3)
                for i, i2 in ipairs(Command.Args) do
                    Name_2 = i2.Name
                    if i2.Optional ~= true then
                        v6 = ""
                    else
                        v6 = "?"
                    end
                    Type = i2.Type
                    Description = i2.Description
                    v1 = ("#%d %s%s: %s - %s"):format(i, Name_2, v6, Type, Description)
                    v8:Reply(v1)
                end
            end
        end
        return ""
    end,
}