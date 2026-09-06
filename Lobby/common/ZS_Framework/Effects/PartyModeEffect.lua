local u31, u32
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
u31, u32 = require(ReplicatedStorage.Packages.Bin)()
local function togglePartyMode() -- Line: 14 -- upvalues: GameState (val), u32 (val), SoundService (val), u31 (val), Lighting (val), RunService (val)
    u32()
    if not GameState.Data.Variables.PartyModeEnabled then
        return
    end
    local Primary = SoundService:WaitForChild("Primary")
    local Music = Primary:WaitForChild("Music")
    local u19 = u31(Instance.new("SoundGroup"))
    u19.Name = "PartyModeMusicGroup"
    u19.Volume = Music:GetAttribute("Volume") or 1
    u19.Parent = Primary
    local AttributeChangedSignal = Music:GetAttributeChangedSignal("Volume")
    u31(AttributeChangedSignal:Connect(function() -- Line: 31 -- upvalues: u19 (val), Music (val)
        u19.Volume = Music:GetAttribute("Volume") or 1
    end))
    local v1 = u31(Instance.new("Sound"))
    v1.Name = "PartyModeMusic"
    v1.SoundId = "rbxassetid://80336684189373"
    v1.Looped = true
    v1.Volume = 1
    v1.SoundGroup = u19
    v1.Parent = SoundService
    v1.Playing = true
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection")
    if not ColorCorrection then
        ColorCorrection = Instance.new("ColorCorrectionEffect")
        ColorCorrection.Parent = Lighting
    end
    local u57 = {R = 255, G = 255, B = 255}
    local u58 = nil
    local u59 = "Exclude"
    local u60 = nil
    local u61 = 1
    local u62 = 0.25
    local function updateFormula() -- Line: 84 -- upvalues: u61 (ref)
        return CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, u61)
    end
    u31(RunService.RenderStepped:Connect(function(p1) -- Line: 88 -- upvalues: u58 (ref), u60 (ref), u57 (val), u59 (ref), u61 (ref), u62 (ref), ColorCorrection (ref)
        local v1, v2, v3
        local CurrentCamera = workspace.CurrentCamera
        if not u58 then
            u60 = -1
            v1 = {}
            v2 = u57
            v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                table.insert(v1, i)
            end
            if math.random(1, 2) ~= 1 then
                u59 = "Include"
            else
                u59 = "Exclude"
            end
            u58 = v1[math.random(#v1)]
        end
        u61 = math.clamp(u61 + u60 * 0.4705882352941176 * p1, 0.9, 1)
        CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, u61)
        v2 = u62 + u60 * -1 * 3.5294117647058822 * p1
        u62 = math.clamp(v2, 0.25, 1)
        if u59 ~= "Exclude" then
            u57[u58] = math.clamp(u57[u58] + u60 * 1200 * p1, 0, 255)
            v1 = u57[u58]
            if v1 > 0 then
                v1 = u57[u58]
                if 255 <= v1 then
                    u60 = -1
                    u58 = nil
                end
            else
                u60 = 1
            end
        else
            v1 = u57
            v2 = nil
            v3 = nil
            for k, n in v1, v2, v3 do
                if k ~= u58 then
                    u57[k] = math.clamp(n + u60 * 1200 * p1, 0, 255)
                end
            end
            v1 = u57
            v2 = nil
            v3 = nil
            for m, i5 in v1, v2, v3 do
                if m ~= u58 then
                    if i5 <= 0 then
                        u60 = 1
                    elseif 255 <= i5 then
                        u60 = -1
                        u58 = nil
                    end
                end
            end
        end
        ColorCorrection.TintColor = Color3.fromRGB(u57.R, u57.G, u57.B)
        ColorCorrection.Saturation = u62
    end))
end
task.spawn(function() -- Line: 149 -- upvalues: Lighting (val), togglePartyMode (val)
    Lighting:WaitForChild("ColorCorrection", 10)
    togglePartyMode()
end)
GameState.Signals.Variables.PartyModeEnabled:Connect(togglePartyMode)
return {}