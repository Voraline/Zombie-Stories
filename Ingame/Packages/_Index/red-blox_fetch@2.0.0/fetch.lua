local v_u_1 = game:GetService("HttpService")
local v_u_2 = require(script.Parent.Future)
local function v_u_4(p3) -- name: Json
	-- upvalues: (copy) v_u_1
	return pcall(v_u_1.JSONDecode, v_u_1, p3.Body)
end
return function(p_u_5, p6)
	-- upvalues: (copy) v_u_1, (copy) v_u_2, (copy) v_u_4
	local v7 = p6 or {}
	local v8 = v7.Body
	local v9
	if type(v8) == "table" then
		v9 = v_u_1:JSONEncode(v7.Body)
	else
		v9 = v7.Body
	end
	return v_u_2.Try(function(p10, p11)
		-- upvalues: (ref) v_u_1, (copy) p_u_5, (ref) v_u_4
		local v12 = v_u_1:RequestAsync({
			["Url"] = p_u_5,
			["Method"] = p10.Method or "GET",
			["Headers"] = p10.Headers or {},
			["Body"] = p11
		})
		return {
			["Body"] = v12.Body,
			["Headers"] = v12.Headers,
			["Status"] = v12.StatusCode,
			["StatusText"] = v12.StatusMessage,
			["Ok"] = v12.Success,
			["Url"] = p_u_5,
			["Json"] = v_u_4
		}
	end, v7, v9)
end