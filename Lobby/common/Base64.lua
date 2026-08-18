local v_u_1 = {}
local v_u_2 = {}
for v3 = 65, 90 do
	table.insert(v_u_1, v3)
end
for v4 = 97, 122 do
	table.insert(v_u_1, v4)
end
table.insert(v_u_1, 48)
table.insert(v_u_1, 49)
table.insert(v_u_1, 50)
table.insert(v_u_1, 51)
table.insert(v_u_1, 52)
table.insert(v_u_1, 53)
table.insert(v_u_1, 54)
table.insert(v_u_1, 55)
table.insert(v_u_1, 56)
table.insert(v_u_1, 57)
table.insert(v_u_1, 43)
table.insert(v_u_1, 47)
for v5, v6 in ipairs(v_u_1) do
	v_u_2[v6] = v5
end
local v7 = {}
local v_u_8 = bit32.rshift
local v_u_9 = bit32.lshift
local v_u_10 = bit32.band
function v7.Encode(p11) -- name: Encode
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_9, (copy) v_u_1
	local v12 = 0
	local v13 = {}
	for v14 = 1, #p11, 3 do
		local v15 = v14 + 2
		local v16, v17, v18 = string.byte(p11, v14, v15)
		local v19 = v_u_8(v16, 2)
		local v20 = v_u_9(v_u_10(v16, 3), 4) + v_u_8(v17 or 0, 4)
		local v21 = v_u_9(v_u_10(v17 or 0, 15), 2) + v_u_8(v18 or 0, 6)
		local v22 = v_u_10(v18 or 0, 63)
		local v23 = v12 + 1
		v13[v23] = v_u_1[v19 + 1]
		local v24 = v23 + 1
		v13[v24] = v_u_1[v20 + 1]
		local v25 = v24 + 1
		v13[v25] = v17 and v_u_1[v21 + 1] or 61
		v12 = v25 + 1
		v13[v12] = v18 and v_u_1[v22 + 1] or 61
	end
	local v26 = 0
	local v27 = {}
	for v28 = 1, v12, 4096 do
		v26 = v26 + 1
		local v29 = v28 + 4096 - 1
		local v30 = v12 < v29 and v12 and v12 or v29
		local v31 = table.unpack
		v27[v26] = string.char(v31(v13, v28, v30))
	end
	return table.concat(v27)
end
function v7.Decode(p32) -- name: Decode
	-- upvalues: (copy) v_u_2, (copy) v_u_9, (copy) v_u_8, (copy) v_u_10
	local v33 = 0
	local v34 = {}
	for v35 = 1, #p32, 4 do
		local v36 = v35 + 3
		local v37, v38, v39, v40 = string.byte(p32, v35, v36)
		local v41 = v_u_2[v37] - 1
		local v42 = v_u_2[v38] - 1
		local v43 = (v_u_2[v39] or 1) - 1
		local v44 = (v_u_2[v40] or 1) - 1
		local v45 = v_u_9(v41, 2) + v_u_8(v42, 4)
		local v46 = v_u_9(v_u_10(v42, 15), 4) + v_u_8(v43, 2)
		local v47 = v_u_9(v_u_10(v43, 3), 6) + v44
		v33 = v33 + 1
		v34[v33] = v45
		if v39 ~= 61 then
			v33 = v33 + 1
			v34[v33] = v46
		end
		if v40 ~= 61 then
			v33 = v33 + 1
			v34[v33] = v47
		end
	end
	local v48 = 0
	local v49 = {}
	for v50 = 1, v33, 4096 do
		v48 = v48 + 1
		local v51 = v50 + 4096 - 1
		local v52 = v33 < v51 and v33 and v33 or v51
		local v53 = table.unpack
		v49[v48] = string.char(v53(v34, v50, v52))
	end
	return table.concat(v49)
end
return v7