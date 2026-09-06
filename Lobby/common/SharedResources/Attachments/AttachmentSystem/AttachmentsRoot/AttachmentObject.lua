local u0 = {}
u0.__index = u0
function u0.new(p1, p2, p3, p4) -- Line: 4 -- upvalues: u0 (val)
    local v1 = {
        AttachmentIndex = p1,
        Nodes = {},
        AttachmentNodeData = p3,
        NodeID = p2,
        Parent = p4,
    }
    setmetatable(v1, u0)
    return v1
end
function u0:AddNode(p2) -- Line: 21
    self.Nodes[p2] = {}
end
function u0.RemoveNode(p1, p2) -- Line: 28
    p1.Nodes[p2] = nil
end
function u0.SetNodeAttachment(p1, p2, p3) -- Line: 33 -- upvalues: u0 (val)
    local v1 = p1.Nodes[p2]
    if not v1 then
        p1:AddNode(p2)
        v1 = p1.Nodes[p2]
    end
    local AttachmentNodeData = p1:GetAttachmentNodeData()
    if p3 > #AttachmentNodeData[p2].PotentialAttachments then
        warn(("index '%d' is not within the range of potential attachments"):format(p3))
        return
    end
    if AttachmentNodeData[p2].PotentialAttachments[p3] then
        v1.ConnectedAttachment = u0.new(p3, p2, p1.AttachmentNodeData, p1)
        return
    end
    v1.ConnectedAttachment = nil
end
function u0:GetAttachmentIndex() -- Line: 52
    return self.AttachmentIndex
end
function u0:GetNodes() -- Line: 57
    return self.Nodes
end
function u0:GetNodeIDFromName(p2) -- Line: 62
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
function u0.GetAttachmentFromNodeName(p1, p2) -- Line: 72
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
function u0:GetAttachmentNodeData() -- Line: 84
    return self.AttachmentNodeData
end
function u0:GetNodeID() -- Line: 89
    return self.NodeID
end
function u0.GetAttachmentData(p1, p2, p3, p4) -- Line: 93
    return p1.AttachmentNodeData[p1:GetNodeID()].PotentialAttachments[p1:GetAttachmentIndex()]
end
return u0