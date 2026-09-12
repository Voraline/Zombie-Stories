local Players = game:GetService("Players")
local u7 = require("../../Data/PlayerDatabase")
task.spawn(function() -- Line: 7 -- upvalues: Players (val), u7 (val)
    while not Players.LocalPlayer:FindFirstChild("PlayerGui") do
        task.wait(0.1)
    end
    local v1 = u7
    local PlayerGui = v1.PlayerGui
    local PlayerGui_2 = Players.LocalPlayer:FindFirstChild("PlayerGui")
    PlayerGui:set(PlayerGui_2)
end)
return {}