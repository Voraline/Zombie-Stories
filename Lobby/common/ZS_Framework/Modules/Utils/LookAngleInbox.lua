local Players = game:GetService("Players")
local v1 = (require(script.Parent.LatestLookAngles)).new(function(p1) -- Line: 3 -- upvalues: Players (val)
    local v1 = p1.Parent == Players
    return v1
end)
local PlayerRemoving = Players.PlayerRemoving
local Remove = v1.Remove
PlayerRemoving:Connect(Remove)
require("@game/ReplicatedStorage/common/zap").LookAngleEvent.On(v1.Push)
return v1