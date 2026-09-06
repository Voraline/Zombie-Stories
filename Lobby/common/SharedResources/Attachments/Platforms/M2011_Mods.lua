local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
local v1 = {
    {Name = "Charm", PotentialAttachments = {}},
    {Name = "Sticker", PotentialAttachments = {}},
    {Name = "Sticker 2", PotentialAttachments = {}},
}
local v2 = require("../Extensions/Charm")
v1[1].PotentialAttachments = v2.PotentialAttachments
local v3 = require("../Extensions/Sticker")
v1[2].PotentialAttachments = v3.PotentialAttachments
v1[3].PotentialAttachments = v3.PotentialAttachments
v1[4] = {
    Name = "Perk",
    PotentialAttachments = {AttachmentProperties.AP},
}
v1[6] = {
    Name = "Muzzle",
    PotentialAttachments = {AttachmentProperties["Light Suppressor"], AttachmentProperties["Osprey Suppressor"], AttachmentProperties["Pistol Muzzle Brake"], AttachmentProperties["Pistol Compensator"]},
}
v1[8] = {
    Name = "Misc Rail",
    PotentialAttachments = {AttachmentProperties["Green Laser"], AttachmentProperties["Small Flashlight"]},
}
v1[10] = {
    Name = "Pistol Rail",
    PotentialAttachments = {AttachmentProperties["Small Flashlight"], AttachmentProperties["Orange Laser"]},
}
return v1