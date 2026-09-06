local CmdrShared = game.ReplicatedStorage.common:WaitForChild("CmdrShared")
local PermissionsHandler = require(CmdrShared:WaitForChild("PermissionsHandler"))
local v1 = {Name = "help", Description = "Displays a list of all commands, or inspects one command.", Group = "Help"}
local v2 = {
    {Type = "command", Name = "Command", Description = "The command to view information on", Optional = true},
}
v1.Args = v2
function v1.ClientRun(p1, p2) -- Line: 17 -- upvalues: PermissionsHandler (val)
    if not p2 then
        local Commands = p1.Cmdr.Registry:GetCommands()
        p1:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n\nCommand List\n-------------------")
        for k, v in pairs(Commands) do
            if PermissionsHandler:HasCommand(p1.Executor, v.Group) then
                p1:Reply(("%s - %s"):format(v.Name, v.Description))
            end
        end
    else
        local Command = p1.Cmdr.Registry:GetCommand(p2)
        if not (PermissionsHandler:HasCommand(p1.Executor, Command.Group)) then
            local v1 = ("You don't have permission to run command '%s'. Min rank: $i"):format(Command.Name, (PermissionsHandler:GetRequiredRank(Command.Group)))
            p1:Reply(v1, Color3.fromRGB(230, 34, 34))
        else
            local v2
            local v3 = ("Command: %s"):format(Command.Name)
            p1:Reply(v3, Color3.fromRGB(230, 126, 34))
            if Command.Aliases then
                local v4 = #Command.Aliases
                if 0 < v4 then
                    v3 = ("Aliases: %s"):format(table.concat(Command.Aliases, ", "))
                    p1:Reply(v3, Color3.fromRGB(230, 230, 230))
                end
            end
            p1:Reply(Command.Description, Color3.fromRGB(230, 230, 230))
            for i, i2 in ipairs(Command.Args) do
                if i2.Optional ~= true then
                    v2 = ""
                else
                    v2 = "?"
                end
                v5:Reply(("#%d %s%s: %s - %s"):format(i, i2.Name, v2, i2.Type, i2.Description))
            end
        end
    end
    return ""
end
return v1