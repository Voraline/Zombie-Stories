local v1 = script.Parent.Parent
require(v1.Types)
local v_u_2 = require(v1.External)
local function v_u_10(p3, p4) -- name: evaluate
	-- upvalues: (copy) v_u_2, (copy) v_u_10
	if p3.validity == "busy" then
		return v_u_2.logError("infiniteLoop")
	end
	local v5 = p3.lastChange == nil
	if not v5 and (p3.validity ~= "invalid" and not p4) then
		return false
	end
	local v6 = v5 or p4
	if not v6 then
		for v7 in p3.dependencySet do
			v_u_10(v7, false)
			if v7.lastChange > p3.lastChange then
				v6 = true
				break
			end
		end
	end
	local v8
	if v6 then
		for v9 in p3.dependencySet do
			v9.dependentSet[p3] = nil
			p3.dependencySet[v9] = nil
		end
		p3.validity = "busy"
		v8 = p3:_evaluate() or v5
	else
		v8 = false
	end
	if v8 then
		p3.lastChange = os.clock()
	end
	p3.validity = "valid"
	return v8
end
return v_u_10