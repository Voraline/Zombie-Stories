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
    local v2 = u0
    setmetatable(v1, v2)
    return v1
end

function u0:AddNode(p2) -- Line: 21
    self.Nodes[p2] = {}
end

function u0:RemoveNode(p2) -- Line: 28
    self.Nodes[p2] = nil
end

function u0.SetNodeAttachment(p1, p2, p3) -- Line: 33 -- upvalues: u0 (val)
    local v1
    local AttachmentNodeData = p1:GetAttachmentNodeData()
    local v2 = AttachmentNodeData
    if v2 then
        v2 = AttachmentNodeData[p2]
    end
    if not v2 then
        p1:RemoveNode(p2)
        v1 = warn
        local v3 = tostring(p2)
        v1(("[AttachmentObject] Node '%s' no longer exists on this weapon; unequipping its attachment."):format(v3))
        return
    end
    v1 = p1.Nodes[p2]
    if not v1 then
        p1:AddNode(p2)
        v1 = p1.Nodes[p2]
    end
    if not (p3 <= #v2.PotentialAttachments) then
        warn(("index '%d' is not within the range of potential attachments"):format(p3))
        return
    end
    if v2.PotentialAttachments[p3] then
        v1.ConnectedAttachment = u0.new(p3, p2, p1.AttachmentNodeData, p1)
        return
    end
    v1.ConnectedAttachment = nil
end

function u0:GetAttachmentIndex() -- Line: 61
    return self.AttachmentIndex
end

function u0:GetNodes() -- Line: 66
    return self.Nodes
end

function u0:GetNodeIDFromName(p2) -- Line: 71
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

function u0.GetAttachmentFromNodeName(p1, p2) -- Line: 81
    local NodeIDFromName = p1:GetNodeIDFromName(p2)
    if NodeIDFromName then
        local v1 = p1:GetNodes()[NodeIDFromName]
        if v1 then
            return v1.ConnectedAttachment
        end
    end
    return nil
end

function u0:GetAttachmentNodeData() -- Line: 93
    return self.AttachmentNodeData
end

function u0:GetNodeID() -- Line: 98
    return self.NodeID
end

function u0.GetAttachmentData(p1, p2, p3, p4) -- Line: 102
    local AttachmentNodeData = p1.AttachmentNodeData
    if AttachmentNodeData then
        AttachmentNodeData = p1.AttachmentNodeData[p1:GetNodeID()]
    end
    if not AttachmentNodeData then
        return nil
    end
    return AttachmentNodeData.PotentialAttachments[p1:GetAttachmentIndex()]
end

return u0