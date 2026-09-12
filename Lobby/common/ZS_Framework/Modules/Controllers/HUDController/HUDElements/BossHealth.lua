game:GetService("TweenService")
local BossHealth = script:WaitForChild("BossHealth")
local MainFrame = BossHealth:WaitForChild("MainFrame")
local Template = MainFrame:WaitForChild("Template")
local common = game.ReplicatedStorage.common
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local NPCRegistry = require(common:WaitForChild("NPCRegistry"))
local u38 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/StatusEffect_Util")
local u43 = Color3.fromRGB(255, 120, 120)
local u48 = Color3.fromRGB(255, 162, 2)
local u53 = Color3.fromRGB(120, 255, 120)
BossHealth.Parent = game.Players.LocalPlayer.PlayerGui
local u58 = {IsShowing = false}

function u58.Show(p1) -- Line: 27 -- upvalues: u58 (val), MainFrame (val)
    u58.IsShowing = true
    local v1 = MainFrame
    local v2 = UDim2.new(0.5, 0, 0, 0)
    local Out = Enum.EasingDirection.Out
    local Quad = Enum.EasingStyle.Quad
    v1:TweenPosition(v2, Out, Quad, 0.5, true)
end

function u58.Hide(p1) -- Line: 33 -- upvalues: u58 (val), MainFrame (val)
    u58.IsShowing = false
    local v1 = MainFrame
    local v2 = UDim2.new(0.5, 0, -0.5, -36)
    local Out = Enum.EasingDirection.Out
    local Quad = Enum.EasingStyle.Quad
    v1:TweenPosition(v2, Out, Quad, 0.5, true)
end

function u58.AddBoss(p1, p2, p3) -- Line: 39
    -- upvalues: NPCRegistry (val), Template (val), MainFrame (val), u38 (val), u53 (val), u48 (val), u43 (val)
    local u7 = NPCRegistry:WaitForNPC(p2)
    if u7 ~= nil then
        task.defer(function() -- Line: 42
            -- upvalues: u7 (val), p3 (ref), Template (upval), MainFrame (upval), u38 (upval), u53 (upval), u48 (upval)
            -- upvalues: u43 (upval)
            local Bar, MaxHP, Name, Status, u16, u64, u70, u75, u76, updateHealth, v1
            if u7.new ~= nil then
                if not u7.IsDead then
                    if p3 == nil then
                        Name = u7.Name
                    else
                        Name = p3
                    end
                    p3 = Name
                    MaxHP = u7.MaxHP
                    u16 = Template:Clone()
                    Bar = (u16:WaitForChild("HealthBar")):WaitForChild("Bar")
                    Status = u16:WaitForChild("Status")
                    u16.Visible = true
                    u16.NameLabel.Text = p3
                    u16.Parent = MainFrame
                    if u7.CurrentEffects then
                        for i, j in u7.CurrentEffects() do
                            u38.GetIconLabel(j).Parent = Status
                        end
                    end

                    function updateHealth(p1) -- Line: 63
                        -- upvalues: MaxHP (val), Bar (val), u53 (upval), u48 (upval), u43 (upval)
                        local v1 = p1 / MaxHP
                        local v2 = math.max(v1, 0)
                        v1 = Bar
                        local v3 = UDim2.new(v2, 0, 1, 0)
                        v1:TweenSize(v3, nil, nil, 0.25, true)
                        if 0.6 < v2 then
                            Bar.BackgroundColor3 = u53
                            return
                        end
                        if 0.3 < v2 then
                            Bar.BackgroundColor3 = u48
                            return
                        end
                        Bar.BackgroundColor3 = u43
                    end

                    u64 = u7.HealthChanged:Connect(updateHealth)
                    u70 = u7.StatusUpdated:Connect(function(p1, p2) -- Line: 74 -- upvalues: Status (val), u38 (upval)
                        if p1 ~= "Apply" then
                            return
                        end
                        local v1 = Status
                        local _Name = p2._Name
                        if v1:FindFirstChild(_Name) then
                            Status[p2._Name]:Destroy()
                        end
                        v1 = u38.GetIconLabel(p2)
                        v1.Parent = Status
                    end)
                    updateHealth(u7.HP)
                    u75 = nil
                    u76 = nil
                    v1 = u7
                    u76 = v1.Died:Connect(function() -- Line: 93 -- upvalues: u64 (val), u76 (ref), u75 (ref), u16 (val), u70 (val)
                        u64:Disconnect()
                        u76:Disconnect()
                        u75:Disconnect()
                        u16:Destroy()
                        u70:Disconnect()
                    end)
                    v1 = u7
                    v1 = v1.Destroyed:Connect(function() -- Line: 102 -- upvalues: u64 (val), u76 (ref), u75 (ref), u16 (val)
                        u64:Disconnect()
                        u76:Disconnect()
                        u75:Disconnect()
                        u16:Destroy()
                    end)
                end
            elseif u7.IsCompat and not u7.IsDead then
                if p3 == nil then
                    Name = u7.Name
                else
                    Name = p3
                end
                p3 = Name
                MaxHP = u7.MaxHP
                u16 = Template:Clone()
                Bar = (u16:WaitForChild("HealthBar")):WaitForChild("Bar")
                Status = u16:WaitForChild("Status")
                u16.Visible = true
                u16.NameLabel.Text = p3
                u16.Parent = MainFrame
                if u7.CurrentEffects then
                    for k, n in u7.CurrentEffects() do
                        u38.GetIconLabel(n).Parent = Status
                    end
                end

                function updateHealth(p1) -- Line: 63
                    -- upvalues: MaxHP (val), Bar (val), u53 (upval), u48 (upval), u43 (upval)
                    local v1 = p1 / MaxHP
                    local v2 = math.max(v1, 0)
                    v1 = Bar
                    local v3 = UDim2.new(v2, 0, 1, 0)
                    v1:TweenSize(v3, nil, nil, 0.25, true)
                    if 0.6 < v2 then
                        Bar.BackgroundColor3 = u53
                        return
                    end
                    if 0.3 < v2 then
                        Bar.BackgroundColor3 = u48
                        return
                    end
                    Bar.BackgroundColor3 = u43
                end

                u64 = u7.HealthChanged:Connect(updateHealth)
                u70 = u7.StatusUpdated:Connect(function(p1, p2) -- Line: 74 -- upvalues: Status (val), u38 (upval)
                    if p1 ~= "Apply" then
                        return
                    end
                    local v1 = Status
                    local _Name = p2._Name
                    if v1:FindFirstChild(_Name) then
                        Status[p2._Name]:Destroy()
                    end
                    v1 = u38.GetIconLabel(p2)
                    v1.Parent = Status
                end)
                updateHealth(u7.HP)
                u75 = nil
                u76 = nil
                v1 = u7
                u76 = v1.Died:Connect(function() -- Line: 93 -- upvalues: u64 (val), u76 (ref), u75 (ref), u16 (val), u70 (val)
                    u64:Disconnect()
                    u76:Disconnect()
                    u75:Disconnect()
                    u16:Destroy()
                    u70:Disconnect()
                end)
                v1 = u7
                v1 = v1.Destroyed:Connect(function() -- Line: 102 -- upvalues: u64 (val), u76 (ref), u75 (ref), u16 (val)
                    u64:Disconnect()
                    u76:Disconnect()
                    u75:Disconnect()
                    u16:Destroy()
                end)
            end
        end)
    end
end

return u58