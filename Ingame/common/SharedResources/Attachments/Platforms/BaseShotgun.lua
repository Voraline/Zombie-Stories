local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
local v1 = {
    {Name = "Charm", PotentialAttachments = {}},
    {Name = "Sticker", PotentialAttachments = {}},
    {Name = "Sticker 2", PotentialAttachments = {}},
    [5] = {Name = "Optic", PotentialAttachments = {}},
    [8] = {Name = "Misc Rail", PotentialAttachments = {}},
    [9] = {Name = "Top Rail", PotentialAttachments = {}},
}
local v2 = require("../Extensions/Charm")
v1[1].PotentialAttachments = v2.PotentialAttachments
local v3 = require("../Extensions/Sticker")
v1[2].PotentialAttachments = v3.PotentialAttachments
v1[3].PotentialAttachments = v3.PotentialAttachments
local v4 = require("../Extensions/Optic")
v1[5].PotentialAttachments = v4.PotentialAttachments
local v5 = require("../Extensions/MiscRail")
v1[8].PotentialAttachments = v5.PotentialAttachments
v1[4] = {
    Name = "Perk",
    PotentialAttachments = {AttachmentProperties.Flechette},
}
v1[6] = {
    Name = "Muzzle",
    PotentialAttachments = {AttachmentProperties["Shotgun Suppressor"]},
}
v1[7] = {
    Name = "Bottom Rail",
    PotentialAttachments = {
        AttachmentProperties["Angled Grip"],
        AttachmentProperties["Vertical Grip"],
        AttachmentProperties["Stubby Grip"],
        AttachmentProperties["Skeleton Grip"],
        AttachmentProperties["Folding Grip"],
        AttachmentProperties["RK-1 Grip"],
    },
}
v1[9] = {Name = "Top Rail", PotentialAttachments = v1[5].PotentialAttachments}
return v1