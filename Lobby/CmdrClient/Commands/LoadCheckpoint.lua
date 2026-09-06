return {
    Name = "loadcheckpoint",
    Description = "Loads the checkpoint with the given key",
    Group = "Debug",
    Aliases = {"lcp"},
    Args = {
        {Type = "string", Name = "checkpointKey", Description = "The checkpoint's key"},
    },
}