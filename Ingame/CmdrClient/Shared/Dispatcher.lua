local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local u17 = require("./Util")
local u20 = require("./Command")
local u21 = false
local u22 = {
    Evaluate = function(self, p2, p3, p4, p5) -- Line: 21 -- upvalues: RunService (val), Players (val), u17 (val), u20 (val)
        local v1, v2
        if RunService:IsClient() == true and p3 ~= Players.LocalPlayer then
            error("Can't evaluate a command that isn't sent by the local player.")
        end
        local v3 = u17.SplitString(p2)
        local v4 = table.remove(v3, 1)
        local Command = self.Registry:GetCommand(v4)
        if not Command then
            return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(v4)))
        end
        v3 = u17.MashExcessArguments(v3, #Command.Args)
        local v5 = u20.new({
            Dispatcher = self,
            Text = p2,
            CommandObject = Command,
            Alias = v4,
            Executor = p3,
            Arguments = v3,
            Data = p5,
        })
        v2, v1 = v5:Parse(p4)
        if v2 then
            return v5
        end
        return false, v1
    end,
    EvaluateAndRun = function(p1, p2, p3, p4) -- Line: 58 -- upvalues: Players (val), RunService (val)
        local u38, v1, v2, v3, v4
        local LocalPlayer = p3
        if not LocalPlayer then
            LocalPlayer = Players.LocalPlayer
        end
        local v5 = p4
        if not v5 then
            v5 = {}
        end
        local v6 = v5
        if RunService:IsClient() and v6.IsHuman then
            p1:PushHistory(p2)
        end
        u38, v1 = p1:Evaluate(p2, LocalPlayer, nil, v6.Data)
        if not u38 then
            return v1
        end
        v2, v3 = xpcall(function() -- Line: 72 -- upvalues: u38 (val)
            local v1, v2
            v1, v2 = u38:Validate(true)
            if not v1 then
                return v2
            end
            return u38:Run() or "Command executed."
        end, function(p1) -- Line: 80
            return debug.traceback((tostring(p1)))
        end)
        if not v2 then
            warn(("Error occurred while evaluating command string %q\n%s"):format(p2, (tostring(v3))))
        end
        if not v2 then
            v4 = "An error occurred while running this command. Check the console for more information."
        else
            v4 = v3
            if not v4 then
                v4 = "An error occurred while running this command. Check the console for more information."
            end
        end
        return v4
    end,
    Send = function(p1, p2, p3) -- Line: 92 -- upvalues: RunService (val)
        if RunService:IsClient() == false then
            error("Dispatcher:Send can only be called from the client.")
        end
        return p1.Cmdr.RemoteFunction:InvokeServer(p2, {Data = p3})
    end,
    Run = function(self, ...) -- Line: 104 -- upvalues: Players (val)
        local v1, v2
        if not Players.LocalPlayer then
            error("Dispatcher:Run can only be called from the client.")
        end
        local v3 = {...}
        local v4 = v3[1]
        local v5 = #v3
        local v6 = 1
        for i = 2, v5, v6 do
            v4 = v4 .. " " .. tostring(v3[i])
        end
        v5, v6 = self:Evaluate(v4, Players.LocalPlayer)
        if not v5 then
            error(v6)
        end
        v1, v2 = v5:Validate(true)
        if not v1 then
            error(v2)
        end
        return v5:Run()
    end,
    RunHooks = function(p1, p2, p3, ...) -- Line: 132 -- upvalues: RunService (val), u21 (ref)
        if not (p1.Registry.Hooks[p2]) then
            local v1 = ("Invalid hook name: %q"):format(p2)
            error(v1, 2)
        end
        if p2 ~= "BeforeRun" then
            local v2
            for i, v in ipairs(p1.Registry.Hooks[p2]) do
                v2 = v.callback(p3, ...)
                if v2 ~= nil then
                    return (tostring(v2))
                end
            end
            return
        elseif #p1.Registry.Hooks[p2] == 0 and p3.Group ~= "DefaultUtil" and p3.Group ~= "UserAlias" and p3:HasImplementation() then
            if not (RunService:IsStudio()) then
                return "Command blocked for security as no BeforeRun hook is configured."
            elseif u21 == false then
                local v3
                if not (RunService:IsServer()) then
                    v3 = "<Client>"
                else
                    v3 = "<Server>"
                end
                p3:Reply(v3 .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26))
                u21 = true
            end
        end
    end,
    PushHistory = function(self, p2) -- Line: 164 -- upvalues: RunService (val), u17 (val), TeleportService (val)
        local v1 = RunService:IsClient()
        assert(v1, "PushHistory may only be used from the client.")
        local History = self:GetHistory()
        if u17.TrimString(p2) == "" or p2 == History[#History] then
            return
        end
        History[#History + 1] = p2
        TeleportService:SetTeleportSetting("CmdrCommandHistory", History)
    end,
    GetHistory = function(p1) -- Line: 179 -- upvalues: RunService (val), TeleportService (val)
        local v1 = RunService:IsClient()
        assert(v1, "GetHistory may only be used from the client.")
        local TeleportSetting = TeleportService:GetTeleportSetting("CmdrCommandHistory")
        if not TeleportSetting then
            TeleportSetting = {}
        end
        return TeleportSetting
    end,
}
return function(p1) -- Line: 185 -- upvalues: u22 (val)
    u22.Cmdr = p1
    u22.Registry = p1.Registry
    return u22
end