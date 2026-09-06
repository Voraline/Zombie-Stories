local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LobbyDoorGeometry = require(ReplicatedStorage.place.Modules:WaitForChild("LobbyDoorGeometry"))
local Remotes = ReplicatedStorage.common:WaitForChild("Remotes")
local Net = Remotes:WaitForChild("Net")
local function onNetEvent(p1, p2) -- Line: 9 -- upvalues: Net (val)
    return Net.OnClientEvent:Connect(function(a1, ...) -- Line: 10 -- upvalues: p1 (val), p2 (val)
        if a1 == p1 then
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
    local v1, v2
    v1, v2 = pcall(p1.GetPivot, p1)
    if not v1 then
        local PrimaryPart = p1.PrimaryPart
        if not PrimaryPart then
            PrimaryPart = p1:FindFirstChildWhichIsA("BasePart", true)
        end
        if PrimaryPart then
            return PrimaryPart.CFrame
        end
        return (CFrame.new())
    elseif typeof(v2) == "CFrame" then
        return v2
    end
end
function u33.new() -- Line: 41 -- upvalues: u33 (val)
    local v1 = setmetatable({}, u33)
    v1.DoorsById = {}
    v1.PendingStates = {}
    v1.StateRetryTasks = {}
    v1.SyncRetryTask = nil
    v1.SyncRequestTask = nil
    v1.SyncRequestAttempts = 0
    v1.Initialized = false
    v1.MapAddedConnection = nil
    v1.StateConnection = nil
    v1.SyncConnection = nil
    return v1
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
    if self.SyncRequestTask or 3 <= self.SyncRequestAttempts then
        return
    end
    self.SyncRequestAttempts = self.SyncRequestAttempts + 1
    self.SyncRequestTask = task.delay(1.05, function() -- Line: 83 -- upvalues: self (val), Net (upval)
        self.SyncRequestTask = nil
        Net:FireServer("LobbyDoorRequestSync")
    end)
end
function u33:_buildFromMap() -- Line: 89 -- upvalues: LobbyDoorGeometry (val)
    local Attribute, v1, v2, v3, v4, v5
    local DoorsById = self.DoorsById
    local v6 = {}
    local v7 = {}
    local v8 = false
    for k, v in pairs(DoorsById) do
        v6[v.Model] = v
    end
    local Map = workspace:FindFirstChild("Map")
    if not Map then
        self.DoorsById = v7
        self:_clearDoorRecords(DoorsById)
        return false
    end
    local v9 = self
    for i, i2 in ipairs(Map:GetDescendants()) do
        if i2:IsA("Model") then
            Attribute = i2:GetAttribute("LobbyDoorId")
            if typeof(Attribute) == "number" then
                v1 = LobbyDoorGeometry.buildDoorRecord(i2)
                if v1 then
                    v1.DoorId = Attribute
                    v2 = DoorsById[Attribute]
                    if not v2 then
                        v2 = v6[v1.Model]
                    end
                    if not v2 then
                        v8 = true
                    end
                    v3 = v2
                    if v3 then
                        v3 = false
                        if v2.Model == v1.Model then
                            v4 = #v2.Movers
                            v3 = v4 == #v1.Movers
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
                            v5 = v2.Movers[i4]
                            k2.Closed = v5.Closed
                            k2.Open = v5.Open
                        end
                        v9:_snapDoor(v1, v1.Open)
                    end
                    v7[Attribute] = v1
                end
            end
        end
    end
    v9.DoorsById = v7
    v9:_clearDoorRecords(DoorsById)
    return v8
end
function u33._ensureSound(p1, p2, p3) -- Line: 145 -- upvalues: SoundService (val)
    local v1
    local v2 = p2.Movers[1]
    local Model = v2
    if Model then
        Model = v2.Model
    end
    if not Model then
        return nil
    end
    if not p3 then
        v1 = "CloseSound"
    else
        v1 = "OpenSound"
    end
    local v3 = p2[v1]
    if not v3 then
        local v4
        local PrimaryPart = Model.PrimaryPart
        if not PrimaryPart then
            PrimaryPart = Model:FindFirstChildWhichIsA("BasePart", true)
        end
        if not PrimaryPart then
            return nil
        end
        if not p3 then
            v4 = "LobbyDoorCloseSound"
        else
            v4 = "LobbyDoorOpenSound"
        end
        local v5 = PrimaryPart:FindFirstChild(v4)
        if not v5 then
            local OpenSoundId
            v3 = Instance.new("Sound")
            v3.Name = v4
            if not p3 then
                OpenSoundId = p2.CloseSoundId
            else
                OpenSoundId = p2.OpenSoundId
            end
            v3.SoundId = OpenSoundId
            v3.Volume = 1
            v3.RollOffMode = Enum.RollOffMode.InverseTapered
            v3.RollOffMinDistance = 8
            v3.RollOffMaxDistance = 80
            local Primary = SoundService:FindFirstChild("Primary")
            if Primary and Primary:IsA("SoundGroup") then
                v3.SoundGroup = Primary
            end
            v3.Parent = PrimaryPart
        elseif v5:IsA("Sound") then
            v3 = v5
        end
        p2[v1] = v3
        return v3
    elseif v3.Parent then
        return v3
    end
end
function u33._cancelMoverTween(p1, p2) -- Line: 186
    if p2.TweenValue then
        p2.TweenValue:Destroy()
        p2.TweenValue = nil
    end
end
function u33:_snapDoor(p2, p3) -- Line: 193
    local v1, v2
    p2.Open = p3
    v1, v2 = self, p3
    for i, v in ipairs(p2.Movers) do
        v1:_cancelMoverTween(v)
        if v.Model and v.Model.Parent then
            if not v2 then
                Open = v.Closed
            else
                local Open = v.Open
            end
            pcall(function() -- Line: 199 -- upvalues: v (val), Open (val)
                v.Model:PivotTo(Open)
            end)
        end
    end
end
function u33:_tweenDoor(p2, p3) -- Line: 206 -- upvalues: TweenService (val)
    local CFrame, Model, Open, OpenTweenTime, PrimaryPart, TweenTime, v1, v2, v3, v4, v5, v6
    if p2.Open == p3 then
        return
    end
    p2.Open = p3
    local v7 = self:_ensureSound(p2, p3)
    if v7 then
        v7:Play()
    end
    if not p3 then
        OpenTweenTime = p2.CloseTweenTime
    else
        OpenTweenTime = p2.OpenTweenTime
    end
    v1, v6, v2 = self, p3, p2
    for i, v in ipairs(p2.Movers) do
        if v.Model and v.Model.Parent then
            v1:_cancelMoverTween(v)
            local CFrameValue = Instance.new("CFrameValue")
            Model = v.Model
            v3, v4 = pcall(Model.GetPivot, Model)
            if not v3 then
                PrimaryPart = Model.PrimaryPart
                if not PrimaryPart then
                    PrimaryPart = Model:FindFirstChildWhichIsA("BasePart", true)
                end
                if not PrimaryPart then
                    CFrame = CFrame.new()
                else
                    CFrame = PrimaryPart.CFrame
                end
            elseif typeof(v4) == "CFrame" then
                CFrame = v4
            end
            CFrameValue.Value = CFrame
            v.TweenValue = CFrameValue
            local u69 = nil
            u69 = CFrameValue.Changed:Connect(function(p1) -- Line: 227 -- upvalues: v (val), u69 (ref)
                if v.Model.Parent then
                    pcall(function() -- Line: 229 -- upvalues: v (upval), p1 (val)
                        v.Model:PivotTo(p1)
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
            TweenTime = OpenTweenTime
            if not TweenTime then
                TweenTime = v2.TweenTime
            end
            v5 = TweenInfo.new(TweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v3 = TweenService:Create(CFrameValue, v5, {Value = Open})
            v3.Completed:Connect(function() -- Line: 244 -- upvalues: u69 (ref), v (val), CFrameValue (val)
                local v1 = u69
                if v1 then
                    v1:Disconnect()
                end
                if v.TweenValue == CFrameValue then
                    v.TweenValue = nil
                end
                CFrameValue:Destroy()
            end)
            v3:Play()
        end
    end
end
function u33:_applySync(p2, p3) -- Line: 257
    local open, u105, u108, u75, v1, v2
    self.SyncRetryTask = nil
    local v3 = self:_buildFromMap()
    if type(p2) ~= "table" then
        open = {}
    elseif type(p2.open) == "table" then
        open = p2.open
    end
    local v4 = false
    u75, u105, u108 = self, p2, p3
    for k in pairs(open) do
        v1 = tonumber(k)
        if not v1 then
            v4 = true
        elseif u75.DoorsById[v1] then
        end
    end
    for k2, v in pairs(u75.DoorsById) do
        v2 = if open[k2] ~= true then open[tostring(k2)] == true else true
        u75:_snapDoor(v, v2)
    end
    if not v4 and not v3 then
        u75.SyncRequestAttempts = 0
    end
    if v3 then
        u75:_scheduleSyncRequest()
        return
    end
    if not v4 then
        if v4 then
            u75.SyncRetryTask = task.delay(0.1, function() -- Line: 281 -- upvalues: u75 (val), u105 (val), u108 (val)
                u75:_applySync(u105, u108 + 1)
            end)
        end
        return
    end
    if 3 <= u108 then
        u75:_scheduleSyncRequest()
        return
    end
    if v4 then
        u75.SyncRetryTask = task.delay(0.1, function() -- Line: 281 -- upvalues: u75 (val), u105 (val), u108 (val)
            u75:_applySync(u105, u108 + 1)
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
    local StateRetryTasks
    self.StateRetryTasks[p2] = nil
    if self:_buildFromMap() then
        self:_scheduleSyncRequest()
    end
    local v1 = self.PendingStates[p2]
    local v2 = self.DoorsById[p2]
    if not v2 then
        if not v2 then
            if p3 >= 3 then
                self.PendingStates[p2] = nil
                return
            end
            StateRetryTasks = self.StateRetryTasks
            StateRetryTasks[p2] = task.delay(0.1, function() -- Line: 310 -- upvalues: self (val), p2 (val), p3 (val)
                self:_retryState(p2, p3 + 1)
            end)
            return
        end
        return
    end
    if v1 ~= nil then
        self.PendingStates[p2] = nil
        self:_tweenDoor(v2, v1)
        return
    end
    if v2 then
        return
    end
    if p3 >= 3 then
        self.PendingStates[p2] = nil
        return
    end
    StateRetryTasks = self.StateRetryTasks
    StateRetryTasks[p2] = task.delay(0.1, function() -- Line: 310 -- upvalues: self (val), p2 (val), p3 (val)
        self:_retryState(p2, p3 + 1)
    end)
end
function u33:_handleDoorState(p2) -- Line: 319
    local StateRetryTasks, id, open
    if type(p2) ~= "table" or typeof(p2.id) ~= "number" or typeof(p2.open) ~= "boolean" then
        return
    end
    id = p2.id
    open = p2.open
    local v1 = self.DoorsById[id]
    if not v1 then
        if self:_buildFromMap() then
            self:_scheduleSyncRequest()
        end
        v1 = self.DoorsById[id]
    end
    if v1 then
        self.PendingStates[id] = nil
        self:_tweenDoor(v1, open)
        return
    end
    self.PendingStates[id] = open
    if not (self.StateRetryTasks[id]) then
        StateRetryTasks = self.StateRetryTasks
        StateRetryTasks[id] = task.delay(0.1, function() -- Line: 341 -- upvalues: self (val), id (val)
            self:_retryState(id, 1)
        end)
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
    local function u6(a1) -- Line: 367 -- upvalues: p1 (val)
        p1:_handleDoorState(a1)
    end
    local u9 = "LobbyDoorState"
    p1.StateConnection = Net.OnClientEvent:Connect(function(p1, ...) -- Line: 10 -- upvalues: u9 (val), u6 (val)
        if p1 == u9 then
            u6(...)
        end
    end)
    local function u15(a1) -- Line: 370 -- upvalues: p1 (val)
        p1:_handleDoorSync(a1)
    end
    local u18 = "LobbyDoorSync"
    p1.SyncConnection = Net.OnClientEvent:Connect(function(p1, ...) -- Line: 10 -- upvalues: u18 (val), u15 (val)
        if p1 == u18 then
            u15(...)
        end
    end)
    Net:FireServer("LobbyDoorRequestSync")
    p1.MapAddedConnection = workspace.ChildAdded:Connect(function(a1) -- Line: 376 -- upvalues: p1 (val)
        if a1.Name == "Map" then
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