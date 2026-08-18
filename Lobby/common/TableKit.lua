local v_u_1 = {}
local function v_u_10(p2, p3) -- name: deepCopyInner
	-- upvalues: (copy) v_u_10
	if typeof(p2) ~= "table" then
		return p2
	end
	local v4 = p3[p2]
	if v4 then
		return v4
	end
	local v5 = table.create(#p2)
	p3[p2] = v5
	for v6, v7 in p2 do
		v5[v_u_10(v6, p3)] = v_u_10(v7, p3)
	end
	local v8 = getmetatable(p2)
	if v8 ~= nil then
		local v9 = v_u_10
		setmetatable(v5, v9(v8, p3))
	end
	if table.isfrozen and table.isfrozen(p2) then
		table.freeze(v5)
	end
	return v5
end
function v_u_1.DeepCopy(p11) -- name: DeepCopy
	-- upvalues: (copy) v_u_10
	return v_u_10(p11, {})
end
function v_u_1.MergeDictionary(p12, p13) -- name: MergeDictionary
	local v14 = table.clone(p12)
	for v15, v16 in p13 do
		v14[v15] = v16
	end
	return v14
end
function v_u_1.Keys(p17) -- name: Keys
	local v18 = {}
	for v19, _ in p17 do
		table.insert(v18, v19)
	end
	return v18
end
function v_u_1.Values(p20) -- name: Values
	local v21 = {}
	for _, v22 in p20 do
		table.insert(v21, v22)
	end
	return v21
end
function v_u_1.MergeArray(p23, p24) -- name: MergeArray
	local v25 = table.clone(p23)
	for _, v26 in p24 do
		table.insert(v25, v26)
	end
	return v25
end
function v_u_1.Reconcile(p27, p28) -- name: Reconcile
	-- upvalues: (copy) v_u_1
	local v29 = table.clone(p27)
	for v30, v31 in p28 do
		if v29[v30] == nil then
			if typeof(v31) == "table" then
				v29[v30] = v_u_1.DeepCopy(v31)
			else
				v29[v30] = v31
			end
		else
			local v32 = p28[v30]
			if typeof(v32) == "table" then
				if typeof(v31) == "table" then
					v29[v30] = v_u_1.Reconcile(v31, p28[v30])
				else
					v29[v30] = v_u_1.DeepCopy(p28[v30])
				end
			end
		end
	end
	return v29
end
function v_u_1.IsArray(p33) -- name: IsArray
	local v34 = 0
	for _, _ in p33 do
		v34 = v34 + 1
	end
	return v34 == #p33
end
function v_u_1.IsDictionary(p35) -- name: IsDictionary
	-- upvalues: (copy) v_u_1
	return not v_u_1.IsArray(p35)
end
function v_u_1.ToString(p36) -- name: ToString
	local v37 = ""
	for v38, v39 in p36 do
		local v40 = tostring(v38)
		local v41 = tostring(v39)
		v37 = v37 .. string.format("[%*]: %*\n", v40, v41)
	end
	return v37
end
function v_u_1.From(p42) -- name: From
	if typeof(p42) ~= "string" then
		return typeof(p42) == "Color3" and { p42.R, p42.G, p42.B } or (typeof(p42) == "Vector2" and { p42.X, p42.Y } or (typeof(p42) == "Vector3" and { p42.X, p42.Y, p42.Z } or (typeof(p42) ~= "NumberSequence" and (typeof(p42) == "Vector3int16" and { p42.X, p42.Y, p42.Z } or (typeof(p42) == "Vector2int16" and { p42.X, p42.Y } or { p42 })) or p42.Keypoints)))
	end
	local v43 = {}
	for v44 = 1, string.len(p42) do
		local v45 = string.sub(p42, v44, v44)
		table.insert(v43, v45)
	end
	return v43
end
function v_u_1.Filter(p46, p47) -- name: Filter
	local v48 = table.clone(p46)
	for v49, v50 in p46 do
		if p47(v50) then
			table.remove(v48, v49)
		end
	end
	return v48
end
function v_u_1.Some(p51, p52) -- name: Some
	for _, v53 in p51 do
		if p52(v53) == true then
			return true
		end
	end
	return false
end
function v_u_1.IsFlat(p54) -- name: IsFlat
	for _, v55 in p54 do
		if typeof(v55) == "table" then
			return false
		end
	end
	return true
end
function v_u_1.Every(p56, p57) -- name: Every
	for v58, v59 in p56 do
		if not p57(v59) then
			return false, v58
		end
	end
	return true
end
function v_u_1.HasKey(p60, p61) -- name: HasKey
	for v62, _ in p60 do
		if v62 == p61 then
			return true
		end
	end
	return false
end
function v_u_1.HasValue(p63, p64) -- name: HasValue
	for _, v65 in p63 do
		if v65 == p64 then
			return true
		end
	end
	return false
end
function v_u_1.IsEmpty(p66) -- name: IsEmpty
	return next(p66) == nil
end
return v_u_1