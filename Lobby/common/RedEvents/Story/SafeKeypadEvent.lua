local v1 = game:GetService("ReplicatedStorage")
v1.common:WaitForChild("RedEvents")
local v2 = require(v1.Packages.Red)
local function v_u_3(...) -- name: log
	warn("[SafeKeypadEvent]", ...)
end
v_u_3("Module loaded", game:GetService("RunService"):IsServer() and "Server" or "Client")
return v2.SharedEvent("SafeKeypad", function(p4)
	-- upvalues: (copy) v_u_3
	if typeof(p4) == "table" then
		local v5 = p4.action
		if typeof(v5) == "string" then
			if v5 == "Enable" then
				local v6 = p4.hints
				if typeof(v6) ~= "table" then
					v_u_3("Enable missing hints")
					return nil
				end
				local v7 = {}
				for _, v8 in ipairs(v6) do
					if typeof(v8) ~= "table" then
						v_u_3("Enable invalid hint entry", v8)
						return nil
					end
					local v9 = v8.colorName
					local v10 = v8.digit
					local v11 = v8.color
					if typeof(v9) ~= "string" or (typeof(v10) ~= "number" or typeof(v11) ~= "Color3") then
						return nil
					end
					table.insert(v7, {
						["colorName"] = v9,
						["digit"] = v10,
						["color"] = v11
					})
				end
				local v12 = p4.keypadPath
				local v13
				if v12 == nil then
					v13 = nil
				else
					if typeof(v12) ~= "table" then
						v_u_3("Enable invalid keypadPath")
						return nil
					end
					v13 = {}
					for _, v14 in ipairs(v12) do
						if typeof(v14) ~= "string" then
							v_u_3("Enable keypadPath segment invalid", v14)
							return nil
						end
						table.insert(v13, v14)
					end
				end
				local v15 = p4.statusText
				local v16 = typeof(v15) ~= "string" and "Enter Code" or v15
				local v17 = p4.statusColor
				if typeof(v17) ~= "Color3" then
					v17 = Color3.new(1, 1, 1)
				end
				local v18 = p4.displayText
				if v18 ~= nil and typeof(v18) ~= "string" then
					v18 = nil
				end
				local v19 = p4.locked == true
				local v20 = p4.showHints
				if v20 ~= nil then
					v20 = v20 == true
				end
				local v21 = p4.logoAssetId
				if v21 ~= nil and typeof(v21) ~= "string" then
					v21 = nil
				end
				local v22 = p4.codeLength
				if v22 ~= nil then
					if typeof(v22) == "number" then
						local v23 = math.floor(v22)
						v22 = math.clamp(v23, 1, 32)
					else
						v22 = nil
					end
				end
				return {
					["action"] = v5,
					["hints"] = v7,
					["statusText"] = v16,
					["statusColor"] = v17,
					["displayText"] = v18,
					["locked"] = v19,
					["keypadPath"] = v13,
					["showHints"] = v20,
					["logoAssetId"] = v21,
					["codeLength"] = v22
				}
			elseif v5 == "Status" then
				local v24 = p4.statusText
				if typeof(v24) ~= "string" then
					v_u_3("Status missing text")
					return nil
				end
				local v25 = p4.statusColor
				if typeof(v25) ~= "Color3" then
					v25 = Color3.new(1, 1, 1)
				end
				local v26 = p4.displayText
				if v26 ~= nil and typeof(v26) ~= "string" then
					v26 = nil
				end
				local v27 = p4.lockInput == true
				local v28 = p4.resetAfter
				if v28 ~= nil and typeof(v28) ~= "number" then
					v28 = nil
				end
				return {
					["action"] = v5,
					["statusText"] = v24,
					["statusColor"] = v25,
					["displayText"] = v26,
					["lockInput"] = v27,
					["resetAfter"] = v28
				}
			elseif v5 == "Reset" then
				local v29 = p4.displayText
				if v29 ~= nil and typeof(v29) ~= "string" then
					v_u_3("Reset invalid display text")
					v29 = nil
				end
				local v30 = p4.statusText
				if v30 ~= nil and typeof(v30) ~= "string" then
					v30 = nil
				end
				local v31 = p4.statusColor
				if v31 ~= nil and typeof(v31) ~= "Color3" then
					v31 = nil
				end
				return {
					["action"] = v5,
					["displayText"] = v29,
					["statusText"] = v30,
					["statusColor"] = v31
				}
			elseif v5 == "Disable" then
				v_u_3("Disable action accepted")
				return {
					["action"] = v5
				}
			elseif v5 == "RequestState" then
				return {
					["action"] = v5
				}
			elseif v5 == "Submit" then
				local v32 = p4.code
				if typeof(v32) == "string" then
					v_u_3("Submit packet accepted")
					return {
						["action"] = v5,
						["code"] = v32
					}
				else
					v_u_3("Submit invalid code", p4.code)
					return nil
				end
			else
				v_u_3("Unknown action", v5)
				return nil
			end
		else
			v_u_3("Rejected missing action", p4)
			return nil
		end
	else
		v_u_3("Rejected non-table packet", p4)
		return nil
	end
end)