local v1 = {}
local EggTouched = require(game.ReplicatedStorage.common.RedEvents.Events.EggTouched)
local StarterGui = game:GetService("StarterGui")
local u16 = require("@game/ReplicatedStorage/common/Events/Easter2025/EggData")
local function makeThumbUrl(p1) -- Line: 7
    local v1 = tonumber(p1:match("%d+"))
    if not v1 then
        return ""
    end
    return ("rbxthumb://type=Asset&id=%d&w=150&h=150"):format(v1)
end
local function eggTouchRegistered(p1) -- Line: 15 -- upvalues: u16 (val), StarterGui (val)
    local v1, v2
    local v3 = tonumber(u16.EggConfigs[p1].ImageId:match("%d+"))
    if v3 then
        v2 = ("rbxthumb://type=Asset&id=%d&w=150&h=150"):format(v3)
    else
        v2 = ""
    end
    if p1 ~= "Master" then
        v1 = p1
    else
        v1 = "the Master Egg"
    end
    local Sound = Instance.new("Sound")
    Sound.Parent = game.Workspace
    Sound.SoundId = "rbxassetid://1211938342"
    Sound.Volume = 1
    Sound:Play()
    Sound.Ended:Connect(function() -- Line: 28 -- upvalues: Sound (val)
        Sound:Destroy()
    end)
    print("Client: Egg touched for chapter " .. v1 .. ". Complete the chapter to claim your badge!")
    StarterGui:SetCore("SendNotification", {Title = "Egg Collected!", Duration = 10, Text = "Please complete the chapter to claim your badge and skin for " .. v1, Icon = v2})
end
EggTouched:SetClientListener(function(p1) -- Line: 40 -- upvalues: eggTouchRegistered (val)
    eggTouchRegistered(p1)
end)
return v1