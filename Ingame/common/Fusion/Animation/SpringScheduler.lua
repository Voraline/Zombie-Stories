local v1 = game:GetService("RunService")
local v2 = script.Parent.Parent
require(v2.Types)
local v_u_3 = require(v2.Animation.packType)
local v_u_4 = require(v2.Animation.springCoefficients)
local v_u_5 = require(v2.Dependencies.updateAll)
local v6 = {}
local v_u_7 = {}
local v_u_8 = os.clock()
function v6.add(p9) -- name: add
	-- upvalues: (ref) v_u_8, (copy) v_u_7
	p9._lastSchedule = v_u_8
	p9._startDisplacements = {}
	p9._startVelocities = {}
	for v10, v11 in ipairs(p9._springGoals) do
		p9._startDisplacements[v10] = p9._springPositions[v10] - v11
		p9._startVelocities[v10] = p9._springVelocities[v10]
	end
	v_u_7[p9] = true
end
function v6.remove(p12) -- name: remove
	-- upvalues: (copy) v_u_7
	v_u_7[p12] = nil
end
local function v32() -- name: updateAllSprings
	-- upvalues: (ref) v_u_8, (copy) v_u_7, (copy) v_u_4, (copy) v_u_3, (copy) v_u_5
	local v13 = {}
	v_u_8 = os.clock()
	for v14 in pairs(v_u_7) do
		local v15, v16, v17, v18 = v_u_4(v_u_8 - v14._lastSchedule, v14._currentDamping, v14._currentSpeed)
		local v19 = v14._springPositions
		local v20 = v14._springVelocities
		local v21 = v14._startDisplacements
		local v22 = v14._startVelocities
		local v23 = false
		for v24, v25 in ipairs(v14._springGoals) do
			local v26 = v21[v24]
			local v27 = v22[v24]
			local v28 = v26 * v15 + v27 * v16
			local v29 = v26 * v17 + v27 * v18
			v23 = (math.abs(v28) > 0.0001 or math.abs(v29) > 0.0001) and true or v23
			v19[v24] = v28 + v25
			v20[v24] = v29
		end
		if not v23 then
			v13[v14] = true
		end
	end
	for v30 in pairs(v_u_7) do
		v30._currentValue = v_u_3(v30._springPositions, v30._currentType)
		v_u_5(v30)
	end
	for v31 in pairs(v13) do
		v_u_7[v31] = nil
	end
end
v1:BindToRenderStep("__FusionSpringScheduler", Enum.RenderPriority.First.Value, v32)
return v6