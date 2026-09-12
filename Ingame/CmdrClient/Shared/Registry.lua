local RunService = game:GetService("RunService")
local u7 = require("./Util")
local u8 = {}
local MakeDictionary = u7.MakeDictionary
u8.TypeMethods = MakeDictionary({
    "Transform",
    "Validate",
    "Autocomplete",
    "Parse",
    "DisplayName",
    "Listable",
    "ValidateOnce",
    "Prefixes",
    "Default",
    "ArgumentOperatorAliases",
})
local MakeDictionary_2 = u7.MakeDictionary
u8.CommandMethods = MakeDictionary_2({"Name", "Aliases", "AutoExec", "Description", "Args", "Run", "ClientRun", "Data", "Group"})
local MakeDictionary_3 = u7.MakeDictionary
u8.CommandArgProps = MakeDictionary_3({"Name", "Type", "Description", "Optional", "Default"})
u8.Types = {}
u8.TypeAliases = {}
u8.Commands = {}
u8.CommandsArray = {}
u8.Hooks = {BeforeRun = {}, AfterRun = {}}
local v1 = {
    __index = function(p1, p2) -- Line: 20
        p1[p2] = {}
        return p1[p2]
    end,
}
u8.Stores = setmetatable({}, v1)
u8.AutoExecBuffer = {}

function u8.RegisterType(p1, p2, p3) -- Line: 30
    if not p2 or typeof(p2) ~= "string" then
        error("Invalid type name provided: nil")
    end
    if not p2:find("^[%d%l]%w*$") then
        error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p2))
    end
    for k in pairs(p3) do
        if p1.TypeMethods[k] == nil then
            error("Unknown key/method in type \"" .. p2 .. "\": " .. k)
        end
    end
    if p1.Types[p2] ~= nil then
        error(("Type \"%s\" has already been registered."):format(p2))
    end
    p3.Name = p2
    p3.DisplayName = p3.DisplayName or p2
    p1.Types[p2] = p3
    if p3.Prefixes then
        local Prefixes = p3.Prefixes
        p1:RegisterTypePrefix(p2, Prefixes)
    end
end

function u8:RegisterTypePrefix(p2, p3) -- Line: 59
    if not self.TypeAliases[p2] then
        self.TypeAliases[p2] = p2
    end
    local TypeAliases = self.TypeAliases
    local v1 = self.TypeAliases[p2]
    TypeAliases[p2] = (("%s %s"):format(v1, p3))
end

function u8.RegisterTypeAlias(p1, p2, p3) -- Line: 67
    local v1 = p1.TypeAliases[p2] == nil
    local v2 = ("Type alias %s already exists!"):format(p3)
    assert(v1, v2)
    p1.TypeAliases[p2] = p3
end

function u8:RegisterTypesIn(p2) -- Line: 73
    for k, v in pairs(p2:GetChildren()) do
        if not v:IsA("ModuleScript") then
            self:RegisterTypesIn(v)
        else
            v.Parent = self.Cmdr.ReplicatedRoot.Types
            require(v)(self)
        end
    end
end

u8.RegisterHooksIn = u8.RegisterTypesIn

function u8:RegisterCommandObject(p2, p3) -- Line: 90 -- upvalues: RunService (val)
    local CommandsArray, v1, v2
    for k in pairs(p2) do
        if self.CommandMethods[k] == nil then
            error("Unknown key/method in command " .. (p2.Name or "unknown command") .. ": " .. k)
        end
    end
    if not p2.Args then
        v2, v1 = p2, self
    else
        local v3, v4
        v1, v2 = self, p2
        for k2, v in pairs(p2.Args) do
            if type(v) == "table" then
                for k3 in pairs(v) do
                    if v1.CommandArgProps[k3] == nil then
                        v3 = error
                        v4 = v2.Name or "unknown"
                        v3(("Unknown property in command \"%s\" argument #%d: %s"):format(v4, k2, k3))
                    end
                end
            end
        end
    end
    if v2.AutoExec and RunService:IsClient() then
        local AutoExecBuffer = v1.AutoExecBuffer
        local AutoExec = v2.AutoExec
        table.insert(AutoExecBuffer, AutoExec)
        v1:FlushAutoExecBufferDeferred()
    end
    local v5 = v1.Commands[v2.Name:lower()]
    if not v5 then
        if not v5 then
            CommandsArray = v1.CommandsArray
            table.insert(CommandsArray, v2)
        end
    elseif v5.Aliases then
        local Commands, v6
        for k4, i in pairs(v5.Aliases) do
            Commands = v1.Commands
            v6 = i:lower()
            Commands[v6] = nil
        end
    elseif not v5 then
        CommandsArray = v1.CommandsArray
        table.insert(CommandsArray, v2)
    end
    v1.Commands[v2.Name:lower()] = v2
    if v2.Aliases then
        for k5, j in pairs(v2.Aliases) do
            v1.Commands[j:lower()] = v2
        end
    end
end

function u8:RegisterCommand(p2, p3, p4) -- Line: 135 -- upvalues: RunService (val)
    local v1 = require(p2)
    local v2 = typeof(v1) == "table"
    local Name = p2.Name
    local v3 = typeof(v1)
    local v4 = ("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(Name, v3)
    assert(v2, v4)
    if p3 then
        v2 = RunService:IsServer()
        assert(v2, "The commandServerScript parameter is not valid for client usage.")
        v1.Run = require(p3)
    end
    if p4 and not p4(v1) then
        return
    end
    self:RegisterCommandObject(v1)
    p2.Parent = self.Cmdr.ReplicatedRoot.Commands
end

function u8:RegisterCommandsIn(p2, p3) -- Line: 157
    local v1, v2
    local v3 = {}
    local v4 = {}
    local v5, v6, v7 = p2, p3, self
    for k, v in pairs(p2:GetChildren()) do
        if not v:IsA("ModuleScript") then
            v7:RegisterCommandsIn(v, v6)
        elseif v.Name:find("Server") then
            v3[v] = true
        else
            v2 = v.Name .. "Server"
            v1 = v5:FindFirstChild(v2)
            if v1 then
                v4[v1] = true
            end
            v7:RegisterCommand(v, v1, v6)
        end
    end
    for k2 in pairs(v3) do
        if not v4[k2] then
            warn("Command script " .. k2.Name .. " was skipped because it has 'Server' in its name, and has no equivalent shared script.")
        end
    end
end

function u8.RegisterDefaultCommands(p1, p2) -- Line: 187 -- upvalues: RunService (val), u7 (val)
    local v1
    local v2 = RunService:IsServer()
    assert(v2, "RegisterDefaultCommands cannot be called from the client.")
    local v3 = p2
    local v4 = type(v3) == "table"
    if v4 then
        p2 = u7.MakeDictionary(p2)
    end
    local DefaultCommandsFolder = p1.Cmdr.DefaultCommandsFolder
    if not v4 then
        v1 = p2
    else
        function v1(p1) -- Line: 196 -- upvalues: p2 (ref)
            return p2[p1.Group] or false
        end

        if not v1 then
            v1 = p2
        end
    end
    p1:RegisterCommandsIn(DefaultCommandsFolder, v1)
end

function u8.GetCommand(p1, p2) -- Line: 202
    return p1.Commands[(p2 or ""):lower()]
end

function u8.GetCommands(p1) -- Line: 208
    return p1.CommandsArray
end

function u8.GetCommandNames(p1) -- Line: 213
    local Name
    local v1 = {}
    for k, v in pairs(p1.CommandsArray) do
        Name = v.Name
        table.insert(v1, Name)
    end
    return v1
end

u8.GetCommandsAsStrings = u8.GetCommandNames

function u8.GetTypeNames(p1) -- Line: 226
    local v1 = {}
    for k in pairs(p1.Types) do
        table.insert(v1, k)
    end
    return v1
end

function u8.GetType(p1, p2) -- Line: 238
    return p1.Types[p2]
end

function u8.GetTypeName(p1, p2) -- Line: 243
    return p1.TypeAliases[p2] or p2
end

function u8.RegisterHook(p1, p2, p3, p4) -- Line: 248
    if not p1.Hooks[p2] then
        error(("Invalid hook name: %q"):format(p2), 2)
    end
    local v1 = p1.Hooks[p2]
    local v2 = {callback = p3, priority = p4 or 0}
    table.insert(v1, v2)
    table.sort(p1.Hooks[p2], function(p1, p2) -- Line: 254
        local v1 = p1.priority < p2.priority
        return v1
    end)
end

u8.AddHook = u8.RegisterHook

function u8.GetStore(p1, p2) -- Line: 262
    return p1.Stores[p2]
end

function u8:FlushAutoExecBufferDeferred() -- Line: 267 -- upvalues: RunService (val)
    if self.AutoExecFlushConnection then
        return
    end
    local v1 = RunService
    local Heartbeat = v1.Heartbeat
    self.AutoExecFlushConnection = Heartbeat:Connect(function() -- Line: 272 -- upvalues: self (val)
        self.AutoExecFlushConnection:Disconnect()
        self.AutoExecFlushConnection = nil
        self:FlushAutoExecBuffer()
    end)
end

function u8:FlushAutoExecBuffer() -- Line: 280
    local v1 = self
    for i, v in ipairs(self.AutoExecBuffer) do
        for i2, i3 in ipairs(v) do
            v1.Cmdr.Dispatcher:EvaluateAndRun(i3)
        end
    end
    v1.AutoExecBuffer = {}
end

return function(p1) -- Line: 290 -- upvalues: u8 (val)
    u8.Cmdr = p1
    return u8
end