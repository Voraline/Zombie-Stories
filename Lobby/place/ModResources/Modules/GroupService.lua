local v_u_1 = {}
local v_u_2 = game:GetService("GroupService")
local function v_u_9(p3) -- name: PagesToArray
	local v4 = {}
	while true do
		local v5 = next
		local v6, v7 = p3:GetCurrentPage()
		for _, v8 in v5, v6, v7 do
			v4[#v4 + 1] = v8
		end
		if p3.IsFinished then
			return
		end
		pcall(p3.AdvanceToNextPageAsync, p3)
	end
end
function v_u_1.GetRankInGroupAsync(_, p10, p11) -- name: GetRankInGroupAsync
	-- upvalues: (copy) v_u_1
	local v12 = v_u_1:GetGroupsAsync(p10)
	for v13 = 1, #v12 do
		local v14 = v12[v13]
		if v14.Id == p11 then
			return v14.Rank
		end
	end
	return 0
end
function v_u_1.GetRoleInGroupAsync(_, p15, p16) -- name: GetRoleInGroupAsync
	-- upvalues: (copy) v_u_1
	local v17 = v_u_1:GetGroupsAsync(p15)
	for v18 = 1, #v17 do
		local v19 = v17[v18]
		if v19.Id == p16 then
			return v19.Role
		end
	end
	return "Guest"
end
function v_u_1.GetPrimaryGroupAsync(_, p20) -- name: GetPrimaryGroupAsync
	-- upvalues: (copy) v_u_1
	local v21 = v_u_1:GetGroupsAsync(p20)
	for v22 = 1, #v21 do
		local v23 = v21[v22]
		if v23.IsPrimary then
			return v23
		end
	end
	return nil
end
function v_u_1.IsInGroupAsync(_, p24, p25) -- name: IsInGroupAsync
	-- upvalues: (copy) v_u_1
	local v26 = v_u_1:GetGroupsAsync(p24)
	for v27 = 1, #v26 do
		if v26[v27].Id == p25 then
			return true
		end
	end
	return false
end
function v_u_1.IsPrimaryGroupAsync(_, p28) -- name: IsPrimaryGroupAsync
	-- upvalues: (copy) v_u_1
	local v29 = v_u_1:GetGroupsAsync(p28)
	for v30 = 1, #v29 do
		if v29[v30].IsPrimary then
			return true
		end
	end
	return false
end
function v_u_1.IsGroupAlly(_, p31, p32) -- name: IsGroupAlly
	-- upvalues: (copy) v_u_1
	local v33 = v_u_1:GetGroupAlliesAsync(p31)
	for v34 = 1, #v33 do
		if v33[v34].Id == p32 then
			return true
		end
	end
	return false
end
function v_u_1.IsGroupEnemy(_, p35, p36) -- name: IsGroupEnemy
	-- upvalues: (copy) v_u_1
	local v37 = v_u_1:GetGroupEnemiesAsync(p35)
	for v38 = 1, #v37 do
		if v37[v38].Id == p36 then
			return true
		end
	end
	return false
end
function v_u_1.GetGroupAlliesAsync(_, p39) -- name: GetGroupAlliesAsync
	-- upvalues: (copy) v_u_2, (copy) v_u_9
	local v41, v41 = pcall(v_u_2.GetAlliesAsync, v_u_2, p39)
	if v41 then
		if v41 then
			v41 = v_u_9(v41)
		end
	end
	return v41
end
function v_u_1.GetEnemiesAsync(_, p42) -- name: GetEnemiesAsync
	-- upvalues: (copy) v_u_2, (copy) v_u_9
	local v44, v44 = pcall(v_u_2.GetEnemiesAsync, v_u_2, p42)
	if v44 then
		if v44 then
			v44 = v_u_9(v44)
		end
	end
	return v44
end
function v_u_1.GetGroupsAsync(_, p45) -- name: GetGroupsAsync
	-- upvalues: (copy) v_u_2
	local v46, v47 = pcall(v_u_2.GetGroupsAsync, v_u_2, p45.UserId)
	return v46 and v47 and v47 or {}
end
function v_u_1.GetGroupInfoAsync(_, p48) -- name: GetGroupInfoAsync
	-- upvalues: (copy) v_u_2
	local v49, v50 = pcall(v_u_2.GetGroupInfoAsync, v_u_2, p48)
	return v49 and v50 and v50 or {}
end
return v_u_1