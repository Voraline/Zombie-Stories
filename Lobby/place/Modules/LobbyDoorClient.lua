local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LobbyDoorGeometry = require(ReplicatedStorage.place.Modules:WaitForChild("LobbyDoorGeometry"))
local Net = (ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("Net")

local function onNetEvent(p1, p2) -- Line: 9 -- upvalues: Net (val)
    local v1 = Net
    return v1.OnClientEvent:Connect(function(p1_2, ...) -- Line: 10 -- upvalues: p1 (val), p2 (val)
        if p1_2 == p1 then
            p2(...)
        end
    end)
end

local u33 = {}
u33.__index = u33

local function disconnectConnection(p1) -- Line: 25
    if p1 then
        p1:Disconnect()
    end
end

local function getModelPivot(p1) -- Line: 31
    local success, result = pcall(p1.GetPivot, p1)
    if success and typeof(result) == "CFrame" then
        return result
    end
    local PrimaryPart = p1.PrimaryPart
    if not PrimaryPart then
        PrimaryPart = p1:FindFirstChildWhichIsA("BasePart", true)
    end
    if PrimaryPart then
        return PrimaryPart.CFrame
    end
    return (CFrame.new())
end

function u33.new() -- Line: 41 -- upvalues: u33 (val)
    local v1 = u33
    local v2 = setmetatable({}, v1)
    v2.DoorsById = {}
    v2.PendingStates = {}
    v2.StateRetryTasks = {}
    v2.SyncRetryTask = nil
    v2.SyncRequestTask = nil
    v2.SyncRequestAttempts = 0
    v2.Initialized = false
    v2.MapAddedConnection = nil
    v2.StateConnection = nil
    v2.SyncConnection = nil
    return v2
end

function u33:_clearDoorRecords(p2) -- Line: 56
    local DoorsById = p2
    if not DoorsById then
        DoorsById = self.DoorsById
    end
    local v1 = DoorsById
    for k, v in pairs(v1) do
        for i, i2 in ipairs(v.Movers) do
            if i2.TweenValue then
                i2.TweenValue:Destroy()
                i2.TweenValue = nil
            end
        end
        if v.OpenSound then
            v.OpenSound:Destroy()
            v.OpenSound = nil
        end
        if v.CloseSound then
            v.CloseSound:Destroy()
            v.CloseSound = nil
        end
    end
    table.clear(v1)
end

function u33:_scheduleSyncRequest() -- Line: 77 -- upvalues: Net (val)
    if not self.SyncRequestTask and not (3 <= self.SyncRequestAttempts) then
        self.SyncRequestAttempts = self.SyncRequestAttempts + 1
        local delay = task.delay
        self.SyncRequestTask = delay(1.05, function() -- Line: 83 -- upvalues: self (val), Net (upval)
            self.SyncRequestTask = nil
            Net:FireServer("LobbyDoorRequestSync")
        end)
        return
    end
end

function u33:_buildFromMap() -- Line: 89 -- upvalues: LobbyDoorGeometry (val)
    local Attribute, Open, v1, v2, v3, v4
    local DoorsById = self.DoorsById
    local v5 = {}
    local v6 = {}
    local v7 = false
    for k, v in pairs(DoorsById) do
        v5[v.Model] = v
    end
    local Map = workspace:FindFirstChild("Map")
    if not Map then
        self.DoorsById = v6
        self:_clearDoorRecords(DoorsById)
        return false
    end
    local v8 = self
    for i, i2 in ipairs(Map:GetDescendants()) do
        if i2:IsA("Model") then
            Attribute = i2:GetAttribute("LobbyDoorId")
            if typeof(Attribute) == "number" then
                v1 = LobbyDoorGeometry.buildDoorRecord(i2)
                if v1 then
                    v1.DoorId = Attribute
                    v2 = DoorsById[Attribute]
                    if not v2 then
                        v2 = v5[v1.Model]
                    end
                    if not v2 then
                        v7 = true
                    end
                    v3 = v2
                    if v3 then
                        v3 = false
                        if v2.Model == v1.Model then
                            v3 = #v2.Movers == #v1.Movers
                        end
                    end
                    if v3 then
                        for i3, j in ipairs(v1.Movers) do
                            if v2.Movers[i3].Model ~= j.Model then
                                v3 = false
                                break
                            end
                        end
                    end
                    if v3 then
                        v1.Open = v2.Open
                        for i4, k2 in ipairs(v1.Movers) do
                            v4 = v2.Movers[i4]
                            k2.Closed = v4.Closed
                            k2.Open = v4.Open
                        end
                        Open = v1.Open
                        v8:_snapDoor(v1, Open)
                    end
                    v6[Attribute] = v1
                end
            end
        end
    end
    v8.DoorsById = v6
    v8:_clearDoorRecords(DoorsById)
    return v7
end

function u33._ensureSound(p1, p2, p3) -- Line: 145 -- upvalues: SoundService (val)
    local v1, v2
    local v3 = p2.Movers[1]
    local Model = v3
    if Model then
        Model = v3.Model
    end
    if not Model then
        return nil
    end
    if not p3 then
        v1 = "CloseSound"
    else
        v1 = "OpenSound"
    end
    local v4 = p2[v1]
    if v4 and v4.Parent then
        return v4
    end
    local PrimaryPart = Model.PrimaryPart
    if not PrimaryPart then
        PrimaryPart = Model:FindFirstChildWhichIsA("BasePart", true)
    end
    if not PrimaryPart then
        return nil
    end
    if not p3 then
        v2 = "LobbyDoorCloseSound"
    else
        v2 = "LobbyDoorOpenSound"
    end
    local v5 = PrimaryPart:FindFirstChild(v2)
    if not v5 or not v5:IsA("Sound") then
        local OpenSoundId
        v4 = Instance.new("Sound")
        v4.Name = v2
        if not p3 then
            OpenSoundId = p2.CloseSoundId
        else
            OpenSoundId = p2.OpenSoundId
        end
        v4.SoundId = OpenSoundId
        v4.Volume = 1
        v4.RollOffMode = Enum.RollOffMode.InverseTapered
        v4.RollOffMinDistance = 8
        v4.RollOffMaxDistance = 80
        local Primary = SoundService:FindFirstChild("Primary")
        if Primary and Primary:IsA("SoundGroup") then
            v4.SoundGroup = Primary
        end
        v4.Parent = PrimaryPart
    else
        v4 = v5
    end
    p2[v1] = v4
    return v4
end

function u33._cancelMoverTween(p1, p2) -- Line: 186
    if p2.TweenValue then
        p2.TweenValue:Destroy()
        p2.TweenValue = nil
    end
end

function u33:_snapDoor(p2, p3) -- Line: 193
    p2.Open = p3
    local v1, v2 = self, p3
    for i, v in ipairs(p2.Movers) do
        v1:_cancelMoverTween(v)
        if v.Model and v.Model.Parent then
            if not v2 then
                Open = v.Closed
            else
                local Open = v.Open
            end
            pcall(function() -- Line: 199 -- upvalues: v (val), Open (val)
                local v1 = v
                local Model = v1.Model
                local v2 = Open
                Model:PivotTo(v2)
            end)
        end
    end
end

function u33:_tweenDoor(p2, p3) -- Line: 206 -- upvalues: TweenService (val)
    local CFrame_2, Model, Open, OpenTweenTime, PrimaryPart, TweenTime, new, result, success, v1, v2, v3
    if p2.Open == p3 then
        return
    end
    p2.Open = p3
    local v4 = self:_ensureSound(p2, p3)
    if v4 then
        v4:Play()
    end
    if not p3 then
        OpenTweenTime = p2.CloseTweenTime
    else
        OpenTweenTime = p2.OpenTweenTime
    end
    local v5, v6, v7 = self, p3, p2
    for i, v in ipairs(p2.Movers) do
        if v.Model and v.Model.Parent then
            v5:_cancelMoverTween(v)
            local CFrameValue = Instance.new("CFrameValue")
            Model = v.Model
            success, result = pcall(Model.GetPivot, Model)
            if not success or typeof(result) ~= "CFrame" then
                PrimaryPart = Model.PrimaryPart
                if not PrimaryPart then
                    PrimaryPart = Model:FindFirstChildWhichIsA("BasePart", true)
                end
                if not PrimaryPart then
                    CFrame_2 = CFrame.new()
                else
                    CFrame_2 = PrimaryPart.CFrame
                end
            else
                CFrame_2 = result
            end
            CFrameValue.Value = CFrame_2
            v.TweenValue = CFrameValue
            local u69 = nil
            u69 = CFrameValue.Changed:Connect(function(p1) -- Line: 227 -- upvalues: v (val), u69 (ref)
                if v.Model.Parent then
                    pcall(function() -- Line: 229 -- upvalues: v (upval), p1 (val)
                        local v1 = v
                        local Model = v1.Model
                        local v2 = p1
                        Model:PivotTo(v2)
                    end)
                    return
                end
                local v1 = u69
                if v1 then
                    v1:Disconnect()
                end
            end)
            if not v6 then
                Open = v.Closed
            else
                Open = v.Open
            end
            v1 = TweenService
            new = TweenInfo.new
            TweenTime = OpenTweenTime
            if not TweenTime then
                TweenTime = v7.TweenTime
            end
            v2 = new(TweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v3 = {Value = Open}
            v1 = v1:Create(CFrameValue, v2, v3)
            v1.Completed:Connect(function() -- Line: 244 -- upvalues: u69 (ref), v (val), CFrameValue (val)
                local v1 = u69
                if v1 then
                    v1:Disconnect()
                end
                if v.TweenValue == CFrameValue then
                    v.TweenValue = nil
                end
                CFrameValue:Destroy()
            end)
            v1:Play()
        end
    end
end

function u33:_applySync(p2, p3) -- Line: 257
    local open_2, v1, v2
    self.SyncRetryTask = nil
    local v3 = self:_buildFromMap()
    if type(p2) ~= "table" then
        open_2 = {}
    else
        local open = p2.open
        if type(open) ~= "table" then
            open_2 = {}
        else
            open_2 = p2.open
        end
    end
    local v4 = false
    for k in pairs(open_2) do
        v1 = tonumber(k)
        if not v1 or not self.DoorsById[v1] then
            v4 = true
        end
    end
    for k2, v in pairs(self.DoorsById) do
        v2 = true
        if open_2[k2] ~= true then
            v2 = open_2[tostring(k2)] == true
        end
        self:_snapDoor(v, v2)
    end
    if not v4 and not v3 then
        self.SyncRequestAttempts = 0
    end
    if v3 then
        self:_scheduleSyncRequest()
        return
    end
    if v4 and 3 <= p3 then
        self:_scheduleSyncRequest()
        return
    end
    if v4 then
        local delay = task.delay
        self.SyncRetryTask = delay(0.1, function() -- Line: 281 -- upvalues: self (val), p2 (val), p3 (val)
            local v1 = self
            local v2 = p2
            local v3 = p3
            local v4 = v3 + 1
            v1:_applySync(v2, v4)
        end)
    end
end

function u33:_applyPendingStates() -- Line: 287
    local v1
    for k, v in pairs(self.PendingStates) do
        v1 = self.DoorsById[k]
        if v1 then
            self.PendingStates[k] = nil
            self:_tweenDoor(v1, v)
        end
    end
end

function u33:_retryState(p2, p3) -- Line: 297
    self.StateRetryTasks[p2] = nil
    if self:_buildFromMap() then
        self:_scheduleSyncRequest()
    end
    local v1 = self.PendingStates[p2]
    local v2 = self.DoorsById[p2]
    if v2 and v1 ~= nil then
        self.PendingStates[p2] = nil
        self:_tweenDoor(v2, v1)
        return
    end
    if not v2 then
        if p3 < 3 then
            local StateRetryTasks = self.StateRetryTasks
            local delay = task.delay
            StateRetryTasks[p2] = (delay(0.1, function() -- Line: 310 -- upvalues: self (val), p2 (val), p3 (val)
                local v1 = self
                local v2 = p2
                local v3 = p3
                local v4 = v3 + 1
                v1:_retryState(v2, v4)
            end))
            return
        end
        self.PendingStates[p2] = nil
    end
end

function u33:_handleDoorState(p2) -- Line: 319
    if type(p2) == "table" then
        local id_2 = p2.id
        if typeof(id_2) == "number" then
            local open = p2.open
            if typeof(open) == "boolean" then
                local id = p2.id
                local open_2 = p2.open
                local v1 = self.DoorsById[id]
                if not v1 then
                    if self:_buildFromMap() then
                        self:_scheduleSyncRequest()
                    end
                    v1 = self.DoorsById[id]
                end
                if v1 then
                    self.PendingStates[id] = nil
                    self:_tweenDoor(v1, open_2)
                    return
                end
                self.PendingStates[id] = open_2
                if not self.StateRetryTasks[id] then
                    local StateRetryTasks = self.StateRetryTasks
                    local delay = task.delay
                    StateRetryTasks[id] = (delay(0.1, function() -- Line: 341 -- upvalues: self (val), id (val)
                        local v1 = self
                        local v2 = id
                        v1:_retryState(v2, 1)
                    end))
                end
                return
            end
        end
    end
end

function u33:_handleDoorSync(p2) -- Line: 348
    if self.SyncRetryTask then
        task.cancel(self.SyncRetryTask)
        self.SyncRetryTask = nil
    end
    if self.SyncRequestTask then
        task.cancel(self.SyncRequestTask)
        self.SyncRequestTask = nil
    end
    self:_applySync(p2, 0)
end

function u33.Init(p1) -- Line: 360 -- upvalues: Net (val)
    if p1.Initialized then
        return
    end
    p1.Initialized = true
    p1:_buildFromMap()

    local function u6(p1_2) -- Line: 367 -- upvalues: p1 (val)
        p1:_handleDoorState(p1_2)
    end

    local v1 = Net
    local OnClientEvent = v1.OnClientEvent
    local u9 = "LobbyDoorState"
    p1.StateConnection = OnClientEvent:Connect(function(p1, ...) -- Line: 10 -- upvalues: u9 (val), u6 (val)
        if p1 == u9 then
            u6(...)
        end
    end)

    local function u15(p1_2) -- Line: 370 -- upvalues: p1 (val)
        p1:_handleDoorSync(p1_2)
    end

    v1 = Net
    local OnClientEvent_2 = v1.OnClientEvent
    local u18 = "LobbyDoorSync"
    p1.SyncConnection = OnClientEvent_2:Connect(function(p1, ...) -- Line: 10 -- upvalues: u18 (val), u15 (val)
        if p1 == u18 then
            u15(...)
        end
    end)
    Net:FireServer("LobbyDoorRequestSync")
    local ChildAdded = workspace.ChildAdded
    p1.MapAddedConnection = ChildAdded:Connect(function(p1_2) -- Line: 376 -- upvalues: p1 (val)
        if p1_2.Name == "Map" then
            task.defer(function() -- Line: 378 -- upvalues: p1 (upval)
                local v1 = p1:_buildFromMap()
                p1:_applyPendingStates()
                if v1 then
                    p1:_scheduleSyncRequest()
                end
            end)
        end
    end)
end

function u33:Destroy() -- Line: 389
    local MapAddedConnection = self.MapAddedConnection
    if MapAddedConnection then
        MapAddedConnection:Disconnect()
    end
    self.MapAddedConnection = nil
    local StateConnection = self.StateConnection
    if StateConnection then
        StateConnection:Disconnect()
    end
    self.StateConnection = nil
    local SyncConnection = self.SyncConnection
    if SyncConnection then
        SyncConnection:Disconnect()
    end
    self.SyncConnection = nil
    if self.SyncRetryTask then
        task.cancel(self.SyncRetryTask)
        self.SyncRetryTask = nil
    end
    if self.SyncRequestTask then
        task.cancel(self.SyncRequestTask)
        self.SyncRequestTask = nil
    end
    for k, v in pairs(self.StateRetryTasks) do
        task.cancel(v)
        self.StateRetryTasks[k] = nil
    end
    self:_clearDoorRecords()
    table.clear(self.PendingStates)
    self.SyncRequestAttempts = 0
    self.Initialized = false
end

return (u33.new())