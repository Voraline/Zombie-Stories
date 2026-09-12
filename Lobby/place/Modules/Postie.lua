local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
if not script:FindFirstChild("Sent") then
    local RemoteEvent = Instance.new("RemoteEvent")
    RemoteEvent.Name = "Sent"
    RemoteEvent.Parent = script
end
if not script:FindFirstChild("Received") then
    local RemoteEvent_2 = Instance.new("RemoteEvent")
    RemoteEvent_2.Name = "Received"
    RemoteEvent_2.Parent = script
end
local Sent = script.Sent
local Received = script.Received
local u43 = RunService:IsServer()
local u44 = {}
local u45 = {}

local function spawnNow(p1, ...) -- Line: 97
    local BindableEvent = Instance.new("BindableEvent")
    local u6 = table.pack(...)
    BindableEvent.Event:Connect(function() -- Line: 100 -- upvalues: p1 (val), u6 (val)
        local v1 = p1
        local v2 = u6
        local v3 = u6
        local n = v3.n
        v1(table.unpack(v2, 1, n))
    end)
    BindableEvent:Fire()
    BindableEvent:Destroy()
end

local v1 = {
    InvokeClient = function(p1, p2, p3, ...) -- Line: 112 -- upvalues: u43 (val), u45 (val), HttpService (val), spawnNow (val), Sent (val)
        local v1 = u43
        assert(v1, "Postie.InvokeClient can only be called from the server")
        v1 = typeof(p1) == "string"
        assert(v1, "bad argument #1 to Postie.InvokeClient, expects string")
        v1 = false
        if typeof(p2) == "Instance" then
            v1 = p2:IsA("Player")
        end
        assert(v1, "bad argument #2 to Postie.InvokeClient, expects Instance<Player>")
        v1 = typeof(p3) == "number"
        assert(v1, "bad argument #3 to Postie.InvokeClient, expects number")
        local BindableEvent = Instance.new("BindableEvent")
        local u43_2 = false
        local u46 = #u45 + 1
        local u51 = HttpService:GenerateGUID(false)
        local v2 = u45

        v2[u46] = function(p1, p2_2, ...) -- Line: 123
            -- upvalues: p2 (val), u51 (val), u43_2 (ref), u45 (upval), u46 (val), BindableEvent (val)
            if p1 == p2 and p2_2 == u51 then
                u43_2 = true
                table.remove(u45, u46)
                BindableEvent:Fire(true, ...)
                return true
            end
            return false
        end

        v2 = spawnNow
        v2(function() -- Line: 131 -- upvalues: p3 (val), u43_2 (ref), u45 (upval), u46 (val), BindableEvent (val)
            task.wait(p3)
            if u43_2 then
                return
            end
            table.remove(u45, u46)
            BindableEvent:Fire(false)
        end)
        Sent:FireClient(p2, p1, u51, ...)
        v2 = BindableEvent.Event:Wait()
        return v2
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
        local v2 = u45

        v2[u32] = function(p1, ...) -- Line: 153 -- upvalues: u37 (val), u29 (ref), u45 (upval), u32 (val), BindableEvent (val)
            if p1 ~= u37 then
                return false
            end
            u29 = true
            table.remove(u45, u32)
            BindableEvent:Fire(true, ...)
            return true
        end

        v2 = spawnNow
        v2(function() -- Line: 161 -- upvalues: p2 (val), u29 (ref), u45 (upval), u32 (val), BindableEvent (val)
            task.wait(p2)
            if u29 then
                return
            end
            table.remove(u45, u32)
            BindableEvent:Fire(false)
        end)
        Sent:FireServer(p1, u37, ...)
        v2 = BindableEvent.Event:Wait()
        return v2
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
        local v2 = Received
        local v3 = v1
        if v3 then
            v3 = v1(p1, ...)
        end
        v2:FireClient(p1, p3, v3)
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
    local v2 = Received
    local v3 = v1
    if v3 then
        v3 = v1(...)
    end
    v2:FireServer(p2, v3)
end)
return v1