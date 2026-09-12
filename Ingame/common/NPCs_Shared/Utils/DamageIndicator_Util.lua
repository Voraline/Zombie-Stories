local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local PartCache = require(ReplicatedStorage.common.PartCache)
local u21 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local u32 = nil
local v1 = {}

local function initializeCache() -- Line: 20
    -- upvalues: peek (val), u21 (val), u32 (ref), NPCs_Shared (val), PartCache (val)
    if peek(u21.Graphics.DisplayDamageIndicators) and not u32 then
        local v1 = NPCs_Shared
        local DamagePart = v1.Resources.Misc.DamagePart
        u32 = PartCache.new(DamagePart, 100, workspace.Ignore)
    end
end

function v1.Init() -- Line: 27 -- upvalues: peek (val), u21 (val), u32 (ref), NPCs_Shared (val), PartCache (val)
    if peek(u21.Graphics.DisplayDamageIndicators) and not u32 then
        local v1 = NPCs_Shared
        local DamagePart = v1.Resources.Misc.DamagePart
        u32 = PartCache.new(DamagePart, 100, workspace.Ignore)
    end
end

function v1.Display(p1, p2) -- Line: 31 -- upvalues: u32 (ref), peek (val), u21 (val), TweenService (val)
    if u32 and peek(u21.Graphics.DisplayDamageIndicators) then
        local Position = p1.Position
        local v1 = string.find(p1.Name, "Head")
        local Part = u32:GetPart()
        local DamageText = Part:FindFirstChild("DamageText", true)
        DamageText.Text = string.format("%.2f", p2)
        DamageText.TextTransparency = 1
        DamageText.TextStrokeTransparency = 1
        if not v1 then
            DamageText.Size = UDim2.fromScale(0.65, 0.65)
            DamageText.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            DamageText.Size = UDim2.fromScale(0.78, 0.78)
            DamageText.TextColor3 = Color3.fromRGB(255, 71, 71)
        end
        Part.Position = Position
        local v2 = (workspace.CurrentCamera.CFrame.lookVector:Cross((Vector3.new(0, 1, 0)))) * (0.25 * (math.random(200) / 100))
        local v3 = 0.5 + math.random(100) / 100
        local v4 = Vector3.new(0, v3, 0)
        local v5 = Position + v2 + v4
        v3 = TweenService
        local v6 = TweenInfo.new(0.25, Enum.EasingStyle.Back)
        local v7 = {Position = v5}
        v3:Create(Part, v6, v7):Play()
        v3 = TweenService
        v6 = TweenInfo.new(0.2)
        v3 = v3:Create(DamageText, v6, {TextTransparency = 0, TextStrokeTransparency = 0})
        v3:Play()
        v3.Completed:Connect(function(p1) -- Line: 67 -- upvalues: TweenService (upval), DamageText (val), u32 (upval), Part (val)
            task.wait(2)
            local v1 = TweenService
            local v2 = DamageText
            local v3 = TweenInfo.new(1)
            v1 = v1:Create(v2, v3, {TextTransparency = 1, TextStrokeTransparency = 1})
            v1:Play()
            v1.Completed:Wait()
            local v4 = u32
            v3 = Part
            v4:ReturnPart(v3)
        end)
        return
    end
end

return v1