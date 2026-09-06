local TweenService = game:GetService("TweenService")
local v1 = {}
local function SoundCreator(p1) -- Line: 5
    local Sound = Instance.new("Sound")
    local v1 = p1
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        Sound[i] = j
    end
    if string.find(Sound.SoundId, "rbxassetid://") then
        v1 = ""
    else
        v1 = "rbxassetid://"
    end
    Sound.SoundId = v1 .. Sound.SoundId
    return Sound
end
function v1.Init(p1, p2) -- Line: 15
    local Config = p2.Config
    local Sound = Instance.new("Sound")
    local v1 = Config.Shooting_Start
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        Sound[i] = j
    end
    if string.find(Sound.SoundId, "rbxassetid://") then
        v1 = ""
    else
        v1 = "rbxassetid://"
    end
    Sound.SoundId = v1 .. Sound.SoundId
    p2.StartSFX = Sound
    local Sound_2 = Instance.new("Sound")
    v1 = Config.Shooting_Loop
    v2 = nil
    v3 = nil
    for k, n in v1, v2, v3 do
        Sound_2[k] = n
    end
    if string.find(Sound_2.SoundId, "rbxassetid://") then
        v1 = ""
    else
        v1 = "rbxassetid://"
    end
    Sound_2.SoundId = v1 .. Sound_2.SoundId
    p2.LoopSFX = Sound_2
    local Sound_3 = Instance.new("Sound")
    v1 = Config.Shooting_End
    v2 = nil
    v3 = nil
    for m, i5 in v1, v2, v3 do
        Sound_3[m] = i5
    end
    if string.find(Sound_3.SoundId, "rbxassetid://") then
        v1 = ""
    else
        v1 = "rbxassetid://"
    end
    Sound_3.SoundId = v1 .. Sound_3.SoundId
    p2.EndSFX = Sound_3
    while true do
        task.wait()
        if p2.Viewmodel.Model then
            break
        end
    end
    local Handle = p2.Viewmodel.Model.KeyParts.Handle
    p2.StartSFX.Parent = Handle
    p2.LoopSFX.Parent = Handle
    p2.EndSFX.Parent = Handle
end
function v1.Start(p1, p2) -- Line: 30 -- upvalues: TweenService (val)
    if not p2.LoopSFX_Playing then
        local Min
        p2.LoopSFX_Playing = true
        local LoopSFX = p2.LoopSFX
        if not p2.Config.Shooting_Loop.PlaybackRegion then
            Min = 0
        else
            Min = p2.Config.Shooting_Loop.PlaybackRegion.Min
            if not Min then
                Min = 0
            end
        end
        LoopSFX.TimePosition = Min
        p2.StartSFX.TimePosition = p2.Config.Shooting_Start.PlaybackRegion.Min
        p2.StartSFX.Volume = p2.Config.Shooting_Start.Volume or 0.5
        p2.LoopSFX.Volume = p2.Config.Shooting_Loop.Volume or 0.5
        local v1 = TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        TweenService:Create(p2.StartSFX, v1, {Volume = p2.StartSFX.Volume}):Play()
        v1 = TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        TweenService:Create(p2.LoopSFX, v1, {Volume = p2.LoopSFX.Volume}):Play()
        p2.LoopSFX:Play()
        p2.StartSFX:Play()
    end
end
function v1.Stop(p1, p2) -- Line: 44 -- upvalues: TweenService (val)
    if p2.LoopSFX_Playing then
        p2.LoopSFX_Playing = false
        local v1 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        TweenService:Create(p2.StartSFX, v1, {Volume = 0}):Play()
        v1 = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        TweenService:Create(p2.LoopSFX, v1, {Volume = 0}):Play()
        p2.EndSFX.TimePosition = p2.Config.Shooting_End.PlaybackRegion.Min
        p2.EndSFX:Play()
    end
end
return v1