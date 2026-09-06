return {
    Name = "documents",
    Description = "Audits, reports, marks, grants, or revokes Archivist documents",
    Group = "Debug",
    Args = {
        {Type = "string", Name = "action", Description = "audit, status, mark, grant, or revoke"},
        {Type = "string", Name = "documentId", Description = "Registry document id (optional for audit/status)", Optional = true},
        {Type = "player", Name = "target", Description = "Player to grant/revoke; defaults to you", Optional = true},
    },
}