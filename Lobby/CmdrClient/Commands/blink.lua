return {
    Name = "blink",
    Description = "Teleports you to where your mouse is hovering.",
    Group = "Debug",
    Aliases = {"b"},
    Args = {},
    ClientRun = function(p1) -- Line: 8
        local Mouse = p1.Executor:GetMouse()
        local Character = p1.Executor.Character
        if not Character then
            return "You don't have a character."
        end
        local Ignore = workspace:FindFirstChild("Ignore")
        if Ignore then
            Mouse.TargetFilter = Ignore
        end
        Character:MoveTo(Mouse.Hit.p)
        return "Blinked!"
    end,
}