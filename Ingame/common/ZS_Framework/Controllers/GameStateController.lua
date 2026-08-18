local v1 = game:GetService("ReplicatedStorage")
local v2 = require("@game/ReplicatedStorage/common/zap")
local v_u_3 = require(v1.common.ZS_Shared.Data.GameState)
v2.InitGameState.On(function(p4)
	-- upvalues: (copy) v_u_3
	v_u_3.Data = p4
	for v5, v6 in v_u_3.Signals do
		if typeof(v6) == "table" and v6.Fire then
			v6:Fire(v_u_3.Data[v5])
		else
			for v7, v8 in v6 do
				if typeof(v8) == "table" and v8.Fire then
					v8:Fire(v_u_3.Data[v5][v7])
				end
			end
		end
	end
end)
v2.SetGameStateKey.On(function(p9)
	-- upvalues: (copy) v_u_3
	v_u_3.Data[p9.Key] = p9.Value
	if v_u_3.Signals[p9.Key] then
		v_u_3.Signals[p9.Key]:Fire(p9.Value)
	else
		warn("GameStateController: SetGameStateKey - No signal for key:", p9.Key)
	end
end)
v2.SetGameStateVariable.On(function(p10)
	-- upvalues: (copy) v_u_3
	v_u_3.Data.Variables[p10.Key] = p10.Value
	if v_u_3.Signals.Variables[p10.Key] then
		v_u_3.Signals.Variables[p10.Key]:Fire(p10.Value)
	else
		warn("GameStateController: SetGameStateVariable - No signal for variable key:", p10.Key)
	end
end)
return {}