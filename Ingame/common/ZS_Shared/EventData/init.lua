game:GetService("ReplicatedStorage")
local v_u_1 = {}
local v_u_2 = {}
local function v_u_8(p3) -- name: registerEventModule
	-- upvalues: (copy) v_u_1, (copy) v_u_2
	if p3 and p3:IsA("ModuleScript") then
		local v4, v5 = pcall(require, p3)
		if v4 then
			if type(v5) == "table" then
				local v6 = v5.Id or (v5.id or p3.Name)
				if v6 then
					v5.Id = v6
					v_u_1[v6] = v5
					local v7 = v5.DataStoreKey or (v5.datastoreKey or v6)
					v5.DataStoreKey = v7
					v_u_2[v7] = v5
				else
					warn(string.format("[EventData] Event module %s is missing an Id field", p3:GetFullName()))
				end
			else
				warn(string.format("[EventData] Event module %s did not return a table", p3:GetFullName()))
				return
			end
		else
			warn(string.format("[EventData] Failed to require event module %s: %s", p3:GetFullName(), (tostring(v5))))
			return
		end
	else
		return
	end
end
local v_u_9 = {}
for _, v10 in ipairs(script:GetChildren()) do
	v_u_8(v10)
end
local v_u_11 = {}
function v_u_9.GetEvent(p12) -- name: GetEvent
	-- upvalues: (copy) v_u_1
	if p12 then
		return v_u_1[p12]
	else
		return nil
	end
end
function v_u_9.GetEventByDataStoreKey(p13) -- name: GetEventByDataStoreKey
	-- upvalues: (copy) v_u_2
	if p13 then
		return v_u_2[p13]
	else
		return nil
	end
end
function v_u_9.GetRegisteredEventIds() -- name: GetRegisteredEventIds
	-- upvalues: (copy) v_u_1
	local v14 = {}
	for v15 in pairs(v_u_1) do
		table.insert(v14, v15)
	end
	table.sort(v14)
	return v14
end
function v_u_9.SetActiveEventIds(p16) -- name: SetActiveEventIds
	-- upvalues: (ref) v_u_11
	local v17 = {}
	for v18, v19 in ipairs(p16 or {}) do
		v17[v18] = v19
	end
	v_u_11 = v17
end
function v_u_9.GetActiveEventIds() -- name: GetActiveEventIds
	-- upvalues: (ref) v_u_11
	local v20 = v_u_11
	local v21 = {}
	for v22, v23 in ipairs(v20) do
		v21[v22] = v23
	end
	return v21
end
function v_u_9.GetActiveEvents() -- name: GetActiveEvents
	-- upvalues: (ref) v_u_11, (copy) v_u_9
	local v24 = {}
	for _, v25 in ipairs(v_u_11) do
		local v26 = v_u_9.GetEvent(v25)
		if v26 then
			table.insert(v24, v26)
		else
			warn(string.format("[EventData] Active event %s has no registered configuration", (tostring(v25))))
		end
	end
	return v24
end
local function v_u_32(p27) -- name: createDefaultRewardState
	local v28 = {}
	if p27 then
		local v29 = p27.Rewards
		if type(v29) == "table" then
			for _, v30 in ipairs(p27.Rewards) do
				local v31 = v30.RewardId or v30.Id
				if v31 then
					v28[v31] = {
						["rewarded"] = false,
						["count"] = 0
					}
				end
			end
			return v28
		end
	end
	return v28
end
function v_u_9.BuildDefaultAwardsForEvent(p33) -- name: BuildDefaultAwardsForEvent
	-- upvalues: (copy) v_u_9, (copy) v_u_32
	local v34 = v_u_9.GetEvent(p33)
	return not v34 and {} or v_u_32(v34)
end
function v_u_9.BuildDefaultAwardsForActiveEvents() -- name: BuildDefaultAwardsForActiveEvents
	-- upvalues: (copy) v_u_9, (copy) v_u_32
	local v35 = {}
	for _, v36 in ipairs(v_u_9.GetActiveEvents()) do
		v35[v36.DataStoreKey] = v_u_32(v36)
	end
	return v35
end
function v_u_9.EnsureEventDataTables(p37) -- name: EnsureEventDataTables
	-- upvalues: (copy) v_u_9, (copy) v_u_32
	if type(p37) == "table" then
		p37.Stats = p37.Stats or {}
		p37.Stats.UniqueAwards = p37.Stats.UniqueAwards or {}
		local v38 = p37.Stats.UniqueAwards
		for _, v39 in ipairs(v_u_9.GetActiveEvents()) do
			local v40 = v39.DataStoreKey
			if v38[v40] == nil then
				v38[v40] = v_u_32(v39)
			else
				local v41 = v38[v40]
				if type(v41) ~= "table" then
					v41 = {}
					v38[v40] = v41
				end
				local v42 = v_u_32(v39)
				for v43, v44 in pairs(v42) do
					local v45 = v41[v43]
					if type(v45) == "table" then
						if v45.count == nil then
							v45.count = v44.count
						end
						if v45.rewarded == nil then
							v45.rewarded = v44.rewarded
						end
					else
						v41[v43] = {
							["rewarded"] = v44.rewarded,
							["count"] = v44.count
						}
					end
				end
			end
		end
	end
end
function v_u_9.RegisterEventModule(p46) -- name: RegisterEventModule
	-- upvalues: (copy) v_u_8
	v_u_8(p46)
end
if #v_u_11 == 0 then
	v_u_9.SetActiveEventIds({ "CHRISTMAS2025" })
end
return v_u_9