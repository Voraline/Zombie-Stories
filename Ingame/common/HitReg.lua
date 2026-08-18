local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.common.zap)
local v3 = {}
local v_u_4 = {}
local v_u_5 = {}
function v3.Register(_, p6) -- name: Register
	-- upvalues: (copy) v_u_4
	local v7 = v_u_4
	table.insert(v7, p6)
end
function v3.ProcessHit(_, p8, p9, p10) -- name: ProcessHit
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v11 = p8.Instance
	if not v11 then
		return nil
	end
	for _, v12 in v_u_4 do
		if v12.validate(v11) then
			local v13 = v12.onHitClient(p8, p9)
			local v14 = not p10 and v12.buildNetworkData(p8, p9)
			if v14 then
				if not v_u_5[v12.moduleId] then
					v_u_5[v12.moduleId] = {}
				end
				local v15 = v_u_5[v12.moduleId]
				table.insert(v15, v14)
			end
			return v13
		end
	end
	return nil
end
function v3.ProcessNetworkQueue(_) -- name: ProcessNetworkQueue
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	for v16, v17 in v_u_5 do
		if #v17 > 0 then
			v_u_2.HitRegClaim.Fire({
				["moduleId"] = v16,
				["hits"] = v17
			})
		end
	end
	table.clear(v_u_5)
end
return v3