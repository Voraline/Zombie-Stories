local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local u22 = require("@game/ReplicatedStorage/common/PlayerHandler")
local u25 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local u37 = {}
local u41 = peek(u25.Graphics.HideNearbyPlayers)
local u42 = false
local function playerAdded(p1) -- Line: 17 -- upvalues: Players (val), u22 (val), u37 (val)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p1)
    if PlayerFromCharacter == Players.LocalPlayer then
        return
    end
    local PlayerState = u22:GetPlayerState(PlayerFromCharacter)
    u37[p1] = {
        LastDistance = 100,
        Character = p1,
        LastCheck = os.time(),
        Player = PlayerFromCharacter,
        PlayerState = PlayerState,
    }
    if not PlayerState then
        local v1 = u22:WaitForPlayerState(PlayerFromCharacter)
        if v1 then
            u37[p1].PlayerState = v1
        end
    end
end
local function makeVisiblePlayers() -- Line: 67 -- upvalues: u37 (val)
    local v1 = u37
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        for k, n in j.Character:QueryDescendants("BasePart, Decal") do
            n.LocalTransparencyModifier = 0
        end
    end
end
RunService.Heartbeat:Connect(function() -- Line: 75 -- upvalues: peek (val), u25 (val), u41 (ref), Players (val), makeVisiblePlayers (val), u42 (ref), u37 (val), u22 (val)
    local LastDistance, Magnitude, PlayerState, PrimaryPart_2, v1
    local v2 = peek(u25.Graphics.HideNearbyPlayers)
    u41 = v2
    local Character = Players.LocalPlayer.Character
    local PrimaryPart = Character
    if PrimaryPart then
        PrimaryPart = Character.PrimaryPart
        if not PrimaryPart then
            PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
        end
    end
    if not v2 then
        if u41 then
            makeVisiblePlayers()
        end
        return
    end
    if not PrimaryPart then
        if u42 then
            makeVisiblePlayers()
        end
        u42 = false
        return
    end
    u42 = true
    local v3 = u37
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        if j.Character then
            PrimaryPart_2 = j.Character.PrimaryPart
            if PrimaryPart_2 then
                LastDistance = j.LastDistance
                Magnitude = (PrimaryPart.Position - PrimaryPart_2.Position).Magnitude
                j.LastDistance = Magnitude
                if LastDistance < 10 then
                    if Magnitude <= 3 then
                        v1 = 1
                    elseif 6 > Magnitude then
                        v1 = (6 - Magnitude) / 3
                    else
                        v1 = 0
                    end
                    PlayerState = u22:GetPlayerState(Players.LocalPlayer)
                    if PlayerState and PlayerState.Properties.IsDowned then
                        v1 = 0
                    end
                    if j.PlayerState then
                        if j.PlayerState.Properties.IsDowned then
                            v1 = 0
                        elseif not j.PlayerState.Properties.IsDead then
                        end
                    end
                    for k, n in j.Character:QueryDescendants("BasePart, Decal") do
                        n.LocalTransparencyModifier = v1
                    end
                elseif Magnitude >= 10 then
                end
            end
        end
    end
end)
for i, j in CollectionService:GetTagged("PlayerCharacter") do
    playerAdded(j)
end
local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("PlayerCharacter")
InstanceAddedSignal:Connect(playerAdded)
local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal("PlayerCharacter")
InstanceRemovedSignal:Connect(function(p1) -- Line: 41 -- upvalues: u37 (val)
    for i, j in p1:QueryDescendants("BasePart, Decal") do
        j.LocalTransparencyModifier = 0
    end
    u37[p1] = nil
end)
for k, n in CollectionService:GetTagged("WorldWeapon") do
    u37[n] = {LastDistance = 100, Character = n, LastCheck = os.time()}
end
local InstanceAddedSignal_2 = CollectionService:GetInstanceAddedSignal("WorldWeapon")
InstanceAddedSignal_2:Connect(function(p1) -- Line: 49 -- upvalues: u37 (val)
    u37[p1] = {LastDistance = 100, Character = p1, LastCheck = os.time()}
end)
local InstanceRemovedSignal_2 = CollectionService:GetInstanceRemovedSignal("WorldWeapon")
InstanceRemovedSignal_2:Connect(function(p1) -- Line: 59 -- upvalues: u37 (val)
    for i, j in p1:QueryDescendants("BasePart, Decal") do
        j.LocalTransparencyModifier = 0
    end
    u37[p1] = nil
end)
return {}