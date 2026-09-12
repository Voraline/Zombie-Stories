return {
    Name = "thru",
    Description = "Teleports you through whatever your mouse is hovering over, placing you equidistantly from the wall.",
    Group = "Debug",
    Aliases = {"t", "through"},
    Args = {
        {
            Type = "number",
            Name = "Extra distance",
            Description = "Go through the wall an additional X studs.",
            Default = 0,
        },
    },
    ClientRun = function(p1, p2) -- Line: 15
        local Mouse = p1.Executor:GetMouse()
        local Character = p1.Executor.Character
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            local Ignore = workspace:FindFirstChild("Ignore")
            if Ignore then
                Mouse.TargetFilter = Ignore
            end
            local Position = Character.HumanoidRootPart.Position
            local v1 = Mouse.Hit.p - Position
            local v2 = v1 * 2 + v1.unit * p2 + Position
            Character:MoveTo(v2)
            return "Blinked!"
        end
        return "You don't have a character."
    end,
}