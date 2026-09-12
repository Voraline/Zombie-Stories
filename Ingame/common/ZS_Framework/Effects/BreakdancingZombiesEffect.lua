local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local u21, u22 = require(ReplicatedStorage.Packages.Bin)()

local function toggleBreakdancingZombies() -- Line: 11
    -- upvalues: GameState (val), u22 (val), u21 (val), RunService (val)
    local v1 = GameState
    local BreakdancingZombiesEnabled = v1.Data.Variables.BreakdancingZombiesEnabled
    u22()
    if not BreakdancingZombiesEnabled then
        GameState.LocalState.NPCRotation = CFrame.Angles(0, 0, 0)
        GameState.LocalState.RotationAxis = {X = 0, Y = 0, Z = 0}
        return
    end
    local v2 = u21
    local v3 = RunService
    v2(v3.Heartbeat:Connect(function(p1) -- Line: 30 -- upvalues: GameState (upval)
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
        local v1 = GameState
        local LocalState = v1.LocalState
        local Angles = CFrame.Angles
        local v2 = GameState
        local X = v2.LocalState.RotationAxis.X
        local v3 = math.rad(X)
        local v4 = GameState
        local Y = v4.LocalState.RotationAxis.Y
        v2 = math.rad(Y)
        local v5 = GameState
        local Z = v5.LocalState.RotationAxis.Z
        LocalState.NPCRotation = Angles(v3, v2, (math.rad(Z)))
    end))
end

toggleBreakdancingZombies()
GameState.Signals.Variables.BreakdancingZombiesEnabled:Connect(toggleBreakdancingZombies)
return {}