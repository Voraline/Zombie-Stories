local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = {}
local v_u_3 = nil
local function v6(p4) -- name: getOrCreateRemote
	-- upvalues: (ref) v_u_3, (copy) v_u_1
	v_u_3 = v_u_3 or v_u_1:FindFirstChild("SkillTreeRemotes")
	if not v_u_3 then
		v_u_3 = Instance.new("Folder")
		v_u_3.Name = "SkillTreeRemotes"
		v_u_3.Parent = v_u_1
	end
	local v5 = v_u_3:FindFirstChild(p4)
	if not v5 then
		v5 = Instance.new("RemoteEvent")
		v5.Name = p4
		v5.Parent = v_u_3
	end
	return v5
end
v2.PurchaseSkill = v6("PurchaseSkill")
v2.SkillsUpdated = v6("SkillsUpdated")
v2.RequestSync = v6("RequestSync")
return v2