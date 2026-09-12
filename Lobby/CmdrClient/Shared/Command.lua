local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local u12 = require("./Argument")
local u15 = RunService:IsServer()
local u16 = {}
u16.__index = u16

function u16.new(p1) -- Line: 12 -- upvalues: u16 (val)
    local v1 = {
        Dispatcher = p1.Dispatcher,
        Cmdr = p1.Dispatcher.Cmdr,
        Name = p1.CommandObject.Name,
        RawText = p1.Text,
        Object = p1.CommandObject,
        Group = p1.CommandObject.Group,
        State = {},
        Aliases = p1.CommandObject.Aliases,
        Alias = p1.Alias,
        Description = p1.CommandObject.Description,
        Executor = p1.Executor,
        ArgumentDefinitions = p1.CommandObject.Args,
        RawArguments = p1.Arguments,
        Arguments = {},
        Data = p1.Data,
    }
    local v2 = u16
    setmetatable(v1, v2)
    return v1
end

function u16.Parse(p1, p2) -- Line: 40 -- upvalues: u12 (val)
    local Name, Name_2, v1, v2, v3
    local v4 = false
    local v5 = p1
    for i, v in ipairs(p1.ArgumentDefinitions) do
        if type(v) == "function" then
            v = v(v5)
            if v == nil then
                break
            end
        end
        v2 = false
        if v.Default == nil then
            v2 = v.Optional ~= true
        end
        if not v2 then
            if not v2 then
                v4 = true
            end
        elseif v4 then
            v3 = error
            Name = v5.Name
            v3(("Command %q: Required arguments cannot occur after optional arguments."):format(Name))
        elseif not v2 then
            v4 = true
        end
        if v5.RawArguments[i] == nil and v2 and v1 ~= true then
            Name_2 = v.Name
            return false, ("Required argument #%d %s is missing."):format(i, Name_2)
        end
        if v5.RawArguments[i] or v1 then
            v5.Arguments[i] = (u12.new(v5, v, v5.RawArguments[i] or ""))
        end
    end
    return true
end

function u16:Validate(p2) -- Line: 72
    local Name, v1, v2
    self._Validated = true
    local v3 = ""
    local v4 = true
    for k, v in pairs(self.Arguments) do
        v2, v1 = v:Validate(p2)
        if not v2 then
            v4 = false
            Name = v.Name
            v3 = ("%s; #%d %s: %s"):format(v3, k, Name, v1 or "error")
        end
    end
    return v4, v3:sub(3)
end

function u16.GetLastArgument(p1) -- Line: 91
    for i = #p1.Arguments, 1, -1 do
        if p1.Arguments[i].RawValue then
            return p1.Arguments[i]
        end
    end
end

function u16:GatherArgumentValues() -- Line: 100
    local v1, v2
    local v3 = {}
    local v4 = #self.ArgumentDefinitions
    local v5 = self
    for i = 1, v4 do
        v1 = v5.Arguments[i]
        if not v1 then
            v2 = v5.ArgumentDefinitions[i]
            if type(v2) == "table" then
                v3[i] = v5.ArgumentDefinitions[i].Default
            end
        else
            v3[i] = (v1:GetValue())
        end
    end
    return v3, #v5.ArgumentDefinitions
end

function u16.Run(p1) -- Line: 117 -- upvalues: u15 (val)
    local v1, v2
    if p1._Validated == nil then
        error("Must validate a command before running.")
    end
    local v3 = p1.Dispatcher:RunHooks("BeforeRun", p1)
    if v3 then
        return v3
    end
    if not u15 and p1.Object.Data and p1.Data == nil then
        v1, v2 = p1:GatherArgumentValues()
        p1.Data = p1.Object.Data(p1, unpack(v1, 1, v2))
    end
    if not u15 and p1.Object.ClientRun then
        v1, v2 = p1:GatherArgumentValues()
        p1.Response = p1.Object.ClientRun(p1, unpack(v1, 1, v2))
    end
    if p1.Response == nil then
        if p1.Object.Run then
            v1, v2 = p1:GatherArgumentValues()
            p1.Response = p1.Object.Run(p1, unpack(v1, 1, v2))
        elseif not u15 then
            local Dispatcher = p1.Dispatcher
            local RawText = p1.RawText
            local Data = p1.Data
            p1.Response = Dispatcher:Send(RawText, Data)
        else
            if not p1.Object.ClientRun then
                warn(p1.Name, "command has no implementation!")
            else
                warn(
                    p1.Name,
                    "command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command."
                )
            end
            p1.Response = "No implementation."
        end
    end
    v1 = p1.Dispatcher:RunHooks("AfterRun", p1)
    if v1 then
        return v1
    end
    return p1.Response
end

function u16.GetArgument(p1, p2) -- Line: 164
    return p1.Arguments[p2]
end

function u16.GetData(p1) -- Line: 172 -- upvalues: u15 (val)
    if p1.Data then
        return p1.Data
    end
    if p1.Object.Data and not u15 then
        p1.Data = p1.Object.Data(p1)
    end
    return p1.Data
end

function u16:SendEvent(p2, p3, ...) -- Line: 185 -- upvalues: u15 (val), Players (val)
    local v1 = typeof(p2) == "Instance"
    assert(v1, "Argument #1 must be a Player")
    v1 = p2:IsA("Player")
    assert(v1, "Argument #1 must be a Player")
    v1 = type(p3) == "string"
    assert(v1, "Argument #2 must be a string")
    if u15 then
        self.Dispatcher.Cmdr.RemoteEvent:FireClient(p2, p3, ...)
        return
    end
    if self.Dispatcher.Cmdr.Events[p3] then
        v1 = p2 == Players.LocalPlayer
        assert(v1, "Event messages can only be sent to the local player on the client.")
        self.Dispatcher.Cmdr.Events[p3](...)
    end
end

function u16.BroadcastEvent(p1, ...) -- Line: 199 -- upvalues: u15 (val)
    if not u15 then
        error("Can't broadcast event messages from the client.", 2)
    end
    p1.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...)
end

function u16.Reply(p1, ...) -- Line: 208
    local Executor = p1.Executor
    return p1:SendEvent(Executor, "AddLine", ...)
end

function u16:GetStore(...) -- Line: 213
    return self.Dispatcher.Cmdr.Registry:GetStore(...)
end

function u16.HasImplementation(p1) -- Line: 218 -- upvalues: RunService (val)
    if RunService:IsClient() and p1.Object.ClientRun then
        return true
    end
    if p1.Object.Run then
        return true
    end
    return false
end

return u16