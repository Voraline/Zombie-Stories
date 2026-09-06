game:GetService("TweenService")
local BossHealth = script:WaitForChild("BossHealth")
local MainFrame = BossHealth:WaitForChild("MainFrame")
local Template = MainFrame:WaitForChild("Template")
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local NPCRegistry = require(game.ReplicatedStorage.common:WaitForChild("NPCRegistry"))
local u38 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/StatusEffect_Util")
local u43 = Color3.fromRGB(255, 120, 120)
local u48 = Color3.fromRGB(255, 162, 2)
local u53 = Color3.fromRGB(120, 255, 120)
BossHealth.Parent = game.Players.LocalPlayer.PlayerGui
local u58 = {IsShowing = false}
function u58.Show(p1) -- Line: 27 -- upvalues: u58 (val), MainFrame (val)
    u58.IsShowing = true
    local v1 = UDim2.new(0.5, 0, 0, 0)
    MainFrame:TweenPosition(v1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
end
function u58.Hide(p1) -- Line: 33 -- upvalues: u58 (val), MainFrame (val)
    u58.IsShowing = false
    local v1 = UDim2.new(0.5, 0, -0.5, -36)
    MainFrame:TweenPosition(v1, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
end
function u58.AddBoss(p1, p2, p3) -- Line: 39 -- upvalues: NPCRegistry (val), Template (val), MainFrame (val), u38 (val), u53 (val), u48 (val), u43 (val)
    local u7 = NPCRegistry:WaitForNPC(p2)
    if u7 ~= nil then
        task.defer(function() -- Line: 42 -- upvalues: u7 (val), p3 (ref), Template (upval), MainFrame (upval), u38 (upval), u53 (upval), u48 (upval), u43 (upval)
            if u7.new ~= nil then
                if not u7.IsDead then
                    local Name
                    if p3 == nil then
                        Name = u7.Name
                    else
                        Name = p3
                    end
                    p3 = Name
                    local MaxHP = u7.MaxHP
                    local u16 = Template:Clone()
                    local HealthBar = u16:WaitForChild("HealthBar")
                    local Bar = HealthBar:WaitForChild("Bar")
                    local Status = u16:WaitForChild("Status")
                    u16.Visible = true
                    u16.NameLabel.Text = p3
                    u16.Parent = MainFrame
                    if u7.CurrentEffects then
                        for i, j in u7.CurrentEffects() do
                            u38.GetIconLabel(j).Parent = Status
                        end
                    end
                    local function updateHealth(p1) -- Line: 63 -- upvalues: MaxHP (val), Bar (val), u53 (upval), u48 (upval), u43 (upval)
                        local v1 = math.max(p1 / MaxHP, 0)
                        local v2 = UDim2.new(v1, 0, 1, 0)
                        Bar:TweenSize(v2, nil, nil, 0.25, true)
                        if 0.6 < v1 then
                            Bar.BackgroundColor3 = u53
                            return
                        end
                        if 0.3 < v1 then
                            Bar.BackgroundColor3 = u48
                            return
                        end
                        Bar.BackgroundColor3 = u43
                    end
                    local u64 = u7.HealthChanged:Connect(updateHealth)
                    local u70 = u7.StatusUpdated:Connect(function(p1, p2) -- Line: 74 -- upvalues: Status (val), u38 (upval)
                        if p1 ~= "Apply" then
                            return
                        end
                        if Status:FindFirstChild(p2._Name) then
                            Status[p2._Name]:Destroy()
                        end
                        local v1 = u38.GetIconLabel(p2)
                        v1.Parent = Status
                    end)
                    updateHealth(u7.HP)
                    local u75 = nil
                    local u76 = nil
                    u76 = u7.Died:Connect(function() -- Line: 93 -- upvalues: u64 (val), u76 (ref), u75 (ref), u16 (val), u70 (val)
                        u64:Disconnect()
                        u76:Disconnect()
                        u75:Disconnect()
                        u16:Destroy()
                        u70:Disconnect()
                    end)
                end
            elseif not u7.IsCompat then
            end
        end)
    end
end
return u58