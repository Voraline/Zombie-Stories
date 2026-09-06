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
local enums = require("@self/Enum").enums
local u31 = require("@self/Janitor")
local u34 = require("@self/Signal")
local v2 = require("@self/ZonePlusReference")
local v3 = v2.getObject()
local ZoneController = script.ZoneController
local Tracker = ZoneController.Tracker
local CollectiveWorldModel = ZoneController.CollectiveWorldModel
local u46 = require(ZoneController)
if not (game:GetService("RunService"):IsClient()) then
    v1 = "Server"
else
    v1 = "Client"
end
local v4 = v3
if v4 then
    v4 = v3:FindFirstChild(v1)
end
if v4 then
    return require(v3.Value)
end
local u69 = {}
u69.__index = u69
if not v4 then
    v2.addToReplicatedStorage()
end
u69.enum = enums
function u69.new(p1) -- Line: 34 -- upvalues: u69 (val), enums (val), u31 (val), HttpService (val), u46 (val), u34 (val), LocalPlayer (val)
    local v1, v2
    local u146 = {}
    setmetatable(u146, u69)
    local v3 = typeof(p1)
    if v3 ~= "table" and v3 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!")
    end
    u146.accuracy = enums.Accuracy.High
    u146.autoUpdate = true
    u146.respectUpdateQueue = true
    local v4 = u31.new()
    u146.janitor = v4
    u146._updateConnections = v4:add(u31.new(), "destroy")
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
    u46.updateDetection(u146)
    u146.updated = v4:add(u34.new(), "destroy")
    local v5 = {"player", "part", "localPlayer", "item"}
    local v6 = {"entered", "exited"}
    for k, v in pairs(v5) do
        local u131 = 0
        local u132 = 0
        for k2, i in pairs(v6) do
            v2 = u34.new(true)
            v1 = v4:add(v2, "destroy")
            v2 = i:sub(1, 1):upper()
            local u173 = v2 .. i:sub(2)
            u146[v .. u173] = v1
            v1.connectionsChanged:Connect(function(p1) -- Line: 105 -- upvalues: v (val), LocalPlayer (upval), u173 (val), u132 (ref), u131 (ref), u46 (upval), u146 (val)
                if v == "localPlayer" and not LocalPlayer and p1 == 1 then
                    error(("Can only connect to 'localPlayer%s' on the client!"):format(u173))
                end
                u132 = u131
                u131 = u131 + p1
                if u132 ~= 0 then
                    if 0 < u132 and u131 == 0 then
                        u46._deregisterConnection(u146, v)
                    end
                    return
                end
                if 0 < u131 then
                    u46._registerConnection(u146, v, u173)
                    return
                end
                if 0 < u132 and u131 == 0 then
                    u46._deregisterConnection(u146, v)
                end
            end)
        end
    end
    u69.touchedConnectionActions = {}
    for k3, j in pairs(v5) do
        u131 = ("_%sTouchedZone"):format(j)
        u132 = u146[u131]
        if u132 then
            u146.trackingTouchedTriggers[j] = {}
            u69.touchedConnectionActions[j] = function(p1) -- Line: 129 -- upvalues: u132 (val), u146 (val)
                u132(u146, p1)
            end
        end
    end
    u146:_update()
    u46._registerZone(u146)
    v4:add(function() -- Line: 140 -- upvalues: u46 (upval), u146 (val)
        u46._deregisterZone(u146)
    end, true)
    return u146
end
function u69.fromRegion(p1, p2) -- Line: 147 -- upvalues: u69 (val)
    local createCube
    local Model = Instance.new("Model")
    function createCube(p1, p2) -- Line: 150 -- upvalues: createCube (val), Model (val)
        local v1, v2, v3
        if 2024 < p2.X or 2024 < p2.Y then
            v1 = p2 * 0.25
            v2 = p2 * 0.5
            v3 = p1 * CFrame.new(-v1.X, -v1.Y, -v1.Z)
            createCube(v3, v2)
            v3 = p1 * CFrame.new(-v1.X, -v1.Y, v1.Z)
            createCube(v3, v2)
            v3 = p1 * CFrame.new(-v1.X, v1.Y, -v1.Z)
            createCube(v3, v2)
            v3 = p1 * CFrame.new(-v1.X, v1.Y, v1.Z)
            createCube(v3, v2)
            v3 = p1 * CFrame.new(v1.X, -v1.Y, -v1.Z)
            createCube(v3, v2)
            v3 = p1 * CFrame.new(v1.X, -v1.Y, v1.Z)
            createCube(v3, v2)
            v3 = p1 * CFrame.new(v1.X, v1.Y, -v1.Z)
            createCube(v3, v2)
            v3 = p1 * CFrame.new(v1.X, v1.Y, v1.Z)
            createCube(v3, v2)
            return
        end
        if 2024 >= p2.Z then
            local Part = Instance.new("Part")
            Part.CFrame = p1
            Part.Size = p2
            Part.Anchored = true
            Part.Parent = Model
            return
        end
        v1 = p2 * 0.25
        v2 = p2 * 0.5
        v3 = p1 * CFrame.new(-v1.X, -v1.Y, -v1.Z)
        createCube(v3, v2)
        v3 = p1 * CFrame.new(-v1.X, -v1.Y, v1.Z)
        createCube(v3, v2)
        v3 = p1 * CFrame.new(-v1.X, v1.Y, -v1.Z)
        createCube(v3, v2)
        v3 = p1 * CFrame.new(-v1.X, v1.Y, v1.Z)
        createCube(v3, v2)
        v3 = p1 * CFrame.new(v1.X, -v1.Y, -v1.Z)
        createCube(v3, v2)
        v3 = p1 * CFrame.new(v1.X, -v1.Y, v1.Z)
        createCube(v3, v2)
        v3 = p1 * CFrame.new(v1.X, v1.Y, -v1.Z)
        createCube(v3, v2)
        v3 = p1 * CFrame.new(v1.X, v1.Y, v1.Z)
        createCube(v3, v2)
    end
    createCube(p1, p2)
    local v1 = u69.new(Model)
    v1:relocate()
    return v1
end
function u69._calculateRegion(p1, p2, p3) -- Line: 179
    local Components, Components_2, Components_3, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    local v14 = {Min = {}, Max = {}}
    for k, v in pairs(v14) do
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
    v11 = p3
    for k2, i in pairs(p2) do
        v13 = i.Size * 0.5
        v1 = {}
        v2 = i.CFrame * CFrame.new(-v13.X, -v13.Y, -v13.Z)
        v3 = i.CFrame * CFrame.new(-v13.X, -v13.Y, v13.Z)
        v4 = i.CFrame * CFrame.new(-v13.X, v13.Y, -v13.Z)
        v5 = i.CFrame * CFrame.new(-v13.X, v13.Y, v13.Z)
        v10 = -v13.Y
        v6 = i.CFrame * CFrame.new(v13.X, v10, -v13.Z)
        v7 = i.CFrame * CFrame.new(v13.X, -v13.Y, v13.Z)
        v8 = i.CFrame * CFrame.new(v13.X, v13.Y, -v13.Z)
        v1[1] = v2
        v1[2] = v3
        v1[3] = v4
        v1[4] = v5
        v1[5] = v6
        v1[6] = v7
        v1[7] = v8
        v1[8] = i.CFrame * CFrame.new(v13.X, v13.Y, v13.Z)
        for k3, j in pairs(v1) do
            Components, Components_2, Components_3 = j:GetComponents()
            v10 = {Components, Components_2, Components_3}
            v14.Min:parse(v10)
            v14.Max:parse(v10)
        end
    end
    local v15 = {}
    local v16 = {}
    local function roundToFour(p1) -- Line: 222
        return math.floor((p1 + 2) / 4) * 4
    end
    for k4, k5 in pairs(v14) do
        for k6, n in pairs(k5.Values) do
            if k4 ~= "Min" then
                v8 = v16
            else
                v8 = v15
            end
            v9 = n
            if not v11 then
                if k4 ~= "Min" then
                    v10 = 2
                else
                    v10 = -2
                end
                v9 = math.floor((n + v10 + 2) / 4) * 4
            end
            table.insert(v8, v9)
        end
    end
    v12 = Vector3.new(unpack(v15))
    local v17 = Vector3.new(unpack(v16))
    return Region3.new(v12, v17), v12, v17
end
function u69._displayBounds(p1) -- Line: 245
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
function u69:_update() -- Line: 264 -- upvalues: RunService (val)
    local PropertyChangedSignal, PropertyChangedSignal_2, _updateConnections, _updateConnections_2, _updateConnections_3, v1, v2, v3, v4, v5, v6
    local container = self.container
    local v7 = {}
    local u250 = 0
    self._updateConnections:clean()
    local v8 = typeof(container)
    local v9 = {}
    if v8 == "table" then
        for k2, v in pairs(container) do
            if v:IsA("BasePart") then
                table.insert(v7, v)
            end
        end
    elseif v8 == "Instance" then
        if not (container:IsA("BasePart")) then
            table.insert(v9, container)
            for i, j in container:QueryDescendants("BasePart") do
                table.insert(v7, j)
            end
            for k, n in container:QueryDescendants(":not(BasePart)") do
                table.insert(v9, n)
            end
        else
            table.insert(v7, container)
        end
    end
    self.zoneParts = v7
    self.overlapParams = {}
    local v10 = true
    for k3, m in pairs(v7) do
        _, v1 = pcall(function() -- Line: 297 -- upvalues: m (val)
            return m.Shape.Name
        end)
        if v1 ~= "Block" then
            v10 = false
        end
    end
    self.allZonePartsAreBlocks = v10
    local v11 = OverlapParams.new()
    v11.FilterType = Enum.RaycastFilterType.Whitelist
    v11.MaxParts = #v7
    v11.FilterDescendantsInstances = v7
    self.overlapParams.zonePartsWhitelist = v11
    local v12 = OverlapParams.new()
    v12.FilterType = Enum.RaycastFilterType.Blacklist
    v12.FilterDescendantsInstances = v7
    self.overlapParams.zonePartsIgnorelist = v12
    local function update() -- Line: 317 -- upvalues: self (val), u250 (ref), RunService (upval)
        if self.autoUpdate then
            local u8 = os.clock()
            if self.respectUpdateQueue then
                u250 = u250 + 1
                u8 = u8 + 0.1
            end
            local u9 = nil
        end
    end
    local v13 = {"Size", "Position"}
    local function verifyDefaultCollision(p1) -- Line: 339
        if p1.CollisionGroupId ~= 0 and p1.CollisionGroupId ~= -1 then
            error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
        end
    end
    local u232 = self
    for k4, i5 in pairs(v7) do
        for k5, i6 in pairs(v13) do
            _updateConnections_3 = u232._updateConnections
            PropertyChangedSignal_2 = i5:GetPropertyChangedSignal(i6)
            v5 = PropertyChangedSignal_2:Connect(update)
            _updateConnections_3:add(v5, "Disconnect")
        end
        if i5.CollisionGroupId ~= 0 and i5.CollisionGroupId ~= -1 then
            error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
        end
        _updateConnections_2 = u232._updateConnections
        PropertyChangedSignal = i5:GetPropertyChangedSignal("CollisionGroupId")
        v4 = PropertyChangedSignal:Connect(function() -- Line: 349 -- upvalues: i5 (val)
            local v1 = i5
            if v1.CollisionGroupId ~= 0 and v1.CollisionGroupId ~= -1 then
                error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
            end
        end)
        _updateConnections_2:add(v4, "Disconnect")
    end
    local v14 = {"ChildAdded", "ChildRemoved"}
    for k6, i7 in pairs(v9) do
        for k7, i8 in pairs(v14) do
            _updateConnections = u232._updateConnections
            v6 = u232.container[i8]:Connect(function(p1) -- Line: 356 -- upvalues: u232 (val), u250 (ref), RunService (upval)
                if p1:IsA("BasePart") and u232.autoUpdate then
                    local u13 = os.clock()
                    if u232.respectUpdateQueue then
                        u250 = u250 + 1
                        u13 = u13 + 0.1
                    end
                    local u14 = nil
                end
            end)
            _updateConnections:add(v6, "Disconnect")
        end
    end
    v1, v2, v3 = u232:_calculateRegion(v7)
    local v15 = u232:_calculateRegion(v7, true)
    u232.region = v1
    u232.exactRegion = v15
    u232.boundMin = v2
    u232.boundMax = v3
    local Size = v1.Size
    u232.volume = Size.X * Size.Y * Size.Z
    u232:_updateTouchedConnections()
    u232.updated:Fire()
end
function u69._updateOccupants(p1, p2, p3) -- Line: 392
    local Character, v1
    local v2 = p1.occupants[p2]
    if not v2 then
        p1.occupants[p2] = {}
    end
    local v3 = {}
    local v4 = p3
    for k, v in pairs(v2) do
        v1 = v4[k]
        if v1 == nil then
            v2[k] = nil
            if not v3.exited then
                v3.exited = {}
            end
            table.insert(v3.exited, k)
        elseif v1 == v then
        end
    end
    for k2, i in pairs(v4) do
        if v2[k2] == nil then
            if not (k2:IsA("Player")) then
                Character = true
            else
                Character = k2.Character
            end
            v2[k2] = Character
            if not v3.entered then
                v3.entered = {}
            end
            table.insert(v3.entered, k2)
        end
    end
    return v3
end
function u69._formTouchedConnection(p1, p2) -- Line: 422 -- upvalues: u31 (val)
    local v1 = "_touchedJanitor" .. p2
    local v2 = p1[v1]
    if not v2 then
        p1[v1] = p1.janitor:add(u31.new(), "destroy")
    else
        v2:clean()
    end
    p1:_updateTouchedConnection(p2)
end
function u69:_updateTouchedConnection(p2) -- Line: 434
    local v1
    local v2 = self["_touchedJanitor" .. p2]
    if not v2 then
        return
    end
    for k, v in pairs(self.zoneParts) do
        v1 = v.Touched:Connect(self.touchedConnectionActions[p2], self)
        v2:add(v1, "Disconnect")
    end
end
function u69:_updateTouchedConnections() -- Line: 443
    local v1
    for k, v in pairs(self.touchedConnectionActions) do
        v1 = self["_touchedJanitor" .. k]
        if v1 then
            v1:cleanup()
            self:_updateTouchedConnection(k)
        end
    end
end
function u69._disconnectTouchedConnection(p1, p2) -- Line: 454
    local v1 = "_touchedJanitor" .. p2
    local v2 = p1[v1]
    if v2 then
        v2:cleanup()
        p1[v1] = nil
    end
end
local function round(p1, p2) -- Line: 463
    local v1 = math.round(p1 * 10 ^ p2)
    return v1 * 10 ^ (-p2)
end
function u69._partTouchedZone(p1, p2) -- Line: 466 -- upvalues: u31 (val), Heartbeat (val), enums (val)
    local part = p1.trackingTouchedTriggers.part
    if part[p2] then
        return
    end
    local u5 = 0
    local u6 = false
    local Position = p2.Position
    local u9 = os.clock()
    local u17 = p1.janitor:add(u31.new(), "destroy")
    part[p2] = u17
    local v1 = {Seat = true, VehicleSeat = true}
    local v2 = {HumanoidRootPart = true}
    if not (v1[p2.ClassName]) and v2[p2.Name] then
        p2.CanTouch = false
    end
    local u37 = math.round(p2.Size.X * p2.Size.Y * p2.Size.Z * 100000) * 1e-05
    p1.totalPartVolume = p1.totalPartVolume + u37
    local v3 = Heartbeat:Connect(function() -- Line: 484 -- upvalues: u5 (ref), enums (upval), p1 (val), p2 (val), u6 (ref), Position (ref), u9 (ref), u17 (val)
        local v1 = os.clock()
        if u5 > v1 then
            return
        end
        local v2 = enums.Accuracy.getProperty(p1.accuracy)
        u5 = v1 + v2
        local v3 = p1:findPoint(p2.CFrame)
        if not v3 then
            v3 = p1:findPart(p2)
        end
        if u6 then
            if not v3 then
                u6 = false
                Position = p2.Position
                u9 = os.clock()
                p1.partExited:Fire(p2)
            end
            return
        end
        if v3 then
            u6 = true
            p1.partEntered:Fire(p2)
            return
        end
        if 1.5 >= (p2.Position - Position).Magnitude or v2 > v1 - u9 then
            return
        end
        u17:cleanup()
    end)
    u17:add(v3, "Disconnect")
    u17:add(function() -- Line: 515 -- upvalues: part (val), p2 (val), p1 (val), u37 (val)
        part[p2] = nil
        p2.CanTouch = true
        p1.totalPartVolume = math.round((p1.totalPartVolume - u37) * 100000) * 1e-05
    end, true)
end
local u114 = {
    Ball = function(p1) -- Line: 523
        return "GetPartBoundsInRadius", {p1.Position, p1.Size.X}
    end,
    Block = function(p1) -- Line: 526
        return "GetPartBoundsInBox", {p1.CFrame, p1.Size}
    end,
    Other = function(p1) -- Line: 529
        return "GetPartsInPart", {p1}
    end,
}
function u69:_getRegionConstructor(p2, p3) -- Line: 533 -- upvalues: u114 (val)
    local v1, v2
    v1, v2 = pcall(function() -- Line: 534 -- upvalues: p2 (val)
        return p2.Shape.Name
    end)
    local v3 = nil
    local v4 = nil
    if v1 and self.allZonePartsAreBlocks then
        local v5 = u114[v2]
        if v5 then
            local v6, v7
            v6, v7 = v5(p2)
            v3 = v6
            v4 = v7
        end
    end
    if not v3 then
        v3 = "GetPartsInPart"
        v4 = {p2}
    end
    if p3 then
        table.insert(v4, p3)
    end
    return v3, v4
end
function u69.findLocalPlayer(p1) -- Line: 554 -- upvalues: LocalPlayer (val)
    if not LocalPlayer then
        error("Can only call 'findLocalPlayer' on the client!")
    end
    return p1:findPlayer(LocalPlayer)
end
function u69:_find(p2, p3) -- Line: 561 -- upvalues: u46 (val)
    u46.updateDetection(self)
    local v1 = u46.getTouchingZones(p3, false, self._currentEnterDetection, u46.trackers[p2])
    for k, v in pairs(v1) do
        if v == self then
            return true
        end
    end
    return false
end
function u69:findPlayer(p2) -- Line: 573
    local Character = p2.Character
    local Humanoid = Character
    if Humanoid then
        Humanoid = Character:FindFirstChildOfClass("Humanoid")
    end
    if not Humanoid then
        return false
    end
    return self:_find("player", p2.Character)
end
function u69:findItem(p2) -- Line: 582
    return self:_find("item", p2)
end
function u69:findPart(p2) -- Line: 586
    local v1, v2
    v1, v2 = self:_getRegionConstructor(p2, self.overlapParams.zonePartsWhitelist)
    local v3 = self.worldModel[v1](self.worldModel, unpack(v2))
    if 0 < #v3 then
        return true, v3
    end
    return false
end
function u69:getCheckerPart() -- Line: 596 -- upvalues: u46 (val)
    local checkerPart = self.checkerPart
    if not checkerPart then
        local Part = Instance.new("Part")
        checkerPart = self.janitor:add(Part, "Destroy")
        checkerPart.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
        checkerPart.Name = "ZonePlusCheckerPart"
        checkerPart.Anchored = true
        checkerPart.Transparency = 1
        checkerPart.CanCollide = false
        self.checkerPart = checkerPart
    end
    local worldModel = self.worldModel
    if worldModel == workspace then
        worldModel = u46.getWorkspaceContainer()
    end
    if checkerPart.Parent ~= worldModel then
        checkerPart.Parent = worldModel
    end
    return checkerPart
end
function u69:findPoint(p2) -- Line: 617
    local v1, v2
    local v3 = if typeof(p2) == "Vector3" then CFrame.new(p2) else p2
    local v4 = self:getCheckerPart()
    v4.CFrame = v3
    v1, v2 = self:_getRegionConstructor(v4, self.overlapParams.zonePartsWhitelist)
    local v5 = self.worldModel[v1](self.worldModel, unpack(v2))
    if 0 < #v5 then
        return true, v5
    end
    return false
end
function u69:_getAll(p2) -- Line: 634 -- upvalues: u46 (val)
    u46.updateDetection(self)
    local v1 = {}
    local v2 = u46._getZonesAndItems(p2, {self = true}, self.volume, false, self._currentEnterDetection)[self]
    if v2 then
        for k, v in pairs(v2) do
            table.insert(v1, k)
        end
    end
    return v1
end
function u69.getPlayers(p1) -- Line: 647
    return p1:_getAll("player")
end
function u69.getItems(p1) -- Line: 651
    return p1:_getAll("item")
end
function u69.getParts(p1) -- Line: 655
    local part
    local v1 = {}
    if p1.activeTriggers.part then
        part = p1.trackingTouchedTriggers.part
        for k2, i in pairs(part) do
            table.insert(v1, k2)
        end
        return v1
    end
    local PartBoundsInBox = p1.worldModel:GetPartBoundsInBox(p1.region.CFrame, p1.region.Size, p1.overlapParams.zonePartsIgnorelist)
    for k, v in pairs(PartBoundsInBox) do
        if p1:findPart(v) then
            table.insert(v1, v)
        end
    end
    return v1
end
function u69.getRandomPoint(p1) -- Line: 676
    local v1, v2, v3, v4
    local exactRegion = p1.exactRegion
    local Size = exactRegion.Size
    local CFrame = exactRegion.CFrame
    local v5 = Random.new()
    local v6 = nil
    local v7 = p1
    while true do
        v1 = v5:NextNumber(-Size.X / 2, Size.X / 2)
        v2 = v5:NextNumber(-Size.Y / 2, Size.Y / 2)
        v3 = CFrame * CFrame.new(v1, v2, v5:NextNumber(-Size.Z / 2, Size.Z / 2))
        v4, v1 = v7:findPoint(v3)
        if v4 then
            v6 = true
        end
        if v6 then
            break
        end
    end
    return v3.Position, v1
end
function u69.setAccuracy(p1, p2) -- Line: 695 -- upvalues: enums (val)
    local v1 = tonumber(p2)
    if not v1 then
        v1 = enums.Accuracy[p2]
        if not v1 then
            error(("'%s' is an invalid enumName!"):format(p2))
        end
    elseif not (enums.Accuracy.getName(v1)) then
        error(("%s is an invalid enumId!"):format(v1))
    end
    p1.accuracy = v1
end
function u69.setDetection(p1, p2) -- Line: 711 -- upvalues: enums (val)
    local v1 = tonumber(p2)
    if not v1 then
        v1 = enums.Detection[p2]
        if not v1 then
            error(("'%s' is an invalid enumName!"):format(p2))
        end
    elseif not (enums.Detection.getName(v1)) then
        error(("%s is an invalid enumId!"):format(v1))
    end
    p1.enterDetection = v1
    p1.exitDetection = v1
end
function u69:trackItem(p2) -- Line: 728 -- upvalues: u31 (val), Tracker (val)
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
    local v3 = self.janitor:add(u31.new(), "destroy")
    local v4 = {janitor = v3, item = p2, isBasePart = v1, isCharacter = v2}
    self.trackedItems[p2] = v4
    local v5 = p2.AncestryChanged:Connect(function() -- Line: 753 -- upvalues: p2 (val), self (val)
        if not (p2:IsDescendantOf(game)) then
            self:untrackItem(p2)
        end
    end)
    v3:add(v5, "Disconnect")
    require(Tracker).itemAdded:Fire(v4)
end
function u69:untrackItem(p2) -- Line: 763 -- upvalues: Tracker (val)
    local v1 = self.trackedItems[p2]
    if v1 then
        v1.janitor:destroy()
    end
    self.trackedItems[p2] = nil
    require(Tracker).itemRemoved:Fire(v1)
end
function u69.bindToGroup(p1, p2) -- Line: 774 -- upvalues: u46 (val)
    p1:unbindFromGroup()
    local v1 = u46.getGroup(p2)
    if not v1 then
        v1 = u46.setGroup(p2)
    end
    v1._memberZones[p1.zoneId] = p1
    p1.settingsGroupName = p2
end
function u69:unbindFromGroup() -- Line: 781 -- upvalues: u46 (val)
    if self.settingsGroupName then
        local v1 = u46.getGroup(self.settingsGroupName)
        if v1 then
            v1._memberZones[self.zoneId] = nil
        end
        self.settingsGroupName = nil
    end
end
function u69:relocate() -- Line: 791 -- upvalues: CollectiveWorldModel (val)
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
function u69:_onItemCallback(p2, p3, p4, p5) -- Line: 812
    local v1 = self.onItemDetails[p4]
    if not v1 then
        self.onItemDetails[p4] = {}
    end
    if #v1 == 0 then
        self.itemsToUntrack[p4] = true
    end
    table.insert(v1, p4)
    self:trackItem(p4)
    local function triggerCallback() -- Line: 824 -- upvalues: p5 (val), self (val), p4 (val)
        p5()
        if self.itemsToUntrack[p4] then
            self.itemsToUntrack[p4] = nil
            self:untrackItem(p4)
        end
    end
    if self:findItem(p4) ~= p3 then
        local u45 = nil
        return
    end
    p5()
    if not (self.itemsToUntrack[p4]) then
        return
    end
    self.itemsToUntrack[p4] = nil
    self:untrackItem(p4)
end
function u69.onItemEnter(p1, ...) -- Line: 859
    p1:_onItemCallback("itemEntered", true, ...)
end
function u69.onItemExit(p1, ...) -- Line: 863
    p1:_onItemCallback("itemExited", false, ...)
end
function u69:destroy() -- Line: 867
    self:unbindFromGroup()
    self.janitor:destroy()
end
u69.Destroy = u69.destroy
return u69