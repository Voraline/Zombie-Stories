local v1 = {
    DrawAnimation = "Equip",
    DrawAnimationTime = 0,
    KeyFrameSounds = {
        rotate1 = {SoundId = "9119714273", Volume = 0.5},
        rotate2 = {SoundId = "9119714273", Volume = 0.5},
        rotate3 = {SoundId = "9119714461", Volume = 0.5},
        brushEnd_slide = {SoundId = "9116197246", Volume = 0.5},
        swing_start = {SoundId = "6230943001", Volume = 0.5},
    },
}
local v2 = CFrame.new(0, -1.7, 0)
v1.BlockOffset = v2 * CFrame.Angles(1.1423973285781066, 0, -1.5707963267948966)
return v1