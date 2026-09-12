return {
    Name = "heatmap",
    Description = "Draws the aggregate player-position heatmap on your client.",
    Group = "Debug",
    Aliases = {"hm"},
    Args = {
        {
            Type = "heatmapMetric",
            Name = "metric",
            Description = "samples, visitors, or dwell",
            Default = "samples",
        },
        {Type = "heatmapLayer", Name = "layer", Description = "move, seat, or both", Default = "move"},
        {
            Type = "integer",
            Name = "limit",
            Description = "Maximum number of cells to draw (up to 6000)",
            Default = 2000,
        },
        {
            Type = "string",
            Name = "mapKey",
            Description = "Stored map key; defaults to the current map",
            Optional = true,
        },
    },
}