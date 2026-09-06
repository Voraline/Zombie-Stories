return {
    Name = "additem",
    Description = "Adds items to a player's inventory",
    Group = "Items",
    Args = {
        {Type = "playerId", Name = "target", Description = "Player to give items"},
        {Type = "itemId", Name = "item", Description = "The item to give"},
        {Type = "integer", Name = "copies", Description = "Number of copies to give", Default = 1},
        {Type = "boolean", Name = "tradable", Description = "Tradability of the copies", Default = false},
    },
}