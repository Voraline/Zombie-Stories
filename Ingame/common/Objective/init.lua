local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local u22 = require("@self/Pathfinder")
local Signal = require(game.ReplicatedStorage.common.Signal)
local u55 = nil
local u34 = game:GetService("RunService"):IsServer()
local ReplicateObjective = require(game.ReplicatedStorage.common.RedEvents.General.ReplicateObjective)
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
    u55 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.HUDController.HUDElements.Objectives)
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
function u56.new(p1, p2) -- Line: 167 -- upvalues: HttpService (val), u34 (val), u39 (val), ReplicateObjective (val), u56 (val), u55 (ref)
    local v1, v2
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
    local v4 = {
        Type = p1.Type,
        Text = p1.Text,
        IsPrimary = p1.IsPrimary,
        MarkerMap = p1.MarkerMap,
        MarkerPositions = p1.MarkerPositions,
        MarkerParts = p1.MarkerParts,
        Location = p1.Location,
        Progress = p1.Progress,
        ProgressTotal = p1.ProgressTotal or 1,
        ImageID = p1.ImageID,
        AccentColor = p1.AccentColor,
        ProgressFormat = p1.ProgressFormat,
        NewSoundId = p1.NewSoundId,
        CompleteSoundId = p1.CompleteSoundId,
    }
    if not p1.ProgressTotal then
        if v4.Type == "kill" then
            if not v4.ProgressFormat then
                v4.ProgressFormat = ""
            end
        elseif v4.Type ~= "collect" and v4.Type ~= "find" and v4.Type ~= "interact" then
        end
    end
    if v4.MarkerPositions then
        v3 = true
        if typeof(v4.MarkerPositions) ~= "table" then
            if typeof(v4.MarkerPositions) ~= "Vector3" then
                v3 = false
            end
        elseif not (v4.MarkerPositions[1]) then
            v3 = false
        elseif typeof(v4.MarkerPositions[1]) == "Vector3" then
        end
        if not v3 then
            error("MarkerPositions must be of type Vector3 or array of Vector3")
        end
    elseif not u34 and v4.MarkerParts then
        v2 = v4.MarkerParts.Count ~= nil
        assert(v2, "MarkerParts table needs a count")
        v4.MarkerParts.Parts = getUnreplicatedParts(v1, v4.MarkerParts.Count)
    end
    if v4.Type == "kill" then
        if not v4.Progress then
            v4.Progress = 0
        end
    elseif v4.Type ~= "find" and v4.Type ~= "collect" and v4.Type ~= "interact" and v4.Type ~= "money" and p1.Type ~= "move" then
        error("Type must be either kill, find, collect, interact, or move")
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
        return (setmetatable(v3, u56))
    end
    v3 = {_Destroyed = false, _Identifier = v1, Properties = v4}
    v2 = v1 == nil
    v3._IsLocal = v2
    setmetatable(v3, u56)
    u39[v3._Identifier] = v3
    u55:AddObjective(v4, v1)
    if not v4.Location then
        if not v4.MarkerMap then
            if v4.MarkerParts then
                v3:AddMarkers(v4.MarkerParts.Parts)
            end
            if v4.MarkerPositions then
                v3:AddMarkers(v4.MarkerPositions)
            end
        else
            v3:_UpdateMarkerMap()
        end
    elseif not v4.MarkerMap then
        v3:AddMarker(v4.Location)
    end
    if v4.Type == "move" then
        v3:_RunMoveProgressUpdates()
    end
    return v3
end
function u56:AddMarker(p2) -- Line: 302 -- upvalues: u55 (ref)
    local v1 = u55:AddMarker(self.Properties, p2, nil, self._Identifier)
    if typeof(p2) == "Vector3" then
        if not self._MarkerPositionIdentifiers then
            self._MarkerPositionIdentifiers = {}
        end
        table.insert(self._MarkerPositionIdentifiers, v1)
        return v1
    end
    if typeof(p2) == "Instance" then
        if not self._MarkerPartIdentifiers then
            self._MarkerPartIdentifiers = {}
        end
        table.insert(self._MarkerPartIdentifiers, v1)
    end
    return v1
end
function u56:AddMarkers(p2) -- Line: 324
    local v1 = true
    if typeof(p2) == "Vector3" then
        self:AddMarker(p2)
    elseif typeof(p2) ~= "table" then
        v1 = false
    elseif not (p2[1]) then
        v1 = false
    else
        local v2, v3, v4
        if typeof(p2[1]) == "Vector3" then
            v2 = p2
            v3 = nil
            v4 = nil
            for k, n in v2, v3, v4 do
                self:AddMarker(n)
            end
        elseif typeof(p2[1]) ~= "Instance" then
            v1 = false
        else
            v2 = p2
            v3 = nil
            v4 = nil
            for i, j in v2, v3, v4 do
                self:AddMarker(j)
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
        if not (table.find(TargetPlayers.value, p2)) then
            table.insert(v1, p2)
        end
    end
    p1.TargetPlayers = v1
end
function u56:Destroy(p2) -- Line: 368 -- upvalues: u56 (val), u34 (val), ReplicateObjective (val), u39 (val), u55 (ref)
    if p2 then
        u56.Completed:Fire(self)
    end
    if u34 then
        local v1 = {Type = "Destroy", Identifier = self._Identifier, WasCompleted = p2 or false}
        if not self._ServerProperties.TargetPlayers then
            ReplicateObjective:FireAllClients(v1)
        else
            ReplicateObjective:FireClients(self._ServerProperties.TargetPlayers, v1)
        end
        u39[self._Identifier] = nil
        return
    end
    if not self._Destroyed then
        u55:RemoveObjective(self._Identifier, p2)
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
    u22:Init(self.Properties.MarkerMap)
    self:_RunMarkerPathfinding()
end
function u56:_RunMarkerPathfinding() -- Line: 426 -- upvalues: u55 (ref), u22 (val)
    assert(self.Properties.MarkerMap, "This objective has node map for markers")
    local u7 = tick()
    self._PathfindingCode = u7
    task.defer(function() -- Line: 431 -- upvalues: u7 (val), self (val), u55 (upval), u22 (upval)
        local Character, HumanoidRootPart, Location, Position, Position_2, v1
        local LocalPlayer = game.Players.LocalPlayer
        local v2 = nil
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
            self:_IterateMarkers(function(p1) -- Line: 456 -- upvalues: u55 (upval)
                u55:RemoveMarker(p1)
            end)
            if Position and Position_2 then
                v1 = u22:FindPath(Position, Position_2)
                if not v1 then
                    v1 = {}
                end
                if 1 <= #v1 then
                    if (Position - v1[1]).Magnitude < 10 then
                        v2 = table.remove(v1, 1)
                    elseif v2 == v1[1] then
                        table.remove(v1, 1)
                    end
                end
                if #v1 ~= 0 then
                    self:AddMarker(v1[1])
                else
                    self:AddMarker(self.Properties.Location)
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
        local Character, HumanoidRootPart, Location, Position, Position_2
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
                u55:UpdateProgress(self._Identifier, (math.floor((Position - Position_2).Magnitude * 0.28)))
            end
        end
    end)
end
function u56:_StopMoveProgressUpdates() -- Line: 522
    self._IsMoveProgressRunning = nil
end
function u56:_SetProperty(p2, p3) -- Line: 526 -- upvalues: u40 (val), u34 (val), ReplicateObjective (val), u55 (ref)
    local TargetPlayers, u70, v1
    if not (u40[p2]) then
        return
    end
    if p2 ~= "TargetPlayers" then
        self.Properties[p2] = p3
    end
    if u34 then
        local v2, v3
        if p2 ~= "MarkerParts" then
            u70 = p3
        else
            u70 = formatMarkerParts(p3, self._Identifier)
        end
        if p2 ~= "TargetPlayers" then
            v3 = {Type = "PropertyChanged", Identifier = self._Identifier, Index = p2, Value = u70}
            if not self._ServerProperties.TargetPlayers then
                ReplicateObjective:FireAllClients(v3)
            else
                ReplicateObjective:FireClients(self._ServerProperties.TargetPlayers, v3)
            end
            return
        end
        v3 = nil
        TargetPlayers = self._ServerProperties.TargetPlayers
        if not TargetPlayers then
            v2 = self
        else
            local value
            v1 = u70
            local v4 = nil
            local v5 = nil
            v2 = self
            for m, i5 in v1, v4, v5 do
                if not (table.find(TargetPlayers.value, i5)) then
                    if not v3 then
                        v3 = {}
                    end
                    table.insert(v3, i5)
                end
            end
            value = TargetPlayers.value
            v4 = nil
            v5 = nil
            for i6, i7 in value, v4, v5 do
                if not (table.find(u70, i7)) then
                    ReplicateObjective:FireClient(i7, {Type = "Destroy", WasCompleted = false, Identifier = v2._Identifier})
                end
            end
        end
        v2._ServerProperties.TargetPlayers = u70
        if v3 then
            ReplicateObjective:FireClients(v3, {Type = "Add", PropertyTable = v2.Properties, Identifier = v2._Identifier})
        end
        return
    end
    if p2 == "Text" then
        self:_IterateMarkers(function(p1) -- Line: 593 -- upvalues: u55 (upval), p3 (ref)
            u55:SetMarkerText(p1, p3)
        end)
    else
        local v6
        if p2 ~= "MarkerPositions" then
            if p2 ~= "MarkerParts" then
                if p2 == "Progress" then
                    u55:UpdateProgress(self._Identifier, p3)
                elseif p2 == "ProgressTotal" then
                    u55:UpdateProgress(self._Identifier, nil, p3)
                elseif p2 == "IsPrimary" then
                    u55:SetIsPrimary(self._Identifier, p3)
                elseif p2 == "MarkerMap" then
                    self:_UpdateMarkerMap()
                elseif p2 == "Location" and not self.Properties.MarkerMap and p3 ~= nil then
                    self:AddMarker(p3)
                end
            elseif not self.MarkerMap then
                local _MarkerPartIdentifiers
                u70 = formatMarkerParts(p3, self._Identifier)
                self.Properties[p2] = u70
                u70.Parts = getUnreplicatedParts(self._Identifier, u70.Count)
                if self._MarkerPartIdentifiers then
                    _MarkerPartIdentifiers = self._MarkerPartIdentifiers
                    v6 = nil
                    v1 = nil
                    for i, j in _MarkerPartIdentifiers, v6, v1 do
                        u55:RemoveMarker(j)
                    end
                end
                self:AddMarkers(u70.Parts)
            end
        elseif not self.MarkerMap then
            local _MarkerPositionIdentifiers
            if self._MarkerPositionIdentifiers then
                _MarkerPositionIdentifiers = self._MarkerPositionIdentifiers
                v6 = nil
                v1 = nil
                for k, n in _MarkerPositionIdentifiers, v6, v1 do
                    u55:RemoveMarker(n)
                end
            end
            self:AddMarkers(p3)
        end
    end
end
function u56:_IterateMarkers(p2) -- Line: 637
    local _MarkerPartIdentifiers, _MarkerPositionIdentifiers, v1, v2
    if self._MarkerPositionIdentifiers then
        _MarkerPositionIdentifiers = self._MarkerPositionIdentifiers
        v1 = nil
        v2 = nil
        for i, j in _MarkerPositionIdentifiers, v1, v2 do
            p2(j)
        end
    end
    if self._MarkerPartIdentifiers then
        _MarkerPartIdentifiers = self._MarkerPartIdentifiers
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
    local v1, v2, v3
    v1, v2 = p1, p2
    while true do
        v3 = CollectionService:GetTagged(v1)
        if #v3 < v2 then
            CollectionService:GetInstanceAddedSignal(v1):Wait()
        end
        if v2 <= #v3 then
            break
        end
    end
    return v3
end
function formatMarkerParts(p1, p2) -- Line: 669 -- upvalues: CollectionService (val)
    local Parts, v1, v2
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
        end
    elseif not p1.Parts then
        v2 = if typeof(p1[1]) == "Instance" then p1[1]:IsA("BasePart") else false
        assert(v2, "MarkerParts table must be an array of BaseParts")
        v1 = {Parts = p1, Count = #p1}
    end
    if typeof(v1) == "Instance" then
        CollectionService:AddTag(v1, p2)
        return v1
    end
    if typeof(v1) == "table" then
        Parts = v1.Parts
        v2 = nil
        local v3 = nil
        for i, j in Parts, v2, v3 do
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
            v1:Destroy(p1.WasCompleted)
            return
        end
        if p1.Type == "PropertyChanged" then
            v1 = u39[p1.Identifier]
            if v1 then
                v1:_SetProperty(p1.Index, p1.Value)
            end
        end
    end)
    ReplicateObjective:FireServer()
else
    ReplicateObjective:SetServerListener(function(p1, p2) -- Line: 706 -- upvalues: u39 (val), ReplicateObjective (val)
        local v1 = u39
        local v2 = nil
        local v3 = nil
        local v4 = p1
        for i, j in v1, v2, v3 do
            if not j._ServerProperties.TargetPlayers then
                ReplicateObjective:FireClient(v4, {Type = "Add", PropertyTable = j.Properties, Identifier = i})
            elseif not (table.find(j._ServerProperties.TargetPlayers, v4)) then
            end
        end
    end)
end
return u56