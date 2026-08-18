local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local v_u_3 = require(v1.Logging.parseError)
local v4 = {
	["type"] = "Contextual"
}
local v_u_5 = table.freeze({
	["__index"] = v4
})
local v_u_6 = table.freeze({
	["__mode"] = "k"
})
function v4.now(p7) -- name: now
	local v8 = coroutine.running()
	local v9 = p7._valuesNow[v8]
	if typeof(v9) == "table" then
		return v9.value
	else
		return p7._defaultValue
	end
end
function v4.is(p_u_10, p_u_11) -- name: is
	-- upvalues: (copy) v_u_3, (copy) v_u_2
	return {
		["during"] = function(_, p12, ...) -- name: during
			-- upvalues: (copy) p_u_10, (copy) p_u_11, (ref) v_u_3, (ref) v_u_2
			local v13 = coroutine.running()
			local v14 = p_u_10._valuesNow[v13]
			local v15 = {
				["value"] = p_u_11
			}
			p_u_10._valuesNow[v13] = v15
			local v16, v17 = xpcall(p12, v_u_3, ...)
			p_u_10._valuesNow[v13] = v14
			if not v16 then
				v_u_2.logError("callbackError", v17)
			end
			return v17
		end
	}
end
table.freeze(v4)
return function(p18) -- name: Contextual
	-- upvalues: (copy) v_u_6, (copy) v_u_5
	local v19 = {}
	local v20 = v_u_6
	v19._valuesNow = setmetatable({}, v20)
	v19._defaultValue = p18
	local v21 = v_u_5
	return setmetatable(v19, v21)
end