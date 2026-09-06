local Players = game:GetService("Players")
return {
    Name = "hover",
    Description = "Returns the name of the player you are hovering over.",
    Group = "DefaultUtil",
    Args = {},
    ClientRun = function() -- Line: 9 -- upvalues: Players (val)
        local Name
        local Target = Players.LocalPlayer:GetMouse().Target
        if not Target then
            return ""
        end
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Target:FindFirstAncestorOfClass("Model"))
        if not PlayerFromCharacter then
            Name = ""
        else
            Name = PlayerFromCharacter.Name
            if not Name then
                Name = ""
            end
        end
        return Name
    end,
}