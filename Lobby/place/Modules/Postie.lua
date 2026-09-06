local Received, Sent
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
if not (script:FindFirstChild("Sent")) then
    local RemoteEvent = Instance.new("RemoteEvent")
    RemoteEvent.Name = "Sent"
    RemoteEvent.Parent = script
end
if not (script:FindFirstChild("Received")) then
    local RemoteEvent_2 = Instance.new("RemoteEvent")
    RemoteEvent_2.Name = "Received"
    RemoteEvent_2.Parent = script
end
Sent = script.Sent
Received = script.Received
local u43 = RunService:IsServer()
local u44 = {}
local u45 = {}
local function spawnNow(p1, ...) -- Line: 97
    local BindableEvent = Instance.new("BindableEvent")
    local u6 = table.pack(...)
    BindableEvent.Event:Connect(function() -- Line: 100 -- upvalues: p1 (val), u6 (val)
        p1(table.unpack(u6, 1, u6.n))
    end)
    BindableEvent:Fire()
    BindableEvent:Destroy()
end
local v1 = {
    InvokeClient = function(p1, p2, p3, ...) -- Line: 112 -- upvalues: u43 (val), u45 (val), HttpService (val), spawnNow (val), Sent (val)
        local u43
        assert(u43, "Postie.InvokeClient can only be called from the server")
        local v1 = typeof(p1) == "string"
        assert(v1, "bad argument #1 to Postie.InvokeClient, expects string")
        v1 = if typeof(p2) == "Instance" then p2:IsA("Player") else false
        assert(v1, "bad argument #2 to Postie.InvokeClient, expects Instance<Player>")
        v1 = typeof(p3) == "number"
        assert(v1, "bad argument #3 to Postie.InvokeClient, expects number")
        local BindableEvent = Instance.new("BindableEvent")
        u43 = false
        local u46 = #u45 + 1
        local u51 = HttpService:GenerateGUID(false)
        u45[u46] = function(p1, a2, ...) -- Line: 123 -- upvalues: p2 (val), u51 (val), u43 (ref), u45 (upval), u46 (val), BindableEvent (val)
            if p1 ~= p2 or a2 ~= u51 then
                return false
            end
            u43 = true
            table.remove(u45, u46)
            BindableEvent:Fire(true, ...)
            return true
        end
        spawnNow(function() -- Line: 131 -- upvalues: p3 (val), u43 (ref), u45 (upval), u46 (val), BindableEvent (val)
            task.wait(p3)
            if u43 then
                return
            end
            table.remove(u45, u46)
            BindableEvent:Fire(false)
        end)
        Sent:FireClient(p2, p1, u51, ...)
        return BindableEvent.Event:Wait()
    end,
    InvokeServer = function(p1, p2, ...) -- Line: 143 -- upvalues: u43 (val), u45 (val), HttpService (val), spawnNow (val), Sent (val)
        local v1 = not u43
        assert(v1, "Postie.InvokeServer can only be called from the client")
        v1 = typeof(p1) == "string"
        assert(v1, "bad argument #1 to Postie.InvokeServer, expects string")
        v1 = typeof(p2) == "number"
        assert(v1, "bad argument #2 to Postie.InvokeServer, expects number")
        local BindableEvent = Instance.new("BindableEvent")
        local u29 = false
        local u32 = #u45 + 1
        local u37 = HttpService:GenerateGUID(false)
        u45[u32] = function(p1, ...) -- Line: 153 -- upvalues: u37 (val), u29 (ref), u45 (upval), u32 (val), BindableEvent (val)
            if p1 ~= u37 then
                return false
            end
            u29 = true
            table.remove(u45, u32)
            BindableEvent:Fire(true, ...)
            return true
        end
        spawnNow(function() -- Line: 161 -- upvalues: p2 (val), u29 (ref), u45 (upval), u32 (val), BindableEvent (val)
            task.wait(p2)
            if u29 then
                return
            end
            table.remove(u45, u32)
            BindableEvent:Fire(false)
        end)
        Sent:FireServer(p1, u37, ...)
        return BindableEvent.Event:Wait()
    end,
    SetCallback = function(p1, p2) -- Line: 173 -- upvalues: u44 (val)
        local v1 = typeof(p1) == "string"
        assert(v1, "bad argument #1 to Postie.SetCallback, expects string")
        u44[p1] = p2
    end,
    GetCallback = function(p1) -- Line: 179 -- upvalues: u44 (val)
        local v1 = typeof(p1) == "string"
        assert(v1, "bad argument #1 to Postie.GetCallback, expects string")
        return u44[p1]
    end,
}
if u43 then
    Received.OnServerEvent:Connect(function(...) -- Line: 189 -- upvalues: u45 (val)
        for i, v in ipairs(u45) do
            if v(...) then
                return
            end
        end
    end)
    Sent.OnServerEvent:Connect(function(p1, p2, p3, ...) -- Line: 195 -- upvalues: u44 (val), Received (val)
        local v1 = u44[p2]
        local v2 = v1
        if v2 then
            v2 = v1(p1, ...)
        end
        Received:FireClient(p1, p3, v2)
    end)
    return v1
end
Received.OnClientEvent:Connect(function(...) -- Line: 201 -- upvalues: u45 (val)
    for i, v in ipairs(u45) do
        if v(...) then
            return
        end
    end
end)
Sent.OnClientEvent:Connect(function(p1, p2, ...) -- Line: 207 -- upvalues: u44 (val), Received (val)
    local v1 = u44[p1]
    local v2 = v1
    if v2 then
        v2 = v1(...)
    end
    Received:FireServer(p2, v2)
end)
return v1