local v_u_1 = game:GetService("RunService")
local v_u_2 = game:GetService("HttpService")
local v3 = script.Parent
local v_u_4 = require(v3.External)
local v8 = {
	["policies"] = {
		["allowWebLinks"] = v_u_1:IsStudio()
	},
	["doTaskImmediate"] = function(p5) -- name: doTaskImmediate
		task.spawn(p5)
	end,
	["doTaskDeferred"] = function(p6) -- name: doTaskDeferred
		task.defer(p6)
	end,
	["logErrorNonFatal"] = function(p7) -- name: logErrorNonFatal
		task.spawn(error, p7, 0)
	end,
	["logWarn"] = warn
}
local function v_u_9() -- name: performUpdateStep
	-- upvalues: (copy) v_u_4
	v_u_4.performUpdateStep(os.clock())
end
local v_u_10 = nil
function v8.startScheduler() -- name: startScheduler
	-- upvalues: (ref) v_u_10, (copy) v_u_1, (copy) v_u_2, (copy) v_u_9
	if v_u_10 == nil then
		if v_u_1:IsClient() then
			local v_u_11 = "FusionUpdateStep_" .. v_u_2:GenerateGUID()
			v_u_1:BindToRenderStep(v_u_11, Enum.RenderPriority.First.Value, v_u_9)
			v_u_10 = function()
				-- upvalues: (ref) v_u_1, (copy) v_u_11
				v_u_1:UnbindFromRenderStep(v_u_11)
			end
		else
			local v_u_12 = v_u_1.Heartbeat:Connect(v_u_9)
			v_u_10 = function()
				-- upvalues: (copy) v_u_12
				v_u_12:Disconnect()
			end
		end
	else
		return
	end
end
function v8.stopScheduler() -- name: stopScheduler
	-- upvalues: (ref) v_u_10
	if v_u_10 ~= nil then
		v_u_10()
		v_u_10 = nil
	end
end
return v8