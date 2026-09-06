local v1 = {
    Name = "overridewalkspeed",
    Description = "Override player walkspeed to single value.",
    Group = "Debug",
    Aliases = {"ws"},
}
local v2 = {
    {Type = "integer", Name = "walkspeed", Description = "The walkspeed. Negative number resets."},
}
v1.Args = v2
function v1.ClientRun(p1, p2) -- Line: 14
    local v1
    local LocalPlayerController = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
    if p2 >= 0 then
        v1 = p2
    else
        v1 = nil
    end
    LocalPlayerController:SetWalkSpeedOverride(v1)
    if v1 then
        return (string.format("Set override walkspeed to %d", v1))
    end
    return "Reset walkspeed"
end
return v1