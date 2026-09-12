local RunService = game:GetService("RunService")
local Future = require(script.Parent.Parent.Future)
local Spawn = require(script.Parent.Parent.Spawn)
local Net = require(script.Parent.Net)
local Identifier = require(script.Parent.Identifier)

local function SetCallback(p1, p2) -- Line: 22 -- upvalues: RunService (val), Net (val), Spawn (val)
    local v1 = RunService:IsServer()
    assert(v1, "Cannot set callback to function on client")
    local v2 = Net
    v2.Server.SetListener(p1.Id, function(p1_2, p2_2) -- Line: 25 -- upvalues: Spawn (upval), p1 (val), Net (upval), p2 (val)
        local v1 = table.remove(p2_2, 1)
        if type(v1) ~= "string" then
            return
        end
        local v2 = Spawn
        v2(function(p1_2, p2_2, ...) -- Line: 32 -- upvalues: p1 (upval), Net (upval), p2 (upval)
            if pcall(p1.Validate, ...) then
                Net.Server.SendCallReturn(p1_2, p2_2, table.pack(pcall(p2, p1_2, ...)))
            end
        end, p1_2, v1, unpack(p2_2))
    end)
end

local function Call(p1, ...) -- Line: 40 -- upvalues: Future (val), Identifier (val), Net (val)
    local v1 = Future
    return v1.new(function(...) -- Line: 41 -- upvalues: Identifier (upval), Net (upval), p1 (val)
        local v1 = Identifier
        v1 = v1.Unique()
        local v2 = Net
        local CallAsync = v2.Client.CallAsync
        local v3 = p1
        local Id = v3.Id
        local v4 = table.pack(v1, ...)
        v2 = CallAsync(Id, v4)
        return unpack(v2)
    end, ...)
end

return function(p1, p2, p3) -- Line: 48 -- upvalues: Identifier (val), SetCallback (val), Call (val)
    local v1 = not Identifier.Exists(p1)
    assert(v1, "Cannot use same name twice")
    return {Id = Identifier.Shared(p1):Await(), Validate = p2, SetCallback = SetCallback, Call = Call}
end