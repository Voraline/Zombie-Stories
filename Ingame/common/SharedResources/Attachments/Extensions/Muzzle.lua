local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
    Name = "Muzzle",
    PotentialAttachments = {
        AttachmentProperties["AR Suppressor"],
        AttachmentProperties["Light Suppressor"],
        AttachmentProperties["AR Muzzle Brake"],
        AttachmentProperties["AR Compensator"],
        AttachmentProperties["Flash Hider"],
    },
}