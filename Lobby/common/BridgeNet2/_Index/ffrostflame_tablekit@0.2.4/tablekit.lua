local v_u_61 = {
	["DeepCopy"] = function(p1) -- name: DeepCopy
		-- upvalues: (copy) v_u_61
		local v2 = table.clone(p1)
		for v3, v4 in v2 do
			if typeof(v4) == "table" then
				v2[v3] = v_u_61.DeepCopy(v4)
			end
		end
		return v2
	end,
	["MergeDictionary"] = function(p5, p6) -- name: MergeDictionary
		local v7 = table.clone(p5)
		for v8, v9 in p6 do
			v7[v8] = v9
		end
		return v7
	end,
	["Keys"] = function(p10) -- name: Keys
		local v11 = {}
		for v12 in p10 do
			table.insert(v11, v12)
		end
		return v11
	end,
	["Values"] = function(p13) -- name: Values
		local v14 = {}
		for _, v15 in p13 do
			table.insert(v14, v15)
		end
		return v14
	end,
	["MergeArrays"] = function(p16, p17) -- name: MergeArrays
		local v18 = table.clone(p16)
		table.move(p17, 1, #p17, #v18 + 1, v18)
		return v18
	end,
	["Reconcile"] = function(p19, p20) -- name: Reconcile
		-- upvalues: (copy) v_u_61
		local v21 = table.clone(p19)
		for v22, v23 in p20 do
			if v21[v22] == nil then
				if typeof(v23) == "table" then
					v21[v22] = v_u_61.DeepCopy(v23)
				else
					v21[v22] = v23
				end
			else
				local v24 = p20[v22]
				if typeof(v24) == "table" then
					if typeof(v23) == "table" then
						v21[v22] = v_u_61.Reconcile(v23, p20[v22])
					else
						v21[v22] = v_u_61.DeepCopy(p20[v22])
					end
				end
			end
		end
		return v21
	end,
	["IsArray"] = function(p25) -- name: IsArray
		local v26 = 0
		for _ in p25 do
			v26 = v26 + 1
		end
		return v26 == #p25
	end,
	["IsDictionary"] = function(p27) -- name: IsDictionary
		local v28 = 0
		for _ in p27 do
			v28 = v28 + 1
		end
		return v28 ~= #p27
	end,
	["ToString"] = function(p29) -- name: ToString
		local v30 = {}
		for v31, v32 in p29 do
			local v33
			if typeof(v31) == "string" then
				v33 = ("\"%*\""):format((tostring(v31)))
			else
				v33 = tostring(v31)
			end
			local v34 = tostring(v32)
			if typeof(v32) == "string" then
				v34 = ("\"%*\""):format(v34)
			end
			local v35 = ("\t[%*] = %*"):format(v33, v34)
			table.insert(v30, v35)
		end
		return "{\n" .. table.concat(v30, "\n") .. "\n}"
	end,
	["ToArrayString"] = function(p36) -- name: ToArrayString
		local v37 = {}
		for _, v38 in p36 do
			local v39 = tostring(v38)
			if typeof(v38) == "string" then
				v39 = ("\"%*\""):format(v39)
			end
			table.insert(v37, v39)
		end
		return "{" .. table.concat(v37, ", ") .. "}"
	end,
	["From"] = function(p40) -- name: From
		local v41 = typeof(p40)
		if v41 == "string" then
			return string.split(p40, "")
		else
			return v41 == "Color3" and { p40.R, p40.G, p40.B } or (v41 == "Vector2" and { p40.X, p40.Y } or (v41 == "Vector3" and { p40.X, p40.Y, p40.Z } or (v41 ~= "NumberSequence" and (v41 == "Vector3int16" and { p40.X, p40.Y, p40.Z } or (v41 == "Vector2int16" and { p40.X, p40.Y } or { p40 })) or p40.Keypoints)))
		end
	end,
	["Filter"] = function(p42, p43) -- name: Filter
		local v44 = {}
		for _, v45 in p42 do
			if p43(v45) then
				table.insert(v44, v45)
			end
		end
		return v44
	end,
	["Some"] = function(p46, p47) -- name: Some
		for _, v48 in p46 do
			if p47(v48) == true then
				return true
			end
		end
		return false
	end,
	["IsFlat"] = function(p49) -- name: IsFlat
		for _, v50 in p49 do
			if typeof(v50) == "table" then
				return false
			end
		end
		return true
	end,
	["Every"] = function(p51, p52) -- name: Every
		for v53, v54 in p51 do
			if not p52(v54) then
				return false, v53
			end
		end
		return true
	end,
	["HasKey"] = function(p55, p56) -- name: HasKey
		return p55[p56] ~= nil
	end,
	["HasValue"] = function(p57, p58) -- name: HasValue
		for _, v59 in p57 do
			if v59 == p58 then
				return true
			end
		end
		return false
	end,
	["IsEmpty"] = function(p60) -- name: IsEmpty
		return next(p60) == nil
	end
}
return table.freeze(v_u_61)