local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
return {
    Name = "Charm",
    PotentialAttachments = {
        AttachmentProperties.Slasher,
        AttachmentProperties["Jack Carbine"],
        AttachmentProperties.Medkit,
        AttachmentProperties["Ammo Box"],
        AttachmentProperties["Focus Spray"],
        AttachmentProperties.Tix,
        AttachmentProperties["Golden Slasher"],
        AttachmentProperties.Helicopter,
        AttachmentProperties.Rat,
    },
}