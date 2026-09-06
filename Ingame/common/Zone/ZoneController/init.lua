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
local u42 = {player = u11.new("player"), item = u11.new("item")}
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
        p1[p2] = {}
    end
    local Character = p3:IsA("Player")
    if Character then
        Character = p3.Character
    end
    v1[p3] = Character or true
end
local u52 = {
    player = function(p1) -- Line: 59 -- upvalues: u41 (val), u21 (val), u22 (ref)
        return u41._getZonesAndItems("player", u21, u22, true, p1)
    end,
    localPlayer = function(p1) -- Line: 62 -- upvalues: LocalPlayer (val), u41 (val), u42 (val)
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
                    v3[v] = {}
                end
                Character_2 = v2:IsA("Player")
                if Character_2 then
                    Character_2 = v2.Character
                end
                v1[v2] = Character_2 or true
            end
        end
        return v3
    end,
    item = function(p1) -- Line: 76 -- upvalues: u41 (val), u21 (val), u22 (ref)
        return u41._getZonesAndItems("item", u21, u22, true, p1)
    end,
}
function u41._registerZone(p1) -- Line: 84 -- upvalues: u24 (val), u2 (val), u41 (val)
    u24[p1] = true
    local v1 = p1.janitor:add(u2.new(), "destroy")
    p1._registeredJanitor = v1
    local v2 = p1.updated:Connect(function() -- Line: 88 -- upvalues: u41 (upval)
        u41._updateZoneDetails()
    end)
    v1:add(v2, "Disconnect")
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
    local v2 = 0
    for k, v in pairs(p1.activeTriggers) do
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
    local Centre
    local v1 = {enterDetection = "_currentEnterDetection", exitDetection = "_currentExitDetection"}
    local v2 = p1
    for k, v in pairs(v1) do
        Centre = v2[k]
        if Centre == enums.Detection.Automatic then
            if 729000 >= u11.getCombinedTotalVolumes() then
                Centre = enums.Detection.WholeBody
            else
                Centre = enums.Detection.Centre
            end
        end
        v2[v] = Centre
    end
end
function u41._formHeartbeat(p1) -- Line: 140 -- upvalues: u36 (val), Heartbeat (val), u21 (val), u41 (val), u52 (val), enums (val)
    local v1
    if u36[p1] then
        return
    end
    local u3 = 0
    v1 = Heartbeat:Connect(function() -- Line: 150 -- upvalues: u3 (ref), u21 (upval), p1 (val), u41 (upval), u52 (upval), enums (upval)
        local v1 = os.clock()
        if u3 <= v1 then
            local _currentEnterDetection, accuracy, accuracy_2, settingsGroupName, v2, v3, v4, v5, v6, v7
            local v8 = nil
            local v9 = nil
            for k, v in pairs(u21) do
                if k.activeTriggers[p1] then
                    accuracy_2 = k.accuracy
                    if v8 == nil then
                        v8 = accuracy_2
                    elseif accuracy_2 >= v8 then
                    end
                    u41.updateDetection(k)
                    _currentEnterDetection = k._currentEnterDetection
                    if v9 == nil then
                        v9 = _currentEnterDetection
                    elseif _currentEnterDetection >= v9 then
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
                            v12[k2.settingsGroupName] = {}
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
                    v5 = k7:_updateOccupants(p1, v3)
                    v14[1][k7] = v5.exited
                    v14[2][k7] = v5.entered
                end
            end
            local v15 = {"Exited", "Entered"}
            for k9, i6 in pairs(v14) do
                v4 = p1 .. v15[k9]
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
    u36[p1] = v1
end
function u41._deregisterConnection(p1, p2) -- Line: 249 -- upvalues: u29 (ref), u23 (val), u36 (val), u21 (val), u41 (val)
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
    local v2 = 0
    for k, v in pairs(p1.activeTriggers) do
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
function u41._updateZoneDetails() -- Line: 271 -- upvalues: u25 (ref), u26 (ref), u27 (ref), u28 (ref), u22 (ref), u24 (val), u21 (val)
    local v1
    u25 = {}
    u26 = {}
    u27 = {}
    u28 = {}
    u22 = 0
    for k, v in pairs(u24) do
        v1 = u21[k]
        if v1 then
            u22 = u22 + k.volume
        end
        for k2, i in pairs(k.zoneParts) do
            if v1 then
                table.insert(u25, i)
                u26[i] = k
            end
            table.insert(u27, i)
            u28[i] = k
        end
    end
end
function u41._getZonesAndItems(p1, p2, p3, p4, p5) -- Line: 293 -- upvalues: u42 (val), u41 (val), Players (val), u14 (val)
    local Character_2, Character_3, PartBoundsInBox, PlayerFromCharacter, v1, v2, v3, v4, v5
    local v6 = p3
    if not v6 then
        for k, v in pairs(p2) do
            v6 = v6 + k.volume
        end
    end
    local v7 = {}
    local v8 = u42[p1]
    if v8.totalVolume < v6 then
        local Character, v9, v10, v11
        v5, v11, v1 = p4, p5, p1
        for k6, n in pairs(v8.items) do
            v9 = u41.getTouchingZones(n, v5, v11, v8)
            for k7, m in pairs(v9) do
                if not v5 then
                    v10 = if v1 == "player" then Players:GetPlayerFromCharacter(n) else n
                    if v10 then
                        v3 = v10
                        v4 = v7[m]
                        if not v4 then
                            v7[m] = {}
                        end
                        Character = v3:IsA("Player")
                        if Character then
                            Character = v3.Character
                        end
                        v4[v3] = Character or true
                    end
                elseif not (m.activeTriggers[v1]) then
                end
            end
        end
        return v7
    end
    v5, v1 = p4, p1
    for k2, i in pairs(p2) do
        if not v5 then
            PartBoundsInBox = u14:GetPartBoundsInBox(k2.region.CFrame, k2.region.Size, v8.whitelistParams)
            v2 = {}
            for k3, j in pairs(PartBoundsInBox) do
                v3 = v8.partToItem[j]
                if not (v2[v3]) then
                    v2[v3] = true
                end
            end
            for k4, k5 in pairs(v2) do
                if v1 == "player" then
                    PlayerFromCharacter = Players:GetPlayerFromCharacter(k4)
                    if k2:findPlayer(PlayerFromCharacter) then
                        v4 = v7[k2]
                        if not v4 then
                            v7[k2] = {}
                        end
                        Character_2 = PlayerFromCharacter:IsA("Player")
                        if Character_2 then
                            Character_2 = PlayerFromCharacter.Character
                        end
                        v4[PlayerFromCharacter] = Character_2 or true
                    end
                elseif k2:findItem(k4) then
                    v3 = v7[k2]
                    if not v3 then
                        v7[k2] = {}
                    end
                    Character_3 = k4:IsA("Player")
                    if Character_3 then
                        Character_3 = k4.Character
                    end
                    v3[k4] = Character_3 or true
                end
            end
        elseif not (k2.activeTriggers[v1]) then
        end
    end
    return v7
end
function u41.getZones() -- Line: 354 -- upvalues: u24 (val)
    local v1 = {}
    for k, v in pairs(u24) do
        table.insert(v1, k)
    end
    return v1
end
function u41.getTouchingZones(p1, p2, p3, p4) -- Line: 374 -- upvalues: enums (val), u11 (val), u25 (ref), u27 (ref), u26 (ref), u28 (ref), u14 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = nil
    if p4 then
        v7 = p4.exitDetections[p1]
        p4.exitDetections[p1] = nil
    end
    local Size = nil
    local CFrame = nil
    local v8 = p1:IsA("BasePart")
    local v9 = not v8
    local v10 = {}
    if v8 then
        Size = p1.Size
        CFrame = p1.CFrame
        table.insert(v10, p1)
    elseif v7 or p3 ~= enums.Detection.WholeBody then
        local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            Size = HumanoidRootPart.Size
            CFrame = HumanoidRootPart.CFrame
            table.insert(v10, HumanoidRootPart)
        end
    else
        v2, v3 = u11.getCharacterSize(p1)
        Size = v2
        CFrame = v3
        v10 = p1:GetChildren()
    end
    if not Size or not CFrame then
        return {}
    end
    if not p2 then
        v2 = u27
    else
        v2 = u25
    end
    if not p2 then
        v3 = u28
    else
        v3 = u26
    end
    local v11 = OverlapParams.new()
    v11.FilterType = Enum.RaycastFilterType.Whitelist
    v11.MaxParts = #v2
    v11.FilterDescendantsInstances = v2
    local v12 = {}
    local v13 = {}
    local PartBoundsInBox = u14:GetPartBoundsInBox(CFrame, Size, v11)
    local v14 = {}
    v1, v6 = p1, p4
    for k, v in pairs(PartBoundsInBox) do
        v5 = v3[v]
        if not v5 then
            table.insert(v14, v)
        elseif v5.allZonePartsAreBlocks then
            v13[v5] = true
            v12[v] = v5
        end
    end
    local v15 = #v14
    local v16 = 0
    if 0 < v15 then
        local PartsInPart, v17, v18
        v4 = OverlapParams.new()
        v4.FilterType = Enum.RaycastFilterType.Whitelist
        v4.MaxParts = v15
        v4.FilterDescendantsInstances = v14
        for k2, i in pairs(v10) do
            v17 = false
            if i:IsA("BasePart") then
                if v9 and u11.bodyPartsToIgnore[i.Name] then
                    continue
                end
                PartsInPart = u14:GetPartsInPart(i, v4)
                for k3, j in pairs(PartsInPart) do
                    if not (v12[j]) then
                        v18 = v3[j]
                        if v18 then
                            v13[v18] = true
                            v12[j] = v18
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
    v4 = {}
    local _currentExitDetection = nil
    for k4, k5 in pairs(v13) do
        if _currentExitDetection == nil then
            _currentExitDetection = k4._currentExitDetection
        elseif k4._currentExitDetection >= _currentExitDetection then
        end
        table.insert(v4, k4)
    end
    if _currentExitDetection and v6 then
        v6.exitDetections[v1] = _currentExitDetection
    end
    return v4, v12
end
local u82 = {}
function u41.setGroup(p1, p2) -- Line: 491 -- upvalues: u82 (val)
    local v1 = u82[p1]
    if not v1 then
        u82[p1] = {}
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
if not (RunService:IsClient()) then
    v1 = "Server"
else
    v1 = "Client"
end
local u97 = string.format("ZonePlus%sContainer", v1)
function u41.getWorkspaceContainer() -- Line: 521 -- upvalues: u85 (ref), u97 (val)
    local v1 = u85
    if not v1 then
        v1 = workspace:FindFirstChild(u97)
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