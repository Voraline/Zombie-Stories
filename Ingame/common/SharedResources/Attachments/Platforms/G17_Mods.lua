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
v1[5] = {
    Name = "Optic",
    PotentialAttachments = {AttachmentProperties["Mini Red Dot"]},
}
v1[6] = {
    Name = "Muzzle",
    PotentialAttachments = {AttachmentProperties["Light Suppressor"], AttachmentProperties["Osprey Suppressor"], AttachmentProperties["Pistol Muzzle Brake"], AttachmentProperties["Pistol Compensator"]},
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
v1[8] = {
    Name = "Misc Rail",
    PotentialAttachments = {AttachmentProperties["Green Laser"], AttachmentProperties["Small Flashlight"]},
}
v1[9] = {Name = "Top Rail", PotentialAttachments = v1[5].PotentialAttachments}
v1[10] = {
    Name = "Pistol Rail",
    PotentialAttachments = {AttachmentProperties["Small Flashlight"]},
}
v1[11] = {
    Name = "Magazine",
    PotentialAttachments = {AttachmentProperties.G17_Var50, AttachmentProperties.G17_ExtendedMag},
}
local PotentialAttachments = v1[8].PotentialAttachments
local v4 = nil
local v5 = nil
for i, j in PotentialAttachments, v4, v5 do
    table.insert(v1[7].PotentialAttachments, j)
end
return v1