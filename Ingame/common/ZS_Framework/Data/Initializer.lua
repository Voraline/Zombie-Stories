local v1 = game:GetService("ReplicatedStorage")
local _ = require(v1.Packages.Fusion).peek
local v2 = require("@game/ReplicatedStorage/common/zap")
local v_u_3 = require("./PlayerDatabase")
local v_u_4 = v_u_3.Scope
local v_u_5 = {}
local function v_u_10(p6) -- name: deepCopy
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_10
	local v7 = {}
	for v8, v9 in pairs(p6) do
		if type(v9) == "table" then
			if typeof(v8) == "string" and (v8:match("Table") or v_u_5[v8]) then
				v7[v8] = v_u_4:Value(v_u_10(v9))
			else
				v7[v8] = v_u_10(v9)
			end
		else
			v7[v8] = v_u_4:Value(v9)
		end
	end
	return v7
end
v2.InitUser.On(function(p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_10
	print(p11.Data, p11.State)
	v_u_3.Data = v_u_10(p11.Data)
	v_u_3.State = v_u_10(p11.State)
	v_u_3.Game = v_u_10(p11.Game)
	require("./Replicater")
	v_u_3.Loaded:set(true)
end)
return {}