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
local v2 = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255)}
local v3 = {Color3.fromRGB(143, 95, 255), Color3.fromRGB(159, 85, 255), Color3.fromRGB(130, 245, 245)}
local v4 = {Color3.fromRGB(25, 0, 255), Color3.fromRGB(47, 102, 255), Color3.fromRGB(0, 17, 255)}
local v5 = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(209, 52, 52), Color3.fromRGB(224, 69, 69)}
local v6 = {Color3.fromRGB(230, 227, 77), Color3.fromRGB(255, 255, 0), Color3.fromRGB(206, 236, 69)}
local v7 = {Color3.fromRGB(219, 73, 122), Color3.fromRGB(230, 58, 109), Color3.fromRGB(219, 76, 136)}
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
local function giftAdded(p1) -- Line: 81 -- upvalues: Bin (val), u33 (val), u37 (val), ReplicatedStorage (val), u34 (val), RunService (val), Players (val)
    local v1, v2, v3
    v1, v3 = Bin()
    u33[p1] = v3
    local Position = p1.CFrame.Position
    local v4 = math.floor(Position.X)
    local v5 = v4 + math.floor(Position.Y)
    local v6 = v5 + math.floor(Position.Z)
    v5 = Random.new(v6)
    v4 = u37[v5:NextInteger(1, #u37)]
    local u62 = v1(ReplicatedStorage.common.SharedResources.Assets.ChristmasGift:Clone())
    local v7 = v1(ReplicatedStorage.common.SharedResources.Assets.ChristmasGiftOpenSparkle:Clone())
    v7.CFrame = p1.CFrame
    v7.Parent = u62.PrimaryPart
    local u75 = 0.01
    u62.PrimaryPart = u62.Base
    u62:ScaleTo(u75)
    u62:SetPrimaryPartCFrame(p1.CFrame)
    local v8 = u34
    local v9 = nil
    local v10 = nil
    for i, j in v8, v9, v10 do
        v2 = v1(Instance.new("Sound"))
        v2.SoundId = j
        v2.Parent = u62
    end
    for k, n in u62:QueryDescendants("BasePart") do
        if n.Name == "Ribbon" then
            n.Color = v4[v5:NextInteger(1, #v4)]
        elseif n.Name == "Bow" then
            n.Color = v4[v5:NextInteger(1, #v4)]
        elseif n.Name ~= "Base" then
            n.Color = v4[v5:NextInteger(1, #v4)]
        else
            n.Color = v4[v5:NextInteger(1, #v4)]
        end
    end
    u62.Parent = workspace
    v1(RunService.Heartbeat:Connect(function(p1) -- Line: 132 -- upvalues: u62 (val), u75 (ref)
        local v1 = math.rad(p1 * 60)
        local v2 = CFrame.Angles(0, v1, 0)
        u62:SetPrimaryPartCFrame(u62.PrimaryPart.CFrame * v2)
        if u75 < 1 then
            u75 = math.clamp(u75 + p1 * 1.5, 0, 1)
            u62:ScaleTo(u75)
        end
    end))
    local u121 = false
    v1(p1.Touched:Connect(function(a1) -- Line: 145 -- upvalues: Players (upval), u121 (ref), p1 (val), u62 (val)
        local Parent = a1.Parent
        if not Parent or not (Parent:FindFirstChild("Humanoid")) then
            return
        end
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Parent)
        if not PlayerFromCharacter or PlayerFromCharacter ~= Players.LocalPlayer or u121 then
            return
        end
        u121 = true
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
local InstanceAddedSignal = CollectionService:GetInstanceAddedSignal("ChristmasGift")
InstanceAddedSignal:Connect(giftAdded)
local InstanceRemovedSignal = CollectionService:GetInstanceRemovedSignal("ChristmasGift")
InstanceRemovedSignal:Connect(function(p1) -- Line: 178 -- upvalues: u33 (val)
    if u33[p1] then
        u33[p1]()
        u33[p1] = nil
    end
end)
v1.ChristmasGiftCollected.On(function(p1) -- Line: 192 -- upvalues: collectedEffect (val)
    if not (p1.Player:IsA("Player")) then
        return
    end
    collectedEffect(p1.Player, p1.Gift)
end)
return {}