local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
    Name = "Perk",
    PotentialAttachments = {AttachmentProperties.AP, AttachmentProperties.HP},
}