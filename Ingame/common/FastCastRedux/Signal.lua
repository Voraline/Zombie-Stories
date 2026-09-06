require("./TypeDefinitions")
local TestService = game:GetService("TestService")
local u10 = require("./Table")
local u11 = {}
u11.__index = u11
u11.__type = "Signal"
local u13 = {}
u13.__index = u13
u13.__type = "SignalConnection"
function u11.new(p1) -- Line: 44 -- upvalues: u11 (val)
    local v1 = {Name = p1, Connections = {}, YieldingThreads = {}}
    return (setmetatable(v1, u11))
end
local function NewConnection(p1, p2) -- Line: 53 -- upvalues: u13 (val)
    local v1 = {Index = -1, Signal = p1, Delegate = p2}
    return (setmetatable(v1, u13))
end
local function ThreadAndReportError(p1, p2, p3) -- Line: 62 -- upvalues: TestService (val)
    local v1, v2
    local v3 = coroutine.create(function() -- Line: 63 -- upvalues: p1 (val), p2 (val)
        p1(unpack(p2))
    end)
    v1, v2 = coroutine.resume(v3)
    if not v1 then
        TestService:Error(string.format("Exception thrown in your %s event handler: %s", p3, v2))
        TestService:Checkpoint(debug.traceback(v3))
    end
end
function u11.Connect(p1, p2) -- Line: 75 -- upvalues: u11 (val), u13 (val), u10 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u11
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Connect", "Signal.new()"))
    local v3 = setmetatable({Index = -1, Signal = p1, Delegate = p2}, u13)
    v3.Index = #p1.Connections + 1
    u10.insert(p1.Connections, v3.Index, v3)
    return v3
end
function u11.Fire(p1, ...) -- Line: 83 -- upvalues: u11 (val), u10 (val), ThreadAndReportError (val)
    local v1
    local v2 = getmetatable(p1)
    local v3 = v2 == u11
    assert(v3, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Fire", "Signal.new()"))
    local v4 = u10.pack(...)
    local Connections = p1.Connections
    local YieldingThreads = p1.YieldingThreads
    local v5 = #Connections
    local v6 = 1
    for i = 1, v5, v6 do
        v1 = Connections[i]
        if v1.Delegate ~= nil then
            ThreadAndReportError(v1.Delegate, v4, v1.Signal.Name)
        end
    end
    v5 = #YieldingThreads
    v6 = 1
    for j = 1, v5, v6 do
        v1 = YieldingThreads[j]
        if v1 ~= nil then
            coroutine.resume(v1, ...)
        end
    end
end
function u11.FireSync(p1, ...) -- Line: 103 -- upvalues: u11 (val), u10 (val)
    local v1
    local v2 = getmetatable(p1)
    local v3 = v2 == u11
    assert(v3, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("FireSync", "Signal.new()"))
    local v4 = u10.pack(...)
    local Connections = p1.Connections
    local YieldingThreads = p1.YieldingThreads
    local v5 = #Connections
    local v6 = 1
    for i = 1, v5, v6 do
        v1 = Connections[i]
        if v1.Delegate ~= nil then
            v1.Delegate(unpack(v4))
        end
    end
    v5 = #YieldingThreads
    v6 = 1
    for j = 1, v5, v6 do
        v1 = YieldingThreads[j]
        if v1 ~= nil then
            coroutine.resume(v1, ...)
        end
    end
end
function u11.Wait(p1) -- Line: 123 -- upvalues: u11 (val), u10 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u11
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Wait", "Signal.new()"))
    local v3 = {}
    v2 = coroutine.running()
    u10.insert(p1.YieldingThreads, v2)
    v3 = {coroutine.yield()}
    u10.removeObject(p1.YieldingThreads, v2)
    return unpack(v3)
end
function u11.Dispose(p1) -- Line: 133 -- upvalues: u11 (val)
    local v1 = getmetatable(p1)
    local v2 = v1 == u11
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "Signal.new()"))
    local Connections = p1.Connections
    v2 = #Connections
    v1 = 1
    for i = 1, v2, v1 do
        Connections[i]:Disconnect()
    end
    p1.Connections = {}
    setmetatable(p1, nil)
end
function u13:Disconnect() -- Line: 143 -- upvalues: u13 (val), u10 (val)
    local v1 = getmetatable(self)
    local v2 = v1 == u13
    assert(v2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Disconnect", "private function NewConnection()"))
    u10.remove(self.Signal.Connections, self.Index)
    self.SignalStatic = nil
    self.Delegate = nil
    self.YieldingThreads = {}
    self.Index = -1
    setmetatable(self, nil)
end
return u11