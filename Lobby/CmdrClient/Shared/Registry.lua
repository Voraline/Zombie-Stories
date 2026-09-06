local RunService = game:GetService("RunService")
local u7 = require("./Util")
local u8 = {
    TypeMethods = u7.MakeDictionary({
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
    }),
    CommandMethods = u7.MakeDictionary({
        "Name",
        "Aliases",
        "AutoExec",
        "Description",
        "Args",
        "Run",
        "ClientRun",
        "Data",
        "Group",
    }),
    CommandArgProps = u7.MakeDictionary({
        "Name",
        "Type",
        "Description",
        "Optional",
        "Default",
    }),
    Types = {},
    TypeAliases = {},
    Commands = {},
    CommandsArray = {},
    Hooks = {BeforeRun = {}, AfterRun = {}},
}
local v1 = {}
u8.Stores = setmetatable(v1, {
    __index = function(p1, p2) -- Line: 20
        p1[p2] = {}
        return p1[p2]
    end,
})
local v2 = {}
u8.AutoExecBuffer = v2
function u8.RegisterType(p1, p2, p3) -- Line: 30
    if not p2 then
        error("Invalid type name provided: nil")
    elseif typeof(p2) == "string" then
    end
    if not (p2:find("^[%d%l]%w*$")) then
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
        p1:RegisterTypePrefix(p2, p3.Prefixes)
    end
end
function u8:RegisterTypePrefix(p2, p3) -- Line: 59
    if not (self.TypeAliases[p2]) then
        self.TypeAliases[p2] = p2
    end
    self.TypeAliases[p2] = ("%s %s"):format(self.TypeAliases[p2], p3)
end
function u8.RegisterTypeAlias(p1, p2, p3) -- Line: 67
    local v1 = p1.TypeAliases[p2] == nil
    assert(v1, ("Type alias %s already exists!"):format(p3))
    p1.TypeAliases[p2] = p3
end
function u8:RegisterTypesIn(p2) -- Line: 73
    local v1
    for k, v in pairs(p2:GetChildren()) do
        if not (v:IsA("ModuleScript")) then
            self:RegisterTypesIn(v)
        else
            v.Parent = self.Cmdr.ReplicatedRoot.Types
            v1 = require(v)
            v1(self)
        end
    end
end
u8.RegisterHooksIn = u8.RegisterTypesIn
function u8:RegisterCommandObject(p2, p3) -- Line: 90 -- upvalues: RunService (val)
    local v1, v2
    for k in pairs(p2) do
        if self.CommandMethods[k] == nil then
            error("Unknown key/method in command " .. (p2.Name or "unknown command") .. ": " .. k)
        end
    end
    if not p2.Args then
        v2, v1 = p2, self
    else
        v1, v2 = self, p2
        for k2, v in pairs(p2.Args) do
            if type(v) == "table" then
                for k3 in pairs(v) do
                    if v1.CommandArgProps[k3] == nil then
                        error(("Unknown property in command \"%s\" argument #%d: %s"):format(v2.Name or "unknown", k2, k3))
                    end
                end
            end
        end
    end
    if v2.AutoExec and RunService:IsClient() then
        table.insert(v1.AutoExecBuffer, v2.AutoExec)
        v1:FlushAutoExecBufferDeferred()
    end
    local v3 = v1.Commands[v2.Name:lower()]
    if not v3 then
        if not v3 then
            table.insert(v1.CommandsArray, v2)
        end
    elseif v3.Aliases then
        local v4
        for k4, i in pairs(v3.Aliases) do
            v4 = i:lower()
            v1.Commands[v4] = nil
        end
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
    assert(v2, (("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(p2.Name, (typeof(v1)))))
    if p3 then
        v2 = RunService:IsServer()
        assert(v2, "The commandServerScript parameter is not valid for client usage.")
        v1.Run = require(p3)
    end
    if not p4 then
        self:RegisterCommandObject(v1)
        p2.Parent = self.Cmdr.ReplicatedRoot.Commands
        return
    end
    if not (p4(v1)) then
        return
    end
    self:RegisterCommandObject(v1)
    p2.Parent = self.Cmdr.ReplicatedRoot.Commands
end
function u8:RegisterCommandsIn(p2, p3) -- Line: 157
    local v1, v2, v3, v4
    local v5 = {}
    local v6 = {}
    v2, v4, v1 = p2, p3, self
    for k, v in pairs(p2:GetChildren()) do
        if not (v:IsA("ModuleScript")) then
            v1:RegisterCommandsIn(v, v4)
        elseif v.Name:find("Server") then
            v5[v] = true
        else
            v3 = v2:FindFirstChild(v.Name .. "Server")
            if v3 then
                v6[v3] = true
            end
            v1:RegisterCommand(v, v3, v4)
        end
    end
    for k2 in pairs(v5) do
        if not (v6[k2]) then
            warn("Command script " .. k2.Name .. " was skipped because it has 'Server' in its name, and has no equivalent shared script.")
        end
    end
end
function u8.RegisterDefaultCommands(p1, p2) -- Line: 187 -- upvalues: RunService (val), u7 (val)
    local u20, v1
    local v2 = RunService:IsServer()
    assert(v2, "RegisterDefaultCommands cannot be called from the client.")
    local v3 = type(p2) == "table"
    if not v3 then
        u20 = p2
    else
        u20 = u7.MakeDictionary(p2)
    end
    local DefaultCommandsFolder = p1.Cmdr.DefaultCommandsFolder
    if not v3 then
        v1 = u20
    else
        function v1(p1) -- Line: 196 -- upvalues: u20 (ref)
            return u20[p1.Group] or false
        end
        if not v1 then
            v1 = u20
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
    local v1 = {}
    for k, v in pairs(p1.CommandsArray) do
        table.insert(v1, v.Name)
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
    if not (p1.Hooks[p2]) then
        local v1 = ("Invalid hook name: %q"):format(p2)
        error(v1, 2)
    end
    table.insert(p1.Hooks[p2], {callback = p3, priority = p4 or 0})
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
    self.AutoExecFlushConnection = RunService.Heartbeat:Connect(function() -- Line: 272 -- upvalues: self (val)
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