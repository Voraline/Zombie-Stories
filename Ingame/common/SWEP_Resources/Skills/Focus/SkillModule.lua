local v1 = {ActivateType = "Use"}
local RunService = game:GetService("RunService")
local Remotes = game:GetService("ReplicatedStorage").common:WaitForChild("Remotes")
local Net = Remotes:WaitForChild("Net")
local Resources = script.Parent:WaitForChild("Resources")
if not (RunService:IsClient()) then
    return v1
end
function v1.Init(p1, p2, p3) -- Line: 10 -- upvalues: Resources (val), Net (val)
    local u11 = script.Parent:WaitForChild("DashGui"):Clone()
    u11.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local SoundService = game:GetService("SoundService")
    local ColorCorrection = Resources.ColorCorrection
    local AmbientReverb = SoundService.AmbientReverb
    ColorCorrection.Parent = game.Lighting
    local u33 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local Frame = p1:WaitForChild("Frame")
    local UseBar = Frame:WaitForChild("UseBar")
    local u45 = Frame:waitForChild("Tactical")
    local PlayerScripts = game.Players.LocalPlayer:WaitForChild("PlayerScripts")
    PlayerScripts:WaitForChild("FrameworkEvent")
    local Remotes = game.ReplicatedStorage.common:WaitForChild("Remotes")
    local Focus = Remotes:WaitForChild("Focus")
    local Value = workspace:WaitForChild("InitialFocus").Value
    local u74 = false
    local u75 = false
    local function FocusUpdate() -- Line: 39 -- upvalues: u74 (ref), UseBar (val), Value (ref), p3 (val), u45 (val), u75 (ref), SoundService (val), Resources (upval), p2 (val)
        if u74 ~= false then
            return
        end
        local v1 = UDim2.new(Value / 1, 0, 0.75, 0)
        UseBar:TweenSize(v1, "Out", "Linear", 0.1, false)
        if 1 > Value then
            p3("red")
            p2("FOCUS: NOT READY")
            u75 = false
            return
        end
        p3("white")
        if u45.Text ~= "FOCUS: READY [<FInstruction>]" and u75 == false then
            SoundService:PlayLocalSound(Resources.Recharge)
            u75 = true
        end
        p2("FOCUS: READY [<FInstruction>]")
    end
    Net.OnClientEvent:connect(function(p1, p2) -- Line: 59 -- upvalues: Value (ref), FocusUpdate (val), u74 (ref), u11 (val), UseBar (val), Resources (upval), SoundService (val), ColorCorrection (val), u33 (val), AmbientReverb (ref)
        if p1 == "f" then
            Value = p2
            FocusUpdate()
            return
        end
        if p1 == "FocusEnded" then
            u74 = false
            u11.On.Value = false
            local v1 = UDim2.new(0, 0, 0.75, 0)
            UseBar:TweenSize(v1, "Out", "Linear", 0, true)
            FocusUpdate()
            Resources.Focus:Stop()
            SoundService:PlayLocalSound(Resources.FocusEnd)
            game:GetService("TweenService"):Create(ColorCorrection, u33, {TintColor = Color3.new(1, 1, 1)}):Play()
            SoundService.AmbientReverb = AmbientReverb
        end
    end)
    return function(p1) -- Line: 77 -- upvalues: FocusUpdate (val)
        FocusUpdate()
    end, function() -- Line: 80 -- upvalues: Value (ref), Focus (val), u74 (ref), u11 (val), UseBar (val), p2 (val), Resources (upval), SoundService (val), ColorCorrection (val), u33 (val), AmbientReverb (ref)
        if 1 <= Value then
            local v1, v2
            v1, v2 = Focus:InvokeServer()
            if v1 then
                u74 = true
                Value = 0
                u11.On.Value = true
                local v3 = UDim2.new(0, 0, 0.75, 0)
                UseBar:TweenSize(v3, "Out", "Linear", v2, true)
                p2("FOCUS: ACTIVE")
                Resources.Focus:Play()
                SoundService:PlayLocalSound(Resources.FocusActive)
                task.delay(0.7, function() -- Line: 92 -- upvalues: SoundService (upval), Resources (upval)
                    SoundService:PlayLocalSound(Resources.FocusActive2)
                end)
                game:GetService("TweenService"):Create(ColorCorrection, u33, {TintColor = Color3.fromRGB(202, 197, 255)}):Play()
                AmbientReverb = SoundService.AmbientReverb
                SoundService.AmbientReverb = "Hangar"
            end
        end
    end
end
return v1