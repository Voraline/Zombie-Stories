return {
    Name = "overridewalkspeed",
    Description = "Override player walkspeed to single value.",
    Group = "Debug",
    Aliases = {"ws"},
    Args = {
        {Type = "integer", Name = "walkspeed", Description = "The walkspeed. Negative number resets."},
    },
    ClientRun = function(p1, p2) -- Line: 14
        local v1
        local ZS_Framework = (game:GetService("ReplicatedStorage")).common.ZS_Framework
        local LocalPlayerController = require(ZS_Framework.Modules.Controllers.LocalPlayerController)
        if not (p2 < 0) then
            v1 = p2
        else
            v1 = nil
        end
        LocalPlayerController:SetWalkSpeedOverride(v1)
        if v1 then
            return (string.format("Set override walkspeed to %d", v1))
        end
        return "Reset walkspeed"
    end,
}