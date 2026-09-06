return {
    Name = "setmag",
    Description = "Sets the magazine ammo of a player's gun",
    Group = "Debug",
    Args = {
        {Type = "player", Name = "target", Description = "The target player"},
        {Type = "integer", Name = "ammo", Description = "Amount of ammo for the magazine"},
        {Type = "gunSlot", Name = "slot", Description = "The gun slot", Default = "Primary"},
    },
}