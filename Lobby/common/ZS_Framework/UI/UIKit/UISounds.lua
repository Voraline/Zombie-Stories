local u104, u124, u24, u44, u64, u84
local SoundService = game:GetService("SoundService")

local function getOrCreate(p1, p2, p3) -- Line: 5 -- upvalues: SoundService (val)
    local v1 = SoundService:FindFirstChild(p1)
    if v1 and v1:IsA("Sound") then
        v1.SoundId = p2
        v1.Volume = p3
        return v1
    end
    local Sound = Instance.new("Sound")
    Sound.Name = p1
    Sound.SoundId = p2
    Sound.Volume = p3
    Sound.Parent = SoundService
    return Sound
end

local UIKitHover = SoundService:FindFirstChild("UIKitHover")
if not UIKitHover or not UIKitHover:IsA("Sound") then
    local Sound = Instance.new("Sound")
    Sound.Name = "UIKitHover"
    Sound.SoundId = "rbxassetid://103003970474571"
    Sound.Volume = 0.12
    Sound.Parent = SoundService
    u24 = Sound
else
    UIKitHover.SoundId = "rbxassetid://103003970474571"
    UIKitHover.Volume = 0.12
    u24 = UIKitHover
end
local UIKitClick = SoundService:FindFirstChild("UIKitClick")
if not UIKitClick or not UIKitClick:IsA("Sound") then
    local Sound_2 = Instance.new("Sound")
    Sound_2.Name = "UIKitClick"
    Sound_2.SoundId = "rbxassetid://129190194679291"
    Sound_2.Volume = 0.3
    Sound_2.Parent = SoundService
    u44 = Sound_2
else
    UIKitClick.SoundId = "rbxassetid://129190194679291"
    UIKitClick.Volume = 0.3
    u44 = UIKitClick
end
local UIKitClose = SoundService:FindFirstChild("UIKitClose")
if not UIKitClose or not UIKitClose:IsA("Sound") then
    local Sound_3 = Instance.new("Sound")
    Sound_3.Name = "UIKitClose"
    Sound_3.SoundId = "rbxassetid://92617871621489"
    Sound_3.Volume = 0.3
    Sound_3.Parent = SoundService
    u64 = Sound_3
else
    UIKitClose.SoundId = "rbxassetid://92617871621489"
    UIKitClose.Volume = 0.3
    u64 = UIKitClose
end
local UIKitPurchasePrompt = SoundService:FindFirstChild("UIKitPurchasePrompt")
if not UIKitPurchasePrompt or not UIKitPurchasePrompt:IsA("Sound") then
    local Sound_4 = Instance.new("Sound")
    Sound_4.Name = "UIKitPurchasePrompt"
    Sound_4.SoundId = "rbxassetid://117007205708961"
    Sound_4.Volume = 0.3
    Sound_4.Parent = SoundService
    u84 = Sound_4
else
    UIKitPurchasePrompt.SoundId = "rbxassetid://117007205708961"
    UIKitPurchasePrompt.Volume = 0.3
    u84 = UIKitPurchasePrompt
end
local UIKitReward = SoundService:FindFirstChild("UIKitReward")
if not UIKitReward or not UIKitReward:IsA("Sound") then
    local Sound_5 = Instance.new("Sound")
    Sound_5.Name = "UIKitReward"
    Sound_5.SoundId = "rbxassetid://4612378086"
    Sound_5.Volume = 0.5
    Sound_5.Parent = SoundService
    u104 = Sound_5
else
    UIKitReward.SoundId = "rbxassetid://4612378086"
    UIKitReward.Volume = 0.5
    u104 = UIKitReward
end
local UIKitError = SoundService:FindFirstChild("UIKitError")
if not UIKitError or not UIKitError:IsA("Sound") then
    local Sound_6 = Instance.new("Sound")
    Sound_6.Name = "UIKitError"
    Sound_6.SoundId = "rbxassetid://97329712338974"
    Sound_6.Volume = 0.35
    Sound_6.Parent = SoundService
    u124 = Sound_6
else
    UIKitError.SoundId = "rbxassetid://97329712338974"
    UIKitError.Volume = 0.35
    u124 = UIKitError
end
return {
    HoverSound = u24,
    ClickSound = u44,
    CloseSound = u64,
    PurchaseSound = u84,
    RewardSound = u104,
    ErrorSound = u124,
    Hover = function() -- Line: 36 -- upvalues: u24 (val)
        u24:Play()
    end,
    Click = function() -- Line: 39 -- upvalues: u44 (val)
        u44:Play()
    end,
    Close = function() -- Line: 42 -- upvalues: u64 (val)
        u64:Play()
    end,
    Purchase = function() -- Line: 45 -- upvalues: u84 (val)
        u84:Play()
    end,
    Reward = function() -- Line: 48 -- upvalues: u104 (val)
        u104:Play()
    end,
    Error = function() -- Line: 51 -- upvalues: u124 (val)
        u124:Play()
    end,
}