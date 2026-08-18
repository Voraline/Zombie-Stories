local v1 = script.Parent.Parent
require(v1.PubTypes)
require(v1.Types)
local v_u_2 = require(v1.Dependencies.initDependency)
local v3 = {}
local v_u_4 = {
	["__index"] = v3
}
local v_u_5 = {}
function v3.update(p6) -- name: update
	for _, v7 in pairs(p6._changeListeners) do
		task.spawn(v7)
	end
	return false
end
function v3.onChange(p_u_8, p9) -- name: onChange
	-- upvalues: (copy) v_u_5
	local v_u_10 = {}
	p_u_8._numChangeListeners = p_u_8._numChangeListeners + 1
	p_u_8._changeListeners[v_u_10] = p9
	v_u_5[p_u_8] = true
	local v_u_11 = false
	return function()
		-- upvalues: (ref) v_u_11, (copy) p_u_8, (copy) v_u_10, (ref) v_u_5
		if not v_u_11 then
			v_u_11 = true
			p_u_8._changeListeners[v_u_10] = nil
			local v12 = p_u_8
			v12._numChangeListeners = v12._numChangeListeners - 1
			if p_u_8._numChangeListeners == 0 then
				v_u_5[p_u_8] = nil
			end
		end
	end
end
return function(p13) -- name: Observer
	-- upvalues: (copy) v_u_4, (copy) v_u_2
	local v14 = {
		["type"] = "State",
		["kind"] = "Observer",
		["dependencySet"] = nil,
		["dependentSet"] = nil,
		["_changeListeners"] = nil,
		["_numChangeListeners"] = 0,
		["dependencySet"] = {
			[p13] = true
		},
		["dependentSet"] = {},
		["_changeListeners"] = {}
	}
	local v15 = v_u_4
	local v16 = setmetatable(v14, v15)
	v_u_2(v16)
	p13.dependentSet[v16] = true
	return v16
end