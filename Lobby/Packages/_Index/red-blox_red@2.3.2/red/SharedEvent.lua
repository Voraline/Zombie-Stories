local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Identifier = require(script.Parent.Identifier)
local Spawn = require(script.Parent.Parent.Spawn)
local Signal = require(script.Parent.Parent.Signal)
local Net = require(script.Parent.Net)
local function FireClient(p1, p2, ...) -- Line: 43 -- upvalues: RunService (val), Net (val)
    local v1 = RunService:IsServer()
    assert(v1, "FireClient can only be called from the server")
    if p1.Unreliable then
        Net.Server.SendUnreliableEvent(p2, p1.Id, table.pack(...))
        return
    end
    Net.Server.SendReliableEvent(p2, p1.Id, table.pack(...))
end
local function FireAllClients(p1, ...) -- Line: 53 -- upvalues: RunService (val), Players (val), Net (val)
    local v1 = RunService:IsServer()
    assert(v1, "FireAllClients can only be called from the server")
    local v2 = table.pack(...)
    if p1.Unreliable then
        for k, n in Players:GetPlayers() do
            Net.Server.SendUnreliableEvent(n, p1.Id, v2)
        end
        return
    end
    for i, j in Players:GetPlayers() do
        Net.Server.SendReliableEvent(j, p1.Id, v2)
    end
end
local function FireAllClientsExcept(p1, p2, ...) -- Line: 69 -- upvalues: RunService (val), Players (val), Net (val)
    local v1 = RunService:IsServer()
    assert(v1, "FireAllClientsExcept can only be called from the server")
    local v2 = table.pack(...)
    if p1.Unreliable then
        for k, n in Players:GetPlayers() do
            if n ~= p2 then
                Net.Server.SendUnreliableEvent(n, p1.Id, v2)
            end
        end
        return
    end
    for i, j in Players:GetPlayers() do
        if j ~= p2 then
            Net.Server.SendReliableEvent(j, p1.Id, v2)
        end
    end
end
local function FireClients(p1, p2, ...) -- Line: 89 -- upvalues: RunService (val), Net (val)
    local v1, v2
    local v3 = RunService:IsServer()
    assert(v3, "FireClients can only be called from the server")
    local v4 = table.pack(...)
    if p1.Unreliable then
        v3 = p2
        v1 = nil
        v2 = nil
        for k, n in v3, v1, v2 do
            Net.Server.SendUnreliableEvent(n, p1.Id, v4)
        end
        return
    end
    v3 = p2
    v1 = nil
    v2 = nil
    for i, j in v3, v1, v2 do
        Net.Server.SendReliableEvent(j, p1.Id, v4)
    end
end
local function FireFilteredClients(p1, p2, ...) -- Line: 105 -- upvalues: RunService (val), Players (val), Net (val)
    local v1 = RunService:IsServer()
    assert(v1, "FireFilteredClients can only be called from the server")
    local v2 = table.pack(...)
    for i, j in Players:GetPlayers() do
        if p2(j) then
            if not p1.Unreliable then
                Net.Server.SendReliableEvent(j, p1.Id, v2)
            else
                Net.Server.SendUnreliableEvent(j, p1.Id, v2)
            end
        end
    end
end
local function FireServer(p1, ...) -- Line: 121 -- upvalues: RunService (val), Net (val)
    local v1 = RunService:IsClient()
    assert(v1, "FireServer can only be called from the client")
    local v2 = table.pack(...)
    if p1.Unreliable then
        Net.Client.SendUnreliableEvent(p1.Id, v2)
        return
    end
    Net.Client.SendReliableEvent(p1.Id, v2)
end
local function SetServerListener(p1, p2) -- Line: 133 -- upvalues: RunService (val)
    local v1 = RunService:IsServer()
    assert(v1, "SetServerListener can only be called from the server")
    p1.Listener = p2
end
local function SetClientListener(p1, p2) -- Line: 139 -- upvalues: RunService (val)
    local v1 = RunService:IsClient()
    assert(v1, "SetClientListener can only be called from the client")
    p1.Listener = p2
end
local function OnServer(p1, p2) -- Line: 145 -- upvalues: RunService (val)
    local v1 = RunService:IsServer()
    assert(v1, "OnServer can only be called from the server")
    return p1.Signal:Connect(p2)
end
local function OnClient(p1, p2) -- Line: 151 -- upvalues: RunService (val)
    local v1 = RunService:IsClient()
    assert(v1, "OnClient can only be called from the client")
    return p1.Signal:Connect(p2)
end
local function SharedBaseEvent(p1, p2) -- Line: 164 -- upvalues: Identifier (val), FireClient (val), FireAllClients (val), FireAllClientsExcept (val), FireClients (val), FireFilteredClients (val), FireServer (val)
    return {
        Id = Identifier.Shared(p1):Await(),
        Unreliable = p2,
        FireClient = FireClient,
        FireAllClients = FireAllClients,
        FireAllClientsExcept = FireAllClientsExcept,
        FireClients = FireClients,
        FireFilteredClients = FireFilteredClients,
        FireServer = FireServer,
    }
end
return {
    SharedCallEvent = function(p1, p2) -- Line: 181 -- upvalues: Identifier (val), FireClient (val), FireAllClients (val), FireAllClientsExcept (val), FireClients (val), FireFilteredClients (val), FireServer (val), SetServerListener (val), SetClientListener (val), RunService (val), Net (val), Spawn (val)
        local v1
        if typeof(p1) == "string" then
            v1 = {Unreliable = false, Name = p1}
        else
            v1 = p1
        end
        local u25 = {
            Id = Identifier.Shared(v1.Name):Await(),
            Unreliable = v1.Unreliable or false,
            FireClient = FireClient,
            FireAllClients = FireAllClients,
            FireAllClientsExcept = FireAllClientsExcept,
            FireClients = FireClients,
            FireFilteredClients = FireFilteredClients,
            FireServer = FireServer,
            CallMode = "Call",
            SetServerListener = SetServerListener,
            SetClientListener = SetClientListener,
            Listener = nil,
        }
        if RunService:IsServer() then
            Net.Server.SetListener(u25.Id, function(p1, a2) -- Line: 202 -- upvalues: Spawn (upval), u25 (val), p2 (val)
                Spawn(function(p1, ...) -- Line: 203 -- upvalues: u25 (upval), p2 (upval)
                    if u25.Listener and pcall(p2, ...) then
                        u25.Listener(p1, ...)
                    end
                end, p1, table.unpack(a2))
            end)
            return u25
        end
        Net.Client.SetListener(u25.Id, function(p1) -- Line: 210 -- upvalues: Spawn (upval), u25 (val), p2 (val)
            Spawn(function(...) -- Line: 211 -- upvalues: u25 (upval), p2 (upval)
                if u25.Listener and pcall(p2, ...) then
                    u25.Listener(...)
                end
            end, table.unpack(p1))
        end)
        return u25
    end,
    SharedSignalEvent = function(p1, p2) -- Line: 222 -- upvalues: Identifier (val), FireClient (val), FireAllClients (val), FireAllClientsExcept (val), FireClients (val), FireFilteredClients (val), FireServer (val), Signal (val), OnServer (val), OnClient (val), RunService (val), Net (val), Spawn (val)
        local v1
        if typeof(p1) == "string" then
            v1 = {Unreliable = false, Name = p1}
        else
            v1 = p1
        end
        local u25 = {
            Id = Identifier.Shared(v1.Name):Await(),
            Unreliable = v1.Unreliable or false,
            FireClient = FireClient,
            FireAllClients = FireAllClients,
            FireAllClientsExcept = FireAllClientsExcept,
            FireClients = FireClients,
            FireFilteredClients = FireFilteredClients,
            FireServer = FireServer,
            CallMode = "Signal",
            Signal = Signal(),
            OnServer = OnServer,
            OnClient = OnClient,
        }
        if RunService:IsServer() then
            Net.Server.SetListener(u25.Id, function(p1, a2) -- Line: 243 -- upvalues: Spawn (upval), p2 (val), u25 (val)
                Spawn(function(p1, ...) -- Line: 244 -- upvalues: p2 (upval), u25 (upval)
                    if pcall(p2, ...) then
                        u25.Signal:Fire(p1, ...)
                    end
                end, p1, table.unpack(a2))
            end)
            return u25
        end
        Net.Client.SetListener(u25.Id, function(p1) -- Line: 251 -- upvalues: Spawn (upval), p2 (val), u25 (val)
            Spawn(function(...) -- Line: 252 -- upvalues: p2 (upval), u25 (upval)
                if pcall(p2, ...) then
                    u25.Signal:Fire(...)
                end
            end, table.unpack(p1))
        end)
        return u25
    end,
}