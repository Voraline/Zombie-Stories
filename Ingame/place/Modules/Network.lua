local u58, u63, v1, v2
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
    local format, result, success, v1, v2, v3, v4, v5
    local v6 = table.pack(...)
    local n = v6.n
    local v7 = math.min(10, n)
    local v8 = v7
    for i = 1, v8 do
        local u14 = v6[i]
        v3 = v6[i]
        v2 = typeof(v3)
        if v2 == "string" then
            format = string.format
            v4 = "%q[%d]"
            if not (#u14 <= 18) then
                v5 = (u14:sub(1, 15)) .. "..."
            else
                v5 = u14
                if not v5 then
                    v5 = (u14:sub(1, 15)) .. "..."
                end
            end
            v6[i] = (format(v4, v5, #u14))
        elseif v2 ~= "Instance" then
            v6[i] = v2
        else
            success, result = pcall(function() -- Line: 78 -- upvalues: u14 (val)
                return u14.ClassName
            end)
            if not success then
                v5 = v2
            else
                v5 = string.format("%s<%s>", v2, result)
                if not v5 then
                    v5 = v2
                end
            end
            v6[i] = v5
        end
    end
    local v9 = table.concat(v6, ", ", 1, v7)
    if not (v7 < v6.n) then
        v1 = ""
    else
        v1 = string.format(", ... (%d more)", v6.n - v7)
        if not v1 then
            v1 = ""
        end
    end
    return v9 .. v1
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
    coroutine.wrap(function(...) -- Line: 112 -- upvalues: BindableEvent (upval), p1 (val)
        BindableEvent.Event:Wait()
        p1(...)
    end)(...)
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
    local u1 = false
    local u2 = nil
    local u3 = nil
    local u4 = nil

    local function finish(...) -- Line: 143 -- upvalues: u1 (ref), u4 (ref), u3 (ref)
        if not u1 then
            u1 = true
            u4 = table.pack(...)
            if u3 then
                ResumeThread(u3)
            end
        end
    end

    local v1 = FastSpawn
    v1(function(...) -- Line: 154 -- upvalues: u2 (ref), finish (val), p1 (val)
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
        v1 = coroutine.running()
        YieldThread()
    end
    local v2 = u4
    v1 = unpack(v2)
    return v1
end

function SafeInvoke(p1, p2, ...) -- Line: 183 -- upvalues: u23 (val)
    local u3 = coroutine.running()
    local u4 = false
    local u5 = nil
    coroutine.wrap(function(...) -- Line: 188 -- upvalues: u23 (upval), u5 (ref), p2 (val), u4 (ref), u3 (val)
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
    end)(...)
    if typeof(p1) == "number" then
        delay(p1, function() -- Line: 202 -- upvalues: u4 (ref), u3 (val)
            if not u4 then
                u4 = true
                ResumeThread(u3)
            end
        end)
    end
    YieldThread()
    if u5 and u5[1] == true and u5[2] == true then
        local v1 = u5
        local v2 = unpack(v1, 3)
        return true, v2
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
                if not (0 < u2) then
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
        local v1 = p1.ChildAdded:Connect(function(p1) -- Line: 247 -- upvalues: p2 (val), u8 (ref), u5 (ref), u7 (val)
            if p1.Name == p2 then
                u8:Disconnect()
                u5 = p1
                ResumeThread(u7)
            end
        end)
        YieldThread()
    end
    return u5
end

function GetEventHandler(p1) -- Line: 261 -- upvalues: u16 (val), u63 (ref), u23 (val), u27 (ref), u20 (val)
    local v1 = u16[p1]
    if v1 then
        return v1
    end
    local u3 = {}
    u3.Name = p1
    u3.Folder = u63
    u3.Callbacks = {}
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
                if 2048 <= #u3.IncomingQueue then
                    if not u3.IncomingQueueErrored then
                        u3.IncomingQueueErrored = true
                        FastSpawn(
                            error,
                            string.format("Exhausted remote invocation queue for %s", u7:GetFullName()),
                            -1
                        )
                        delay(1, function() -- Line: 301 -- upvalues: u3 (upval)
                            u3.IncomingQueueErrored = nil
                        end)
                    end
                    if 8172 <= #u3.IncomingQueue then
                        table.remove(u3.IncomingQueue, 1)
                    end
                end
                u27 = u27 + 1
                local v1 = u3
                local IncomingQueue = v1.IncomingQueue
                local pack = table.pack
                local v2 = u27
                local v3 = u3
                local v4 = pack(v2, v3, ...)
                table.insert(IncomingQueue, v4)
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
    local u3 = {}
    u3.Name = p1
    u3.Folder = u58
    u17[p1] = u3
    if not u23 then
        FastSpawn(function() -- Line: 357 -- upvalues: u3 (val), u27 (upval), u20 (upval)
            u3.Queue = {}
            local u7 = WaitForChild(u3.Folder, u3.Name)
            u3.Remote = u7
            u3.IncomingQueue = {}
            local v1 = u3

            function v1.OnClientInvoke(...) -- Line: 364 -- upvalues: u3 (upval), u7 (val), u27 (upval)
                if not u3.Callback then
                    if 2048 <= #u3.IncomingQueue then
                        if not u3.IncomingQueueErrored then
                            u3.IncomingQueueErrored = true
                            FastSpawn(
                                error,
                                string.format("Exhausted remote invocation queue for %s", u7:GetFullName()),
                                -1
                            )
                            delay(1, function() -- Line: 371 -- upvalues: u3 (upval)
                                u3.IncomingQueueErrored = nil
                            end)
                        end
                        if 8172 <= #u3.IncomingQueue then
                            table.remove(u3.IncomingQueue, 1)
                        end
                    end
                    u27 = u27 + 1
                    local v1 = table.pack(u27, u3, coroutine.running())
                    local v2 = u3
                    local IncomingQueue = v2.IncomingQueue
                    table.insert(IncomingQueue, v1)
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
                local v1 = warn
                local traceback = debug.traceback
                local FullName = p1.Folder:GetFullName()
                local v2 = p1
                local Name = v2.Name
                v1(traceback(("Infinite yield possible on '%s:WaitForChild(\"%s\")'"):format(FullName, Name)))
            end
        end)
    end
end

function ExecuteDeferredHandlers() -- Line: 422 -- upvalues: u26 (ref)
    local IncomingQueue, v1
    local v2 = u26
    local v3 = {}
    u26 = {}
    for k in pairs(v2) do
        IncomingQueue = k.IncomingQueue
        k.IncomingQueue = nil
        table.move(IncomingQueue, 1, #IncomingQueue, #v3 + 1, v3)
    end
    table.sort(v3, function(p1, p2) -- Line: 435
        local v1 = p1[1] < p2[1]
        return v1
    end)
    for i, v in ipairs(v3) do
        v1 = v[2]
        if not v1.Callbacks then
            ResumeThread(v[3])
        else
            SafeFireEvent(v1, unpack(v, 3))
        end
    end
end

local u87 = {}

function u87.MatchParams(p1, p2) -- Line: 449 -- upvalues: u23 (val), u20 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = {}
    local v8 = p2
    v7[1] = unpack(v8)
    local u96 = v7
    local u99 = 1
    for k, v in pairs(u96) do
        if type(v) ~= "string" then
            v5 = v
        else
            v5 = string.split(v, "|")
            if not v5 then
                v5 = v
            end
        end
        v6 = {}
        v1 = ""
        for k2, i in pairs(v5) do
            v2 = (i:gsub("^%s+", "")):gsub("%s+$", "")
            if not (0 < #v1) then
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
        v8 = u96
        table.insert(v8, 1, false)
    end
    return function(p1_2, ...) -- Line: 475 -- upvalues: u96 (ref), u20 (upval), p1 (val), u99 (ref)
        local _string, v1, v2, v3, v4, v5, v6, v7
        local v8 = table.pack(...)
        local n = v8.n
        if #u96 < n then
            if u20 then
                v4 = warn
                v5 = p1
                v6 = #u96 - u99 + 1
                local n_2 = v8.n
                v2 = u99
                v7 = n_2 - v2 + 1
                v4(("[Network] Invalid number of parameters to %s (%s expected, got %s)"):format(v5, v6, v7))
            end
            return
        end
        local v9 = u99
        v4 = #u96
        for i = v9, v4 do
            v6 = v8[i]
            v5 = typeof(v6)
            v6 = u96[i]
            if not v6[v5:lower()] and not v6.any then
                if u20 then
                    v7 = warn
                    v2 = i - u99 + 1
                    v3 = p1
                    _string = v6._string
                    v7(("[Network] Invalid parameter %d to %s (%s expected, got %s)"):format(v2, v3, _string, v5))
                end
                return
            end
        end
        return v1(...)
    end
end

function combineFn(self, p2, ...) -- Line: 504 -- upvalues: u87 (val), u24 (ref), GetParamString (val)
    local u2 = {}
    u2[1] = ...
    local v1 = p2
    if typeof(v1) == "table" then
        local v2 = p2
        p2 = p2[1]
        if v2.MatchParams then
            local v3 = u87
            v3 = v3.MatchParams(self.Name, v2.MatchParams)
            table.insert(u2, v3)
        end
    end
    return function(...) -- Line: 516 -- upvalues: u24 (upval), self (val), GetParamString (upval), u2 (val), p2 (ref)
        local runMiddleware
        if u24 then
            local v1 = u24[...]
            local v2 = self
            local dataIn = v1[v2.Remote].dataIn
            v1 = GetParamString
            v2 = select(2, ...)
            v1 = v1(v2)
            table.insert(dataIn, v1)
        end
        local u16 = 1

        function runMiddleware(p1, ...) -- Line: 524 -- upvalues: u16 (ref), u2 (upval), runMiddleware (val), p2 (upval)
            if p1 ~= u16 then
                return
            end
            u16 = u16 + 1
            if p1 <= #u2 then
                return u2[p1](function(...) -- Line: 532 -- upvalues: runMiddleware (upval), p1 (val)
                    local v1 = runMiddleware
                    return v1(p1 + 1, ...)
                end, ...)
            end
            return p2(...)
        end

        local v3 = runMiddleware(1, ...)
        return v3
    end
end

function u0.BindEvents(p1, p2, p3) -- Line: 544 -- upvalues: u23 (val), u26 (ref)
    local Callbacks, v1, v2, v3
    if typeof(p2) ~= "table" then
        v3, v1 = p3, p2
    else
        v3 = p2
        v1 = nil
    end
    for k, v in pairs(v3) do
        local u26_2 = GetEventHandler(k)
        if not u26_2 then
            error(("Tried to bind callback to non-existing RemoteEvent %q"):format(k))
        end
        Callbacks = u26_2.Callbacks
        v2 = #u26_2.Callbacks + 1
        Callbacks[v2] = (combineFn(u26_2, v, v1))
        if u23 then
            u26_2.Remote.OnServerEvent:Connect(function(...) -- Line: 558 -- upvalues: u26_2 (val)
                SafeFireEvent(u26_2, ...)
            end)
        elseif u26_2.IncomingQueue then
            u26[u26_2] = true
        end
    end
    ExecuteDeferredHandlers()
end

function u0.BindFunctions(p1, p2, p3) -- Line: 571 -- upvalues: u23 (val), u26 (ref)
    local FullName, Remote, v1, v2, v3
    if typeof(p2) ~= "table" then
        v2, v1 = p3, p2
    else
        v2 = p2
        v1 = nil
    end
    for k, v in pairs(v2) do
        local u26_2 = GetFunctionHandler(k)
        if not u26_2 then
            error(("Tried to bind callback to non-existing RemoteFunction %q"):format(k))
        end
        if u26_2.Callback then
            v3 = error
            FullName = u26_2.Remote:GetFullName()
            v3(("Tried to bind multiple callbacks to the same RemoteFunction (%s)"):format(FullName))
        end
        u26_2.Callback = combineFn(u26_2, v, v1)
        if u23 then
            Remote = u26_2.Remote

            function Remote.OnServerInvoke(...) -- Line: 589 -- upvalues: u26_2 (val)
                return SafeInvokeCallback(u26_2, ...)
            end
        elseif u26_2.IncomingQueue then
            u26[u26_2] = true
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
            local v1 = u4
            local Remote = v1.Remote
            local v2 = u21
            local v3 = unpack(v2)
            Remote:FireServer(v3)
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
            local dataOut = u24[p2][self.Remote].dataOut
            local v1 = GetParamString
            v1 = v1(...)
            table.insert(dataOut, v1)
        end
        return self.Remote:FireClient(p2, ...)
    end

    function u0.GetPlayers(p1) -- Line: 616 -- upvalues: Players (val)
        return Players:GetPlayers()
    end

    function u0.GetPlayerPosition(p1, p2) -- Line: 620
        local Position
        if not p2 or not p2.Character or not p2.Character.PrimaryPart then
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

    function u0:InvokeClient(...) -- Line: 705
        return self:InvokeClientWithTimeout(60, ...)
    end

    function u0.LogTraffic(p1, ...) -- Line: 710
        FastSpawn(p1.LogTrafficAsync, p1, ...)
    end

    function u0.LogTrafficAsync(p1, p2, p3) -- Line: 714 -- upvalues: u24 (ref)
        local dataIn, dataOut, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
        local v13 = p3 or warn
        local v14 = v13
        if u24 then
            return
        end
        v14("Logging Network Traffic...")
        local v15 = {
            __index = function(p1, p2) -- Line: 720
                local v1 = {
                    __index = function(p1, p2) -- Line: 721
                        p1[p2] = {dataIn = {}, dataOut = {}}
                        return p1[p2]
                    end,
                }
                p1[p2] = (setmetatable({}, v1))
                return p1[p2]
            end,
        }
        u24 = setmetatable({}, v15)
        v13 = os.clock()
        wait(p2)
        local v16 = os.clock() - v13
        v15 = u24
        u24 = nil
        for k, v in pairs(v15) do
            v1 = 0
            v2 = 0
            for k2, i in pairs(v) do
                v1 = v1 + #i.dataIn
                v2 = v2 + #i.dataOut
            end
            v14(string.format("Player '%s', total received/sent: %d/%d", k.Name, v1, v2))
            for k3, j in pairs(v) do
                dataIn = j.dataIn
                if 0 < #dataIn then
                    v14(string.format("   %s %s: %d (%.2f/s)", "FireServer", k3.Name, #dataIn, #dataIn / v16))
                    v4 = #dataIn
                    v3 = math.min(v4, 3)
                    v4 = v3
                    for k4 = 1, v4 do
                        v9 = k4 - 1
                        v11 = v3 - 1
                        v7 = v9 / math.max(1, v11) * (#dataIn - 1) + 1 + 0.5
                        v6 = math.floor(v7)
                        v14(string.format("      %d: %s", v6, dataIn[v6]))
                    end
                end
                dataOut = j.dataOut
                if 0 < #dataOut then
                    v14(string.format("   %s %s: %d (%.2f/s)", "FireClient", k3.Name, #dataOut, #dataOut / v16))
                    v5 = #dataOut
                    v4 = math.min(v5, 3)
                    v5 = v4
                    for n = 1, v5 do
                        v10 = n - 1
                        v12 = v4 - 1
                        v8 = v10 / math.max(1, v12) * (#dataOut - 1) + 1 + 0.5
                        v7 = math.floor(v8)
                        v14(string.format("      %d: %s", v7, dataOut[v7]))
                    end
                end
            end
        end
    end
end
local v3 = {
    __mode = "k",
    __index = function(p1, p2) -- Line: 832
        p1[p2] = {}
        return p1[p2]
    end,
}
local u154 = setmetatable({}, v3)
local v4 = {
    __mode = "k",
    __index = function(p1, p2) -- Line: 833
        p1[p2] = {}
        return p1[p2]
    end,
}
local u159 = setmetatable({}, v4)
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
    if not u160[v1] then
        error(string.format("Invalid value passed to Network:Pack (values of type %s are not supported)", v1))
    end
    if v1 ~= "boolean" and v1 ~= "nil" and p1 ~= "" then
        if v1 == "string" and 64 < #p1 then
            return "\000" .. p1
        end
        local v2 = u154[p2]
        local v3 = v2[p1]
        if not v3 then
            local v4, v5
            if not (#v2 < 32) then
                local v6
                v6, v4 = p1, p2
                for i, v in ipairs(v2) do
                    if not v3 or v.last < v3.last then
                        v3 = v
                    end
                end
                v2[v3.value] = nil
                v2[v6] = v3
                v3.value = v6
            else
                v5 = #v2 + 1
                v3 = {last = 0, char = string.char(v5), value = p1}
                v2[v5] = v3
                v2[p1] = v3
                v4 = p2
            end
            if not u23 then
                v5 = u0
                local char_2 = v3.char
                local value_2 = v3.value
                v5:FireServer("SetPackedValue", char_2, value_2)
            else
                v5 = u0
                local char = v3.char
                local value = v3.value
                v5:FireClient(v4, "SetPackedValue", char, value)
            end
        end
        v3.last = os.clock()
        return v3.char
    end
    return p1
end

local function getEntry(p1, p2) -- Line: 894 -- upvalues: u159 (val)
    if typeof(p1) == "string" and p1 ~= "" then
        local v1 = string.byte(p1, 1)
        if v1 == 0 then
            return (string.sub(p1, 2))
        end
        return u159[p2][v1]
    end
    return p1
end

if not u23 then
    function u0.Pack(p1, p2) -- Line: 939 -- upvalues: addEntry (val)
        return (addEntry(p2, "Server"))
    end

    function u0.Unpack(p1, p2) -- Line: 943 -- upvalues: u159 (val)
        if typeof(p2) == "string" and p2 ~= "" then
            local v1 = string.byte(p2, 1)
            if v1 == 0 then
                return (string.sub(p2, 2))
            end
            return u159.Server[v1]
        end
        return p2
    end

    v2 = {
        SetPackedValue = function(p1, p2) -- Line: 948 -- upvalues: u159 (val)
            u159.Server[string.byte(p1)] = p2
        end,
    }
    u0:BindEvents(v2)
else
    function u0.Pack(p1, p2, p3) -- Line: 909 -- upvalues: addEntry (val)
        local v1 = false
        if typeof(p3) == "Instance" then
            v1 = p3:IsA("Player")
        end
        assert(v1, "client is not a player")
        return (addEntry(p2, p3))
    end

    function u0.Unpack(p1, p2, p3) -- Line: 914 -- upvalues: u159 (val)
        local v1 = false
        if typeof(p3) == "Instance" then
            v1 = p3:IsA("Player")
        end
        assert(v1, "client is not a player")
        if typeof(p2) == "string" and p2 ~= "" then
            local v2 = string.byte(p2, 1)
            if v2 == 0 then
                return (string.sub(p2, 2))
            end
            return u159[p3][v2]
        end
        return p2
    end

    v2 = {
        SetPackedValue = function(p1, p2, p3) -- Line: 920 -- upvalues: u160 (val), u159 (val)
            if typeof(p2) == "string" and #p2 == 1 then
                local v1 = string.byte(p2)
                if not (v1 < 1) and not (32 < v1) then
                    local v2 = typeof(p3)
                    if not u160[v2] then
                        return p1:Kick()
                    end
                    if v2 == "string" and 64 < #p3 then
                        return p1:Kick()
                    end
                    u159[p1][v1] = p3
                    return
                end
                return p1:Kick()
            end
            return p1:Kick()
        end,
    }
    u0:BindEvents(v2)
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
    local v2 = u205
    local v3 = v2[p3]
    assert(v3, "Invalid Reference Type")
    v2 = {}
    v2.Type = p3
    v2.Reference = p2
    v2.Objects = {...}
    v2.Aliases = {}
    local v4 = u208[p3]
    v4[v2.Reference] = v2
    v4 = u209[p3]
    for i, v in ipairs(v2.Objects) do
        v1 = v4[v]
        if not v1 then
            v1 = {}
        end
        v4[v] = v1
        v4 = v1
    end
    v4.__Data = v2
end

function u0.AddReferenceAlias(p1, p2, p3, ...) -- Line: 994 -- upvalues: u205 (val), u208 (val), u209 (val)
    local v1
    local v2 = u205
    local v3 = v2[p3]
    assert(v3, "Invalid Reference Type")
    v2 = u208[p3][p2]
    if not v2 then
        warn("Tried to add an alias to a non-existing reference")
        return
    end
    local v4 = {...}
    v2.Aliases[#v2.Aliases + 1] = v4
    local v5 = u209[p3]
    for i, v in ipairs(v4) do
        v1 = v5[v]
        if not v1 then
            v1 = {}
        end
        v5[v] = v1
        v5 = v1
    end
    v5.__Data = v2
end

function u0.RemoveReference(p1, p2, p3) -- Line: 1017 -- upvalues: u205 (val), u208 (val), u209 (val)
    local rem, v1, v2
    local v3 = u205
    local v4 = v3[p3]
    assert(v4, "Invalid Reference Type")
    local u11 = u208[p3][p2]
    if not u11 then
        warn("Tried to remove a non-existing reference")
        return
    end
    local v5 = u208[p3]
    v5[u11.Reference] = nil

    function rem(p1, p2, p3) -- Line: 1029 -- upvalues: rem (val), u11 (val)
        if not (p3 <= #p2) then
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

    local v6 = u209[u11.Type]
    local Objects = u11.Objects
    if 1 <= #Objects then
        local v7 = Objects[1]
        local v8 = v6[v7]
        rem(v8, Objects, 2)
        if next(v8) == nil then
            v6[v7] = nil
        end
    elseif v6.__Data == u11 then
        v6.__Data = nil
    end
    for i, v in ipairs(u11.Aliases) do
        if 1 <= #v then
            v1 = v[1]
            v2 = v6[v1]
            rem(v2, v, 2)
            if next(v2) == nil then
                v6[v1] = nil
            end
        elseif v6.__Data == u11 then
            v6.__Data = nil
        end
    end
end

function u0.GetObject(p1, p2, p3) -- Line: 1052 -- upvalues: u205 (val), u208 (val)
    local v1 = u205[p3]
    assert(v1, "Invalid Reference Type")
    local v2 = u208[p3][p2]
    if not v2 then
        return nil
    end
    local Objects = v2.Objects
    return unpack(Objects)
end

function u0.GetReference(p1, ...) -- Line: 1063 -- upvalues: u205 (val), u209 (val)
    local Reference
    local v1 = {...}
    local v2 = table.remove(v1)
    local v3 = u205[v2]
    assert(v3, "Invalid Reference Type")
    local v4 = u209[v2]
    for i, v in ipairs(v1) do
        v4 = v4[v]
        if not v4 then
            break
        end
    end
    local __Data = v4
    if __Data then
        __Data = v4.__Data
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