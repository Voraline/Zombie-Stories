local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
    Name = "Misc Rail",
    PotentialAttachments = {
        AttachmentProperties["Green Laser"],
        AttachmentProperties["Orange Laser"],
        AttachmentProperties["Small Flashlight"],
    },
}