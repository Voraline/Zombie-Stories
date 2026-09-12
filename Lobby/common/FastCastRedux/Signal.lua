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
    local v2 = u11
    return (setmetatable(v1, v2))
end

local function NewConnection(p1, p2) -- Line: 53 -- upvalues: u13 (val)
    local v1 = {Index = -1, Signal = p1, Delegate = p2}
    local v2 = u13
    return (setmetatable(v1, v2))
end

local function ThreadAndReportError(p1, p2, p3) -- Line: 62 -- upvalues: TestService (val)
    local v1 = coroutine.create(function() -- Line: 63 -- upvalues: p1 (val), p2 (val)
        local v1 = p1
        local v2 = p2
        v1(unpack(v2))
    end)
    local v2, v3 = coroutine.resume(v1)
    if not v2 then
        local v4 = TestService
        local v5 = string.format("Exception thrown in your %s event handler: %s", p3, v3)
        v4:Error(v5)
        v4 = TestService
        v5 = debug.traceback(v1)
        v4:Checkpoint(v5)
    end
end

function u11.Connect(p1, p2) -- Line: 75 -- upvalues: u11 (val), u13 (val), u10 (val)
    local v1 = (getmetatable(p1)) == u11
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Connect",
        "Signal.new()"
    )
    assert(v1, v2)
    v1 = {Index = -1, Signal = p1, Delegate = p2}
    local v3 = u13
    local v4 = setmetatable(v1, v3)
    v4.Index = #p1.Connections + 1
    u10.insert(p1.Connections, v4.Index, v4)
    return v4
end

function u11.Fire(p1, ...) -- Line: 83 -- upvalues: u11 (val), u10 (val), ThreadAndReportError (val)
    local v1
    local v2 = (getmetatable(p1)) == u11
    local v3 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Fire",
        "Signal.new()"
    )
    assert(v2, v3)
    local v4 = u10.pack(...)
    local Connections = p1.Connections
    local YieldingThreads = p1.YieldingThreads
    local v5 = #Connections
    for i = 1, v5 do
        v1 = Connections[i]
        if v1.Delegate ~= nil then
            ThreadAndReportError(v1.Delegate, v4, v1.Signal.Name)
        end
    end
    v5 = #YieldingThreads
    for j = 1, v5 do
        v1 = YieldingThreads[j]
        if v1 ~= nil then
            coroutine.resume(v1, ...)
        end
    end
end

function u11.FireSync(p1, ...) -- Line: 103 -- upvalues: u11 (val), u10 (val)
    local v1
    local v2 = (getmetatable(p1)) == u11
    local v3 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "FireSync",
        "Signal.new()"
    )
    assert(v2, v3)
    local v4 = u10.pack(...)
    local Connections = p1.Connections
    local YieldingThreads = p1.YieldingThreads
    local v5 = #Connections
    for i = 1, v5 do
        v1 = Connections[i]
        if v1.Delegate ~= nil then
            v1.Delegate(unpack(v4))
        end
    end
    v5 = #YieldingThreads
    for j = 1, v5 do
        v1 = YieldingThreads[j]
        if v1 ~= nil then
            coroutine.resume(v1, ...)
        end
    end
end

function u11.Wait(p1) -- Line: 123 -- upvalues: u11 (val), u10 (val)
    local v1 = (getmetatable(p1)) == u11
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Wait",
        "Signal.new()"
    )
    assert(v1, v2)
    v1 = coroutine.running()
    u10.insert(p1.YieldingThreads, v1)
    local v3 = {coroutine.yield()}
    u10.removeObject(p1.YieldingThreads, v1)
    return unpack(v3)
end

function u11.Dispose(p1) -- Line: 133 -- upvalues: u11 (val)
    local v1 = (getmetatable(p1)) == u11
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Dispose",
        "Signal.new()"
    )
    assert(v1, v2)
    local Connections = p1.Connections
    v1 = #Connections
    for i = 1, v1 do
        Connections[i]:Disconnect()
    end
    p1.Connections = {}
    setmetatable(p1, nil)
end

function u13:Disconnect() -- Line: 143 -- upvalues: u13 (val), u10 (val)
    local v1 = (getmetatable(self)) == u13
    local v2 = ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format(
        "Disconnect",
        "private function NewConnection()"
    )
    assert(v1, v2)
    u10.remove(self.Signal.Connections, self.Index)
    self.SignalStatic = nil
    self.Delegate = nil
    self.YieldingThreads = {}
    self.Index = -1
    setmetatable(self, nil)
end

return u11