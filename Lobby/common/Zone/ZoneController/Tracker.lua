local Players = game:GetService("Players")
local Heartbeat = game:GetService("RunService").Heartbeat
local v1 = require("../Signal")
local u16 = require("../Janitor")
local u17 = {}
u17.__index = u17
local u18 = {}
u17.trackers = u18
u17.itemAdded = v1.new()
u17.itemRemoved = v1.new()
u17.bodyPartsToIgnore = {
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    LeftHand = true,
    RightHand = true,
    LeftFoot = true,
    RightFoot = true,
}

function u17.getCombinedTotalVolumes() -- Line: 35 -- upvalues: u18 (val)
    local v1 = 0
    for k, v in pairs(u18) do
        v1 = v1 + k.totalVolume
    end
    return v1
end

function u17.getCharacterSize(p1) -- Line: 43
    local Head = p1
    if Head then
        Head = p1:FindFirstChild("Head")
    end
    local HumanoidRootPart = p1
    if HumanoidRootPart then
        HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")
    end
    if HumanoidRootPart and Head then
        if not Head:IsA("BasePart") then
            Head = HumanoidRootPart
        end
        local Y = Head.Size.Y
        local Size = HumanoidRootPart.Size
        return Size * Vector3.new(2, 2, 1) + Vector3.new(0, Y, 0), HumanoidRootPart.CFrame * CFrame.new(0, Y / 2 - Size.Y / 2, 0)
    end
    return nil
end

function u17.new(p1) -- Line: 60 -- upvalues: u17 (val), u16 (val), Players (val), u18 (val)
    local u1 = {}
    local v1 = u17
    setmetatable(u1, v1)
    u1.name = p1
    u1.totalVolume = 0
    u1.parts = {}
    u1.partToItem = {}
    u1.items = {}
    u1.whitelistParams = nil
    u1.characters = {}
    u1.baseParts = {}
    u1.exitDetections = {}
    u1.janitor = u16.new()
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
        v1 = Players
        v1.PlayerRemoving:Connect(function(p1) -- Line: 116 -- upvalues: updatePlayerCharacters (val), u1 (val)
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

        local v2 = u17
        v2.itemAdded:Connect(function(p1) -- Line: 131 -- upvalues: u1 (val)
            if p1.isCharacter then
                u1.characters[p1.item] = true
            elseif p1.isBasePart then
                u1.baseParts[p1.item] = true
            end
            u1:update()
        end)
        v2 = u17
        v2.itemRemoved:Connect(function(p1) -- Line: 134 -- upvalues: u1 (val)
            u1.exitDetections[p1.item] = nil
            if p1.isCharacter then
                u1.characters[p1.item] = nil
            elseif p1.isBasePart then
                u1.baseParts[p1.item] = nil
            end
            u1:update()
        end)
    end
    u18[u1] = true
    task.defer(u1.update, u1)
    return u1
end

function u17:_preventMultiFrameUpdates(p2, ...) -- Line: 148
    local _preventMultiDetails = self._preventMultiDetails
    if not _preventMultiDetails then
        _preventMultiDetails = {}
    end
    self._preventMultiDetails = _preventMultiDetails
    local u10 = self._preventMultiDetails[p2]
    if not u10 then
        u10 = {calling = false, callsThisFrame = 0, updatedThisFrame = false}
        self._preventMultiDetails[p2] = u10
    end
    u10.callsThisFrame = u10.callsThisFrame + 1
    if u10.callsThisFrame ~= 1 then
        return true
    end
    local u18 = table.pack(...)
    task.defer(function() -- Line: 165 -- upvalues: u10 (ref), self (val), p2 (val), u18 (val)
        local v1 = u10
        local callsThisFrame = v1.callsThisFrame
        u10.callsThisFrame = 0
        if 1 < callsThisFrame then
            local v2 = self[p2]
            local v3 = self
            local v4 = u18
            v2(v3, unpack(v4))
        end
    end)
    return false
end

function u17:update() -- Line: 177 -- upvalues: u17 (val), u16 (val)
    local Size, items, items_2, janitor, parts, parts_2, updateTrackerOnParentChanged, v1, v2, v3, v4, v5
    if self:_preventMultiFrameUpdates("update") then
        return
    end
    self.totalVolume = 0
    self.parts = {}
    self.partToItem = {}
    self.items = {}
    for k, v in pairs(self.characters) do
        v4 = u17.getCharacterSize(k)
        if v4 then
            v5 = v4.X * v4.Y * v4.Z
            self.totalVolume = self.totalVolume + v5
            janitor = self.janitor
            v1 = u16
            v1 = v1.new()
            v2 = "trackCharacterParts-" .. self.name
            local u82 = janitor:add(v1, "destroy", v2)

            function updateTrackerOnParentChanged(p1) -- Line: 198 -- upvalues: u82 (ref), self (val)
                local v1 = u82
                local v2 = p1.AncestryChanged:Connect(function() -- Line: 199 -- upvalues: p1 (val), u82 (upval), self (upval)
                    local v1 = p1
                    local v2 = game
                    if not v1:IsDescendantOf(v2) and p1.Parent == nil and u82 ~= nil then
                        u82:destroy()
                        u82 = nil
                        self:update()
                    end
                end)
                v1:add(v2, "Disconnect")
            end

            for k2, i in pairs(k:GetChildren()) do
                if i:IsA("BasePart") and not u17.bodyPartsToIgnore[i.Name] then
                    self.partToItem[i] = k
                    parts_2 = self.parts
                    table.insert(parts_2, i)
                    v3 = i.AncestryChanged:Connect(function() -- Line: 199 -- upvalues: i (val), u82 (ref), self (val)
                        local v1 = i
                        local v2 = game
                        if not v1:IsDescendantOf(v2) and i.Parent == nil and u82 ~= nil then
                            u82:destroy()
                            u82 = nil
                            self:update()
                        end
                    end)
                    u82:add(v3, "Disconnect")
                end
            end
            v2 = k.AncestryChanged:Connect(function() -- Line: 199 -- upvalues: k (val), u82 (ref), self (val)
                local v1 = k
                local v2 = game
                if not v1:IsDescendantOf(v2) and k.Parent == nil and u82 ~= nil then
                    u82:destroy()
                    u82 = nil
                    self:update()
                end
            end)
            u82:add(v2, "Disconnect")
            items_2 = self.items
            table.insert(items_2, k)
        end
    end
    for k3, j in pairs(self.baseParts) do
        Size = k3.Size
        v5 = Size.X * Size.Y * Size.Z
        self.totalVolume = self.totalVolume + v5
        self.partToItem[k3] = k3
        parts = self.parts
        table.insert(parts, k3)
        items = self.items
        table.insert(items, k3)
    end
    self.whitelistParams = OverlapParams.new()
    self.whitelistParams.FilterType = Enum.RaycastFilterType.Whitelist
    self.whitelistParams.MaxParts = #self.parts
    self.whitelistParams.FilterDescendantsInstances = self.parts
end

return u17