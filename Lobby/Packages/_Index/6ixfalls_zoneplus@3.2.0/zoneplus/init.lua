local v1
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Heartbeat = RunService.Heartbeat
local LocalPlayer = RunService:IsClient()
if LocalPlayer then
    LocalPlayer = Players.LocalPlayer
end
game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local enums = require(script.Enum).enums
local Janitor = require(script.Janitor)
local Signal = require(script.Signal)
local ZonePlusReference = require(script.ZonePlusReference)
local v2 = ZonePlusReference.getObject()
local ZoneController = script.ZoneController
local Tracker = ZoneController.Tracker
local CollectiveWorldModel = ZoneController.CollectiveWorldModel
local u50 = require(ZoneController)
if not game:GetService("RunService"):IsClient() then
    v1 = "Server"
else
    v1 = "Client"
end
local v3 = v2
if v3 then
    v3 = v2:FindFirstChild(v1)
end
if v3 then
    return require(v2.Value)
end
local u73 = {}
u73.__index = u73
if not v3 then
    ZonePlusReference.addToReplicatedStorage()
end
u73.enum = enums

function u73.new(p1) -- Line: 34
    -- upvalues: u73 (val), enums (val), Janitor (val), HttpService (val), u50 (val), Signal (val), LocalPlayer (val)
    local touchedConnectionActions, v1, v2, v3
    local u146 = {}
    local v4 = u73
    setmetatable(u146, v4)
    local v5 = typeof(p1)
    if v5 ~= "table" and v5 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!")
    end
    u146.accuracy = enums.Accuracy.High
    u146.autoUpdate = true
    u146.respectUpdateQueue = true
    local v6 = Janitor.new()
    u146.janitor = v6
    local v7 = Janitor
    v7 = v7.new()
    u146._updateConnections = v6:add(v7, "destroy")
    u146.container = p1
    u146.zoneParts = {}
    u146.overlapParams = {}
    u146.region = nil
    u146.volume = nil
    u146.boundMin = nil
    u146.boundMax = nil
    u146.recommendedMaxParts = nil
    u146.zoneId = HttpService:GenerateGUID()
    u146.activeTriggers = {}
    u146.occupants = {}
    u146.trackingTouchedTriggers = {}
    u146.enterDetection = enums.Detection.Centre
    u146.exitDetection = enums.Detection.Centre
    u146._currentEnterDetection = nil
    u146._currentExitDetection = nil
    u146.totalPartVolume = 0
    u146.allZonePartsAreBlocks = true
    u146.trackedItems = {}
    u146.settingsGroupName = nil
    u146.worldModel = workspace
    u146.onItemDetails = {}
    u146.itemsToUntrack = {}
    u50.updateDetection(u146)
    v7 = Signal
    v7 = v7.new()
    u146.updated = v6:add(v7, "destroy")
    v4 = {"player", "part", "localPlayer", "item"}
    local v8 = {"entered", "exited"}
    for k, v in pairs(v4) do
        local u131 = 0
        local u132 = 0
        for k2, i in pairs(v8) do
            v3 = Signal.new(true)
            v2 = v6:add(v3, "destroy")
            local u173 = (i:sub(1, 1):upper()) .. i:sub(2)
            u146[v .. u173] = v2
            v2.connectionsChanged:Connect(function(p1) -- Line: 105
                -- upvalues: v (val), LocalPlayer (upval), u173 (val), u132 (ref), u131 (ref), u50 (upval), u146 (val)
                if v == "localPlayer" and not LocalPlayer and p1 == 1 then
                    local v1 = error
                    local v2 = u173
                    v1(("Can only connect to 'localPlayer%s' on the client!"):format(v2))
                end
                u132 = u131
                u131 = u131 + p1
                if u132 == 0 and 0 < u131 then
                    u50._registerConnection(u146, v, u173)
                    return
                end
                if 0 < u132 and u131 == 0 then
                    u50._deregisterConnection(u146, v)
                end
            end)
        end
    end
    u73.touchedConnectionActions = {}
    for k3, j in pairs(v4) do
        local u123 = u146[("_%sTouchedZone"):format(j)]
        if u123 then
            u146.trackingTouchedTriggers[j] = {}
            v1 = u73
            touchedConnectionActions = v1.touchedConnectionActions

            touchedConnectionActions[j] = function(p1) -- Line: 129 -- upvalues: u123 (val), u146 (val)
                u123(u146, p1)
            end
        end
    end
    u146:_update()
    u50._registerZone(u146)
    v6:add(function() -- Line: 140 -- upvalues: u50 (upval), u146 (val)
        u50._deregisterZone(u146)
    end, true)
    return u146
end

function u73.fromRegion(p1, p2) -- Line: 147 -- upvalues: u73 (val)
    local createCube
    local Model = Instance.new("Model")

    function createCube(p1, p2) -- Line: 150 -- upvalues: createCube (val), Model (val)
        if not (2024 < p2.X) and not (2024 < p2.Y) and not (2024 < p2.Z) then
            local Part = Instance.new("Part")
            Part.CFrame = p1
            Part.Size = p2
            Part.Anchored = true
            Part.Parent = Model
            return
        end
        local v1 = p2 * 0.25
        local v2 = p2 * 0.5
        local v3 = createCube
        local new = CFrame.new
        local v4 = -v1.X
        local v5 = -v1.Y
        v3(p1 * new(v4, v5, -v1.Z), v2)
        v3 = createCube
        local new_2 = CFrame.new
        v4 = -v1.X
        v5 = -v1.Y
        v3(p1 * new_2(v4, v5, v1.Z), v2)
        v3 = createCube
        local new_3 = CFrame.new
        v4 = -v1.X
        v3(p1 * new_3(v4, v1.Y, -v1.Z), v2)
        v3 = createCube
        local new_4 = CFrame.new
        v4 = -v1.X
        v3(p1 * new_4(v4, v1.Y, v1.Z), v2)
        v3 = createCube
        local new_5 = CFrame.new
        local X = v1.X
        v5 = -v1.Y
        v3(p1 * new_5(X, v5, -v1.Z), v2)
        v3 = createCube
        local new_6 = CFrame.new
        local X_2 = v1.X
        v5 = -v1.Y
        v3(p1 * new_6(X_2, v5, v1.Z), v2)
        v3 = createCube
        v3(p1 * CFrame.new(v1.X, v1.Y, -v1.Z), v2)
        v3 = createCube
        v3(p1 * CFrame.new(v1.X, v1.Y, v1.Z), v2)
    end

    createCube(p1, p2)
    local v1 = u73.new(Model)
    v1:relocate()
    return v1
end

function u73._calculateRegion(p1, p2, p3) -- Line: 179
    local CFrame_6, Components, Components_2, Components_3, X, new_5, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local v13 = {Min = {}, Max = {}}
    for k, v in pairs(v13) do
        v.Values = {}

        function v.parseCheck(p1, p2) -- Line: 183 -- upvalues: k (val)
            local v1
            if k == "Min" then
                v1 = p1 <= p2
                return v1
            end
            if k ~= "Max" then
                return
            end
            v1 = p2 <= p1
            return v1
        end

        function v:parse(p2) -- Line: 190
            local v1
            for k, v in pairs(p2) do
                v1 = self.Values[k] or v
                if self.parseCheck(v, v1) then
                    self.Values[k] = v
                end
            end
        end
    end
    local v14 = p3
    for k2, i in pairs(p2) do
        v12 = i.Size * 0.5
        v1 = {}
        v2 = i.CFrame * CFrame.new(-v12.X, -v12.Y, -v12.Z)
        v3 = i.CFrame * CFrame.new(-v12.X, -v12.Y, v12.Z)
        v4 = i.CFrame * CFrame.new(-v12.X, v12.Y, -v12.Z)
        v5 = i.CFrame * CFrame.new(-v12.X, v12.Y, v12.Z)
        CFrame_6 = i.CFrame
        new_5 = CFrame.new
        X = v12.X
        v10 = -v12.Y
        v6 = CFrame_6 * new_5(X, v10, -v12.Z)
        v7 = i.CFrame * CFrame.new(v12.X, -v12.Y, v12.Z)
        v8 = i.CFrame * CFrame.new(v12.X, v12.Y, -v12.Z)
        v1[1] = v2
        v1[2] = v3
        v1[3] = v4
        v1[4] = v5
        v1[5] = v6
        v1[6] = v7
        v1[7] = v8
        v1[8] = i.CFrame * CFrame.new(v12.X, v12.Y, v12.Z)
        for k3, j in pairs(v1) do
            Components, Components_2, Components_3 = j:GetComponents()
            v10 = {Components, Components_2, Components_3}
            v13.Min:parse(v10)
            v13.Max:parse(v10)
        end
    end
    local v15 = {}
    local v16 = {}

    local function roundToFour(p1) -- Line: 222
        local v1 = (p1 + 2) / 4
        return math.floor(v1) * 4
    end

    for k4, k5 in pairs(v13) do
        for k6, n in pairs(k5.Values) do
            v8 = k4 == "Min" and v15 or v16
            v9 = n
            if not v14 then
                if k4 ~= "Min" then
                    v10 = 2
                else
                    v10 = -2
                end
                v11 = (n + v10 + 2) / 4
                v9 = math.floor(v11) * 4
            end
            table.insert(v8, v9)
        end
    end
    local v17 = unpack(v15)
    local v18 = Vector3.new(v17)
    v12 = unpack(v16)
    v17 = Vector3.new(v12)
    return Region3.new(v18, v17), v18, v17
end

function u73._displayBounds(p1) -- Line: 245
    if not p1.displayBoundParts then
        local Part
        p1.displayBoundParts = true
        local v1 = {BoundMin = p1.boundMin, BoundMax = p1.boundMax}
        for k, v in pairs(v1) do
            Part = Instance.new("Part")
            Part.Anchored = true
            Part.CanCollide = false
            Part.Transparency = 0.5
            Part.Size = Vector3.new(1, 1, 1)
            Part.Color = Color3.fromRGB(255, 0, 0)
            Part.CFrame = CFrame.new(v)
            Part.Name = k
            Part.Parent = workspace
            p1.janitor:add(Part, "Destroy")
        end
    end
end

function u73:_update() -- Line: 264 -- upvalues: RunService (val)
    local _updateConnections, _updateConnections_2, _updateConnections_3, result, v1, v2, v3
    local container = self.container
    local v4 = {}
    local u237 = 0
    self._updateConnections:clean()
    local v5 = typeof(container)
    local v6 = {}
    if v5 == "table" then
        for k2, i in pairs(container) do
            if i:IsA("BasePart") then
                table.insert(v4, i)
            end
        end
    elseif v5 == "Instance" then
        if not container:IsA("BasePart") then
            table.insert(v6, container)
            for k, v in pairs(container:GetDescendants()) do
                if not v:IsA("BasePart") then
                    table.insert(v6, v)
                else
                    table.insert(v4, v)
                end
            end
        else
            table.insert(v4, container)
        end
    end
    self.zoneParts = v4
    self.overlapParams = {}
    local v7 = true
    for k3, j in pairs(v4) do
        _, result = pcall(function() -- Line: 298 -- upvalues: j (val)
            return j.Shape.Name
        end)
        if result ~= "Block" then
            v7 = false
        end
    end
    self.allZonePartsAreBlocks = v7
    local v8 = OverlapParams.new()
    v8.FilterType = Enum.RaycastFilterType.Whitelist
    v8.MaxParts = #v4
    v8.FilterDescendantsInstances = v4
    self.overlapParams.zonePartsWhitelist = v8
    local v9 = OverlapParams.new()
    v9.FilterType = Enum.RaycastFilterType.Blacklist
    v9.FilterDescendantsInstances = v4
    self.overlapParams.zonePartsIgnorelist = v9

    local function update() -- Line: 318 -- upvalues: self (val), u237 (ref), RunService (upval)
        if self.autoUpdate then
            local u8 = os.clock()
            if self.respectUpdateQueue then
                u237 = u237 + 1
                u8 = u8 + 0.1
            end
            local u9 = nil
            local v1 = RunService
            v1 = v1.Heartbeat:Connect(function() -- Line: 326 -- upvalues: u8 (ref), u9 (ref), self (upval), u237 (upval)
                local v1 = os.clock()
                if u8 <= v1 then
                    u9:Disconnect()
                    if self.respectUpdateQueue then
                        u237 = u237 - 1
                    end
                    if u237 == 0 and self.zoneId then
                        self:_update()
                    end
                end
            end)
        end
    end

    local v10 = {"Size", "Position"}

    local function verifyDefaultCollision(p1) -- Line: 340
        if p1.CollisionGroupId ~= 0 then
            error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
        end
    end

    for k4, k5 in pairs(v4) do
        for k6, n in pairs(v10) do
            _updateConnections_3 = self._updateConnections
            v2 = (k5:GetPropertyChangedSignal(n)):Connect(update)
            _updateConnections_3:add(v2, "Disconnect")
        end
        if k5.CollisionGroupId ~= 0 then
            error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
        end
        _updateConnections_2 = self._updateConnections
        v1 = (k5:GetPropertyChangedSignal("CollisionGroupId")):Connect(function() -- Line: 350 -- upvalues: k5 (val)
            if k5.CollisionGroupId ~= 0 then
                error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
            end
        end)
        _updateConnections_2:add(v1, "Disconnect")
    end
    local v11 = {"ChildAdded", "ChildRemoved"}
    for k7, m in pairs(v6) do
        for k8, i5 in pairs(v11) do
            _updateConnections = self._updateConnections
            v3 = self.container[i5]:Connect(function(p1) -- Line: 357 -- upvalues: self (val), u237 (ref), RunService (upval)
                if p1:IsA("BasePart") and self.autoUpdate then
                    local u13 = os.clock()
                    if self.respectUpdateQueue then
                        u237 = u237 + 1
                        u13 = u13 + 0.1
                    end
                    local u14 = nil
                    local v1 = RunService
                    v1 = v1.Heartbeat:Connect(function() -- Line: 326 -- upvalues: u13 (ref), u14 (ref), self (upval), u237 (upval)
                        local v1 = os.clock()
                        if u13 <= v1 then
                            u14:Disconnect()
                            if self.respectUpdateQueue then
                                u237 = u237 - 1
                            end
                            if u237 == 0 and self.zoneId then
                                self:_update()
                            end
                        end
                    end)
                end
            end)
            _updateConnections:add(v3, "Disconnect")
        end
    end
    local v12, v13, v14 = self:_calculateRegion(v4)
    local v15 = self:_calculateRegion(v4, true)
    self.region = v12
    self.exactRegion = v15
    self.boundMin = v13
    self.boundMax = v14
    local Size = v12.Size
    local v16 = Size.X * Size.Y
    self.volume = v16 * Size.Z
    self:_updateTouchedConnections()
    self.updated:Fire()
end

function u73._updateOccupants(p1, p2, p3) -- Line: 393
    local Character, entered, exited, v1
    local v2 = p1.occupants[p2]
    if not v2 then
        v2 = {}
        p1.occupants[p2] = v2
    end
    local v3 = {}
    local v4 = p3
    for k, v in pairs(v2) do
        v1 = v4[k]
        if v1 == nil or v1 ~= v then
            v2[k] = nil
            if not v3.exited then
                v3.exited = {}
            end
            exited = v3.exited
            table.insert(exited, k)
        end
    end
    for k2, i in pairs(v4) do
        if v2[k2] == nil then
            if not k2:IsA("Player") then
                Character = true
            else
                Character = k2.Character
                if not Character then
                    Character = true
                end
            end
            v2[k2] = Character
            if not v3.entered then
                v3.entered = {}
            end
            entered = v3.entered
            table.insert(entered, k2)
        end
    end
    return v3
end

function u73._formTouchedConnection(p1, p2) -- Line: 423 -- upvalues: Janitor (val)
    local v1 = "_touchedJanitor" .. p2
    local v2 = p1[v1]
    if not v2 then
        local janitor = p1.janitor
        local v3 = Janitor
        v3 = v3.new()
        p1[v1] = (janitor:add(v3, "destroy"))
    else
        v2:clean()
    end
    p1:_updateTouchedConnection(p2)
end

function u73:_updateTouchedConnection(p2) -- Line: 435
    local Touched, v1, v2
    local v3 = self["_touchedJanitor" .. p2]
    if not v3 then
        return
    end
    for k, v in pairs(self.zoneParts) do
        Touched = v.Touched
        v2 = self.touchedConnectionActions[p2]
        v1 = Touched:Connect(v2, self)
        v3:add(v1, "Disconnect")
    end
end

function u73:_updateTouchedConnections() -- Line: 444
    local v1
    for k, v in pairs(self.touchedConnectionActions) do
        v1 = self["_touchedJanitor" .. k]
        if v1 then
            v1:cleanup()
            self:_updateTouchedConnection(k)
        end
    end
end

function u73._disconnectTouchedConnection(p1, p2) -- Line: 455
    local v1 = "_touchedJanitor" .. p2
    local v2 = p1[v1]
    if v2 then
        v2:cleanup()
        p1[v1] = nil
    end
end

local function round(p1, p2) -- Line: 464
    local v1 = 10 ^ p2
    local v2 = p1 * v1
    return (math.round(v2)) * 10 ^ (-p2)
end

function u73._partTouchedZone(p1, p2) -- Line: 467 -- upvalues: Janitor (val), Heartbeat (val), enums (val)
    local part = p1.trackingTouchedTriggers.part
    if part[p2] then
        return
    end
    local u5 = 0
    local u6 = false
    local Position = p2.Position
    local u9 = os.clock()
    local janitor = p1.janitor
    local v1 = Janitor
    v1 = v1.new()
    local u17 = janitor:add(v1, "destroy")
    part[p2] = u17
    local v2 = {Seat = true, VehicleSeat = true}
    v1 = {HumanoidRootPart = true}
    if not v2[p2.ClassName] and v1[p2.Name] then
        p2.CanTouch = false
    end
    local v3 = p2.Size.X * p2.Size.Y * p2.Size.Z * 100000
    local u37 = math.round(v3) * 1e-05
    p1.totalPartVolume = p1.totalPartVolume + u37
    v3 = Heartbeat
    v3 = v3:Connect(function() -- Line: 485
        -- upvalues: u5 (ref), enums (upval), p1 (val), p2 (val), u6 (ref), Position (ref), u9 (ref), u17 (val)
        local v1 = os.clock()
        if u5 <= v1 then
            local v2, v3
            local v4 = enums.Accuracy.getProperty(p1.accuracy)
            u5 = v1 + v4
            local v5 = p1
            local v6 = p2
            local CFrame = v6.CFrame
            v5 = v5:findPoint(CFrame)
            if not v5 then
                v2 = p1
                v3 = p2
                v5 = v2:findPart(v3)
            end
            if not u6 then
                if v5 then
                    u6 = true
                    v2 = p1
                    local partEntered = v2.partEntered
                    v3 = p2
                    partEntered:Fire(v3)
                    return
                end
                if 1.5 < (p2.Position - Position).Magnitude and v4 <= v1 - u9 then
                    u17:cleanup()
                    return
                end
            elseif not v5 then
                u6 = false
                Position = p2.Position
                u9 = os.clock()
                v2 = p1
                local partExited = v2.partExited
                v3 = p2
                partExited:Fire(v3)
            end
        end
    end)
    u17:add(v3, "Disconnect")
    u17:add(function() -- Line: 516 -- upvalues: part (val), p2 (val), p1 (val), u37 (val)
        part[p2] = nil
        p2.CanTouch = true
        local v1 = p1
        local v2 = p1
        local totalPartVolume = v2.totalPartVolume
        local v3 = u37
        v3 = (totalPartVolume - v3) * 100000
        v1.totalPartVolume = math.round(v3) * 1e-05
    end, true)
end

local u118 = {}

function u118.Ball(p1) -- Line: 524
    return "GetPartBoundsInRadius", {p1.Position, p1.Size.X}
end

function u118.Block(p1) -- Line: 527
    return "GetPartBoundsInBox", {p1.CFrame, p1.Size}
end

function u118.Other(p1) -- Line: 530
    return "GetPartsInPart", {p1}
end

function u73:_getRegionConstructor(p2, p3) -- Line: 534 -- upvalues: u118 (val)
    local success, result = pcall(function() -- Line: 535 -- upvalues: p2 (val)
        return p2.Shape.Name
    end)
    local v1 = nil
    local v2 = nil
    if success and self.allZonePartsAreBlocks then
        local v3 = u118[result]
        if v3 then
            local v4, v5 = v3(p2)
            v1 = v4
            v2 = v5
        end
    end
    if not v1 then
        v1 = "GetPartsInPart"
        v2 = {p2}
    end
    if p3 then
        table.insert(v2, p3)
    end
    return v1, v2
end

function u73.findLocalPlayer(p1) -- Line: 555 -- upvalues: LocalPlayer (val)
    if not LocalPlayer then
        error("Can only call 'findLocalPlayer' on the client!")
    end
    local v1 = LocalPlayer
    return p1:findPlayer(v1)
end

function u73:_find(p2, p3) -- Line: 562 -- upvalues: u50 (val)
    u50.updateDetection(self)
    local v1 = u50.trackers[p2]
    local v2 = u50.getTouchingZones(p3, false, self._currentEnterDetection, v1)
    for k, v in pairs(v2) do
        if v == self then
            return true
        end
    end
    return false
end

function u73:findPlayer(p2) -- Line: 574
    local Character = p2.Character
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    if not Humanoid then
        return false
    end
    local Character_2 = p2.Character
    return self:_find("player", Character_2)
end

function u73:findItem(p2) -- Line: 583
    return self:_find("item", p2)
end

function u73:findPart(p2) -- Line: 587
    local zonePartsWhitelist = self.overlapParams.zonePartsWhitelist
    local v1, v2 = self:_getRegionConstructor(p2, zonePartsWhitelist)
    local v3 = self.worldModel[v1](self.worldModel, unpack(v2))
    if 0 < #v3 then
        return true, v3
    end
    return false
end

function u73:getCheckerPart() -- Line: 597 -- upvalues: u50 (val)
    local checkerPart = self.checkerPart
    if not checkerPart then
        local janitor = self.janitor
        local Part = Instance.new("Part")
        checkerPart = janitor:add(Part, "Destroy")
        checkerPart.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
        checkerPart.Name = "ZonePlusCheckerPart"
        checkerPart.Anchored = true
        checkerPart.Transparency = 1
        checkerPart.CanCollide = false
        self.checkerPart = checkerPart
    end
    local worldModel = self.worldModel
    if worldModel == workspace then
        worldModel = u50.getWorkspaceContainer()
    end
    if checkerPart.Parent ~= worldModel then
        checkerPart.Parent = worldModel
    end
    return checkerPart
end

function u73:findPoint(p2) -- Line: 618
    local v1 = p2
    if typeof(p2) == "Vector3" then
        v1 = CFrame.new(p2)
    end
    local v2 = self:getCheckerPart()
    v2.CFrame = v1
    local zonePartsWhitelist = self.overlapParams.zonePartsWhitelist
    local v3, v4 = self:_getRegionConstructor(v2, zonePartsWhitelist)
    local v5 = self.worldModel[v3](self.worldModel, unpack(v4))
    if 0 < #v5 then
        return true, v5
    end
    return false
end

function u73:_getAll(p2) -- Line: 635 -- upvalues: u50 (val)
    u50.updateDetection(self)
    local v1 = {}
    local v2 = u50._getZonesAndItems(p2, {self = true}, self.volume, false, self._currentEnterDetection)[self]
    if v2 then
        for k, v in pairs(v2) do
            table.insert(v1, k)
        end
    end
    return v1
end

function u73.getPlayers(p1) -- Line: 648
    return p1:_getAll("player")
end

function u73.getItems(p1) -- Line: 652
    return p1:_getAll("item")
end

function u73.getParts(p1) -- Line: 656
    local v1 = {}
    if p1.activeTriggers.part then
        local part = p1.trackingTouchedTriggers.part
        for k2, i in pairs(part) do
            table.insert(v1, k2)
        end
        return v1
    end
    local worldModel = p1.worldModel
    local CFrame = p1.region.CFrame
    local Size = p1.region.Size
    local zonePartsIgnorelist = p1.overlapParams.zonePartsIgnorelist
    local PartBoundsInBox = worldModel:GetPartBoundsInBox(CFrame, Size, zonePartsIgnorelist)
    for k, v in pairs(PartBoundsInBox) do
        if p1:findPart(v) then
            table.insert(v1, v)
        end
    end
    return v1
end

function u73.getRandomPoint(p1) -- Line: 677
    local new, v1, v2, v3, v4, v5, v6, v7, v8, v9
    local exactRegion = p1.exactRegion
    local Size = exactRegion.Size
    local CFrame_2 = exactRegion.CFrame
    local v10 = Random.new()
    local v11 = nil
    local v12 = p1
    repeat
        new = CFrame.new
        v3 = -Size.X / 2
        v4 = Size.X / 2
        v1 = v10:NextNumber(v3, v4)
        v4 = -Size.Y / 2
        v5 = Size.Y / 2
        v2 = v10:NextNumber(v4, v5)
        v5 = -Size.Z / 2
        v6 = Size.Z / 2
        v7 = CFrame_2 * new(v1, v2, v10:NextNumber(v5, v6))
        v9, v1 = v12:findPoint(v7)
        v8 = v1
        if v9 then
            v11 = true
        end
    until v11
    return v7.Position, v8
end

function u73.setAccuracy(p1, p2) -- Line: 696 -- upvalues: enums (val)
    local v1 = tonumber(p2)
    if not v1 then
        v1 = enums.Accuracy[p2]
        if not v1 then
            error(("'%s' is an invalid enumName!"):format(p2))
        end
    elseif not enums.Accuracy.getName(v1) then
        error(("%s is an invalid enumId!"):format(v1))
    end
    p1.accuracy = v1
end

function u73.setDetection(p1, p2) -- Line: 712 -- upvalues: enums (val)
    local v1 = tonumber(p2)
    if not v1 then
        v1 = enums.Detection[p2]
        if not v1 then
            error(("'%s' is an invalid enumName!"):format(p2))
        end
    elseif not enums.Detection.getName(v1) then
        error(("%s is an invalid enumId!"):format(v1))
    end
    p1.enterDetection = v1
    p1.exitDetection = v1
end

function u73:trackItem(p2) -- Line: 729 -- upvalues: Janitor (val), Tracker (val)
    local v1 = p2:IsA("BasePart")
    local v2 = false
    if not v1 then
        local Humanoid = p2:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid = p2:FindFirstChild("HumanoidRootPart")
        end
        v2 = Humanoid
    end
    assert(v1 or v2, "Only BaseParts or Characters/NPCs can be tracked!")
    if self.trackedItems[p2] then
        return
    end
    if self.itemsToUntrack[p2] then
        self.itemsToUntrack[p2] = nil
    end
    local janitor = self.janitor
    local v3 = Janitor
    v3 = v3.new()
    local v4 = janitor:add(v3, "destroy")
    local v5 = {janitor = v4, item = p2, isBasePart = v1, isCharacter = v2}
    self.trackedItems[p2] = v5
    local v6 = p2.AncestryChanged:Connect(function() -- Line: 754 -- upvalues: p2 (val), self (val)
        local v1 = p2
        local v2 = game
        if not v1:IsDescendantOf(v2) then
            v1 = self
            v2 = p2
            v1:untrackItem(v2)
        end
    end)
    v4:add(v6, "Disconnect")
    require(Tracker).itemAdded:Fire(v5)
end

function u73:untrackItem(p2) -- Line: 764 -- upvalues: Tracker (val)
    local v1 = self.trackedItems[p2]
    if v1 then
        v1.janitor:destroy()
    end
    self.trackedItems[p2] = nil
    require(Tracker).itemRemoved:Fire(v1)
end

function u73.bindToGroup(p1, p2) -- Line: 775 -- upvalues: u50 (val)
    p1:unbindFromGroup()
    local v1 = u50.getGroup(p2)
    if not v1 then
        v1 = u50.setGroup(p2)
    end
    v1._memberZones[p1.zoneId] = p1
    p1.settingsGroupName = p2
end

function u73:unbindFromGroup() -- Line: 782 -- upvalues: u50 (val)
    if self.settingsGroupName then
        local v1 = u50.getGroup(self.settingsGroupName)
        if v1 then
            v1._memberZones[self.zoneId] = nil
        end
        self.settingsGroupName = nil
    end
end

function u73:relocate() -- Line: 792 -- upvalues: CollectiveWorldModel (val)
    if self.hasRelocated then
        return
    end
    local v1 = require(CollectiveWorldModel).setupWorldModel(self)
    self.worldModel = v1
    self.hasRelocated = true
    local container = self.container
    if typeof(container) == "table" then
        container = Instance.new("Folder")
        for k, v in pairs(self.zoneParts) do
            v.Parent = container
        end
    end
    self.relocationContainer = self.janitor:add(container, "Destroy", "RelocationContainer")
    container.Parent = v1
end

function u73:_onItemCallback(p2, p3, p4, p5) -- Line: 813
    local v1 = self.onItemDetails[p4]
    if not v1 then
        v1 = {}
        self.onItemDetails[p4] = v1
    end
    if #v1 == 0 then
        self.itemsToUntrack[p4] = true
    end
    table.insert(v1, p4)
    self:trackItem(p4)

    local function triggerCallback() -- Line: 825 -- upvalues: p5 (val), self (val), p4 (val)
        p5()
        if self.itemsToUntrack[p4] then
            self.itemsToUntrack[p4] = nil
            local v1 = self
            local v2 = p4
            v1:untrackItem(v2)
        end
    end

    if self:findItem(p4) ~= p3 then
        local u45 = nil
        local v2 = self[p2]:Connect(function(p1) -- Line: 838 -- upvalues: u45 (ref), p4 (val), p5 (val), self (val)
            if u45 and p1 == p4 then
                u45:Disconnect()
                u45 = nil
                p5()
                if self.itemsToUntrack[p4] then
                    self.itemsToUntrack[p4] = nil
                    local v1 = self
                    local v2 = p4
                    v1:untrackItem(v2)
                end
            end
        end)
        return
    end
    p5()
    if not self.itemsToUntrack[p4] then
        return
    end
    self.itemsToUntrack[p4] = nil
    self:untrackItem(p4)
end

function u73.onItemEnter(p1, ...) -- Line: 860
    p1:_onItemCallback("itemEntered", true, ...)
end

function u73.onItemExit(p1, ...) -- Line: 864
    p1:_onItemCallback("itemExited", false, ...)
end

function u73:destroy() -- Line: 868
    self:unbindFromGroup()
    self.janitor:destroy()
end

u73.Destroy = u73.destroy
return u73