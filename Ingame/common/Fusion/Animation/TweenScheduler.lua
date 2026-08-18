local v1 = game:GetService("RunService")
local v2 = script.Parent.Parent
require(v2.Types)
local v_u_3 = require(v2.Animation.lerpType)
local v_u_4 = require(v2.Animation.getTweenRatio)
local v_u_5 = require(v2.Dependencies.updateAll)
local v_u_6 = {}
local v_u_7 = {}
setmetatable(v_u_7, {
	["__mode"] = "k"
})
function v_u_6.add(p8) -- name: add
	-- upvalues: (copy) v_u_7
	v_u_7[p8] = true
end
function v_u_6.remove(p9) -- name: remove
	-- upvalues: (copy) v_u_7
	v_u_7[p9] = nil
end
v1:BindToRenderStep("__FusionTweenScheduler", Enum.RenderPriority.First.Value, function() -- name: updateAllTweens
	-- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_6, (copy) v_u_4, (copy) v_u_3
	local v10 = os.clock()
	for v11 in pairs(v_u_7) do
		local v12 = v10 - v11._currentTweenStartTime
		if v11._currentTweenDuration < v12 then
			if v11._currentTweenInfo.Reverses then
				v11._currentValue = v11._prevValue
			else
				v11._currentValue = v11._nextValue
			end
			v11._currentlyAnimating = false
			v_u_5(v11)
			v_u_6.remove(v11)
		else
			local v13 = v_u_4(v11._currentTweenInfo, v12)
			v11._currentValue = v_u_3(v11._prevValue, v11._nextValue, v13)
			v11._currentlyAnimating = true
			v_u_5(v11)
		end
	end
end)
return v_u_6