local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
    Name = "Optic",
    PotentialAttachments = {
        AttachmentProperties["Red Dot"],
        AttachmentProperties["OKP-7"],
        AttachmentProperties.Coyote,
        AttachmentProperties.EOTech,
        AttachmentProperties.Aimpoint,
        AttachmentProperties.ACOG,
        AttachmentProperties.Kobra,
        AttachmentProperties.Riser,
        AttachmentProperties["Nocturne LPVO"],
    },
}