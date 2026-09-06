local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require("@game/ReplicatedStorage/common/zap")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local v2 = {}
v1.InitGameState.On(function(p1) -- Line: 8 -- upvalues: GameState (val)
    local v1, v2, v3
    GameState.Data = p1
    local Signals = GameState.Signals
    local v4 = nil
    local v5 = nil
    for i, j in Signals, v4, v5 do
        if typeof(j) ~= "table" then
            v1 = j
            v2 = nil
            v3 = nil
            for k, n in v1, v2, v3 do
                if typeof(n) == "table" and n.Fire then
                    n:Fire(GameState.Data[i][k])
                end
            end
        elseif j.Fire then
            j:Fire(GameState.Data[i])
        end
    end
end)
v1.SetGameStateKey.On(function(p1) -- Line: 25 -- upvalues: GameState (val)
    GameState.Data[p1.Key] = p1.Value
    if GameState.Signals[p1.Key] then
        GameState.Signals[p1.Key]:Fire(p1.Value)
        return
    end
    warn("GameStateController: SetGameStateKey - No signal for key:", p1.Key)
end)
v1.SetGameStateVariable.On(function(p1) -- Line: 34 -- upvalues: GameState (val)
    GameState.Data.Variables[p1.Key] = p1.Value
    if GameState.Signals.Variables[p1.Key] then
        GameState.Signals.Variables[p1.Key]:Fire(p1.Value)
        return
    end
    warn("GameStateController: SetGameStateVariable - No signal for variable key:", p1.Key)
end)
return v2