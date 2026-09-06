game:GetService("TweenService")
local Earnings = script.UI.Earnings
local Earnings_2 = Earnings.Earnings
local Items = Earnings.Items
local Template = Items.Template
local LevelUp = script.UI.LevelUp
local ClipFrame = LevelUp.ClipFrame
local ContentFrame = ClipFrame.ContentFrame
local WeaponUp = script.UI.WeaponUp
local ClipFrame_2 = WeaponUp.ClipFrame
local ContentFrame_2 = ClipFrame_2.ContentFrame
local Values = workspace:FindFirstChild("Values")
local IsDoubleXP = Values
if IsDoubleXP then
    IsDoubleXP = Values:FindFirstChild("IsDoubleXP")
end
local IsWeekend = Values
if IsWeekend then
    IsWeekend = Values:FindFirstChild("IsWeekend")
end
local StackableDoubleXP = Values
if StackableDoubleXP then
    StackableDoubleXP = Values:FindFirstChild("StackableDoubleXP")
end
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local ItemData = require(game.ReplicatedStorage.common.ItemData)
local ProgressionEvent = require(game.ReplicatedStorage.common.RedEvents.General.ProgressionEvent)
local u72 = {}
local u73 = {}
local u74 = {}
local u75 = false
local u76 = {Assault = "rbxassetid://4458718282", Medic = "rbxassetid://2706886795", Support = "rbxassetid://2706886028", Sniper = "rbxassetid://4458692655"}
local u77 = 0
local u78 = nil
local u79 = nil
local u80 = nil
Earnings.Parent = game.Players.LocalPlayer.PlayerGui
LevelUp.Parent = game.Players.LocalPlayer.PlayerGui
WeaponUp.Parent = game.Players.LocalPlayer.PlayerGui
local u102 = {IsShowing = true}
function u102.Show(p1) -- Line: 53 -- upvalues: u102 (val), Earnings (val), LevelUp (val), WeaponUp (val)
    u102.IsShowing = true
    Earnings.Enabled = true
    LevelUp.Enabled = true
    WeaponUp.Enabled = true
end
function u102.Hide(p1) -- Line: 61 -- upvalues: u102 (val), Earnings (val), LevelUp (val), WeaponUp (val)
    u102.IsShowing = false
    Earnings.Enabled = false
    LevelUp.Enabled = false
    WeaponUp.Enabled = false
end
ProgressionEvent:SetClientListener(function(p1) -- Line: 68 -- upvalues: u72 (val), u73 (val), u74 (val), IsDoubleXP (val), StackableDoubleXP (val), IsWeekend (val), u79 (ref), Earnings_2 (val), u80 (ref), u78 (ref), u77 (ref), Template (val), Items (val)
    local v1, v2
    if not p1.Type then
        return
    end
    if p1.Type == "LevelUpClass" then
        table.insert(u72, {Class = p1.Class, Level = p1.Level, ZBucks = p1.ZBucks})
        runQueue()
        return
    end
    if p1.Type == "LevelUpWeapon" then
        table.insert(u73, {WeaponID = p1.ID, Level = p1.Level})
        runQueue()
        return
    end
    if p1.Type == "UnlockedWeapon" then
        table.insert(u74, {WeaponID = p1.ID})
        runQueue()
        return
    end
    if p1.Type ~= "XPEarned" then
        if p1.Type == "AddXPItem" then
            u77 = u77 + 1
            v1 = Template:Clone()
            v1.LayoutOrder = -u77
            local Reason = v1:WaitForChild("Reason")
            Reason.Text = p1.Reason
            if p1.Color then
                v1.Reason.TextColor3 = p1.Color
            end
            v1.Parent = Items
            v1.Visible = true
            v2 = UDim2.new(0, 0, 0, 0)
            v1.Reason:TweenPosition(v2, "Out", "Quad", 0.25, true)
            task.wait(3)
            v2 = UDim2.new(0, 0, 1, 0)
            v1.Reason:TweenPosition(v2, "Out", "Quad", 0.25, true)
            task.wait(0.25)
            v1:Destroy()
        end
        return
    end
    v1 = "XP"
    if IsDoubleXP and IsDoubleXP.Value then
        if not StackableDoubleXP then
            v1 = "XP (x2)"
        elseif StackableDoubleXP.Value and IsWeekend and IsWeekend.Value then
            v1 = "XP (x4)"
        end
    end
    if not u79 then
        u79 = 0
    end
    u79 = u79 + p1.AddedXP
    Earnings_2.XP.Text = ("+%d %s"):format(u79, v1)
    v2 = UDim2.new(0.35, 0, 0.05, 0)
    Earnings_2:TweenSize(v2, "Out", "Quad", 0.25, true)
    local v3 = math.floor(tick() * 1000)
    u80 = v3
    task.wait(3)
    if u80 ~= v3 then
        return
    end
    u78 = nil
    u79 = nil
    local v4 = UDim2.new(0, 0, 0.05, 0)
    Earnings_2:TweenSize(v4, "Out", "Quad", 0.25, true)
end)
function runQueue() -- Line: 132 -- upvalues: u75 (ref), u72 (val), ContentFrame (val), u76 (val), ClipFrame (val), u74 (val), ItemData (val), ContentFrame_2 (val), ClipFrame_2 (val), u73 (val)
    if not u75 then
        local Name, Name_2, v1, v2, v3, v4, v5
        u75 = true
        while true do
            v1 = #u72
            if 0 < v1 then
                script.LevelUp:Play()
                v1 = u72[1]
                ContentFrame.ClassIcon.Image = u76[v1.Class]
                v3 = string.upper(v1.Class)
                ContentFrame.Class.Text = ("%s LEVEL %d!"):format(v3, v1.Level)
                ContentFrame.ZB.Text = ("+ %d Z$"):format(v1.ZBucks)
                v2 = UDim2.new(0.7, 0, 0.14, 0)
                ClipFrame:TweenSize(v2, "Out", "Quad", 0.2, true)
                task.wait(3)
                v2 = UDim2.new(0.7, 0, 0, 0)
                ClipFrame:TweenSize(v2, "Out", "Quad", 0.2, true)
                task.wait(0.25)
                table.remove(u72, 1)
            end
            v1 = #u74
            if 0 < v1 then
                script.LevelUp:Play()
                Name = ItemData.List[u74[1].WeaponID].Name
                ContentFrame_2.WeaponImage.ImageLabel.Image = "rbxgameasset://Images/" .. Name
                ContentFrame_2.LevelLabel.Text = ("%s UNLOCKED!"):format(string.upper(Name))
                v4 = UDim2.new(0.6, 0, 0.12, 0)
                ClipFrame_2:TweenSize(v4, "Out", "Quad", 0.2, true)
                task.wait(3)
                v4 = UDim2.new(0.6, 0, 0, 0)
                ClipFrame_2:TweenSize(v4, "Out", "Quad", 0.2, true)
                task.wait(0.25)
                table.remove(u74, 1)
            end
            v1 = #u73
            if 0 < v1 then
                script.LevelUp:Play()
                v1 = u73[1]
                Name_2 = ItemData.List[v1.WeaponID].Name
                ContentFrame_2.WeaponImage.ImageLabel.Image = "rbxgameasset://Images/" .. Name_2
                v5 = string.upper(Name_2)
                ContentFrame_2.LevelLabel.Text = ("%s LEVEL %d!"):format(v5, v1.Level)
                v4 = UDim2.new(0.6, 0, 0.12, 0)
                ClipFrame_2:TweenSize(v4, "Out", "Quad", 0.2, true)
                task.wait(3)
                v4 = UDim2.new(0.6, 0, 0, 0)
                ClipFrame_2:TweenSize(v4, "Out", "Quad", 0.2, true)
                task.wait(0.25)
                table.remove(u73, 1)
            end
            if #u72 == 0 then
                if #u74 ~= 0 then end
                if #u73 == 0 then
                    break
                end
            end
        end
        u75 = false
    end
end
return u102