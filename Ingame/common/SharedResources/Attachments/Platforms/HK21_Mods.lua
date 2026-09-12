local PotentialAttachments_2
local AttachmentProperties = require(script.Parent.Parent:WaitForChild("AttachmentProperties"))
local v1 = {
    {Name = "Charm", PotentialAttachments = {}},
    {Name = "Sticker", PotentialAttachments = {}},
    {Name = "Sticker 2", PotentialAttachments = {}},
    {Name = "Perk", PotentialAttachments = {}},
    {Name = "Optic", PotentialAttachments = {}},
    {Name = "Muzzle", PotentialAttachments = {}},
    [8] = {Name = "Misc Rail", PotentialAttachments = {}},
    [9] = {Name = "Top Rail", PotentialAttachments = {}},
}
local v2 = require("../Extensions/Charm")
v1[1].PotentialAttachments = v2.PotentialAttachments
local v3 = require("../Extensions/Sticker")
v1[2].PotentialAttachments = v3.PotentialAttachments
v1[3].PotentialAttachments = v3.PotentialAttachments
v1[4] = {
    Name = "Perk",
    PotentialAttachments = {AttachmentProperties.AP, AttachmentProperties.HP, AttachmentProperties.HK21_APBelt},
}
local v4 = require("../Extensions/Optic")
v1[5].PotentialAttachments = v4.PotentialAttachments
local v5 = require("../Extensions/Muzzle")
v1[6].PotentialAttachments = v5.PotentialAttachments
local v6 = require("../Extensions/MiscRail")
v1[8].PotentialAttachments = v6.PotentialAttachments
v1[7] = {
    Name = "Bottom Rail",
    PotentialAttachments = {
        AttachmentProperties["Angled Grip"],
        AttachmentProperties["Vertical Grip"],
        AttachmentProperties["Stubby Grip"],
        AttachmentProperties["Skeleton Grip"],
        AttachmentProperties["Folding Grip"],
        AttachmentProperties["RK-1 Grip"],
        AttachmentProperties["Grip Bipod"],
    },
}
v1[9] = {Name = "Top Rail", PotentialAttachments = v1[5].PotentialAttachments}
local PotentialAttachments = v1[8].PotentialAttachments
local v7 = nil
local v8 = nil
for i, j in PotentialAttachments, v7, v8 do
    PotentialAttachments_2 = v1[7].PotentialAttachments
    table.insert(PotentialAttachments_2, j)
end
return v1