local u2 = require("@self/AttachmentObject")
local u5 = require("@game/ReplicatedStorage/common/Table")
local u6 = {}
u6.__index = u6
function u6.new(p1, p2) -- Line: 15 -- upvalues: u6 (val)
    local AttachmentNodeData, BaseAttachments
    local v1 = {IsRoot = true}
    setmetatable(v1, u6)
    local v2 = {}
    v1.Nodes = v2
    v1.AttachmentNodeData = p1.AttachmentNodeData
    if not v1.AttachmentNodeData then
        warn(("[AttachmentsRoot] Missing AttachmentNodeData for weapon '%s'. Check if the config has BaseConfig defined or if the weapon name matches the item database."):format(p1.WeaponName or "unknown"))
        return v1
    end
    v2 = {}
    AttachmentNodeData = v1.AttachmentNodeData
    local v3 = nil
    local v4 = nil
    for i, j in AttachmentNodeData, v3, v4 do
        v2[j.Name] = i
        v1:AddNode(i)
    end
    if p1.BaseAttachments then
        local v5
        BaseAttachments = p1.BaseAttachments
        v3 = nil
        v4 = nil
        for k, n in BaseAttachments, v3, v4 do
            v5 = v2[k]
            if not v5 then
                warn(("No node found with the name '%s'"):format(k))
            else
                v1:SetNodeAttachment(v5, n)
            end
        end
    end
    if p2 then
        v1:Deserialize(p2)
    end
    return v1
end
function u6:AddNode(p2) -- Line: 61
    self.Nodes[p2] = {}
end
function u6.RemoveNode(p1, p2) -- Line: 68
    p1.Nodes[p2] = nil
end
function u6:SetNodeAttachment(p2, p3) -- Line: 73 -- upvalues: u2 (val)
    local v1 = self.Nodes[p2]
    if not v1 then
        return
    end
    local AttachmentNodeData = self:GetAttachmentNodeData()
    if p3 > #AttachmentNodeData[p2].PotentialAttachments then
        warn(("index '%d' is not within the range of potential attachments"):format(p3))
        return
    end
    if AttachmentNodeData[p2].PotentialAttachments[p3] then
        v1.ConnectedAttachment = u2.new(p3, p2, self.AttachmentNodeData, self)
        return
    end
    v1.ConnectedAttachment = nil
end
function u6:GetAttachmentNodeData() -- Line: 90
    return self.AttachmentNodeData
end
function u6:GetNodes() -- Line: 95
    return self.Nodes
end
function u6:GetNodeIDFromName(p2) -- Line: 100
    local AttachmentNodeData = self.AttachmentNodeData
    local v1 = nil
    local v2 = nil
    for i, j in AttachmentNodeData, v1, v2 do
        if j.Name == p2 then
            return i
        end
    end
    return nil
end
function u6.GetAttachmentFromNodeName(p1, p2) -- Line: 110
    local NodeIDFromName = p1:GetNodeIDFromName(p2)
    if not NodeIDFromName then
        return nil
    end
    local v1 = p1:GetNodes()[NodeIDFromName]
    if v1 then
        return v1.ConnectedAttachment
    end
    return nil
end
function u6.Serialize(p1) -- Line: 122
    local readObject
    local v1 = {}
    function readObject(p1, p2) -- Line: 125 -- upvalues: readObject (val)
        local ConnectedAttachment, v1, v2
        for i, j in p1:GetNodes() do
            v1 = tostring(i)
            ConnectedAttachment = j.ConnectedAttachment
            if ConnectedAttachment then
                v2 = {}
                p2[v1] = {ConnectedAttachment:GetAttachmentIndex(), v2}
                readObject(ConnectedAttachment, v2)
            end
        end
    end
    readObject(p1, v1)
    return v1
end
function u6.GetDisplayName(p1, p2) -- Line: 151 -- upvalues: u5 (val)
    local scan, u2
    function scan(p1) -- Line: 154 -- upvalues: u5 (upval), u2 (ref), scan (val)
        local AttachmentData, ConnectedAttachment
        local v1 = u5.keys(p1:GetNodes())
        table.sort(v1)
        local v2 = v1
        local v3 = nil
        local v4 = nil
        local v5 = p1
        for i, j in v2, v3, v4 do
            ConnectedAttachment = v5:GetNodes()[j].ConnectedAttachment
            if ConnectedAttachment then
                AttachmentData = ConnectedAttachment:GetAttachmentData()
                if AttachmentData and AttachmentData.CustomName then
                    u2 = AttachmentData.CustomName
                end
                scan(ConnectedAttachment)
            end
        end
    end
    scan(p1)
    return p2
end
function u6.Deserialize(p1, p2) -- Line: 175 -- upvalues: u5 (val)
    local convertIDToInteger, readNode, v1, v2
    local v3 = u5.deepCopy(p2)
    function convertIDToInteger(p1) -- Line: 179 -- upvalues: u5 (upval), convertIDToInteger (val)
        local v1
        local v2 = u5.keys(p1)
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            v1 = p1[j]
            p1[tonumber(j)] = v1
            p1[j] = nil
            convertIDToInteger(v1[2])
        end
    end
    convertIDToInteger(v3)
    function readNode(p1, p2, p3) -- Line: 190 -- upvalues: readNode (val)
        p2:SetNodeAttachment(p1, p3[1])
        local v1 = p3[2]
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            readNode(i, p2:GetNodes()[p1].ConnectedAttachment, j)
        end
    end
    v1 = v3
    local v4 = nil
    v2 = nil
    for i, j in v1, v4, v2 do
        readNode(i, p1, j)
    end
end
return u6