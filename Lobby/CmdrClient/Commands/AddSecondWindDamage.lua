return {
    Name = "addsecondwinddamage",
    Description = "Add damage to a downed player's Second Wind meter",
    Group = "Debug",
    Aliases = {"aswd", "secondwind"},
    Args = {
        {Type = "player", Name = "target", Description = "The player to add Second Wind damage to", Optional = true},
        {Type = "number", Name = "amount", Description = "Amount of damage to add (default: max to trigger revive)", Optional = true},
    },
}