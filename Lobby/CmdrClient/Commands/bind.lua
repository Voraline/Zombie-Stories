local UserInputService = game:GetService("UserInputService")
local v1 = {Name = "bind", Description = "Binds a command string to a key or mouse input.", Group = "DefaultUtil", Aliases = {}}
local v2 = {}
local v3 = {Type = "string", Name = "Arguments", Description = "The arguments for the command", Default = ""}
v2[1] = {Type = "userInput ! bindableResource @ player", Name = "Input", Description = "The key or input type you'd like to bind the command to."}
v2[2] = {Type = "command", Name = "Command", Description = "The command you want to run on this input"}
v2[3] = v3
v1.Args = v2
function v1.ClientRun(p1, p2, p3, p4) -- Line: 27 -- upvalues: UserInputService (val)
    local Store = p1:GetStore("CMDR_Binds")
    local u11 = p3 .. " " .. p4
    if Store[p2] then
        Store[p2]:Disconnect()
    end
    local Name = p1:GetArgument(1).Type.Name
    if Name == "userInput" then
        Store[p2] = UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 39 -- upvalues: p2 (val), p1 (val), u11 (ref)
            if a2 then
                return
            end
            if a1.UserInputType == p2 then
                p1:Reply(p1.Dispatcher:EvaluateAndRun(p1.Cmdr.Util.RunEmbeddedCommands(p1.Dispatcher, u11)))
            elseif a1.KeyCode == p2 then
                p1:Reply(p1.Dispatcher:EvaluateAndRun(p1.Cmdr.Util.RunEmbeddedCommands(p1.Dispatcher, u11)))
            end
        end)
        return "Bound command to input."
    end
    if Name == "bindableResource" then
        return "Unimplemented..."
    end
    if Name == "player" then
        Store[p2] = p2.Chatted:Connect(function(a1) -- Line: 51 -- upvalues: p1 (val), u11 (ref), p2 (val)
            local v1 = p1.Cmdr.Util.RunEmbeddedCommands(p1.Dispatcher, p1.Cmdr.Util.SubstituteArgs(u11, {a1}))
            local v2 = ("%s $ %s : %s"):format(p2.Name, v1, p1.Dispatcher:EvaluateAndRun(v1))
            p1:Reply(v2, Color3.fromRGB(244, 92, 66))
        end)
    end
    return "Bound command to input."
end
return v1