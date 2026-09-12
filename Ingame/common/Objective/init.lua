local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local common = game.ReplicatedStorage.common
local LocalPlayer = game.Players.LocalPlayer
local RedEvents = game.ReplicatedStorage.common.RedEvents
local u22 = require("@self/Pathfinder")
local Signal = require(common.Signal)
local u55 = nil
local u34 = game:GetService("RunService"):IsServer()
local ReplicateObjective = require(RedEvents.General.ReplicateObjective)
local u39 = {}
local u40 = {
    Type = true,
    Text = true,
    IsPrimary = true,
    MarkerMap = true,
    MarkerPositions = true,
    MarkerParts = true,
    Location = true,
    Progress = true,
    ProgressTotal = true,
    TargetPlayers = true,
    ImageID = true,
    AccentColor = true,
    ProgressFormat = true,
    NewSoundId = true,
    CompleteSoundId = true,
}
if not u34 then
    local HUDController = (game:GetService("ReplicatedStorage")).common.ZS_Framework.Modules.Controllers.HUDController
    u55 = require(HUDController.HUDElements.Objectives)
end
local u56 = {}
u56.__index = u56
u56.Completed = Signal.new()

function u56.__index(p1, p2) -- Line: 136 -- upvalues: u40 (val), u56 (val)
    local v1 = rawget(p1, p2)
    if u40[p2] then
        return rawget(p1, "Properties")[p2]
    end
    if v1 ~= nil then
        return v1
    end
    return u56[p2]
end

function u56.__newindex(p1, p2, p3) -- Line: 148 -- upvalues: u40 (val), u56 (val)
    local v1 = rawget(p1, p2)
    if u40[p2] then
        p1:_SetProperty(p2, p3)
        return p1
    end
    if v1 ~= nil then
        p1[p2] = p3
        return p1
    end
    u56[p2] = p3
    return p1
end

function u56.new(p1, p2) -- Line: 167
    -- upvalues: HttpService (val), u34 (val), u39 (val), ReplicateObjective (val), u56 (val), u55 (ref)
    local MarkerPositions_4, Parts, v1, v2
    if not p2 then
        v1 = HttpService:GenerateGUID(false)
    else
        v1 = p2
    end
    if not u34 and v1 == nil then end
    local v3 = p1 ~= nil
    assert(v3, "Must pass a property table")
    v3 = p1.Type ~= nil
    assert(v3, "Must pass a Type in the propertyTable")
    v3 = p1.Text ~= nil
    assert(v3, "Must pass text in the propertyTable")
    p1.MarkerParts = formatMarkerParts(p1.MarkerParts, v1)
    local v4 = {}
    v4.Type = p1.Type
    v4.Text = p1.Text
    v4.IsPrimary = p1.IsPrimary
    v4.MarkerMap = p1.MarkerMap
    v4.MarkerPositions = p1.MarkerPositions
    v4.MarkerParts = p1.MarkerParts
    v4.Location = p1.Location
    v4.Progress = p1.Progress
    v4.ProgressTotal = p1.ProgressTotal or 1
    v4.ImageID = p1.ImageID
    v4.AccentColor = p1.AccentColor
    v4.ProgressFormat = p1.ProgressFormat
    v4.NewSoundId = p1.NewSoundId
    v4.CompleteSoundId = p1.CompleteSoundId
    if not p1.ProgressTotal then
        if v4.Type == "kill" or v4.Type == "collect" or v4.Type == "find" then
            if not v4.ProgressFormat then
                v4.ProgressFormat = ""
            end
        elseif v4.Type == "interact" and not v4.ProgressFormat then
            v4.ProgressFormat = ""
        end
    end
    if v4.MarkerPositions then
        v3 = true
        local MarkerPositions = v4.MarkerPositions
        if typeof(MarkerPositions) ~= "table" then
            local MarkerPositions_3 = v4.MarkerPositions
            if typeof(MarkerPositions_3) ~= "Vector3" then
                v3 = false
            end
        elseif not v4.MarkerPositions[1] then
            v3 = false
        else
            local v5 = v4.MarkerPositions[1]
            if typeof(v5) ~= "Vector3" then
                v3 = false
            end
        end
        if not v3 then
            error("MarkerPositions must be of type Vector3 or array of Vector3")
        end
    elseif not u34 and v4.MarkerParts then
        v2 = v4.MarkerParts.Count ~= nil
        assert(v2, "MarkerParts table needs a count")
        v4.MarkerParts.Parts = getUnreplicatedParts(v1, v4.MarkerParts.Count)
    end
    if v4.Type == "kill" or v4.Type == "find" or v4.Type == "collect" or v4.Type == "interact" then
        if not v4.Progress then
            v4.Progress = 0
        end
    elseif v4.Type ~= "money" then
        if p1.Type ~= "move" then
            error("Type must be either kill, find, collect, interact, or move")
        end
    elseif not v4.Progress then
        v4.Progress = 0
    end
    if u34 then
        v3 = {_Destroyed = false, _Identifier = v1, _ServerProperties = {}, Properties = v4}
        u39[v3._Identifier] = v3
        v2 = {Type = "Add", PropertyTable = v4, Identifier = v1}
        local TargetPlayers = p1.TargetPlayers
        if not TargetPlayers then
            ReplicateObjective:FireAllClients(v2)
        else
            ReplicateObjective:FireClients(TargetPlayers, v2)
        end
        if TargetPlayers then
            v3._ServerProperties.TargetPlayers = TargetPlayers
        end
        local v6 = u56
        return (setmetatable(v3, v6))
    end
    v3 = {_Destroyed = false}
    v3._Identifier = v1
    v3.Properties = v4
    v2 = v1 == nil
    v3._IsLocal = v2
    local v7 = u56
    setmetatable(v3, v7)
    u39[v3._Identifier] = v3
    u55:AddObjective(v4, v1)
    if not v4.Location then
        if not v4.MarkerMap then
            if v4.MarkerParts then
                Parts = v4.MarkerParts.Parts
                v3:AddMarkers(Parts)
            end
            if v4.MarkerPositions then
                MarkerPositions_4 = v4.MarkerPositions
                v3:AddMarkers(MarkerPositions_4)
            end
        else
            v3:_UpdateMarkerMap()
        end
    elseif not v4.MarkerMap then
        local Location = v4.Location
        v3:AddMarker(Location)
    elseif not v4.MarkerMap then
        if v4.MarkerParts then
            Parts = v4.MarkerParts.Parts
            v3:AddMarkers(Parts)
        end
        if v4.MarkerPositions then
            MarkerPositions_4 = v4.MarkerPositions
            v3:AddMarkers(MarkerPositions_4)
        end
    else
        v3:_UpdateMarkerMap()
    end
    if v4.Type == "move" then
        v3:_RunMoveProgressUpdates()
    end
    return v3
end

function u56:AddMarker(p2) -- Line: 302 -- upvalues: u55 (ref)
    local v1 = u55
    local Properties = self.Properties
    local _Identifier = self._Identifier
    v1 = v1:AddMarker(Properties, p2, nil, _Identifier)
    if typeof(p2) == "Vector3" then
        if not self._MarkerPositionIdentifiers then
            self._MarkerPositionIdentifiers = {}
        end
        local _MarkerPositionIdentifiers = self._MarkerPositionIdentifiers
        table.insert(_MarkerPositionIdentifiers, v1)
        return v1
    end
    if typeof(p2) == "Instance" then
        if not self._MarkerPartIdentifiers then
            self._MarkerPartIdentifiers = {}
        end
        local _MarkerPartIdentifiers = self._MarkerPartIdentifiers
        table.insert(_MarkerPartIdentifiers, v1)
    end
    return v1
end

function u56:AddMarkers(p2) -- Line: 324
    local v1 = true
    if typeof(p2) == "Vector3" then
        self:AddMarker(p2)
    elseif typeof(p2) ~= "table" or not p2[1] then
        v1 = false
    else
        local v2, v3
        local v4 = p2[1]
        if typeof(v4) ~= "Vector3" then
            v4 = p2[1]
            if typeof(v4) ~= "Instance" then
                v1 = false
            else
                v2 = p2
                v4 = nil
                v3 = nil
                for i, j in v2, v4, v3 do
                    self:AddMarker(j)
                end
            end
        else
            v2 = p2
            v4 = nil
            v3 = nil
            for k, n in v2, v4, v3 do
                self:AddMarker(n)
            end
        end
    end
    if not v1 then
        error("Markers must be of type Vector3, {Vector3}, or {BasePart}")
    end
end

function u56.AppendPlayer(p1, p2) -- Line: 351
    local v1 = {}
    local TargetPlayers = p1._ServerProperties.TargetPlayers
    if not TargetPlayers then
        table.insert(v1, p2)
    else
        local value = TargetPlayers.value
        local v2 = nil
        local v3 = nil
        for i, j in value, v2, v3 do
            table.insert(v1, j)
        end
        if not table.find(TargetPlayers.value, p2) then
            table.insert(v1, p2)
        end
    end
    p1.TargetPlayers = v1
end

function u56:Destroy(p2) -- Line: 368 -- upvalues: u56 (val), u34 (val), ReplicateObjective (val), u39 (val), u55 (ref)
    local v1
    if p2 then
        u56.Completed:Fire(self)
    end
    if u34 then
        v1 = {Type = "Destroy", Identifier = self._Identifier, WasCompleted = p2 or false}
        if not self._ServerProperties.TargetPlayers then
            ReplicateObjective:FireAllClients(v1)
        else
            local v2 = ReplicateObjective
            local TargetPlayers = self._ServerProperties.TargetPlayers
            v2:FireClients(TargetPlayers, v1)
        end
        u39[self._Identifier] = nil
        return
    end
    if not self._Destroyed then
        v1 = u55
        local _Identifier = self._Identifier
        v1:RemoveObjective(_Identifier, p2)
        self:_IterateMarkers(function(p1) -- Line: 390 -- upvalues: u55 (upval)
            u55:RemoveMarker(p1)
        end)
        self:_StopMarkerPathfinding()
        self:_StopMoveProgressUpdates()
        self._Destroyed = true
    end
end

function u56.Remove(p1) -- Line: 403
    p1:Destroy()
end

function u56.Complete(p1) -- Line: 408
    p1:Destroy(true)
end

function u56:_UpdateMarkerMap() -- Line: 412 -- upvalues: u55 (ref), u22 (val)
    self:_IterateMarkers(function(p1) -- Line: 414 -- upvalues: u55 (upval)
        u55:RemoveMarker(p1)
    end)
    if not self.Properties.MarkerMap then
        self:_StopMarkerPathfinding()
        return
    end
    local v1 = u22
    local MarkerMap = self.Properties.MarkerMap
    v1:Init(MarkerMap)
    self:_RunMarkerPathfinding()
end

function u56:_RunMarkerPathfinding() -- Line: 426 -- upvalues: u55 (ref), u22 (val)
    local MarkerMap = self.Properties.MarkerMap
    assert(MarkerMap, "This objective has node map for markers")
    local u7 = tick()
    self._PathfindingCode = u7
    task.defer(function() -- Line: 431 -- upvalues: u7 (val), self (val), u55 (upval), u22 (upval)
        local Character, HumanoidRootPart, Location, Location_2, Position, Position_2, v1, v2, v3
        local LocalPlayer = game.Players.LocalPlayer
        local v4 = nil
        while task.wait(0.2) do
            if u7 ~= self._PathfindingCode then
                break
            end
            Character = LocalPlayer.Character
            Position = nil
            if Character then
                HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart then
                    Position = HumanoidRootPart.Position
                end
            end
            Location = self.Properties.Location
            Position_2 = nil
            if Location then
                if typeof(Location) == "Vector3" then
                    Position_2 = Location
                elseif typeof(Location) == "Instance" and Location:IsA("BasePart") then
                    Position_2 = Location.Position
                end
            end
            v2 = self
            v2:_IterateMarkers(function(p1) -- Line: 456 -- upvalues: u55 (upval)
                u55:RemoveMarker(p1)
            end)
            if Position and Position_2 then
                v2 = u22:FindPath(Position, Position_2) or {}
                if 1 <= #v2 then
                    if (Position - v2[1]).Magnitude < 10 then
                        v4 = table.remove(v2, 1)
                    elseif v4 == v2[1] then
                        table.remove(v2, 1)
                    end
                end
                if #v2 ~= 0 then
                    v3 = self
                    v1 = v2[1]
                    v3:AddMarker(v1)
                else
                    v3 = self
                    v1 = self
                    Location_2 = v1.Properties.Location
                    v3:AddMarker(Location_2)
                end
            end
        end
    end)
end

function u56:_StopMarkerPathfinding() -- Line: 487
    self._PathfindingCode = nil
end

function u56:_RunMoveProgressUpdates() -- Line: 491 -- upvalues: u55 (ref)
    self._IsMoveProgressRunning = true
    task.defer(function() -- Line: 493 -- upvalues: self (val), u55 (upval)
        local Character, HumanoidRootPart, Location, Position, Position_2, _Identifier, v1, v2, v3, v4
        local LocalPlayer = game.Players.LocalPlayer
        while task.wait(0.2) do
            if not self._IsMoveProgressRunning then
                break
            end
            Character = LocalPlayer.Character
            Position = nil
            if Character then
                HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart then
                    Position = HumanoidRootPart.Position
                end
            end
            Location = self.Properties.Location
            Position_2 = nil
            if Location then
                if typeof(Location) == "Vector3" then
                    Position_2 = Location
                elseif typeof(Location) == "Instance" and Location:IsA("BasePart") then
                    Position_2 = Location.Position
                end
            end
            if Position and Position_2 then
                v1 = u55
                v2 = self
                _Identifier = v2._Identifier
                v4 = (Position - Position_2).Magnitude * 0.28
                v3 = math.floor(v4)
                v1:UpdateProgress(_Identifier, v3)
            end
        end
    end)
end

function u56:_StopMoveProgressUpdates() -- Line: 522
    self._IsMoveProgressRunning = nil
end

function u56:_SetProperty(p2, p3) -- Line: 526 -- upvalues: u40 (val), u34 (val), ReplicateObjective (val), u55 (ref)
    if u40[p2] then
        local v1, v2, v3, v4, v5
        if p2 ~= "TargetPlayers" then
            self.Properties[p2] = p3
        end
        if u34 then
            if p2 == "MarkerParts" then
                p3 = formatMarkerParts(p3, self._Identifier)
            end
            if p2 == "TargetPlayers" then
                local v6
                v1 = nil
                local TargetPlayers = self._ServerProperties.TargetPlayers
                if not TargetPlayers then
                    v6 = self
                else
                    local v7, v8
                    v3 = p3
                    v4 = nil
                    v5 = nil
                    v6 = self
                    for i6, i7 in v3, v4, v5 do
                        if not table.find(TargetPlayers.value, i7) then
                            if not v1 then
                                v1 = {}
                            end
                            table.insert(v1, i7)
                        end
                    end
                    local value = TargetPlayers.value
                    v4 = nil
                    v5 = nil
                    for i8, i9 in value, v4, v5 do
                        if not table.find(p3, i9) then
                            v7 = ReplicateObjective
                            v8 = {Type = "Destroy", WasCompleted = false, Identifier = v6._Identifier}
                            v7:FireClient(i9, v8)
                        end
                    end
                end
                v6._ServerProperties.TargetPlayers = p3
                if v1 then
                    v3 = {Type = "Add", PropertyTable = v6.Properties, Identifier = v6._Identifier}
                    ReplicateObjective:FireClients(v1, v3)
                end
                return
            end
            v1 = {Type = "PropertyChanged", Identifier = self._Identifier, Index = p2, Value = p3}
            if not self._ServerProperties.TargetPlayers then
                ReplicateObjective:FireAllClients(v1)
            else
                v2 = ReplicateObjective
                local TargetPlayers_2 = self._ServerProperties.TargetPlayers
                v2:FireClients(TargetPlayers_2, v1)
            end
        elseif p2 == "Text" then
            self:_IterateMarkers(function(p1) -- Line: 593 -- upvalues: u55 (upval), p3 (ref)
                local v1 = u55
                local v2 = p3
                v1:SetMarkerText(p1, v2)
            end)
        else
            local Parts, _Identifier, _Identifier_2, _Identifier_3, _MarkerPartIdentifiers, v9
            if p2 ~= "MarkerPositions" then
                if p2 ~= "MarkerParts" then
                    if p2 == "Progress" then
                        v1 = u55
                        _Identifier = self._Identifier
                        v4 = p3
                        v1:UpdateProgress(_Identifier, v4)
                    elseif p2 == "ProgressTotal" then
                        v1 = u55
                        _Identifier_2 = self._Identifier
                        v5 = p3
                        v1:UpdateProgress(_Identifier_2, nil, v5)
                    elseif p2 == "IsPrimary" then
                        v1 = u55
                        _Identifier_3 = self._Identifier
                        v4 = p3
                        v1:SetIsPrimary(_Identifier_3, v4)
                    elseif p2 == "MarkerMap" then
                        self:_UpdateMarkerMap()
                    elseif p2 == "Location" and not self.Properties.MarkerMap and p3 ~= nil then
                        v3 = p3
                        self:AddMarker(v3)
                    end
                elseif not self.MarkerMap then
                    v9 = formatMarkerParts(p3, self._Identifier)
                    self.Properties[p2] = v9
                    v9.Parts = getUnreplicatedParts(self._Identifier, v9.Count)
                    if self._MarkerPartIdentifiers then
                        _MarkerPartIdentifiers = self._MarkerPartIdentifiers
                        v2 = nil
                        v3 = nil
                        for i, j in _MarkerPartIdentifiers, v2, v3 do
                            u55:RemoveMarker(j)
                        end
                    end
                    Parts = v9.Parts
                    self:AddMarkers(Parts)
                elseif p2 == "Progress" then
                    v1 = u55
                    _Identifier = self._Identifier
                    v4 = p3
                    v1:UpdateProgress(_Identifier, v4)
                elseif p2 == "ProgressTotal" then
                    v1 = u55
                    _Identifier_2 = self._Identifier
                    v5 = p3
                    v1:UpdateProgress(_Identifier_2, nil, v5)
                elseif p2 == "IsPrimary" then
                    v1 = u55
                    _Identifier_3 = self._Identifier
                    v4 = p3
                    v1:SetIsPrimary(_Identifier_3, v4)
                elseif p2 == "MarkerMap" then
                    self:_UpdateMarkerMap()
                elseif p2 == "Location" and not self.Properties.MarkerMap and p3 ~= nil then
                    v3 = p3
                    self:AddMarker(v3)
                end
            elseif not self.MarkerMap then
                if self._MarkerPositionIdentifiers then
                    local _MarkerPositionIdentifiers = self._MarkerPositionIdentifiers
                    v2 = nil
                    v3 = nil
                    for m, i5 in _MarkerPositionIdentifiers, v2, v3 do
                        u55:RemoveMarker(i5)
                    end
                end
                v3 = p3
                self:AddMarkers(v3)
            elseif p2 ~= "MarkerParts" then
                if p2 == "Progress" then
                    v1 = u55
                    _Identifier = self._Identifier
                    v4 = p3
                    v1:UpdateProgress(_Identifier, v4)
                elseif p2 == "ProgressTotal" then
                    v1 = u55
                    _Identifier_2 = self._Identifier
                    v5 = p3
                    v1:UpdateProgress(_Identifier_2, nil, v5)
                elseif p2 == "IsPrimary" then
                    v1 = u55
                    _Identifier_3 = self._Identifier
                    v4 = p3
                    v1:SetIsPrimary(_Identifier_3, v4)
                elseif p2 == "MarkerMap" then
                    self:_UpdateMarkerMap()
                elseif p2 == "Location" and not self.Properties.MarkerMap and p3 ~= nil then
                    v3 = p3
                    self:AddMarker(v3)
                end
            elseif not self.MarkerMap then
                v9 = formatMarkerParts(p3, self._Identifier)
                self.Properties[p2] = v9
                v9.Parts = getUnreplicatedParts(self._Identifier, v9.Count)
                if self._MarkerPartIdentifiers then
                    _MarkerPartIdentifiers = self._MarkerPartIdentifiers
                    v2 = nil
                    v3 = nil
                    for k, n in _MarkerPartIdentifiers, v2, v3 do
                        u55:RemoveMarker(n)
                    end
                end
                Parts = v9.Parts
                self:AddMarkers(Parts)
            elseif p2 == "Progress" then
                v1 = u55
                _Identifier = self._Identifier
                v4 = p3
                v1:UpdateProgress(_Identifier, v4)
            elseif p2 == "ProgressTotal" then
                v1 = u55
                _Identifier_2 = self._Identifier
                v5 = p3
                v1:UpdateProgress(_Identifier_2, nil, v5)
            elseif p2 == "IsPrimary" then
                v1 = u55
                _Identifier_3 = self._Identifier
                v4 = p3
                v1:SetIsPrimary(_Identifier_3, v4)
            elseif p2 == "MarkerMap" then
                self:_UpdateMarkerMap()
            elseif p2 == "Location" and not self.Properties.MarkerMap and p3 ~= nil then
                v3 = p3
                self:AddMarker(v3)
            end
        end
    end
end

function u56:_IterateMarkers(p2) -- Line: 637
    local v1, v2
    if self._MarkerPositionIdentifiers then
        local _MarkerPositionIdentifiers = self._MarkerPositionIdentifiers
        v1 = nil
        v2 = nil
        for i, j in _MarkerPositionIdentifiers, v1, v2 do
            p2(j)
        end
    end
    if self._MarkerPartIdentifiers then
        local _MarkerPartIdentifiers = self._MarkerPartIdentifiers
        v1 = nil
        v2 = nil
        for k, n in _MarkerPartIdentifiers, v1, v2 do
            p2(n)
        end
    end
end

function getUnreplicatedPart(p1) -- Line: 650 -- upvalues: CollectionService (val)
    local v1 = CollectionService:GetTagged(p1)[1]
    while v1 == nil do
        v1 = CollectionService:GetInstanceAddedSignal(p1):Wait()
    end
    return v1
end

function getUnreplicatedParts(p1, p2) -- Line: 658 -- upvalues: CollectionService (val)
    local v1
    local v2, v3 = p1, p2
    repeat
        v1 = CollectionService:GetTagged(v2)
        if #v1 < v3 then
            CollectionService:GetInstanceAddedSignal(v2):Wait()
        end
    until v3 <= #v1
    return v1
end

function formatMarkerParts(p1, p2) -- Line: 669 -- upvalues: CollectionService (val)
    local v1, v2
    if not p1 then
        return nil
    end
    if typeof(p1) ~= "table" then
        if typeof(p1) ~= "Instance" then
            if p1.Parts then
                v1 = p1
            else
                error("MarkerParts must be {BasePart} or BasePart")
                v1 = p1
            end
        elseif p1:IsA("BasePart") then
            v1 = {
                Count = 1,
                Parts = {p1},
            }
        elseif p1.Parts then
            v1 = p1
        else
            error("MarkerParts must be {BasePart} or BasePart")
            v1 = p1
        end
    elseif not p1.Parts then
        v2 = false
        local v3 = p1[1]
        if typeof(v3) == "Instance" then
            v2 = p1[1]:IsA("BasePart")
        end
        assert(v2, "MarkerParts table must be an array of BaseParts")
        v1 = {Parts = p1, Count = #p1}
    elseif typeof(p1) ~= "Instance" then
        if p1.Parts then
            v1 = p1
        else
            error("MarkerParts must be {BasePart} or BasePart")
            v1 = p1
        end
    elseif p1:IsA("BasePart") then
        v1 = {
            Count = 1,
            Parts = {p1},
        }
    elseif p1.Parts then
        v1 = p1
    else
        error("MarkerParts must be {BasePart} or BasePart")
        v1 = p1
    end
    if typeof(v1) == "Instance" then
        CollectionService:AddTag(v1, p2)
        return v1
    end
    if typeof(v1) == "table" then
        local Parts = v1.Parts
        v2 = nil
        local v4 = nil
        for i, j in Parts, v2, v4 do
            CollectionService:AddTag(j, p2)
        end
    end
    return v1
end

if not u34 then
    ReplicateObjective:SetClientListener(function(p1) -- Line: 722 -- upvalues: u56 (val), u39 (val)
        local v1
        if p1.Type == "Add" then
            u56.new(p1.PropertyTable, p1.Identifier)
            return
        end
        if p1.Type == "Destroy" then
            v1 = u39[p1.Identifier]
            if not v1 then
                return
            end
            local WasCompleted = p1.WasCompleted
            v1:Destroy(WasCompleted)
            return
        end
        if p1.Type == "PropertyChanged" then
            v1 = u39[p1.Identifier]
            if v1 then
                local Index = p1.Index
                local Value = p1.Value
                v1:_SetProperty(Index, Value)
            end
        end
    end)
    ReplicateObjective:FireServer()
else
    ReplicateObjective:SetServerListener(function(p1, p2) -- Line: 706 -- upvalues: u39 (val), ReplicateObjective (val)
        local v1
        local v2 = u39
        local v3 = nil
        local v4 = nil
        local v5 = p1
        for i, j in v2, v3, v4 do
            if not j._ServerProperties.TargetPlayers or table.find(j._ServerProperties.TargetPlayers, v5) then
                v1 = {Type = "Add", PropertyTable = j.Properties, Identifier = i}
                ReplicateObjective:FireClient(v5, v1)
            end
        end
    end)
end
return u56