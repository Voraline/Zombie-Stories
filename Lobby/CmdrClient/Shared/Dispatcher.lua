local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local u17 = require("./Util")
local u20 = require("./Command")
local u21 = false
local u22 = {}

function u22:Evaluate(p2, p3, p4, p5) -- Line: 21 -- upvalues: RunService (val), Players (val), u17 (val), u20 (val)
    if RunService:IsClient() == true and p3 ~= Players.LocalPlayer then
        error("Can't evaluate a command that isn't sent by the local player.")
    end
    local v1 = u17.SplitString(p2)
    local v2 = table.remove(v1, 1)
    local Command = self.Registry:GetCommand(v2)
    if not Command then
        local v3 = tostring(v2)
        return false, ("%q is not a valid command name. Use the help command to see all available commands."):format(v3)
    end
    v1 = u17.MashExcessArguments(v1, #Command.Args)
    local v4 = u20
    v4 = v4.new({
        Dispatcher = self,
        Text = p2,
        CommandObject = Command,
        Alias = v2,
        Executor = p3,
        Arguments = v1,
        Data = p5,
    })
    local v5, v6 = v4:Parse(p4)
    if v5 then
        return v4
    end
    return false, v6
end

function u22.EvaluateAndRun(p1, p2, p3, p4) -- Line: 58 -- upvalues: Players (val), RunService (val)
    local v1
    local LocalPlayer = p3
    if not LocalPlayer then
        LocalPlayer = Players.LocalPlayer
    end
    local v2 = LocalPlayer
    local v3 = p4 or {}
    local v4 = v3
    if RunService:IsClient() and v4.IsHuman then
        p1:PushHistory(p2)
    end
    local Data = v4.Data
    local u38, v5 = p1:Evaluate(p2, v2, nil, Data)
    if not u38 then
        return v5
    end
    local success, result = xpcall(function() -- Line: 72 -- upvalues: u38 (val)
        local v1, v2 = u38:Validate(true)
        if not v1 then
            return v2
        end
        return u38:Run() or "Command executed."
    end, function(p1) -- Line: 80
        return debug.traceback((tostring(p1)))
    end)
    if not success then
        v1 = warn
        local v6 = tostring(result)
        v1(("Error occurred while evaluating command string %q\n%s"):format(p2, v6))
    end
    v1 = success and result or "An error occurred while running this command. Check the console for more information."
    return v1
end

function u22.Send(p1, p2, p3) -- Line: 92 -- upvalues: RunService (val)
    if RunService:IsClient() == false then
        error("Dispatcher:Send can only be called from the client.")
    end
    local RemoteFunction = p1.Cmdr.RemoteFunction
    local v1 = {Data = p3}
    return RemoteFunction:InvokeServer(p2, v1)
end

function u22:Run(...) -- Line: 104 -- upvalues: Players (val)
    local v1, v2, v3
    if not Players.LocalPlayer then
        error("Dispatcher:Run can only be called from the client.")
    end
    local v4 = {...}
    local v5 = v4[1]
    local v6 = #v4
    for i = 2, v6 do
        v3 = v4[i]
        v5 = v5 .. " " .. tostring(v3)
    end
    local v7 = Players
    local LocalPlayer = v7.LocalPlayer
    v6, v1 = self:Evaluate(v5, LocalPlayer)
    if not v6 then
        error(v1)
    end
    v2, v7 = v6:Validate(true)
    if not v2 then
        error(v7)
    end
    return v6:Run()
end

function u22.RunHooks(p1, p2, p3, ...) -- Line: 132 -- upvalues: RunService (val), u21 (ref)
    local v1
    if not p1.Registry.Hooks[p2] then
        error(("Invalid hook name: %q"):format(p2), 2)
    end
    if p2 == "BeforeRun"
        and #p1.Registry.Hooks[p2] == 0
        and p3.Group ~= "DefaultUtil"
        and p3.Group ~= "UserAlias"
        and p3:HasImplementation() then
        if not RunService:IsStudio() then
            return "Command blocked for security as no BeforeRun hook is configured."
        elseif u21 == false then
            local v2
            if not RunService:IsServer() then
                v2 = "<Client>"
            else
                v2 = "<Server>"
            end
            local v3 = v2 .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html"
            v2 = Color3.fromRGB(255, 228, 26)
            p3:Reply(v3, v2)
            u21 = true
        end
    end
    for i, v in ipairs(p1.Registry.Hooks[p2]) do
        v1 = v.callback(p3, ...)
        if v1 ~= nil then
            return (tostring(v1))
        end
    end
end

function u22:PushHistory(p2) -- Line: 164 -- upvalues: RunService (val), u17 (val), TeleportService (val)
    local v1 = RunService:IsClient()
    assert(v1, "PushHistory may only be used from the client.")
    local History = self:GetHistory()
    if u17.TrimString(p2) ~= "" and p2 ~= History[#History] then
        History[#History + 1] = p2
        TeleportService:SetTeleportSetting("CmdrCommandHistory", History)
        return
    end
end

function u22.GetHistory(p1) -- Line: 179 -- upvalues: RunService (val), TeleportService (val)
    local v1 = RunService:IsClient()
    assert(v1, "GetHistory may only be used from the client.")
    local TeleportSetting = TeleportService:GetTeleportSetting("CmdrCommandHistory")
    if not TeleportSetting then
        TeleportSetting = {}
    end
    return TeleportSetting
end

return function(p1) -- Line: 185 -- upvalues: u22 (val)
    u22.Cmdr = p1
    u22.Registry = p1.Registry
    return u22
end