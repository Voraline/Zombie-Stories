local RunService_2 = game:GetService("RunService")
local u7 = require("./EggData")
local RedEvents = game:GetService("ReplicatedStorage").common.RedEvents
local Players = game:GetService("Players")
local Eggs = script.Eggs
local SpawnEgg = require(RedEvents.Events.SpawnEgg)
local EggCollected = require(RedEvents.Events.EggCollected)
local u30 = {
    ChooseRandomPosition = function(p1, p2) -- Line: 13
        if not p2 or #p2 == 0 then
            return nil
        end
        return p2[math.random(1, #p2)]
    end,
}
if RunService_2:IsServer() then
    local u37 = require("./EasterEventController")
    function u30.SpawnEggServer(p1, p2) -- Line: 21 -- upvalues: u7 (val), u30 (val), u37 (val), SpawnEgg (val)
        local v1
        local v2 = u7.EggConfigs[p2]
        if not v2 then
            warn("No egg config found for chapter: " .. p2)
            return
        end
        local v3 = {}
        local GetData = game.ServerScriptService.common.Data.Bindables.GetData
        if _G.Difficulty ~= "Hard" then
            v1 = p2
        else
            local EggConfigs, v4, v5, v6, v7, v8
            v1 = p2
            for i, j in game.Players:GetPlayers() do
                v4 = GetData:Invoke(j)
                v5 = 0
                EggConfigs = u7.EggConfigs
                v6 = nil
                v7 = nil
                for k, n in EggConfigs, v6, v7 do
                    if v4.Stats.UniqueAwards.Easter2025[k] then
                        v8 = v4.Stats.UniqueAwards.Easter2025[k]
                        if 0 < v8 then
                            v5 = v5 + 1
                        end
                    end
                end
                if 4 <= v5 then
                    table.insert(v3, j)
                end
            end
        end
        local v9 = u30:ChooseRandomPosition(v2.SpawnPositions)
        local EligiblePlayers = u37:GetEligiblePlayers(v1)
        SpawnEgg:FireClients(EligiblePlayers, v1, v9)
        SpawnEgg:FireClients(v3, "Master", v9)
        return v9
    end
end
if RunService_2:IsClient() then
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    require("./EasterEventClient")
    function u30.SpawnEggLocal(p1, p2, p3) -- Line: 63 -- upvalues: u7 (val), Eggs (val), RunService (val), Players (val), LocalPlayer (val), EggCollected (val)
        if not (u7.EggConfigs[p2]) then
            warn("No egg config found for chapter: " .. p2)
            return
        end
        local u18 = Eggs:FindFirstChild(p2):Clone()
        u18.Name = "EasterEgg_" .. p2
        u18.PrimaryPart.Anchored = true
        u18.PrimaryPart.CanCollide = false
        u18:SetPrimaryPartCFrame((CFrame.new(p3)))
        u18.Parent = workspace
        local Sound = Instance.new("Sound")
        Sound.SoundId = "rbxassetid://9116393424"
        Sound.Volume = 2
        Sound.Looped = true
        Sound.Parent = u18.PrimaryPart
        Sound.RollOffMaxDistance = 50
        Sound.RollOffMinDistance = 5
        Sound.RollOffMode = Enum.RollOffMode.Linear
        Sound:Play()
        local PrimaryPartCFrame = u18:GetPrimaryPartCFrame()
        local u50 = 0
        local u51 = nil
        u51 = RunService.Heartbeat:Connect(function(p1) -- Line: 94 -- upvalues: u50 (ref), u18 (val), PrimaryPartCFrame (val), u51 (ref)
            u50 = u50 + p1
            if not u18 then
                if u51 then
                    u51:Disconnect()
                end
                return
            end
            if u18.Parent then
                local v1 = (math.sin(u50 * 1.5) + 1) * 0.5 * 2
                u18:SetPrimaryPartCFrame(PrimaryPartCFrame * CFrame.new(0, v1, 0))
                return
            end
            if u51 then
                u51:Disconnect()
            end
        end)
        local u59 = false
        u18.PrimaryPart.Touched:Connect(function(p1) -- Line: 107 -- upvalues: u59 (ref), Players (upval), LocalPlayer (upval), Sound (val), u18 (val), u51 (ref), EggCollected (upval), p2 (val)
            if u59 then
                return
            end
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p1.Parent)
            if PlayerFromCharacter and PlayerFromCharacter == LocalPlayer then
                Sound:Destroy()
                u59 = true
                for i, j in u18:GetChildren() do
                    j.Transparency = 1
                end
                if u51 then
                    u51:Disconnect()
                end
                EggCollected:FireServer(p2)
                task.delay(1, function() -- Line: 119 -- upvalues: u18 (upval)
                    if u18 then
                        u18:Destroy()
                    end
                end)
            end
        end)
    end
    SpawnEgg:SetClientListener(function(p1, p2) -- Line: 126 -- upvalues: u30 (val)
        u30:SpawnEggLocal(p1, p2)
    end)
end
return u30