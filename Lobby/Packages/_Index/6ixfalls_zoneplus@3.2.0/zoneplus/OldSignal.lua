local HttpService = game:GetService("HttpService")
local Heartbeat = game:GetService("RunService").Heartbeat
local u11 = {}
u11.__index = u11
u11.ClassName = "Signal"
u11.totalConnections = 0
function u11.new(p1) -- Line: 12 -- upvalues: u11 (val)
    local v1 = setmetatable({}, u11)
    if p1 then
        v1.connectionsChanged = u11.new()
    end
    v1.connections = {}
    v1.totalConnections = 0
    v1.waiting = {}
    v1.totalWaiting = 0
    return v1
end
function u11:Fire(, ...) -- Line: 30
    for k, v in pairs(self.connections) do
        task.spawn(v.Handler, ...)
    end
    if 0 < self.totalWaiting then
        local v1 = table.pack(...)
        for k2, i in pairs(self.waiting) do
            self.waiting[k2] = v1
        end
    end
end
u11.fire = u11.Fire
function u11.Connect(p1, p2) -- Line: 44 -- upvalues: HttpService (val)
    if type(p2) ~= "function" then
        local v1 = ("connect(%s)"):format((typeof(p2)))
        error(v1, 2)
    end
    local u19 = HttpService:GenerateGUID(false)
    local u20 = {Connected = true, ConnectionId = u19, Handler = p2}
    p1.connections[u19] = u20
    function u20.Disconnect(a1) -- Line: 57 -- upvalues: p1 (val), u19 (val), u20 (val)
        p1.connections[u19] = nil
        u20.Connected = false
        local v1 = p1
        v1.totalConnections = v1.totalConnections - 1
        if p1.connectionsChanged then
            p1.connectionsChanged:Fire(-1)
        end
    end
    u20.Destroy = u20.Disconnect
    u20.destroy = u20.Disconnect
    u20.disconnect = u20.Disconnect
    p1.totalConnections = p1.totalConnections + 1
    if p1.connectionsChanged then
        p1.connectionsChanged:Fire(1)
    end
    return u20
end
u11.connect = u11.Connect
function u11:Wait() -- Line: 77 -- upvalues: HttpService (val), Heartbeat (val)
    local v1 = HttpService:GenerateGUID(false)
    self.waiting[v1] = true
    self.totalWaiting = self.totalWaiting + 1
    while true do
        Heartbeat:Wait()
        if self.waiting[v1] ~= true then
            break
        end
    end
    self.totalWaiting = self.totalWaiting - 1
    local v2 = self.waiting[v1]
    self.waiting[v1] = nil
    return unpack(v2)
end
u11.wait = u11.Wait
function u11:Destroy() -- Line: 89
    if self.bindableEvent then
        self.bindableEvent:Destroy()
        self.bindableEvent = nil
    end
    if self.connectionsChanged then
        self.connectionsChanged:Fire(-self.totalConnections)
        self.connectionsChanged:Destroy()
        self.connectionsChanged = nil
    end
    self.totalConnections = 0
    for k, v in pairs(self.connections) do
        self.connections[k] = nil
    end
end
u11.destroy = u11.Destroy
u11.Disconnect = u11.Destroy
u11.disconnect = u11.Destroy
return u11