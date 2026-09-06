local Players = game:GetService("Players")
local u7 = require("../../Data/PlayerDatabase")
task.spawn(function() -- Line: 7 -- upvalues: Players (val), u7 (val)
    while not (Players.LocalPlayer:FindFirstChild("PlayerGui")) do
        task.wait(0.1)
    end
    u7.PlayerGui:set(Players.LocalPlayer:FindFirstChild("PlayerGui"))
end)
return {}