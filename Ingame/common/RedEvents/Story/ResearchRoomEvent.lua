local v1 = game:GetService("ReplicatedStorage")
local function v_u_6(p2) -- name: sanitizePath
	if p2 == nil then
		return nil
	elseif typeof(p2) == "table" then
		local v3 = {}
		for _, v5 in ipairs(p2) do
			local v5
			if typeof(v5) == "string" then
				if #v5 > 120 then
					v5 = string.sub(v5, 1, 120)
				end
			else
				v5 = nil
			end
			if not v5 or v5 == "" then
				return nil
			end
			table.insert(v3, v5)
		end
		if #v3 == 0 then
			return nil
		else
			return v3
		end
	else
		return nil
	end
end
local function v_u_18(p7) -- name: sanitizeBodyParts
	-- upvalues: (copy) v_u_6
	if typeof(p7) ~= "table" then
		return {}
	end
	local v8 = {}
	for v9, v10 in ipairs(p7) do
		if v9 > 12 then
			break
		end
		if typeof(v10) == "table" then
			local v11 = v10.id or v10.bodyPartId
			if typeof(v11) == "string" then
				if #v11 > 120 then
					v11 = string.sub(v11, 1, 120)
				end
			else
				v11 = nil
			end
			local v12 = v10.name or v10.displayName
			if typeof(v12) == "string" then
				if #v12 > 120 then
					v12 = string.sub(v12, 1, 120)
				end
			else
				v12 = nil
			end
			local v13 = {}
			local v14 = v10.partPaths
			if typeof(v14) == "table" then
				for v15, v16 in ipairs(v10.partPaths) do
					if v15 > 12 then
						break
					end
					local v17 = v_u_6(v16)
					if v17 then
						table.insert(v13, v17)
					end
				end
			end
			if v11 and (v12 and #v13 > 0) then
				table.insert(v8, {
					["id"] = v11,
					["name"] = v12,
					["partPaths"] = v13
				})
			end
		end
	end
	return v8
end
local function v_u_32(p19) -- name: sanitizeCapsules
	-- upvalues: (copy) v_u_6, (copy) v_u_18
	if typeof(p19) ~= "table" then
		return {}
	end
	local v20 = {}
	for v21, v22 in ipairs(p19) do
		if v21 > 50 then
			break
		end
		if typeof(v22) == "table" then
			local v23 = v22.id
			local v24
			if typeof(v23) == "number" then
				v24 = math.floor(v23)
			else
				v24 = typeof(v23) == "string" and tonumber(v23)
				if v24 then
					v24 = math.floor(v24)
				end
			end
			if typeof(v24) == "number" and v24 >= 1 then
				local v25 = v22.label
				local v26 = string.format("Capsule #%02d", v24)
				if typeof(v25) == "string" then
					if #v25 > 120 then
						v25 = string.sub(v25, 1, 120)
					end
				else
					v25 = v26
				end
				local v27 = v22.shortLabel
				if typeof(v27) == "string" then
					if #v27 > 120 then
						v27 = string.sub(v27, 1, 120)
					end
				else
					v27 = nil
				end
				local v28 = v_u_6(v22.modelPath or v22.path)
				local v29 = v_u_18(v22.bodyParts or v22.zones)
				local v30 = v22.zombieModelRef
				local v31
				if typeof(v30) == "Instance" then
					v31 = v22.zombieModelRef
				else
					v31 = nil
				end
				table.insert(v20, {
					["id"] = v24,
					["label"] = v25,
					["shortLabel"] = v27,
					["modelPath"] = v28,
					["bodyParts"] = v29,
					["zombieModelRef"] = v31
				})
			end
		end
	end
	return v20
end
local function v_u_48(p33) -- name: sanitizeScanState
	if typeof(p33) ~= "table" then
		return nil
	end
	local v34 = p33.mode
	if typeof(v34) == "string" then
		if #v34 > 120 then
			v34 = string.sub(v34, 1, 120)
		end
	else
		v34 = "idle"
	end
	local v35 = p33.capsuleId
	local v36
	if typeof(v35) == "number" then
		local v37 = p33.capsuleId
		v36 = math.floor(v37)
	else
		v36 = nil
	end
	local v38 = p33.duration
	local v39
	if typeof(v38) == "number" then
		local v40 = p33.duration
		v39 = math.max(0, v40)
	else
		v39 = nil
	end
	local v41 = p33.remaining
	local v42
	if typeof(v41) == "number" then
		local v43 = p33.remaining
		v42 = math.max(0, v43)
	else
		v42 = nil
	end
	local v44 = p33.startedBy
	if typeof(v44) == "string" then
		if #v44 > 120 then
			v44 = string.sub(v44, 1, 120)
		end
	else
		v44 = nil
	end
	local v45 = p33.cooldown
	local v46
	if typeof(v45) == "number" then
		local v47 = p33.cooldown
		v46 = math.max(0, v47)
	else
		v46 = nil
	end
	return {
		["mode"] = v34,
		["capsuleId"] = v36,
		["duration"] = v39,
		["remaining"] = v42,
		["startedBy"] = v44,
		["cooldown"] = v46
	}
end
return require(v1.Packages.Red).SharedEvent("ResearchRoom", function(p49)
	-- upvalues: (copy) v_u_32, (copy) v_u_48
	if typeof(p49) ~= "table" then
		return nil
	end
	local v50 = p49.action
	if typeof(v50) == "string" then
		if #v50 > 120 then
			v50 = string.sub(v50, 1, 120)
		end
	else
		v50 = nil
	end
	if not v50 then
		return nil
	end
	if v50 == "OpenXRay" then
		local v51 = p49.sessionId
		if typeof(v51) == "string" then
			if #v51 > 120 then
				v51 = string.sub(v51, 1, 120)
			end
		else
			v51 = nil
		end
		local v52 = v_u_32(p49.capsules or {})
		local v53 = p49.focusId
		local v54
		if typeof(v53) == "number" then
			local v55 = p49.focusId
			v54 = math.floor(v55)
		else
			v54 = nil
		end
		return {
			["action"] = v50,
			["sessionId"] = v51,
			["capsules"] = v52,
			["focusId"] = v54
		}
	end
	if v50 == "CloseXRay" then
		return {
			["action"] = v50
		}
	end
	if v50 == "OpenScan" then
		local v56 = p49.sessionId
		if typeof(v56) == "string" then
			if #v56 > 120 then
				v56 = string.sub(v56, 1, 120)
			end
		else
			v56 = nil
		end
		return {
			["action"] = v50,
			["sessionId"] = v56,
			["capsules"] = v_u_32(p49.capsules or {}),
			["scanState"] = v_u_48(p49.scanState)
		}
	end
	if v50 == "ScanState" then
		local v57 = v_u_48(p49.scanState)
		return v57 and {
			["action"] = v50,
			["scanState"] = v57
		} or nil
	end
	if v50 ~= "ScanResult" then
		if v50 == "ConsoleInUse" then
			local v58 = p49.by
			if typeof(v58) == "string" then
				if #v58 > 120 then
					v58 = string.sub(v58, 1, 120)
				end
			else
				v58 = nil
			end
			return {
				["action"] = v50,
				["by"] = v58
			}
		end
		if v50 == "RequestScanStatus" then
			return {
				["action"] = v50
			}
		end
		if v50 ~= "StartScan" then
			return (v50 == "CloseScan" or v50 == "CloseXRayClient") and {
				["action"] = v50
			} or (v50 == "RequestXRayData" and {
				["action"] = v50
			} or nil)
		end
		local v59 = p49.capsuleId
		local v60
		if typeof(v59) == "number" then
			v60 = math.floor(v59)
		else
			v60 = typeof(v59) == "string" and tonumber(v59)
			if v60 then
				v60 = math.floor(v60)
			end
		end
		return typeof(v60) == "number" and v60 >= 1 and {
			["action"] = v50,
			["capsuleId"] = v60
		} or nil
	end
	local v61 = p49.result
	if typeof(v61) == "string" then
		if #v61 > 120 then
			v61 = string.sub(v61, 1, 120)
		end
	else
		v61 = nil
	end
	if v61 ~= "success" and v61 ~= "failure" then
		return nil
	end
	local v62 = p49.capsuleId
	local v63
	if typeof(v62) == "number" then
		local v64 = p49.capsuleId
		v63 = math.floor(v64)
	else
		v63 = nil
	end
	local v65 = p49.message
	if typeof(v65) == "string" then
		if #v65 > 120 then
			v65 = string.sub(v65, 1, 120)
		end
	else
		v65 = nil
	end
	local v66 = p49.cooldown
	local v67
	if typeof(v66) == "number" then
		local v68 = p49.cooldown
		v67 = math.max(0, v68)
	else
		v67 = nil
	end
	return {
		["action"] = v50,
		["result"] = v61,
		["capsuleId"] = v63,
		["message"] = v65,
		["cooldown"] = v67
	}
end)