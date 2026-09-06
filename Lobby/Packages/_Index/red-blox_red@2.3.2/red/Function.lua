local RunService = game:GetService("RunService")
local Future = require(script.Parent.Parent.Future)
local Spawn = require(script.Parent.Parent.Spawn)
local Net = require(script.Parent.Net)
local Identifier = require(script.Parent.Identifier)
local function SetCallback(p1, p2) -- Line: 22 -- upvalues: RunService (val), Net (val), Spawn (val)
    local v1 = RunService:IsServer()
    assert(v1, "Cannot set callback to function on client")
    Net.Server.SetListener(p1.Id, function(a1, a2) -- Line: 25 -- upvalues: Spawn (upval), p1 (val), Net (upval), p2 (val)
        local v1 = table.remove(a2, 1)
        if type(v1) ~= "string" then
            return
        end
        Spawn(function(a1, a2, ...) -- Line: 32 -- upvalues: p1 (upval), Net (upval), p2 (upval)
            if pcall(p1.Validate, ...) then
                Net.Server.SendCallReturn(a1, a2, table.pack(pcall(p2, a1, ...)))
            end
        end, a1, v1, unpack(a2))
    end)
end
local function Call(p1, ...) -- Line: 40 -- upvalues: Future (val), Identifier (val), Net (val)
    return Future.new(function(...) -- Line: 41 -- upvalues: Identifier (upval), Net (upval), p1 (val)
        return unpack(Net.Client.CallAsync(p1.Id, table.pack(Identifier.Unique(), ...)))
    end, ...)
end
return function(p1, p2, p3) -- Line: 48 -- upvalues: Identifier (val), SetCallback (val), Call (val)
    local v1 = not Identifier.Exists(p1)
    assert(v1, "Cannot use same name twice")
    return {Id = Identifier.Shared(p1):Await(), Validate = p2, SetCallback = SetCallback, Call = Call}
end