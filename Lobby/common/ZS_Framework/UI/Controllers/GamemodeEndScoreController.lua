local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u21 = require("../../Data/PlayerDatabase")
local u24 = require("../Components/Arcade/GamemodeEndScoreboard")
local v1 = require("@game/ReplicatedStorage/common/zap")
local u29 = nil

local function closeScoreboard() -- Line: 15 -- upvalues: u29 (ref)
    if not u29 then
        return
    end
    local v1 = {}
    local v2 = u29
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1[i] = j
    end
    u29 = nil
    v1.closeFunction()
    task.wait(10)
    v1.scope:doCleanup()
end

v1.OpenGamemodeEndScoreboard.On(function(p1) -- Line: 33
    -- upvalues: closeScoreboard (val), Fusion (val), Players (val), SoundService (val), u21 (val), u24 (val), u29 (ref)
    local Image, v1
    closeScoreboard()
    local u6 = Fusion.scoped(Fusion)
    local Players_2 = p1.Players
    local v2 = nil
    local v3 = nil
    for i, j in Players_2, v2, v3 do
        Image = j.Image
        j.Image = u6:Value(Image or "")
        task.spawn(function() -- Line: 40 -- upvalues: u6 (val), j (val), Players (upval)
            if u6.peek(j.Image) == "" then
                local v1 = j.UserId or 1583746009
                if v1 <= 0 then
                    v1 = 1583746009
                end
                local v2 = j
                local Image = v2.Image
                local v3 = Players
                local HeadShot = Enum.ThumbnailType.HeadShot
                local Size100x100 = Enum.ThumbnailSize.Size100x100
                local UserThumbnailAsync = v3:GetUserThumbnailAsync(v1, HeadShot, Size100x100)
                Image:set(UserThumbnailAsync)
            end
        end)
    end
    v2 = u6:New("ScreenGui")({IgnoreGuiInset = true, Parent = u21.PlayerGui, ScreenInsets = Enum.ScreenInsets.None})
    v3 = u24
    _, v1 = v3({
        scope = u6,
        Players = p1.Players,
        target = v2,
        PlaySound = function(p1) -- Line: 54 -- upvalues: SoundService (upval)
            local Sound = Instance.new("Sound")
            Sound.SoundId = "rbxasset://sounds/action_jump.mp3"
            Sound.Volume = 0.5
            Sound.Parent = SoundService
            Sound.Playing = true
            Sound.PlaybackSpeed = math.random(800, 1200) / 1000
            local PitchShiftSoundEffect = Instance.new("PitchShiftSoundEffect")
            PitchShiftSoundEffect.Octave = math.random(700, 850) / 1000
            PitchShiftSoundEffect.Parent = Sound
            Sound.Ended:Connect(function() -- Line: 68 -- upvalues: Sound (val)
                Sound:Destroy()
            end)
        end,
    })
    u29 = {scope = u6, closeFunction = v1}
end)
v1.CloseGamemodeEndScoreboard.On(function(p1) -- Line: 94 -- upvalues: closeScoreboard (val)
    closeScoreboard()
end)
return {}