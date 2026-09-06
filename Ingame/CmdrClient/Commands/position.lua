local Players = game:GetService("Players")
return {
    Name = "position",
    Description = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
    Group = "DefaultDebug",
    Aliases = {"pos"},
    Args = {
        {Type = "player", Name = "Player", Description = "The player to report the position of. Omit for your own position.", Default = Players.LocalPlayer},
    },
    ClientRun = function(p1, p2) -- Line: 17
        local Character = p2.Character
        if not Character or not (Character:FindFirstChild("HumanoidRootPart")) then
            return ""
        end
        return tostring(Character.HumanoidRootPart.Position):gsub("%s", "")
    end,
}