local RunService = game:GetService("RunService")
local Identifier = require(script.Parent.Identifier)
local Server = require(script.Server)
local Client = require(script.Client)
local function Server_2(p1) -- Line: 21 -- upvalues: RunService (val), Server (val)
    local v1 = RunService:IsServer()
    assert(v1, "Server events can only be accessed from the server")
    if not p1.ServerEvent then
        p1.ServerEvent = Server(p1.Id, p1.Validate, p1.Unreliable)
    end
    return p1.ServerEvent
end
local function Client_2(p1) -- Line: 31 -- upvalues: RunService (val), Client (val)
    local v1 = RunService:IsClient()
    assert(v1, "Client events can only be accessed from the client")
    if not p1.ClientEvent then
        p1.ClientEvent = Client(p1.Id, p1.Unreliable)
    end
    return p1.ClientEvent
end
return function(p1, p2) -- Line: 46 -- upvalues: Identifier (val), Server_2 (val), Client_2 (val)
    local Name, v1
    if type(p1) ~= "string" then
        Name = p1.Name
        v1 = p1.Unreliable or false
    else
        Name = p1
        v1 = false
    end
    local v2 = not Identifier.Exists(Name)
    assert(v2, "Cannot use same name twice")
    return {
        Id = Identifier.Shared(Name):Await(),
        Validate = p2,
        Unreliable = v1,
        Server = Server_2,
        Client = Client_2,
    }
end