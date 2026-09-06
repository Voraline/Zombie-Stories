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
    setmetatable(v1, u16)
    return v1
end
function u16.Parse(p1, p2) -- Line: 40 -- upvalues: u12 (val)
    local v1, v2
    local v3 = false
    local v4 = p1
    for i, v in ipairs(p1.ArgumentDefinitions) do
        if type(v) == "function" then
            v = v(v4)
            if v == nil then
                break
            end
        end
        v2 = if v.Default == nil then v.Optional ~= true else false
        if not v2 then
            if not v2 then
                v3 = true
            end
        elseif v3 then
            error(("Command %q: Required arguments cannot occur after optional arguments."):format(v4.Name))
        end
        if v4.RawArguments[i] == nil and v2 and v1 ~= true then
            return false, ("Required argument #%d %s is missing."):format(i, v.Name)
        end
        if v4.RawArguments[i] then
            v4.Arguments[i] = u12.new(v4, v, v4.RawArguments[i] or "")
        elseif not v1 then
        end
    end
    return true
end
function u16:Validate(p2) -- Line: 72
    local v1, v2
    self._Validated = true
    local v3 = ""
    local v4 = true
    for k, v in pairs(self.Arguments) do
        v2, v1 = v:Validate(p2)
        if not v2 then
            v4 = false
            v3 = ("%s; #%d %s: %s"):format(v3, k, v.Name, v1 or "error")
        end
    end
    return v4, v3:sub(3)
end
function u16.GetLastArgument(p1) -- Line: 91
    local v1 = 1
    local v2 = -1
    for i = #p1.Arguments, v1, v2 do
        if p1.Arguments[i].RawValue then
            return p1.Arguments[i]
        end
    end
end
function u16:GatherArgumentValues() -- Line: 100
    local v1
    local v2 = {}
    local v3 = #self.ArgumentDefinitions
    local v4 = 1
    local v5 = self
    for i = 1, v3, v4 do
        v1 = v5.Arguments[i]
        if v1 then
            v2[i] = v1:GetValue()
        elseif type(v5.ArgumentDefinitions[i]) == "table" then
            v2[i] = v5.ArgumentDefinitions[i].Default
        end
    end
    return v2, #v5.ArgumentDefinitions
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
            p1.Response = p1.Dispatcher:Send(p1.RawText, p1.Data)
        else
            if not p1.Object.ClientRun then
                warn(p1.Name, "command has no implementation!")
            else
                warn(p1.Name, "command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command.")
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
    return p1:SendEvent(p1.Executor, "AddLine", ...)
end
function u16:GetStore(, ...) -- Line: 213
    return self.Dispatcher.Cmdr.Registry:GetStore(...)
end
function u16.HasImplementation(p1) -- Line: 218 -- upvalues: RunService (val)
    if not (RunService:IsClient()) then
        if p1.Object.Run then
            return true
        end
        return false
    end
    if p1.Object.ClientRun or p1.Object.Run then
        return true
    end
    return false
end
return u16