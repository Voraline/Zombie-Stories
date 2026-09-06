local Players = game:GetService("Players")
local Signal = require(script.Parent.Parent.Signal)
local Janitor = require(script.Parent.Parent.Janitor)
local u23 = {}
u23.__index = u23
local u24 = {}
u23.trackers = u24
u23.itemAdded = Signal.new()
u23.itemRemoved = Signal.new()
u23.bodyPartsToIgnore = {
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    LeftHand = true,
    RightHand = true,
    LeftFoot = true,
    RightFoot = true,
}
function u23.getCombinedTotalVolumes() -- Line: 35 -- upvalues: u24 (val)
    local v1 = 0
    for k, v in pairs(u24) do
        v1 = v1 + k.totalVolume
    end
    return v1
end
function u23.getCharacterSize(p1) -- Line: 43
    local Head = p1
    if Head then
        Head = p1:FindFirstChild("Head")
    end
    local HumanoidRootPart = p1
    if HumanoidRootPart then
        HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
    end
    if not HumanoidRootPart or not Head then
        return nil
    end
    if not (Head:IsA("BasePart")) then
        Head = HumanoidRootPart
    end
    local Y = Head.Size.Y
    local Size = HumanoidRootPart.Size
    local v1 = Size * Vector3.new(2, 2, 1)
    local v2 = v1 + Vector3.new(0, Y, 0)
    return v2, HumanoidRootPart.CFrame * CFrame.new(0, Y / 2 - Size.Y / 2, 0)
end
function u23.new(p1) -- Line: 60 -- upvalues: u23 (val), Janitor (val), Players (val), u24 (val)
    local u1 = {}
    setmetatable(u1, u23)
    u1.name = p1
    u1.totalVolume = 0
    u1.parts = {}
    u1.partToItem = {}
    u1.items = {}
    u1.whitelistParams = nil
    u1.characters = {}
    u1.baseParts = {}
    u1.exitDetections = {}
    u1.janitor = Janitor.new()
    if p1 == "player" then
        local function updatePlayerCharacters() -- Line: 76 -- upvalues: Players (upval), u1 (val)
            local Character
            local v1 = {}
            for k, v in pairs(Players:GetPlayers()) do
                Character = v.Character
                if Character then
                    v1[Character] = true
                end
            end
            u1.characters = v1
        end
        local function playerAdded(p1) -- Line: 87 -- upvalues: updatePlayerCharacters (val), u1 (val)
            local function charAdded(p1) -- Line: 88 -- upvalues: updatePlayerCharacters (upval), u1 (upval)
                local Humanoid = p1:WaitForChild("Humanoid", 3)
                if Humanoid then
                    updatePlayerCharacters()
                    u1:update()
                    for k, v in pairs(Humanoid:GetChildren()) do
                        if v:IsA("NumberValue") then
                            v.Changed:Connect(function() -- Line: 95 -- upvalues: u1 (upval)
                                u1:update()
                            end)
                        end
                    end
                end
            end
            if p1.Character then
                charAdded(p1.Character)
            end
            p1.CharacterAdded:Connect(charAdded)
            p1.CharacterRemoving:Connect(function(p1) -- Line: 106 -- upvalues: u1 (upval)
                u1.exitDetections[p1] = nil
            end)
        end
        Players.PlayerAdded:Connect(playerAdded)
        for k, v in pairs(Players:GetPlayers()) do
            playerAdded(v)
        end
        Players.PlayerRemoving:Connect(function(p1) -- Line: 116 -- upvalues: updatePlayerCharacters (val), u1 (val)
            updatePlayerCharacters()
            u1:update()
        end)
    elseif p1 == "item" then
        local function updateItem(p1, p2) -- Line: 123 -- upvalues: u1 (val)
            if p1.isCharacter then
                u1.characters[p1.item] = p2
            elseif p1.isBasePart then
                u1.baseParts[p1.item] = p2
            end
            u1:update()
        end
        u23.itemAdded:Connect(function(p1) -- Line: 131 -- upvalues: u1 (val)
            if p1.isCharacter then
                u1.characters[p1.item] = true
            elseif p1.isBasePart then
                u1.baseParts[p1.item] = true
            end
            u1:update()
        end)
        u23.itemRemoved:Connect(function(p1) -- Line: 134 -- upvalues: u1 (val)
            u1.exitDetections[p1.item] = nil
            if p1.isCharacter then
                u1.characters[p1.item] = nil
            elseif p1.isBasePart then
                u1.baseParts[p1.item] = nil
            end
            u1:update()
        end)
    end
    u24[u1] = true
    task.defer(u1.update, u1)
    return u1
end
function u23:_preventMultiFrameUpdates(p2, ...) -- Line: 148
    local _preventMultiDetails = self._preventMultiDetails
    if not _preventMultiDetails then
        _preventMultiDetails = {}
    end
    self._preventMultiDetails = _preventMultiDetails
    local u10 = self._preventMultiDetails[p2]
    if not u10 then
        self._preventMultiDetails[p2] = {calling = false, callsThisFrame = 0, updatedThisFrame = false}
    end
    u10.callsThisFrame = u10.callsThisFrame + 1
    if u10.callsThisFrame ~= 1 then
        return true
    end
    local u18 = table.pack(...)
    task.defer(function() -- Line: 165 -- upvalues: u10 (ref), self (val), p2 (val), u18 (val)
        u10.callsThisFrame = 0
        if 1 < u10.callsThisFrame then
            self[p2](self, unpack(u18))
        end
    end)
    return false
end
function u23:update() -- Line: 177 -- upvalues: u23 (val), Janitor (val)
    local Size, updateTrackerOnParentChanged, v1, v2, v3
    if self:_preventMultiFrameUpdates("update") then
        return
    end
    self.totalVolume = 0
    self.parts = {}
    self.partToItem = {}
    self.items = {}
    local u102 = self
    for k, v in pairs(self.characters) do
        v3 = u23.getCharacterSize(k)
        if v3 then
            u102.totalVolume = u102.totalVolume + v3.X * v3.Y * v3.Z
            local totalVolume = u102.janitor:add(Janitor.new(), "destroy", "trackCharacterParts-" .. u102.name)
            function updateTrackerOnParentChanged(p1) -- Line: 198 -- upvalues: totalVolume (ref), u102 (val)
                local v1 = p1.AncestryChanged:Connect(function() -- Line: 199 -- upvalues: p1 (val), totalVolume (upval), u102 (upval)
                    if not (p1:IsDescendantOf(game)) and p1.Parent == nil and totalVolume ~= nil then
                        totalVolume:destroy()
                        totalVolume = nil
                        u102:update()
                    end
                end)
                totalVolume:add(v1, "Disconnect")
            end
            for k2, i in pairs(k:GetChildren()) do
                if i:IsA("BasePart") and not (u23.bodyPartsToIgnore[i.Name]) then
                    u102.partToItem[i] = k
                    table.insert(u102.parts, i)
                    v2 = i.AncestryChanged:Connect(function() -- Line: 199 -- upvalues: i (val), totalVolume (ref), u102 (val)
                        if not (i:IsDescendantOf(game)) and i.Parent == nil and totalVolume ~= nil then
                            totalVolume:destroy()
                            totalVolume = nil
                            u102:update()
                        end
                    end)
                    totalVolume:add(v2, "Disconnect")
                end
            end
            v1 = k.AncestryChanged:Connect(function() -- Line: 199 -- upvalues: k (val), totalVolume (ref), u102 (val)
                if not (k:IsDescendantOf(game)) and k.Parent == nil and totalVolume ~= nil then
                    totalVolume:destroy()
                    totalVolume = nil
                    u102:update()
                end
            end)
            totalVolume:add(v1, "Disconnect")
            table.insert(u102.items, k)
        end
    end
    for k3, j in pairs(u102.baseParts) do
        Size = k3.Size
        u102.totalVolume = u102.totalVolume + Size.X * Size.Y * Size.Z
        totalVolume = u102.partToItem
        totalVolume[k3] = k3
        table.insert(u102.parts, k3)
        table.insert(u102.items, k3)
    end
    u102.whitelistParams = OverlapParams.new()
    u102.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
    u102.whitelistParams.MaxParts = #u102.parts
    u102.whitelistParams.FilterDescendantsInstances = u102.parts
end
return u23