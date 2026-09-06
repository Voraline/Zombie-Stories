local Players = game:GetService("Players")
return {
    Name = "clear",
    Description = "Clear all lines above the entry line of the Cmdr window.",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {},
    ClientRun = function() -- Line: 9 -- upvalues: Players (val)
        local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
        local Cmdr = PlayerGui:WaitForChild("Cmdr")
        local Frame = Cmdr:WaitForChild("Frame")
        if Cmdr and Frame then
            for k, v in pairs(Frame:GetChildren()) do
                if v.Name == "Line" and v:IsA("TextBox") then
                    v:Destroy()
                end
            end
        end
        return ""
    end,
}