local v1
local u2 = require("./Janitor")
local v2 = require("./Enum")
require("./Signal")
local u11 = require("@self/Tracker")
local u14 = require("@self/CollectiveWorldModel")
local enums = v2.enums
local Players = game:GetService("Players")
local u21 = {}
local u22 = 0
local u23 = {}
local u24 = {}
local u25 = {}
local u26 = {}
local u27 = {}
local u28 = {}
local u29 = 0
local RunService = game:GetService("RunService")
local Heartbeat = RunService.Heartbeat
local u36 = {}
local LocalPlayer = RunService:IsClient()
if LocalPlayer then
    LocalPlayer = Players.LocalPlayer
end
local u41 = {}
local u42 = {}
u42.player = u11.new("player")
u42.item = u11.new("item")
u41.trackers = u42

local function dictLength(p1) -- Line: 40
    local v1 = 0
    for k, v in pairs(p1) do
        v1 = v1 + 1
    end
    return v1
end

local function fillOccupants(p1, p2, p3) -- Line: 48
    local v1 = p1[p2]
    if not v1 then
        v1 = {}
        p1[p2] = v1
    end
    local Character = p3:IsA("Player")
    if Character then
        Character = p3.Character
    end
    v1[p3] = Character or true
end

local u52 = {}

function u52.player(p1) -- Line: 59 -- upvalues: u41 (val), u21 (val), u22 (ref)
    return u41._getZonesAndItems("player", u21, u22, true, p1)
end

function u52.localPlayer(p1) -- Line: 62 -- upvalues: LocalPlayer (val), u41 (val), u42 (val)
    local Character_2, v1, v2
    local v3 = {}
    local Character = LocalPlayer.Character
    if not Character then
        return v3
    end
    local v4 = u41.getTouchingZones(Character, true, p1, u42.player)
    for k, v in pairs(v4) do
        if v.activeTriggers.localPlayer then
            v2 = LocalPlayer
            v1 = v3[v]
            if not v1 then
                v1 = {}
                v3[v] = v1
            end
            Character_2 = v2:IsA("Player")
            if Character_2 then
                Character_2 = v2.Character
            end
            v1[v2] = Character_2 or true
        end
    end
    return v3
end

function u52.item(p1) -- Line: 76 -- upvalues: u41 (val), u21 (val), u22 (ref)
    return u41._getZonesAndItems("item", u21, u22, true, p1)
end

function u41._registerZone(p1) -- Line: 84 -- upvalues: u24 (val), u2 (val), u41 (val)
    u24[p1] = true
    local janitor = p1.janitor
    local v1 = u2
    v1 = v1.new()
    local v2 = janitor:add(v1, "destroy")
    p1._registeredJanitor = v2
    local v3 = p1.updated:Connect(function() -- Line: 88 -- upvalues: u41 (upval)
        u41._updateZoneDetails()
    end)
    v2:add(v3, "Disconnect")
    u41._updateZoneDetails()
end

function u41._deregisterZone(p1) -- Line: 94 -- upvalues: u24 (val), u41 (val)
    u24[p1] = nil
    p1._registeredJanitor:destroy()
    p1._registeredJanitor = nil
    u41._updateZoneDetails()
end

function u41._registerConnection(p1, p2) -- Line: 101 -- upvalues: u29 (ref), u21 (val), u41 (val), u23 (val), u52 (val)
    local v1
    local activeTriggers = p1.activeTriggers
    local v2 = 0
    for k, v in pairs(activeTriggers) do
        v2 = v2 + 1
    end
    u29 = u29 + 1
    if v2 == 0 then
        u21[p1] = true
        u41._updateZoneDetails()
    end
    local v3 = u23[p2]
    v2 = u23
    if not v3 then
        v1 = 1
    else
        v1 = v3 + 1
        if not v1 then
            v1 = 1
        end
    end
    v2[p2] = v1
    p1.activeTriggers[p2] = true
    if p1.touchedConnectionActions[p2] then
        p1:_formTouchedConnection(p2)
    end
    if u52[p2] then
        u41._formHeartbeat(p2)
    end
end

function u41.updateDetection(p1) -- Line: 121 -- upvalues: u11 (val), enums (val)
    local Centre, v1
    local v2 = {enterDetection = "_currentEnterDetection", exitDetection = "_currentExitDetection"}
    local v3 = p1
    for k, v in pairs(v2) do
        Centre = v3[k]
        v1 = u11
        v1 = v1.getCombinedTotalVolumes()
        if Centre == enums.Detection.Automatic then
            if not (729000 < v1) then
                Centre = enums.Detection.WholeBody
            else
                Centre = enums.Detection.Centre
            end
        end
        v3[v] = Centre
    end
end

function u41._formHeartbeat(p1) -- Line: 140
    -- upvalues: u36 (val), Heartbeat (val), u21 (val), u41 (val), u52 (val), enums (val)
    if u36[p1] then
        return
    end
    local u3 = 0
    local v1 = Heartbeat
    local v2 = v1:Connect(function() -- Line: 150 -- upvalues: u3 (ref), u21 (upval), p1 (val), u41 (upval), u52 (upval), enums (upval)
        local v1 = os.clock()
        if u3 <= v1 then
            local _currentEnterDetection, accuracy, accuracy_2, settingsGroupName, v2, v3, v4, v5, v6, v7
            local v8 = nil
            local v9 = nil
            for k, v in pairs(u21) do
                if k.activeTriggers[p1] then
                    accuracy_2 = k.accuracy
                    if v8 == nil or accuracy_2 < v8 then
                        v8 = accuracy_2
                    end
                    u41.updateDetection(k)
                    _currentEnterDetection = k._currentEnterDetection
                    if v9 == nil or _currentEnterDetection < v9 then
                        v9 = _currentEnterDetection
                    end
                end
            end
            local v10 = v8
            local v11 = u52[p1](v9)
            local v12 = {}
            local v13 = {}
            for k2, i in pairs(v11) do
                settingsGroupName = k2.settingsGroupName
                if settingsGroupName then
                    settingsGroupName = u41.getGroup(k2.settingsGroupName)
                end
                if settingsGroupName and settingsGroupName.onlyEnterOnceExitedAll == true then
                    for k3, j in pairs(i) do
                        v6 = v12[k2.settingsGroupName]
                        if not v6 then
                            v6 = {}
                            v12[k2.settingsGroupName] = v6
                        end
                        v6[k3] = k2
                    end
                    v13[k2] = i
                end
            end
            for k4, k5 in pairs(v13) do
                v2 = v12[k4.settingsGroupName]
                if v2 then
                    for k6, n in pairs(k5) do
                        v6 = v2[k6]
                        if v6 and v6 ~= k4 then
                            k5[k6] = nil
                        end
                    end
                end
            end
            local v14 = {{}, {}}
            for k7, m in pairs(u21) do
                if k7.activeTriggers[p1] then
                    accuracy = k7.accuracy
                    v3 = v11[k7]
                    if not v3 then
                        v3 = {}
                    end
                    v4 = false
                    for k8, i5 in pairs(v3) do
                        v4 = true
                        break
                    end
                    if v4 and v10 < accuracy then
                        v10 = accuracy
                    end
                    v6 = p1
                    v5 = k7:_updateOccupants(v6, v3)
                    v14[1][k7] = v5.exited
                    v14[2][k7] = v5.entered
                end
            end
            local v15 = {"Exited", "Entered"}
            for k9, i6 in pairs(v14) do
                v3 = v15[k9]
                v4 = p1 .. v3
                for k10, i7 in pairs(i6) do
                    v7 = k10[v4]
                    if v7 then
                        for k11, i8 in pairs(i7) do
                            v7:Fire(i8)
                        end
                    end
                end
            end
            u3 = v1 + enums.Accuracy.getProperty(v10)
        end
    end)
    u36[p1] = v2
end

function u41._deregisterConnection(p1, p2) -- Line: 249
    -- upvalues: u29 (ref), u23 (val), u36 (val), u21 (val), u41 (val)
    local v1
    u29 = u29 - 1
    if u23[p2] ~= 1 then
        v1 = u23
        v1[p2] = v1[p2] - 1
    else
        u23[p2] = nil
        v1 = u36[p2]
        if v1 then
            u36[p2] = nil
            v1:Disconnect()
        end
    end
    p1.activeTriggers[p2] = nil
    local activeTriggers = p1.activeTriggers
    local v2 = 0
    for k, v in pairs(activeTriggers) do
        v2 = v2 + 1
    end
    if v2 == 0 then
        u21[p1] = nil
        u41._updateZoneDetails()
    end
    if p1.touchedConnectionActions[p2] then
        p1:_disconnectTouchedConnection(p2)
    end
end

function u41._updateZoneDetails() -- Line: 271
    -- upvalues: u25 (ref), u26 (ref), u27 (ref), u28 (ref), u22 (ref), u24 (val), u21 (val)
    local v1, v2
    u25 = {}
    u26 = {}
    u27 = {}
    u28 = {}
    u22 = 0
    for k, v in pairs(u24) do
        v2 = u21[k]
        if v2 then
            u22 = u22 + k.volume
        end
        for k2, i in pairs(k.zoneParts) do
            if v2 then
                v1 = u25
                table.insert(v1, i)
                u26[i] = k
            end
            v1 = u27
            table.insert(v1, i)
            u28[i] = k
        end
    end
end

function u41._getZonesAndItems(p1, p2, p3, p4, p5) -- Line: 293
    -- upvalues: u42 (val), u41 (val), Players (val), u14 (val)
    local CFrame, Character_2, Character_3, PartBoundsInBox, PlayerFromCharacter, Size, v1, v2, v3, v4, v5, v6, whitelistParams
    local v7 = p3
    if not v7 then
        for k, v in pairs(p2) do
            v7 = v7 + k.volume
        end
    end
    local v8 = {}
    local v9 = u42[p1]
    if v9.totalVolume < v7 then
        local Character, v10, v11
        v6, v11, v1 = p4, p5, p1
        for k8, i5 in pairs(v9.items) do
            v2 = u41.getTouchingZones(i5, v6, v11, v9)
            for k9, i6 in pairs(v2) do
                if not v6 or i6.activeTriggers[v1] then
                    v10 = i5
                    if v1 == "player" then
                        v10 = Players:GetPlayerFromCharacter(i5)
                    end
                    if v10 then
                        v4 = v10
                        v5 = v8[i6]
                        if not v5 then
                            v5 = {}
                            v8[i6] = v5
                        end
                        Character = v4:IsA("Player")
                        if Character then
                            Character = v4.Character
                        end
                        v5[v4] = Character or true
                    end
                end
            end
        end
        return v8
    end
    v6, v1 = p4, p1
    for k2, i in pairs(p2) do
        if not v6 then
            v2 = u14
            CFrame = k2.region.CFrame
            Size = k2.region.Size
            whitelistParams = v9.whitelistParams
            PartBoundsInBox = v2:GetPartBoundsInBox(CFrame, Size, whitelistParams)
            v3 = {}
            for k3, j in pairs(PartBoundsInBox) do
                v4 = v9.partToItem[j]
                if not v3[v4] then
                    v3[v4] = true
                end
            end
            for k4, k5 in pairs(v3) do
                if v1 == "player" then
                    PlayerFromCharacter = Players:GetPlayerFromCharacter(k4)
                    if k2:findPlayer(PlayerFromCharacter) then
                        v5 = v8[k2]
                        if not v5 then
                            v5 = {}
                            v8[k2] = v5
                        end
                        Character_2 = PlayerFromCharacter:IsA("Player")
                        if Character_2 then
                            Character_2 = PlayerFromCharacter.Character
                        end
                        v5[PlayerFromCharacter] = Character_2 or true
                    end
                elseif k2:findItem(k4) then
                    v4 = v8[k2]
                    if not v4 then
                        v4 = {}
                        v8[k2] = v4
                    end
                    Character_3 = k4:IsA("Player")
                    if Character_3 then
                        Character_3 = k4.Character
                    end
                    v4[k4] = Character_3 or true
                end
            end
        elseif k2.activeTriggers[v1] then
            v2 = u14
            CFrame = k2.region.CFrame
            Size = k2.region.Size
            whitelistParams = v9.whitelistParams
            PartBoundsInBox = v2:GetPartBoundsInBox(CFrame, Size, whitelistParams)
            v3 = {}
            for k6, n in pairs(PartBoundsInBox) do
                v4 = v9.partToItem[n]
                if not v3[v4] then
                    v3[v4] = true
                end
            end
            for k7, m in pairs(v3) do
                if v1 == "player" then
                    PlayerFromCharacter = Players:GetPlayerFromCharacter(k7)
                    if k2:findPlayer(PlayerFromCharacter) then
                        v5 = v8[k2]
                        if not v5 then
                            v5 = {}
                            v8[k2] = v5
                        end
                        Character_2 = PlayerFromCharacter:IsA("Player")
                        if Character_2 then
                            Character_2 = PlayerFromCharacter.Character
                        end
                        v5[PlayerFromCharacter] = Character_2 or true
                    end
                elseif k2:findItem(k7) then
                    v4 = v8[k2]
                    if not v4 then
                        v4 = {}
                        v8[k2] = v4
                    end
                    Character_3 = k7:IsA("Player")
                    if Character_3 then
                        Character_3 = k7.Character
                    end
                    v4[k7] = Character_3 or true
                end
            end
        end
    end
    return v8
end

function u41.getZones() -- Line: 354 -- upvalues: u24 (val)
    local v1 = {}
    for k, v in pairs(u24) do
        table.insert(v1, k)
    end
    return v1
end

function u41.getTouchingZones(p1, p2, p3, p4) -- Line: 374
    -- upvalues: enums (val), u11 (val), u25 (ref), u27 (ref), u26 (ref), u28 (ref), u14 (val)
    local v1, v2
    local v3 = nil
    if p4 then
        v3 = p4.exitDetections[p1]
        p4.exitDetections[p1] = nil
    end
    local Size = nil
    local CFrame = nil
    local v4 = p1:IsA("BasePart")
    local v5 = not v4
    local v6 = {}
    if v4 then
        Size = p1.Size
        CFrame = p1.CFrame
        table.insert(v6, p1)
    elseif (v3 or p3) ~= enums.Detection.WholeBody then
        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            Size = HumanoidRootPart.Size
            CFrame = HumanoidRootPart.CFrame
            table.insert(v6, HumanoidRootPart)
        end
    else
        v1, v2 = u11.getCharacterSize(p1)
        Size = v1
        CFrame = v2
        v6 = p1:GetChildren()
    end
    if Size and CFrame then
        local v7, v8
        if not p2 then
            v1 = u27
        else
            v1 = u25
            if not v1 then
                v1 = u27
            end
        end
        if not p2 then
            v2 = u28
        else
            v2 = u26
            if not v2 then
                v2 = u28
            end
        end
        local v9 = OverlapParams.new()
        v9.FilterType = Enum.RaycastFilterType.Whitelist
        v9.MaxParts = #v1
        v9.FilterDescendantsInstances = v1
        local v10 = {}
        local v11 = {}
        local PartBoundsInBox = u14:GetPartBoundsInBox(CFrame, Size, v9)
        local v12 = {}
        local v13, v14 = p1, p4
        for k, v in pairs(PartBoundsInBox) do
            v8 = v2[v]
            if not v8 or not v8.allZonePartsAreBlocks then
                table.insert(v12, v)
            else
                v11[v8] = true
                v10[v] = v8
            end
        end
        local v15 = #v12
        local v16 = 0
        if 0 < v15 then
            local PartsInPart, v17, v18
            v7 = OverlapParams.new()
            v7.FilterType = Enum.RaycastFilterType.Whitelist
            v7.MaxParts = v15
            v7.FilterDescendantsInstances = v12
            for k2, i in pairs(v6) do
                v17 = false
                if i:IsA("BasePart") then
                    if v5 and u11.bodyPartsToIgnore[i.Name] then
                        continue
                    end
                    PartsInPart = u14:GetPartsInPart(i, v7)
                    for k3, j in pairs(PartsInPart) do
                        if not v10[j] then
                            v18 = v2[j]
                            if v18 then
                                v11[v18] = true
                                v10[j] = v18
                                v16 = v16 + 1
                            end
                            if v16 == v15 then
                                v17 = true
                                break
                            end
                        end
                    end
                    if v17 then
                        break
                    end
                end
            end
        end
        v7 = {}
        local _currentExitDetection = nil
        for k4, k5 in pairs(v11) do
            if _currentExitDetection == nil or k4._currentExitDetection < _currentExitDetection then
                _currentExitDetection = k4._currentExitDetection
            end
            table.insert(v7, k4)
        end
        if _currentExitDetection and v14 then
            v14.exitDetections[v13] = _currentExitDetection
        end
        return v7, v10
    end
    return {}
end

local u82 = {}

function u41.setGroup(p1, p2) -- Line: 491 -- upvalues: u82 (val)
    local v1 = u82[p1]
    if not v1 then
        v1 = {}
        u82[p1] = v1
    end
    v1.onlyEnterOnceExitedAll = true
    v1._name = p1
    v1._memberZones = {}
    if typeof(p2) == "table" then
        for k, v in pairs(p2) do
            v1[k] = v
        end
    end
    return v1
end

function u41.getGroup(p1) -- Line: 515 -- upvalues: u82 (val)
    return u82[p1]
end

local u85 = nil
local format = string.format
if not RunService:IsClient() then
    v1 = "Server"
else
    v1 = "Client"
end
local u97 = format("ZonePlus%sContainer", v1)

function u41.getWorkspaceContainer() -- Line: 521 -- upvalues: u85 (ref), u97 (val)
    local v1 = u85
    if not v1 then
        v1 = workspace
        local v2 = u97
        v1 = v1:FindFirstChild(v2)
    end
    if not v1 then
        v1 = Instance.new("Folder")
        v1.Name = u97
        v1.Parent = workspace
        u85 = v1
    end
    return v1
end

return u41