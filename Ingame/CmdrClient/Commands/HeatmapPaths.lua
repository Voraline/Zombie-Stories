return {
    Name = "heatmappaths",
    Description = "Draws anonymous player route paths on your client.",
    Group = "Debug",
    Aliases = {"hmp"},
    Args = {
        {
            Type = "heatmapPathColor",
            Name = "color",
            Description = "route, flat, or density",
            Default = "route",
        },
        {
            Type = "integer",
            Name = "limit",
            Description = "Maximum number of paths to draw (up to 600)",
            Default = 150,
        },
        {
            Type = "string",
            Name = "mapKey",
            Description = "Stored map key; defaults to the current map",
            Optional = true,
        },
    },
}