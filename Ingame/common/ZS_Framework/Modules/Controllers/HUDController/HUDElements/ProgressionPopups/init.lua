local RedEvents = game.ReplicatedStorage.common.RedEvents
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
local common = game.ReplicatedStorage.common
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
local ItemData = require(common.ItemData)
local ProgressionEvent = require(RedEvents.General.ProgressionEvent)
local u72 = {}
local u73 = {}
local u74 = {}
local u75 = false
local u76 = {
    Assault = "rbxassetid://4458718282",
    Medic = "rbxassetid://2706886795",
    Support = "rbxassetid://2706886028",
    Sniper = "rbxassetid://4458692655",
}
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

ProgressionEvent:SetClientListener(function(p1) -- Line: 68
    -- upvalues: u72 (val), u73 (val), u74 (val), IsDoubleXP (val), StackableDoubleXP (val), IsWeekend (val), u79 (ref)
    -- upvalues: Earnings_2 (val), u80 (ref), u78 (ref), u77 (ref), Template (val), Items (val)
    if p1.Type then
        local v1, v2, v3, v4
        if p1.Type == "LevelUpClass" then
            v2 = u72
            v3 = {Class = p1.Class, Level = p1.Level, ZBucks = p1.ZBucks}
            table.insert(v2, v3)
            runQueue()
            return
        end
        if p1.Type == "LevelUpWeapon" then
            v2 = u73
            v3 = {WeaponID = p1.ID, Level = p1.Level}
            table.insert(v2, v3)
            runQueue()
            return
        end
        if p1.Type == "UnlockedWeapon" then
            v2 = u74
            v3 = {WeaponID = p1.ID}
            table.insert(v2, v3)
            runQueue()
            return
        end
        if p1.Type == "XPEarned" then
            v1 = "XP"
            if IsDoubleXP and IsDoubleXP.Value then
                if not StackableDoubleXP or not StackableDoubleXP.Value or not IsWeekend or not IsWeekend.Value then
                    v1 = "XP (x2)"
                else
                    v1 = "XP (x4)"
                end
            end
            if not u79 then
                u79 = 0
            end
            u79 = u79 + p1.AddedXP
            v2 = Earnings_2
            local XP = v2.XP
            local v5 = u79
            XP.Text = ("+%d %s"):format(v5, v1)
            v2 = Earnings_2
            v4 = UDim2.new(0.35, 0, 0.05, 0)
            v2:TweenSize(v4, "Out", "Quad", 0.25, true)
            v3 = (tick()) * 1000
            v2 = math.floor(v3)
            u80 = v2
            task.wait(3)
            if u80 == v2 then
                u78 = nil
                u79 = nil
                v3 = Earnings_2
                v5 = UDim2.new(0, 0, 0.05, 0)
                v3:TweenSize(v5, "Out", "Quad", 0.25, true)
                return
            end
        elseif p1.Type == "AddXPItem" then
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
            local Reason_2 = v1.Reason
            v4 = UDim2.new(0, 0, 0, 0)
            Reason_2:TweenPosition(v4, "Out", "Quad", 0.25, true)
            task.wait(3)
            local Reason_3 = v1.Reason
            v4 = UDim2.new(0, 0, 1, 0)
            Reason_3:TweenPosition(v4, "Out", "Quad", 0.25, true)
            task.wait(0.25)
            v1:Destroy()
        end
    end
end)

function runQueue() -- Line: 132
    -- upvalues: u75 (ref), u72 (val), ContentFrame (val), u76 (val), ClipFrame (val), u74 (val), ItemData (val)
    -- upvalues: ContentFrame_2 (val), ClipFrame_2 (val), u73 (val)
    if not u75 then
        local Class, Level, LevelLabel, LevelLabel_2, Level_2, Name, Name_2, ZB, ZBucks, v1, v2, v3, v4, v5, v6, v7
        u75 = true
        repeat
            v1 = #u72
            if 0 < v1 then
                script.LevelUp:Play()
                v1 = u72[1]
                ContentFrame.ClassIcon.Image = u76[v1.Class]
                v2 = ContentFrame
                Class = v2.Class
                v5 = string.upper(v1.Class)
                Level = v1.Level
                Class.Text = ("%s LEVEL %d!"):format(v5, Level)
                v2 = ContentFrame
                ZB = v2.ZB
                ZBucks = v1.ZBucks
                ZB.Text = ("+ %d Z$"):format(ZBucks)
                v2 = ClipFrame
                v4 = UDim2.new(0.7, 0, 0.14, 0)
                v2:TweenSize(v4, "Out", "Quad", 0.2, true)
                task.wait(3)
                v2 = ClipFrame
                v4 = UDim2.new(0.7, 0, 0, 0)
                v2:TweenSize(v4, "Out", "Quad", 0.2, true)
                task.wait(0.25)
                table.remove(u72, 1)
            end
            v1 = #u74
            if 0 < v1 then
                script.LevelUp:Play()
                v2 = u74
                v1 = v2[1]
                Name = ItemData.List[v1.WeaponID].Name
                v3 = "rbxgameasset://Images/" .. Name
                ContentFrame_2.WeaponImage.ImageLabel.Image = v3
                v4 = ContentFrame_2
                LevelLabel = v4.LevelLabel
                v7 = string.upper(Name)
                LevelLabel.Text = ("%s UNLOCKED!"):format(v7)
                v4 = ClipFrame_2
                v6 = UDim2.new(0.6, 0, 0.12, 0)
                v4:TweenSize(v6, "Out", "Quad", 0.2, true)
                task.wait(3)
                v4 = ClipFrame_2
                v6 = UDim2.new(0.6, 0, 0, 0)
                v4:TweenSize(v6, "Out", "Quad", 0.2, true)
                task.wait(0.25)
                table.remove(u74, 1)
            end
            v1 = #u73
            if 0 < v1 then
                script.LevelUp:Play()
                v1 = u73[1]
                Name_2 = ItemData.List[v1.WeaponID].Name
                v3 = "rbxgameasset://Images/" .. Name_2
                ContentFrame_2.WeaponImage.ImageLabel.Image = v3
                v4 = ContentFrame_2
                LevelLabel_2 = v4.LevelLabel
                v7 = string.upper(Name_2)
                Level_2 = v1.Level
                LevelLabel_2.Text = ("%s LEVEL %d!"):format(v7, Level_2)
                v4 = ClipFrame_2
                v6 = UDim2.new(0.6, 0, 0.12, 0)
                v4:TweenSize(v6, "Out", "Quad", 0.2, true)
                task.wait(3)
                v4 = ClipFrame_2
                v6 = UDim2.new(0.6, 0, 0, 0)
                v4:TweenSize(v6, "Out", "Quad", 0.2, true)
                task.wait(0.25)
                table.remove(u73, 1)
            end
        until #u72 == 0 and #u74 == 0 and #u73 == 0
        u75 = false
    end
end

return u102