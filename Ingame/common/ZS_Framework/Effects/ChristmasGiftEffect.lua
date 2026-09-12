local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local v1 = require("@game/ReplicatedStorage/common/zap")
local Bin = require(ReplicatedStorage.Packages.Bin)
local u33 = {}
local u34 = {"rbxassetid://9117204119", "rbxassetid://6337264445"}
local u37 = {}
local v2 = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), (Color3.fromRGB(0, 0, 255))}
local v3 = {Color3.fromRGB(143, 95, 255), Color3.fromRGB(159, 85, 255), (Color3.fromRGB(130, 245, 245))}
local v4 = {Color3.fromRGB(25, 0, 255), Color3.fromRGB(47, 102, 255), (Color3.fromRGB(0, 17, 255))}
local v5 = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(209, 52, 52), (Color3.fromRGB(224, 69, 69))}
local v6 = {Color3.fromRGB(230, 227, 77), Color3.fromRGB(255, 255, 0), (Color3.fromRGB(206, 236, 69))}
local v7 = {Color3.fromRGB(219, 73, 122), Color3.fromRGB(230, 58, 109), (Color3.fromRGB(219, 76, 136))}
u37[1] = v2
u37[2] = v3
u37[3] = v4
u37[4] = v5
u37[5] = v6
u37[6] = v7

local function clientCollectedEffect(p1) -- Line: 54
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://9117204119"
    Sound.Volume = 1
    Sound.Parent = workspace
    Sound.PlayOnRemove = true
    Sound:Destroy()
end

local function collectedEffect(p1, p2) -- Line: 63 -- upvalues: Players (val), ReplicatedStorage (val), Debris (val)
    if p1 == Players.LocalPlayer then
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://6337264445"
        Sound.Volume = 2
        Sound.Parent = workspace
        Sound.PlayOnRemove = true
        Sound:Destroy()
    end
    local v1 = ReplicatedStorage.common.SharedResources.Assets.ChristmasGiftOpenSparkle:Clone()
    v1.CFrame = p2
    v1.Parent = workspace
    v1.Attachment.ParticleEmitter:Emit(1)
    Debris:AddItem(v1, 5)
end

local function giftAdded(p1) -- Line: 81
    -- upvalues: Bin (val), u33 (val), u37 (val), ReplicatedStorage (val), u34 (val), RunService (val), Players (val)
    local v1
    local v2, v3 = Bin()
    u33[p1] = v3
    local Position = p1.CFrame.Position
    local X = Position.X
    local v4 = math.floor(X)
    local Y = Position.Y
    local v5 = v4 + math.floor(Y)
    local Z = Position.Z
    local v6 = v5 + math.floor(Z)
    v5 = Random.new(v6)
    local v7 = u37
    local v8 = u37
    local v9 = #v8
    v4 = v7[v5:NextInteger(1, v9)]
    v9 = #v4
    v7 = v4[v5:NextInteger(1, v9)]
    v8 = #v4
    local v10 = v4[v5:NextInteger(1, v8)]
    local v11 = #v4
    local v12 = v4[v5:NextInteger(1, v11)]
    local v13 = #v4
    local v14 = v4[v5:NextInteger(1, v13)]
    local u62 = v2(ReplicatedStorage.common.SharedResources.Assets.ChristmasGift:Clone())
    v8 = v2(ReplicatedStorage.common.SharedResources.Assets.ChristmasGiftOpenSparkle:Clone())
    v8.CFrame = p1.CFrame
    v8.Parent = u62.PrimaryPart
    local u75 = 0.01
    u62.PrimaryPart = u62.Base
    local v15 = u75
    u62:ScaleTo(v15)
    local CFrame = p1.CFrame
    u62:SetPrimaryPartCFrame(CFrame)
    v13 = u34
    local v16 = nil
    v15 = nil
    for i, j in v13, v16, v15 do
        v1 = v2(Instance.new("Sound"))
        v1.SoundId = j
        v1.Parent = u62
    end
    for k, n in u62:QueryDescendants("BasePart") do
        if n.Name == "Ribbon" then
            n.Color = v7
        elseif n.Name == "Bow" then
            n.Color = v12
        elseif n.Name ~= "Base" then
            n.Color = v14
        else
            n.Color = v10
        end
    end
    u62.Parent = workspace
    v16 = RunService
    v2(v16.Heartbeat:Connect(function(p1) -- Line: 132 -- upvalues: u62 (val), u75 (ref)
        local v1 = u62
        local CFrame_2 = v1.PrimaryPart.CFrame
        local Angles = CFrame.Angles
        local v2 = p1 * 60
        local v3 = math.rad(v2)
        local v4 = Angles(0, v3, 0)
        local v5 = u62
        v2 = CFrame_2 * v4
        v5:SetPrimaryPartCFrame(v2)
        if u75 < 1 then
            v3 = u75 + p1 * 1.5
            u75 = math.clamp(v3, 0, 1)
            v5 = u62
            v2 = u75
            v5:ScaleTo(v2)
        end
    end))
    local u121 = false
    v2(p1.Touched:Connect(function(p1_2) -- Line: 145 -- upvalues: Players (upval), u121 (ref), p1 (val), u62 (val)
        local Parent = p1_2.Parent
        if not Parent or not Parent:FindFirstChild("Humanoid") then
            return
        end
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Parent)
        if not PlayerFromCharacter or PlayerFromCharacter ~= Players.LocalPlayer or u121 then
            return
        end
        u121 = true
        local CFrame = p1.CFrame
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://9117204119"
        Sound.Volume = 1
        Sound.Parent = workspace
        Sound.PlayOnRemove = true
        Sound:Destroy()
        for i, j in u62:QueryDescendants("BasePart") do
            j.Transparency = 1
        end
    end))
end

for i, j in CollectionService:GetTagged("ChristmasGift") do
    giftAdded(j)
end
;(CollectionService:GetInstanceAddedSignal("ChristmasGift")):Connect(giftAdded)
;(CollectionService:GetInstanceRemovedSignal("ChristmasGift")):Connect(function(p1) -- Line: 178 -- upvalues: u33 (val)
    if u33[p1] then
        u33[p1]()
        u33[p1] = nil
    end
end)
v1.ChristmasGiftCollected.On(function(p1) -- Line: 192 -- upvalues: collectedEffect (val)
    if not p1.Player:IsA("Player") then
        return
    end
    collectedEffect(p1.Player, p1.Gift)
end)
return {}