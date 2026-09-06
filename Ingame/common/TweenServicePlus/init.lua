local v1 = {}
local u3 = require("@self/SyncedTime")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local wrap = coroutine.wrap
local TweenCommunication = script:WaitForChild("TweenCommunication")
if RunService:IsServer() and not (u3:IsSynced()) then
    while true do
        u3:Sync()
        task.wait(0.5)
        if u3:IsSynced() then
            break
        end
    end
end
local function infoToTable(p1) -- Line: 111
    local v1 = {Time = p1.Time or 1}
    local EasingStyle = p1.EasingStyle
    if not EasingStyle then
        EasingStyle = Enum.EasingStyle.Quad
    end
    v1.EasingStyle = EasingStyle
    local EasingDirection = p1.EasingDirection
    if not EasingDirection then
        EasingDirection = Enum.EasingDirection.Out
    end
    v1.EasingDirection = EasingDirection
    v1.RepeatCount = p1.RepeatCount or 0
    v1.Reverses = p1.Reverses or false
    v1.DelayTime = p1.DelayTime or 0
    return v1
end
local function assign(p1, p2, p3) -- Line: 122
    local v1
    if not p1 or not p2 then
        return
    end
    for k, v in pairs(p2) do
        p1[k] = v
        if p3 then
            v1 = tostring(v)
            print("Set " .. p1.Name .. "'s " .. k .. " to " .. v1 .. ".")
        end
    end
end
function v1.Construct(p1, p2, p3, p4, p5, p6, p7) -- Line: 135 -- upvalues: HttpService (val), u3 (val), wrap (val), assign (val), TweenCommunication (val), infoToTable (val)
    if not p2 then
        warn("This object doesn't exist.")
        return
    end
    if not p3 then
        warn("Please provide some TweenInfo!")
        return
    end
    if not p4 then
        warn("Please provide some properties to tween to!")
        return
    end
    if not p5 then
        if not p6 then
            if not p7 then
                if p3.Reverses then
                    for k, v in pairs(p4) do
                        (nil)[k] = p2[k]
                    end
                end
                local u69 = p6 or false
                local u73 = p7 or true
                local u74 = {Cancelled = true, Completed = true, Paused = true, Resumed = true}
                local u79 = {
                    PlaybackState = Enum.PlaybackState.Begin,
                    TweenId = HttpService:GenerateGUID(false),
                    IsPaused = false,
                    IsCancelled = false,
                    LastPlay = u3:GetTime(),
                    TimeElapsed = 0,
                }
                local function changeState(p1) -- Line: 172 -- upvalues: u79 (val), u69 (ref)
                    u79.PlaybackState = p1
                    if u69 then
                        print("Playback state changed. New playback state:", (tostring(p1)))
                    end
                end
                for k2, i in pairs(u74) do
                    u74[k2] = Instance.new("BindableEvent")
                    u79[k2] = u74[k2].Event
                end
                local function u106(p1) -- Line: 185 -- upvalues: u79 (val), u69 (ref)
                    local v1 = tick()
                    while true do
                        task.wait()
                        if u79.IsPaused == true or u79.IsCancelled == true then
                            break
                        end
                        if p1 or 0.0333 <= tick() - v1 then
                            return
                        end
                    end
                    if u69 then
                        print("Tween cancelled/paused server-side.")
                    end
                    return true
                end
                local function completionWait(p1) -- Line: 199 -- upvalues: wrap (upval), u79 (val), u69 (ref), u74 (val), p3 (val), u3 (upval), u106 (val), assign (upval), p2 (val), p4 (val)
                    wrap(function() -- Line: 200 -- upvalues: u79 (upval), p1 (ref), u69 (upval), u74 (upval), p3 (upval), u3 (upval), u106 (upval), assign (upval), p2 (upval), p4 (upval)
                        if u79.IsPaused then
                            p1 = p1 - u79.TimeElapsed
                            if u69 then
                                print("Tween is resuming from a pause. Length:", p1)
                            end
                            u74.Resumed:Fire()
                            u79.IsPaused = false
                        end
                        if u79.IsCancelled then
                            u79.IsCancelled = false
                        end
                        if 0 < p3.DelayTime then
                            local Delayed = Enum.PlaybackState.Delayed
                            u79.PlaybackState = Delayed
                            if u69 then
                                print("Playback state changed. New playback state:", (tostring(Delayed)))
                            end
                            task.wait(p3.DelayTime)
                        end
                        u79.LastPlay = u3:GetTime()
                        local Playing = Enum.PlaybackState.Playing
                        u79.PlaybackState = Playing
                        if u69 then
                            print("Playback state changed. New playback state:", (tostring(Playing)))
                        end
                        if u106(p1) then
                            return
                        end
                        assign(p2, p4, u69)
                        if not p3.Reverses then
                            local Completed = Enum.PlaybackState.Completed
                            u79.PlaybackState = Completed
                            if u69 then
                                print("Playback state changed. New playback state:", (tostring(Completed)))
                            end
                            u74.Completed:Fire()
                            return
                        end
                        if p3.Reverses then
                            task.wait(p1)
                            if not u79.IsPaused then
                                assign(p2, nil, u69)
                                local Completed_2 = Enum.PlaybackState.Completed
                                u79.PlaybackState = Completed_2
                                if u69 then
                                    print("Playback state changed. New playback state:", (tostring(Completed_2)))
                                end
                                u74.Completed:Fire()
                            end
                        end
                    end)()
                end
                function u79.Play(p1, a2, a3, a4, a5) -- Line: 251 -- upvalues: p2 (val), u69 (ref), wrap (upval), TweenCommunication (upval), infoToTable (upval), p3 (val), p4 (val), u3 (upval), u79 (val), p5 (val), u73 (ref), u74 (val), u106 (val), assign (upval)
                    local u5 = a4 or "HumanoidRootPart"
                    if not a5 then
                        local Time
                        local v1 = a5
                        if not v1 then
                            v1 = p2
                        end
                        local u21 = v1
                        if u21 ~= p2 and u69 then
                            print("Set the main object to", u21.Name)
                        end
                        if a2 then
                            if type(a2) ~= "table" then
                                v1 = {a2}
                            else
                                v1 = a2
                            end
                            local v2 = v1
                            if not a3 then
                                for i2, i3 in ipairs(v2) do
                                    if i3 and i3:IsA("Player") and i3.Character then
                                        wrap(function() -- Line: 304 -- upvalues: TweenCommunication (upval), i3 (val), p2 (upval), infoToTable (upval), p3 (upval), p4 (upval), u3 (upval), u79 (upval), p5 (upval), u69 (upval), u73 (upval)
                                            local v1 = infoToTable(p3)
                                            local Time = u3:GetTime()
                                            TweenCommunication:FireClient(i3, p2, v1, p4, Time, u79.TweenId, p5, u69, nil, u73)
                                        end)()
                                    end
                                end
                            else
                                for i4, j in ipairs(v2) do
                                    if j and j:IsA("Player") and j.Character then
                                        wrap(function() -- Line: 274 -- upvalues: j (val), u5 (ref), u69 (upval), u21 (ref), a3 (val), TweenCommunication (upval), p2 (upval), infoToTable (upval), p3 (upval), p4 (upval), u3 (upval), u79 (upval), p5 (upval), u73 (upval)
                                            local v1 = j.Character:FindFirstChild(u5, true)
                                            if v1 then
                                                if u69 then
                                                    print("Found root part of " .. j.Name .. ":", u5)
                                                end
                                                local magnitude = (u21.Position - v1.Position).magnitude
                                                if magnitude <= a3 then
                                                    local v2 = infoToTable(p3)
                                                    local Time = u3:GetTime()
                                                    TweenCommunication:FireClient(j, p2, v2, p4, Time, u79.TweenId, p5, u69, nil, u73)
                                                    if u69 then
                                                        print("Sent tween data to " .. j.Name .. ". Distance from object:", magnitude)
                                                    end
                                                end
                                            end
                                        end)()
                                    end
                                end
                            end
                        elseif not a3 then
                            local v3 = infoToTable(p3)
                            local Time_2 = u3:GetTime()
                            TweenCommunication:FireAllClients(p2, v3, p4, Time_2, u79.TweenId, p5, u69, nil, u73)
                        else
                            for i, v in ipairs(game.Players:GetPlayers()) do
                                if v and v:IsA("Player") and v.Character then
                                    wrap(function() -- Line: 320 -- upvalues: v (val), u5 (ref), u69 (upval), u21 (ref), a3 (val), TweenCommunication (upval), p2 (upval), infoToTable (upval), p3 (upval), p4 (upval), u3 (upval), u79 (upval), p5 (upval), u73 (upval)
                                        local v1 = v.Character:FindFirstChild(u5, true)
                                        if v1 then
                                            if u69 then
                                                print("Found root part of " .. v.Name .. ":", u5)
                                            end
                                            local magnitude = (u21.Position - v1.Position).magnitude
                                            if magnitude <= a3 then
                                                local v2 = infoToTable(p3)
                                                local Time = u3:GetTime()
                                                TweenCommunication:FireClient(v, p2, v2, p4, Time, u79.TweenId, p5, u69, nil, u73)
                                                if u69 then
                                                    print("Sent tween data to " .. v.Name .. ". Distance from object:", magnitude)
                                                end
                                            end
                                        end
                                    end)()
                                end
                            end
                        end
                        Time = p3.Time
                        wrap(function() -- Line: 200 -- upvalues: u79 (upval), Time (ref), u69 (upval), u74 (upval), p3 (upval), u3 (upval), u106 (upval), assign (upval), p2 (upval), p4 (upval)
                            if u79.IsPaused then
                                Time = Time - u79.TimeElapsed
                                if u69 then
                                    print("Tween is resuming from a pause. Length:", Time)
                                end
                                u74.Resumed:Fire()
                                u79.IsPaused = false
                            end
                            if u79.IsCancelled then
                                u79.IsCancelled = false
                            end
                            if 0 < p3.DelayTime then
                                local Delayed = Enum.PlaybackState.Delayed
                                u79.PlaybackState = Delayed
                                if u69 then
                                    print("Playback state changed. New playback state:", (tostring(Delayed)))
                                end
                                task.wait(p3.DelayTime)
                            end
                            u79.LastPlay = u3:GetTime()
                            local Playing = Enum.PlaybackState.Playing
                            u79.PlaybackState = Playing
                            if u69 then
                                print("Playback state changed. New playback state:", (tostring(Playing)))
                            end
                            if u106(Time) then
                                return
                            end
                            assign(p2, p4, u69)
                            if not p3.Reverses then
                                local Completed = Enum.PlaybackState.Completed
                                u79.PlaybackState = Completed
                                if u69 then
                                    print("Playback state changed. New playback state:", (tostring(Completed)))
                                end
                                u74.Completed:Fire()
                                return
                            end
                            if p3.Reverses then
                                task.wait(Time)
                                if not u79.IsPaused then
                                    assign(p2, nil, u69)
                                    local Completed_2 = Enum.PlaybackState.Completed
                                    u79.PlaybackState = Completed_2
                                    if u69 then
                                        print("Playback state changed. New playback state:", (tostring(Completed_2)))
                                    end
                                    u74.Completed:Fire()
                                end
                            end
                        end)()
                        return
                    elseif not (a5:IsA("BasePart")) then
                        warn("The mainObject must be a BasePart in the workspace.")
                        return
                    elseif not (a5:IsDescendantOf(workspace)) then
                        warn("The mainObject must be a BasePart in the workspace.")
                        return
                    end
                end
                function u79.Cancel(p1, p2) -- Line: 355 -- upvalues: TweenCommunication (upval), u3 (upval), u79 (val), u69 (ref), u74 (val)
                    if not p2 then
                        local Time_2 = u3:GetTime()
                        TweenCommunication:FireAllClients(nil, nil, nil, Time_2, u79.TweenId, nil, u69, "Cancel")
                    else
                        local Time, v1
                        if type(p2) ~= "table" then
                            v1 = {p2}
                        else
                            v1 = p2
                        end
                        local v2 = v1
                        for i, v in ipairs(v2) do
                            Time = u3:GetTime()
                            TweenCommunication:FireClient(v, nil, nil, nil, Time, u79.TweenId, nil, u69, "Cancel")
                        end
                    end
                    u74.Cancelled:Fire()
                    u79.IsCancelled = true
                    local Cancelled = Enum.PlaybackState.Cancelled
                    u79.PlaybackState = Cancelled
                    if u69 then
                        print("Playback state changed. New playback state:", (tostring(Cancelled)))
                    end
                end
                function u79.Pause(p1, p2) -- Line: 373 -- upvalues: TweenCommunication (upval), u3 (upval), u79 (val), u69 (ref), u74 (val)
                    if not p2 then
                        local Time_2 = u3:GetTime()
                        TweenCommunication:FireAllClients(nil, nil, nil, Time_2, u79.TweenId, nil, u69, "Pause")
                    else
                        local Time, v1
                        if type(p2) ~= "table" then
                            v1 = {p2}
                        else
                            v1 = p2
                        end
                        local v2 = v1
                        for i, v in ipairs(v2) do
                            Time = u3:GetTime()
                            TweenCommunication:FireClient(v, nil, nil, nil, Time, u79.TweenId, nil, u69, "Pause")
                        end
                    end
                    local Time_3 = u3:GetTime()
                    u79.TimeElapsed = Time_3 - u79.LastPlay
                    u79.LastPlay = u3:GetTime()
                    u74.Paused:Fire()
                    u79.IsPaused = true
                    local Paused = Enum.PlaybackState.Paused
                    u79.PlaybackState = Paused
                    if u69 then
                        print("Playback state changed. New playback state:", (tostring(Paused)))
                    end
                end
                return u79
            elseif not type(p7) == "boolean" then
                warn("The parameter clientSync must be true or false!")
                return
            end
        elseif not type(p6) == "boolean" then
            warn("The debugMode parameter must be true or false!")
            return
        end
    elseif not type(p5) == "number" then
        warn("Latency threshold must be a number!")
        return
    end
end
if RunService:IsClient() then
    local LocalPlayer = game.Players.LocalPlayer
    local u61 = {}
    TweenCommunication.OnClientEvent:Connect(function(p1, p2, p3, p4, p5, p6, p7, p8, p9) -- Line: 403 -- upvalues: u61 (val), u3 (val), LocalPlayer (val), wrap (val), TweenService (val)
        local v1
        if not p8 then
            local Time
            v1 = u3:GetTime() - p4
            if not p9 then
                Time = p2.Time
            else
                Time = p2.Time - v1
            end
            if p7 then
                print("Approximate latency for " .. LocalPlayer.Name .. ": " .. v1 .. " seconds. \n New tween time: " .. Time .. " seconds")
            end
            if (p6 or 0 < Time) and p1 and p3 and p5 then
                local u94 = TweenInfo.new(Time, p2.EasingStyle, p2.EasingDirection, p2.RepeatCount, p2.Reverses, p2.DelayTime)
                wrap(function() -- Line: 465 -- upvalues: u61 (upval), p5 (val), TweenService (upval), p1 (val), u94 (val), p3 (val)
                    if not (u61[p5]) then
                        u61[p5] = TweenService:Create(p1, u94, p3)
                    end
                    u61[p5]:Play()
                    u61[p5].Completed:Wait()
                    u61[p5] = nil
                end)()
                if p7 then
                    wrap(function() -- Line: 479 -- upvalues: p1 (val), p3 (val)
                        print("Currently tweening properties of " .. p1.Name .. ":")
                        for k, v in pairs(p3) do
                            print(k .. " to " .. tostring(v))
                        end
                    end)()
                end
            end
            return
        else
            local v2
            v1 = u61[p5]
            if not v1 then
                warn("The tween you tried to modify does not exist.")
                return
            end
            if p8 == "Cancel" then
                v1:Cancel()
                if p7 then
                    v2 = u3:GetTime() - p4
                    print("Cancelled a tween. Latency:", v2)
                end
                return
            end
            if p8 == "Pause" then
                v1:Pause()
                if p7 then
                    v2 = u3:GetTime() - p4
                    print("Paused a tween. Latency:", v2)
                end
                return
            end
        end
    end)
end
return v1