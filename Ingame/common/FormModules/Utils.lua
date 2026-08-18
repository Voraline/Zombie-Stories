local v_u_1 = game:GetService("DataStoreService")
local v2 = script.Parent
local v_u_3 = require(v2.Config)
local v_u_5 = {
	["\\n"] = "\n",
	["&nbsp;"] = "",
	["&amp;"] = "&",
	["&lt;"] = "<",
	["&gt;"] = ">",
	["&quot;"] = "\"",
	["&apos;"] = "\'",
	["&#(%d+);"] = function(p4)
		return string.char(p4)
	end
}
local v_u_6 = {}
local v_u_7 = nil
local v_u_8 = {}
return {
	["SanitizeEncodedHtml"] = function(p9, p10) -- name: sanitizeEncodedHtml
		-- upvalues: (copy) v_u_5
		for v11, v12 in pairs(v_u_5) do
			if p10 then
				p9 = string.gsub(p9, p10 .. v11, v12)
			end
			p9 = string.gsub(p9, v11, v12)
		end
		local v15 = string.gsub(p9, "\\u%x%x%x%x", function(p13)
			local v14 = string.sub(p13, 3)
			return utf8.char("0x" .. v14)
		end)
		local v16 = string.gsub(v15, "\160", "")
		return string.gsub(v16, "\194", " ")
	end,
	["IsValidFormId"] = function(p17) -- name: isValidFormId
		if p17 == nil or typeof(p17) ~= "string" then
			return false
		end
		local v18 = string.len(p17)
		return v18 ~= 0 and v18 <= 128
	end,
	["IsRenderedContentEqual"] = function(p19, p20) -- name: isRenderedContentEqual
		return (string.gsub(p19, "</?[biu]>", "") or "") == (p20 or "")
	end,
	["ThrottleRequest"] = function(p21, p22) -- name: throttleRequest
		-- upvalues: (copy) v_u_6, (copy) v_u_3
		local v23 = v_u_6[p21]
		local v24 = time()
		if v23 then
			local v25 = v23[p22]
			if v25 and v_u_3.RateLimits[p22] > v24 - v25 then
				return true
			end
		else
			v23 = {}
			v_u_6[p21] = v23
		end
		v23[p22] = v24
		return false
	end,
	["HasPlayerResponded"] = function(p26, p27) -- name: hasPlayerResponded
		-- upvalues: (copy) v_u_3, (copy) v_u_8, (ref) v_u_7, (copy) v_u_1
		local v28 = v_u_3.AllowMultipleResponses == false
		assert(v28)
		local v29 = p26.UserId
		local v30 = v_u_8[v29]
		if v30 == nil then
			local v31 = v_u_3.AllowMultipleResponses == false
			assert(v31)
			if v_u_7 == nil then
				v_u_7 = v_u_1:GetDataStore(v_u_3.DataStoreName)
			end
			v30 = v_u_7:GetAsync(v29)
			v_u_8[v29] = v30
		end
		local v32
		if v30 == nil then
			v32 = false
		else
			v32 = v30[p27] ~= nil
		end
		return v32
	end,
	["SetPlayerFormResponse"] = function(p33, p34, p35) -- name: setPlayerFormResponse
		-- upvalues: (copy) v_u_3, (copy) v_u_8
		local v36 = v_u_3.AllowMultipleResponses == false
		assert(v36)
		local v37 = p33.UserId
		local v38 = v_u_8[v37]
		if v38 == nil then
			v38 = {}
			v_u_8[v37] = v38
		end
		v38[p34] = p35
	end,
	["SavePlayerFormResponses"] = function(p39) -- name: savePlayerFormReponses
		-- upvalues: (copy) v_u_3, (copy) v_u_8, (ref) v_u_7, (copy) v_u_1
		local v40 = v_u_3.AllowMultipleResponses == false
		assert(v40)
		local v41 = p39.UserId
		local v42 = v_u_8[v41]
		if v42 ~= nil then
			local v43 = v_u_3.AllowMultipleResponses == false
			assert(v43)
			if v_u_7 == nil then
				v_u_7 = v_u_1:GetDataStore(v_u_3.DataStoreName)
			end
			v_u_7:SetAsync(v41, v42, { v41 })
		end
	end
}