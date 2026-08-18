local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local function v_u_13(p3, p4) -- name: whichScopeLivesLonger
	local v5 = 2
	local v6 = { p3, p4 }
	local v7 = {}
	local v8 = 0
	local v9 = {}
	while v5 > 0 do
		for _, v10 in v6 do
			v7[v10] = true
			for _, v11 in ipairs(v10) do
				if v11 == p3 then
					return "definitely-b"
				end
				if v11 == p4 then
					return "definitely-a"
				end
				if typeof(v11) == "table" and (v11[1] ~= nil and v7[v10] == nil) then
					v8 = v8 + 1
					v9[v8] = v11
				end
			end
		end
		table.clear(v6)
		v5 = v8
		local v12 = v9
		v9 = v6
		v6 = v12
		v8 = 0
	end
	return "unsure"
end
return function(p14, p15, p16, p17) -- name: whichLivesLonger
	-- upvalues: (copy) v_u_2, (copy) v_u_13
	if v_u_2.isTimeCritical() then
		return "unsure"
	end
	if p14 ~= p16 then
		return v_u_13(p14, p16)
	end
	for v18 = #p14, 1, -1 do
		local v19 = p14[v18]
		if v19 == p15 then
			return "definitely-b"
		end
		if v19 == p17 then
			return "definitely-a"
		end
	end
	return "unsure"
end