local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local NPCs_Shared = ReplicatedStorage.common:WaitForChild("NPCs_Shared")
local PartCache = require(ReplicatedStorage.common.PartCache)
local u21 = require("@game/ReplicatedStorage/common/Settings")
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local u32 = nil
local v1 = {}
local function initializeCache() -- Line: 20 -- upvalues: peek (val), u21 (val), u32 (ref), NPCs_Shared (val), PartCache (val)
    if peek(u21.Graphics.DisplayDamageIndicators) and not u32 then
        u32 = PartCache.new(NPCs_Shared.Resources.Misc.DamagePart, 100, workspace.Ignore)
    end
end
function v1.Init() -- Line: 27 -- upvalues: peek (val), u21 (val), u32 (ref), NPCs_Shared (val), PartCache (val)
    if peek(u21.Graphics.DisplayDamageIndicators) and not u32 then
        u32 = PartCache.new(NPCs_Shared.Resources.Misc.DamagePart, 100, workspace.Ignore)
    end
end
function v1.Display(p1, p2) -- Line: 31 -- upvalues: u32 (ref), peek (val), u21 (val), TweenService (val)
    if not u32 or not (peek(u21.Graphics.DisplayDamageIndicators)) then
        return
    end
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
    local v2 = workspace.CurrentCamera.CFrame.lookVector:Cross((Vector3.new(0, 1, 0)))
    local v3 = v2 * (0.25 * (math.random(200) / 100))
    local v4 = 0.5 + math.random(100) / 100
    local v5 = Vector3.new(0, v4, 0)
    local v6 = TweenInfo.new(0.25, Enum.EasingStyle.Back)
    TweenService:Create(Part, v6, {Position = Position + v3 + v5}):Play()
    v6 = TweenInfo.new(0.2)
    v4 = TweenService:Create(DamageText, v6, {TextTransparency = 0, TextStrokeTransparency = 0})
    v4:Play()
    v4.Completed:Connect(function(p1) -- Line: 66 -- upvalues: TweenService (upval), DamageText (val), u32 (upval), Part (val)
        task.wait(2)
        local v1 = TweenInfo.new(1)
        local v2 = TweenService:Create(DamageText, v1, {TextTransparency = 1, TextStrokeTransparency = 1})
        v2:Play()
        v2.Completed:Wait()
        u32:ReturnPart(Part)
    end)
end
return v1