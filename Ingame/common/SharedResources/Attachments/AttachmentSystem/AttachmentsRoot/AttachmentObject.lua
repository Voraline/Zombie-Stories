local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new(p2, p3, p4, p5) -- name: new
	-- upvalues: (copy) v_u_1
	local v6 = {
		["AttachmentIndex"] = p2,
		["Nodes"] = {},
		["AttachmentNodeData"] = p4,
		["NodeID"] = p3,
		["Parent"] = p5
	}
	local v7 = v_u_1
	setmetatable(v6, v7)
	return v6
end
function v_u_1.AddNode(p8, p9) -- name: AddNode
	p8.Nodes[p9] = {
		["ConnectedAttachment"] = nil
	}
end
function v_u_1.RemoveNode(p10, p11) -- name: RemoveNode
	p10.Nodes[p11] = nil
end
function v_u_1.SetNodeAttachment(p12, p13, p14) -- name: SetNodeAttachment
	-- upvalues: (copy) v_u_1
	local v15 = p12.Nodes[p13]
	if not v15 then
		p12:AddNode(p13)
		v15 = p12.Nodes[p13]
	end
	local v16 = p12:GetAttachmentNodeData()
	if p14 <= #v16[p13].PotentialAttachments then
		if v16[p13].PotentialAttachments[p14] then
			v15.ConnectedAttachment = v_u_1.new(p14, p13, p12.AttachmentNodeData, p12)
		else
			v15.ConnectedAttachment = nil
		end
	else
		warn(("index \'%d\' is not within the range of potential attachments"):format(p14))
		return
	end
end
function v_u_1.GetAttachmentIndex(p17) -- name: GetAttachmentIndex
	return p17.AttachmentIndex
end
function v_u_1.GetNodes(p18) -- name: GetNodes
	return p18.Nodes
end
function v_u_1.GetNodeIDFromName(p19, p20) -- name: GetNodeIDFromName
	for v21, v22 in p19.AttachmentNodeData do
		if v22.Name == p20 then
			return v21
		end
	end
	return nil
end
function v_u_1.GetAttachmentFromNodeName(p23, p24) -- name: GetAttachmentFromNodeName
	local v25 = p23:GetNodeIDFromName(p24)
	local v26 = v25 and p23:GetNodes()[v25]
	if v26 then
		return v26.ConnectedAttachment
	else
		return nil
	end
end
function v_u_1.GetAttachmentNodeData(p27) -- name: GetAttachmentNodeData
	return p27.AttachmentNodeData
end
function v_u_1.GetNodeID(p28) -- name: GetNodeID
	return p28.NodeID
end
function v_u_1.GetAttachmentData(p29, _, _, _) -- name: GetAttachmentData
	return p29.AttachmentNodeData[p29:GetNodeID()].PotentialAttachments[p29:GetAttachmentIndex()]
end
return v_u_1