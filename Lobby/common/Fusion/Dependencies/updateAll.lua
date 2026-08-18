local v1 = script.Parent.Parent
require(v1.PubTypes)
return function(p2) -- name: updateAll
	local v3 = 0
	local v4 = {}
	local v5 = {}
	local v6 = 1
	local v7 = {}
	for v8 in p2.dependentSet do
		v3 = v3 + 1
		v4[v3] = v8
		v5[v8] = true
	end
	while v6 <= v3 do
		local v9 = v4[v6]
		local v10 = v7[v9]
		v7[v9] = v10 == nil and 1 or v10 + 1
		if v9.dependentSet ~= nil then
			for v11 in v9.dependentSet do
				v3 = v3 + 1
				v4[v3] = v11
			end
		end
		v6 = v6 + 1
	end
	local v12 = 1
	while v12 <= v3 do
		local v13 = v4[v12]
		local v14 = v7[v13] - 1
		v7[v13] = v14
		if v14 == 0 and (v5[v13] and (v13:update() and v13.dependentSet ~= nil)) then
			for v15 in v13.dependentSet do
				v5[v15] = true
			end
		end
		v12 = v12 + 1
	end
end