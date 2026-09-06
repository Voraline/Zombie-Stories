local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
local v1 = {
    {Name = "Charm", PotentialAttachments = {}},
    {Name = "Sticker", PotentialAttachments = {}},
    {Name = "Sticker 2", PotentialAttachments = {}},
    {Name = "Perk", PotentialAttachments = {}},
    {Name = "Optic", PotentialAttachments = {}},
    {Name = "Barrel", PotentialAttachments = {}},
    {Name = "Muzzle", PotentialAttachments = {}},
    {Name = "Misc Rail", PotentialAttachments = {}},
    {Name = "Top Rail", PotentialAttachments = {}},
}
local v2 = require("../Extensions/Charm")
v1[1].PotentialAttachments = v2.PotentialAttachments
local v3 = require("../Extensions/Sticker")
v1[2].PotentialAttachments = v3.PotentialAttachments
v1[3].PotentialAttachments = v3.PotentialAttachments
local v4 = require("../Extensions/Perk")
v1[4].PotentialAttachments = v4.PotentialAttachments
local v5 = require("../Extensions/Optic")
v1[5].PotentialAttachments = v5.PotentialAttachments
local v6 = require("../Extensions/SMG_Muzzle")
v1[7].PotentialAttachments = v6.PotentialAttachments
local v7 = require("../Extensions/MiscRail")
v1[8].PotentialAttachments = v7.PotentialAttachments
v1[10] = {
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
v1[6] = {
    Name = "Barrel",
    PotentialAttachments = {AttachmentProperties["P90 Extended Barrel"]},
}
v1[11] = {
    Name = "Handguard",
    PotentialAttachments = {AttachmentProperties["P90 Handguard"]},
}
local PotentialAttachments = v1[8].PotentialAttachments
local v8 = nil
local v9 = nil
for i, j in PotentialAttachments, v8, v9 do
    table.insert(v1[10].PotentialAttachments, j)
end
return v1