local v_u_1 = game:GetService("HttpService")
local v_u_2 = {
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	"a",
	"b",
	"c",
	"d",
	"e",
	"f"
}
local v_u_3 = Random.new()
local function v_u_6(p4) -- name: RandomHex
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	local v5 = ""
	for _ = 1, p4 do
		v5 = v5 .. v_u_2[v_u_3:NextInteger(1, 16)]
	end
	return v5
end
local function v_u_7()
	-- upvalues: (copy) v_u_6, (copy) v_u_2, (copy) v_u_3
	return string.format("%s4%s8%s%s", v_u_6(12), (("" .. v_u_2[v_u_3:NextInteger(1, 16)]) .. v_u_2[v_u_3:NextInteger(1, 16)]) .. v_u_2[v_u_3:NextInteger(1, 16)], (("" .. v_u_2[v_u_3:NextInteger(1, 16)]) .. v_u_2[v_u_3:NextInteger(1, 16)]) .. v_u_2[v_u_3:NextInteger(1, 16)], (v_u_6(12)))
end
local function v_u_20(p8, p9, p10) -- name: TrySend
	-- upvalues: (copy) v_u_1
	if p8.enabled then
		local v11, v12 = pcall(v_u_1.JSONEncode, v_u_1, p9)
		if v11 then
			local v13, v14 = pcall(v_u_1.PostAsync, v_u_1, p8.requestUrl, v12, Enum.HttpContentType.ApplicationJson, true, p10)
			if v13 then
				local v15, v16 = pcall(v_u_1.JSONDecode, v_u_1, v14)
				if v15 then
					return true, v16
				else
					return false, v16
				end
			else
				local v17 = tonumber(v14:match("^HTTP (%d+)"))
				if v17 then
					if v17 >= 400 and v17 < 500 then
						warn(("Raven: HTTP %d in TrySend, JSON packet:"):format(v17))
						warn(v12)
						warn("Headers:")
						for v18, v19 in pairs(p10) do
							warn(v18 .. " " .. v19)
						end
						warn("Response:")
						warn(v14)
						if v17 == 401 then
							warn("Please check the validity of your DSN.")
						end
					elseif v17 == 429 then
						warn("Raven: HTTP 429 Retry-After in TrySend, disabling SDK for this server.")
						p8.enabled = false
					end
				end
				return false, v14
			end
		else
			return false, v12
		end
	else
		return false, "SDK disabled."
	end
end
local function v_u_36(p21, p22, p23) -- name: SendEvent
	-- upvalues: (ref) v_u_7, (copy) v_u_20
	local v24 = type(p22) == "table"
	assert(v24)
	local v25 = os.date("!*t")
	local v26 = ("%04d-%02d-%02dT%02d:%02d:%02d"):format(v25.year, v25.month, v25.day, v25.hour, v25.min, v25.sec)
	p22.event_id = v_u_7()
	p22.timestamp = v26
	p22.logger = "server"
	p22.platform = "other"
	p22.sdk = {
		["name"] = "raven-rbxlua",
		["version"] = "1.0"
	}
	for v27, v28 in pairs(p21.config) do
		p22[v27] = v28
	end
	for v29, v30 in pairs(p23) do
		if v29 == "tags" then
			local v31 = p22[v29]
			if type(v31) ~= "table" then
				goto l10
			end
			for v32, v33 in pairs(v30) do
				p22[v29][v32] = v33
			end
		else
			::l10::
			p22[v29] = v30
		end
	end
	local v34, v35 = v_u_20(p21, p22, {
		["Authorization"] = p21.authHeader:format(v26)
	})
	return v34, v35
end
local function v_u_45(p37) -- name: StringTraceToTable
	local v38 = {}
	for v39 in p37:gmatch("[^\n\r]+") do
		if not (v39:match("^Stack Begin$") or v39:match("^Stack End$")) then
			local v40, v41, v42 = v39:match("^Script \'(.-)\', Line (%d+)%s?%-?%s?(.*)$")
			if not (v40 and (v41 and v42)) then
				return false, "invalid traceback"
			end
			v38[#v38 + 1] = {
				["filename"] = v40,
				["function"] = v42 or "nil",
				["lineno"] = v41
			}
		end
	end
	if #v38 == 0 then
		return false, "invalid traceback"
	end
	local v43 = {}
	for v44 = #v38, 1, -1 do
		v43[v44] = v38[v44]
	end
	return true, v43
end
local v_u_72 = {
	["EventLevel"] = {
		["Fatal"] = "fatal",
		["Error"] = "error",
		["Warning"] = "warning",
		["Info"] = "info",
		["Debug"] = "debug"
	},
	["ExceptionType"] = {
		["Server"] = "ServerError",
		["Client"] = "ClientError"
	},
	["Client"] = function(p46, p47, p48) -- name: Client
		local v49 = {
			["DSN"] = p47
		}
		local v50, v51, v52, v53, v54, v55 = p47:match("^([^:]+)://([^:]+):([^@]+)@([^/]+)(.*/)(.+)$")
		local v56
		if v50 then
			v56 = v50:lower():match("^https?$")
		else
			v56 = v50
		end
		assert(v56, "invalid DSN: protocol not valid")
		assert(v51, "invalid DSN: public key not valid")
		assert(v52, "invalid DSN: secret key not valid")
		assert(v53, "invalid DSN: host not valid")
		assert(v54, "invalid DSN: path not valid")
		assert(v55, "invalid DSN: project ID not valid")
		v49.requestUrl = ("%s://%s%sapi/%d/store/"):format(v50, v53, v54, v55)
		v49.authHeader = ("Sentry sentry_version=%d,sentry_timestamp=%s,sentry_key=%s,sentry_secret=%s,sentry_client=%s"):format("7", "%s", v51, v52, ("%s/%s"):format("raven-rbxlua", "1.0"))
		v49.config = p48 or {}
		v49.enabled = true
		return setmetatable(v49, {
			["__index"] = p46
		})
	end,
	["SendMessage"] = function(p57, p58, p59, p60) -- name: SendMessage
		-- upvalues: (copy) v_u_36
		return v_u_36(p57, {
			["level"] = p59 or p57.EventLevel.Info,
			["message"] = p58
		}, p60 or {})
	end,
	["SendException"] = function(p61, p62, p63, p64, p65) -- name: SendException
		-- upvalues: (copy) v_u_45, (copy) v_u_72, (copy) v_u_36
		local v66 = type(p62) == "string"
		assert(v66, "invalid exception type")
		local v67 = p65 or {}
		local v68 = {
			["type"] = p62,
			["value"] = p63
		}
		local v69 = nil
		if type(p64) == "string" then
			local v70, v71 = v_u_45(p64)
			if v70 then
				v68.stacktrace = {
					["frames"] = v71
				}
				v69 = v71[#v71].filename
			else
				warn(("Raven: Failed to convert string traceback to stacktrace: %s"):format(v71))
				warn(p64)
			end
		elseif type(p64) == "table" then
			v68.stacktrace = {
				["frames"] = p64
			}
			v69 = p64[#p64].filename
		end
		return v_u_36(p61, {
			["level"] = v_u_72.EventLevel.Error,
			["exception"] = { v68 },
			["culprit"] = v69
		}, v67)
	end
}
local function v_u_80(p73, p74, p75) -- name: ScrubData
	-- upvalues: (copy) v_u_45
	local v76 = p74:gsub(p73, "<Player>")
	local v77, v78
	if p75 == nil then
		v77 = true
		v78 = nil
	else
		v77, v78 = v_u_45(p75)
		if v77 then
			for _, v79 in pairs(v78) do
				v79.filename = v79.filename:gsub(p73, "<Player>")
			end
		end
	end
	if v77 and v76 ~= "" then
		return true, v76, v78
	else
		return false, "invalid exception"
	end
end
local v_u_81 = setmetatable({}, {
	["__mode"] = "k"
})
function v_u_72.ConnectRemoteEvent(p_u_82, p83) -- name: ConnectRemoteEvent
	-- upvalues: (copy) v_u_81, (copy) v_u_80, (copy) v_u_72
	local v84
	if typeof(p83) == "Instance" then
		v84 = p83.ClassName == "RemoteEvent"
	else
		v84 = false
	end
	assert(v84, "ConnectRemoteEvent did not receive RemoteEvent instance")
	p83.OnServerEvent:Connect(function(p85, p86, p87)
		-- upvalues: (ref) v_u_81, (ref) v_u_80, (copy) p_u_82, (ref) v_u_72
		local v88 = v_u_81[p85] or 5
		if v88 > 0 then
			if type(p86) == "string" and (type(p87) == "string" or p87 == nil) then
				local v89, v90, v91 = v_u_80(p85.Name, p86, p87)
				if v89 then
					v88 = v88 - 1
					p_u_82:SendException(v_u_72.ExceptionType.Client, v90, v91)
				else
					warn(("Raven: Player \'%s\' tried to send spoofed data, their ability to report errors has been disabled."):format(p85.Name))
					warn("errorMessage:")
					warn(p86)
					warn("traceback:")
					warn(p87)
					v88 = 0
				end
			else
				warn(("Raven: Player \'%s\' tried to send spoofed data, their ability to report errors has been disabled."):format(p85.Name))
				warn("errorMessage:")
				warn(p86)
				warn("traceback:")
				warn(p87)
				v88 = 0
			end
		end
		v_u_81[p85] = v88
	end)
end
return v_u_72