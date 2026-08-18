local v1 = {
	["libraries"] = {}
}
local v2 = {
	["tension"] = "number",
	["friction"] = "number"
}
local v3 = v1.libraries
local v4 = {
	["name"] = "ripple",
	["exports"] = nil
}
local v5 = {
	["createMotion"] = "function",
	["immediate"] = "function",
	["linear"] = "function",
	["spring"] = "function",
	["tween"] = "function",
	["config"] = nil
}
local v6 = {
	["spring"] = {
		["default"] = v2,
		["gentle"] = v2,
		["wobbly"] = v2,
		["stiff"] = v2,
		["slow"] = v2,
		["molasses"] = v2
	},
	["linear"] = {
		["default"] = {
			["speed"] = "number"
		}
	},
	["tween"] = {
		["default"] = {
			["time"] = "number",
			["style"] = "EnumItem",
			["direction"] = "EnumItem",
			["repeatCount"] = "number",
			["reverses"] = "boolean",
			["delayTime"] = "number"
		}
	}
}
v5.config = v6
v4.exports = v5
v3.ripple = v4
local function v_u_11(p7, p8) -- name: compareTypes
	-- upvalues: (copy) v_u_11
	if typeof(p7) == "string" then
		return p7 == typeof(p8)
	end
	if typeof(p8) ~= "table" then
		return false
	end
	for v9, v10 in p7 do
		if not v_u_11(v10, p8[v9]) then
			return false
		end
	end
	return true
end
function v1.find(p12, p13) -- name: find
	-- upvalues: (copy) v_u_11
	local v14 = script.Parent.Parent
	local v15 = p12.name:lower()
	while v14 do
		local v16 = v14:FindFirstChild(p12) or v14:FindFirstChild(v15)
		if v16 and v16:IsA("ModuleScript") then
			local v17 = require(v16)
			if v_u_11(p12, v17) then
				return v17
			end
		end
		v14 = v14.Parent
	end
	error((("[pretty-fusion-utils] Cannot find library %* for %*"):format(p12.name, p13)))
end
return v1