local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require("@game/ReplicatedStorage/common/zap")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
v1.InitGameState.On(function(p1) -- Line: 8 -- upvalues: GameState (val)
    local v1, v2, v3, v4, v5, v6
    GameState.Data = p1
    local Signals = GameState.Signals
    local v7 = nil
    local v8 = nil
    for i, j in Signals, v7, v8 do
        if typeof(j) ~= "table" then
            v3 = j
            v4 = nil
            v5 = nil
            for k, n in v3, v4, v5 do
                if typeof(n) == "table" and n.Fire then
                    v2 = GameState
                    v1 = v2.Data[i][k]
                    n:Fire(v1)
                end
            end
        elseif not j.Fire then
            v3 = j
            v4 = nil
            v5 = nil
            for m, i5 in v3, v4, v5 do
                if typeof(i5) == "table" and i5.Fire then
                    v2 = GameState
                    v1 = v2.Data[i][m]
                    i5:Fire(v1)
                end
            end
        else
            v6 = GameState
            v5 = v6.Data[i]
            j:Fire(v5)
        end
    end
end)
v1.SetGameStateKey.On(function(p1) -- Line: 25 -- upvalues: GameState (val)
    GameState.Data[p1.Key] = p1.Value
    if not GameState.Signals[p1.Key] then
        warn("GameStateController: SetGameStateKey - No signal for key:", p1.Key)
        return
    end
    local v1 = GameState.Signals[p1.Key]
    local Value = p1.Value
    v1:Fire(Value)
end)
v1.SetGameStateVariable.On(function(p1) -- Line: 34 -- upvalues: GameState (val)
    GameState.Data.Variables[p1.Key] = p1.Value
    if not GameState.Signals.Variables[p1.Key] then
        warn("GameStateController: SetGameStateVariable - No signal for variable key:", p1.Key)
        return
    end
    local v1 = GameState.Signals.Variables[p1.Key]
    local Value = p1.Value
    v1:Fire(Value)
end)
return {}