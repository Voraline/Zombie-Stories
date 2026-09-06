local u58, u63, v1
local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local u16 = {}
local u17 = {}
local u20 = RunService:IsStudio()
local u23 = RunService:IsServer()
local u24 = nil
local function GetParamString(...) -- Line: 67
    local format, v1, v2, v3, v4, v5, v6
    local v7 = table.pack(...)
    local v8 = math.min(10, v7.n)
    local v9 = v8
    local v10 = 1
    for i = 1, v9, v10 do
        local u14 = v7[i]
        v3 = typeof(v7[i])
        if v3 == "string" then
            format = string.format
            if #u14 > 18 then
                v1 = u14:sub(1, 15)
                v6 = v1 .. "..."
            else
                v6 = u14
            end
            v7[i] = format("%q[%d]", v6, #u14)
        elseif v3 ~= "Instance" then
            v7[i] = v3
        else
            v4, v5 = pcall(function() -- Line: 78 -- upvalues: u14 (val)
                return u14.ClassName
            end)
            if not v4 then
                v6 = v3
            else
                v6 = string.format("%s<%s>", v3, v5)
            end
            v7[i] = v6
        end
    end
    v10 = table.concat(v7, ", ", 1, v8)
    if v8 >= v7.n then
        v2 = ""
    else
        v2 = string.format(", ... (%d more)", v7.n - v8)
        if not v2 then
            v2 = ""
        end
    end
    return v10 .. v2
end
local u26 = {}
local u27 = 0
if not u23 then
    v1 = ReplicatedStorage:WaitForChild("Communication")
    u58 = v1:WaitForChild("Functions")
    u63 = v1:WaitForChild("Events")
else
    v1 = Instance.new("Folder", ReplicatedStorage)
    v1.Name = "Communication"
    u58 = Instance.new("Folder", v1)
    u58.Name = "Functions"
    u63 = Instance.new("Folder", v1)
    u63.Name = "Events"
end
local BindableEvent = Instance.new("BindableEvent")
function FastSpawn(p1, ...) -- Line: 111 -- upvalues: BindableEvent (val)
    local v1 = coroutine.wrap(function(...) -- Line: 112 -- upvalues: BindableEvent (upval), p1 (val)
        BindableEvent.Event:Wait()
        p1(...)
    end)
    v1(...)
    BindableEvent:Fire()
end
function YieldThread() -- Line: 120 -- upvalues: BindableEvent (val)
    return (function(...) -- Line: 125 -- upvalues: BindableEvent (upval)
        BindableEvent.Event:Wait()
        return ...
    end)(coroutine.yield())
end
function ResumeThread(p1, ...) -- Line: 128 -- upvalues: BindableEvent (val)
    coroutine.resume(p1, ...)
    BindableEvent:Fire()
end
function SafeInvokeCallback(p1, ...) -- Line: 137 -- upvalues: u23 (val), Players (val)
    local u4
    local u1 = false
    local u2 = nil
    local u3 = nil
    local function finish(...) -- Line: 143 -- upvalues: u1 (ref), u4 (ref), u3 (ref)
        if not u1 then
            u1 = true
            u4 = table.pack(...)
            if u3 then
                ResumeThread(u3)
            end
        end
    end
    FastSpawn(function(...) -- Line: 154 -- upvalues: u2 (ref), finish (val), p1 (val)
        u2 = coroutine.running()
        finish(true, p1.Callback(...))
    end, ...)
    if not u1 then
        local u11 = u23
        if u11 then
            u11 = ...
        end
        coroutine.wrap(function() -- Line: 162 -- upvalues: u1 (ref), u2 (ref), u23 (upval), u11 (val), Players (upval), finish (val)
            while not u1 do
                if coroutine.status(u2) == "dead" then
                    break
                end
                if u23 and u11.Parent ~= Players then
                    break
                end
                wait(0.5)
            end
            finish(false)
        end)()
    end
    if not u1 then
        YieldThread()
    end
    return unpack(nil)
end
function SafeInvoke(p1, p2, ...) -- Line: 183 -- upvalues: u23 (val)
    local u3 = coroutine.running()
    local u4 = false
    local u5 = nil
    local v1 = coroutine.wrap(function(...) -- Line: 188 -- upvalues: u23 (upval), u5 (ref), p2 (val), u4 (ref), u3 (val)
        if not u23 then
            u5 = table.pack(pcall(function(...) -- Line: 192 -- upvalues: p2 (upval)
                return p2.Remote:InvokeServer(...)
            end, ...))
        else
            u5 = table.pack(pcall(function(...) -- Line: 190 -- upvalues: p2 (upval)
                return p2.Remote:InvokeClient(...)
            end, ...))
        end
        if not u4 then
            u4 = true
            ResumeThread(u3)
        end
    end)
    v1(...)
    if typeof(p1) == "number" then
        delay(p1, function() -- Line: 202 -- upvalues: u4 (ref), u3 (val)
            if not u4 then
                u4 = true
                ResumeThread(u3)
            end
        end)
    end
    YieldThread()
    if not u5 or u5[1] ~= true then
        return false
    end
    if u5[2] == true then
        return true, unpack(u5, 3)
    end
    return false
end
function SafeFireEvent(p1, ...) -- Line: 219
    local Callbacks = p1.Callbacks
    local u2 = #Callbacks
    while 0 < u2 do
        local u5 = true
        FastSpawn(function(...) -- Line: 226 -- upvalues: u5 (ref), u2 (ref), Callbacks (val)
            local v1
            while u5 do
                if 0 >= u2 then
                    break
                end
                v1 = Callbacks[u2]
                u2 = u2 - 1
                v1(...)
            end
        end, ...)
    end
end
function WaitForChild(p1, p2) -- Line: 240
    local u5 = p1:FindFirstChild(p2)
    if not u5 then
        local u7 = coroutine.running()
        local u8 = nil
        YieldThread()
    end
    return u5
end
function GetEventHandler(p1) -- Line: 261 -- upvalues: u16 (val), u63 (ref), u23 (val), u27 (ref), u20 (val)
    local v1 = u16[p1]
    if v1 then
        return v1
    end
    local u3 = {Name = p1, Folder = u63, Callbacks = {}}
    u16[p1] = u3
    if not u23 then
        FastSpawn(function() -- Line: 284 -- upvalues: u3 (val), u27 (upval), u20 (upval)
            u3.Queue = {}
            local u7 = WaitForChild(u3.Folder, u3.Name)
            u3.Remote = u7
            if #u3.Callbacks == 0 then
                u3.IncomingQueue = {}
            end
            u7.OnClientEvent:Connect(function(...) -- Line: 294 -- upvalues: u3 (upval), u7 (val), u27 (upval)
                if not u3.IncomingQueue then
                    SafeFireEvent(u3, ...)
                    return
                end
                local v1 = #u3.IncomingQueue
                if 2048 <= v1 then
                    if not u3.IncomingQueueErrored then
                        u3.IncomingQueueErrored = true
                        local v2 = string.format("Exhausted remote invocation queue for %s", u7:GetFullName())
                        FastSpawn(error, v2, -1)
                        delay(1, function() -- Line: 301 -- upvalues: u3 (upval)
                            u3.IncomingQueueErrored = nil
                        end)
                    end
                    v1 = #u3.IncomingQueue
                    if 8172 <= v1 then
                        table.remove(u3.IncomingQueue, 1)
                    end
                end
                u27 = u27 + 1
                table.insert(u3.IncomingQueue, table.pack(u27, u3, ...))
            end)
            if not u20 then
                u7.Name = ""
            end
            for k, v in pairs(u3.Queue) do
                v()
            end
            u3.Queue = nil
        end)
        return u3
    end
    local RemoteEvent = Instance.new("RemoteEvent")
    RemoteEvent.Name = u3.Name
    RemoteEvent.Parent = u3.Folder
    u3.Remote = RemoteEvent
    return u3
end
function GetFunctionHandler(p1) -- Line: 334 -- upvalues: u17 (val), u58 (ref), u23 (val), u27 (ref), u20 (val)
    local v1 = u17[p1]
    if v1 then
        return v1
    end
    local u3 = {Name = p1, Folder = u58}
    u17[p1] = u3
    if not u23 then
        FastSpawn(function() -- Line: 357 -- upvalues: u3 (val), u27 (upval), u20 (upval)
            u3.Queue = {}
            local u7 = WaitForChild(u3.Folder, u3.Name)
            u3.Remote = u7
            local v1 = {}
            u3.IncomingQueue = v1
            function u3.OnClientInvoke(...) -- Line: 364 -- upvalues: u3 (upval), u7 (val), u27 (upval)
                if not u3.Callback then
                    local v1 = #u3.IncomingQueue
                    if 2048 <= v1 then
                        if not u3.IncomingQueueErrored then
                            u3.IncomingQueueErrored = true
                            local v2 = string.format("Exhausted remote invocation queue for %s", u7:GetFullName())
                            FastSpawn(error, v2, -1)
                            delay(1, function() -- Line: 371 -- upvalues: u3 (upval)
                                u3.IncomingQueueErrored = nil
                            end)
                        end
                        v1 = #u3.IncomingQueue
                        if 8172 <= v1 then
                            table.remove(u3.IncomingQueue, 1)
                        end
                    end
                    u27 = u27 + 1
                    v1 = table.pack(u27, u3, coroutine.running())
                    table.insert(u3.IncomingQueue, v1)
                    YieldThread()
                end
                return SafeInvokeCallback(u3, ...)
            end
            if not u20 then
                u7.Name = ""
            end
            for k, v in pairs(u3.Queue) do
                v()
            end
            u3.Queue = nil
        end)
        return u3
    end
    local RemoteFunction = Instance.new("RemoteFunction")
    RemoteFunction.Name = u3.Name
    RemoteFunction.Parent = u3.Folder
    u3.Remote = RemoteFunction
    return u3
end
function AddToQueue(p1, p2, p3) -- Line: 406
    if p1.Remote then
        return p2()
    end
    p1.Queue[#p1.Queue + 1] = p2
    if p3 then
        delay(5, function() -- Line: 414 -- upvalues: p1 (val)
            if not p1.Remote then
                local FullName = p1.Folder:GetFullName()
                warn(debug.traceback(("Infinite yield possible on '%s:WaitForChild(\"%s\")'"):format(FullName, p1.Name)))
            end
        end)
    end
end
function ExecuteDeferredHandlers() -- Line: 422 -- upvalues: u26 (ref)
    local IncomingQueue, v1
    local v2 = {}
    local v3 = {}
    u26 = v3
    for k in pairs(u26) do
        IncomingQueue = k.IncomingQueue
        k.IncomingQueue = nil
        table.move(IncomingQueue, 1, #IncomingQueue, #v2 + 1, v2)
    end
    table.sort(v2, function(p1, p2) -- Line: 435
        local v1 = p1[1] < p2[1]
        return v1
    end)
    for i, v in ipairs(v2) do
        v1 = v[2]
        if not v1.Callbacks then
            ResumeThread(v[3])
        else
            SafeFireEvent(v1, unpack(v, 3))
        end
    end
end
local u87 = {
    MatchParams = function(p1, p2) -- Line: 449 -- upvalues: u23 (val), u20 (val)
        local v1, v2, v3, v4, v5, v6
        local u96 = {unpack(p2)}
        local u99 = 1
        local u93 = p1
        for k, v in pairs(u96) do
            if type(v) ~= "string" then
                v5 = v
            else
                v5 = string.split(v, "|")
            end
            v6 = {}
            v1 = ""
            for k2, i in pairs(v5) do
                v2 = i:gsub("^%s+", "")
                v2 = v2:gsub("%s+$", "")
                if 0 >= #v1 then
                    v4 = ""
                else
                    v4 = " or "
                end
                v1 = v1 .. v4 .. v2
                v3 = v2:lower()
                v6[v3] = true
            end
            v6._string = v1
            u96[k] = v6
        end
        if u23 then
            u99 = 2
            table.insert(u96, 1, false)
        end
        return function(p1, ...) -- Line: 475 -- upvalues: u96 (ref), u20 (upval), u93 (val), u99 (ref)
            local v1, v2, v3
            local v4 = table.pack(...)
            if #u96 < v4.n then
                if u20 then
                    warn(("[Network] Invalid number of parameters to %s (%s expected, got %s)"):format(u93, #u96 - u99 + 1, v4.n - u99 + 1))
                end
                return
            end
            local v5 = #u96
            local v6 = 1
            for i = u99, v5, v6 do
                v2 = typeof(v4[i])
                v3 = u96[i]
                if not (v3[v2:lower()]) and not v3.any then
                    if u20 then
                        warn(("[Network] Invalid parameter %d to %s (%s expected, got %s)"):format(i - u99 + 1, u93, v3._string, v2))
                    end
                    return
                end
            end
            return v1(...)
        end
    end,
}
function combineFn(self, p2, ...) -- Line: 504 -- upvalues: u87 (val), u24 (ref), GetParamString (val)
    local u8, v1
    local u2 = {...}
    if typeof(p2) ~= "table" then
        u8 = p2
    else
        v1 = p2
        u8 = p2[1]
        if v1.MatchParams then
            table.insert(u2, (u87.MatchParams(self.Name, v1.MatchParams)))
        end
    end
    return function(...) -- Line: 516 -- upvalues: u24 (upval), self (val), GetParamString (upval), u2 (val), u8 (ref)
        local runMiddleware
        if u24 then
            local v1 = u24[...]
            table.insert(v1[self.Remote].dataIn, GetParamString(select(2, ...)))
        end
        local u16 = 1
        function runMiddleware(p1, ...) -- Line: 524 -- upvalues: u16 (ref), u2 (upval), runMiddleware (val), u8 (upval)
            if p1 ~= u16 then
                return
            end
            u16 = u16 + 1
            if p1 <= #u2 then
                return u2[p1](function(...) -- Line: 532 -- upvalues: runMiddleware (upval), p1 (val)
                    return runMiddleware(p1 + 1, ...)
                end, ...)
            end
            return u8(...)
        end
        return runMiddleware(1, ...)
    end
end
function u0.BindEvents(p1, p2, p3) -- Line: 544 -- upvalues: u23 (val), u26 (ref)
    local Callbacks, v1, v2
    if typeof(p2) ~= "table" then
        v2, v1 = p3, p2
    else
        v2 = p2
        v1 = nil
    end
    for k, v in pairs(v2) do
        local u26 = GetEventHandler(k)
        if not u26 then
            error(("Tried to bind callback to non-existing RemoteEvent %q"):format(k))
        end
        Callbacks = u26.Callbacks
        Callbacks[#u26.Callbacks + 1] = combineFn(u26, v, v1)
        if u23 then
            u26.Remote.OnServerEvent:Connect(function(...) -- Line: 558 -- upvalues: u26 (val)
                SafeFireEvent(u26, ...)
            end)
        elseif u26.IncomingQueue then
            u26[u26] = true
        end
    end
    ExecuteDeferredHandlers()
end
function u0.BindFunctions(p1, p2, p3) -- Line: 571 -- upvalues: u23 (val), u26 (ref)
    local v1, v2
    if typeof(p2) ~= "table" then
        v2, v1 = p3, p2
    else
        v2 = p2
        v1 = nil
    end
    for k, v in pairs(v2) do
        local u26 = GetFunctionHandler(k)
        if not u26 then
            error(("Tried to bind callback to non-existing RemoteFunction %q"):format(k))
        end
        if u26.Callback then
            error(("Tried to bind multiple callbacks to the same RemoteFunction (%s)"):format(u26.Remote:GetFullName()))
        end
        u26.Callback = combineFn(u26, v, v1)
        if u23 then
            function u26.Remote.OnServerInvoke(...) -- Line: 589 -- upvalues: u26 (val)
                return SafeInvokeCallback(u26, ...)
            end
        elseif u26.IncomingQueue then
            u26[u26] = true
        end
    end
    ExecuteDeferredHandlers()
end
if not u23 then
    u63.ChildAdded:Connect(function(p1) -- Line: 773
        GetEventHandler(p1.Name)
    end)
    for k, v in pairs(u63:GetChildren()) do
        GetEventHandler(v.Name)
    end
    u58.ChildAdded:Connect(function(p1) -- Line: 776
        GetFunctionHandler(p1.Name)
    end)
    for i, i2 in ipairs(u58:GetChildren()) do
        GetFunctionHandler(i2.Name)
    end
    function u0.FireServer(p1, p2, ...) -- Line: 781
        local u4 = GetEventHandler(p2)
        if not u4 then
            error(("'%s' is not a valid RemoteEvent"):format(p2))
        end
        if u4.Remote then
            u4.Remote:FireServer(...)
            return
        end
        local u21 = table.pack(...)
        AddToQueue(u4, function() -- Line: 792 -- upvalues: u4 (val), u21 (val)
            u4.Remote:FireServer(unpack(u21))
        end, true)
    end
    function u0.InvokeServerWithTimeout(p1, p2, p3, ...) -- Line: 798
        local v1 = GetFunctionHandler(p3)
        if not v1 then
            error(("'%s' is not a valid RemoteFunction"):format(p3))
        end
        if not v1.Remote then
            local u16 = coroutine.running()
            AddToQueue(v1, function() -- Line: 810 -- upvalues: u16 (val)
                ResumeThread(u16)
            end, true)
            YieldThread()
        end
        local v2 = table.pack(SafeInvoke(p2, v1, ...))
        local v3 = v2[1] == true
        assert(v3, "InvokeServer error")
        return unpack(v2, 2)
    end
    function u0:InvokeServer(p2, ...) -- Line: 823
        return self:InvokeServerWithTimeout(nil, p2, ...)
    end
else
    function HandlerFireClient(self, p2, ...) -- Line: 606 -- upvalues: u24 (ref), GetParamString (val)
        if u24 then
            table.insert(u24[p2][self.Remote].dataOut, GetParamString(...))
        end
        return self.Remote:FireClient(p2, ...)
    end
    function u0.GetPlayers(p1) -- Line: 616 -- upvalues: Players (val)
        return Players:GetPlayers()
    end
    function u0.GetPlayerPosition(p1, p2) -- Line: 620
        local Position
        if not p2 then
            Position = nil
        elseif not p2.Character then
            Position = nil
        elseif not p2.Character.PrimaryPart then
            Position = nil
        else
            Position = p2.Character.PrimaryPart.Position
            if not Position then
                Position = nil
            end
        end
        return Position
    end
    function u0.FireClient(p1, p2, p3, ...) -- Line: 626
        local v1 = GetEventHandler(p3)
        if not v1 then
            error(("'%s' is not a valid RemoteEvent"):format(p3))
        end
        HandlerFireClient(v1, p2, ...)
    end
    function u0.FireAllClients(p1, p2, ...) -- Line: 635
        local v1 = GetEventHandler(p2)
        if not v1 then
            error(("'%s' is not a valid RemoteEvent"):format(p2))
        end
        for k, v in pairs(p1:GetPlayers()) do
            HandlerFireClient(v1, v, ...)
        end
    end
    function u0.FireOtherClients(p1, p2, p3, ...) -- Line: 646
        local v1 = GetEventHandler(p3)
        if not v1 then
            error(("'%s' is not a valid RemoteEvent"):format(p3))
        end
        for k, v in pairs(p1:GetPlayers()) do
            if v ~= p2 then
                HandlerFireClient(v1, v, ...)
            end
        end
    end
    function u0.FireOtherClientsWithinDistance(p1, p2, p3, p4, ...) -- Line: 659
        local PlayerPosition_2
        local v1 = GetEventHandler(p4)
        if not v1 then
            error(("'%s' is not a valid RemoteEvent"):format(p4))
        end
        local PlayerPosition = p1:GetPlayerPosition(p2)
        if not PlayerPosition then
            return
        end
        for k, v in pairs(p1:GetPlayers()) do
            if v ~= p2 then
                PlayerPosition_2 = p1:GetPlayerPosition(v)
                if PlayerPosition_2 and (PlayerPosition - PlayerPosition_2).Magnitude <= p3 then
                    HandlerFireClient(v1, v, ...)
                end
            end
        end
    end
    function u0.FireAllClientsWithinDistance(p1, p2, p3, p4, ...) -- Line: 681
        local PlayerPosition
        local v1 = GetEventHandler(p4)
        if not v1 then
            error(("'%s' is not a valid RemoteEvent"):format(p4))
        end
        for k, v in pairs(p1:GetPlayers()) do
            PlayerPosition = p1:GetPlayerPosition(v)
            if PlayerPosition and (p2 - PlayerPosition).Magnitude <= p3 then
                HandlerFireClient(v1, v, ...)
            end
        end
    end
    function u0.InvokeClientWithTimeout(p1, p2, p3, p4, ...) -- Line: 696
        local v1 = GetEventHandler(p4)
        if not v1 then
            error(("'%s' is not a valid RemoteEvent"):format(p4))
        end
        return SafeInvoke(p2, v1, p3, ...)
    end
    function u0:InvokeClient(, ...) -- Line: 705
        return self:InvokeClientWithTimeout(60, ...)
    end
    function u0.LogTraffic(p1, ...) -- Line: 710
        FastSpawn(p1.LogTrafficAsync, p1, ...)
    end
    function u0.LogTrafficAsync(p1, p2, p3) -- Line: 714 -- upvalues: u24 (ref)
        local dataIn, dataOut, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
        local v11 = p3
        if not v11 then
            v11 = warn
        end
        local v12 = v11
        if u24 then
            return
        end
        v12("Logging Network Traffic...")
        u24 = setmetatable({}, {
            __index = function(p1, p2) -- Line: 720
                p1[p2] = setmetatable({}, {
                    __index = function(p1, p2) -- Line: 721
                        p1[p2] = {dataIn = {}, dataOut = {}}
                        return p1[p2]
                    end,
                })
                return p1[p2]
            end,
        })
        wait(p2)
        local v13 = os.clock() - os.clock()
        u24 = nil
        for k, v in pairs(u24) do
            v1 = 0
            v2 = 0
            for k2, i in pairs(v) do
                v1 = v1 + #i.dataIn
                v2 = v2 + #i.dataOut
            end
            v12(string.format("Player '%s', total received/sent: %d/%d", k.Name, v1, v2))
            for k3, j in pairs(v) do
                dataIn = j.dataIn
                if 0 < #dataIn then
                    v12(string.format("   %s %s: %d (%.2f/s)", "FireServer", k3.Name, #dataIn, #dataIn / v13))
                    v3 = math.min(#dataIn, 3)
                    v4 = v3
                    v5 = 1
                    for k4 = 1, v4, v5 do
                        v9 = (k4 - 1) / math.max(1, v3 - 1)
                        v7 = math.floor(v9 * (#dataIn - 1) + 1 + 0.5)
                        v12(string.format("      %d: %s", v7, dataIn[v7]))
                    end
                end
                dataOut = j.dataOut
                if 0 < #dataOut then
                    v12(string.format("   %s %s: %d (%.2f/s)", "FireClient", k3.Name, #dataOut, #dataOut / v13))
                    v4 = math.min(#dataOut, 3)
                    v5 = v4
                    v6 = 1
                    for n = 1, v5, v6 do
                        v10 = (n - 1) / math.max(1, v4 - 1)
                        v8 = math.floor(v10 * (#dataOut - 1) + 1 + 0.5)
                        v12(string.format("      %d: %s", v8, dataOut[v8]))
                    end
                end
            end
        end
    end
end
local u154 = setmetatable({}, {
    __mode = "k",
    __index = function(p1, p2) -- Line: 832
        p1[p2] = {}
        return p1[p2]
    end,
})
local u159 = setmetatable({}, {
    __mode = "k",
    __index = function(p1, p2) -- Line: 833
        p1[p2] = {}
        return p1[p2]
    end,
})
local u160 = {
    "number",
    "string",
    "boolean",
    "nil",
    "Vector2",
    "Vector3",
    "CFrame",
    "Color3",
    "BrickColor",
    "UDim2",
    "UDim",
}
for i3, j in ipairs(u160) do
    u160[j] = true
end
local function addEntry(p1, p2) -- Line: 846 -- upvalues: u160 (val), u154 (val), u23 (val), u0 (val)
    local v1 = typeof(p1)
    if not (u160[v1]) then
        error(string.format("Invalid value passed to Network:Pack (values of type %s are not supported)", v1))
    end
    if v1 == "boolean" then
        return p1
    elseif v1 == "nil" then
        return p1
    else
        if p1 == "" then
            return p1
        end
        if v1 ~= "string" then
            local v2 = u154[p2]
            local v3 = v2[p1]
            if not v3 then
                local v4
                if #v2 >= 32 then
                    local v5
                    v5, v4 = p1, p2
                    for i, v in ipairs(v2) do
                        if not v3 then
                            v3 = v
                        elseif v.last >= v3.last then
                        end
                    end
                    v2[v3.value] = nil
                    v2[v5] = v3
                    v3.value = v5
                else
                    local v6 = #v2 + 1
                    v3 = {last = 0, char = string.char(v6), value = p1}
                    v2[v6] = v3
                    v2[p1] = v3
                    v4 = p2
                end
                if not u23 then
                    u0:FireServer("SetPackedValue", v3.char, v3.value)
                else
                    u0:FireClient(v4, "SetPackedValue", v3.char, v3.value)
                end
            end
            v3.last = os.clock()
            return v3.char
        elseif 64 < #p1 then
            return "\000" .. p1
        end
    end
end
local function getEntry(p1, p2) -- Line: 894 -- upvalues: u159 (val)
    if typeof(p1) ~= "string" or p1 == "" then
        return p1
    end
    local v1 = string.byte(p1, 1)
    if v1 == 0 then
        return (string.sub(p1, 2))
    end
    return u159[p2][v1]
end
if not u23 then
    function u0.Pack(p1, p2) -- Line: 939 -- upvalues: addEntry (val)
        return (addEntry(p2, "Server"))
    end
    function u0.Unpack(p1, p2) -- Line: 943 -- upvalues: u159 (val)
        if typeof(p2) ~= "string" or p2 == "" then
            return p2
        end
        local v1 = string.byte(p2, 1)
        if v1 == 0 then
            return (string.sub(p2, 2))
        end
        return u159.Server[v1]
    end
    u0:BindEvents({
        SetPackedValue = function(p1, p2) -- Line: 948 -- upvalues: u159 (val)
            u159.Server[string.byte(p1)] = p2
        end,
    })
else
    function u0.Pack(p1, p2, p3) -- Line: 909 -- upvalues: addEntry (val)
        local v1 = if typeof(p3) == "Instance" then p3:IsA("Player") else false
        assert(v1, "client is not a player")
        return (addEntry(p2, p3))
    end
    function u0.Unpack(p1, p2, p3) -- Line: 914 -- upvalues: u159 (val)
        local v1 = if typeof(p3) == "Instance" then p3:IsA("Player") else false
        assert(v1, "client is not a player")
        if typeof(p2) ~= "string" or p2 == "" then
            return p2
        end
        local v2 = string.byte(p2, 1)
        if v2 == 0 then
            return (string.sub(p2, 2))
        end
        return u159[p3][v2]
    end
    u0:BindEvents({
        SetPackedValue = function(p1, p2, p3) -- Line: 920 -- upvalues: u160 (val), u159 (val)
            if typeof(p2) ~= "string" or #p2 ~= 1 then
                return p1:Kick()
            end
            local v1 = string.byte(p2)
            if v1 < 1 or 32 < v1 then
                return p1:Kick()
            end
            local v2 = typeof(p3)
            if not (u160[v2]) then
                return p1:Kick()
            end
            if v2 ~= "string" then
                u159[p1][v1] = p3
                return
            end
            if 64 < #p3 then
                return p1:Kick()
            end
            u159[p1][v1] = p3
        end,
    })
end
local u205 = {Character = {}, CharacterPart = {}}
local u208 = {}
local u209 = {}
for k2, k3 in pairs(u205) do
    u208[k2] = {}
    u209[k2] = {}
end
function u0.AddReference(p1, p2, p3, ...) -- Line: 971 -- upvalues: u205 (val), u208 (val), u209 (val)
    local v1
    assert(u205[p3], "Invalid Reference Type")
    local v2 = {
        Type = p3,
        Reference = p2,
        Objects = {...},
        Aliases = {},
    }
    local v3 = u208[p3]
    v3[v2.Reference] = v2
    v3 = u209[p3]
    for i, v in ipairs(v2.Objects) do
        v1 = v3[v]
        if not v1 then
            v1 = {}
        end
        v3[v] = v1
        v3 = v1
    end
    v3.__Data = v2
end
function u0.AddReferenceAlias(p1, p2, p3, ...) -- Line: 994 -- upvalues: u205 (val), u208 (val), u209 (val)
    local v1
    assert(u205[p3], "Invalid Reference Type")
    local v2 = u208[p3][p2]
    if not v2 then
        warn("Tried to add an alias to a non-existing reference")
        return
    end
    local v3 = {...}
    v2.Aliases[#v2.Aliases + 1] = v3
    local v4 = u209[p3]
    for i, v in ipairs(v3) do
        v1 = v4[v]
        if not v1 then
            v1 = {}
        end
        v4[v] = v1
        v4 = v1
    end
    v4.__Data = v2
end
function u0.RemoveReference(p1, p2, p3) -- Line: 1017 -- upvalues: u205 (val), u208 (val), u209 (val)
    local rem, v1, v2
    assert(u205[p3], "Invalid Reference Type")
    local u11 = u208[p3][p2]
    if not u11 then
        warn("Tried to remove a non-existing reference")
        return
    end
    local v3 = u208[p3]
    v3[u11.Reference] = nil
    function rem(p1, p2, p3) -- Line: 1029 -- upvalues: rem (val), u11 (val)
        if p3 > #p2 then
            if p1.__Data == u11 then
                p1.__Data = nil
            end
            return
        end
        local v1 = p2[p3]
        local v2 = p1[v1]
        rem(v2, p2, p3 + 1)
        if next(v2) ~= nil then
            return
        end
        p1[v1] = nil
    end
    local v4 = u209[u11.Type]
    local Objects = u11.Objects
    if 1 <= #Objects then
        local v5 = Objects[1]
        local v6 = v4[v5]
        rem(v6, Objects, 2)
        if next(v6) == nil then
            v4[v5] = nil
        end
    elseif v4.__Data == u11 then
        v4.__Data = nil
    end
    for i, v in ipairs(u11.Aliases) do
        if 1 <= #v then
            v1 = v[1]
            v2 = v4[v1]
            rem(v2, v, 2)
            if next(v2) == nil then
                v4[v1] = nil
            end
        elseif v4.__Data == u11 then
            v4.__Data = nil
        end
    end
end
function u0.GetObject(p1, p2, p3) -- Line: 1052 -- upvalues: u205 (val), u208 (val)
    assert(u205[p3], "Invalid Reference Type")
    local v1 = u208[p3][p2]
    if not v1 then
        return nil
    end
    return unpack(v1.Objects)
end
function u0.GetReference(p1, ...) -- Line: 1063 -- upvalues: u205 (val), u209 (val)
    local Reference
    local v1 = {...}
    local v2 = table.remove(v1)
    assert(u205[v2], "Invalid Reference Type")
    local v3 = u209[v2]
    for i, v in ipairs(v1) do
        v3 = v3[v]
        if not v3 then
            break
        end
    end
    local __Data = v3
    if __Data then
        __Data = v3.__Data
    end
    if not __Data then
        Reference = nil
    else
        Reference = __Data.Reference
        if not Reference then
            Reference = nil
        end
    end
    return Reference
end
return u0