local Players = game:GetService("Players")
local common = game.ReplicatedStorage.common
local hpbar = script.hpbar
local u10 = {
    Assault = "rbxassetid://4458718282",
    Medic = "rbxassetid://2706886795",
    Sniper = "rbxassetid://4458692655",
    Support = "rbxassetid://2706886028",
    Arcade = "rbxassetid://112766246588072",
}
local u11 = {}
u11.Low = Color3.fromRGB(255, 148, 148)
u11.Medium = Color3.fromRGB(255, 249, 158)
u11.High = Color3.fromRGB(178, 255, 161)
local PlayerHandler = require(common.PlayerHandler)
local u30 = 100
local u31 = {}
local u32 = nil
local v1 = {}

local function addHealthBar(p1, p2) -- Line: 34
    -- upvalues: u31 (val), u32 (ref), hpbar (val), u10 (val), PlayerHandler (val), u30 (ref), u11 (val)
    local v1 = u31[p1]
    if v1 and p1 ~= u32 then
        local Character_2 = p2
        if not Character_2 then
            Character_2 = p1.Character
        end
        local Character = Character_2
        local Name = p1.Name
        local LoadingStatus = workspace:WaitForChild("LoadingStatus")
        local v2 = tick()
        while true do
            if not Character then
                if not (tick() - v2 < 30) then
                    break
                end
                Character = p1.Character
                if not Character then
                    task.wait(0.5)
                end
            else
                if Character.Parent ~= nil or not (tick() - v2 < 30) then
                    break
                end
                Character = p1.Character
                if not Character then
                    task.wait(0.5)
                end
            end
        end
        if Character and p1.Character == Character then
            if v1.currentCharacter ~= Character then
                return
            end
            local Head = Character:WaitForChild("Head", 10)
            if Head and Head.Parent == Character then
                local Value = "Assault"
                local Value_2 = 0
                local v3 = LoadingStatus.Players:WaitForChild(Name)
                if v3 then
                    local Class = v3:WaitForChild("Class")
                    local Level = v3:WaitForChild("Level")
                    if Class then
                        Value = Class.Value
                    end
                    if Level then
                        Value_2 = Level.Value
                    end
                end
                if not Character or not Character.Parent or not Head or not Head.Parent then
                    warn("HealthBarController: Character or head no longer exists for", Name)
                else
                    local u86 = hpbar:Clone()
                    u86.Parent = Head
                    local v4 = u10[Value] or "rbxassetid://4458718282"
                    u86.ImageLabel.Image = v4
                    u86.Username.Text = "@" .. p1.Name
                    local DisplayName = u86.DisplayName
                    local DisplayName_2 = p1.DisplayName
                    if not DisplayName_2 then
                        DisplayName_2 = p1.Name
                    end
                    DisplayName.Text = DisplayName_2
                    local LevelLabel = u86.LevelLabel
                    LevelLabel.Text = tostring(Value_2)
                    if p1.MembershipType == Enum.MembershipType.Premium then
                        u86.PremiumIcon.Visible = true
                        local DisplayName_3 = u86.DisplayName
                        DisplayName_3.Position = UDim2.new(0.285, 0, 0.1, 0)
                        local DisplayName_4 = u86.DisplayName
                        DisplayName_4.Size = UDim2.new(0.71, 0, 0.5, 0)
                    end
                    if 100 <= Value_2 then
                        local LevelLabel_2 = u86.LevelLabel
                        LevelLabel_2.TextColor3 = Color3.fromRGB(255, 215, 0)
                        local ImageLabel = u86.ImageLabel
                        ImageLabel.ImageColor3 = Color3.fromRGB(255, 215, 0)
                    end
                    local success, result = pcall(function() -- Line: 110 -- upvalues: PlayerHandler (upval), p1 (val)
                        local v1 = PlayerHandler
                        local v2 = p1
                        return v1:WaitForPlayerState(v2)
                    end)
                    if not success or not result then
                        warn("HealthBarController: Failed to get player state for", Name)
                    else
                        local u157 = result.HealthChanged:Connect(function(p1, p2) -- Line: 115 -- upvalues: u86 (val), result (val), u30 (upval), u11 (upval)
                            if u86 and u86.Parent then
                                local Low
                                local v1 = result.MaxHP or 100
                                u30 = p1
                                if p1 <= v1 * 0.4 then
                                    Low = u11.Low
                                elseif not (p1 <= v1 * 0.6) then
                                    Low = u11.High
                                else
                                    Low = u11.Medium
                                end
                                u86.Bar.HPFill.BackgroundColor3 = Low
                                local v2 = u86
                                local HPFill = v2.Bar.HPFill
                                local new = UDim2.new
                                local v3 = p1 / v1
                                HPFill.Size = new(math.clamp(v3, 0, 1), 0, 1, 0)
                                return
                            end
                        end)
                        Character.AncestryChanged:Connect(function() -- Line: 138 -- upvalues: Character (ref), u157 (val)
                            if not Character.Parent then
                                u157:Disconnect()
                            end
                        end)
                    end
                end
                return
            end
            warn("HealthBarController: Head not found for player", Name)
            return
        end
        warn("HealthBarController: Character not found for player", Name)
        return
    end
end

local function cleanupTrackedPlayer(p1) -- Line: 151 -- upvalues: u31 (val)
    local v1 = u31[p1]
    if not v1 then
        return
    end
    if v1.characterAddedConn then
        v1.characterAddedConn:Disconnect()
    end
    u31[p1] = nil
end

local function trackPlayer(p1) -- Line: 164 -- upvalues: u32 (ref), u31 (val), addHealthBar (val)
    if u32 and p1 ~= u32 and not u31[p1] then
        local u5 = {}
        u31[p1] = u5
        u5.characterAddedConn = p1.CharacterAdded:Connect(function(p1_2) -- Line: 171 -- upvalues: u5 (val), addHealthBar (upval), p1 (val)
            u5.currentCharacter = p1_2
            task.spawn(function() -- Line: 173 -- upvalues: p1_2 (val)
                local Humanoid = p1_2:WaitForChild("Humanoid", 10)
                if Humanoid then
                    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                end
            end)
            task.spawn(addHealthBar, p1, p1_2)
        end)
        if p1.Character then
            local Character = p1.Character
            u5.currentCharacter = Character
            task.spawn(function() -- Line: 173 -- upvalues: Character (val)
                local Humanoid = Character:WaitForChild("Humanoid", 10)
                if Humanoid then
                    Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                end
            end)
            task.spawn(addHealthBar, p1, Character)
        end
        return
    end
end

function v1.Init(p1, p2) -- Line: 190 -- upvalues: u32 (ref), Players (val), trackPlayer (val), u31 (val)
    u32 = p2
    if not p2.Character then
        p2.CharacterAdded:Wait()
    end
    local v1 = Players
    local PlayerAdded = v1.PlayerAdded
    local v2 = trackPlayer
    PlayerAdded:Connect(v2)
    v1 = Players
    v1.PlayerRemoving:Connect(function(p1) -- Line: 199 -- upvalues: u31 (upval)
        local v1 = u31[p1]
        if not v1 then
            return
        end
        if v1.characterAddedConn then
            v1.characterAddedConn:Disconnect()
        end
        u31[p1] = nil
    end)
    for i, j in Players:GetPlayers() do
        task.defer(trackPlayer, j)
    end
end

return v1