local v_u_1 = require("@self/AttachmentObject")
local v_u_2 = require("@game/ReplicatedStorage/common/Table")
local v_u_3 = {}
v_u_3.__index = v_u_3
function v_u_3.new(p4, p5) -- name: new
	-- upvalues: (copy) v_u_3
	local v6 = {
		["IsRoot"] = true
	}
	local v7 = v_u_3
	setmetatable(v6, v7)
	v6.Nodes = {}
	v6.AttachmentNodeData = p4.AttachmentNodeData
	if not v6.AttachmentNodeData then
		warn(("[AttachmentsRoot] Missing AttachmentNodeData for weapon \'%s\'. Check if the config has BaseConfig defined or if the weapon name matches the item database."):format(p4.WeaponName or "unknown"))
		return v6
	end
	local v8 = {}
	for v9, v10 in v6.AttachmentNodeData do
		v8[v10.Name] = v9
		v6:AddNode(v9)
	end
	if p4.BaseAttachments then
		for v11, v12 in p4.BaseAttachments do
			local v13 = v8[v11]
			if v13 then
				v6:SetNodeAttachment(v13, v12)
			else
				warn(("No node found with the name \'%s\'"):format(v11))
			end
		end
	end
	if p5 then
		v6:Deserialize(p5)
	end
	return v6
end
function v_u_3.AddNode(p14, p15) -- name: AddNode
	p14.Nodes[p15] = {
		["ConnectedAttachment"] = nil
	}
end
function v_u_3.RemoveNode(p16, p17) -- name: RemoveNode
	p16.Nodes[p17] = nil
end
function v_u_3.SetNodeAttachment(p18, p19, p20) -- name: SetNodeAttachment
	-- upvalues: (copy) v_u_1
	local v21 = p18.Nodes[p19]
	if v21 then
		local v22 = p18:GetAttachmentNodeData()
		if p20 <= #v22[p19].PotentialAttachments then
			if v22[p19].PotentialAttachments[p20] then
				v21.ConnectedAttachment = v_u_1.new(p20, p19, p18.AttachmentNodeData, p18)
			else
				v21.ConnectedAttachment = nil
			end
		end
		warn(("index \'%d\' is not within the range of potential attachments"):format(p20))
	end
end
function v_u_3.GetAttachmentNodeData(p23) -- name: GetAttachmentNodeData
	return p23.AttachmentNodeData
end
function v_u_3.GetNodes(p24) -- name: GetNodes
	return p24.Nodes
end
function v_u_3.GetNodeIDFromName(p25, p26) -- name: GetNodeIDFromName
	for v27, v28 in p25.AttachmentNodeData do
		if v28.Name == p26 then
			return v27
		end
	end
	return nil
end
function v_u_3.GetAttachmentFromNodeName(p29, p30) -- name: GetAttachmentFromNodeName
	local v31 = p29:GetNodeIDFromName(p30)
	local v32 = v31 and p29:GetNodes()[v31]
	if v32 then
		return v32.ConnectedAttachment
	else
		return nil
	end
end
function v_u_3.Serialize(p33) -- name: Serialize
	local v34 = {}
	local function v_u_42(p35, p36) -- name: readObject
		-- upvalues: (copy) v_u_42
		for v37, v38 in p35:GetNodes() do
			local v39 = tostring(v37)
			local v40 = v38.ConnectedAttachment
			if v40 then
				local v41 = {}
				p36[v39] = { v40:GetAttachmentIndex(), v41 }
				v_u_42(v40, v41)
			end
		end
	end
	v_u_42(p33, v34)
	return v34
end
function v_u_3.GetDisplayName(p43, p44) -- name: GetDisplayName
	-- upvalues: (copy) v_u_2
	local v_u_45 = p44
	local function v_u_51(p46) -- name: scan
		-- upvalues: (ref) v_u_2, (ref) v_u_45, (copy) v_u_51
		local v47 = v_u_2.keys(p46:GetNodes())
		table.sort(v47)
		for _, v48 in v47 do
			local v49 = p46:GetNodes()[v48].ConnectedAttachment
			if v49 then
				local v50 = v49:GetAttachmentData()
				if v50 and v50.CustomName then
					v_u_45 = v50.CustomName
				end
				v_u_51(v49)
			end
		end
	end
	v_u_51(p43)
	return v_u_45
end
function v_u_3.Deserialize(p52, p53) -- name: Deserialize
	-- upvalues: (copy) v_u_2
	local v54 = v_u_2.deepCopy(p53)
	local function v_u_58(p55) -- name: convertIDToInteger
		-- upvalues: (ref) v_u_2, (copy) v_u_58
		for _, v56 in v_u_2.keys(p55) do
			local v57 = p55[v56]
			p55[tonumber(v56)] = v57
			p55[v56] = nil
			v_u_58(v57[2])
		end
	end
	v_u_58(v54)
	local function v_u_64(p59, p60, p61) -- name: readNode
		-- upvalues: (copy) v_u_64
		p60:SetNodeAttachment(p59, p61[1])
		for v62, v63 in p61[2] do
			v_u_64(v62, p60:GetNodes()[p59].ConnectedAttachment, v63)
		end
	end
	for v65, v66 in v54 do
		v_u_64(v65, p52, v66)
	end
end
return v_u_3