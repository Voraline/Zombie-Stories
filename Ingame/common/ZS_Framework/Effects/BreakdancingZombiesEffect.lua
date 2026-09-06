local u21, u22
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
u21, u22 = require(ReplicatedStorage.Packages.Bin)()
local function toggleBreakdancingZombies() -- Line: 11 -- upvalues: GameState (val), u22 (val), u21 (val), RunService (val)
    u22()
    if GameState.Data.Variables.BreakdancingZombiesEnabled then
        u21(RunService.Heartbeat:Connect(function(p1) -- Line: 30 -- upvalues: GameState (upval)
            local RotationAxis = GameState.LocalState.RotationAxis
            RotationAxis.X = RotationAxis.X + p1 * 60
            local RotationAxis_2 = GameState.LocalState.RotationAxis
            RotationAxis_2.Y = RotationAxis_2.Y + p1 * 200
            local RotationAxis_3 = GameState.LocalState.RotationAxis
            RotationAxis_3.Z = RotationAxis_3.Z + p1 * 30
            if 360 < GameState.LocalState.RotationAxis.X then
                local RotationAxis_4 = GameState.LocalState.RotationAxis
                RotationAxis_4.X = RotationAxis_4.X - 360
            end
            if 360 < GameState.LocalState.RotationAxis.Y then
                local RotationAxis_5 = GameState.LocalState.RotationAxis
                RotationAxis_5.Y = RotationAxis_5.Y - 360
            end
            if 360 < GameState.LocalState.RotationAxis.Z then
                local RotationAxis_6 = GameState.LocalState.RotationAxis
                RotationAxis_6.Z = RotationAxis_6.Z - 360
            end
            local v1 = math.rad(GameState.LocalState.RotationAxis.X)
            local v2 = math.rad(GameState.LocalState.RotationAxis.Y)
            GameState.LocalState.NPCRotation = CFrame.Angles(v1, v2, (math.rad(GameState.LocalState.RotationAxis.Z)))
        end))
        return
    end
    GameState.LocalState.NPCRotation = CFrame.Angles(0, 0, 0)
    GameState.LocalState.RotationAxis = {X = 0, Y = 0, Z = 0}
end
toggleBreakdancingZombies()
GameState.Signals.Variables.BreakdancingZombiesEnabled:Connect(toggleBreakdancingZombies)
return {}